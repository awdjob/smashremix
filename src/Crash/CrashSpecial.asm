// CrashSpecial.asm

// This file contains subroutines used by Crash Bandicoots's special moves.

scope CrashNSP {
    constant MIN_SPEED(0x4000)              // float32 2
    constant MAX_SPEED(0x429C)              // float32 78
    constant END_ACCELERATION(0x4090)       // float32 4.5
    constant ACCELERATION(0x4000)           // float32 2
    constant G_SPEED_MULTIPLIER(0x3F20)     // float32 0.625
    constant A_SPEED_MULTIPLIER(0x3F00)     // float32 0.5
    constant GRAVITY(0x4028)                // float32 2.625
    constant KIRBY_GRAVITY(0x4007)          // float32 2.1
    constant FALL_SPEED(0x4240)             // float32 48
    constant JUMP_SPEED(0x4290)             // float32 72
    constant KIRBY_JUMP_SPEED(0x4280)       // float32 64
    constant FLING_WIDTH(0x4396)            // float 300
    constant FLING_HEIGHT_MIDDLE(0x4396)    // float 300
    constant FLING_HEIGHT(0x4396)           // float 300

    // @ Description
    // Initial function for NSPG
    scope ground_initial_: {
        OS.routine_begin(0x30)
        sw      a0, 0x0018(sp)              // 0x0018(sp) = player object
        or      a2, r0, r0                  // a2(starting frame) = 0
        lui     a3, 0x3F80                  // a3(frame speed multiplier) = 1.0

        lw      t0, 0x0084(a0)              // get player struct
        lw      t1, 0x0008(t0)              // get character id
        addiu   at, r0, Character.id.CRASH
        beql    at, t1, _change_action      // branch if character = Crash
        lli     a1, Crash.Action.NSPG       // a1(action id) = Action.NSPG
        // if here, set kirby action
        lli     a1, Kirby.Action.CRASH_NSP_Ground // a1(action id) = Kirby Crash NSP G

        _change_action:
        jal     0x800E6F24                  // change action
        sw      r0, 0x0010(sp)              // argument 4 = 0
        jal     0x800E0830                  // unknown common subroutine
        lw      a0, 0x0018(sp)              // a0 = player object
        jal     create_spin_gfx_            // create spin gfx
        lw      a0, 0x0018(sp)              // a0 = player object
        lw      a0, 0x0018(sp)              // ~
        beq     v0, r0, _end                // branch if no gfx object was created
        lw      a0, 0x0084(a0)              // a0 = player struct

        // if a spin GFX object was created
        jal     setup_spin_gfx_             // set up spin gfx
        nop

        _end:
        li      at, shield_hit_routine_     // ~
        sw      at, 0x09F4(a0)              // store on shield hit routine
        lwc1    f2, 0x0048(a0)              // f2 = x velocity
        lui     at, 0x3FC0                  // ~
        mtc1    at, f4                      // f4 = 1.5
        mul.s   f2, f2, f4                  // f2 = x velocity * 1.5
        sw      r0, 0x017C(a0)              // temp variable 1 = 0
        sw      r0, 0x0180(a0)              // temp variable 2 = 0
        sw      r0, 0x0184(a0)              // temp variable 3 = 0
        swc1    f2, 0x0048(a0)              // f2 = x velocity * 1.5
        OS.routine_end(0x30)
    }

    // @ Description
    // Initial function for NSPA
    scope air_initial_: {
        OS.routine_begin(0x30)
        sw      a0, 0x0018(sp)              // 0x0018(sp) = player object
        or      a2, r0, r0                  // a2(starting frame) = 0
        lui     a3, 0x3F80                  // a3(frame speed multiplier) = 1.0

        lw      t0, 0x0084(a0)              // get player struct
        lw      t1, 0x0008(t0)              // get character id
        addiu   at, r0, Character.id.CRASH
        beql    at, t1, _change_action      // branch if character = Crash
        lli     a1, Crash.Action.NSPA       // a1(action id) = Action.NSPG
        // if here, set kirby action
        lli     a1, Kirby.Action.CRASH_NSP_Air // a1(action id) = Kirby Crash NSP G

        _change_action:
        jal     0x800E6F24                  // change action
        sw      r0, 0x0010(sp)              // argument 4 = 0
        jal     0x800E0830                  // unknown common subroutine
        lw      a0, 0x0018(sp)              // a0 = player object
        jal     create_spin_gfx_            // create spin gfx
        lw      a0, 0x0018(sp)              // a0 = player object
        lw      a0, 0x0018(sp)              // ~
        beq     v0, r0, _end                // branch if no gfx object was created
        lw      a0, 0x0084(a0)              // a0 = player struct

        // if a spin GFX object was created
        jal     setup_spin_gfx_             // set up spin gfx
        nop

        _end:
        li      at, shield_hit_routine_     // ~
        sw      at, 0x09F4(a0)              // store on shield hit routine
        lwc1    f2, 0x0048(a0)              // f2 = x velocity
        lui     at, 0x3FA0                  // ~
        mtc1    at, f4                      // f4 = 1.25
        mul.s   f2, f2, f4                  // f2 = x velocity * 1.25
        sw      r0, 0x017C(a0)              // temp variable 1 = 0
        sw      r0, 0x0180(a0)              // temp variable 2 = 0
        sw      r0, 0x0184(a0)              // temp variable 3 = 0
        swc1    f2, 0x0048(a0)              // f2 = x velocity * 1.25
         // reset fall speed
        lbu     v1, 0x018D(a0)              // v1 = fast fall flag
        ori     t6, r0, 0x0007              // t6 = bitmask (01111111)
        and     v1, v1, t6                  // ~
        sb      v1, 0x018D(a0)              // disable fast fall flag
        OS.routine_end(0x30)
    }

    // Additional shared setup subroutine for the Spin GFX.
    // a0 = player struct
    // v0 = gfx object
    scope setup_spin_gfx_: {
        // enable a bitflag in the player struct to indicate a GFX object is attached to the player
        lbu     at, 0x018F(a0)              // ~
        ori     at, at, 0x0010              // ~
        sb      at, 0x018F(a0)              // enable bitflag for attached GFX
        // update the render routine for the Spin GFX to work with Size.asm
        li      at, Size.link.adjust_usp_gfx_size_.render_routine_
        sw      at, 0x002C(v0)              // update render routine for Size adjustments
        // update the Primitive/Environment colour values for the Spin textures based on costume id
        lw      t0, 0x0008(a0)              // t0 = character id
        addiu   at, r0, Character.id.CRASH
        beq     t0, at, _continue
        lbu     at, 0x0010(a0)              // at = costume id
        // if here, kirby costume table
        li      t0, kirby_spin_gfx_table    // t0 = spin_gfx_table
        b       _kirby_continue
        nop
        _continue:
        li      t0, spin_gfx_table          // t0 = spin_gfx_table
        _kirby_continue:
        sll     at, at, 0x4                 // ~
        addu    t0, t0, at                  // t0 = spin_gfx_table, adjusted for costume id
        lw      t1, 0x0074(v0)              // t1 = gfx object part 0 (root) struct
        lw      t1, 0x0010(t1)              // t1 = part 1 (top) struct
        lw      t2, 0x0010(t1)              // t2 = part 2 (bottom) struct
        lw      t1, 0x0080(t1)              // t1 = part 1 special image struct
        lw      t2, 0x0080(t2)              // t2 = part 2 special image struct
        lw      at, 0x0000(t0)              // ~
        sw      at, 0x0058(t1)              // set primitive colour for part 1
        lw      at, 0x0004(t0)              // ~
        sw      at, 0x0060(t1)              // set environment colour for part 1
        lw      at, 0x0008(t0)              // ~
        sw      at, 0x0058(t2)              // set primitive colour for part 2
        lw      at, 0x000C(t0)              // ~
        jr      ra                          // return
        sw      at, 0x0060(t2)              // set environment colour for part 2
    }

    // @ Description
    // Runs when Crash NSP connects with a shield (also clangs, so we check specifically for shield collision).
    scope shield_hit_routine_: {
        OS.routine_begin(0x30)
        sw      a0, 0x0018(sp)              // 0x0018(sp) = player object
        lw      a0, 0x0084(a0)              // a0 = player struct

        // v0 = collision flags for all active hitboxes
        jal     Character.get_hitbox_collision_flags_
        sw      a0, 0x001C(sp)              // 0x001C(sp) = player struct

        andi    v0, v0, 0x0040              // v0 != 0 if shield collision has occured
        beq     v0, r0, _end                // skip if no shield collision is detected
        lw      v0, 0x001C(sp)              // v0 = player struct

        // if a shield collision is detected
        sw      r0, 0x0180(v0)              // temp variable 2 = 0
        lwc1    f2, 0x0048(v0)              // f2 = x velocity
        lui     at, 0x3E80                  // ~
        mtc1    at, f4                      // f4 = 0.25
        mul.s   f2, f2, f4                  // f2 = x velocity * 0.25
        swc1    f2, 0x0B18(v0)              // store updated x velocity for later
        lui     at, 0x3F00                  // ~
        mtc1    at, f4                      // f4 = 0.5
        lwc1    f2, 0x004C(v0)              // f2 = y velocity
        mul.s   f2, f2, f4                  // f2 = y velocity * 0.5
        swc1    f2, 0x0B1C(v0)              // store updated y velocity for later
        lwc1    f2, 0x0060(v0)              // f2 = ground x velocity
        mul.s   f2, f2, f4                  // f2 = ground x velocity * 0.5
        swc1    f2, 0x0B20(v0)              // store ground x velocity for later
        sw      r0, 0x0B24(v0)              // bool hitlag_over = FALSE
        sw      r0, 0x0048(v0)              // x velocity = 0
        sw      r0, 0x0060(v0)              // ground x velocity = 0
        lw      at, 0x014C(v0)              // at = kinetic state
        bnez    at, _aerial                 // branch if kinetic state != grounded
        sw      r0, 0x004C(v0)              // y velocity = 0

        _grounded:
        jal     blocked_ground_initial_     // begin NSPGBlocked
        lw      a0, 0x0018(sp)              // a0 = player object
        b       _end                        // branch to end
        nop

        _aerial:
        lbu     v1, 0x018D(v0)              // v1 = fast fall flag
        ori     t6, r0, 0x0007              // t6 = bitmask (01111111)
        and     v1, v1, t6                  // ~
        sb      v1, 0x018D(v0)              // disable fast fall flag
        jal     blocked_air_initial_        // begin NSPABlocked
        lw      a0, 0x0018(sp)              // a0 = player object

        _end:
        OS.routine_end(0x30)
    }

    // @ Description
    // Initial function for NSPGBlocked
    scope blocked_ground_initial_: {
        OS.routine_begin(0x30)
        sw      a0, 0x0018(sp)              // 0x0018(sp) = player object
        or      a2, r0, r0                  // a2(starting frame) = 0
        lui     a3, 0x3F80                  // a3(frame speed multiplier) = 1.0

        lw      t0, 0x0084(a0)              // get player struct
        lw      t1, 0x0008(t0)              // get character id
        addiu   at, r0, Character.id.CRASH
        beql    at, t1, _change_action      // branch if character = Crash
        lli     a1, Crash.Action.NSPGBlocked // a1(action id) = Action.NSPGBlocked
        // if here, set kirby action
        lli     a1, Kirby.Action.CRASH_NSP_Ground_Blocked // a1(action id) = Kirby Crash NSP G

        _change_action:
        jal     0x800E6F24                  // change action
        sw      r0, 0x0010(sp)              // argument 4 = 0
        jal     0x800E0830                  // unknown common subroutine
        lw      a0, 0x0018(sp)              // a0 = player object

        OS.routine_end(0x30)
    }

    // @ Description
    // Initial function for NSPABlocked
    scope blocked_air_initial_: {
        OS.routine_begin(0x30)
        sw      a0, 0x0018(sp)              // 0x0018(sp) = player object
        or      a2, r0, r0                  // a2(starting frame) = 0
        lui     a3, 0x3F80                  // a3(frame speed multiplier) = 1.0

        lw      t0, 0x0084(a0)              // get player struct
        lw      t1, 0x0008(t0)              // get character id
        addiu   at, r0, Character.id.CRASH
        beql    at, t1, _change_action      // branch if character = Crash
        lli     a1, Crash.Action.NSPABlocked // a1(action id) = Action.NSPABlocked
        // if here, set kirby action
        lli     a1, Kirby.Action.CRASH_NSP_Air_Blocked // a1(action id) = Kirby Crash NSP G

        _change_action:
        jal     0x800E6F24                  // change action
        sw      r0, 0x0010(sp)              // argument 4 = 0
        jal     0x800E0830                  // unknown common subroutine
        lw      a0, 0x0018(sp)              // a0 = player object

        OS.routine_end(0x30)
    }

    // @ Description
    // Based on item pick up detect routine 0x80145990
    scope spin_detect_item_: {
        addiu   sp, sp, -0x30
        sw      s0, 0x0004(sp)
        addiu   v1, r0, 0           // returns 0 if no item found

        lw      v0, 0x0084(a0)      // v0 = fighter struct
        lui     a3, 0x8004
        lw      a3, 0x6700(a3)      // load first item
        beqz    a3, _end            // branch if no items
        nop
        lw      a1, 0x0084(a3)      // v0 = item struct

        lw      t8, 0x0074(a0)      // t8 = player position struct
        lwc1    f4, 0x001C(t8)      // f4 = player.x
        lwc1    f6, 0x0020(t8)      // f6 = player.y
        lui     at, FLING_HEIGHT_MIDDLE
        mtc1    at, f2
        add.s   f6, f6, f2          // player.y += FLING_HEIGHT_MIDDLE

        _loop_start:
        lw      a1, 0x0084(a3)
        lh      t7, 0x02CE(a1)      // load item flags
        bgezl   t7, _increment_loop
        lw      a3, 0x0004(a3)      // a3 = next item

        // if here, possible valid item
        lbu     t4, 0x02CE(a1)      // check item pickup flag
        andi    t4, t4, 1           // ~
        beqzl   t4, _increment_loop // branch if item can't be picked up
        lw      a3, 0x0004(a3)      // a3 = next item
        addiu   t0, a1, 0x0040      // t0 = item position struct
        lwc1    f8, 0x0000(t0)      // f8 = item.x
        lwc1    f10, 0x0004(t0)     // f10 = item.y

        sub.s   f2, f4, f8          // f2 = player.x - item.x
        abs.s   f2, f2              // f2 = absolute x difference

        lui     at, FLING_WIDTH
        mtc1    at, f12             // at = x difference
        c.le.s  f2, f12             // = 1 if x difference less than fling width
        bc1fl   _increment_loop     // branch if x coordinate doesn't match
        lw      a3, 0x0004(a3)      // a3 = next item

        sub.s   f2, f6, f10         // f2 = player.y - item.y
        lui     at, FLING_HEIGHT
        abs.s   f2, f2              // f2 = absolute x difference
        mtc1    at, f12             // at = y difference
        c.le.s  f2, f12             // = 1 if x difference less than fling height
        bc1fl   _increment_loop     // branch if x coordinate doesn't match
        lw      a3, 0x0004(a3)      // a3 = next item

        // if here, return this item as valid
        b       _end
        addiu   v1, a3, 0           // return item

        _increment_loop:
        bnezl   a3, _loop_start
        lw      a1, 0x0084(a3)

        _end:
        lw      s0, 0x0004(sp)
        addiu   sp, sp, 0x30
        jr      ra
        or      v0, v1, r0      // return 0 or item obj

    }

    // @ Description
    // Main function for Crash NSPG
    scope ground_main_: {
        OS.routine_begin(0x30)
        sw      a0, 0x0018(sp)              // 0x0018(sp) = player object
        // checks the current animation frame to see if we've reached end of the animation
        mtc1    r0, f6                      // ~
        lwc1    f8, 0x0078(a0)              // ~
        c.le.s  f8, f6                      // ~
        nop
        bc1fl   _jump_check                 // skip if animation end has not been reached
        nop
        jal     0x800DEE54                  // transition to idle
        nop
        b       _item_check                 // branch to end
        nop

        _jump_check:
        lw      a0, 0x0084(a0)              // a0 = player struct
        lw      at, 0x0180(a0)              // at = temp variable 2
        bnez    at, _item_check             // skip if temp variable 2 is set
        nop
        jal     0x8013F474                  // check jump (returns 0 for no jump)
        nop
        beq     v0, r0, _item_check         // skip if !jump
        nop

        // if we're here then Crash has input a jump, so transition to NSPA with jump velocity
        jal     ground_to_air_jump_         // jump transition
        lw      a0, 0x0018(sp)              // a0 = player object
        b       _end_2
        nop

        _item_check:
        jal     spin_detect_item_           // function returns nearby items that can be picked up
        lw      a0, 0x0018(sp)              // argument 0 = player obj
        beqz    v0, _end_2
        nop
        // if nearby item detected, shoot it away

        lw      t3, 0x0018(sp)              // t3 = player obj
        lw      t4, 0x0074(t3)              // t4 = player position struct
        lwc1    f2, 0x001C(t4)              // f2 = player x coord
        lw      t1, 0x0074(v0)
        lwc1    f4, 0x001C(t1)              // f4 = item x coord

        c.le.s  f2, f4                      // if player.x < item.x, code = 1
        nop
        bc1tl   _fling_item_continue
        lui     at, 0x4396
        lui     at, 0xC396

        _fling_item_continue:
        lw      t0, 0x0084(v0)

        sw      at, 0x002C(t0)              // set item x speed to zero

        jal     item_fling_                 // flings the item away forever
        or      a0, v0, 0                   // argument 0 = item obj
        FGM.play(0x5BD)                     // play item throw sound

        // b       _item_check
        // nop

        _end_2:
        OS.routine_end(0x30)
    }

    // @ Description
    // Main function for Crash NSPA
    scope air_main_: {
        OS.routine_begin(0x30)
        sw      a0, 0x0018(sp)              // save a0
        // checks the current animation frame to see if we've reached end of the animation
        mtc1    r0, f6                      // ~
        lwc1    f8, 0x0078(a0)              // ~
        c.le.s  f8, f6                      // ~
        nop
        bc1fl   _item_check                 // skip if animation end has not been reached
        nop
        jal     0x800DEE54                  // transition to idle
        nop

        _item_check:
        jal     spin_detect_item_           // function returns nearby items that can be picked up
        lw      a0, 0x0018(sp)              // argument 0 = player obj
        beqz    v0, _end_2
        nop
        // if nearby item detected, shoot it away

        lw      t3, 0x0018(sp)              // t3 = player obj
        lw      t4, 0x0074(t3)              // t4 = player position struct
        lwc1    f2, 0x001C(t4)              // f2 = player x coord
        lw      t1, 0x0074(v0)
        lwc1    f4, 0x001C(t1)              // f4 = item x coord

        c.le.s  f2, f4                      // if player.x < item.x, code = 1
        nop
        bc1tl   _fling_item_continue
        lui     at, 0x4396
        lui     at, 0xC396

        _fling_item_continue:
        lw      t0, 0x0084(v0)

        sw      at, 0x002C(t0)              // set item x speed to zero

        jal     item_fling_                 // flings the item away forever
        or      a0, v0, 0                   // argument 0 = item obj
        FGM.play(0x5BD)                     // play item throw sound

        // b       _item_check
        // nop

        _end_2:
        OS.routine_end(0x30)
    }

    // @ Description
    // Main function for Crash NSPGBlocked/NSPABlocked
    scope blocked_main_: {
        OS.routine_begin(0x30)
        sw      a0, 0x0018(sp)              // save a0
        lw      a1, 0x0084(a0)              // a1 = player struct
        lw      at, 0x0180(a1)              // a1 = temp variable 2
        beqz    at, _check_ending           // skip if temp variable 2 is not set
        lli     at, OS.TRUE                 // ~

        // if temp variable 2 is set, the "hitlag" phase of the animation has ended so resume original velocity
        sw      at, 0x0B24(a1)              // bool hitlag_over = TRUE
        lw      at, 0x0B18(a1)              // load saved x velocity
        sw      at, 0x0048(a1)              // store saved x velocity
        lw      at, 0x0B1C(a1)              // load saved y velocity
        sw      at, 0x004C(a1)              // store saved y velocity
        lw      at, 0x0B20(a1)              // load saved ground x velocity
        sw      at, 0x0060(a1)              // store saved ground x velocity
        sw      r0, 0x0180(a1)              // reset temp variable 2

        // checks the current animation frame to see if we've reached end of the animation
        _check_ending:
        mtc1    r0, f6                      // ~
        lwc1    f8, 0x0078(a0)              // ~
        c.le.s  f8, f6                      // ~
        nop
        bc1fl   _end                        // skip if animation end has not been reached
        nop
        jal     0x800DEE54                  // transition to idle
        nop

        _end:
        OS.routine_end(0x30)
    }

    // @ Description
    // Handles movement for NSPG.
    scope ground_physics_: {
        OS.routine_begin(0x40)
        sw      a0, 0x0020(sp)              // ~
        sw      s0, 0x0024(sp)              // store a0, s0
        lw      s0, 0x0084(a0)              // s0 = player struct
        lui     at, ACCELERATION            // ~
        mtc1    at, f12                     // f12 = ACCELERATION

        _check_flag:
        lw      t6, 0x180(s0)               // t6 = temp variable 2
        mtc1    r0, f2                      // target x velocity = 0
        lui     at, END_ACCELERATION        // ~
        bnezl   t6, _apply_movement         // branch if temp variable 2 is set...
        mtc1    at, f12                     // ...and f12 = END_ACCELERATION

        _check_movement:
        lb      t6, 0x01C2(s0)              // t6 = stick_x
        bltzl   t6, pc() + 8                // if stick_x is negative...
        subu    t6, r0, t6                  // ...make stick_x positive
        slti    at, t6, 11                  // at = 1 if |stick_x| < 11, else at = 0
        beqz    at, _check_stick            // branch if |stick_x| >= 10
        nop

        _check_min_speed:
        // if we're here then stick_x is < 11, so consider the stick neutral
        lwc1    f4, 0x0048(s0)              // ~
        abs.s   f4, f4                      // f4 = absolute x velocity
        lui     at, MIN_SPEED               // ~
        mtc1    at, f6                      // f6 = MIN_SPEED
        c.le.s  f4, f6                      // ~
        lui     at, 0x3FA0                  // ~
        mtc1    at, f12                     // ACCELERATION = 1.25
        bc1fl   _apply_movement             // apply movement if current speed < MIN_SPEED...
        mtc1    r0, f2                      // ...and target x velocity = 0
        // set velocity to 0 if below minimum speed
        b       _end                        // end
        sw      r0, 0x0048(s0)              // x velocity = 0

        _check_stick:
        lui     at, G_SPEED_MULTIPLIER      // ~
        mtc1    at, f0                      // f0 = G_SPEED_MULTIPLIER
        lb      at, 0x01C2(s0)              // ~
        mtc1    at, f2                      // ~
        cvt.s.w f2, f2                      // f2 = stick_x
        mul.s   f2, f2, f0                  // f2 = target x velocity = stick_x * SPEED_MULTIPLIER

        _apply_movement:
        lwc1    f4, 0x0048(s0)              // f4 = x velocity
        sub.s   f6, f2, f4                  // f6 = X_DIFF
        abs.s   f8, f6                      // f8 = |X_DIFF|
        lui     at, 0x4000                  // ~
        mtc1    at, f10                     // f10 = 2
        c.le.s  f10, f8                     // ~
        mfc1    t6, f6                      // t6 = X_DIFF
        bc1fl   _set_velocity               // branch if |X_DIFF| < 2...
        mov.s   f2, f4                      // ...and set x velocity to target velocity

        lui     t7, 0x8000                  // ~
        and     t6, t6, t7                  // t6 = sign of X_DIFF
        beql    t6, r0, _set_velocity       // branch if X_DIFF is positive...
        add.s   f4, f4, f12                 // and add ACCELERATION to x velocity
        sub.s   f4, f4, f12                 // subtract ACCELERATION from x velocity

        _set_velocity:
        lui     at, MAX_SPEED               // ~
        mtc1    at, f6                      // f6 = MAX_SPEED
        abs.s   f8, f4                      // f8 |X_VELOCITY|
        mfc1    t6, f4                      // t6 = X_VELOCITY
        lui     t7, 0x8000                  // ~
        and     t6, t6, t7                  // t6 = sign of X_VELOCITY
        c.le.s  f8, f6                      // ~
        or      at, at, t6                  // at = MAX_SPEED, adjusted
        bc1fl   pc() + 8                    // if MAX_SPEED =< X_VELOCITY...
        mtc1    at, f4                      // X_VELOCITY = MAX_SPEED
        swc1    f4, 0x0048(s0)              // store updated x velocity
        lwc1    f6, 0x0044(s0)              // ~
        cvt.s.w f6, f6                      // f6 = DIRECTION
        mul.s   f4, f4, f6                  // f4 = X_VELOCITY * DIRECTION
        swc1    f4, 0x0060(s0)              // ground x velocity = X_VELOCITY * DIRECTION

        _end:
        OS.routine_end(0x40)
    }

    // @ Description
    // Handles movement for NSPA.
    scope air_physics_: {
        OS.routine_begin(0x40)
        sw      a0, 0x0020(sp)              // ~
        sw      s0, 0x0024(sp)              // store a0, s0
        lw      s0, 0x0084(a0)              // s0 = player struct
        lui     at, ACCELERATION            // ~
        mtc1    at, f12                     // f12 = ACCELERATION

        _check_movement:
        lb      t6, 0x01C2(s0)              // t6 = stick_x
        bltzl   t6, pc() + 8                // if stick_x is negative...
        subu    t6, r0, t6                  // ...make stick_x positive
        slti    at, t6, 11                  // at = 1 if |stick_x| < 11, else at = 0
        beqz    at, _check_stick            // branch if |stick_x| >= 10
        nop

        _check_min_speed:
        // if we're here then stick_x is < 11, so consider the stick neutral
        lwc1    f4, 0x0048(s0)              // ~
        abs.s   f4, f4                      // f4 = absolute x velocity
        lui     at, MIN_SPEED               // ~
        mtc1    at, f6                      // f6 = MIN_SPEED
        c.le.s  f4, f6                      // ~
        nop                                 // ~
        bc1fl   _apply_movement             // apply movement if current speed < MIN_SPEED...
        mtc1    r0, f2                      // ...and target x velocity = 0
        // set velocity to 0 if below minimum speed
        b       _end                        // end
        sw      r0, 0x0048(s0)              // x velocity = 0

        _check_stick:
        lui     at, A_SPEED_MULTIPLIER      // ~
        mtc1    at, f0                      // f0 = A_SPEED_MULTIPLIER
        lb      at, 0x01C2(s0)              // ~
        mtc1    at, f2                      // ~
        cvt.s.w f2, f2                      // f2 = stick_x
        mul.s   f2, f2, f0                  // f2 = target x velocity = stick_x * SPEED_MULTIPLIER

        _apply_movement:
        lwc1    f4, 0x0048(s0)              // f4 = x velocity
        sub.s   f6, f2, f4                  // f6 = X_DIFF
        abs.s   f8, f6                      // f8 = |X_DIFF|
        lui     at, 0x4000                  // ~
        mtc1    at, f10                     // f10 = 2
        c.le.s  f10, f8                     // ~
        mfc1    t6, f6                      // t6 = X_DIFF
        bc1fl   _set_velocity               // branch if |X_DIFF| < 2...
        mov.s   f2, f4                      // ...and set x velocity to target velocity

        lui     t7, 0x8000                  // ~
        and     t6, t6, t7                  // t6 = sign of X_DIFF
        beql    t6, r0, _set_velocity       // branch if X_DIFF is positive...
        add.s   f4, f4, f12                 // and add ACCELERATION to x velocity
        sub.s   f4, f4, f12                 // subtract ACCELERATION from x velocity

        _set_velocity:
        lui     at, MAX_SPEED               // ~
        mtc1    at, f6                      // f6 = MAX_SPEED
        abs.s   f8, f4                      // f8 |X_VELOCITY|
        mfc1    t6, f4                      // t6 = X_VELOCITY
        lui     t7, 0x8000                  // ~
        and     t6, t6, t7                  // t6 = sign of X_VELOCITY
        c.le.s  f8, f6                      // ~
        or      at, at, t6                  // at = MAX_SPEED, adjusted
        bc1fl   pc() + 8                    // if MAX_SPEED =< X_VELOCITY...
        mtc1    at, f4                      // X_VELOCITY = MAX_SPEED
        swc1    f4, 0x0048(s0)              // store updated x velocity

        _end:
        lui     a1, GRAVITY                 // a1 = GRAVITY
        lw      t6, 0x0008(s0)              // t6 = character id
        lli     at, Character.id.KIRBY      // ~
        beql    at, t6, pc() + 20           // if character = KIRBY...
        lui     a1, KIRBY_GRAVITY           // ...a1 = KIRBY_GRAVITY
        lli     at, Character.id.JKIRBY     // ~
        beql    at, t6, pc() + 8            // if character = JKIRBY...
        lui     a1, KIRBY_GRAVITY           // ...a1 = KIRBY_GRAVITY
        lui     a2, FALL_SPEED              // a2 = FALL_SPEED
        jal     0x800D8D68                  // apply gravity
        or      a0, s0, r0                  // a0 = player struct
        lw      s0, 0x0024(sp)              // load s0
        OS.routine_end(0x40)
    }

    // @ Description
    // Handles movement for NSPABlocked
    scope blocked_air_physics_: {
        OS.routine_begin(0x28)

        lw      v0, 0x0084(a0)              // player struct
        lw      at, 0x0B24(v0)              // bool hitlag_over
        beqz    at, _end                    // branch if "hitlag" isn't over
        nop

        // if "hitlag" is over, run normal air physics
        jal     0x800D91EC                  // run normal air physics
        nop

        _end:
        OS.routine_end(0x28)
    }

    // @ Description
    // Collision function for NSPG
    scope ground_collision_: {
        OS.routine_begin(0x18)
        li      a1, ground_to_air_          // a1(transition subroutine) = ground_to_air_
        jal     0x800DDDDC                  // common ground collision subroutine (transition on no floor, slide-off)
        nop
        OS.routine_end(0x18)
    }

    // @ Description
    // Collision function for NSPA
    scope air_collision_: {
        OS.routine_begin(0x18)
        li      a1, air_to_ground_          // a1(transition subroutine) = air_to_ground_
        jal     0x800DE6E4                  // common air collision subroutine (transition on landing, no ledge grab)
        nop
        OS.routine_end(0x18)
    }

    // @ Description
    // Subroutine which handles ground to air transition for NSP
    scope ground_to_air_: {
        OS.routine_begin(0x50)
        sw      a0, 0x0038(sp)              // 0x0038(sp) = player object
        jal     0x800DEEC8                  // set aerial state
        lw      a0, 0x0084(a0)              // a0 = player struct
        lw      a0, 0x0038(sp)              // a0 = player object

        lw      a2, 0x0078(a0)              // a2(starting frame) = current animation frame
        lui     a3, 0x3F80                  // a3(frame speed multiplier) = 1.0
        lli     t6, 0x0807                  // ~

        lw      t0, 0x0084(a0)              // get player struct
        lw      t1, 0x0008(t0)              // get character id
        addiu   at, r0, Character.id.CRASH
        beql    at, t1, _change_action      // branch if character = Crash
        lli     a1, Crash.Action.NSPA       // a1 = Action.NSPA
        // if here, set kirby action
        lli     a1, Kirby.Action.CRASH_NSP_Air // a1(action id) = Kirby Crash NSP A

        _change_action:
        jal     0x800E6F24                  // change action
        sw      t6, 0x0010(sp)              // argument 4 = 0x0807 (continue: 3C FGM, attached gfx, gfx routines, hitboxes)
        lw      a0, 0x0038(sp)              // a0 = player object
        lw      a0, 0x0084(a0)              // a0 = player struct
        li      at, shield_hit_routine_     // ~
        sw      at, 0x09F4(a0)              // store on shield hit routine
        OS.routine_end(0x50)
    }

    // @ Description
    // Subroutine which handles ground to air transition for neutral special jump
    scope ground_to_air_jump_: {
        OS.routine_begin(0x50)
        jal     ground_to_air_              // transition to NSPA
        sw      a0, 0x0038(sp)              // 0x0038(sp) = player object

        // apply jump velocity
        lw      a0, 0x0038(sp)              // load a0
        lw      a0, 0x0084(a0)              // a0 = player struct
        lui     at, JUMP_SPEED              // at = JUMP_SPEED
        lw      t6, 0x0008(a0)              // t6 = character id
        lli     t7, Character.id.KIRBY      // ~
        beql    t7, t6, pc() + 20           // if character = KIRBY...
        lui     at, KIRBY_JUMP_SPEED        // ...at = KIRBY_JUMP_SPEED
        lli     t7, Character.id.JKIRBY     // ~
        beql    at, t6, pc() + 8            // if character = JKIRBY...
        lui     at, KIRBY_JUMP_SPEED        // ...at = KIRBY_JUMP_SPEED
        sw      at, 0x004C(a0)              // y velocity = JUMP_SPEED
        // create gfx
        lw      a0, 0x0078(a0)              // a0 = player x/y/z pointer
        ori     a1, r0, 0x0001              // a1 = 0x1
        jal     0x800FF3F4                  // jump smoke graphic
        lui     a2, 0x3F80                  // a2 = float: 1.0
        OS.routine_end(0x50)
    }

    // @ Description
    // Subroutine which handles air to ground transition for NSP
    scope air_to_ground_: {
        OS.routine_begin(0x50)
        sw      a0, 0x0038(sp)              // 0x0038(sp) = player object
        jal     0x800DEE98                  // set grounded state
        lw      a0, 0x0084(a0)              // a0 = player struct
        lw      a0, 0x0038(sp)              // a0 = player object

        lw      a2, 0x0078(a0)              // a2(starting frame) = current animation frame
        lui     a3, 0x3F80                  // a3(frame speed multiplier) = 1.0
        lli     t6, 0x0807                  // ~

        lw      t0, 0x0084(a0)              // get player struct
        lw      t1, 0x0008(t0)              // get character id
        addiu   at, r0, Character.id.CRASH
        beql    at, t1, _change_action      // branch if character = Crash
        lli     a1, Crash.Action.NSPG       // a1 = Action.NSPG
        // if here, set kirby action
        lli     a1, Kirby.Action.CRASH_NSP_Ground // a1(action id) = Kirby Crash NSP G

        _change_action:
        jal     0x800E6F24                  // change action
        sw      t6, 0x0010(sp)              // argument 4 = 0x0807 (continue: 3C FGM, attached gfx, gfx routines, hitboxes)
        lw      a0, 0x0038(sp)              // a0 = player object
        lw      a0, 0x0084(a0)              // a0 = player struct
        li      at, shield_hit_routine_     // ~
        sw      at, 0x09F4(a0)              // store on shield hit routine
        OS.routine_end(0x50)
    }

    // @ Description
    // Collision function for NSPGBlocked
    scope blocked_ground_collision_: {
        OS.routine_begin(0x18)
        li      a1, blocked_ground_to_air_  // a1(transition subroutine) = blocked_ground_to_air_
        jal     0x800DDDDC                  // common ground collision subroutine (transition on no floor, slide-off)
        nop
        OS.routine_end(0x18)
    }

    // @ Description
    // Collision function for NSPABlocked
    scope blocked_air_collision_: {
        OS.routine_begin(0x18)
        li      a1, blocked_air_to_ground_  // a1(transition subroutine) = blocked_air_to_ground_
        jal     0x800DE6E4                  // common air collision subroutine (transition on landing, no ledge grab)
        nop
        OS.routine_end(0x18)
    }

    // @ Description
    // Subroutine which handles ground to air transition for blocked nsp
    scope blocked_ground_to_air_: {
        OS.routine_begin(0x50)
        sw      a0, 0x0038(sp)              // 0x0038(sp) = player object
        jal     0x800DEEC8                  // set aerial state
        lw      a0, 0x0084(a0)              // a0 = player struct
        lw      a0, 0x0038(sp)              // a0 = player object

        lw      a2, 0x0078(a0)              // a2(starting frame) = current animation frame
        lui     a3, 0x3F80                  // a3(frame speed multiplier) = 1.0
        lli     t6, 0x0807                  // ~

        lw      t0, 0x0084(a0)              // get player struct
        lw      t1, 0x0008(t0)              // get character id
        addiu   at, r0, Character.id.CRASH
        beql    at, t1, _change_action      // branch if character = Crash
        lli     a1, Crash.Action.NSPABlocked // a1 = Action.NSPABlocked
        // if here, set kirby action
        lli     a1, Kirby.Action.CRASH_NSP_Air_Blocked // a1(action id) = Kirby Crash NSP A

        _change_action:
        jal     0x800E6F24                  // change action
        sw      t6, 0x0010(sp)              // argument 4 = 0x0807 (continue: 3C FGM, attached gfx, gfx routines, hitboxes)
        lw      a0, 0x0038(sp)              // a0 = player object
        OS.routine_end(0x50)
    }

    // @ Description
    // Subroutine which handles air to ground transition for blocked nsp
    scope blocked_air_to_ground_: {
        OS.routine_begin(0x50)
        sw      a0, 0x0038(sp)              // 0x0038(sp) = player object
        jal     0x800DEE98                  // set grounded state
        lw      a0, 0x0084(a0)              // a0 = player struct
        lw      a0, 0x0038(sp)              // a0 = player object

        lw      a2, 0x0078(a0)              // a2(starting frame) = current animation frame
        lui     a3, 0x3F80                  // a3(frame speed multiplier) = 1.0
        lli     t6, 0x0807                  // ~

        lw      t0, 0x0084(a0)              // get player struct
        lw      t1, 0x0008(t0)              // get character id
        addiu   at, r0, Character.id.CRASH
        beql    at, t1, _change_action      // branch if character = Crash
        lli     a1, Crash.Action.NSPGBlocked // a1 = Action.NSPGBlocked
        // if here, set kirby action
        lli     a1, Kirby.Action.CRASH_NSP_Ground_Blocked // a1(action id) = Kirby Crash NSP G

        _change_action:
        jal     0x800E6F24                  // change action
        sw      t6, 0x0010(sp)              // argument 4 = 0x0807 (continue: 3C FGM, attached gfx, gfx routines, hitboxes)
        lw      a0, 0x0038(sp)              // a0 = player object
        OS.routine_end(0x50)
    }

    // @ Description
    // This function is responsible for creating the Spin GFX object.
    // Based on 0x80103378 which creates the Up Special GFX for Link.
    scope create_spin_gfx_: {
        OS.routine_begin(0x18)

        or      a2, a0, r0                  // a2 = player object
        li      a0, spin_gfx_struct         // a0 = spin_gfx_struct
        lw      t0, 0x0084(a2)              // t0 = player struct
        lw      t1, 0x0008(t0)              // t1 = character id
        addiu   at, r0, Character.id.KIRBY
        beq     at, t1, _kirby              // branch if character is KIRBY
        addiu   at, r0, Character.id.JKIRBY
        bne     at, t1, _continue           // skip if character is not JKIRBY
        nop

        _kirby:
        li      a0, kirby_spin_gfx_struct   // a0 = kirby_spin_gfx_struct
        li      t6, Character.CRASH_file_7_ptr
        lw      t6, 0x0000(t6)              // ~
        addiu   t6, t6, 0x0CC4              // ~
        sw      t6, 0x0004(a0)              // update Kirby Spin GFX file pointer

        _continue:
        jal     0x800FDAFC                  // create attached gfx
        sw      a2, 0x0018(sp)              // 0x0018(sp) = player object
        j       0x80103398                  // jump to original function and continue
        lw      a2, 0x0018(sp)              // a2 = player object
    }

    // @ Description
    // flings an item and disabled item pickup flag
    scope item_fling_: {
        addiu   sp, sp, -0x18
        sw      ra, 0x0014(sp)
        sw      a0, 0x0018(sp)
        lw      a0, 0x0084(a0)
        lbu     t7, 0x02ce(a0)
        andi    t8, t7, 0xff7f
        jal     0x80173f78
        sb      t8, 0x02ce(a0)
        li      a1, flung_item_state_table
        lw      a0, 0x0018(sp)
        jal     0x80172ec8      // change item state
        addiu   a2, r0, 0x0000  // state = 0
        lw      ra, 0x0014(sp)
        jr      ra
        addiu   sp, sp, 0x18
    }

    // @ Description
    // Patch which skips regular hitlag when NSP hits shield
    scope shield_hitlag_patch_: {
        OS.patch_start(0x61D1C, 0x800E651C)
        j       shield_hitlag_patch_
        nop
        _return:
        OS.patch_end()

        // s0 = player struct
        lw      t6, 0x0008(s0)              // t6 = character id
        lli     t4, Character.id.KIRBY      // t4 = id.KIRBY
        beq     t6, t4, _kirby              // skip if character id = KIRBY
        lli     t4, Character.id.JKIRBY     // t4 = id.JKIRBY
        beq     t6, t4, _kirby              // skip if character id = JKIRBY
        lli     t4, Character.id.CRASH      // t4 = id.CRASH
        bne     t6, t4, _end                // skip if character id != Crash
        lw      t6, 0x07BC(s0)              // t6 = hitlag frames (original line 2)

        // if the character is Crash
        lw      t5, 0x0024(s0)              // t5 = current action
        lli     t4, Crash.Action.NSPGBlocked // t4 = Action.NSPGBlocked
        beql    t5, t4, _end                // branch if action = NSPGBlocked...
        or      t6, r0, r0                  // ... and t6 = hitlag frames = 0
        lli     t4, Crash.Action.NSPABlocked // t4 = Action.NAPGBlocked
        beql    t5, t4, _end                // branch if action = NSPGBlocked...
        or      t6, r0, r0                  // ... and t6 = hitlag frames = 0

        b       _end
        nop

        _kirby:
        lb      t6, 0x0980(s0)              // at = current hat ID
        addiu   t4, r0, 0x2A                // t4 = crash hat id
        bne     t4, t6, _end
        lw      t6, 0x07BC(s0)              // t6 = hitlag frames (original line 2)

        lw      t5, 0x0024(s0)              // t5 = current action
        lli     t4, Kirby.Action.CRASH_NSP_Ground_Blocked // t4 = Action.NSPGBlocked
        beql    t5, t4, _end                // branch if action = NSPGBlocked...
        or      t6, r0, r0                  // ... and t6 = hitlag frames = 0
        lli     t4, Kirby.Action.CRASH_NSP_Air_Blocked // t4 = Action.NSPABlocked
        beql    t5, t4, _end                // branch if action = NSPABlocked...
        or      t6, r0, r0                  // ... and t6 = hitlag frames = 0

        _end:
        bc1tl   _j_0x800E6550               // original branch logic
        nop
        j       _return                     // return
        nop

        _j_0x800E6550:
        j       0x800E6550                  // original branch location
        nop
    }

    // @ Description
    // GFX struct for Spin GFX, based on Link's Up special graphic which is at 0xA9E2C in the base ROM.
    spin_gfx_struct:
    dw 0x060F0000
    dw Character.CRASH_file_7_ptr
    dw 0x501A001C
    dw 0
    dw 0x800FD568
    dw 0x80014768
    // these need to be update with the GFX, 0xA9E44 in the base ROM
    dw 0x00000708
    dw 0x00000838
    dw 0x00000894
    dw 0x000008B4

    // @ Description
    // GFX struct for Spin GFX, based on Link's Up special graphic which is at 0xA9E2C in the base ROM.
    kirby_spin_gfx_struct:
    dw 0x060F0000
    dw 0                                    // will hold file pointer
    dw 0x501A001C
    dw 0
    dw 0x800FD568
    dw 0x80014768
    // these need to be update with the GFX, 0xA9E44 in the base ROM
    dw 0x00000708
    dw 0x00000838
    dw 0x00000894
    dw 0x000008B4

    // @ Description
    // Table of Primitive/Environment colours for the Spin GFX for each costume.
    spin_gfx_table:
    // costume 0
    dw 0xFFFFFFB0, 0xFF4E00FF               // prim colour, env colour (top)
    dw 0x42001FA0, 0x120015FF               // prim colour, env colour (bottom)
    // costume 1
    dw 0xFFFFFFB0, 0xFF0000FF               // prim colour, env colour (top)
    dw 0x52002FA0, 0x220005FF               // prim colour, env colour (bottom)
    // costume 2
    dw 0xFFFFFFB0, 0x60E800FF               // prim colour, env colour (top)
    dw 0x62002FA0, 0x120015FF               // prim colour, env colour (bottom)
    // costume 3
    dw 0xFFFFFFB0, 0xB0D0FFFF               // prim colour, env colour (top)
    dw 0x003070A0, 0x00080FFF               // prim colour, env colour (bottom)
    // costume 4
    dw 0xFFFFFFB0, 0xFFE000FF               // prim colour, env colour (top)
    dw 0x404040A0, 0x080808FF               // prim colour, env colour (bottom)
    // costume 5
    dw 0xFFFFFFB0, 0x4C3020FF               // prim colour, env colour (top)
    dw 0x004058A0, 0x240008FF               // prim colour, env colour (bottom)
    // costume 6
    dw 0xFFFFFFB0, 0xFF7400FF               // prim colour, env colour (top)
    dw 0x1F4200A0, 0x040F00FF               // prim colour, env colour (bottom)

    // @ Description
    // Table of Primitive/Environment colours for the Spin GFX for each costume.
    kirby_spin_gfx_table:
    // costume 0
    dw 0xFF0000A0, 0xFFA5B480               // prim colour, env colour (top)
    dw 0xFFA5B4A0, 0xFF4E00C0               // prim colour, env colour (bottom)
    // costume 1
    dw 0xFF8000A0, 0xFFF00080               // prim colour, env colour (top)
    dw 0xFFFF00A0, 0xFF4E00C0               // prim colour, env colour (bottom)
    // costume 2
    dw 0x0000FFA0, 0x00F0FF80               // prim colour, env colour (top)
    dw 0x00F0FFA0, 0xFF4E00C0               // prim colour, env colour (bottom)
    // costume 3
    dw 0x804000A0, 0xFF000080               // prim colour, env colour (top)
    dw 0xFF0000A0, 0xFF4E00C0               // prim colour, env colour (bottom)
    // costume 4
    dw 0x008800A0, 0x00FF6080               // prim colour, env colour (top)
    dw 0x00FF60A0, 0xFF4E00C0               // prim colour, env colour (bottom)
    // costume 5
    dw 0x606060A0, 0xFFFFFF80               // prim colour, env colour (top)
    dw 0xFFFFFFA0, 0xFF4E00C0               // prim colour, env colour (bottom)
    // costume 6
    dw 0x904080A0, 0x1828A880               // prim colour, env colour (top)
    dw 0x1828A8A0, 0xFF4E00C0               // prim colour, env colour (bottom)

    flung_item_state_table:
    dw 0, 0, 0, 0, 0, 0, 0, 0               // no special functions
}


scope CrashUSP {
    constant Y_SPEED(0x4260)                // float32 56
    constant FALL_SPEED(0x42F0)             // float32 120
    constant GRAVITY(0x3FC0)                // float32 1.5
    constant GRAVITY_2(0x4190)              // float32 18
    constant BOUNCE_X_SPEED(0xC1A0)         // float32 -20
    constant BOUNCE_Y_SPEED(0x4270)         // float32 60
    constant AIR_SPEED(0x4240)              // float32 48
    constant AIR_ACCEL(0x3DA4)              // float32 0.08
    constant AIR_SPEED_2(0x41A0)            // float32 20
    constant AIR_ACCEL_2(0x3D4D)            // float32 0.05
    constant AIR_FRICTION(0x4000)           // float32 2

    // @ Description
    // Initial subroutine for USPG.
    scope ground_initial_: {
        addiu   sp, sp,-0x0020              // allocate stack space
        sw      ra, 0x001C(sp)              // ~
        sw      a0, 0x0020(sp)              // store a0, ra
        lw      v1, 0x0084(a0)              // v1 = player struct

        lli     a1, Crash.Action.USPG       // a1(action id) = USPG
        or      a2, r0, r0                  // a2(starting frame) = 0
        sw      r0, 0x0010(sp)              // argument 4 = 0
        jal     0x800E6F24                  // change action
        lui     a3, 0x3F80                  // a3(frame speed multiplier) = 1.0
        jal     0x800E0830                  // unknown common subroutine
        lw      a0, 0x0020(sp)              // a0 = player object
        lw      a0, 0x0020(sp)              // ~
        lw      a0, 0x0084(a0)              // a0 = player struct
        sw      r0, 0x017C(a0)              // temp variable 1 = 0
        sw      r0, 0x0180(a0)              // temp variable 2 = 0
        sw      r0, 0x0184(a0)              // temp variable 3 = 0
        sw      r0, 0x004C(a0)              // y velocity = 0
        lw      ra, 0x001C(sp)              // load ra
        addiu   sp, sp, 0x0020              // deallocate stack space
        jr      ra                          // return
        nop
    }

    // @ Description
    // Initial subroutine for USPA.
    scope air_initial_: {
        addiu   sp, sp,-0x0020              // allocate stack space
        sw      ra, 0x001C(sp)              // ~
        sw      a0, 0x0020(sp)              // store a0, ra
        lw      v1, 0x0084(a0)              // v1 = player struct

        lli     a1, Crash.Action.USPA       // a1(action id) = USPA
        or      a2, r0, r0                  // a2(starting frame) = 0
        sw      r0, 0x0010(sp)              // argument 4 = 0
        jal     0x800E6F24                  // change action
        lui     a3, 0x3F80                  // a3(frame speed multiplier) = 1.0
        jal     0x800E0830                  // unknown common subroutine
        lw      a0, 0x0020(sp)              // a0 = player object
        lw      a0, 0x0020(sp)              // ~
        lw      a0, 0x0084(a0)              // a0 = player struct
        sw      r0, 0x017C(a0)              // temp variable 1 = 0
        sw      r0, 0x0180(a0)              // temp variable 2 = 0
        sw      r0, 0x0184(a0)              // temp variable 3 = 0
         // reset fall speed
        lbu     v1, 0x018D(a0)              // v1 = fast fall flag
        ori     t6, r0, 0x0007              // t6 = bitmask (01111111)
        and     v1, v1, t6                  // ~
        sb      v1, 0x018D(a0)              // disable fast fall flag
        lui     at, 0x3D48                  // ~
        mtc1    at, f2                      // f2 = 0.05
        lwc1    f4, 0x004C(a0)              // f4 = y velocity
        mul.s   f2, f2, f4                  // f2 = y velocity * 0.05
        swc1    f2, 0x004C(a0)              // store updated ye velocity
        lw      ra, 0x001C(sp)              // load ra
        addiu   sp, sp, 0x0020              // deallocate stack space
        jr      ra                          // return
        nop
    }

    // @ Description
    // Initial function for USPLanding
    scope landing_initial_: {
        OS.routine_begin(0x30)
        sw      a0, 0x0018(sp)              // 0x0018(sp) = player object
        jal     0x800DEE98                  // set grounded state
        lw      a0, 0x0084(a0)              // a0 = player struct
        lw      a0, 0x0018(sp)              // a0 = player object
        lli     a1, Crash.Action.USPLanding // a1(action id) = Action.USPLanding
        or      a2, r0, r0                  // a2(starting frame) = 0
        lui     a3, 0x3F80                  // a3(frame speed multiplier) = 1.0
        jal     0x800E6F24                  // change action
        sw      r0, 0x0010(sp)              // argument 4 = 0
        jal     0x800E0830                  // unknown common subroutine
        lw      a0, 0x0018(sp)              // a0 = player object
        lw      a0, 0x0018(sp)              // ~
        lw      a0, 0x0084(a0)              // a0 = player struct
        sw      r0, 0x0060(a0)              // ground x velocity = 0
        //sw      r0, 0x0180(a0)              // temp variable 2 = 0
        //sw      r0, 0x0184(a0)              // temp variable 3 = 0
        OS.routine_end(0x30)
    }

    // @ Description
    // Main subroutine for USPA and USPG
    scope main_: {
        addiu   sp, sp,-0x0030              // allocate stack space
        sw      ra, 0x0014(sp)              // store ra
        lw      v0, 0x0084(a0)              // v0 = player struct

        _check_begin_move:
        lw      at, 0x017C(v0)              // at = temp variable 1
        beqz    at, _end                    // skip if temp variable 1 not set
        sw      v0, 0x0018(sp)              // 0x0018(v0)

        sw      r0, 0x017C(v0)              //
        lui     at, Y_SPEED                 // ~
        sw      at, 0x004C(v0)              // y velocity = Y_SPEED
        // take mid-air jumps away at this point
        jal     0x800DEEC8                  // set aerial state
        or      a0, v0, r0                  // a0 = player struct
        lw      v0, 0x0018(sp)              // v0 = player struct
        lw      t0, 0x09C8(v0)              // t0 = attribute pointer
        lw      t0, 0x0064(t0)              // t0 = max jumps
        sb      t0, 0x0148(v0)              // jumps used = max jump
        jal     PokemonAnnouncer.body_slam_announcement_
        nop

        _end:
        lw      ra, 0x0014(sp)              // load ra
        addiu   sp, sp, 0x0030              // deallocate stack space
        jr      ra                          // return
        nop
    }

    // @ Description
    // Subroutine which allows a direction change for Crash's up special.
    scope change_direction_: {
        // 0x180 in player struct = temp variable 2

        addiu   sp, sp,-0x0020              // allocate stack space
        sw      ra, 0x0014(sp)              // store ra
        lw      a1, 0x0084(a0)              // a1 = player struct
        sw      a1, 0x0018(sp)              // 0x0018(sp) = player struct
        lw      t0, 0x0184(a1)              // t0 = temp variable 3
        beqz    t0, _end                    // skip if temp variable 3 not set
        lli     at, 0x0001                  // ~

        jal     0x80160370                  // turn subroutine (copied from captain falcon)
        sw      at, 0x0180(a1)              // temp variable 2 = 1
        lw      a1, 0x0018(sp)              // a1 = player struct
        sw      r0, 0x0180(a1)              // ~
        sw      r0, 0x0184(a1)              // reset temp variable 1/2

        _end:
        lw      ra, 0x0014(sp)              // load ra
        jr      ra                          // return
        addiu   sp, sp, 0x0020              // deallocate stack space
    }

    // @ Description
    // Movement subroutine for USP.
    // Modified version of subroutine 0x800D90E0.
    scope physics_: {
        // Copy the first 8 lines of subroutine 0x800D90E0
        OS.copy_segment(0x548E0, 0x20)

        // Skip 7 lines (fast fall branch logic)

        // jal 0x800D8E50                   // ~
        // or a1, s1, r0                    // original 2 lines call gravity subroutine
        lui     a1, GRAVITY                 // a1 = GRAVITY
        lw      t6, 0x0180(s0)              // t6 = temp variable 2
        bnezl   t6, _apply_gravity          // branch if temp variable 2 is set...
        lui     a1, GRAVITY_2               // ...and a1 = GRAVITY_2

        _apply_gravity:
        jal     0x800D8D68                  // apply gravity/fall speed
        lui     a2, FALL_SPEED              // a2 = FALL_SPEED
        lw      at, 0x0180(s0)              // at = temp variable 2
        beqz    at, _air_control            // skip if temp variable 2 is not set
        // Copy the next 4 lines of subroutine 0x800D90E0
        OS.copy_segment(0x54924, 0x10)
        _air_control:
        or      a0, r0, s0
         // jal 0x800D9044                   // original line calls air control subroutine
        jal     air_control_                // call custom subroutine instead
        or      a1, s1, r0                  // a1 = attribute pointer
        or      a0, s0, r0                  // a0 = player struct
        // jal 0x800D9074                   // original line calls air friction subroutine
        jal     air_friction_               // call custom wrapped subroutine instead
        // Copy the last 6 lines of subroutine 0x800D90E0
        OS.copy_segment(0x54948, 0x18)
    }

    // @ Description
    // Subroutine which handles Crash's horizontal air control for up special.
    // Based on 0x800D9044
    scope air_control_: {
        addiu   sp, sp,-0x0028              // allocate stack space
        sw      ra, 0x0014(sp)              // store ra
        lw      t6, 0x0180(a0)              // t6 = temp variable 2
        lui     a2, AIR_ACCEL_2             // ...a2 = AIR_ACCEL_2
        bnezl   t6, _continue               // if temp variable 2 is set...
        lui     a3, AIR_SPEED_2             // ...a3 = AIR_SPEED_2
        // if temp variable 2 is not set, use normal values
        lui     a2, AIR_ACCEL               // a2 = AIR_ACCEL
        lui     a3, AIR_SPEED               // a3 = AIR_SPEED_2

        _continue:
        jal     0x800D8FC8                  // air drift subroutine?
        addiu   a1, r0, 0x0008              // a1 = 0x8 (original line)
        lw      ra, 0x0014(sp)              // load ra
        jr      ra                          // return
        addiu   sp, sp, 0x0028              // deallocate stack space
    }

    // @ Description
    // Subroutine which handles Crash's air friction for up special.
    scope air_friction_: {
        OS.routine_begin(0x80)
        // use sp as fake attribute pointer for custom air friction
        lui     at, AIR_FRICTION            // ~
        sw      at, 0x0054(sp)              // 0x0054(sp) = AIR_FRICTION
        jal     0x800D9074                  // air friction function
        or      a1, sp, r0                  // a1 = sp
        OS.routine_end(0x80)
    }

    // @ Description
    // Subroutine which handles collision for Crash's up special.
    // 80161050
    scope collision_: {
        addiu   sp, sp,-0x0020              // allocate stack space
        sw      a0, 0x0010(sp)              // ~
        sw      ra, 0x0014(sp)              // store ra, a0
        lw      a1, 0x0084(a0)              // a1 = player struct
        lw      v0, 0x014C(a1)              // v0 = kinetic state
        bnez    v0, _aerial                 // branch if kinetic state != grounded
        nop

        _grounded:
        jal     0x800DDF44                  // grounded collision subroutine
        nop
        b       _end                        // branch to end
        nop

        _aerial:
        li      a1, landing_initial_        // a1 = begin_landing_
        jal     0x800DE80C                  // common air collision subroutine (transition on landing, allow ledge grab)
        lw      a0, 0x0010(sp)              // load a0

        _end:
        lw      ra, 0x0014(sp)              // load ra
        addiu   sp, sp, 0x0020              // deallocate stack space
        jr      ra
        nop
    }
}

scope CrashDSP {
    constant MIN_SPEED(0x4000)              // float32 2
    constant MAX_SPEED(0x4220)              // float32 40
    constant ACCELERATION(0x4100)           // float32 8
    constant G_SPEED_MULTIPLIER(0x3F00)     // float32 0.5
    constant END_Y_SPEED(0x4270)            // float32 60
    constant END_Y_SPEED_EDGE(0x4220)       // float32 40
    constant DIVE_Y_SPEED(0xC2C8)           // float32 -100
    constant DIVE_AIR_Y_SPEED(0x41F0)       // float32 30
    constant DIVE_AIR_FRICTION(0x3FE0)      // float32 1.75
    constant DIVE_FALL_SPEED(0x42C8)        // float32 100
    constant DIVE_GRAVITY(0x3F00)          // float32 0.5
    constant DIVE_GRAVITY_2(0x40E0)        // float32 7
    constant MAX_TIME(180)

    // @ Description
    // Initial function for Down Special
    scope initial_: {
        OS.routine_begin(0x30)

        lw      a1, 0x0084(a0)              // a1 = player struct
        lw      t6, 0x00F4(a1)              // t6 = clipping id
        andi    t6, t6, 0x4000              // t6 = 0x4000 if platform has drop-through
        sw      r0, 0x0B1C(a1)              // clear referenced GFX object
        addiu   at, r0, -1                  // ~
        beqz    t6, _normal                 // begin DSP normally if it's not a drop-through platform
        sw      at, 0x0B20(a1)              // move timer offset = -1

        _platform:
        // does an alternate DSP on floors with drop-through
        jal     dive_initial_
        nop
        b       _end
        nop

        _normal:
        // on solid floors, do the regular DSP
        jal     begin_initial_
        nop

        _end:
        OS.routine_end(0x30)
    }

    // @ Description
    // Initial function for DSPBegin
    scope begin_initial_: {
        OS.routine_begin(0x30)
        sw      a0, 0x0018(sp)              // 0x0018(sp) = player object
        lli     a1, Crash.Action.DSPBegin   // a1(action id) = Action.DSPBegin
        or      a2, r0, r0                  // a2(starting frame) = 0
        lui     a3, 0x3F80                  // a3(frame speed multiplier) = 1.0
        lli     t6, 0x0007                  // ~
        jal     0x800E6F24                  // change action
        sw      t6, 0x0010(sp)              // argument 4 = 0x0007 (attached gfx, gfx routines, hitboxes)
        jal     0x800E0830                  // unknown common subroutine
        lw      a0, 0x0018(sp)              // a0 = player object
        jal     create_dig_gfx_             // create dig gfx
        lw      a0, 0x0018(sp)              // a0 = player object
        beq     v0, r0, _end                // branch if no gfx object was created
        lw      a0, 0x0018(sp)              // ~

        // if a dig GFX object was created
        jal     PokemonAnnouncer.burrow_announcement_
        nop
        lw      a0, 0x0084(a0)              // a0 = player struct
        jal     setup_dig_gfx_              // set up dig gfx
        sw      v0, 0x0B1C(a0)              // store attached object reference

        _end:
        lw      a0, 0x0018(sp)              // ~
        lw      a0, 0x0084(a0)              // a0 = player struct
        sw      r0, 0x017C(a0)              // temp variable 1 = 0
        sw      r0, 0x0180(a0)              // temp variable 2 = 0
        sw      r0, 0x0184(a0)              // temp variable 3 = 0
        OS.routine_end(0x30)
    }

    // @ Description
    // Initial function for DSPDive
    scope dive_initial_: {
        OS.routine_begin(0x30)
        sw      a0, 0x0018(sp)              // 0x0018(sp) = player object
        lli     a1, Crash.Action.DSPDive    // a1(action id) = Action.DSPDive
        or      a2, r0, r0                  // a2(starting frame) = 0
        lui     a3, 0x3F80                  // a3(frame speed multiplier) = 1.0
        lli     t6, 0x0007                  // ~
        jal     0x800E6F24                  // change action
        sw      t6, 0x0010(sp)              // argument 4 = 0x0007 (attached gfx, gfx routines, hitboxes)
        jal     0x800E0830                  // unknown common subroutine
        lw      a0, 0x0018(sp)              // a0 = player object
        lw      a0, 0x0018(sp)              // ~
        lw      a0, 0x0084(a0)              // a0 = player struct
        sw      r0, 0x017C(a0)              // temp variable 1 = 0
        sw      r0, 0x0180(a0)              // temp variable 2 = 0
        sw      r0, 0x0184(a0)              // temp variable 3 = 0
        sw      r0, 0x0048(a0)              // x velocity = 0
        OS.routine_end(0x30)
    }

    // @ Description
    // Initial function for DSPAirDive
    scope dive_air_initial_: {
        OS.routine_begin(0x30)
        sw      a0, 0x0018(sp)              // 0x0018(sp) = player object
        lli     a1, Crash.Action.DSPAirDive // a1(action id) = Action.DSPAirDive
        or      a2, r0, r0                  // a2(starting frame) = 0
        lui     a3, 0x3F80                  // a3(frame speed multiplier) = 1.0
        lli     t6, 0x0007                  // ~
        jal     0x800E6F24                  // change action
        sw      t6, 0x0010(sp)              // argument 4 = 0x0007 (attached gfx, gfx routines, hitboxes)
        jal     0x800E0830                  // unknown common subroutine
        lw      a0, 0x0018(sp)              // a0 = player object
        lw      a0, 0x0018(sp)              // ~
        lw      a0, 0x0084(a0)              // a0 = player struct
        sw      r0, 0x017C(a0)              // temp variable 1 = 0
        sw      r0, 0x0180(a0)              // temp variable 2 = 0
        sw      r0, 0x0184(a0)              // temp variable 3 = 0
        sw      r0, 0x0048(a0)              // x velocity = 0
        lui     at, DIVE_AIR_Y_SPEED        // ~
        sw      at, 0x004C(a0)              // y velocity = DIVE_AIR_Y_SPEED
        OS.routine_end(0x30)
    }

    // @ Description
    // Initial function for DSPWait
    scope wait_initial_: {
        OS.routine_begin(0x30)
        sw      a0, 0x0018(sp)              // 0x0018(sp) = player object
        lli     a1, Crash.Action.DSPWait    // a1(action id) = Action.DSPWait
        or      a2, r0, r0                  // a2(starting frame) = 0
        lui     a3, 0x3F80                  // a3(frame speed multiplier) = 1.0
        lli     t6, 0x0007                  // ~
        jal     0x800E6F24                  // change action
        sw      t6, 0x0010(sp)              // argument 4 = 0x0007 (attached gfx, gfx routines, hitboxes)
        jal     0x800E0830                  // unknown common subroutine
        lw      a0, 0x0018(sp)              // a0 = player object

        lw      a0, 0x0018(sp)              // a0 = player object
        lw      a0, 0x0084(a0)              // a0 = player struct
        lw      t6, 0x0B1C(a0)              // t6 = referenced gfx object
        beqz    t6, _end                    // skip if no referenced gfx object
        lw      t8, 0x08E8(a0)              // t8 = player topjoint struct
        lw      t7, 0x0074(t6)              // t7 = gfx topjoint struct
        lw      at, 0x0034(t8)              // ~
        sw      at, 0x0034(t7)              // copy player topjoint rotation
        lw      a0, 0x0010(t7)              // a0 = gfx joint 1
        li      a1, track_dig_wait          // a1 = wait animation track
        jal     0x8000BD1C                  // apply animation track to joint
        or      a2, r0, r0                  // a2 = 0

        _end:
        OS.routine_end(0x30)
    }

    // @ Description
    // Initial function for DSPTurn
    scope turn_intial_: {
        OS.routine_begin(0x30)
        sw      a0, 0x0018(sp)              // 0x0018(sp) = player object
        lli     a1, Crash.Action.DSPTurn    // a1(action id) = Action.DSPTurn
        or      a2, r0, r0                  // a2(starting frame) = 0
        lui     a3, 0x3F80                  // a3(frame speed multiplier) = 1.0
        lli     t6, 0x0007                  // ~
        jal     0x800E6F24                  // change action
        sw      t6, 0x0010(sp)              // argument 4 = 0x0007 (attached gfx, gfx routines, hitboxes)
        jal     0x800E0830                  // unknown common subroutine
        lw      a0, 0x0018(sp)              // a0 = player object

        lw      a0, 0x0018(sp)              // a0 = player object
        lw      a0, 0x0084(a0)              // a0 = player struct
        lw      t6, 0x0B1C(a0)              // t6 = referenced gfx object
        beqz    t6, _end                    // skip if no referenced gfx object
        nop
        lw      a0, 0x0074(t6)              // ~
        lw      a0, 0x0010(a0)              // a0 = gfx joint 1
        li      a1, track_dig_turn          // a1 = turn animation track
        jal     0x8000BD1C                  // apply animation track to joint
        or      a2, r0, r0                  // a2 = 0

        _end:
        OS.routine_end(0x30)
    }

    // @ Description
    // Initial function for DSPEnd
    // a0 - player struct
    // a1 - bool slide-off
    scope end_initial_: {
        OS.routine_begin(0x30)
        sw      a0, 0x0018(sp)              // 0x0018(sp) = player object
        jal     PokemonAnnouncer.dig_announcement_
        sw      a1, 0x001C(sp)              // 0x001C(sp) = bool slide-off
        lli     a1, Crash.Action.DSPEnd     // a1(action id) = Action.DSPTurn
        or      a2, r0, r0                  // a2(starting frame) = 0
        lui     a3, 0x3F80                  // a3(frame speed multiplier) = 1.0
        lli     t6, 0x0007                  // ~
        jal     0x800E6F24                  // change action
        sw      t6, 0x0010(sp)              // argument 4 = 0x0007 (attached gfx, gfx routines, hitboxes)
        jal     0x800E0830                  // unknown common subroutine
        lw      a0, 0x0018(sp)              // a0 = player object
        lw      a0, 0x0018(sp)              // ~
        lw      a0, 0x0084(a0)              // a0 = player struct
        lw      t5, 0x0B1C(a0)              // t5 = referenced GFX object
        beqz    t5, _end                    // skip if no referenced GFX object
        lw      t8, 0x08E8(a0)              // t8 = player topjoint struct

        // if there's a referenced GFX object, stop its position from updating
        lw      t6, 0x0074(t5)              // t6 = gfx topjoint struct
        lw      t7, 0x0058(t6)              // t7 = topjoint render struct?
        lw      at, 0x0034(t8)              // ~
        sw      at, 0x0034(t6)              // copy player topjoint rotation
        lw      at, 0x001C(t8)              // ~
        sw      at, 0x004C(t5)              // ~
        lw      at, 0x0020(t8)              // ~
        sw      at, 0x0050(t5)              // ~
        lw      at, 0x0024(t8)              // ~
        sw      at, 0x0054(t5)              // copy player x/y/z position
        // lli     at, 0x0040                  // ~
        // sb      at, 0x0004(t7)              // 0x50 -> 0x40, branch at 8001100C checks if this is 0x40 or less before attaching to joint
        lli     at, 0x0002                  // ~
        sb      at, 0x0005(t7)              // 0x00 -> 0x02, branch at 80010E8C checks if this is not equal to 0x2 before attaching to joint
        lw      a0, 0x0010(t6)              // a0 = gfx joint 1
        li      a1, track_dig_end           // a1 = end animation track
        jal     0x8000BD1C                  // apply animation track to joint
        or      a2, r0, r0                  // a2 = 0

        _end:
        lw      a0, 0x0018(sp)              // ~
        lw      a0, 0x0084(a0)              // a0 = player struct
        lw      a1, 0x001C(sp)              // a1 = bool slide-off
        beqzl   a1, pc() + 12               // if bool slide-off = FALSE...
        lui     at, END_Y_SPEED             // ...y velocity = END_Y_SPEED
        lui     at, END_Y_SPEED_EDGE        // else, y velocity = END_Y_SPEED_EDGE
        jal     0x800DEEC8                  // set aerial state
        sw      at, 0x004C(a0)              // store y velocity
        OS.routine_end(0x30)
    }

    // @ Description
    // Begin DSPEnd with slide-off bool set to TRUE
    scope slide_off_end_initial_: {
        OS.routine_begin(0x20)
        jal     end_initial_                // transition to DSPEnd
        lli     a1, OS.TRUE                 // bool slide-off = TRUE
        OS.routine_end(0x20)
    }

    // @ Description
    // Transitions from DSPDive to DSPBegin when colliding with a floor
    scope begin_initial_from_dive_: {
        OS.routine_begin(0x30)
        sw      a0, 0x0018(sp)              // 0x0018(sp) = player object
        jal     0x800DEE98                  // set grounded state
        lw      a0, 0x0084(a0)              // a0 = player struct
        lw      a0, 0x0018(sp)              // a0 = player object
        lli     a1, Crash.Action.DSPBegin   // a1(action id) = Action.DSPBegin
        lui     a2, 0x41A0                  // a2(starting frame) = 20
        lui     a3, 0x3F80                  // a3(frame speed multiplier) = 1.0
        lli     t6, 0x0007                  // ~
        jal     0x800E6F24                  // change action
        sw      t6, 0x0010(sp)              // argument 4 = 0x0007 (attached gfx, gfx routines, hitboxes)
        jal     0x800E0830                  // unknown common subroutine
        lw      a0, 0x0018(sp)              // a0 = player object
        jal     create_dig_gfx_             // create dig gfx
        lw      a0, 0x0018(sp)              // a0 = player object
        beq     v0, r0, _end                // branch if no gfx object was created
        lw      a0, 0x0018(sp)              // ~

        // if a dig GFX object was created
        lw      a0, 0x0084(a0)              // a0 = player struct
        jal     setup_dig_gfx_              // set up dig gfx
        sw      v0, 0x0B1C(a0)              // store attached object reference
        lw      a0, 0x0074(v0)              // ~
        lw      a0, 0x0010(a0)              // a0 = gfx joint 1
        lui     at, 0x4040                  // ~
        sw      at, 0x0074(a0)              // adjust animation timer
        jal     0x800269C0                  // play fgm
        lli     a0, 45                      // fgm id = 45
        jal     0x800269C0                  // play fgm
        lli     a0, 220                     // fgm id = 220

        _end:
        lw      a0, 0x0018(sp)              // ~
        lw      a0, 0x0084(a0)              // a0 = player struct
        sw      r0, 0x017C(a0)              // temp variable 1 = 0
        sw      r0, 0x0180(a0)              // temp variable 2 = 0
        sw      r0, 0x0184(a0)              // temp variable 3 = 0
        OS.routine_end(0x30)
    }

    // @ Description
    // Main subroutine for DSPBegin.
    // Transitions to DSPWait on animation end.
    scope begin_main_: {
        addiu   sp, sp,-0x0030              // allocate stack space
        sw      ra, 0x0024(sp)              // store ra

        jal     dig_graphic_update_         // update dig graphic
        sw      a0, 0x0018(sp)              // 0x0018(sp) = player object

        lw      a0, 0x0018(sp)              // a0 = player object
        // checks the current animation frame to see if we've reached end of the animation
        mtc1    r0, f6                      // ~
        lwc1    f8, 0x0078(a0)              // ~
        c.le.s  f8, f6                      // ~
        nop
        bc1fl   _end                        // skip if animation end has not been reached
        nop

        // transition to DSPWait if the animation has ended
        lw      a1, 0x0084(a0)              // a1 = player struct
        lli     at, MAX_TIME                // at = MAX_TIME
        jal     wait_initial_               // begin DSPWait
        sw      at, 0x0B18(a1)              // DSPWait timer = MAX_TIME

        _end:
        lw      ra, 0x0024(sp)              // load ra
        jr      ra                          // return
        addiu   sp, sp, 0x0030              // deallocate stack space
    }

    // @ Description
    // Main function for DSPWait.
    scope wait_main_: {
        addiu   sp, sp,-0x0030              // allocate stack space
        sw      ra, 0x0014(sp)              // store ra

        jal     dig_graphic_update_         // update dig graphic
        sw      a0, 0x0018(sp)              // 0x0018(sp) = player object

        jal     dig_update_                 // check for gfx/sfx
        lw      a0, 0x0018(sp)              // a0 = player object

        lw      a0, 0x0018(sp)              // a0 = player object
        lw      v1, 0x0084(a0)              // v1 = player struct

        _update_timer:
        lw      at, 0x0B18(v1)              // at = timer
        addiu   at, at, -1                  // decrement timer by 1
        beqz    at, _begin_attack           // end down special if timer has expired
        sw      at, 0x0B18(v1)              // store updated timer

        _check_attack:
        lh      t7, 0x01BC(v1)              // t7 = buttons_held
        andi    t7, t7, Joypad.B            // t7 = 0x0020 if (B_HELD); else t7 = 0
        bnez    t7, _check_turn             // skip if (B_HELD)
        nop

        // if the B button isn't held or the timer expires
        _begin_attack:
        jal     end_initial_                // transition to DSPEnd
        lli     a1, OS.FALSE                // bool slide-off = FALSE
        b       _end                        // end
        nop

        _check_turn:
        lb      t6, 0x01C2(v1)              // t6 = stick_x
        bltzl   t6, pc() + 8                // if stick_x is negative...
        subu    t6, r0, t6                  // ...make stick_x positive
        slti    at, t6, 11                  // at = 1 if |stick_x| < 11, else at = 0
        bnez    at, _end                    // branch if |stick_x| < 11
        lb      t6, 0x01C2(v1)              // t6 = stick_x

        // if |stick_x| >= 10
        lui     at, 0x8000                  // at = sign bitmask
        and     t6, t6, at                  // t6 = stick_x sign
        lw      t7, 0x0044(v1)              // t7 = DIRECTION
        and     t7, t7, at                  // t7 = DIRECTION sign
        beq     t6, t7, _end                // end if DIRECTION and stick_x signs match
        nop

        // if the signs of DIRECTION and stick_x don't match, begin a turn
        _begin_turn:
        jal     turn_intial_                // transition to DSPTurn
        nop

        _end:
        lw      ra, 0x0014(sp)              // load ra
        jr      ra                          // return
        addiu   sp, sp, 0x0030              // deallocate stack space
    }

    // @ Description
    // Main function for DSPTurn.
    scope turn_main_: {
        addiu   sp, sp,-0x0030              // allocate stack space
        sw      ra, 0x0014(sp)              // store ra

        jal     dig_graphic_update_         // update dig graphic
        sw      a0, 0x0018(sp)              // 0x0018(sp) = player object

        jal     dig_update_                 // check for gfx/sfx
        lw      a0, 0x0018(sp)              // a0 = player object

        lw      a0, 0x0018(sp)              // a0 = player object
        lw      v1, 0x0084(a0)              // v1 = player struct
        lw      at, 0x0180(v1)              // at = temp variable 2
        beqz    at, _update_timer           // branch if temp variable 2 not set
        lw      at, 0x0044(v1)              // at = DIRECTION

        // if temp variable 2 is set
        subu    at, r0, at                  // ~
        sw      at, 0x0044(v1)              // reverse and update DIRECTION
        sw      r0, 0x0180(v1)              // reset temp variable 2

        _update_timer:
        lw      at, 0x0B18(v1)              // at = timer
        addiu   at, at, -1                  // decrement timer by 1
        beqz    at, _begin_attack           // end down special if timer has expired
        sw      at, 0x0B18(v1)              // store updated timer

        _check_attack:
        lh      t7, 0x01BC(v1)              // t7 = buttons_held
        andi    t7, t7, Joypad.B            // t7 = 0x0020 if (B_HELD); else t7 = 0
        bnez    t7, _check_ending           // skip if (B_HELD)
        nop

        // if the B button isn't held or the timer expires
        _begin_attack:
        jal     end_initial_                // transition to DSPEnd
        lli     a1, OS.FALSE                // bool slide-off = FALSE
        b       _end                        // end
        nop

        // checks the current animation frame to see if we've reached end of the animation
        _check_ending:
        mtc1    r0, f6                      // ~
        lwc1    f8, 0x0078(a0)              // ~
        c.le.s  f8, f6                      // ~
        bc1fl   _end                        // skip if animation end has not been reached
        nop

        jal     wait_initial_               // transition to DSPWait
        nop

        _end:
        lw      ra, 0x0014(sp)              // load ra
        jr      ra                          // return
        addiu   sp, sp, 0x0030              // deallocate stack space
    }

    // @ Description
    // Main function for DSPDive
    scope dive_main_: {
        OS.routine_begin(0x30)

        lw      a0, 0x0084(a0)              // a0 = player struct
        lw      at, 0x0180(a0)              // at = temp variable 2
        beqz    at, _end                    // branch if temp variable 2 not set
        nop

        // if temp variable 2 was set
        lw      at, 0x00EC(a0)              // ~
        sw      at, 0x0144(a0)              // update clipping related thing(?)
        lui     at, DIVE_Y_SPEED            // ~
        jal     0x800DEEC8                  // set aerial state
        sw      at, 0x004C(a0)              // y velocity = DIVE_Y_SPEED


        _end:
        OS.routine_end(0x30)
    }

    // @ Description
    // Handles movement for DSP
    scope physics_: {
        OS.routine_begin(0x40)
        sw      a0, 0x0020(sp)              // ~
        sw      s0, 0x0024(sp)              // store a0, s0
        lw      s0, 0x0084(a0)              // s0 = player struct
        lui     at, ACCELERATION            // ~
        mtc1    at, f12                     // f12 = ACCELERATION

        _check_movement:
        lb      t6, 0x01C2(s0)              // t6 = stick_x
        bltzl   t6, pc() + 8                // if stick_x is negative...
        subu    t6, r0, t6                  // ...make stick_x positive
        slti    at, t6, 11                  // at = 1 if |stick_x| < 11, else at = 0
        beqz    at, _check_stick            // branch if |stick_x| >= 10
        nop

        _check_min_speed:
        // if we're here then stick_x is < 11, so consider the stick neutral
        lwc1    f4, 0x0048(s0)              // ~
        abs.s   f4, f4                      // f4 = absolute x velocity
        lui     at, MIN_SPEED               // ~
        mtc1    at, f6                      // f6 = MIN_SPEED
        c.le.s  f4, f6                      // ~
        bc1fl   _move_timer                 // apply movement if current speed < MIN_SPEED...
        mtc1    r0, f2                      // ...and target x velocity = 0
        // set velocity to 0 if below minimum speed
        addiu   at, r0, -1                  // ~
        sw      at, 0x0B20(s0)              // move timer offset = -1
        b       _end                        // end
        sw      r0, 0x0048(s0)              // x velocity = 0

        _check_stick:
        lui     at, G_SPEED_MULTIPLIER      // ~
        mtc1    at, f0                      // f0 = G_SPEED_MULTIPLIER
        lb      at, 0x01C2(s0)              // ~
        mtc1    at, f2                      // ~
        cvt.s.w f2, f2                      // f2 = stick_x
        mul.s   f2, f2, f0                  // f2 = target x velocity = stick_x * SPEED_MULTIPLIER

        _move_timer:
        lw      at, 0x0B20(s0)              // at = move timer offset
        bgez    at, _apply_movement         // branch if move timer offset >= 0
        nop

        // if we're here then crash just started moving, so set the move timer offset
        lw      at, 0x0B18(s0)              // at = dsp timer
        andi    at, at, 0x001F              // at = timer % 32
        sw      at, 0x0B20(s0)              // move timer offset = timer % 32

        _apply_movement:
        lwc1    f4, 0x0048(s0)              // f4 = x velocity
        sub.s   f6, f2, f4                  // f6 = X_DIFF
        abs.s   f8, f6                      // f8 = |X_DIFF|
        lui     at, 0x4000                  // ~
        mtc1    at, f10                     // f10 = 2
        c.le.s  f10, f8                     // ~
        mfc1    t6, f6                      // t6 = X_DIFF
        bc1fl   _set_velocity               // branch if |X_DIFF| < 2...
        mov.s   f2, f4                      // ...and set x velocity to target velocity

        lui     t7, 0x8000                  // ~
        and     t6, t6, t7                  // t6 = sign of X_DIFF
        beql    t6, r0, _set_velocity       // branch if X_DIFF is positive...
        add.s   f4, f4, f12                 // and add ACCELERATION to x velocity
        sub.s   f4, f4, f12                 // subtract ACCELERATION from x velocity

        _set_velocity:
        lui     at, MAX_SPEED               // ~
        mtc1    at, f6                      // f6 = MAX_SPEED
        abs.s   f8, f4                      // f8 |X_VELOCITY|
        mfc1    t6, f4                      // t6 = X_VELOCITY
        lui     t7, 0x8000                  // ~
        and     t6, t6, t7                  // t6 = sign of X_VELOCITY
        c.le.s  f8, f6                      // ~
        or      at, at, t6                  // at = MAX_SPEED, adjusted
        bc1fl   pc() + 8                    // if MAX_SPEED =< X_VELOCITY...
        mtc1    at, f4                      // X_VELOCITY = MAX_SPEED
        swc1    f4, 0x0048(s0)              // store updated x velocity
        lwc1    f6, 0x0044(s0)              // ~
        cvt.s.w f6, f6                      // f6 = DIRECTION
        mul.s   f4, f4, f6                  // f4 = X_VELOCITY * DIRECTION
        swc1    f4, 0x0060(s0)              // ground x velocity = X_VELOCITY * DIRECTION

        _end:
        OS.routine_end(0x40)
    }

    // @ Description
    // Handles movement for DSPDive
    scope dive_physics_: {
        OS.routine_begin(0x40)

        lw      v1, 0x0084(a0)              // v1 = player struct
        lw      at, 0x014C(v1)              // at = kinetic state
        beqz    at, _end                    // branch if kinetic state = grounded
        nop

        // if kinetic state = aerial
        jal     dive_air_physics_           // dive air physics
        nop

        _end:
        OS.routine_end(0x40)
    }

    // @ Description
    // Aerial movement subroutine for DSPAirDive
    // Modified version of subroutine 0x800D90E0.
    scope dive_air_physics_: {
        // Copy the first 8 lines of subroutine 0x800D90E0
        OS.copy_segment(0x548E0, 0x20)

        // Skip 7 lines (fast fall branch logic)

        // jal 0x800D8E50                   // ~
        // or a1, s1, r0                    // original 2 lines call gravity subroutine
        lui     a1, DIVE_GRAVITY            // a1 = DIVE_GRAVITY
        lw      t6, 0x0180(s0)              // t6 = temp variable 2
        bnezl   t6, _apply_gravity          // branch if temp variable 2 is set...
        lui     a1, DIVE_GRAVITY_2          // ...and a1 = DIVE_GRAVITY_2

        _apply_gravity:
        jal     0x800D8D68                  // apply gravity/fall speed
        lui     a2, DIVE_FALL_SPEED         // a1 = DIVE_FALL_SPEED

        // Copy the next 8 lines of subroutine 0x800D90E0
        OS.copy_segment(0x54924, 0x20)
        // jal 0x800D9074                   // original line calls air friction subroutine
        jal     air_dive_friction_          // call custom wrapped subroutine instead
        // Copy the last 6 lines of subroutine 0x800D90E0
        OS.copy_segment(0x54948, 0x18)
    }

    scope air_dive_friction_: {
        OS.routine_begin(0x80)
        // use sp as fake attribute pointer for custom air friction
        lui     at, DIVE_AIR_FRICTION       // ~
        sw      at, 0x0054(sp)              // 0x0054(sp) = DIVE_AIR_FRICTION
        jal     0x800D9074                  // air friction function
        or      a1, sp, r0                  // a1 = sp
        OS.routine_end(0x80)
    }

    // @ Description
    // Collision for DSPBegin and DSPWait
    scope collision_: {
        OS.routine_begin(0x18)
        li      a1, slide_off_end_initial_  // a1(transition subroutine) = slide_off_end_initial_
        jal     0x800DDDDC                  // common ground collision subroutine (transition on no floor, slide-off)
        nop
        OS.routine_end(0x18)
    }

    // @ Description
    // Collision for DSPDive
    scope dive_collision_: {
        OS.routine_begin(0x18)

        lw      a1, 0x0084(a0)              // a1 = player struct
        lw      at, 0x014C(a1)              // at = kinetic state
        bnez    at, _aerial                 // branch if kinetic state != grounded
        nop

        _grounded:
        jal     0x800DDF44                  // common ground collision subroutine
        nop
        b       _end
        nop

        _aerial:
        li      a1, begin_initial_from_dive_ // a1(transition subroutine) = begin_initial_from_dive_
        jal     0x800DE6E4                  // common air collision subroutine (transition on landing, no ledge grab)
        nop


        _end:
        OS.routine_end(0x18)
    }

    // @ Description
    // This function is responsible for creating the Dig GFX object.
    // Based on 0x80103378 which creates the Up Special GFX for Link.
    scope create_dig_gfx_: {
        OS.routine_begin(0x18)
        or      a2, a0, r0                  // a2 = player object
        li      a0, dig_gfx_struct          // a0 = dig_gfx_struct
        li      t6, Character.CRASH_file_7_ptr
        lw      t6, 0x0000(t6)              // ~
        addiu   t6, t6, 0x0CC0              // ~
        sw      t6, 0x0004(a0)              // update Dig GFX file pointer
        jal     0x800FDAFC                  // create attached gfx
        sw      a2, 0x0018(sp)              // 0x0018(sp) = player object
        beqz    v0, _end                    // skip if no gfx object was created
        lw      a2, 0x0018(sp)              // a2 = player object
        lw      a0, 0x0084(v0)              // a0 = gfx special struct
        sw      a2, 0x0004(a0)              // set owner as player?
        lw      v1, 0x0084(a2)              // v1 = player struct
        lw      a1, 0x0074(v0)              // a1 = gfx topjoint struct
        lw      t8, 0x08E8(v1)              // t8 = player topjoint struct
        sw      t8, 0x0084(a1)              // attach gfx to player topjoint
        lw      at, 0x0034(t8)              // ~
        sw      at, 0x0034(a1)              // copy player topjoint rotation

        _end:
        OS.routine_end(0x18)
    }

    // Additional shared setup subroutine for the Dig GFX.
    // a0 = player struct
    // v0 = gfx object
    scope setup_dig_gfx_: {
        // enable a bitflag in the player struct to indicate a GFX object is attached to the player
        lbu     at, 0x018F(a0)              // ~
        ori     at, at, 0x0010              // ~
        sb      at, 0x018F(a0)              // enable bitflag for attached GFX

        // Change render type of first joint so we can scale it
        lw      at, 0x0074(v0)              // at = top joint of GFX object
        lw      at, 0x005C(at)              // at = struct with render type
        lli     a0, 0x001C                  // a0 = render type that scales
        sb      a0, 0x0004(at)              // update render type

        jr      ra                          // return
        nop
    }

    // Handles UV scroll and angle for the Dig GFX.
    // a0 - player object
    scope dig_graphic_update_: {
        OS.routine_begin(0x20)
        sw      a0, 0x0018(sp)              // 0x0018(sp) = player object
        jal     0x80161478                  // f0 = slope angle
        lw      a0, 0x0084(a0)              // a0 = player struct
        lw      a0, 0x0018(sp)              // a0 = player object
        lw      a1, 0x0084(a0)              // a1 = player struct
        lw      t6, 0x0B1C(a1)              // t6 = referenced GFX object
        beqz    t6, _skip                   // skip if no referenced GFX object
        nop
        lw      t6, 0x0074(t6)              // t6 = gfx object part 0 (root) struct
        swc1    f0, 0x0038(t6)              // gfx y rotation = slope angle
        lw      t6, 0x0010(t6)              // t6 = part 1 (top) struct
        lw      t6, 0x0080(t6)              // t1 = part 1 special image struct

        lwc1    f2, 0x0048(a1)              // a2 = x velocity
        abs.s   f2, f2                      // a2 = |x velocity|
        lui     at, 0x3B40                  // ~
        mtc1    at, f4                      // f4 = 0.0029
        mul.s   f2, f2, f4                  // f2 = |x velocity| * 0.0029
        lwc1    f4, 0x0020(t6)              // f4 = texture y scroll
        sub.s   f4, f4, f2                  // f4 = texture y scroll - (|x velocity| * 0.00125)
        swc1    f4, 0x0020(t6)              // store updated y scroll

        _skip:
        OS.routine_end(0x20)
    }

    // Handles GFX and SFX for Dig
    // a0 - player object
    scope dig_update_: {
        OS.routine_begin(0x40)

        lw      a1, 0x0084(a0)              // a1 = player struct
        lw      t6, 0x0B1C(a1)              // t6 = referenced GFX object
        beqz    t6, _skip                   // skip if no referenced GFX object
        sw      a1, 0x0018(sp)              // 0x0018(sp) = player struct
        lw      at, 0x0048(a1)              // at = x velocity
        beqz    at, _skip                   // skip if no x velocity
        nop
        lw      at, 0x0B18(a1)              // at = dsp timer
        lw      t6, 0x0B20(a1)              // at = move timer offset
        subu    t6, at, t6                  // t6 = dsp timer - move timer offset
        andi    at, t6, 0x000F              // at = timer % 16
        bnez    at, _skip                   // skip if timer % 16 != 0
        sw      t6, 0x001C(sp)              // 0x001C(sp) = timer

        // if we're here, create a smoke particle
        lw		a0, 0x0078(a1)              // a0 = player x/y/z
        lwc1    f2, 0x0000(a0)              // f2 = x position
        lwc1    f4, 0x0044(a1)              // ~
        cvt.s.w f4, f4                      // f4 = DIRECTION
        lui     at, 0x430C                  // ~
        mtc1    at, f6                      // ~
        mul.s   f4, f4, f6                  // f4 = DIRECTION * 140
        sub.s   f2, f2, f4                  // f2 = x pos - DIRECTION * 140
        swc1    f2, 0x0020(sp)              // store x pos
        lw      at, 0x0004(a0)              // ~
        sw      at, 0x0024(sp)              // copy y pos
        sw      r0, 0x0028(sp)              // z pos = 0
        addiu   a0, sp, 0x0020              // a0 = x/y/z coordinates for gfx
        lui		a2, 0x3F80
        jal     0x800FF048                  // create gfx
        lw      a1, 0x0044(a1)              // a1 = DIRECTION

        lw      at, 0x001C(sp)              // at = timer
        andi    at, at, 0x001F              // at = timer % 32
        bnez    at, _skip                   // skip if timer % 32 != 0
        nop
        // play a sound and rumble half as frequently
        jal     0x800269C0                  // play fgm
        lli     a0, 132                     // fgm id = 132
        lw      a0, 0x0018(sp)              // ~
        lbu     a0, 0x000D(a0)              // a0 = port
        lli     a1, 0x0000                  // a1 = rumble_id
        lli     a2, 0x001E                  // a2 = duration
        jal     Global.rumble_              // add rumble
        addiu   sp, sp, -0x0030             // allocate stack space (not a safe function)
        addiu   sp, sp, 0x0030              // deallocate stack space

        _skip:
        OS.routine_end(0x40)
    }

    // @ Description
    // Main function for Dig graphic, based on 0x800FD568
    // a0 - gfx object
    scope dig_gfx_main_: {
        OS.routine_begin(0x40)

        lw      v0, 0x0084(a0)              // ~
        or      a1, a0, r0                  // ~
        lw      t6, 0x0010(v0)              // ~
        srl     t7, t6, 31                  // ~
        bnezl   t7, _end                    // ~
        nop                                 // ~
        jal     0x8000DF34                  // ~
        sw      a1, 0x0018(sp)              // ~

        // handle scale
        lw      a1, 0x0018(sp)              // a1 = effect object
        lw      t3, 0x0084(a1)              // t3 = effect struct
        lw      t4, 0x0004(t3)              // t4 = player object
        lw      t3, 0x0084(t4)              // t3 = player struct
        li      t8, Size.multiplier_table
        lbu     t7, 0x000D(t3)              // t7 = port
        sll     t7, t7, 0x0002              // t7 = port * 4 = offset to multiplier
        addu    t8, t8, t7                  // t8 = size multiplier address
        lw      t8, 0x0000(t8)              // t8 = size multiplier
        lw      t3, 0x0074(t4)              // t3 = position struct top joint
        sw      t8, 0x0040(t3)              // update x scale
        sw      t8, 0x0044(t3)              // update y scale
        sw      t8, 0x0048(t3)              // update z scale

        mtc1    r0, f4                      // ~
        lwc1    f6, 0x0078(a1)              // ~
        c.le.s  f6, f4                      // ~
        nop                                 // ~
        bc1fl   _end                        // original logic
        nop

        // when the object is destroyed
        lw      a0, 0x0018(sp)              // ~
        lw      a1, 0x004C(a0)              // ~
        sw      a1, 0x001C(sp)              // copy x position
        lwc1    f2, 0x0050(a0)              // f2 = y position
        lui     a1, 0xC2A0                  // ~
        mtc1    a1, f4                      // f4 = -80
        add.s   f2, f2, f4                  // f4 = y pos - 80
        swc1    f2, 0x0020(sp)              // store offset y position
        sw      r0, 0x0024(sp)              // z position = 0
        addiu   a0, sp, 0x001C              // a0 = x/y/z coordinates
        ori     a1, r0, 0x0001              // a1 = 0x1
        jal     0x800FF3F4                  // jump smoke graphic
        lui     a2, 0x3F80                  // a2 = float: 1.0
        // addiu   a0, a0, 0x001C              // a0 = x/y/z coordinates
        // jal     0x800FF648                  // smoke gfx
        // lui		a1, 0x3F80
        lw      a1, 0x0018(sp)              // ~
        lw      a0, 0x0084(a1)              // ~
        jal     0x800FD4F8                  // ~
        sw      a1, 0x0018(sp)              // ~
        jal     0x80009A84                  // ~
        lw      a0, 0x0018(sp)              // ~
        lw      ra, 0x0014(sp)              // original logic

        _end:
        OS.routine_end(0x40)
    }

    // @ Description
    // Patch which forces a different ECB size during Dig actions.
    dig_ecb_patch_: {
        // TODO: Crash's default ECB size is hard coded here, make sure it matches his main file
        constant DEFAULT_UPPER(0x43A0)      // float32 320
        constant DEFAULT_MIDDLE(0x433E)     // float32 190
        constant DIG_UPPER(0x4316)          // float32 150
        constant DIG_MIDDLE(0x42A0)         // float32 80

        OS.patch_start(0x6274C, 0x800E6F4C)
        j       dig_ecb_patch_
        lw      t7, 0x09C8(s1)              // original line 1 (t7 = attribute pointer)
        _return:
        OS.patch_end()

        // s1 = player struct
        lw      t0, 0x0008(s1)              // t0 = character id
        lli     t2, Character.id.CRASH      // t2 = id.CRASH
        bne     t0, t2, _end                // skip if character id != Crash
        sw      r0, 0x0080(sp)              // original line 2

        // if the character is Crash set the ECB size
        lw      t0, 0x0094(sp)              // t0 = action we're changing to
        lli     t2, Crash.Action.DSPWait    // ~
        beq     t0, t2, _dig                // branch if action = DSPWait
        lli     t2, Crash.Action.DSPTurn    // ~
        bnel    t0, t2, _normal             // if action != DSPTurn, load normal ECB size
        lui     t0, DEFAULT_UPPER           // t0 = DEFAULT_UPPER

        _dig:
        lui     t0, DIG_UPPER               // ~
        sw      t0, 0x009C(t7)              // ecb upper = DIG_UPPER
        lui     t0, DIG_MIDDLE              // ~
        b       _end                        // end
        sw      t0, 0x00A0(t7)              // ecb middle = DIG_MIDDLE

        _normal:
        sw      t0, 0x009C(t7)              // ecb upper = DEFAULT_UPPER
        lui     t0, DEFAULT_MIDDLE          // ~
        sw      t0, 0x00A0(t7)              // ecb middle = DEFAULT_MIDDLE

        _end:
        j       _return                     // return
        nop
    }

    // @ Description
    // GFX struct for Dig GFX, based on Link's Up special graphic which is at 0xA9E2C in the base ROM.
    dig_gfx_struct:
    dw 0x060F0000
    dw 0                                    // will hold file pointer
    dw 0x501A001C
    dw 0
    dw dig_gfx_main_
    dw 0x80014768
    // these need to be update with the GFX, 0xA9E44 in the base ROM
    dw 0x00000230
    dw 0x00000340
    dw 0x00000378
    dw 0x00000394

    // @ Description
    // Animation tracks for additional Dig GFX animations
    track_dig_turn:; insert "track_dig_turn.bin"
    track_dig_wait:; insert "track_dig_wait.bin"
    track_dig_end:; insert "track_dig_end.bin"
}