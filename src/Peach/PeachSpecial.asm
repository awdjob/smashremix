// PeachSpecial.asm

// This file contains subroutines used by Princess Peach's special moves.

scope PeachFloat {
    constant TIMER(150)
    constant INIT_Y_VELOCITY(0x41C0)        // float32 24

    // @ Description
    // Initial function for Float.
    scope initial_: {
        addiu   sp, sp,-0x0030              // allocate stack space
        sw      ra, 0x001C(sp)              // ~
        sw      a0, 0x0020(sp)              // store a0, ra
        lli     a1, Peach.Action.Float      // a1(action id) = Float
        or      a2, r0, r0                  // a2(starting frame) = 0
        lui     a3, 0x3F80                  // a3(frame speed multiplier) = 1.0
        jal     0x800E6F24                  // change action
        sw      r0, 0x0010(sp)              // argument 4 = 0
        lw      a0, 0x0020(sp)              // ~
        lw      a0, 0x0084(a0)              // a0 = player struct
        lui     at, 0x3E80                  // ~
        mtc1    at, f2                      // f2 = 0.375
        lwc1    f4, 0x004C(a0)              // f4 = y velocity
        mul.s   f2, f2, f4                  // f2 = y velocity * 0.375
        lui     at, INIT_Y_VELOCITY         // ~
        mtc1    at, f4                      // f4 = INIT_Y_VELOCITY
        add.s   f2, f2, f4                  // f2 = (y velocity * 0.375) + INIT_Y_VELOCITY
        swc1    f2, 0x004C(a0)              // set initial y velocity
        lw      ra, 0x001C(sp)              // load ra
        jr      ra                          // return
        addiu   sp, sp, 0x0030              // deallocate stack space
    }

    // @ Description
    // Main function for Float.
    scope main_: {
        OS.routine_begin(0x20)

        lw      v1, 0x0084(a0)              // v1 = player struct
        lw      t6, 0x0ADC(v1)              // t6 = float timer
        lli     at, 0x0001                  // at = 1
        bne     at, t6, _end                // skip if float timer != 1
        nop

        // if float timer = 1, transition to fall
        jal     0x8013F9E0                  // transition to fall
        nop

        _end:
        OS.routine_end(0x20)
    }

    // @ Description
    // Interrupt function for Float.
    scope interrupt_: {
        OS.routine_begin(0x20)

        jal     0x80150F08                  // check for B inputs
        sw      a0, 0x0018(sp)              // 0x0018(sp) = player object
        bnez    v0, _end                    // end if action change occurred
        lw      a0, 0x0018(sp)              // a0 = player object
        jal     0x80150B00                  // check for A inputs
        lw      a0, 0x0018(sp)              // a0 = player object
        beqz    v0, _skip                   // skip if no action change occurred
        lw      a0, 0x0018(sp)              // a0 = player object

        _end:
        lw      a0, 0x0084(a0)              // a0 = player struct
        lw      t6, 0x0024(a0)              // t6 = current action
        // if Peach is doing an aerial attack, allow her to continue floating
        sltiu   at, t6, Action.AttackAirN   // at = 1 if action id < Action.AttackAirN
        bnez    at, _end_float              // branch if action id < Action.AttackAirN
        sltiu   at, t6, Action.AttackAirD + 1  // at = 1 if action id =< Action.AttackAirD
        bnez    at, _skip                   // skip if action id =< Action.AttackAirD
        lli     at, 0x0001

        _end_float:
        // if we're here, Peach has changed actions but not to an Aerial, so end float
        sw      at, 0x0ADC(a0)              // float timer = 1 (peach has been fully floated out)

        _skip:
        OS.routine_end(0x20)
    }

    // Patch which handles the physics and timer for float.
    scope handle_physics_: {
        OS.patch_start(0x54568, 0x800D8D68)
        j       handle_physics_
        mtc1    a1, f12                     // original line 1
        _return:
        OS.patch_end()

        lw      t6, 0x0008(a0)              // t6 = character id
        lli     at, Character.id.NPEACH     // at = id.NPEACH
        beq     at, t6, _peach              // branch if poly peach
        lli     at, Character.id.PEACH      // at = id.PEACH
        bne     t6, at, _end                // skip if character != PEACH
        nop

        // if character is Peach
        _peach:
        lw      t6, 0x0ADC(a0)              // t6 = float timer
        addiu   t7, t6,-0x0001              // t7 = float timer, decremented
        beqz    t6, _end                    // skip if float timer = 0 (peach hasn't floated yet)
        lli     at, TIMER                   // ~
        beql    t6, at, _end                // skip if float timer = TIMER (first frame of float)...
        sw      t7, 0x0ADC(a0)              // ...and store decremented float timer
        lli     at, 0x0001                  // ~
        beq     t6, at, _end                // skip if float timer = 1 (float has been used)
        lh      t6, 0x01BC(a0)              // t6 = buttons_held

        // if float timer is not equal to 0 or 1, decrement float timer and set y speed to 0
        sw      t7, 0x0ADC(a0)              // store decremented float timer
        // apply a bitmask to see if peach should continue floating
        andi    t6, t6, Joypad.CU | Joypad.CD | Joypad.CL | Joypad.CR
        // t6 = 0 if no jump button is held, else t6 !=0
        beqzl   t6, _end                    // branch to end if no jump button is being held...
        sw      at, 0x0ADC(a0)              // ...and float timer = 1 (peach has been fully floated out)

        jr      ra                          // end gravity function early
        sw      r0, 0x004C(a0)              // set y speed to 0

        _end:
        j       _return                     // return
        lwc1    f4, 0x004C(a0)              // original line 2
    }

    // Patch which handles starting a float.
    scope check_float_: {
        // Jump 1
        OS.patch_start(0xBA0C8, 0x8013F688)
        jal     check_float_
        lw      a0, 0x0018(sp)              // original line 2
        OS.patch_end()
        // Jump 2
        OS.patch_start(0xBA594, 0x8013FB54)
        jal     check_float_
        lw      a0, 0x0018(sp)              // original line 2
        OS.patch_end()
        // Falling
        OS.patch_start(0xBA408, 0x8013F9C8)
        jal     check_float_
        lw      a0, 0x0018(sp)              // original line 2
        OS.patch_end()
        // Platform Drop
        OS.patch_start(0xBC7C8, 0x80141D88)
        jal     check_float_
        lw      a0, 0x0018(sp)              // original line 2
        OS.patch_end()
        // // Tumble
        // OS.patch_start(0xBDFC8, 0x80143588)
        // jal     check_float_
        // lw      a0, 0x0018(sp)              // original line 2
        // OS.patch_end()

        OS.routine_begin(0x20)
        lw      v0, 0x0084(a0)              // v0 = player struct
        lw      t6, 0x0008(v0)              // t6 = character id
        lli     at, Character.id.NPEACH     // at = id.NPEACH
        beq     at, t6, _peach              // branch if poly peach
        lli     at, Character.id.PEACH      // at = id.PEACH
        bne     t6, at, _end                // skip if character != PEACH
        nop

        // if the character is Peach
        _peach:
        lw      t6, 0x0ADC(v0)              // t6 = float timer
        bnez    t6, _end                    // skip if float timer != 0 (peach has already started a float)
        nop

        // if a float hasn't been started
        lh      t6, 0x01BC(v0)              // t6 = buttons_held
        // apply a bitmask to see if peach should continue floating
        andi    t6, t6, Joypad.CU | Joypad.CD | Joypad.CL | Joypad.CR
        // t6 = 0 if no jump button is held, else t6 !=0
        beqz    t6, _end                    // branch to end if no jump button is being held
        lb      t6, 0x01C3(v0)              // t6 = stick_y
        slti    at, t6, -39                 // at = 1 if stick_y < -39, else at = 0
        bnez    at, _begin_float            // start a float now if stick_y < -39
        nop

        // if the stick isn't being held down, make sure Peach isn't trying to start a double jump
        lw      at, 0x09C8(v0)              // at = attribute pointer
        lw      at, 0x0064(at)              // at = max jumps
        lbu     t0, 0x0148(v0)              // t0 = jumps used
        beq     at, t0, _check_velocity     // if jumps used = max jumps then run velocity check
        nop

        // if Peach still has her double jump, check if a jump button is pressed, and if so skip starting Float
        lh      t6, 0x01BE(v0)              // t6 = buttons_pressed
        // apply a bitmask to see if peach should continue floating
        andi    t6, t6, Joypad.CU | Joypad.CD | Joypad.CL | Joypad.CR
        // t6 = 0 if no jump button is pressed, else t6 !=0
        bnez    t6, _end                    // branch to end if a jump button was pressed this frame
        nop

        // check if Peach's y velocity is below 0 to start a float
        _check_velocity:
        mtc1    r0, f0                      // f0 = 0
        lwc1    f2, 0x004C(v0)              // f2 = y velocity
        c.le.s  f2, f0                      // ~
        nop
        bc1fl   _end                        // skip if y velocity is above 0
        nop

        // don't always float here during double jump
        _check_double_jump:
        lw      t6, 0x0024(v0)              // t6 = current action
        lli     at, Action.JumpAerialF      // ~
        beq     t6, at, _double_jump        // branch if action = JumpAerialF
        lli     at, Action.JumpAerialB      // ~
        bne     t6, at, _begin_float        // skip if action != JumpAerialB
        nop

        // don't start float during the beginning of double jump
        _double_jump:
        lui     at, 0x41A0                  // at = 20.0
        mtc1    at, f6                      // ~
        lwc1    f8, 0x0078(a0)              // ~
        c.le.s  f8, f6                      // ~
        nop
        bc1tl   _end                        // skip if haven't reached frame 20
        nop

        _begin_float:
        lli     at, TIMER                   // ~
        jal     initial_                    // start float
        sw      at, 0x0ADC(v0)              // set initial float timer value
        lli     v0, 0x0001                  // return 1
        OS.routine_end(0x20)

        _end:
        jal     0x8014019C                  // original line 1
        nop
        OS.routine_end(0x20)
    }

    // Patch which handles changing to the float action instead of fall.
    scope fall_override_: {
        OS.patch_start(0xBA494, 0x8013FA54)
        jal     fall_override_
        nop
        OS.patch_end()

        OS.routine_begin(0x20)
        lw      v0, 0x0084(a0)              // v0 = player struct
        lw      t6, 0x0008(v0)              // t6 = character id
        lli     at, Character.id.NPEACH     // at = id.NPEACH
        beq     at, t6, _peach              // branch if poly peach
        lli     at, Character.id.PEACH      // at = id.PEACH
        bne     t6, at, _end                // skip if character != PEACH
        nop
        
        _peach:
        // if the character is Peach
        lw      t6, 0x0ADC(v0)              // t6 = float timer
        beqz    t6, _end                    // skip if float timer = 0 (peach hasn't started a float yet)
        lli     at, 0x0001                  // at = 1
        beq     t6, at, _end                // skip if float timer = 1 (float has been used)
        nop

        // if float is being used
        lh      t6, 0x01BC(v0)              // t6 = buttons_held
        // apply a bitmask to see if peach should continue floating
        andi    t6, t6, Joypad.CU | Joypad.CD | Joypad.CL | Joypad.CR
        // t6 = 0 if no jump button is held, else t6 !=0
        beqz    t6, _end                    // branch to end if no jump button is being held
        nop

        // if a jump button is being held, transition to float
        jal     initial_                    // start float action
        nop
        OS.routine_end(0x20)

        _end:
        jal     0x800E6F24                  // original line 1
        sw      t0, 0x0010(sp)              // original line 2
        OS.routine_end(0x20)
    }

    // Patch which prevents items from being thrown.
    scope prevent_item_throw_: {
        OS.patch_start(0xCB58C, 0x80150B4C)
        jal     prevent_item_throw_
        sw      a3, 0x0040(sp)              // original line 2
        OS.patch_end()

        OS.routine_begin(0x20)
        lw      t6, 0x0008(a0)              // t6 = character id
        lli     at, Character.id.NPEACH     // at = id.NPEACH
        beq     at, t6, _peach              // branch if poly peach
        lli     at, Character.id.PEACH      // at = id.PEACH
        bne     t6, at, _end                // skip if character != PEACH
        nop

        _peach:
        // if the character is Peach
        lw      t6, 0x0ADC(a0)              // t6 = float timer
        beqz    t6, _end                    // skip if float timer = 0 (peach hasn't started a float yet)
        lli     at, 0x0001                  // at = 1
        beq     t6, at, _end                // skip if float timer = 1 (float has been used)
        nop

        // if float is being used
        or      v0, r0, r0                  // return 0 (pretend there's no item to throw)
        OS.routine_end(0x20)

        _end:
        jal     0x80146A8C                  // original line 1
        nop
        OS.routine_end(0x20)
    }

    // Patch which handles "Float Cancelling" (aerial attacks started from float auto cancel)
    scope auto_cancel_aerials_: {
        OS.patch_start(0xCB874, 0x80150E34)
        j       auto_cancel_aerials_
        lw      a1, 0x004C(sp)              // original line 1
        _return:
        OS.patch_end()

        lw      t5, 0x0008(s0)              // t5 = character id
        lli     at, Character.id.NPEACH     // at = id.NPEACH
        beq     t5, at, _peach              // branch if poly peach
        lli     at, Character.id.PEACH      // at = id.PEACH
        bne     t5, at, _end                // skip if character != PEACH
        nop

        _peach:
        // if the character is Peach
        lw      t5, 0x0ADC(s0)              // t5 = float timer
        beqz    t5, _end                    // skip if float timer = 0 (peach hasn't started a float yet)
        lli     at, 0x0001                  // at = 1
        beq     t5, at, _end                // skip if float timer = 1 (float has been used)
        nop

        // if float is being used
        li      at, 0x800DE934              // ~
        sw      at, 0x09E4(s0)              // replace collision function

        _end:
        j       _return                     // return
        addiu   at, r0, 0x00D5              // original line 2
    }

    // @ Description
    // Patch which ends Peach's Float after being hit.
    scope end_float_on_hit_: {
        OS.patch_start(0x63A4C, 0x800E824C)
        j       end_float_on_hit_
        nop
        _return:
        OS.patch_end()

        // a0 = player struct
        lw      t6, 0x0008(a0)              // t6 = character id
        lli     at, Character.id.NPEACH     // at = id.NPEACH
        beql    at, t6, _peach              // branch if poly peach
        lli     at, 0x0001                  // ~
        lli     at, Character.id.PEACH      // at = id.PEACH

        bne     t6, at, _end                // skip if character != Peach
        lli     at, 0x0001                  // ~

        // if the character is Peach
        _peach:
        lw      t6, 0x0ADC(a0)              // t6 = float timer
        bnezl   t6, _end                    // if float timer != 0 (peach has started a float)...
        sw      at, 0x0ADC(a0)              // ...float timer = 1 (end float)

        _end:
        jal     0x800E8138                  // original line 1
        sw      a0, 0x001C(sp)              // 0x001C(sp) = player struct (original line 2)
        j       _return                     // return
        nop
    }
}

scope PeachDSP {

    scope air_initial_: {
        OS.routine_begin(0x20)
        // if here, check if turnip is held. throw item if so.
        lw      v1, 0x0084(a0)
        lw      v0, 0x084C(v1)  // v0 = held item
        beqz    v0, _end        // skip to end if no held item
        nop
        // if here, check if holding a turnip
        lw      v0, 0x0084(v0)  // v0 = item struct
        lw      t0, 0x000C(v0)  // t0 = item id
        addiu   at, r0, Item.Turnip.id
        bne     at, t0, _end    // branch if not a turnip
        nop
        jal     0x80146690  // throw item
        addiu   a1, r0, 0x76    // action id = throw item forward
        _end:
        OS.routine_end(0x20)
    }

    scope ground_initial_: {
        OS.routine_begin(0x20)
        lw      v1, 0x0084(a0)
        sw      r0, 0x017C(v1)  // reset flag
        lw      v0, 0x084C(v1)  // v0 = held item
        bnez    v0, _turnip_check
        nop

        // if here, set action to DSPPull
        Action.change(Peach.Action.DSPPull, -1)
        b       _end
        nop

        _turnip_check:
        // if here, check if turnip is held. throw item if so.
        lw      v0, 0x0084(v0)  // v0 = item struct
        lw      t0, 0x000C(v0)  // t0 = item id
        addiu   at, r0, Item.Turnip.id
        bne     at, t0, _end    // branch if not a turnip
        nop
        jal     0x80146690  // throw item
        addiu   a1, r0, 0x6E    // action id = throw item forward

        _end:
        OS.routine_end(0x20)
    }

    // main routine while peach yanks something from the ground
    scope main: {
        OS.routine_begin(0x20)
        lw      v1, 0x0084(a0)
        lw      v0, 0x017C(v1)  // get flag
        beqz    v0, _check_bingo // skip if flag not set
        sw      a0, 0x001C(sp)  // store player obj

        _spawn_item:
        jal     create_and_assign_item_
        sw      r0, 0x017C(v1)  // reset flag
        b       _end
        nop

        _check_bingo:
        lw      v0, 0x0180(v1)              // get flag
        beqzl   v0, _check_idle             // branch if bingo check flag not ON
        mtc1    r0, f6                      // line 1 of _check_idle below
        sw      r0, 0x0180(v1)              // reset flag
        lw      t0, 0x084C(v1)              // t0 = held item obj
        beqz    t0, _end                     // branch if no held item
        nop
        lw      t1, 0x0084(t0)              // t1 = held item struct
        nop
        lw      t2, 0x000C(t1)              // t2 = item id
        addiu   at, r0, Item.Turnip.id
        bne     t2, at, _end                // branch if not turnip
        nop
        addiu   at, r0, 30                  // Item.Turnip.STITCH_BASE_DAMAGE
        lw      t3, 0x0110(t1)              // t3 = turnip item base damage

        bne     at, t3, _end                // branch if base damage != to STITCH_BASE_DAMAGE
        nop
        FGM.play(0x5D6)                     // play peach saying BINGO
        b       _end
        nop

        _check_idle:
        // checks the current animation frame to see if we've reached end of the animation
        //mtc1    r0, f6                    // f6 = 0.0
        lwc1    f8, 0x0078(a0)              // ~
        c.le.s  f8, f6                      // ~
        nop
        bc1fl   _end                        // skip if animation end has not been reached
        nop
        jal     0x800DEE54                  // transition to idle
        nop

        _end:
        OS.routine_end(0x20)
    }

    // @ Description
    // Creates and assigns the clanpot item to Peach
    // @ Arguments
    // a0 - player object
    scope create_and_assign_item_: {
        addiu   at, r0, 0x0001
        li      t0, Item.skip_item_spawn_gfx_.flag
        sw      at, 0x0000(t0)                      // update override flag to skip showing spawn gfx

        addiu   sp, sp, -0x0010                     // allocate stack space
        sw      ra, 0x0004(sp)                      // save registers
        sw      a0, 0x0008(sp)                      // ~

        addiu   sp, sp, -0x0030                     // allocate stack space (0x8016EA78 is unsafe)
        lw      a1, 0x0074(a0)                      // t1 = location of coordinates (use player position)
        addiu   a1, a1, 0x001C                      // ~
        addiu   a2, sp, 0x0020                      // a2 = address of setup floats
        or      a3, r0, r0                          // a3 = 0
        sw      r0, 0x0000(a2)                      // set up float 1
        sw      r0, 0x0004(a2)                      // set up float 2

        // determine item to pull
        jal     Global.get_random_int_
        addiu   a0, r0, 128
        addiu   at, r0, 127

        bne     at, v0, _turnip
        nop

        // if here, spawn a different item
        jal     Global.get_random_int_
        addiu   a0, r0, 6
        beqz    v0, _beamsword  // 1/6 chance
        slti    at, v0, 3       // at = 0 if spawning "Mr Saturn"
        beqz    at, _saturn     // 3/6 chance
        nop

        _bobomb:
        jal     Item.Bobomb.SPAWN_ITEM              // create item
        sw      r0, 0x0008(a2)                      // set up float 3
        b       _continue                           // continue after item is created
        addiu   sp, sp, 0x0030                      // deallocate stack space

        _turnip:
        jal     Item.Turnip.SPAWN_ITEM              // create item
        sw      r0, 0x0008(a2)                      // set up float 3
        b       _continue                           // continue after item is created
        addiu   sp, sp, 0x0030                      // deallocate stack space

        _saturn:
        jal     Item.MrSaturn.SPAWN_ITEM            // create item
        sw      r0, 0x0008(a2)                      // set up float 3
        b       _continue                           // continue after item is created
        addiu   sp, sp, 0x0030                      // deallocate stack space

        _beamsword:
        jal     Item.BeamSword.SPAWN_ITEM           // create item
        sw      r0, 0x0008(a2)                      // set up float 3
        b       _continue                           // continue after item is created
        addiu   sp, sp, 0x0030                      // deallocate stack space

        _continue:
        beqz    v0, _finish                         // if no item spawned, don't try to assign it!
        or      a0, v0, r0                          // a0 = item object
        lw      a1, 0x0008(sp)                      // a1 = player object
        jal     0x80172CA4                          // initiate item pickup
        addiu   sp, sp, -0x0030                     // allocate stack space (0x80172CA4 is unsafe)
        addiu   sp, sp, 0x0030                      // deallocate stack space

        lw      a0, 0x0008(sp)                      // a0 = player object
        lw      t0, 0x0084(a0)                      // a1 = player struct

        _finish:
        li      t0, Item.skip_item_spawn_gfx_.flag
        sw      r0, 0x0000(t0)                      // clear skip gfx flag

        lw      ra, 0x0004(sp)                      // restore ra
        addiu   sp, sp, 0x0010                      // deallocate stack space

        _end:
        jr      ra
        nop
    }

}

scope PeachUSP {
    // floating point constants for physics and fsm
    constant AIR_Y_SPEED(0x42A4)            // current setting - float32 82
    constant GROUND_Y_SPEED(0x42A8)         // current setting - float32 84
    constant X_SPEED(0x4190)                // current setting - float32 18
    constant FLOAT_GRAVITY(0x3F00)          // current setting - float32 0.5
    constant FLOAT_FALL_SPEED(0x4150)       // current setting - float32 13
    constant AIR_ACCELERATION(0x3C24)       // current setting - float32 0.01
    constant AIR_SPEED(0x41C0)              // current setting - float32 24
    constant LANDING_FSM(0x3EC0)            // current setting - float32 0.375
    // temp variable 3 constants for movement states
    constant BEGIN(0x1)
    constant BEGIN_MOVE(0x2)
    constant MOVE(0x3)
    constant END_MOVE(0x4)

    // @ Description
    // Subroutine which runs when Peach initiates an aerial up special.
    // Changes action, and sets up initial variable values.
    scope air_initial_: {
        addiu   sp, sp,-0x0030              // ~
        sw      ra, 0x001C(sp)              // ~
        sw      a0, 0x0020(sp)              // original lines 1-3
        lli     t6, 0x0020                  // ~
        sw      t6, 0x0010(sp)              // argument 4 = 0x0020 (continue: special model parts)
        lli     a1, Peach.Action.USPA       // a1 = Action.USPA
        or      a2, r0, r0                  // a2 = float: 0.0
        jal     0x800E6F24                  // change action
        lui     a3, 0x3F80                  // a3 = float: 1.0
        jal     0x800E0830                  // unknown common subroutine
        lw      a0, 0x0020(sp)              // a0 = player object
        lw      a0, 0x0020(sp)              // ~
        lw      a0, 0x0084(a0)              // a0 = player struct
        sw      r0, 0x017C(a0)              // temp variable 1 = 0
        sw      r0, 0x0180(a0)              // temp variable 2 = 0
        ori     v1, r0, 0x0001              // ~
        sw      v1, 0x0184(a0)              // temp variable 3 = 0x1(BEGIN)
        // reset fall speed
        lbu     v1, 0x018D(a0)              // v1 = fast fall flag
        ori     t6, r0, 0x0007              // t6 = bitmask (01111111)
        and     v1, v1, t6                  // ~
        sb      v1, 0x018D(a0)              // disable fast fall flag
        // freeze y position
        lw      v1, 0x09C8(a0)              // v1 = attribute pointer
        lw      v1, 0x0058(v1)              // v1 = gravity
        sw      v1, 0x004C(a0)              // y velocity = gravity
        lw      ra, 0x001C(sp)              // ~
        addiu   sp, sp, 0x0030              // ~
        jr      ra                          // original return logic
        nop
    }

    // @ Description
    // Subroutine which runs when Peach initiates a grounded up special.
    // Changes action, and sets up initial variable values.
    scope ground_initial_: {
        addiu   sp, sp,-0x0030              // ~
        sw      ra, 0x001C(sp)              // ~
        sw      a0, 0x0020(sp)              // original lines 1-3
        lli     t6, 0x0020                  // ~
        sw      t6, 0x0010(sp)              // argument 4 = 0x0020 (continue: special model parts)
        lli     a1, Peach.Action.USPG       // a1 = Action.USPG
        or      a2, r0, r0                  // a2 = float: 0.0
        jal     0x800E6F24                  // change action
        lui     a3, 0x3F80                  // a3 = float: 1.0
        jal     0x800E0830                  // unknown common subroutine
        lw      a0, 0x0020(sp)              // a0 = player object
        lw      a0, 0x0020(sp)              // ~
        lw      a0, 0x0084(a0)              // a0 = player struct
        sw      r0, 0x017C(a0)              // temp variable 1 = 0
        sw      r0, 0x0180(a0)              // temp variable 2 = 0
        ori     v1, r0, 0x0001              // ~
        sw      v1, 0x0184(a0)              // temp variable 3 = 0x1(BEGIN)
        lw      ra, 0x001C(sp)              // ~
        addiu   sp, sp, 0x0030              // ~
        jr      ra                          // original return logic
        nop
    }

    // @ Description
    // Subroutine which runs when Peach opens her parasol.
    // Changes action, and sets up initial variable values.
    scope open_initial_: {
        addiu   sp, sp,-0x0030              // ~
        sw      ra, 0x001C(sp)              // ~
        sw      a0, 0x0020(sp)              // original lines 1-3
        lli     t6, 0x0020                  // ~
        sw      t6, 0x0010(sp)              // argument 4 = 0x0020 (continue: special model parts)
        lli     a1, Peach.Action.USPOpen    // a1 = Action.USPOpen
        or      a2, r0, r0                  // a2 = float: 0.0
        jal     0x800E6F24                  // change action
        lui     a3, 0x3F80                  // a3 = float: 1.0
        jal     0x800E0830                  // unknown common subroutine
        lw      a0, 0x0020(sp)              // a0 = player object
        lw      a0, 0x0020(sp)              // ~
        lw      a0, 0x0084(a0)              // a0 = player struct
        ori     v1, r0, 0x0001              // ~
        sw      v1, 0x0180(a0)              // temp variable 2 = 0x1
        // reset fall speed
        lbu     v1, 0x018D(a0)              // v1 = fast fall flag
        ori     t6, r0, 0x0007              // t6 = bitmask (01111111)
        and     v1, v1, t6                  // ~
        sb      v1, 0x018D(a0)              // disable fast fall flag
        // reset y velocity
        sw      r0, 0x004C(a0)              // y velocity = 0
        lw      ra, 0x001C(sp)              // ~
        addiu   sp, sp, 0x0030              // ~
        jr      ra                          // original return logic
        nop
    }

    // @ Description
    // Subroutine which runs when Peach begins floating with her parasol.
    // Changes action, and sets up initial variable values.
    scope float_initial_: {
        addiu   sp, sp,-0x0030              // ~
        sw      ra, 0x001C(sp)              // ~
        sw      a0, 0x0020(sp)              // original lines 1-3
        lli     t6, 0x0020                  // ~
        sw      t6, 0x0010(sp)              // argument 4 = 0x0020 (continue: special model parts)
        lli     a1, Peach.Action.USPFloat   // a1 = Action.USPFloat
        or      a2, r0, r0                  // a2 = float: 0.0
        jal     0x800E6F24                  // change action
        lui     a3, 0x3F80                  // a3 = float: 1.0
        jal     0x800E0830                  // unknown common subroutine
        lw      a0, 0x0020(sp)              // a0 = player object
        lw      a0, 0x0020(sp)              // ~
        lw      a0, 0x0084(a0)              // a0 = player struct
        ori     v1, r0, 0x0001              // ~
        sw      v1, 0x0180(a0)              // temp variable 2 = 0x1
        lw      ra, 0x001C(sp)              // ~
        addiu   sp, sp, 0x0030              // ~
        jr      ra                          // original return logic
        nop
    }

    // @ Description
    // Subroutine which runs when Peach closes her parasol.
    // Changes action, and sets up initial variable values.
    scope close_initial_: {
        addiu   sp, sp,-0x0030              // ~
        sw      ra, 0x001C(sp)              // ~
        sw      a0, 0x0020(sp)              // original lines 1-3
        lli     t6, 0x0020                  // ~
        sw      t6, 0x0010(sp)              // argument 4 = 0x0020 (continue: special model parts)
        lli     a1, Peach.Action.USPClose   // a1 = Action.USPClose
        or      a2, r0, r0                  // a2 = float: 0.0
        jal     0x800E6F24                  // change action
        lui     a3, 0x3F80                  // a3 = float: 1.0
        jal     0x800E0830                  // unknown common subroutine
        lw      a0, 0x0020(sp)              // a0 = player object
        lw      a0, 0x0020(sp)              // ~
        lw      a0, 0x0084(a0)              // a0 = player struct
        ori     v1, r0, 0x0001              // ~
        sw      v1, 0x0180(a0)              // temp variable 2 = 0x1
        lw      ra, 0x001C(sp)              // ~
        addiu   sp, sp, 0x0030              // ~
        jr      ra                          // original return logic
        nop
    }

    // @ Description
    // Main subroutine for USPA/USPG
    scope main_: {
        addiu   sp, sp,-0x0040              // allocate stack space
        sw      ra, 0x0014(sp)              // 0x0014(sp) = ra

        // checks the current animation frame to see if we've reached end of the animation
        mtc1    r0, f6                      // ~
        lwc1    f8, 0x0078(a0)              // ~
        c.le.s  f8, f6                      // ~
        nop
        bc1fl   _end                        // skip if animation end has not been reached
        nop
        jal     open_initial_               // transition to USPOpen
        nop

        _end:
        lw      ra, 0x0014(sp)              // load ra
        addiu   sp, sp, 0x0040              // deallocate stack space
        jr      ra
        nop
    }

    // @ Description
    // Main subroutine for USPOpen.
    scope open_main_: {
        addiu   sp, sp,-0x0040              // allocate stack space
        sw      ra, 0x0014(sp)              // 0x0014(sp) = ra

        // checks the current animation frame to see if we've reached end of the animation
        mtc1    r0, f6                      // ~
        lwc1    f8, 0x0078(a0)              // ~
        c.le.s  f8, f6                      // ~
        nop
        bc1fl   _end                        // skip if animation end has not been reached
        nop
        jal     float_initial_              // transition to USPFloat
        nop

        _end:
        lw      ra, 0x0014(sp)              // load ra
        addiu   sp, sp, 0x0040              // deallocate stack space
        jr      ra
        nop
    }

    // @ Description
    // Main subroutine for USPClose.
    // Based on subroutine 0x8015C750, which is the main subroutine of Fox's up special ending.
    // Modified to load Peach's landing FSM value and disable the interrupt flag.
    scope close_main_: {
        // Copy the first 8 lines of subroutine 0x8015C750
        OS.copy_segment(0xD7190, 0x20)
        bc1fl   _end                        // skip if animation end has not been reached
        lw      ra, 0x0024(sp)              // restore ra
        sw      r0, 0x0010(sp)              // unknown argument = 0
        sw      r0, 0x0018(sp)              // interrupt flag = FALSE
        lui     t6, LANDING_FSM             // t6 = LANDING_FSM
        jal     0x801438F0                  // begin special fall
        sw      t6, 0x0014(sp)              // store LANDING_FSM
        lw      ra, 0x0024(sp)              // restore ra

        _end:
        addiu   sp, sp, 0x0028              // deallocate stack space
        jr      ra                          // return
        nop
    }

    // @ Description
    // Subroutine which allows a direction change for Peach's up special.
    // Uses the moveset data command 580000XX (orignally identified as "set flag" by toomai)
    // This command's purpose appears to be setting a temporary variable in the player struct.
    // Variable values used by this subroutine:
    // 0x2 = change direction
    scope change_direction_: {
        // 0x180 in player struct = temp variable 2
        lw      a1, 0x0084(a0)              // a1 = player struct
        addiu   sp, sp,-0x0010              // allocate stack space
        sw      t0, 0x0004(sp)              // ~
        sw      t1, 0x0008(sp)              // ~
        sw      ra, 0x000C(sp)              // store t0, t1, ra
        lw      t0, 0x0180(a1)              // t0 = temp variable 2
        ori     t1, r0, 0x0002              // t1 = 0x2
        bne     t1, t0, _end                // skip if temp variable 2 != 2
        nop
        jal     0x80160370                  // turn subroutine (copied from captain falcon)
        nop

        _end:
        lw      t0, 0x0004(sp)              // ~
        lw      t1, 0x0008(sp)              // ~
        lw      ra, 0x000C(sp)              // load t0, t1, ra
        addiu   sp, sp, 0x0010              // deallocate stack space
        jr      ra                          // return
        nop
    }

    // @ Description
    // Allows USPFloat to be interrupted with USPClose.
    scope float_interrupt_: {
        OS.routine_begin(0x30)

        lw      v1, 0x0084(a0)              // v1 = player struct
        lb      t6, 0x01C3(v1)              // t6 = stick_y
        slti    at, t6, -39                 // at = 1 if stick_y < -39, else at = 0
        beq     at, r0, _end                // end if stick_y >= -39
        nop

        // if stick_y < -39
        jal     close_initial_              // transition to USPClose
        nop

        _end:
        OS.routine_end(0x30)
    }

    // @ Description
    // Allows USPFall to be interrupted with USPOpen.
    // Replaces 0x80143730
    scope fall_interrupt_: {
        OS.routine_begin(0x30)

        lw      v1, 0x0084(a0)              // v1 = player struct
        lb      t6, 0x01C3(v1)              // t6 = stick_y
        slti    at, t6, 40                  // at = 1 if stick_y < 40, else at = 0
        bne     at, r0, _end                // end if stick_y < 40
        nop

        // if stick_y >= 40
        jal     open_initial_              // transition to USPOpen
        nop

        _end:
        OS.routine_end(0x30)
    }

    // @ Description
    // Subroutine which handles movement for Peach's up special.
    // Uses the moveset data command 5C0000XX (orignally identified as "apply throw?" by toomai)
    // This command's purpose appears to be setting a temporary variable in the player struct.
    // The most common use of this variable is to determine when a throw should be applied.
    // Variable values used by this subroutine:
    // 0x2 = begin movement
    // 0x3 = movement
    // 0x4 = end movement
    scope physics_: {
        // s0 = player struct
        // s1 = attributes pointer
        // 0x184 in player struct = temp variable 3
        addiu   sp, sp,-0x0038              // allocate stack space
        sw      ra, 0x001C(sp)              // ~
        sw      s0, 0x0014(sp)              // ~
        sw      s1, 0x0018(sp)              // store ra, s0, s1

        lw      s0, 0x0084(a0)              // s0 = player struct
        lw      t0, 0x014C(s0)              // t0 = kinetic state
        bnez    t0, _aerial                 // branch if kinetic state !grounded
        nop

        _grounded:
        jal     0x800D8BB4                  // grounded physics subroutine
        nop
        b       _end                        // end subroutine
        nop

        _aerial:
        OS.copy_segment(0x548F0, 0x40)      // copy from original air physics subroutine
        bnez    v0, _check_begin            // modified original branch
        nop
        li      t8, 0x800D8FA8              // t8 = subroutine which disallows air control
        lw      t0, 0x0184(s0)              // t0 = temp variable 3
        ori     t1, r0, MOVE                // t1 = MOVE
        bne     t0, t1, _apply_air_physics  // branch if temp variable 3 != MOVE
        nop
        li      t8, air_control_             // t8 = air_control_

        _apply_air_physics:
        or      a0, s0, r0                  // a0 = player struct
        jalr    t8                          // air control subroutine
        or      a1, s1, r0                  // a1 = attributes pointer
        or      a0, s0, r0                  // a0 = player struct
        jal     0x800D9074                  // air friction subroutine?
        or      a1, s1, r0                  // a1 = attributes pointer

        _check_begin:
        lw      t0, 0x0184(s0)              // t0 = temp variable 3
        ori     t1, r0, BEGIN               // t1 = BEGIN
        bne     t0, t1, _check_begin_move   // skip if temp variable 3 != BEGIN
        lw      t0, 0x0024(s0)              // t0 = current action
        lli     t1, Peach.Action.USPG      // t1 = Action.USPG
        beq     t0, t1, _check_begin_move   // skip if current action = USP_GROUND
        nop
        // slow x movement
        lwc1    f0, 0x0048(s0)              // f0 = current x velocity
        lui     t0, 0x3F60                  // ~
        mtc1    t0, f2                      // f2 = 0.875
        mul.s   f0, f0, f2                  // f0 = x velocity * 0.875
        swc1    f0, 0x0048(s0)              // x velocity = (x velocity * 0.875)
        // freeze y position
        sw      r0, 0x004C(s0)              // y velocity = 0

        _check_begin_move:
        lw      t0, 0x0184(s0)              // t0 = temp variable 3
        ori     t1, r0, BEGIN_MOVE          // t1 = BEGIN_MOVE
        bne     t0, t1, _check_end_move     // skip if temp variable 3 != BEGIN_MOVE
        nop
        // initialize x/y velocity
        lw      t0, 0x0024(s0)              // t0 = current action
        lli     t1, Peach.Action.USPG      // t1 = Action.USPG
        beq     t0, t1, _apply_velocity     // branch if current action = USP_GROUND
        lui     t1, GROUND_Y_SPEED          // t1 = GROUND_Y_SPEED
        // if current action != USP_GROUND
        lui     t1, AIR_Y_SPEED             // t1 = AIR_Y_SPEED

        _apply_velocity:
        lui     t0, X_SPEED                 // ~
        mtc1    t0, f2                      // f2 = X_SPEED
        lwc1    f0, 0x0044(s0)              // ~
        cvt.s.w f0, f0                      // f0 = direction
        mul.s   f2, f0, f2                  // f2 = x velocity * direction
        ori     t0, r0, MOVE                // t0 = MOVE
        sw      t0, 0x0184(s0)              // temp variable 3 = MOVE
        // take mid-air jumps away at this point
        lw      t0, 0x09C8(s0)              // t0 = attribute pointer
        lw      t0, 0x0064(t0)              // t0 = max jumps
        sb      t0, 0x0148(s0)              // jumps used = max jumps
        swc1    f2, 0x0048(s0)              // store x velocity
        sw      t1, 0x004C(s0)              // store y velocity

        _check_end_move:
        lw      t0, 0x0184(s0)              // t0 = temp variable 3
        ori     t1, r0, END_MOVE            // t1 = END_MOVE
        bne     t0, t1, _end                // skip if temp variable 3 != END_MOVE
        lwc1    f0, 0x0048(s0)              // f0 = current x velocity

        lui     t0, 0x3F60                  // ~
        mtc1    t0, f2                      // f2 = 0.875
        mul.s   f0, f0, f2                  // f0 = x velocity * 0.875
        swc1    f0, 0x0048(s0)              // x velocity = (x velocity * 0.875)

        _end:
        lw      ra, 0x001C(sp)              // ~
        lw      s0, 0x0014(sp)              // ~
        lw      s1, 0x0018(sp)              // loar ra, s0, s1
        addiu   sp, sp, 0x0038              // deallocate stack space
        jr      ra                          // return
        nop
    }

    // @ Description
    // Subroutine which handles Peach's horizontal control for up special.
    scope air_control_: {
        addiu   sp, sp,-0x0028              // allocate stack space
        sw      a1, 0x001C(sp)              // ~
        sw      ra, 0x0014(sp)              // ~
        sw      t0, 0x0020(sp)              // ~
        sw      t1, 0x0024(sp)              // store a1, ra, t0, t1
        addiu   a1, r0, 0x0008              // a1 = 0x8 (original line)
        lw      t6, 0x001C(sp)              // t6 = attribute pointer
        // load an immediate value into a2 instead of the air acceleration from the attributes
        lui     a2, AIR_ACCELERATION        // a2 = AIR_ACCELERATION
        lui     a3, AIR_SPEED               // a3 = AIR_SPEED
        jal     0x800D8FC8                  // air drift subroutine?
        nop
        lw      ra, 0x0014(sp)              // ~
        lw      t0, 0x0020(sp)              // ~
        lw      t1, 0x0024(sp)              // load ra, t0, t1
        addiu   sp, sp, 0x0028              // deallocate stack space
        jr      ra                          // return
        nop
    }

    // @ Description
    // Aerial movement subroutine for USPOpen and USPFloat
    // Modified version of subroutine 0x800D90E0.
    scope float_physics_: {
        // Copy the first 8 lines of subroutine 0x800D90E0
        OS.copy_segment(0x548E0, 0x20)

        // Skip 7 lines (fast fall branch logic)

        // jal 0x800D8E50                   // ~
        // or a1, s1, r0                    // original 2 lines call gravity subroutine
        lui     a1, FLOAT_GRAVITY           // a1 = FLOAT_GRAVITY
        jal     0x800D8D68                  // apply gravity/fall speed
        lui     a2, FLOAT_FALL_SPEED        // a1 = FLOAT_FALL_SPEED

        // Copy the next 15 lines of subroutine 0x800D90E0
        OS.copy_segment(0x54924, 0x3C)
    }

    // @ Description
    // Collision wubroutine for Peach's up special.
    // Copy of subroutine 0x80156358, which is the collision subroutine for Mario's up special.
    // Loads the appropriate landing fsm value for Peach.
    scope collision_: {
        // Copy the first 30 lines of subroutine 0x80156358
        OS.copy_segment(0xD0D98, 0x78)
        // Replace original line which loads the landing fsm
        //lui     a2, 0x3E8F                // original line 1
        lui     a2, LANDING_FSM             // a2 = LANDING_FSM
        // Copy the last 17 lines of subroutine 0x80156358
        OS.copy_segment(0xD0E14, 0x44)
    }

    // @ Description
    // Patch which transitions to USPFall instead of FallSpecial for Peach
    scope fall_special_patch_: {
        OS.patch_start(0xBE368, 0x80143928)
        j       fall_special_patch_
        sw      t6, 0x0028(sp)              // original line 2
        _return:
        OS.patch_end()

        // s0 = player struct
        lw      t6, 0x0008(s0)              // t6 = character id
        lli     at, Character.id.PEACH      // at = id.PEACH

        bne     t6, at, _end                // skip if character != Peach
        lli     at, Peach.Action.USPClose   // ~

        // if the character is Peach
        lw      t6, 0x0024(s0)              // t6 = current action
        beql    t6, at, _end                // if current action = USPClose...
        lli     a1, Peach.Action.USPFall    // a1(action id) = USPFall

        _end:
        jal     0x800E6F24                  // original line 1 (change action)
        nop
        j       _return                     // return
        nop
    }
}

scope PeachNSP {
    constant Y_SPEED_INITIAL(0x41F0)        // current setting - float32 30
    constant X_SPEED(0x4240)                // current setting - float32 48
    constant X_SMASH_SPEED(0x4270)          // current setting - float32 60
    constant RECOIL_X_SPEED(0xC208)         // current setting - float:-34.0
    constant RECOIL_Y_SPEED(0x4220)         // current setting - float:40.0
    constant AIR_FRICTION(0x3F80)           // current setting - float32 1

    constant BEGIN_MOVE(0x1)
    constant MOVE(0x2)
    constant END_MOVE(0x3)
    constant END(0x4)

    constant WALL_COLLISION_L(0x0001)       // bitmask for wall collision
    constant WALL_COLLISION_R(0x0020)       // bitmask for wall collision

    // @ Description
    // Subroutine which runs when Peach initiates a grounded neutral special.
    // Changes action, and sets up initial variable values.
    scope ground_initial_: {
        addiu   sp, sp,-0x0030              // ~
        sw      ra, 0x001C(sp)              // ~
        sw      a0, 0x0020(sp)              // original lines 1-3
        lw      v1, 0x0084(a0)              // v1 = player struct
        lli     t6, 0x0020                  // ~
        sw      t6, 0x0010(sp)              // argument 4 = 0x0020 (continue: special model parts)

        lw      a2, 0x0008(v1)              // a2 = current character ID
        lli     a1, Character.id.PEACH      // a1 = id.PEACH
        beql    a1, a2, _change_action
        lli     a1, Peach.Action.NSPG       // a1 = Action.NSPG
        // if here, kirby
        lli     a1, Kirby.Action.PEACH_NSP_Ground       // a1 = Action.NSPG

        _change_action:
        or      a2, r0, r0                  // a2 = float: 0.0
        jal     0x800E6F24                  // change action
        lui     a3, 0x3F80                  // a3 = float: 1.0
        jal     0x800E0830                  // unknown common subroutine
        lw      a0, 0x0020(sp)              // a0 = player object
        jal     0x80163850                  // ftLinkSpecialNProcStatus, sets 0xB18 to 1 if smash input
        lw      a0, 0x0020(sp)              // a0 = player object
        lw      a0, 0x0020(sp)              // ~
        lw      a0, 0x0084(a0)              // a0 = player struct
        sw      r0, 0x0180(a0)              // temp variable 2 = 0
        sw      r0, 0x0184(a0)              // temp variable 3 = 0
        li      at, shield_clang_hit_       // ~
        sw      at, 0x09F4(a0)              // on shield/clang function = shield_clang_hit_
        li      at, recoil_initial_         // ~
        sw      at, 0x09F8(a0)              // on hit function = recoil_initial_
        lw      ra, 0x001C(sp)              // ~
        jr      ra                          // original return logic
        addiu   sp, sp, 0x0030              // ~
    }

    // @ Description
    // Subroutine which runs when Peach initiates an aerial neutral special.
    // Changes action, and sets up initial variable values.
    scope air_initial_: {
        addiu   sp, sp,-0x0030              // ~
        sw      ra, 0x001C(sp)              // ~
        sw      a0, 0x0020(sp)              // original lines 1-3
        lw      v1, 0x0084(a0)              // v1 = player struct
        lli     t6, 0x0020                  // ~
        sw      t6, 0x0010(sp)              // argument 4 = 0x0020 (continue: special model parts)

        lw      a2, 0x0008(v1)              // a2 = current character ID
        lli     a1, Character.id.PEACH      // a1 = id.PEACH
        beql    a1, a2, _change_action
        lli     a1, Peach.Action.NSPA       // a1 = Action.NSPA
        // if here, kirby
        lli     a1, Kirby.Action.PEACH_NSP_Air      // a1 = Action.NSPA

        _change_action:
        or      a2, r0, r0                  // a2 = float: 0.0
        jal     0x800E6F24                  // change action
        lui     a3, 0x3F80                  // a3 = float: 1.0
        jal     0x800E0830                  // unknown common subroutine
        lw      a0, 0x0020(sp)              // a0 = player object
        jal     0x80163850                  // ftLinkSpecialNProcStatus, sets 0xB18 to 1 if smash input
        lw      a0, 0x0020(sp)              // a0 = player object
        lw      a0, 0x0020(sp)              // ~
        lw      a0, 0x0084(a0)              // a0 = player struct
        sw      r0, 0x0180(a0)              // temp variable 2 = 0
        sw      r0, 0x0184(a0)              // temp variable 3 = 0
        // reset fall speed
        lbu     v1, 0x018D(a0)              // v1 = fast fall flag
        ori     t6, r0, 0x0007              // t6 = bitmask (01111111)
        and     v1, v1, t6                  // ~
        sb      v1, 0x018D(a0)              // disable fast fall flag
        lui     v1, Y_SPEED_INITIAL         // ~
        sw      v1, 0x004C(a0)              // y velocity = Y_SPEED_INITIAL
        li      at, shield_clang_hit_       // ~
        sw      at, 0x09F4(a0)              // on shield/clang function = shield_clang_hit_
        li      at, recoil_initial_         // ~
        sw      at, 0x09F8(a0)              // on hit function = recoil_initial_
        lw      ra, 0x001C(sp)              // ~
        addiu   sp, sp, 0x0030              // ~
        jr      ra                          // original return logic
        nop
    }

    // @ Description
    // Subroutine which transitions into Peach's neutral special recoil action.
    scope recoil_initial_: {
        addiu   sp, sp, -0x0020             // allocate stack space
        sw      ra, 0x0014(sp)              // store ra
        sw      a0, 0x0018(sp)              // 0x0018(sp) = player object
        lw      a0, 0x0084(a0)              // a0 = player struct
        lw      t7, 0x014C(a0)              // t7 = kinetic state
        bnez    t7, _end                    // skip if kinetic state !grounded
        nop
        jal     0x800DEEC8                  // set aerial state
        nop

        _end:
        lw      a0, 0x0018(sp)              // a0 = player object
        lw      v1, 0x0084(a0)              // v1 = player struct

        lw      a2, 0x0008(v1)              // a2 = current character ID
        lli     a1, Character.id.PEACH      // a1 = id.PEACH
        beql    a1, a2, _change_action
        ori     a1, r0, Peach.Action.NSPRecoil // a1 = Action.NSPRecoil
        // if here, kirby
        lli     a1, Kirby.Action.PEACH_NSP_Recoil      // a1 = Action.PEACH_NSP_Recoil

        _change_action:
        or      a2, r0, r0                  // a2 = float: 0.0
        sw      r0, 0x0010(sp)              // arg 4 = 0
        jal     0x800E6F24                  // change action
        lui     a3, 0x3F80                  // a3 = float: 1.0

        lw      a0, 0x0018(sp)              // ~
        lw      a1, 0x0084(a0)              // a1 = player struct
        // initial x velocity
        lui     at, RECOIL_X_SPEED          // ~
        mtc1    at, f2                      // f2 = RECOIL_X_SPEED
        lwc1    f4, 0x0044(a1)              // ~
        cvt.s.w f4, f4                      // f4 = DIRECTION
        mul.s   f2, f2, f4                  // f0 = RECOIL_X_SPEED * DIRECTION
        swc1    f2, 0x0048(a1)              // x velocity = RECOIL_X_SPEED * DIRECTION
        // initial y velocity
        lui     at, RECOIL_Y_SPEED          // t1 = RECOIL_Y_SPEED
        sw      at, 0x004C(a1)              // y velocity = RECOIL_Y_SPEED

        lw      ra, 0x0014(sp)              // load ra
        jr      ra                          // return
        addiu   sp, sp, 0x0020              // deallocate stack space
    }

    // @ Description
    // Subroutine which ends the movement of NSP when peach hits shield or clangs
    scope shield_clang_hit_: {
        addiu   sp, sp, -0x0020             // allocate stack space
        sw      ra, 0x0014(sp)              // store ra
        sw      a0, 0x0018(sp)              // 0x0018(sp) = player object
        lw      v1, 0x0084(a0)              // v1 = player struct
        lw      a0, 0x0018(sp)              // a0 = player object
        lw      a1, 0x0024(v1)              // a1 = current action
        lui     a2, 0x420C                  // a2 (starting frame) = 35
        sw      r0, 0x0010(sp)              // arg 4 = 0
        jal     0x800E6F24                  // change action
        lui     a3, 0x3F80                  // a3 = float: 1.0
        lw      ra, 0x0014(sp)              // load ra
        jr      ra                          // return
        addiu   sp, sp, 0x0020              // deallocate stack space
    }

    // @ Description
    // Physics subroutine for NSPGround.
    // Temp variable 3 values:
    // 0x0 - begin, 0x1 - begin movement, 0x2 - movement, 0x3 - end movement, 0x4 - end?
    scope ground_physics_: {
        addiu   sp, sp,-0x0040              // allocate stack space
        sw      ra, 0x0014(sp)              // ~
        sw      a0, 0x0018(sp)              // ~
        sw      s0, 0x001C(sp)              // store ra, a0, s0
        lw      s0, 0x0084(a0)              // s0 = player struct
        lw      t6, 0x0184(s0)              // t6 = temp variable 3
        lli     at, BEGIN_MOVE              // ~
        beq     t6, at, _begin_move         // branch if temp variable 3 = BEGIN_MOVE
        lli     at, MOVE                    // ~
        beq     t6, at, _end                // skip if temp variable 3 = MOVE
        lli     at, END_MOVE                // ~
        beq     t6, at, _end_move           // branch if temp variable 3 = END_MOVE
        nop

        // if no movement state is set
        jal     0x800D8BB4                  // physics subroutine
        nop
        b       _end                        // branch to end
        nop

        _begin_move:
        lui     at, X_SPEED                 // at = X_SPEED
        lw      t6, 0x0B18(s0)              // t6 = is_smash
        bnezl   t6, pc() + 8                // if is_smash...
        lui     at, X_SMASH_SPEED           // at = X_SMASH_SPEED

        mtc1    at, f2                      // f2 = SPEED
        sw      at, 0x0060(s0)              // ground x velocity = SPEED
        lli     at, MOVE                    // ~
        sw      at, 0x0184(s0)              // temp variable 3 = MOVE

        _move:
        jal     0x800D87D0                  // apply grounded movement
        nop
        b       _end                        // branch to end
        nop

        _end_move:
        lli     at, END                     // ~
        sw      at, 0x0184(s0)              // temp variable 3 = END

        _end:
        lw      ra, 0x0014(sp)              // ~
        lw      s0, 0x001C(sp)              // load ra, s0
        jr      ra                          // return
        addiu   sp, sp, 0x0040              // deallocate stack space
    }

    // @ Description
    // Physics subroutine for NSPAir.
    // Temp variable 3 values:
    // 0x0 - begin, 0x1 - begin movement, 0x2 - movement, 0x3 - end movement, 0x4 - end
    scope air_physics_: {
        addiu   sp, sp,-0x0040              // allocate stack space
        sw      ra, 0x0014(sp)              // ~
        sw      a0, 0x0018(sp)              // ~
        sw      s0, 0x001C(sp)              // store ra, a0, s0
        lw      s0, 0x0084(a0)              // s0 = player struct
        lw      t6, 0x0184(s0)              // t6 = temp variable 3
        lli     at, BEGIN_MOVE              // ~
        beq     t6, at, _begin_move         // branch if temp variable 3 = BEGIN_MOVE
        lli     at, MOVE                    // ~
        beq     t6, at, _end                // skip if temp variable 3 = MOVE
        lli     at, END_MOVE                // ~
        beq     t6, at, _end_move           // branch if temp variable 3 = END_MOVE
        lli     at, END                     // ~
        beq     t6, at, _end_physics        // branch if temp variable 3 = END
        nop

        // if no movement state is set
        jal     0x800D90E0                  // physics subroutine (allows player control)
        nop
        b       _end                        // branch to end
        nop

        _begin_move:
        lui     at, X_SPEED                 // at = X_SPEED
        lw      t6, 0x0B18(s0)              // t6 = is_smash
        bnezl   t6, pc() + 8                // if is_smash...
        lui     at, X_SMASH_SPEED           // at = X_SMASH_SPEED

        mtc1    at, f2                      // f2 = SPEED
        lwc1    f4, 0x0044(s0)              // ~
        cvt.s.w f4, f4                      // f4 = DIRECTION
        mul.s   f2, f2, f4                  // f2 = SPEED * DIRECTION
        swc1    f2, 0x0048(s0)              // x velocity = SPEED * DIRECTION
        sw      r0, 0x004C(s0)              // y velocity = 0
        lli     at, MOVE                    // ~
        b       _end                        // branch to end
        sw      at, 0x0184(s0)              // temp variable 3 = MOVE

        _end_move:
        lui     at, 0x3F00                  // ~
        mtc1    at, f2                      // f2 = 0.5
        lwc1    f4, 0x0048(s0)              // f4 = x velocity
        mul.s   f4, f4, f2                  // f4 = x velocity * 0.5
        swc1    f4, 0x0048(s0)              // store updated x velocity
        lli     at, END                     // ~
        sw      at, 0x0184(s0)              // temp variable 3 = END

        _end_physics:
        jal     air_end_physics_            // air_end_physics_
        nop

        _end:
        lw      ra, 0x0014(sp)              // ~
        lw      s0, 0x001C(sp)              // load ra, s0
        jr      ra                          // return
        addiu   sp, sp, 0x0040              // deallocate stack space
    }

    // @ Description
    // Physics subroutine for non-actionable aerial movement
    // Modified version of subroutine 0x800D91EC.
    scope air_end_physics_: {
        addiu   sp, sp,-0x0030              // allocate stack space
        sw      ra, 0x001C(sp)              // store ra
        //sw      s1, 0x0018(sp)              // ~
        sw      s0, 0x0014(sp)              // ~
        lw      s0, 0x0084(a0)              // ~
        //lw      s1, 0x09C8(s0)              // ~
        or      a0, s0, r0                  // original lines
        lw      a3, 0x09C8(s0)              // a3 = attribute pointer
        lw      a1, 0x0058(a3)              // a2 = gravity
        jal     0x800D8D68                  // apply gravity/fall speed
        lw      a2, 0x005C(a3)              // a2 = max fall speed

        // Subroutine 0x800D9074 applies air friction. Usually, air friction is loaded from
        // 0x0054(a1), with a1 being the attribute pointer for the character. In this case, a
        // different air friction value is stored at 0x0054(sp) and then the stack pointer is
        // passed to a1 for subroutine 0x800D9074.
        or      a0, s0, r0                  // a0 = player struct
        addiu   sp, sp,-0x0058              // allocate stack space
        lui     a1, AIR_FRICTION            // a1 = AIR_FRICTION
        sw      a1, 0x0054(sp)              // store AIR_FRICTION
        jal     0x800D9074                  // apply air friction
        or      a1, sp, r0                  // a1 = stack pointer
        addiu   sp, sp, 0x0058              // deallocate stack space
        lw      ra, 0x001C(sp)              // ~
        lw      s0, 0x0014(sp)              // load ra, s0
        jr      ra                          // return
        addiu   sp, sp, 0x0030              // deallocate stack space
    }

    // @ Description
    // Collision wubroutine for NSPGround.
    scope ground_collision_: {
        addiu   sp, sp,-0x0028              // allocate stack space
        sw      ra, 0x0014(sp)              // store ra
        li      a1, ground_to_air_          // a1(transition subroutine) = ground_to_air_
        jal     0x800DDDDC                  // common ground collision subroutine (transition on no floor, slide-off)
        sw      a0, 0x0018(sp)              // 0x0018(sp) = player object

        beqz    v0, _end                    // end if transition has occurred
        lw      a0, 0x0018(sp)              // a0 = player object

        lw      t6, 0x0084(a0)              // t6 = player struct
        lw      t0, 0x0184(t6)              // t0 = temp variable 3
        lli     at, MOVE                    // ~
        bne     t0, at, _end                // skip if temp variable 3 != MOVE
        lhu     a1, 0x00CC(t6)              // a1 = collision flags

        lw      t0, 0x0044(t6)              // t0 = direction
        bgezl   t0, _check_collision        // branch if direction = right
        andi    a1, a1, WALL_COLLISION_L    // a1 = collision flags & WALL_COLLISION_L
        andi    a1, a1, WALL_COLLISION_R    // a1 = collision flags & WALL_COLLISION_R

        _check_collision:
        beql    a1, r0, _end                // skip if !WALL_COLLISION
        nop

        // if Peach is colliding with a wall, bounce off
        jal     recoil_initial_             // being NSPRecoil
        nop

        _end:
        lw      ra, 0x0014(sp)              // load ra
        jr      ra                          // return
        addiu   sp, sp, 0x0028              // deallocate stack space
    }

    // @ Description
    // Collision wubroutine for NSPAir.
    scope air_collision_: {
        addiu   sp, sp,-0x0028              // allocate stack space
        sw      ra, 0x0014(sp)              // store ra
        li      a1, air_to_ground_          // a1(transition subroutine) = air_to_ground_
        jal     0x800DE6E4                  // common air collision subroutine (transition on landing, no ledge grab)
        sw      a0, 0x0018(sp)              // 0x0018(sp) = player object

        bnez    v0, _end                    // end if transition has occurred
        lw      a0, 0x0018(sp)              // a0 = player object

        lw      t6, 0x0084(a0)              // t6 = player struct
        lw      t0, 0x0184(t6)              // t0 = temp variable 3
        lli     at, MOVE                    // ~
        bne     t0, at, _end                // skip if temp variable 3 != MOVE
        lhu     a1, 0x00CC(t6)              // a1 = collision flags

        lw      t0, 0x0044(t6)              // t0 = direction
        bgezl   t0, _check_collision        // branch if direction = right
        andi    a1, a1, WALL_COLLISION_L    // a1 = collision flags & WALL_COLLISION_L
        andi    a1, a1, WALL_COLLISION_R    // a1 = collision flags & WALL_COLLISION_R

        _check_collision:
        beql    a1, r0, _end                // skip if !WALL_COLLISION
        nop

        // if Peach is colliding with a wall, bounce off
        jal     recoil_initial_             // being NSPRecoil
        nop

        _end:
        lw      ra, 0x0014(sp)              // load ra
        jr      ra                          // return
        addiu   sp, sp, 0x0028              // deallocate stack space
    }

    // @ Description
    // Subroutine which handles the transition from NSPGround to NSPAir.
    scope ground_to_air_: {
        addiu   sp, sp,-0x0020              // allocate stack space
        sw      ra, 0x001C(sp)              // ~
        sw      a0, 0x0020(sp)              // store a0, ra
        jal     0x800DEEC8                  // set aerial state
        lw      a0, 0x0084(a0)              // a0 = player struct
        lw      a0, 0x0020(sp)              // a0 = player object
        lw      v1, 0x0084(a0)              // v1 = player struct

        lw      a2, 0x0008(v1)              // a2 = current character ID
        lli     a1, Character.id.PEACH      // a1 = id.PEACH
        beql    a1, a2, _change_action
        lli     a1, Peach.Action.NSPA       // a1 = Action.NSPA
        // if here, kirby
        lli     a1, Kirby.Action.PEACH_NSP_Air       // a1 = Action.NSPG

        _change_action:
        lw      a2, 0x0078(a0)              // a2(starting frame) = current animation frame
        lli     t6, 0x0003                  // ~
        sw      t6, 0x0010(sp)              // argument 4 = 0x0003
        jal     0x800E6F24                  // change action
        lui     a3, 0x3F80                  // a3(frame speed multiplier) = 1.0
        lw      a0, 0x0020(sp)              // ~
        lw      a0, 0x0084(a0)              // a0 = player struct
        li      at, shield_clang_hit_       // ~
        sw      at, 0x09F4(a0)              // on shield/clang function = shield_clang_hit_
        li      at, recoil_initial_         // ~
        sw      at, 0x09F8(a0)              // on hit function = recoil_initial_
        lw      ra, 0x001C(sp)              // load ra
        jr      ra                          // return
        addiu   sp, sp, 0x0020              // deallocate stack space
    }

    // @ Description
    // Subroutine which handles the transition from NSPAir to NSPGround.
    scope air_to_ground_: {
        addiu   sp, sp,-0x0020              // allocate stack space
        sw      ra, 0x001C(sp)              // ~
        sw      a0, 0x0020(sp)              // store a0, ra
        jal     0x800DEE98                  // set grounded state
        lw      a0, 0x0084(a0)              // a0 = player struct
        lw      a0, 0x0020(sp)              // a0 = player object
        lw      v1, 0x0084(a0)              // v1 = player struct

        lw      a2, 0x0008(v1)              // a2 = current character ID
        lli     a1, Character.id.PEACH      // a1 = id.PEACH
        beql    a1, a2, _change_action
        lli     a1, Peach.Action.NSPG       // a1 = Action.NSPG
        // if here, kirby
        lli     a1, Kirby.Action.PEACH_NSP_Ground       // a1 = Action.NSPG

        _change_action:
        lw      a2, 0x0078(a0)              // a2(starting frame) = current animation frame
        lli     t6, 0x0003                  // ~
        sw      t6, 0x0010(sp)              // argument 4 = 0x0003
        jal     0x800E6F24                  // change action
        lui     a3, 0x3F80                  // a3(frame speed multiplier) = 1.0
        lw      a0, 0x0020(sp)              // ~
        lw      a0, 0x0084(a0)              // a0 = player struct
        li      at, shield_clang_hit_       // ~
        sw      at, 0x09F4(a0)              // on shield/clang function = shield_clang_hit_
        li      at, recoil_initial_         // ~
        sw      at, 0x09F8(a0)              // on hit function = recoil_initial_
        lw      ra, 0x001C(sp)              // load ra
        jr      ra                          // return
        addiu   sp, sp, 0x0020              // deallocate stack space
    }
}