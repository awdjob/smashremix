// DSamusSpecial.asm

// This file contains file inclusions, action edits, and assembly for Dark Samus.

scope DSamusNSP {
    //  sets shoot variable if b button pressed during aerial charge start
    scope aerial_b_button_buffer_kirby: {
        lw      v0, 0x0084(a0)
        lb      t0, 0x0980(v0)      // t0 = current hat ID
        addiu   at, r0, 0x13        // at = dsamus hat id

        bne     at, t0, _normal
        nop
        // dsamus hat
        j     0x8015D464            // set shoot variable if b button pressed
        nop

        _normal:
        jr      ra
        nop
    }

    // original line makes sure that samus shoots if variable is set to 1
    scope initial_variable_override: {
        OS.patch_start(0xD8660, 0x8015DC20)
        j       initial_variable_override
        nop
        _return:
        OS.patch_end()

        lw      t7, 0x0008(t8)      // t7 = character id
        addiu   at, r0, Character.id.DSAMUS
        beq     t7, at, _dark_samus
        nop
        _samus:
        addiu   t7, r0, 0x0001      // og 1
        j       _return
        sw      t7, 0x0B18(t8)      // og 2

        _dark_samus:
        lw      t7, 0x0ADC(t8)      // get current ammo
        addiu   at, r0, 7
        beq     at, t7, _samus
        nop
        j       _return
        sw      r0, 0x0B18(t8)      // don't auto shoot
    }

    // original line makes sure that samus shoots if variable is set to 1
    scope initial_variable_override_kirby: {
        OS.patch_start(0xD21C8, 0x80157788)
        j       initial_variable_override_kirby
        nop
        _return:
        OS.patch_end()

        lb      t7, 0x0980(t8)      // t7 = current hat ID
        addiu   at, r0, 0x13        // at = dsamus hat id
        beq     t7, at, _dark_samus
        nop
        _samus:
        addiu   t7, r0, 0x0001      // og 1
        j       _return
        sw      t7, 0x0B18(t8)      // og 2

        _dark_samus:
        lw      t7, 0x0AE0(t8)      // get current ammo
        addiu   at, r0, 7
        beq     at, t7, _samus
        nop
        j       _return
        sw      r0, 0x0B18(t8)      // don't auto shoot
    }

    // remove shoot variable from activating if Dsamus in shoot begin action and transition to aerial
    scope remove_shoot_flag_aerial_transition: {
        OS.patch_start(0xD7FD0, 0x8015D590)
        j       remove_shoot_flag_aerial_transition
        sw      t9, 0x09ec(s0)  // og line 1
        _return:
        OS.patch_end()

        lw      t9, 0x0008(s0)  // t9 = character id
        addiu   at, r0, Character.id.DSAMUS

        beq     t9, at, _dsamus // branch for dark samus
        nop

        // samus
        j       _return
        sw      t0, 0x0b18(s0)  // og line 2, resets variable for samus

        _dsamus:
        j       _return         // dont overwrite transition variable if Dsamus
        nop


    }

    // remove shoot variable from activating if kirby in shoot begin action and transition to aerial
    scope remove_shoot_flag_aerial_transition_kirby: {
        OS.patch_start(0xD1B38, 0x801570F8)
        j       remove_shoot_flag_aerial_transition_kirby
        sw      t9, 0x09EC(s0)  // og line 1
        _return:
        OS.patch_end()

        lb      t9, 0x0980(s0)      // t0 = current hat ID
        addiu   at, r0, 0x13        // at = dsamus hat id
        beq     t9, at, _dsamus     // branch if dsamus hat
        nop

        //_samus:
        j       _return
        sw      t0, 0x0b18(s0)  // og line 2, resets variable for samus

        _dsamus:
        j       _return         // dont overwrite transition variable if Dsamus hat
        nop


    }

    // hook to Samus start main where it sets the action to shoot if aerial
    scope check_aerial_charge: {
        OS.patch_start(0xD7E60, 0x8015D420)
        j       check_aerial_charge
        lw      t0, 0x0084(a0)      // t0 = player struct
        _return:
        OS.patch_end();

        lw      t1, 0x0008(t0)      // t1 = character id
        addiu   at, r0, Character.id.DSAMUS

        bne     t1, at, _shoot      // shoot if Samus
        lw      t1, 0x0ADC(t0)      // get ammo
        addiu   at, r0, 7           // at = max ammo count
        beq     at, t1, _shoot      // shoot if ammo == max ammo
        nop
        lw      t0, 0x0B18(t0)      // check shoot variable if player buffer B press
        bnez    t0, _shoot
        nop
        jal     set_aerial_charge
        nop
        j       _return
        nop

        // dark samus here
        _shoot:
        jal     0x8015DAA8              // og 1, shoot
        nop                             // og 2
        j       _return
        nop
    }


    // sets the action to dsamus's aerial charge action
    scope set_aerial_charge: {
        addiu   sp, sp, -0x38
        sw      ra, 0x0024 (sp)
        sw      s0, 0x0020 (sp)
        lw      s0, 0x0084 (a0)
        addiu   t6, r0, 0x0002
        sw      t6, 0x0010 (sp)
        sw      a0, 0x0038 (sp)
        addiu   a1, r0, 0x00E7      // a1 = DSamus Charge
        j       0x8015D754          // set charge action
        nop
    }

    // hook to Kirby Samus start main where it sets the action to shoot if aerial
    scope check_aerial_charge_kirby: {
        OS.patch_start(0xD19C8, 0x80156F88)
        j       check_aerial_charge_kirby
        lb      t0, 0x0980(v0)      // t0 = current hat ID
        _return:
        OS.patch_end();

        addiu   at, r0, 0x13        // at = dsamus hat id

        bne     t0, at, _shoot      // shoot if not Dark Samus
        lw      t1, 0x0AE0(v0)      // get ammo

        addiu   at, r0, 7           // at = max ammo count
        beq     at, t1, _shoot      // shoot if ammo == max ammo
        nop
        lw      t0, 0x0B18(v0)      // check shoot variable if player buffer B press
        bnez    t0, _shoot
        nop
        jal     set_aerial_charge_kirby
        nop
        j       _return
        nop

        _shoot:
        jal     0x80157610              // og 1, shoot
        nop                             // og 2
        j       _return
        nop
    }



    // sets the action to dsamus's aerial charge action
    // part of 0x8015729C
    scope set_aerial_charge_kirby: {
        addiu   sp, sp, -0x38
        sw      ra, 0x0024(sp)
        sw      s0, 0x0020(sp)
        lw      s0, 0x0084(a0)
        addiu   t6, r0, 0x0002
        sw      t6, 0x0010(sp)
        sw      a0, 0x0038(sp)
        addiu   a1, r0, Action.KIRBY.DSamusNSPChargeAir      // a1 = DSamus Charge
        j       0x801572BC          // set charge action
        nop
    }

    // based on Samus grounded @ 0x8015D5AC
    scope air_charge_main: {
        addiu   sp, sp, -0x20
        sw      ra, 0x0014(sp)
        lw      a3, 0x0084(a0)
        lw      t6, 0x0b1c(a3)
        addiu   t7, t6, 0xffff
        bnez    t7, _end
        sw      t7, 0x0b1c(a3)
        lw      v0, 0x0adc(a3)
        addiu   t9, r0, 0x0014
        sw      t9, 0x0b1c(a3)
        slti    at, v0, 0x0007
        beqz    at, _end
        addiu   t0, v0, 0x0001
        addiu   at, r0, 0x0007
        sw      t0, 0x0adc(a3)
        bne     t0, at, _branch
        or      v0, t0, r0
        addiu   a1, r0, 0x0006
        or      a2, r0, r0
        sw      a0, 0x0020(sp)
        jal     0x800e9814
        sw      a3, 0x001c(sp)
        jal     0x8015d300
        lw      a0, 0x001c(sp)
        //jal     0x8013e1c8  // set idle?
        jal     0x800DEE54    // set aerial idle
        lw      a0, 0x0020(sp)
        b       _end_2
        lw      ra, 0x0014(sp)

        _branch:
        lw      a0, 0x0b20(a3)
        beqzl   a0, _end_2
        lw      ra, 0x0014(sp)
        lw      v1, 0x0084(a0)
        sw      v0, 0x02a4(v1)

        _end:
        lw      ra, 0x0014(sp)

        _end_2:
        jr      ra
        addiu   sp, sp, 0x20

    }

    // based on Samus grounded @ 0x80157114
    scope air_charge_kirby_main: {
        addiu   sp, sp, -0x20
        sw      ra, 0x0014(sp)
        lw      a3, 0x0084(a0)
        lw      t6, 0x0b1c(a3)
        addiu   t7, t6, 0xffff
        bnez    t7, _end
        sw      t7, 0x0b1c(a3)
        lw      v0, 0x0AE0(a3)
        addiu   t9, r0, 0x0014
        sw      t9, 0x0b1c(a3)
        slti    at, v0, 0x0007
        beqz    at, _end
        addiu   t0, v0, 0x0001
        addiu   at, r0, 0x0007
        sw      t0, 0x0AE0(a3)
        bne     t0, at, _branch
        or      v0, t0, r0
        addiu   a1, r0, 0x0006
        or      a2, r0, r0
        sw      a0, 0x0020(sp)
        jal     0x800e9814
        sw      a3, 0x001c(sp)
        jal     0x80156E60
        lw      a0, 0x001c(sp)
        //jal     0x8013e1c8  // set idle?
        jal     0x800DEE54    // set aerial idle
        lw      a0, 0x0020(sp)
        b       _end_2
        lw      ra, 0x0014(sp)

        _branch:
        lw      a0, 0x0b20(a3)
        beqzl   a0, _end_2
        lw      ra, 0x0014(sp)
        lw      v1, 0x0084(a0)
        sw      v0, 0x02a4(v1)

        _end:
        lw      ra, 0x0014(sp)

        _end_2:
        jr      ra
        addiu   sp, sp, 0x20

    }

    // @ Description
    // Interrupt subroutine for NSP_Air_Charge.
    // Loosely based on subroutine 0x8015D640, which is the interrupt subroutine for Samus' grounded neutral special charge.
    scope air_charge_interrupt_: {
        addiu   sp, sp,-0x0030              // allocate stack space
        sw      ra, 0x0014(sp)              // store ra

        // begin by checking for A or B presses
        lw      a1, 0x0084(a0)              // a1 = player struct
        lhu     v0, 0x01BE(a1)              // v0 = buttons_pressed
        andi    t6, v0, Joypad.B            // t6 = 0x4000 if (B_PRESSED); else t6 = 0
        andi    t7, v0, Joypad.A            // t7 = 0x8000 if (A_PRESSED); else t6 = 0
        or      at, t6, t7                  // at = !0 if (A_PRESSED) or (B_PRESSED), else at = 0
        beqz    at, _check_cancel           // branch if both A and B are not being pressed
        nop

        // if we're here, A or B has been pressed, so transition to NSP_Air_Shoot
        lw      t0, 0x0008(a1)              // t0 = character id
        addiu   at, r0, Character.id.DSAMUS
        beq     at, t0, _dsamus
        nop

        // kirby
        jal      0x80157610
        nop
        b       _end                        // end
        lw      ra, 0x0014(sp)              // load ra

        _dsamus:
        jal     0x8015DAA8                  // air_shoot_initial_
        nop
        b       _end                        // end
        lw      ra, 0x0014(sp)              // load ra

        _check_cancel:
        // now check if Shield button has been pressed
        lhu     at, 0x01B8(a1)              // at = shield press bitmask
        and     at, at, v0                  // at != 0 if shield pressed; else at = 0
        beql    at, r0, _end                // end if shield is not pressed
        lw      ra, 0x0014(sp)              // load ra

        // if we're here, Z has been pressed, so transition to fall
        sw      a0, 0x0020(sp)              // 0x0020(sp) = player object
        jal     0x8015D300                  // destroy attached projectile
        lw      a0, 0x0084(a0)              // a0 = player struct
        jal     0x8013F9E0                  // transition to fall
        lw      a0, 0x0020(sp)              // a0 = player object
        lw      ra, 0x0014(sp)              // load ra

        _end:
        jr      ra                          // return
        addiu   sp, sp, 0x0030              // dellocate stack space
    }

    // @ Description
    // Collision subroutine for NSP_Ground_Charge.
    scope ground_charge_collision_: {
        addiu   sp, sp, -0x0018              // allocate stack space
        sw      ra, 0x0014(sp)              // store ra
        sw      a0, 0x0018(sp)
        jal     0x8015D394                  // attach ball
        lw      a0, 0x0084(a0)
        li      a1, air_charge_transition_  // a1(transition subroutine) = air_charge_transition_
        jal     0x800DDE84                  // common ground collision subroutine (transition on no floor, no slide-off)
        lw      a0, 0x0018(sp)
        lw      ra, 0x0014(sp)              // load ra
        jr      ra                          // return
        addiu   sp, sp, 0x0018              // deallocate stack space
    }

    // @ Description
    // Collision subroutine for Kirby's NSP_Ground_Charge.
    scope kirby_ground_charge_collision_: {
        addiu   sp, sp,-0x0018              // allocate stack space
        sw      ra, 0x0014(sp)              // store ra
        sw      a0, 0x0018(sp)
        jal     0x80156EFC                  // attach ball
        lw      a0, 0x0084(a0)
        li      a1, air_charge_transition_  // a1(transition subroutine) = air_charge_transition_
        jal     0x800DDDDC                  // common ground collision subroutine (transition on no floor, slide-off)
        lw      a0, 0x0018(sp)
        lw      ra, 0x0014(sp)              // load ra
        jr      ra                          // return
        addiu   sp, sp, 0x0018              // deallocate stack space
    }

    // @ Description
    // Subroutine which transitions to NSP_Air_Charge.
    scope air_charge_transition_: {
        addiu   sp, sp,-0x0030              // allocate stack spcae
        sw      s0, 0x0020(sp)              // ~
        sw      ra, 0x0024(sp)              // ~
        sw      a0, 0x0028(sp)              // store s0, ra, a0
        lw      s0, 0x0084(a0)              // s0 = player struct
        jal     0x800DEEC8                  // set aerial state
        or      a0, s0, r0                  // a0 = player struct
        jal     0x800D8EB8                  // momentum capture?
        or      a0, s0, r0                  // a0 = player struct
        lw      a0, 0x0028(sp)              // a0 = player object

        lw      a2, 0x0008(s0)              // a2 = current character ID
        lli     a1, Character.id.KIRBY      // a1 = id.KIRBY
        beql    a1, a2, pc() + 24           // if Kirby, load alternate action ID
        lli     a1, Action.KIRBY.DSamusNSPChargeAir
        lli     a1, Character.id.JKIRBY     // a1 = id.JKIRBY
        beql    a1, a2, pc() + 12           // if J Kirby, load alternate action ID
        lli     a1, Action.KIRBY.DSamusNSPChargeAir

        lli     a1, 0x00E7                  // a1(action id) = NSP_Air_Charge
        lw      a2, 0x0078(a0)              // a2(starting frame) = current animation frame
        lui     a3, 0x3F80                  // a3(frame speed multiplier) = 1.0
        lli     t8, 0x0802                  // ~
        jal     0x800E6F24                  // change action
        sw      t8, 0x0010(sp)              // argument 4 = 0x0802

        lw      t7, 0x0008(s0)              // t7 = current character ID
        lli     at, Character.id.KIRBY      // at = id.KIRBY
        beq     t7, at, _kirby              // branch if character = KIRBY
        lli     at, Character.id.JKIRBY     // at = id.JKIRBY
        bne     t7, at, _dsamus             // branch if character != JKIRBY
        nop

        _kirby:
        li      t7, 0x80156E98              // t7 = kirby's on hit subroutine
        b       _end                        // branch to end
        nop

        _dsamus:
        li      t7, 0x8015D338              // t7 = on hit subroutine

        _end:
        sw      t7, 0x09EC(s0)              // store on hit subroutine in player struct
        lw      s0, 0x0020(sp)              // ~
        lw      ra, 0x0024(sp)              // load s0, ra
        jr      ra                          // return
        addiu   sp, sp, 0x0030              // deallocate stack space
    }

    // @ Description
    // Collision subroutine for NSP_Ground_Charge
    // samus has 0x8015D700
    scope air_charge_collision_: {
        addiu   sp, sp,-0x0018              // allocate stack space
        sw      ra, 0x0014(sp)              // store ra
        sw      a0, 0x0018(sp)
        jal     0x8015D394                  // attach ball
        lw      a0, 0x0084(a0)

        li      a1, ground_charge_transition_ // a1(transition subroutine) = ground_charge_transition_
        jal     0x800DE6E4                  // common air collision subroutine (transition on landing, no ledge grab)
        lw      a0, 0x0018(sp)
        lw      ra, 0x0014(sp)              // load ra
        jr      ra                          // return
        addiu   sp, sp, 0x0018              // deallocate stack space
    }

    // @ Description
    // Collision subroutine for NSP_Ground_Charge
    // samus has 0x80157268
    scope air_charge_collision_kirby_: {
        addiu   sp, sp,-0x0018              // allocate stack space
        sw      ra, 0x0014(sp)              // store ra
        sw      a0, 0x0018(sp)
        jal     0x80156EFC                  // attach ball
        lw      a0, 0x0084(a0)

        li      a1, ground_charge_transition_ // a1(transition subroutine) = ground_charge_transition_
        jal     0x800DE6E4                  // common air collision subroutine (transition on landing, no ledge grab)
        lw      a0, 0x0018(sp)
        lw      ra, 0x0014(sp)              // load ra
        jr      ra                          // return
        addiu   sp, sp, 0x0018              // deallocate stack space
    }

    // @ Description
    // Subroutine which transitions to NSP_Ground_Charge.
    scope ground_charge_transition_: {
        addiu   sp, sp,-0x0030              // allocate stack spcae
        sw      s0, 0x0020(sp)              // ~
        sw      ra, 0x0024(sp)              // ~
        sw      a0, 0x0028(sp)              // store s0, ra, a0
        lw      s0, 0x0084(a0)              // s0 = player struct
        jal     0x800DEE98                  // set grounded state
        or      a0, s0, r0                  // a0 = player struct
        lw      a0, 0x0028(sp)              // a0 = player object

        lw      a2, 0x0008(s0)              // a2 = current character ID
        lli     a1, Character.id.KIRBY      // a1 = id.KIRBY
        beql    a1, a2, pc() + 24           // if Kirby, load alternate action ID
        lli     a1, Action.KIRBY.DSCharging
        lli     a1, Character.id.JKIRBY     // a1 = id.JKIRBY
        beql    a1, a2, pc() + 12           // if J Kirby, load alternate action ID
        lli     a1, Action.KIRBY.DSCharging // ground charge

        lli     a1, 0x00DF                  // a1(action id) = NSP_Ground_Charge
        lw      a2, 0x0078(a0)              // a2(starting frame) = current animation frame
        lui     a3, 0x3F80                  // a3(frame speed multiplier) = 1.0
        lli     t8, 0x0802                  // ~
        jal     0x800E6F24                  // change action
        sw      t8, 0x0010(sp)              // argument 4 = 0x0802

        lw      t7, 0x0008(s0)              // t7 = current character ID
        lli     at, Character.id.KIRBY      // at = id.KIRBY
        beq     t7, at, _kirby              // branch if character = KIRBY
        lli     at, Character.id.JKIRBY     // at = id.JKIRBY
        bne     t7, at, _dsamus             // branch if character != JKIRBY
        nop

        _kirby:
        li      t7, 0x80156E98              // t7 = kirby's on hit subroutine
        b       _end                        // branch to end
        nop

        _dsamus:
        li      t7, 0x8015D338              // t7 = on hit subroutine

        _end:
        sw      t7, 0x09EC(s0)              // store on hit subroutine in player struct
        lw      s0, 0x0020(sp)              // ~
        lw      ra, 0x0024(sp)              // load s0, ra
        jr      ra                          // return
        addiu   sp, sp, 0x0030              // deallocate stack space
    }

    // @ Description
    // Patch which loads a different apply_charge_level_ function for Dark Samus
    scope charge_level_patch_: {
        OS.patch_start(0xE36A4, 0x80168C64)
        jal     charge_level_patch_
        OS.patch_end()
        OS.patch_start(0xE3890, 0x80168E50)
        jal     charge_level_patch_
        OS.patch_end()

        OS.routine_begin(0x30)
        lw      v0, 0x0084(a0)              // v0 = projectile special struct
        lw      v0, 0x0008(v0)              // v0 = owner object
        beqz    v0, _original               // skip if no owner object
        nop
        lw      v0, 0x0084(v0)              // v0 = owner player struct
        beqz    v0, _original               // skip if no player struct
        lli     at, Character.id.DSAMUS     // at = id.DSAMUS

        lw      t6, 0x0008(v0)              // t6 = character id
        beq     t6, at, _dark_samus         // branch if character = DSAMUS
        nop
        // kirby hat check
        lb      t6, 0x0980(v0)              // t0 = current hat ID
        addiu   at, r0, 0x13                // at = dsamus hat id
        beq     t6, at, _dark_samus         // branch if wearing Dark Samus hat
        nop

        b       _original
        nop

        // if the character is dark samus
        _dark_samus:
        jal     apply_charge_level_         // use this instead
        nop
        b       _end                        // end function
        nop

        _original:
        jal     0x80168B00                  // original line 1
        nop

        _end:
        OS.routine_end(0x30)
    }

    // @ Description
    // Subroutine for applying charge levels to Dark Charge Shot.
    // Based on subroutine 0x80168B00 which applies charge levels for Charge Shot.
    scope apply_charge_level_: {
        addiu   sp, sp,-0x0020              // allocate stack space
        sw      ra, 0x0014(sp)              // store ra
        lw      v0, 0x0084(a0)              // v0 = item special struct
        li      t8, charge_level_array      // t8 = charge_level_array
        // Copy the next 34 lines of subroutine 0x80168B00
        OS.copy_segment(0xE3554, 0x88)
        li      t5, charge_level_array      // t5 = charge_level_array
        // Copy the next 14 lines of subroutine 0x80168B00
        OS.copy_segment(0xE35E4, 0x38)
    }

    // @ Description
    // Adds a charge level struct for Mewtwo.
    // graphic_size - graphic size multiplier
    // speed - x speed
    // damage - hitbox damage
    // hitbox_size - hitbox size
    // unknown_1 - unknown, always 10 for charge shot
    // shot_fgm - fgm to play when shooting
    // charge_fgm - fgm to play when charging
    // hit_fgm - fgm to play when the projectile hits an opponent
    // priority - clang priority (all projectiles are 1 other than full charge shot)
    macro add_charge_level(graphic_size, speed, damage, hitbox_size, unknown_1, shot_fgm, charge_fgm, hit_fgm, priority) {
        float32 {graphic_size}              // 0x00 - graphic size multiplier
        float32 {speed}                     // 0x04 - x speed
        dw {damage}                         // 0x08 - hitbox damage
        dw {hitbox_size}                    // 0x0C - hitbox size
        dw {unknown_1}                      // 0x10 - unknown, always 10 for charge shot
        dw {shot_fgm}                       // 0x14 - fgm to play when shooting
        dw {charge_fgm}                     // 0x18 - fgm to play when charging
        dw {hit_fgm}                        // 0x1C - fgm to play when the projectile hits an opponent
        dw {priority}                       // 0x20 - clang priority (all projectiles are 1 other than full charge shot)
    }

    OS.align(16)
    charge_level_array:
    add_charge_level(120, 60,  2,  75, 10, 0xEE, 0xEF, 0x18, 1) // level 0
    add_charge_level(180, 55,  4, 100, 10, 0xEE, 0xF0, 0x18, 1) // level 1
    add_charge_level(250, 50,  6, 125, 10, 0xED, 0xF1, 0x17, 1) // level 2
    add_charge_level(320, 45,  9, 150, 10, 0xED, 0xF2, 0x17, 1) // level 3
    add_charge_level(400, 40, 12, 175, 10, 0xED, 0xF3, 0x17, 1) // level 4
    add_charge_level(490, 35, 15, 200, 10, 0xEC, 0xF4, 0x16, 1) // level 5
    add_charge_level(620, 30, 18, 225, 10, 0xEC, 0xF5, 0x16, 1) // level 6
    add_charge_level(740, 25, 24, 275, 10, 0xEB, 0xF6, 0x16, 2) // level 7
}

scope DSamusDSP {
    constant JUMP_SPEED(0x4200)             // float32 32
    constant GROUND_X_MULTIPLIER(0x3F20)    // float32 0.625
    constant GROUND_ACCELERATION(0x4120)    // float32 10
    constant GROUND_Y_VELOCITY(0x4100)      // float32 8
    constant AIR_X_SPEED(0x428C)            // float32 70
    constant AIR_Y_SPEED(0xC220)            // float32 -40
    constant AIR_ACCELERATION(0x3E40)       // float32 0.1875

    // @ Description
    // Physics subroutine for Aerial DSP
    scope air_physics_: {
        OS.routine_begin(0x30)
        sw      a0, 0x0018(sp)              // 0x0018(sp) = player object
        lw      a0, 0x0084(a0)              // a0 = player struct
        lw      t6, 0x0180(a0)              // t6 = temp variable 2
        beqz    t6, _continue               // branch if temp variable 2 isn't set
        lli     at, 0x0001                  // ~

        // if temp variable 2 was set
        bnel    at, t6, _end_movement       // end movement if temp variable 2 != 1
        sw      r0, 0x0180(a0)              // reset temp variable 2 on branch

        // if temp variable 2 = 1
        lui     at, AIR_X_SPEED             // ~
        mtc1    at, f2                      // f2 = AIR_X_SPEED
        lwc1    f4, 0x0044(a0)              // ~
        cvt.s.w f4, f4                      // f4 = DIRECTION
        mul.s   f2, f2, f4                  // f2 = X_VELOCITY * DIRECTION
        swc1    f2, 0x0048(a0)              // store AIR_X_SPEED
        lui     at, AIR_Y_SPEED             // ~
        b       _end                        // branch to end
        sw      at, 0x004C(a0)              // store AIR_Y_SPEED

        _end_movement:
        lui     at, 0x3F00                  // ~
        mtc1    at, f2                      // at = 0.5
        lwc1    f4, 0x0048(a0)              // f4 = x velocity
        mul.s   f4, f4, f2                  // f4 = x velocity * 0.5
        b       _end                        // branch to end
        swc1    f4, 0x0048(a0)              // store updated x velocity

        _continue:
        jal     0x8015E050                  // original air physics
        lw      a0, 0x0018(sp)              // a0 = player object

        _end:
        OS.routine_end(0x30)
    }

    // @ Description
    // Collision subroutine for aerial DSP.
    // Transitions into the down special landing action when temp variable 2 = 1,
    // otherwise lands normally.
    scope air_collision_: {
        addiu   sp, sp,-0x0018              // allocate stack space
        sw      a0, 0x0010(sp)              // ~
        sw      ra, 0x0014(sp)              // store ra, a0
        lw      a1, 0x0084(a0)              // a1 = player struct

        lw      v0, 0x184(a1)               // v0 = temp variable 3
        bnez    v0, _main_collision         // branch if temp variable 3 is set
        nop

        // If Dark Samus is not in the ground pound motion, run a normal aerial collision subroutine
        // instead.
        jal     0x800DE99C                  // aerial collision subroutine
        nop
        b       _end                        // branch to end
        nop

        _main_collision:
        li      a1, landing_initial_        // a1 = landing_initial_
        jal     0x800DE6E4                  // common air collision subroutine (transition on landing, no ledge grab)
        lw      a0, 0x0010(sp)              // load a0

        _end:
        lw      ra, 0x0014(sp)              // load ra
        addiu   sp, sp, 0x0018              // deallocate stack space
        jr      ra
        nop
    }

    // @ Description
    // Initial function for DSPLanding
    // Copy of subroutine 0x801600EC, which begins the landing action for Falcon Kick.
    // Loads the appropriate landing action for Dark Samus.
    scope landing_initial_: {
        // Copy the first 6 lines of subroutine 0x801600EC
        OS.copy_segment(0xDAB2C, 0x18)
        // Replace original line which loads the landing action id
        // addiu   a1, r0, 0x00E8           // replaced line
        lw      t6, 0x0084(a0)              // t6 = player struct
        lui     at, 0x3F20                  // ~
        mtc1    at, f2                      // f2 = 0.625
        lwc1    f4, 0x0060(t6)              // f4 = ground x velocity
        mul.s   f4, f4, f2                  // f4 = ground x velocity * 0.625
        swc1    f4, 0x0060(t6)              // store updated ground x velocity
        lli     a1, DSamus.Action.DSPLanding // a1 = Action.DSPLanding
        // Copy the last 8 lines of subroutine 0x801600EC
        OS.copy_segment(0xDAB48, 0x20)
    }

    // @ Description
    // Collision subroutine for DSP.
    scope ground_collision_: {
        addiu   sp, sp, -0x0028             // allocate stack space
        sw      ra, 0x0014(sp)              // store ra
        sw      a0, 0x0018(sp)              // 0x0018(sp) = player object
        lw      a0, 0x0084(a0)              // a0 = player struct
        lw      v0, 0x0184(a0)              // v0 = temp variable 3
        beqz    v0, _collision_check        // skip if temp variable 3 is not set
        nop

        jal     0x8013F474                  // check jump (returns 0 for no jump)
        nop

        beq     v0, r0, _collision_check    // skip if !jump
        nop

        // if we're here then Dark Samus has input a jump, so transition to NSPA with jump velocity
        jal     ground_to_air_jump_         // jump transition
        lw      a0, 0x0018(sp)              // a0 = player object
        b       _end
        nop

        _collision_check:
        li      a1, ground_to_air_          // a1 = ground_to_air_
        jal     0x800DDDDC                  // common ground collision subroutine (transition on no floor, slide-off)
        lw      a0, 0x0018(sp)              // a0 = player object

        _end:
        lw      ra, 0x0014(sp)              // load ra
        jr      ra                          // return
        addiu   sp, sp, 0x0028              // deallocate stack space
    }

    // @ Description
    // Subroutine which handles ground to air transition for neutral special jump
    scope ground_to_air_: {
        OS.routine_begin(0x50)
        jal     0x8015E1DC                  // transition to DSPA
        sw      a0, 0x0038(sp)              // 0x0038(sp) = player object

        // slow x velocity
        lw      a0, 0x0038(sp)              // load a0
        lw      a0, 0x0084(a0)              // a0 = player struct
        sw      r0, 0x0180(a0)              // reset temp variable 2
        lui     at, 0x3F20                  // ~
        mtc1    at, f2                      // f2 = 0.625
        lwc1    f4, 0x0048(a0)              // f4 = x velocity
        mul.s   f4, f4, f2                  // f4 = x velocity * 0.625
        swc1    f4, 0x0048(a0)              // store updated x velocity
        OS.routine_end(0x50)
    }

    // @ Description
    // Subroutine which handles ground to air transition for down special jump
    scope ground_to_air_jump_: {
        OS.routine_begin(0x50)
        jal     0x8015E1DC                  // transition to DSPA
        sw      a0, 0x0038(sp)              // 0x0038(sp) = player object

        // apply jump velocity
        lw      a0, 0x0038(sp)              // load a0
        lw      a0, 0x0084(a0)              // a0 = player struct
        sw      r0, 0x0180(a0)              // reset temp variable 2
        lui     at, 0x3F20                  // ~
        mtc1    at, f2                      // f2 = 0.625
        lwc1    f4, 0x0048(a0)              // f4 = x velocity
        mul.s   f4, f4, f2                  // f2 = x velocity * 0.625
        swc1    f4, 0x0048(a0)              // store updated x velocity
        lui     at, JUMP_SPEED              // at = JUMP_SPEED
        sw      at, 0x004C(a0)              // y velocity = JUMP_SPEED
        // create gfx
        lw      a0, 0x0078(a0)              // a0 = player x/y/z pointer
        ori     a1, r0, 0x0001              // a1 = 0x1
        jal     0x800FF3F4                  // jump smoke graphic
        lui     a2, 0x3F80                  // a2 = float: 1.0
        OS.routine_end(0x50)
    }

    // @ Description
    // Patches the x speed/acceleration for Grounded DSP
    scope ground_x_physics_patch_: {
        OS.patch_start(0xD8A60, 0x8015E020)
        j       ground_x_physics_patch_
        nop
        _return:
        OS.patch_end();

        lw      t6, 0x0008(a0)              // t6 = character id
        addiu   at, r0, Character.id.DSAMUS
        bne     t6, at, _original           // branch if not dark samus
        nop

        // load new values for Dark Samsu
        lui     a1, GROUND_X_MULTIPLIER
        lui     a2, GROUND_ACCELERATION

        _original:
        jal     0x800D8ADC                  // original line
        nop

        j       _return                     // return
        nop
    }

    // @ Description
    // Patches the inital y velocity for Grounded DSP
    scope ground_y_velocity_patch_: {
        OS.patch_start(0xD8BEC, 0x8015E1AC)
        j       ground_y_velocity_patch_
        lui     at, 0x4220                  // original line 1
        _return:
        OS.patch_end();

        lw      t8, 0x0008(s0)              // t8 = character id
        addiu   t9, r0, Character.id.DSAMUS
        beql    t8, t9, _end                // branch if dark samus...
        lui     at, GROUND_Y_VELOCITY       // ...and load alternate value

        _end:
        j       _return                     // return
        mtc1    at, f4                      // original line 2
    }

    // @ Description
    // Patches the x speed/acceleration for Grounded DSP
    scope air_x_physics_patch_: {
        OS.patch_start(0xD8B00, 0x8015E0C0)
        j       air_x_physics_patch_
        nop
        _return:
        OS.patch_end();

        lw      t6, 0x0008(a0)              // t6 = character id
        addiu   at, r0, Character.id.DSAMUS
        beql    t6, at, _original           // branch if dark samus...
        lui     a2, AIR_ACCELERATION        // ...and load alternate value

        _original:
        jal     0x800D8FC8                  // original line
        nop

        j       _return                     // return
        nop
    }

    // @ Description
    // Patches the initial action for aerial DSP
    scope air_action_patch_: {
        OS.patch_start(0xD8CC4, 0x8015E284)
        j       air_action_patch_
        nop
        _return:
        OS.patch_end();

        lw      t6, 0x0008(s0)              // t6 = character id
        lli     at, Character.id.DSAMUS
        beql    t6, at, _end                // branch if dark samus...
        lli     a1, DSamus.Action.DSPAir    // ...and load alternate action

        lli     a1, Action.SAMUS.BombAir    // original line 1

        _end:
        j       _return                     // return
        or      a2, r0, r0                  // original line 2
    }

    // @ Description
    // Patches the initial variables for DSP
    scope init_variables_patch_: {
        OS.patch_start(0xD8C58, 0x8015E218)
        j       init_variables_patch_
        OS.patch_end();

        sw      r0, 0x0180(a0)              // reset temp variable 2 (should be harmless for samus lol)
        jr      ra
        sw      r0, 0x0184(a0)              // reset temp variable 3 (should be harmless for samus lol)
    }

    // @ Description
    // Patches the air to ground function for Samus DSP
    // Should be harmless for Samus lol
    scope air_to_ground_patch_: {
        OS.patch_start(0xD8B98, 0x8015E158)
        j       air_to_ground_patch_
        lli     t6, 0x2003                  // ~
        _return:
        OS.patch_end();

        jal     0x800E6F24                  // change action
        sw      t6, 0x0010(sp)              // argument 4 = 0x2003 (continue: sword trails, gfx routines, hitboxes)
        j       _return
        nop
    }

    // @ Description
    // Patches the ground to air function for Samus DSP
    // Should be harmless for Samus lol
    scope ground_to_air_patch_: {
    OS.patch_start(0xD8C40, 0x8015E200)
        j       ground_to_air_patch_
        lli     t6, 0x2003                  // ~
        _return:
        OS.patch_end();

        jal     0x800E6F24                  // change action
        sw      t6, 0x0010(sp)              // argument 4 = 0x2003 (continue: sword trails, gfx routines, hitboxes)
        j       _return
        nop
    }
}

// 8015E1AC - ground y velocity (4100?)
// 8018C8E0 - ground x speed multiplier

// 8015E00C - load x speed multiplier
// 8015E014 - load acceleration

// 8015E0B8 - load air acceleration? 3E40?

// 8015E020 - JAL to apply movement (a1 = x speed multiplier, a2 = acceleration)
// a1 = 3F20, a2 - 4120?