// RoySpecial.asm

// This file contains subroutines used by Roy's special moves.

// @ Description
// Subroutines for Roy Down special.
scope RoyDSP {

    constant MAX_CHARGE_LEVEL(21)
    
    // @ Description
    // Subroutine which runs when Roy initiates a grounded down special.
    scope ground_begin_initial_: {
        addiu   sp, sp,-0x0020              // allocate stack space
        sw      ra, 0x001C(sp)              // ~
        sw      a0, 0x0020(sp)              // store a0, ra
        lli     a1, Roy.Action.DSP_Ground_Begin // a1(action id) = DSP_Ground_Begin
        or      a2, r0, r0                  // a2(starting frame) = 0
        lui     a3, 0x3F80                  // a3(frame speed multiplier) = 1.0
        jal     0x800E6F24                  // change action
        sw      r0, 0x0010(sp)              // argument 4 = 0
        jal     0x800E0830                  // unknown common subroutine
        lw      a0, 0x0020(sp)              // a0 = player object
        lw      a0, 0x0020(sp)              // ~
        lw      a0, 0x0084(a0)              // ~
        sw      r0, 0x017C(a0)              // temp variable 1 = 0
        sw      r0, 0x0180(a0)              // temp variable 2 = 0
        sw      r0, 0x0184(a0)              // temp variable 3 = 0
        sw      r0, 0x0B18(a0)              // charge level = 0
        lw      ra, 0x001C(sp)              // load ra
        jr      ra                          // return
        addiu   sp, sp, 0x0020              // deallocate stack space
    }

    // @ Description
    // Subroutine which runs when Roy initiates an aerial down special.
    scope air_begin_initial_: {
        addiu   sp, sp,-0x0020              // allocate stack space
        sw      ra, 0x001C(sp)              // ~
        sw      a0, 0x0020(sp)              // store a0, ra
        lli     a1, Roy.Action.DSP_Air_Begin // a1(action id) = DSP_Air_Begin
        or      a2, r0, r0                  // a2(starting frame) = 0
        lui     a3, 0x3F80                  // a3(frame speed multiplier) = 1.0
        jal     0x800E6F24                  // change action
        sw      r0, 0x0010(sp)              // argument 4 = 0
        jal     0x800E0830                  // unknown common subroutine
        lw      a0, 0x0020(sp)              // a0 = player object
        lw      a0, 0x0020(sp)              // ~
        lw      a0, 0x0084(a0)              // ~
        sw      r0, 0x017C(a0)              // temp variable 1 = 0
        sw      r0, 0x0180(a0)              // temp variable 2 = 0
        sw      r0, 0x0184(a0)              // temp variable 3 = 0
        sw      r0, 0x0B18(a0)              // charge level = 0
        lw      ra, 0x001C(sp)              // load ra
        jr      ra                          // return
        addiu   sp, sp, 0x0020              // deallocate stack space
    }

    // @ Description
    // Subroutine which begins Roy's grounded down special wait action.
    scope ground_wait_initial_: {
        addiu   sp, sp,-0x0020              // allocate stack space
        sw      ra, 0x001C(sp)              // ~
        sw      a0, 0x0020(sp)              // store a0, ra
        lli     a1, Roy.Action.DSP_Ground_Wait // a1(action id) = DSP_Ground_Wait
        or      a2, r0, r0                  // a2(starting frame) = 0
        lui     a3, 0x3F80                  // a3(frame speed multiplier) = 1.0
        jal     0x800E6F24                  // change action
        sw      r0, 0x0010(sp)              // argument 4 = 0
        jal     0x800E0830                  // unknown common subroutine
        lw      a0, 0x0020(sp)              // a0 = player object
        lw      ra, 0x001C(sp)              // load ra
        jr      ra                          // return
        addiu   sp, sp, 0x0020              // deallocate stack space
    }

    // @ Description
    // Subroutine which begins Roy's aerial down special wait action.
    scope air_wait_initial_: {
        addiu   sp, sp,-0x0020              // allocate stack space
        sw      ra, 0x001C(sp)              // ~
        sw      a0, 0x0020(sp)              // store a0, ra
        lli     a1, Roy.Action.DSP_Air_Wait // a1(action id) = DSP_Air_Wait
        or      a2, r0, r0                  // a2(starting frame) = 0
        lui     a3, 0x3F80                  // a3(frame speed multiplier) = 1.0
        jal     0x800E6F24                  // change action
        sw      r0, 0x0010(sp)              // argument 4 = 0s)
        jal     0x800E0830                  // unknown common subroutine
        lw      a0, 0x0020(sp)              // a0 = player object
        lw      ra, 0x001C(sp)              // load ra
        jr      ra                          // return
        addiu   sp, sp, 0x0020              // deallocate stack space
    }

    // @ Description
    // Subroutine which begins Roy's grounded down special ending action.
    scope ground_end_initial_: {
        addiu   sp, sp,-0x0020              // allocate stack space
        sw      ra, 0x001C(sp)              // ~
        sw      a0, 0x0020(sp)              // store a0, ra
        or      a2, r0, r0                  // a2(starting frame) = 0
        lui     a3, 0x3F80                  // a3(frame speed multiplier) = 1.0
        jal     0x800E6F24                  // change action
        sw      r0, 0x0010(sp)              // argument 4 = 0
        jal     0x800E0830                  // unknown common subroutine
        lw      a0, 0x0020(sp)              // a0 = player object
        lw      ra, 0x001C(sp)              // load ra
        jr      ra                          // return
        addiu   sp, sp, 0x0020              // deallocate stack space
    }

    // @ Description
    // Subroutine which begins Roy's aerial neural special ending action.
    scope air_end_initial_: {
        addiu   sp, sp,-0x0020              // allocate stack space
        sw      ra, 0x001C(sp)              // ~
        sw      a0, 0x0020(sp)              // store a0, ra
        or      a2, r0, r0                  // a2(starting frame) = 0
        lui     a3, 0x3F80                  // a3(frame speed multiplier) = 1.0
        jal     0x800E6F24                  // change action
        sw      r0, 0x0010(sp)              // argument 4 = 0
        jal     0x800E0830                  // unknown common subroutine
        lw      a0, 0x0020(sp)              // a0 = player object
        lw      ra, 0x001C(sp)              // load ra
        jr      ra                          // return
        addiu   sp, sp, 0x0020              // deallocate stack space
    }

    // @ Description
    // Main subroutine for DSP_Ground_Begin
    // If temp variable 2 is set by moveset, cancel with DSP_Ground_End when B is not held.
    scope ground_begin_main_: {
        addiu   sp, sp,-0x0018              // allocate stack space
        sw      ra, 0x0014(sp)              // store ra
        lw      v0, 0x0084(a0)              // v0 = player struct
        lw      t7, 0x0180(v0)              // t7 = temp variable 2
        beqz    t7, _check_end              // branch if temp variable 2 is not set
        lh      t7, 0x01BC(v0)              // t7 = buttons_held
        andi    t7, t7, Joypad.B            // t7 = 0x0020 if (B_HELD); else t7 = 0
        bnez    t7, _check_end              // branch if (B_HELD)
        nop

        _release:
        // if we're here then temp variable 2 is set and b is not held, so transition to ending action
        jal     ground_end_initial_         // transition to DSP_Ground_End
        nop
        b       _end
        nop

        _check_end:
        li      a1, ground_wait_initial_    // a1(transition subroutine) = ground_wait_initial_
        jal     0x800D9480                  // common main subroutine (transition on animation end)
        nop

        _end:
        lw      ra, 0x0014(sp)              // load ra
        jr      ra                          // return
        addiu   sp, sp, 0x0018              // deallocate stack space
    }

    // @ Description
    // Main subroutine for DSP_Air_Begin
    // If temp variable 2 is set by moveset, cancel with DSP_Ground_End when B is not held.
    scope air_begin_main_: {
        addiu   sp, sp,-0x0018              // allocate stack space
        sw      ra, 0x0014(sp)              // store ra
        lw      v0, 0x0084(a0)              // v0 = player struct
        lw      t7, 0x0180(v0)              // t7 = temp variable 2
        beqz    t7, _check_end              // branch if temp variable 2 is not set
        lh      t7, 0x01BC(v0)              // t7 = buttons_held
        andi    t7, t7, Joypad.B            // t7 = 0x0020 if (B_HELD); else t7 = 0
        bnez    t7, _check_end              // branch if (B_HELD)
        nop

        _release:
        // if we're here then temp variable 2 is set and b is not held, so transition to ending action
        jal     air_end_initial_            // transition to DSP_Air_End
        nop
        b       _end
        nop

        _check_end:
        li      a1, air_wait_initial_       // a1(transition subroutine) = air_wait_initial_
        jal     0x800D9480                  // common main subroutine (transition on animation end)
        nop

        _end:
        lw      ra, 0x0014(sp)              // load ra
        jr      ra                          // return
        addiu   sp, sp, 0x0018              // deallocate stack space
    }

    // @ Description
    // Main subroutine for DSP_Ground_Wait
    scope ground_wait_main_: {
        addiu   sp, sp,-0x0018              // allocate stack space
        sw      ra, 0x0014(sp)              // store ra
        lw      v0, 0x0084(a0)              // v0 = player struct
        lw      t7, 0x017C(v0)              // t7 = temp variable 1
        beqz    t7, _check_b_held           // branch if temp variable 1 is not set
        sw      r0, 0x017C(v0)              // temp variable 1 = 0
        
        // if temp variable 1 was set, increase charge level
        lw      t7, 0x0B18(v0)              // t7 = current charge level
        addiu   t7, t7, 0x0001              // increment charge level
        sw      t7, 0x0B18(v0)              // store updated charge level
        lli     at, MAX_CHARGE_LEVEL        // at = MAX_CHARGE_LEVEL
        beq     at, t7, _end_transition     // force ending if charge level is 30
        lli     a1, Roy.Action.DSP_Ground_Strong_End // a1(action id) = DSP_Ground_Strong_End

        _check_b_held:
        lh      t7, 0x01BC(v0)              // t7 = buttons_held
        andi    t7, t7, Joypad.B            // t7 = 0x0020 if (B_HELD); else t7 = 0
        bnez    t7, _end                    // branch if (B_HELD)
        lli     a1, Roy.Action.DSP_Ground_End // a1(action id) = DSP_Ground_End

        _end_transition:
        // if we reach this point, the b button is not being held, so transition to ending action
        jal     ground_end_initial_         // transition to attack
        nop

        _end:
        lw      ra, 0x0014(sp)              // load ra
        jr      ra                          // return
        addiu   sp, sp, 0x0018              // deallocate stack space
    }

    // @ Description
    // Main subroutine for DSP_Air_Wait
    scope air_wait_main_: {
        addiu   sp, sp,-0x0018              // allocate stack space
        sw      ra, 0x0014(sp)              // store ra
        lw      v0, 0x0084(a0)              // v0 = player struct
        lw      t7, 0x017C(v0)              // t7 = temp variable 1
        beqz    t7, _check_b_held           // branch if temp variable 1 is not set
        sw      r0, 0x017C(v0)              // temp variable 1 = 0
        
        // if temp variable 1 was set, increase charge level
        lw      t7, 0x0B18(v0)              // t7 = current charge level
        addiu   t7, t7, 0x0001              // increment charge level
        sw      t7, 0x0B18(v0)              // store updated charge level
        lli     at, MAX_CHARGE_LEVEL        // at = MAX_CHARGE_LEVEL
        beq     at, t7, _end_transition     // force ending if charge level is 30
        lli     a1, Roy.Action.DSP_Air_Strong_End // a1(action id) = DSP_Air_Strong_End
        
        _check_b_held:
        lh      t7, 0x01BC(v0)              // t7 = buttons_held
        andi    t7, t7, Joypad.B            // t7 = 0x0020 if (B_HELD); else t7 = 0
        bnez    t7, _end                    // branch if (B_HELD)
        lli     a1, Roy.Action.DSP_Air_End // a1(action id) = DSP_Air_End

        _end_transition:
        // if we reach this point, the b button is not being held, so transition to ending action
        jal     air_end_initial_            // transition to attack
        nop

        _end:
        lw      ra, 0x0014(sp)              // load ra
        jr      ra                          // return
        addiu   sp, sp, 0x0018              // deallocate stack space
    }


    // @ Description
    // Main subroutine for down special air ending.
    // If temp variable 1 is set by moveset, create a projectile.
    // The value of temp variable 3 will be added as bonus power to the projectile.
    scope end_main_: {
        addiu   sp, sp,-0x0040              // allocate stack space
        sw      ra, 0x0014(sp)              // 0x0014(sp) = ra
        sw      a0, 0x0034(sp)              // 0x0034(sp) = player object
        lw      v0, 0x0084(a0)              // v0 = player struct
        lw      t6, 0x0184(v0)              // t6 = temp variable 3
        beqz    t6, _check_hitboxes
        nop

        // if here, apply 10% damage to Roy
        // [ 🤓 1 ]
        lw      a0, 0x0084(a0)              // a0 = fighter struct
        jal     0x800EA248                  // apply damage
        addiu   a1, r0, 10                  // argument 1 = 10 damage to add

        lw      a0, 0x0034(sp)              // restore player object
        lw      v0, 0x0084(a0)              // v0 = player struct
        sw      r0, 0x0184(v0)              // reset varaible 3
        _check_hitboxes:
        addu    a2, a0, r0                  // a2 = player object
        lw      a0, 0x0034(sp)              // 0x0034(sp) = player object
        lw      t7, 0x0B18(v0)              // t7 = charge level
        addiu   t8, t7, 0x0008              // t8 = 8 + (charge level * 2)
        sll     t7, t7, 0x1                 // t7 = charge level * 2
        
        _check_hitbox_1:
        lw      t6, 0x0294(v0)              // t6 = hitbox 1 state
        lli     at, 0x0001                  // 0x0001
        bne     t6, at, _check_hitbox_2     // skip if hitbox state != 1
        lw      t6, 0x358(v0)               // t6 = hitbox 2 state
        // if we're here, hitbox 1 has just become active, so update the damage and shield damage
        lw      t5, 0x294 + 0xC(v0)         // t5 = hitbox 1 damage
        addu    t5, t5, t7                  // t5 = hitbox 1 damage + (charge level * 2)
        sw      t5, 0x294 + 0xC(v0)         // update hitbox 1 damage
        sw      t8, 0x294 + 0x38(v0)        // hitbox 1 shield damage = 8 + (charge level * 2)
        srl     t8, t8, 0x1                 // shield damage / 2

        _check_hitbox_2:
        bne     t6, at, _check_hitbox_3     // skip if hitbox state != 1
        lw      t6, 0x41C(v0)               // t6 = hitbox 3 state
        // if we're here, hitbox 1 has just become active, so update the damage and shield damage
        lw      t5, 0x358 + 0xC(v0)         // t5 = hitbox 2 damage
        addu    t5, t5, t7                  // t5 = hitbox 2 damage + (charge level * 2)
        sw      t5, 0x358 + 0xC(v0)         // update hitbox 2 damage
        sw      t8, 0x358 + 0x38(v0)        // hitbox 2 shield damage = 8 + (charge level * 2)
        srl     t8, t8, 0x1                 // shield damage / 2

        _check_hitbox_3:
        bne     t6, at, _check_hitbox_4     // skip if hitbox state != 1
        lw      t6, 0x4E0(v0)               // t6 = hitbox 4 state
        // if we're here, hitbox 1 has just become active, so update the damage and shield damage
        lw      t5, 0x41C + 0xC(v0)         // t5 = hitbox 3 damage
        addu    t5, t5, t7                  // t5 = hitbox 3 damage + (charge level * 2)
        sw      t5, 0x41C + 0xC(v0)         // update hitbox 3 damage
        sw      t8, 0x41C + 0x38(v0)        // hitbox 3 shield damage = 8 + (charge level * 2)
        srl     t8, t8, 0x1                 // shield damage / 2

        _check_hitbox_4:
        bne     t6, at, _idle_check         // skip if hitbox state != 1
        nop
        // if we're here, hitbox 1 has just become active, so update the damage and shield damage
        lw      t5, 0x4E0 + 0xC(v0)         // t5 = hitbox 4 damage
        addu    t5, t5, t7                  // t5 = hitbox 4 damage + (charge level * 2)
        sw      t5, 0x4E0 + 0xC(v0)         // update hitbox 4 damage
        sw      t8, 0x4E0 + 0x38(v0)        // hitbox 4 shield damage = 8 + (charge level * 2)
        srl     t8, t8, 0x1                 // shield damage / 2


        _idle_check:
        // checks the current animation frame to see if we've reached end of the animation
        mtc1    r0, f6                      // ~
        lwc1    f8, 0x0078(a0)              // ~
        c.le.s  f8, f6                      // ~
        nop
        bc1fl   _end                        // skip if animation end has not been reached
        nop
        jal     0x800DEE54                  // transition to idle
        nop

        _end:
        lw      ra, 0x0014(sp)              // load ra
        jr      ra
        addiu   sp, sp, 0x0040              // deallocate stack space
    }

    // @ Description
    // Subroutine which handles ground collision for down special actions
    scope ground_collision_: {
        addiu   sp, sp,-0x0018              // allocate stack space
        sw      ra, 0x0014(sp)              // store ra
        li      a1, ground_to_air_          // a1(transition subroutine) = ground_to_air_
        jal     0x800DDE84                  // common ground collision subroutine (transition on no floor, no slide-off)
        nop
        lw      ra, 0x0014(sp)              // load ra
        jr      ra                          // return
        addiu   sp, sp, 0x0018              // deallocate stack space
    }

    // @ Description
    // Subroutine which handles air collision for down special actions
    scope air_collision_: {
        addiu   sp, sp,-0x0018              // allocate stack space
        sw      ra, 0x0014(sp)              // store ra
        li      a1, air_to_ground_          // a1(transition subroutine) = air_to_ground_
        jal     0x800DE6E4                  // common air collision subroutine (transition on landing, no ledge grab)
        nop
        lw      ra, 0x0014(sp)              // load ra
        jr      ra                          // return
        addiu   sp, sp, 0x0018              // deallocate stack space
    }

    // @ Description
    // Subroutine which handles ground to air transition for down special actions
    scope ground_to_air_: {
        addiu   sp, sp,-0x0038              // allocate stack space
        sw      ra, 0x001C(sp)              // store ra
        sw      a0, 0x0038(sp)              // 0x0038(sp) = player object
        lw      a0, 0x0084(a0)              // a0 = player struct
        jal     0x800DEEC8                  // set aerial state
        sw      a0, 0x0034(sp)              // 0x0034(sp) = player struct
        lw      v0, 0x0034(sp)              // v0 = player struct
        lw      a0, 0x0038(sp)              // a0 = player object
        lw      t7, 0x0024(v0)              // t7 = current action
        addiu   a1, t7, 0x0004              // a1 = equivalent air action for current ground action (id + 3)
        lw      a2, 0x0078(a0)              // a2(starting frame) = current animation frame
        lui     a3, 0x3F80                  // a3(frame speed multiplier) = 1.0
        lli     t6, 0x2803                  // ~
        jal     0x800E6F24                  // change action
        sw      t6, 0x0010(sp)              // argument 4 = 0x2803 (continue: sword trails, 3C command FGM, gfx routines, hitboxes)
        jal     0x800D8EB8                  // momentum capture?
        lw      a0, 0x0034(sp)              // a0 = player struct
        lw      ra, 0x001C(sp)              // load ra
        jr      ra                          // return
        addiu   sp, sp, 0x0038              // deallocate stack space
    }

    // @ Description
    // Subroutine which handles air to ground transition for down special actions
    scope air_to_ground_: {
        addiu   sp, sp,-0x0038              // allocate stack space
        sw      ra, 0x001C(sp)              // store ra
        sw      a0, 0x0038(sp)              // 0x0038(sp) = player object
        lw      a0, 0x0084(a0)              // a0 = player struct
        jal     0x800DEE98                  // set grounded state
        sw      a0, 0x0034(sp)              // 0x0034(sp) = player struct
        lw      v0, 0x0034(sp)              // v0 = player struct
        lw      a0, 0x0038(sp)              // a0 = player object
        lw      t7, 0x0024(v0)              // t7 = current action
        addiu   a1, t7,-0x0004              // a1 = equivalent ground action for current air action (id - 3)
        lw      a2, 0x0078(a0)              // a2(starting frame) = current animation frame
        lui     a3, 0x3F80                  // a3(frame speed multiplier) = 1.0
        lli     t6, 0x2803                  // ~
        jal     0x800E6F24                  // change action
        sw      t6, 0x0010(sp)              // argument 4 = 0x2803 (continue: sword trails, 3C command FGM, gfx routines, hitboxes)
        lw      ra, 0x001C(sp)              // load ra
        jr      ra                          // return
        addiu   sp, sp, 0x0038              // deallocate stack space
    }
}