// SingleButtonMode.asm (code by goombapatrol)
if !{defined __SINGLEBUTTONMODE__} {
define __SINGLEBUTTONMODE__()
print "included SingleButtonMode.asm\n"

// @ Description
// Single Button Mode
// Restricts players to using only one button (options are 'A', 'B', or 'R')
// (Can optionally include 'C' as well, for jumping)
// Note: we still allow 'Start' presses, and all buttons are available outside of match
// Note: we keep Dpad inputs as stick alternative for 'dpad ctrl' (but no 'dpad map' macros)
//       Taunt Btn Dpad remaps are ignored
// t5, t6, a0 are safe to edit
scope single_button_mode {

    _check_toggle:
    li      t5, Toggles.entry_single_button_mode
    lw      t5, 0x0004(t5)                  // t5 = single_button_mode (0 if OFF, 1 if 'A', 2 if 'B', 3 if 'R', 4 if 'A+C', 5 if 'B+C', 6 if 'R+C')
    beqz    t5, _return                     // if Single Button Mode is disabled, return normally
    nop

    // safety crash check
    li      t6, 0x8003CE78                  // t6 = dSYErrorIsScreenActive (from 'error.c')
    lw      t6, 0x0000(t6)                  // t6 = 1 if game has crashed
    bnez    t6, _return                     // don't get in the way of crash debugger inputs!!
    nop

    _check_screen:
    li      t6, Global.current_screen
    lbu     a0, 0x0000(t6)                  // a0 = current screen
    lli     t6, Global.screen.TITLE_AND_1P  // Title, 1p game over screen, 1p battle, remix 1p battle
    beq     t6, a0, _check_pause            // branch accordingly
    lli     t6, Global.screen.VS_BATTLE
    beq     t6, a0, _check_pause
    lli     t6, Global.screen.BONUS         // Bonus 1, Bonus 2, Bonus 3 (BTT/BTP/RTTF)
    beq     t6, a0, _check_pause
    lli     t6, Global.screen.TRAINING_MODE
    beq     t6, a0, _check_pause_training   // branch for Training Mode
    lli     t6, Global.screen.REMIX_MODES   // Remix Modes (other than Remix 1P) All-star, Multiman, HRC
    bne     t6, a0, _return                 // this branch is taken if screen is not any of the above
    nop

    _check_pause:
    li      t6, Global.match_info
    lw      t6, 0x0000(t6)                  // t6 = match info
    beqz    t6, _return                     // safety branch (for title screen etc)
    nop
    lbu     t6, 0x0011(t6)                  // t6 = pause state
    lli     a0, 3                           // a0 = 3 (unpausing)
    beq     t6, a0, _check_which_single_button  // if unpausing, don't skip (prevent player from buffering a barred button)
    sltiu   t6, t6, 2                       // t6 = 1 if unpaused (pause state is 0 or 1 if not paused)
    beqz    t6, _return                     // skip if we are paused
    nop
    b       _check_which_single_button      // otherwise, continue
    nop

    _check_pause_training:
    li      t6, Training.toggle_menu        // t6 = address of Training toggle_menu
    lbu     t6, 0x0000(t6)                  // t6 = toggle_menu (BOTH_DOWN = 1, SSB_UP = 2, CUSTOM_UP = 3)

    sltiu   t6, t6, 2                       // t6 = 1 if neither Training menu is up...
    bnez    t6, _check_which_single_button  // ...in which case we branch normally
    nop

    // when closing Training Menu, it is possible to buffer an illegal button while toggle_menu is still '2'
    // so we check for Start or B (either can close the menu) and remove extra buffered buttons during this time
    andi    t6, t9, Joypad.START + Joypad.B // t6 != 0 if pressed button (t9) is START or B (potentially unpausing)
    beqz    t6, _return                     // if not pressing either button, skip
    nop

    sltiu   t6, t5, 4                       // t6 = 0 if including 'C' button
    beqzl   t6, pc() + 8                    // if so, subtract 3 to get corresponding main button value
    addiu   t5, t5, -3                      // ~
    addiu   t6, r0, 0x0002                  // t6 = 2 (SBM 'B')
    bnel    t5, t6, pc() + 12               // only remove held 'B' if NOT using SBM 'B' (so no accidental double press)
    lli     t6, Joypad.START                // ~
    lli     t6, Joypad.START + Joypad.B     // ~
    and     t8, t8, t6                      // remove all extra held input (prevent player from buffering a barred button)
    b       _return                         // skip to end
    nop

    _check_which_single_button:
    // t5 = entry_single_button
    sltiu   t6, t5, 4                       // t6 = 0 if including 'C' button
    beqzl   t6, pc() + 8                    // if so, subtract 3 to get corresponding main button value
    addiu   t5, t5, -3                      // ~
    addiu   t6, r0, 0x0001                  // t6 = 1 ('A')
    beql    t5, t6, _modify_input           // branch accordingly
    lli     t5, Joypad.A
    addiu   t6, r0, 0x0002                  // t6 = 2 ('B')
    beql    t5, t6, _modify_input
    lli     t5, Joypad.B
    addiu   t6, r0, 0x0003                  // t6 = 3 ('R')
    beql    t5, t6, _modify_input
    lli     t5, Joypad.R
    b       _return                         // safety branch
    nop

    // t8 = is_held  - check for is_held
    // t9 = pressed  - check for !is_held -> is_held
    _modify_input:
    li     t6, Toggles.entry_single_button_mode
    lw     t6, 0x0004(t6)                   // t6 = single_button_mode (0 if OFF, 1 if 'A', 2 if 'B', 3 if 'R', 4 if 'A+C', 5 if 'B+C', 6 if 'R+C')
    sltiu  t6, t6, 4                        // t6 = 0 if including 'C' button
    beqzl  t6, pc() + 12                    // set accordingly
    addi   t5, t5, Joypad.START + 0x0F0F    // t5 = Single Button + Start + Dpad + C buttons
    addi   t5, t5, Joypad.START + 0x0F00    // t5 = Single Button + Start + Dpad
    and    t8, t8, t5                       // remove extra held input
    and    t9, t9, t5                       // remove extra pressed input

    _return:
    j   CharacterSelectDebugMenu.DpadControl.css_cursor_and_dpad_controls_._sbm_checked
    nop

    // @ Description
    // Handle CPU inputs for Single Button Mode
    // v0, at are safe
    scope handle_cpu_inputs_: {
        OS.patch_start(0xAC73C, 0x80131CFC)
        j       handle_cpu_inputs_._a_b
        lli     t8, Joypad.A            // t8 = Joypad.A
        OS.patch_end()

        OS.patch_start(0xAC764, 0x80131D24)
        j       handle_cpu_inputs_._a_b
        lli     t8, Joypad.B            // t8 = Joypad.B
        OS.patch_end()

        OS.patch_start(0xAC784, 0x80131D44)
        j       handle_cpu_inputs_._z_l
        lli     t8, Joypad.Z            // t8 = Joypad.Z
        OS.patch_end()

        OS.patch_start(0xAC7A4, 0x80131D64)
        j       handle_cpu_inputs_._z_l
        lli     t8, Joypad.L            // t8 = Joypad.L
        OS.patch_end()

        _a_b:
        li      t7, Toggles.entry_single_button_mode
        lw      t7, 0x0004(t7)          // t7 = single_button_mode (0 if OFF, 1 if 'A', 2 if 'B', 3 if 'R', 4 if 'A+C', 5 if 'B+C', 6 if 'R+C')
        beqz    t7, _end                // if Single Button Mode is disabled, return normally
        nop
        sltiu   t8, t7, 4               // t8 = 0 if including 'C' button
        beqzl   t8, pc() + 8            // if so, subtract 3 to get corresponding main button value
        addiu   t7, t7, -3              // ~

        // if we're here the A or B button press to match the active button
        addiu   t8, r0, 0x0001          // t8 = 1 ('A')
        beql    t7, t8, _end            // branch accordingly
        lli     t8, Joypad.A
        addiu   t8, r0, 0x0002          // t8 = 2 ('B')
        beql    t7, t8, _end            // branch accordingly
        lli     t8, Joypad.B
        addiu   t8, r0, 0x0003          // t8 = 3 ('R')
        beql    t7, t8, _end            // branch accordingly
        lli     t8, Joypad.A + Joypad.Z // effectively 'R' for CPU
        b       _end                    // safety branch
        nop

        _z_l:
        li      t7, Toggles.entry_single_button_mode
        lw      t7, 0x0004(t7)           // t7 = single_button_mode (0 if OFF, 1 if 'A', 2 if 'B', 3 if 'R', 4 if 'A+C', 5 if 'B+C', 6 if 'R+C')
        bnezl   t7, pc() + 8             // if Single Button Mode is not disabled, remove the button press
        or      t8, r0, r0               // ~

        _end:
        lhu     t7, 0x01C6(a0)           // original line 1 (restore t7)
        or      t8, t7, t8               // original line 2, modified (add press to button mask
        j       0x80131D2C               // original line 3, modified to jump
        sh      t8, 0x01C6(a0)           // original line 4
    }
}

} // __SINGLEBUTTONMODE__
