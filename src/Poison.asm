// @ Description
// Apply poison effects
scope Poison {

    poisoned_players:
    dw 0        // duration
    dw 0        // damage per x frames (must be negative value)
    dw 0        // poison type
    dw 0        // unused
    dw 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 // ports 2, 3 and 4

    constant DAMAGE_SFX(0x1C)
    constant OVERLAY(0x79)

    // modified branch so it doesn't crash from poison_hook
    scope star_fix: {
        OS.patch_start(0x5D008, 0x800E1808)
        j       star_fix        // og line 1 = BNEL V0, AT, 0x800E1824
        nop                     // og line 2 = LW V1, 0x0818(A2)
        _return:
        OS.patch_end()

        bne     v0, at, _heal_check
        nop
        j       _return
        nop

        _heal_check:
        j       0x800E1820
        nop
    }

    // @ Description
    // Hook before healing routine
    scope poison_hook: {
        OS.patch_start(0x5D020, 0x800E1820)
        j       poison_hook         // og line 1 = LW V1, 0x0818(A2)
        lw      v1, 0x0818(a2)      // og line 2 = BEQZL V1, 0x800E18C8
        _return:
        OS.patch_end()

        beqzl   v1, _skip_heal
        lw      v0, 0x084C(a2)          // v0 = healing amount

        // if here, then healing
        j       0x800E182C + 0x4        // continue to healing portion of routine
        lw      v0, 0x002C(a2)          // og branch line

        _skip_heal:
        // if not healing, check for poison (first the Toggle, then the Hazard)
        j       CharacterSelectDebugMenu.PoisonDmg.apply_damage
        nop

        _poison_check:
        addiu   sp, sp, -0x30           // allocate sp

        sw      t1, 0x0010(sp)          // store registers
        sw      t5, 0x0020(sp)          // store registers
        sw      t7, 0x0024(sp)          // store registers
        sw      t8, 0x0028(sp)          // store registers

        li      t5, poisoned_players
        lbu     t8, 0x000D(a2)          // load port
        sll     t7, t8, 4               // offset to port
        addu    t5, t5, t7              // t5 = players entry in table
        lw      t7, 0x0000(t5)          // t7 = players poison duration
        beqz    t7, _exit_0
        addiu   t7, t7, -1              // t7 = players poison duration

        li      at, Item.CloakingDevice.cloaked_players
        addu    at, at, t8              // t5 = players entry in table
        lbu     at, 0x0000(at)
        bnez    at, _exit_0             // skip if player is cloaked
        nop

        sw      t7, 0x0000(t5)          // update duration

        sw      t1, 0x0010(sp)          // store registers
        sw      t2, 0x0014(sp)          // store registers
        sw      t3, 0x0018(sp)          // store registers
        sw      t4, 0x001C(sp)          // store registers

        bnez    t7, _poison_continue
        li      at, GFXRoutine.port_override.override_table
        // if here, then poison counter == 0
        sll     t2, t8, 0x0002              // t2 = offset to player entry
        addu    t0, at, t2                  // t0 = address of players gfx routine
        addiu   at, r0, OVERLAY             // at = poison gfx routine index
        lw      t1, 0x0000(t0)              // t1 = current players override gfx routine
        bne     at, t1, _poison_continue    // branch if franklin badge gfx routine is not here
        nop
        sw      r0, 0x0000(t0)              // remove gfx override flag

        b       _exit_1
        nop

        _poison_continue:
        // this player is poisoned
        OS.read_half(0x801313F8, t7)     // t7 = current match timer
        andi    t7, t7, 0x001F           // damage every half second
        bnez    t7, _exit_1
        lw      at, 0x05A4(a2)           // at = check if player is invulnerable from spawning
        bnez    at, _exit_1              // skip if still spawning
        nop
        lw      at, 0x05B0(a2)           // at = super star counter
        bnez    at, _exit_1              // skip if using a super star
        lw      at, 0x0024(a2)           // at = current action
        slti    at, at, Action.Idle      // at = 1 if respawning
        beqz    at, _poison_continue_2
        nop
        // if here, player is respawning
        sw      r0, 0x0000(t5)           // set poison duration to 0
        li      at, GFXRoutine.port_override.override_table
        sll     t2, t8, 2
        addu    t2, at, t2
        b       _exit_1                 // exit poison
        sw      r0, 0x0000(t2)          // remove overlay override

        _poison_continue_2:
        lw      t7, 0x002C(a2)           // t7 = current hp
        lw      t4, 0x0004(t5)           // t4 = poison damage amount
        addu    t7, t7, t4               // hp -= damage amount

        // vs mode check
        li      at, Global.current_screen // ~
        lbu     at, 0x0000(at)           // t0 = current screen
        addiu   t2, r0, 0x0016           // screen id
        bne     t2, at, _continue
        nop

        // stamina mode check
        li      t2, Stamina.VS_MODE
        lbu     t2, 0x0000(t2)           // load mode
        addiu   at, r0, Stamina.STAMINA_MODE    // stamina mode
        bne     t2, at, _continue
        lw      t2, 0x002C(a2)           // t2 = current hp
        
        lb      t4, 0x000D(a2)          // t5 = player port
        sll     at, t4, 0x3             // calculate offset
        subu    at, at, t4
        sll     at, at, 0x2
        addu    at, at, t4
        sll     at, at, 0x2
        li      t4, Global.match_info   // ~ 0x800A50E8
        lw      t4, 0x0000(t4)          // t4 = match_info
        addu    at, at, t4              // stock address for that port
        lb      at, 0x002B(at)          // load stock amount
        bltz    at, _exit_1             // skip if the player is already defeated
        nop
        
        li      at, Stamina.TOTAL_HP    // load total hitpoints address
        lw      at, 0x0000(at)          // load total hitpoints amount
        slt     t3, at, t7              // if total hitpoints are less than total percent set t7
        bnel    t3, r0, _continue
        addu    t7, at, r0
        beq     r0, r0, _continue
        nop
        
        //addiu   at, r0, Action.Grab
        //lw      t2, 0x0024(a2)           // t2 = current action
        //
        //_grab:
        //beq     at, t2, _continue
        //addiu   at, at, 0x0001
        //addiu   t3, r0, 0x00AB
        //bne     at, t3, _grab
        //nop
        //
        //lw      t3, 0x0008(a2)           // t7 = character ID
        //addiu   at, r0, Character.id.DK  // DK ID
        //bne     at, t3, _jdk
        //nop
        //
        //_dk_start:
        //addiu   at, r0, Action.DK.Cargo
        //_dk:
        //beq     at, t2, _continue
        //addiu   at, at, 0x0001
        //addiu   t3, r0, Action.DK.HeavyItemThrowF
        //bne     at, t3, _dk
        //nop
        //
        //_jdk:
        //addiu   at, r0, Character.id.JDK  // DK ID
        //beq     at, t3, _dk_start
        //nop
        //
        //addiu   at, r0, Character.id.MARINA  // MARINA ID
        //bne     at, t3, _ko
        //addiu   at, r0, Marina.Action.Cargo
        //
        //_marina:
        //beq     at, t2, _continue
        //addiu   at, at, 0x0001
        //addiu   t3, r0, 0xFC
        //bne     at, t3, _marina
        //nop

        // KO'd, so apply damage and put in DownBounceD
        _ko:
        lw      a0, 0x004C(sp)           // a2 = player struct
        jal     0x800EA248               // update damage
        or      a1, t4, r0               // t7 = damage

        lw      a2, 0x004C(sp)           // restore a2
        addiu   sp, sp, -0x0020          // allocate stack space
        lw      a0, 0x0004(a2)           // a0 = player object
        addiu   a1, r0, Action.Tumble    // a1 = action ID if in the air
        lw      a2, 0x014C(a2)           // a2 = kinetic state
        beqzl   a2, pc() + 8             // if grounded, set action to DownBounceD
        addiu   a1, r0, Action.DownBounceD // a1 = action ID if grounded
        or      a2, r0, r0               // a2(starting frame) = 0
        lui     a3, 0x3F80               // a3(frame speed multiplier) = 1.0
        jal     0x800E6F24               // change action
        sw      r0, 0x0010(sp)           // argument 4 = 0
        addiu   sp, sp, 0x0020           // deallocate stack space

        lw      a2, 0x004C(sp)           // restore a2
        b       _exit_1
        lw      v0, 0x084C(a2)

        _continue:
        sw      t7, 0x002C(a2)           // save HP value
        sw      a2, 0x001C(sp)           // store player struct
        li      at, GFXRoutine.port_override.override_table
        sll     t2, t8, 2
        addu    t2, at, t2
        lw      at, 0x0000(t2)           // get current GFX override value
        bnez    at, _play_poison_sfx
        addiu   t7, r0, OVERLAY
        sw      t7, 0x0000(t2)

        li      at, GFXRoutine.DOOM_ACID
        sw      at, 0x0A28(a2)          // set player gfx routine if poisoned

        _play_poison_sfx:
        FGM.play(DAMAGE_SFX)

        lw      t5, 0x0020(sp)          // restore registers
        lw      t7, 0x0024(sp)          // restore registers
        lw      t8, 0x0028(sp)          // restore registers
        lw      t1, 0x0010(sp)          // restore registers
        lw      t2, 0x0014(sp)          // restore registers
        lw      t3, 0x0018(sp)          // restore registers
        lw      t4, 0x001C(sp)          // restore registers

        j       0x800E1850              // apply hp / damage?
        addiu   sp, sp, 0x30            // deallocate sp


        _exit_1:
        lw      t1, 0x0010(sp)          // restore registers
        lw      t2, 0x0014(sp)          // restore registers
        lw      t3, 0x0018(sp)          // restore registers
        lw      t4, 0x001C(sp)          // restore registers

        _exit_0:
        lw      t5, 0x0020(sp)          // restore registers
        lw      t7, 0x0024(sp)          // restore registers
        lw      t8, 0x0028(sp)          // restore registers

        _exit:
        j       0x800E18C8
        addiu   sp, sp, 0x30            // deallocate sp
    }

    // @ Description
    // Clears the poison array between matches
    scope clear_poison_: {
        li      at, poisoned_players
        sw      r0, 0x0000(at)  // set poison duration to 0
        sw      r0, 0x0010(at)  // ~
        sw      r0, 0x0020(at)  // ~
        sw      r0, 0x0030(at)  // ~
        jr      ra
        sw      r0, 0x001C(at)
    }



}
