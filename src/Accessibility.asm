// Accessibility.asm (code by goombapatrol)
if !{defined __ACCESSIBILITY__} {
define __ACCESSIBILITY__()
print "included Accessibility.asm\n"

// This file includes several accessibility-related toggles.
// May help with photosensitivity and/or motion sickness by reducing flashes and camera shake.

scope Accessibility {

    // @ Description
    // Reimplements the unused 'Anti-Flash' feature.
    // This disables certain screen flashes (hard hits, Zebes acid, barrel etc)
    // Vanilla reads value stored at 0x800A4930 which is always 1 (no option to toggle)
    // Note: included checks in DekuNut.asm and Flashbang.asm for '0x80131A40' screen flashes
    //       included checks in Lighting.asm as well
    scope flash_guard: {
        OS.patch_start(0x91610, 0x80115E10)
        j       flash_guard
        addiu   a0, r0, 0x03F8              // original line 2
        _return:
        OS.patch_end()

        li      t6, Toggles.entry_flash_guard
        lw      t6, 0x0004(t6)              // t5 = 1 if Flash Guard is enabled
        xori    t6, t6, 1                   // 0 -> 1 or 1 -> 0 (flip bool)

        _end:
        //// lbu     t6, 0x4930(t6)         // original line 1
        j       _return                     // return
        nop
    }

    // @ Description
    // Store structure for use later
    scope ParamMakeEffect: {
        OS.patch_start(0x663F4, 0x800EABF4)
        j       ParamMakeEffect.save_gobj
        or      v1, r0, r0                  // original line 2
        _return_1:
        OS.patch_end()
        OS.patch_start(0x66B88, 0x800EB388)
        j       ParamMakeEffect.clear_gobj
        lw      ra, 0x001C(sp)              // original line 1
        _return_2:
        OS.patch_end()

        save_gobj:
        li      at, ParamMakeEffect.gobj    // store struct (t7)
        sw      t7, 0x0000(at)              // ~
        j       _return_1                   // return
        addiu   at, r0, 0x0049              // original line 1

        clear_gobj:
        li      s0, ParamMakeEffect.gobj    // clear stored struct
        sw      r0, 0x0000(s0)              // ~
        j       _return_2                   // return
        lw      s0, 0x0018(sp)              // original line 2

        gobj:
        dw  0
    }

    // @ Description
    // This handles screenshake intensity, which can be lowered or turned off altogether.
    scope screenshake_toggle: {
        OS.patch_start(0x7C164, 0x80100964)
        j       screenshake_toggle
        nop
        _return:
        OS.patch_end()

        // v1 = severity (0 = light, 1 = moderate, 2 = heavy, 3 = POW block)

        // skip offscreen CPUs shaking screen in Remix RTTF
        li      a0, Global.match_info       // a0 = address of match info
        lw      a0, 0x0000(a0)              // a0 = match info start
        lbu     a0, 0x0001(a0)              // a0 = stage_id
        addiu   a0, a0, -Stages.id.REMIX_RTTF  // a0 = REMIX_RTTF Stage ID
        bnez    a0, _check_toggle           // skip if stage is not Remix RTTF
        nop
        li      a0, ParamMakeEffect.gobj    // load stored struct
        lw      a0, 0x0000(a0)              // ~
        beqz    a0, _check_toggle           // skip if no stored struct
        nop
        lh      t7, 0x018C(a0)              // get player state flags?
        andi    t7, t7, 0x0004              // !0 if off screen
        bnez    t7, _no_screenshake         // don't shake if off screen
        nop

        _check_toggle:
        li      a0, Toggles.entry_screenshake
        lw      a0, 0x0004(a0)              // t5 = 0 if 'DEFAULT', 1 if 'LIGHT', 2 if 'OFF'
        beqzl   a0, _end                    // branch accordingly
        lw      v1, 0x0030(sp)              // original line 1
        sltiu   a0, a0, 2                   // a0 = 1 if 'LIGHT'
        bnezl   a0, _end                    // branch accordingly
        or      v1, r0, r0                  // v1 = 0 (force all shakes to be Light)
        // if we're here, screenshake is set to 'OFF'
        _no_screenshake:
        addiu   v1, r0, -0x0001             // v1 = -1 (invalid intensity, so it doesn't take any shake branches)

        _end:
        or      a0, s0, r0                  // original line 2
        j       _return                     // return
        nop
    }

    // // @ Description
    // // Handle the Blast Zone explosion graphic effect
    // scope blastzone_explode_gfx: {
        // OS.patch_start(0x7D9C4, 0x801021C4)
        // j       blastzone_explode_gfx
        // nop
        // _return:
        // OS.patch_end()

        // li      t7, Toggles.entry_puff_sing_anim         // placeholder (Toggles.entry_blastzone_gfx)
        // lw      t7, 0x0004(t7)              // t7 = 0 if 'DEFAULT', 1 if 'OFF'
        // bnez    t7, _skip_gfx               // branch accordingly
        // andi    t7, a2, 0x0001              // original line 1
        // j       _return                     // return
        // sll     t8, t7, 2                   // original line 2

        // _skip_gfx:
        // j       0x801023C8                  // skip to the end of the function
        // nop
    // }

} // __ACCESSIBILITY__
