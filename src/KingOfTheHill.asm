// KingOfTheHill.asm
if !{defined __KOTH__} {
define __KOTH__()
print "included KingOfTheHill.asm\n"

// @ Description
// This file implements King of the Hill mode in VS

scope KingOfTheHill {
    constant CONTESTED_BUFFER(30)
    constant CONTESTED_GRAY(0x505050FF + ((CONTESTED_BUFFER * 3) << 0x18) + ((CONTESTED_BUFFER * 3) << 0x10) + ((CONTESTED_BUFFER * 3) << 0x8))
    constant WIN_FRAMES((3 * 60) + 30)
    constant ALPHA_DELTA(5)
    constant ALPHA_DELTA_MAX(ALPHA_DELTA * 20)

    // @ Description
    // The time setting as set on CSS
    time:
    dw 30

    // @ Description
    // The teams setting as set on CSS
    teams:
    dw OS.FALSE

    // @ Description
    // The time setting options
    time_value_array:
    dw 5, 10, 15, 20, 25, 30, 45, 60, 90, 120, 240, 480, 960

    // @ Description
    // Frames on the hill for each player
    scores:
    dw 0, 0, 0, 0

    // @ Description
    // Frames on the hill for each team
    team_scores:
    dw 0, 0, 0, 0

    // @ Description
    // Frames accrued after reaching target, used to determine winner
    winner_times:
    dw 0, 0, 0, 0

    // @ Description
    // The ID of the current "hill"
    hill_line_id:
    dw -1

    // @ Description
    // Timer for setting next hill
    timer:
    dw 0

    // @ Description
    // The port/team who is currently the "king"
    king:
    dw -1

    // @ Description
    // Frames to wait before hill can be claimed after being contested
    contested_buffer:
    dw 0

    // @ Description
    // Boolean for each port whether or not to use CPU colors
    use_cpu_color:
    db 0, 0, 0, 0

    // @ Description
    // Array of indicator objects
    indicators:
    dw 0, 0, 0, 0

    // @ Description
    // Array of colors for FFA
    colors:
    dw Color.tag.RED
    dw Color.tag.BLUE
    dw Color.tag.YELLOW
    dw Color.tag.GREEN
    dw Color.tag.GRAY

    // @ Description
    // Array of colors for Teams
    team_colors:
    dw Color.tag.RED
    dw Color.tag.BLUE
    dw Color.tag.GREEN
    dw Color.tag.YELLOW

    // @ Description
    // Array of colors for FFA
    colors_meter:
    dw Color.damage_icon.RED
    dw Color.damage_icon.BLUE
    dw Color.damage_icon.YELLOW
    dw Color.damage_icon.GREEN
    dw Color.damage_icon.GRAY

    // @ Description
    // Array of colors for Teams
    team_colors_meter:
    dw Color.damage_icon.RED
    dw Color.damage_icon.BLUE
    dw Color.damage_icon.GREEN
    dw Color.damage_icon.YELLOW

    // @ Description
    // Array of colors for FFA
    colors_bar:
    dw 0xC96A6AFF
    dw 0x7E7EC9FF
    dw 0xB2B244FF
    dw 0x4EAD4EFF
    dw 0x888888FF

    // @ Description
    // Array of colors for Teams
    team_colors_bar:
    dw 0xC96A6AFF
    dw 0x7E7EC9FF
    dw 0x4EAD4EFF
    dw 0xB2B244FF

    // @ Description
    // Head ground GFX object with any children at 0x0040 of each object
    gfx:
    dw 0

    // @ Description
    // Indicator object
    indicator:
    dw 0

    // GFX
    koth_ground_gfx_struct:
    db 0x04, 0x0B, 0x00, 0x00
    dw Render.file_pointer_4
    db 0x1C, 0x00, 0x00, 0x1C
    dw 0x00000000
    dw update_ground_gfx_
    dw render_ground_gfx_
    dw 0x00000400
    dw 0x00000000
    dw 0x00000000 // dw 0x0000066C
    dw 0x00000000

    koth_indicator_gfx_struct:
    db 0x04, 0x0B, 0x00, 0x00
    dw Render.file_pointer_4
    db 0x1C, 0x00, 0x00, 0x1C
    dw 0x00000000
    dw update_indicator_gfx_
    dw render_ground_gfx_
    dw 0x00000F50
    dw 0x00000000
    dw 0x00000000 // dw 0x0000066C
    dw 0x00000000

    // dMnBattleTimerValues (and dMnBattleTimerValuesDuplicate) should be:
    // [1, 2, 3, 4, 5, 6, 7, 8]

    // To get surface X/Y:
    //  - line_id = 0x00EC(player_struct)
    //  - 80131378 = gMPCollisionVertexLinks (array of structs made of 2 u16s)
    //    - vert_id1 = 0x0000(gMPCollisionVertexLinks[line_id])
    //    - vert_id2 = vert_id1 + 0x0002(gMPCollisionVertexLinks[line_id]) - 1
    //  - 80131374 = gMPCollisionVertexIDs (array of structs made of 1 u16)
    //    - vpos_id1 = 0x0000(gMPCollisionVertexIDs[vert_id1])
    //    - vpos_id2 = 0x0000(gMPCollisionVertexIDs[vert_id2])
    //  - 80131370 = gMPCollisionVertexData (array of structs made of Vec2f and u16)
    //    - x1 = 0x0000(gMPCollisionVertexData[vpos_id1])
    //    - y1 = 0x0002(gMPCollisionVertexData[vpos_id1])
    //    - x2 = 0x0000(gMPCollisionVertexData[vpos_id2])
    //    - y2 = 0x0002(gMPCollisionVertexData[vpos_id2])
    //  - 80131368 = gMPCollisionGeometry
    //    - i = # of groups = (u16) 0x0000(gMPCollisionGeometry)
    //    - line_info = 0x0010(gMPCollisionGeometry)
    //      - yokumono_id[i] = 0x0000(line_info[i]) - like a group of clippings
    //      - min_line_id[i] = 0x0002(line_info[i])
    //      - max_line_id[i] = min_line_id + 0x0004(line_info[i]) - 1
    //  - 80131304 = gMPCollisionYakumonoDObjs
    //    - dobj[yokumono_id] = gMPCollisionYakumonoDObjs[yokumono_id]
    //      - 0x0084(dobj):
    //        - if 0, XYZ not relative to dobj XYZ
    //        - if 1 or 2, XYZ relative to dobj XYZ
    //        - if 3, clipping off

    // @ Description
    // Runs when entering the CSS
    scope before_css_setup_: {
        addiu   sp, sp, -0x0010             // allocate stack space
        sw      ra, 0x0004(sp)              // save registers

        li      at, Global.vs.game_mode     // at = game_mode address
        lli     t0, 0x0001                  // t0 = TIME
        sb      t0, 0x0000(at)              // set game mode to TIME
        li      at, 0x8013BDAC              // at = game_mode address
        sw      t0, 0x0000(at)              // set game mode to TIME

        li      at, Global.vs.time          // at = time address
        OS.read_word(time, t0)              // t0 = KOTH time
        sb      t0, 0x0000(at)              // set time
        li      at, 0x8013BD7C              // at = time address
        sw      t0, 0x0000(at)              // set time

        li      at, Global.vs.teams         // at = teams address
        OS.read_word(teams, t0)             // t0 = KOTH teams
        sb      t0, 0x0000(at)              // set teams
        li      at, 0x8013BDA8              // at = teams address
        sw      t0, 0x0000(at)              // set teams

        li      at, 0x8013B7C8              // at = title offsets (first is ffa, second is teams)
        lli     t9, 0x29A8                  // t9 = offset to "King of the Hill" image
        sw      t9, 0x0000(at)              // set ffa offset
        sw      t9, 0x0004(at)              // set teams offset

        li      at, StockMode.stockmode_table // at = stockmode_table address
        sw      r0, 0x0000(at)              // clear stockmode_table p1
        sw      r0, 0x0004(at)              // clear stockmode_table p2
        sw      r0, 0x0008(at)              // clear stockmode_table p3
        sw      r0, 0x000C(at)              // clear stockmode_table p4

        lw      ra, 0x0004(sp)              // restore registers
        jr      ra
        addiu   sp, sp, 0x0010              // deallocate stack space
    }

    // @ Description
    // Runs before leaving the CSS and going back to VS Mode menu
    scope leave_css_setup_: {
        addiu   sp, sp, -0x0010             // allocate stack space
        sw      ra, 0x0004(sp)              // save registers

        li      at, 0x8013BD7C              // at = time address
        OS.read_word(CharacterSelect.saved_nontime_value, t0) // t0 = saved non-time value
        OS.read_word(CharacterSelect.showing_time, t1)
        beqzl   t1, _save_goal              // if not showing Time, use time in time picker
        lw      t0, 0x0000(at)              // t0 = time in css time picker
        // if we're here, Time (and not 'Goal') is showing and we need to save it
        li      t1, VsRemixMenu.global_time // t1 = global_time address
        lw      at, 0x0000(at)              // at = selected time
        sw      at, 0x0000(t1)              // save time

        _save_goal:
        li      t1, time
        sw      t0, 0x0000(t1)              // save KOTH time

        li      at, 0x8013BDA8              // at = teams address
        lw      t0, 0x0000(at)              // t0 = teams in css
        li      t1, teams
        sw      t0, 0x0000(t1)              // save KOTH teams

        // Restore globals
        li      at, 0x8013BD7C              // at = time address
        OS.read_word(VsRemixMenu.global_time, t0) // t0 = saved time
        sw      t0, 0x0000(at)              // restore time

        lw      ra, 0x0004(sp)              // restore registers
        jr      ra
        addiu   sp, sp, 0x0010              // deallocate stack space
    }

    // @ Description
    // Runs before leaving the CSS to start a match
    scope start_match_setup_: {
        addiu   sp, sp, -0x0010             // allocate stack space
        sw      ra, 0x0004(sp)              // save registers

        li      at, 0x8013BD7C              // at = time address
        OS.read_word(CharacterSelect.showing_time, t0)
        beqzl   t0, _save_goal              // if not showing Time, use time in time picker
        lw      t1, 0x0000(at)              // t1 = time in css time picker
        // if we're here, Time (and not 'Goal') is showing and we need to save it
        li      t0, VsRemixMenu.global_time // t0 = global_time address
        lw      t1, 0x0000(at)              // t1 = selected time
        sw      t1, 0x0000(t0)              // save time
        OS.read_word(CharacterSelect.saved_nontime_value, t1) // t1 = saved non-time value

        _save_goal:
        li      t0, time
        sw      t1, 0x0000(t0)              // save KOTH time

        // lli     t1, 0x0064                  // t1 = infinity
        OS.read_word(VsRemixMenu.global_time, t1) // t1 = VS time value
        sw      t1, 0x0000(at)              // set time

        li      at, 0x8013BDA8              // at = teams address
        li      t0, teams
        lw      t1, 0x0000(at)              // t1 = teams in css
        sw      t1, 0x0000(t0)              // save teams

        lw      ra, 0x0004(sp)              // restore registers
        jr      ra
        addiu   sp, sp, 0x0010              // deallocate stack space
    }

    // @ Description
    // This allows 3 digits to be rendered in the yellow value scroller at the top
    // and repositions when 3 digits are present
    scope allow_3_digits_for_picker_: {
        OS.patch_start(0x1321F8, 0x80133F78)
        jal     allow_3_digits_for_picker_
        addiu   t4, r0, 0x0003              // original line 1, modified to render 3 digits instead of 2
        nop
        OS.patch_end()

        OS.read_word(VsRemixMenu.vs_mode_flag, at) // at = vs_mode_flag
        lli     t3, VsRemixMenu.mode.KOTH
        bne     at, t3, _end                // if not KOTH, do normal check
        lui     a2, 0x4354                  // original line 3

        sltiu   at, a1, 100                 // at = 0 if 3 digits
        beqzl   at, _end                    // if 3 digits, change x
        lui     a2, 0x435A                  // original line 3

        _end:
        jr      ra
        sw      t4, 0x0014(sp)              // original line 2
    }

    // @ Description
    // This ends the match once a player/team reaches the time target
    scope check_match_end_: {
        li      at, winner_times
        lli     v1, WIN_FRAMES

        _loop:
        lw      t2, 0x0000(at)              // t2 = p1 winner time
        sltu    t3, t2, v1                  // t3 = 0 if reached target winner time
        beqz    t3, _winner                 // if there is a winner, end match
        lli     v1, WIN_FRAMES - (3 * 60)   // v1 = 3 seconds left
        beql    t2, v1, _play_sfx           // if 3 seconds left, play "3"
        lli     a0, FGM.announcer.fight.THREE_NONBLOCKING
        lli     v1, WIN_FRAMES - (2 * 60)   // v1 = 2 seconds left
        beql    t2, v1, _play_sfx           // if 2 seconds left, play "2"
        lli     a0, FGM.announcer.fight.TWO_NONBLOCKING
        lli     v1, WIN_FRAMES - (1 * 60)   // v1 = 1 second left
        beql    t2, v1, _play_sfx           // if 1 second left, play "1"
        lli     a0, FGM.announcer.fight.ONE
        addiu   at, at, 0x0004              // at = next score
        li      t3, winner_times + 0x0010   // t3 = end of winner_times array
        beq     at, t3, _no_winner          // exit loop if no more scores to check
        nop
        b       _loop
        lli     v1, WIN_FRAMES

        _play_sfx:
        addiu   sp, sp, -0x0010             // allocate stack space
        sw      ra, 0x0004(sp)              // save registers

        jal     FGM.play_                   // play sfx (retain all registers for safety)
        nop
        OS.read_word(Global.match_info, a0) // restore a0

        lw      ra, 0x0004(sp)              // restore registers
        addiu   sp, sp, 0x0010              // deallocate stack space

        _no_winner:
        _normal:
        jr      ra
        nop

        _winner:
        // add one frame to each teammate's score on winning team
        OS.read_word(Global.p_struct_head, at) // at = p1 player struct
        _winner_loop:
        lw      v1, 0x0004(at)              // t1 = player object
        beqz    v1, _next                   // if no player object, get next player struct
        lbu     t3, 0x000C(at)              // t3 = team
        OS.read_word(king, t2)              // t2 = king
        bne     t3, t2, _next               // if not the king, skip
        lbu     t3, 0x000D(at)              // t3 = port
        li      t2, scores
        sll     t3, t3, 0x0002              // t3 = offset to score
        addu    t2, t2, t3                  // t2 = address of score
        lw      t3, 0x0000(t2)              // t3 = score
        addiu   t3, t3, 0x0001              // t3 = score + 1 frame
        sw      t3, 0x0000(t2)              // update score

        _next:
        lw      at, 0x0000(at)              // at = next player struct
        bnez    at, _winner_loop            // loop while there are more players to check
        nop

        li      t9, 0x80114C80              // t9 = GAMESET routine
        j       0x80113218                  // trigger match end
        nop
    }

    // @ Description
    // The update routine for the KOTH ground GFX
    // @ Arguments
    // a0 - GFX object
    scope update_ground_gfx_: {
        // We just need to sync the top joint position with animated geo so we can do it here and jump to the vanilla routine
        lw      t0, 0x0044(a0)              // t0 = dobj, if set
        beqz    t0, _end                    // if no dobj, skip
        lw      t1, 0x0074(a0)              // t1 = top joint

        lw      t3, 0x001C(t0)              // t3 = dobj X
        sw      t3, 0x001C(t1)              // save dobj X
        lw      t3, 0x0020(t0)              // t3 = dobj Y
        sw      t3, 0x0020(t1)              // save dobj Y
        // lw      t3, 0x0024(t0)              // t3 = dobj Z
        // sw      t3, 0x0024(t1)              // save dobj Z

        // Also want to hide it based on the flags
        lw      t2, 0x0084(t0)              // t2 = flags for dobj (0 - not sure, 1 - yes clipping, 2 - yes clipping?, 3 - no clipping, 4 - no clipping?)
        lli     t3, 0x0000                  // t3 = 0 = don't hide
        sltiu   t2, t2, 0x0003              // t2 = 1 if no hide
        beqzl   t2, _update_display         // if no clipping, do hide
        lli     t3, 0x0002                  // t3 = 2 = do hide

        _update_display:
        sb      t3, 0x0054(t1)              // show/hide GFX object

        _end:
        j       0x8000DF34                  // vanilla update routine
        nop
    }

    // @ Description
    // The update routine for the KOTH indicator GFX
    // @ Arguments
    // a0 - GFX object
    scope update_indicator_gfx_: {
        // We need to sync the top joint position with animated geo so we can do it here and jump to the vanilla routine
        lw      t0, 0x0044(a0)              // t0 = dobj, if set
        beqz    t0, _end                    // if no dobj, skip
        lw      t1, 0x0074(a0)              // t1 = top joint

        lw      t3, 0x001C(t0)              // t3 = dobj X
        sw      t3, 0x001C(t1)              // save dobj X
        lw      t3, 0x0020(t0)              // t3 = dobj Y
        sw      t3, 0x0020(t1)              // save dobj Y
        // lw      t3, 0x0024(t0)              // t3 = dobj Z
        // sw      t3, 0x0024(t1)              // save dobj Z

        // Also want to hide it based on the flags
        lw      t2, 0x0084(t0)              // t2 = flags for dobj (0 - not sure, 1 - yes clipping, 2 - yes clipping?, 3 - no clipping, 4 - no clipping?)
        lli     t3, 0x0000                  // t3 = 0 = don't hide
        sltiu   t2, t2, 0x0003              // t2 = 1 if no hide
        beqzl   t2, _update_display         // if no clipping, do hide
        lli     t3, 0x0002                  // t3 = 2 = do hide

        _update_display:
        sb      t3, 0x0054(t1)              // show/hide GFX object

        _end:
        j       0x8000DF34                  // vanilla update routine
        nop
    }

    // @ Description
    // The render routine for the KOTH ground GFX
    // @ Arguments
    // a0 - GFX object
    scope render_ground_gfx_: {
        // We just need to set the prim color so we can do it here and jump to the vanilla routine
        li      t0, 0x800465B0              // t0 = display list address pointer
        lw      t1, 0x0000(t0)              // t1 = display list address

        lui     t2, 0xFA00                  // t2 = 0xFA000000 = G_SETPRIMCOLOR
        sw      t2, 0x0000(t1)              // update display list

        // check contested buffer
        OS.read_word(contested_buffer, t2)  // t2 = contested buffer
        bnezl   t2, _set_gray_color         // if contested, use gray color
        nop

        OS.read_word(king, t2)              // t2 = king
        bltzl   t2, _set_color              // if no king, use white
        addiu   t2, r0, -0x0001             // t2 = 0xFFFFFFFF = white

        li      t3, colors                  // t3 = colors array
        OS.read_byte(Global.vs.teams, t4)   // t4 = 1 if teams
        bnezl   t4, pc() + 8                // if teams, use team_colors instead
        addiu   t3, t3, team_colors - colors // t3 = team_colors

        li      t8, use_cpu_color
        addu    t8, t8, t2                  // address of use_cpu_color
        lbu     t4, 0x0000(t8)              // t4 = use_cpu_color
        sll     t2, t2, 0x0002              // t2 = offset to color
        bnezl   t4, pc() + 8                // if CPU color should be used, use CPU color
        lli     t2, 4 * 0x0004              // t2 = offset to CPU color
        addu    t3, t3, t2                  // t3 = color address
        lw      t2, 0x0000(t3)              // t2 = color

        _set_color:
        sw      t2, 0x0004(t1)              // update display list

        _end:
        addiu   t2, t1, 0x0008              // t2 = new display list address
        j       0x80014038                  // vanilla render routine
        sw      t2, 0x0000(t0)              // update display list address

        _set_gray_color:
        sll     t3, t2, 0x0001              // t3 = contested buffer * 2
        addu    t2, t3, t2                  // t2 = contested buffer * 3
        sll     t4, t3, 0x0008              // t4 = 0000XX00
        or      t5, t4, t3                  // t5 = 0000XXXX
        sll     t5, t5, 0x0010              // t5 = XXXX0000
        or      t5, t5, t4                  // t5 = XXXXXX00

        li      t3, CONTESTED_GRAY          // t3 = gray
        b       _set_color
        subu    t2, t3, t5                  // t2 = color to use
    }

    // @ Description
    // Creates the KOTH ground gfx over the entire clipping passed in
    // @ Arguments
    // a0 - line_id (i.e. 0xEC from player struct)
    scope create_ground_gfx_: {
        addiu   sp, sp, -0x0060             // allocate stack space
        sw      ra, 0x0004(sp)              // save registers

        addiu   a1, sp, 0x0010              // a1 = position offset
        addiu   a2, sp, 0x0020              // a1 = position = [x1, y1, x2, y2]

        // Initialize position
        sw      r0, 0x0000(a1)              // set X to 0
        sw      r0, 0x0004(a1)              // set Y to 0
        sw      r0, 0x0008(a1)              // set Z to 0

        li      t0, gfx                     // t0 = gfx
        sw      t0, 0x0008(sp)              // save as address to store reference

        // Figure out which line_info it is
        OS.read_word(0x80131368, t6)        // t6 = gMPCollisionGeometry
        lhu     t1, 0x0000(t6)              // t1 = # of groups
        lw      t5, 0x0010(t6)              // t5 = line_info[]

        _loop:
        lhu     t2, 0x0002(t5)              // t2 = min_line_id
        lhu     t3, 0x0004(t5)              // t3 = # in group
        addu    t4, t2, t3                  // t4 = max_line_id + 1
        sltu    at, a0, t4                  // at = 1 if this is the group
        bnezl   at, _yokumono_id_found      // if this is the group, exit loop
        lhu     t1, 0x0000(t5)              // t1 = yokumono_id
        addiu   t1, t1, -0x0001             // t1--
        bnez    t1, _loop                   // loop over all groups
        addiu   t5, t5, 0x0012              // t5 = next line_info

        _yokumono_id_found:
        OS.read_word(0x80131304, t2)        // t2 = gMPCollisionYakumonoDObjs[]
        sll     at, t1, 0x0002              // at = offset to dobj
        addu    t2, t2, at                  // t2 = dobj address
        lw      t2, 0x0000(t2)              // t2 = dobj
        lw      t3, 0x0084(t2)              // t3 = non-zero if clipping XY relative to dobj XY
        bnez    t3, _get_dobj_coords        // if clipping XY relative to dobj XY, get dobj XY
        lw      t3, 0x0070(t2)              // t3 = non-zero if clipping XY relative to dobj XY
        beqz    t3, _get_clipping           // if clipping XY not relative to dobj XY, skip getting dobj XY
        sw      r0, 0x0040(sp)              // don't save dobj

        _get_dobj_coords:
        lw      t3, 0x001C(t2)              // t3 = dobj X
        sw      t3, 0x0000(a1)              // save dobj X
        lw      t3, 0x0020(t2)              // t3 = dobj Y
        sw      t3, 0x0004(a1)              // save dobj Y
        // lw      t3, 0x0024(t2)              // t3 = dobj Z
        // sw      t3, 0x0008(a1)              // save dobj Z
        sw      t2, 0x0040(sp)              // save dobj

        _get_clipping:
        lw      t0, 0x000C(t6)              // t0 = gMPCollisionVertexLinks
        sll     t1, a0, 0x0002              // t1 = offset to vertex info
        addu    t0, t0, t1                  // t0 = vertex info
        lhu     t1, 0x0000(t0)              // t1 = min_vert_id
        lhu     t2, 0x0002(t0)              // t2 = # of verts in line
        addiu   t2, t2, -0x0001             // t2 = number of objects to create
        sw      t2, 0x004C(sp)              // save number of objects to create

        lw      t0, 0x0008(t6)              // t0 = gMPCollisionVertexIDs
        sll     t1, t1, 0x0001              // t1 = offset to min_vert_data_id
        addu    s0, t0, t1                  // s0 = address of min_vert_data_id

        sw      t6, 0x0048(sp)              // save gMPCollisionGeometry
        sw      r0, 0x0050(sp)              // total width = 0

        _create_loop:
        lhu     t1, 0x0000(s0)              // t1 = min_vert_data_id
        lhu     t2, 0x0002(s0)              // t1 = min_vert_data_id
        addiu   s0, s0, 0x0002              // s0 = next ver_data_id address
        sw      s0, 0x000C(sp)              // save next vert_data_id address

        lw      t0, 0x0004(t6)              // t0 = gMPCollisionVertexData
        sll     at, t1, 0x0002              // at = min_vert_data_id * 4
        sll     t1, t1, 0x0001              // at = min_vert_data_id * 2
        addu    t1, at, t1                  // t1 = offset to min_vert_data
        addu    t1, t0, t1                  // t1 = min_vert_data
        lh      at, 0x0000(t1)              // at = x1
        mtc1    at, f2                      // f2 = x1
        cvt.s.w f2, f2                      // f2 = x1, float
        lh      at, 0x0002(t1)              // at = y1
        mtc1    at, f4                      // f4 = y1
        cvt.s.w f4, f4                      // f4 = y1, float
        sll     at, t2, 0x0002              // at = max_vert_data_id * 4
        sll     t2, t2, 0x0001              // at = max_vert_data_id * 2
        addu    t2, at, t2                  // t2 = offset to max_vert_data
        addu    t2, t0, t2                  // t2 = max_vert_data
        lh      at, 0x0000(t2)              // at = x2
        mtc1    at, f6                      // f6 = x2
        cvt.s.w f6, f6                      // f6 = x2, float
        lh      at, 0x0002(t2)              // at = y2
        mtc1    at, f8                      // f8 = y2
        cvt.s.w f8, f8                      // f8 = y2, float

        swc1    f2, 0x0000(a2)              // save x1
        swc1    f4, 0x0004(a2)              // save y1

        sub.s   f6, f6, f2                  // f6 = x2, relative (width)
        sub.s   f8, f8, f4                  // f8 = y2, relative (height)
        swc1    f6, 0x0008(a2)              // save x2
        swc1    f8, 0x000C(a2)              // save y2

        // Check if we already have an object created
        lw      t0, 0x0008(sp)              // t0 = address to store reference
        lw      v0, 0x0000(t0)              // v0 = non-zero if we have an object
        bnez    v0, _update_position        // if we already have an object, skip creating a new one
        nop

        li      a0, koth_ground_gfx_struct
        jal     0x800FDB1C                  // create KOTH ground GFX
        nop
        bnezl   v0, _update_position        // if an object was created, continue
        sw      r0, 0x0040(v0)              // for newly created objects, clear custom next pointer

        // sometimes there may be no object returned, so handle that case here
        lw      t4, 0x0008(sp)              // t4 = address to store reference
        b       _end                        // exit routine
        sw      r0, 0x0000(t4)              // clear reference

        _update_position:
        li      t0, update_ground_gfx_
        sw      t0, 0x0014(v0)              // set the update routine, which doesn't get set since we don't want to limit the number of objects
        lw      t0, 0x0040(sp)              // t0 = geo dobj for positioning
        sw      t0, 0x0044(v0)              // save reference to geo dobj
        sw      r0, 0x007C(v0)              // make sure to turn display on

        addiu   a1, sp, 0x0010              // a1 = position offset
        addiu   a2, sp, 0x0020              // a1 = position = [x1, y1, x2, y2]

        lw      t0, 0x0074(v0)              // t0 = top joint
        lw      t1, 0x0000(a1)              // t1 = x offset
        sw      t1, 0x001C(t0)              // save x offset
        lw      t1, 0x0004(a1)              // t1 = y offset
        sw      t1, 0x0020(t0)              // save y offset
        // lw      t1, 0x0008(a1)              // t1 = z offset
        // sw      t1, 0x0024(t0)              // save z offset
        sb      r0, 0x0054(t0)              // ensure display is turned on

        lw      t0, 0x0010(t0)              // t0 = joint 1 (right anchor)
        lw      t1, 0x0000(a2)              // t1 = x1
        sw      t1, 0x001C(t0)              // save x1
        lw      t1, 0x0004(a2)              // t1 = y1
        sw      t1, 0x0020(t0)              // save y1

        lw      t0, 0x0010(t0)              // t0 = joint 2-0 (left anchor)
        lwc1    f2, 0x0008(a2)              // f2 = x2
        swc1    f2, 0x001C(t0)              // save x2
        lw      t1, 0x000C(a2)              // t1 = y2
        sw      t1, 0x0020(t0)              // save y2

        lwc1    f4, 0x0050(sp)              // f4 = total width
        add.s   f4, f4, f2                  // f4 = total width + width of this one
        swc1    f4, 0x0050(sp)              // save total width

        lw      t1, 0x0010(t0)              // t1 = joint 3 (left side)
        lw      t0, 0x0008(t0)              // t1 = joint 2-1 (right side)

        lw      t2, 0x004C(sp)              // t2 = number of objects to create
        addiu   t2, t2, -0x0001             // t2--
        sw      t2, 0x004C(sp)              // save number of objects to create

        lli     t3, 0x0000                  // t3 = display on
        bnezl   t2, pc() + 8                // if more objects to draw, hide left side
        lli     t3, 0x0002                  // t3 = display off
        sb      t3, 0x0054(t1)              // show/hide left side

        lli     t3, 0x0000                  // t3 = display on
        lw      t4, 0x0008(sp)              // t4 = address to store reference
        li      t1, gfx                     // t1 = gfx
        bnel    t4, t1, pc() + 8            // if not the first object, then hide right side
        lli     t3, 0x0002                  // t3 = display off
        sb      t3, 0x0054(t0)              // show/hide right side

        sw      v0, 0x0000(t4)              // store reference to gfx object
        addiu   t0, v0, 0x0040              // t0 = address to store next reference
        sw      t0, 0x0008(sp)              // save address to store reference

        lw      t6, 0x0048(sp)              // t6 = gMPCollisionGeometry
        bnez    t2, _create_loop            // if we have more to create, loop
        lw      s0, 0x000C(sp)              // s0 = next vert_data_id address

        // Now we go through and hide any previously created objects we no longer need
        // We don't destroy so we don't end up running out of space
        lw      a0, 0x0040(v0)              // a0 = if non-zero, existing object we no longer need to display
        _hide_loop:
        beqz    a0, _create_indicator       // if nothing to hide, skip
        lli     t1, 0x0001                  // t1 = display off
        sw      t1, 0x007C(a0)              // turn off display
        b       _hide_loop                  // loop
        lw      a0, 0x0040(a0)              // t0 = non-zero, next existing object we no longer need to display

        _create_indicator:
        OS.read_word(indicator, v0)         // v0 = indicator object, if created already
        bnez    v0, _update_dobj_ref        // skip creating if already created
        li      a0, koth_indicator_gfx_struct
        jal     0x800FDB1C                  // create KOTH indicator GFX
        nop
        li      t0, update_indicator_gfx_
        sw      t0, 0x0014(v0)              // set the update routine, which doesn't get set since we don't want to limit the number of objects
        li      t0, indicator               // t0 = indicator object pointer
        sw      v0, 0x0000(t0)              // save indicator object
        _update_dobj_ref:
        lw      t0, 0x0040(sp)              // t0 = geo dobj for positioning
        sw      t0, 0x0044(v0)              // save reference to geo dobj
        lw      t1, 0x0074(v0)              // t0 = top joint
        sb      r0, 0x0054(t1)              // ensure display is turned on

        OS.read_word(gfx, t0)               // t0 = first gfx object
        lw      t0, 0x0074(t0)              // t0 = top joint

        lw      t3, 0x001C(t0)              // t3 = X
        sw      t3, 0x001C(t1)              // save X
        lw      t3, 0x0020(t0)              // t3 = Y
        sw      t3, 0x0020(t1)              // save Y
        // lw      t3, 0x0024(t0)              // t3 = Z
        // sw      t3, 0x0024(t1)              // save Z

        lw      t1, 0x0010(t1)              // t1 = texture joint
        sb      r0, 0x0054(t1)              // ensure display is turned on
        lw      t0, 0x0010(t0)              // t0 = joint 1 (anchor)

        lwc1    f4, 0x0050(sp)              // f4 = total width
        lui     at, 0x3F00                  // at = 0.5
        mtc1    at, f2                      // f2 = 0.5
        mul.s   f4, f4, f2                  // f4 = width/2 = midpoint

        lwc1    f6, 0x001C(t0)              // f6 = X
        add.s   f6, f6, f4                  // f6 = X at midpoint
        swc1    f6, 0x001C(t1)              // save X
        // lw      t3, 0x0024(t0)              // t3 = Z
        // sw      t3, 0x0024(t1)              // save Z

        // Now find the Y value by finding the object that contains the midpoint, getting its slope and using that
        mtc1    r0, f10                     // f10 = running width = 0
        abs.s   f4, f4                      // f8 = |midpoint|
        _loop_find_mid_line:
        lw      t4, 0x0010(t0)              // t4 = joint 2-0 (left anchor)
        lwc1    f8, 0x001C(t4)              // f8 = width
        abs.s   f8, f8                      // f8 = |width|
        add.s   f10, f10, f8                // f10 = running width + current width = new running width
        c.le.s  f4, f10                     // check if midpoint is in this line
        nop
        bc1t    _get_slope                  // if this is the object, then get the slope
        lw      t5, 0x0004(t4)              // t5 = current gfx object
        // if we're here, it's not the object, so get the next one and try again
        lw      t0, 0x0040(t5)              // t0 = next gfx object, if it exists (it should!)
        beqz    t0, _get_slope              // if there is not one, then just use this line I guess!
        nop
        lw      t0, 0x0074(t0)              // t0 = top joint
        b       _loop_find_mid_line         // loop
        lw      t0, 0x0010(t0)              // t0 = joint 1 (right anchor)

        _get_slope:
        // t4 = left anchor of gfx object that contains midpoint
        // slope = delta y / delta x = height / width
        lwc1    f12, 0x0020(t4)             // f12 = height
        div.s   f14, f12, f8                // f14 = height / width = slope
        sub.s   f10, f10, f4                // f10 = running width - midpoint = distance from left anchor
        sub.s   f8, f8, f10                 // f8 = current width - distance from left anchor = distance from right anchor
        mul.s   f8, f14, f8                 // f8 = slope * distance from right anchor = height at midpoint
        lw      t4, 0x0014(t4)              // t4 = joint 1 (right anchor)
        lwc1    f6, 0x0020(t4)              // f6 = Y
        lui     at, 0x43FA                  // at = 500
        mtc1    at, f2                      // f2 = 500
        add.s   f6, f6, f2                  // f6 = Y, moved up
        add.s   f6, f6, f8                  // f6 = Y, adjusted for midpoint
        swc1    f6, 0x0020(t1)              // save Y

        _end:
        lw      ra, 0x0004(sp)              // restore registers
        jr      ra
        addiu   sp, sp, 0x0060              // deallocate stack space
    }

    // @ Description
    // Gets the XYZ of a surface's center point
    // @ Arguments
    // a0 - line_id (i.e. 0xEC from player struct)
    // a1 - address of position floats (X, Y)
    scope get_surface_center_coords_: {
        addiu   sp, sp, -0x0010             // allocate stack space
        sw      ra, 0x0004(sp)              // save registers

        // Initialize position
        sw      r0, 0x0000(a1)              // set X to 0
        sw      r0, 0x0004(a1)              // set Y to 0

        // Figure out which line_info it is
        OS.read_word(0x80131368, t6)        // t6 = gMPCollisionGeometry
        lhu     t1, 0x0000(t6)              // t1 = # of groups
        lw      t5, 0x0010(t6)              // t5 = line_info[]

        _loop:
        lhu     t2, 0x0002(t5)              // t2 = min_line_id
        lhu     t3, 0x0004(t5)              // t3 = # in group
        addu    t4, t2, t3                  // t4 = max_line_id + 1
        sltu    at, a0, t4                  // at = 1 if this is the group
        bnezl   at, _yokumono_id_found      // if this is the group, exit loop
        lhu     t1, 0x0000(t5)              // t1 = yokumono_id
        addiu   t1, t1, -0x0001             // t1--
        bnez    t1, _loop                   // loop over all groups
        addiu   t5, t5, 0x0012              // t5 = next line_info

        _yokumono_id_found:
        OS.read_word(0x80131304, t2)        // t2 = gMPCollisionYakumonoDObjs[]
        sll     at, t1, 0x0002              // at = offset to dobj
        addu    t2, t2, at                  // t2 = dobj address
        lw      t2, 0x0000(t2)              // t2 = dobj
        lw      t3, 0x0084(t2)              // t3 = non-zero if clipping XY relative to dobj XY
        bnez    t3, _get_dobj_coords        // if clipping XY relative to dobj XY, get dobj XY
        lw      t3, 0x0070(t2)              // t3 = non-zero if clipping XY relative to dobj XY
        beqz    t3, _get_clipping           // if clipping XY not relative to dobj XY, skip getting dobj XY
        nop

        _get_dobj_coords:
        lw      t3, 0x001C(t2)              // t3 = dobj X
        sw      t3, 0x0000(a1)              // save dobj X
        lw      t3, 0x0020(t2)              // t3 = dobj Y
        sw      t3, 0x0004(a1)              // save dobj Y

        _get_clipping:
        lw      t0, 0x000C(t6)              // t0 = gMPCollisionVertexLinks
        sll     t1, a0, 0x0002              // t1 = offset to vertex info
        addu    t0, t0, t1                  // t0 = vertex info
        lhu     t1, 0x0000(t0)              // t1 = min_vert_id
        lhu     t2, 0x0002(t0)              // t2 = # of verts in line
        addu    t2, t2, t1                  // t2 = max_vert_id + 1
        addiu   t2, t2, -0x0001             // t2 = max_vert_id

        lw      t0, 0x0008(t6)              // t0 = gMPCollisionVertexIDs
        sll     t1, t1, 0x0001              // t1 = offset to min_vert_data_id
        addu    t1, t0, t1                  // t1 = address of min_vert_data_id
        lhu     t1, 0x0000(t1)              // t1 = min_vert_data_id
        sll     t2, t2, 0x0001              // t2 = offset to max_vert_data_id
        addu    t2, t0, t2                  // t2 = address of max_vert_data_id
        lhu     t2, 0x0000(t2)              // t2 = max_vert_data_id

        lw      t0, 0x0004(t6)              // t0 = gMPCollisionVertexData
        sll     at, t1, 0x0002              // at = min_vert_data_id * 4
        sll     t1, t1, 0x0001              // at = min_vert_data_id * 2
        addu    t1, at, t1                  // t1 = offset to min_vert_data
        addu    t1, t0, t1                  // t1 = min_vert_data
        lh      at, 0x0000(t1)              // at = min_x
        mtc1    at, f2                      // f2 = min_x
        cvt.s.w f2, f2                      // f2 = min_x, float
        lh      at, 0x0002(t1)              // at = min_y
        mtc1    at, f4                      // f4 = min_y
        cvt.s.w f4, f4                      // f4 = min_y, float
        sll     at, t2, 0x0002              // at = max_vert_data_id * 4
        sll     t2, t2, 0x0001              // at = max_vert_data_id * 2
        addu    t2, at, t2                  // t2 = offset to max_vert_data
        addu    t2, t0, t2                  // t2 = max_vert_data
        lh      at, 0x0000(t2)              // at = max_x
        mtc1    at, f6                      // f6 = max_x
        cvt.s.w f6, f6                      // f6 = max_x, float
        lh      at, 0x0002(t2)              // at = max_y
        mtc1    at, f8                      // f8 = max_y
        cvt.s.w f8, f8                      // f8 = max_y, float

        lui     at, 0x3F00                  // at = 0.5F
        mtc1    at, f10                     // f10 = 0.5F

        // find mid point
        add.s   f2, f2, f6                  // f2 = (min_x + max_x)
        mul.s   f2, f2, f10                 // f2 = (min_x + max_x) / 2 = mid point x
        add.s   f4, f4, f8                  // f4 = (min_y + max_y)
        mul.s   f4, f4, f10                 // f4 = (min_y + max_y) / 2 = mid point y

        lwc1    f10, 0x0000(a1)             // f10 = x offset
        lwc1    f12, 0x0004(a1)             // f12 = y offset
        add.s   f2, f2, f10                 // f2 = true mid x
        add.s   f4, f4, f12                 // f4 = true mid y
        lui     at, 0x4348                  // at = 200 = y offset
        mtc1    at, f6                      // f6 = 0.5F
        add.s   f4, f4, f6                  // f4 = mid y plus offset

        swc1    f2, 0x0000(a1)              // save mid x
        swc1    f4, 0x0004(a1)              // save mid y

        lw      ra, 0x0004(sp)              // restore registers
        jr      ra
        addiu   sp, sp, 0x0010              // deallocate stack space
    }

    // @ Description
    // Gets a random line_id to use as the hill
    scope get_random_line_id_: {
        addiu   sp, sp,-0x0030              // allocate stack space
        sw      ra, 0x0004(sp)              // ~

        lli     a0, 0x0000                  // a0 = number of valid line_ids
        addiu   a1, sp, 0x0000              // a1 = valid line_id array end

        OS.read_word(0x80131368, t6)        // t6 = gMPCollisionGeometry
        lhu     t1, 0x0000(t6)              // t1 = # of groups
        lw      t5, 0x0010(t6)              // t5 = line_info[]

        _loop:
        lhu     t2, 0x0002(t5)              // t2 = min_line_id
        lhu     t3, 0x0004(t5)              // t3 = # in group
        beqz    t3, _next                   // if none in group, skip
        addu    a0, a0, t3                  // a0 = number of valid line_ids

        _inner_loop:
        sh      t2, -0x0002(a1)              // insert into array
        addiu   t2, t2, 0x0001              // next line_id
        addiu   t3, t3, -0x0001             // t3 = # remaining in group
        bnez    t3, _inner_loop             // if more to insert, loop
        addiu   a1, a1, -0x0002             // increase array size

        _next:
        addiu   t1, t1, -0x0001             // t1--
        bnez    t1, _loop                   // loop over all groups
        addiu   t5, t5, 0x0012              // t5 = next line_info

        or      t0, sp, r0                  // t0 = stack
        or      sp, a1, r0                  // move stack so our array is safe
        andi    t2, sp, 0b0011              // t2 = 0 if aligned
        bnezl   t2, pc() + 8                // if not aligned, align
        addiu   sp, sp, -0x0002             // sp, aligned
        addiu   sp, sp, -0x0010             // allocate a bit more
        sw      t0, 0x0004(sp)              // remember stack

        // here, a1 is our array of valid line_ids and a0 is the number of line_ids
        _get_random_int:
        sw      a0, 0x000C(sp)              // save count to stack
        jal     Global.get_random_int_safe_
        sw      a1, 0x0008(sp)              // save array address to stack

        lw      a0, 0x000C(sp)              // a0 = count
        lw      a1, 0x0008(sp)              // a1 = array address

        sll     v0, v0, 0x0001              // v0 = offset to line_id
        addu    t0, a1, v0                  // a1 = line_id address
        lhu     v0, 0x0000(t0)              // v0 = line_id

        // Here, make sure it's a valid line_id:
        // it's not a damage surface (except for acid)
        OS.read_word(0x80131368, t6)        // t6 = gMPCollisionGeometry
        lw      t0, 0x000C(t6)              // t0 = gMPCollisionVertexLinks
        sll     t1, v0, 0x0002              // t1 = offset to vertex info
        addu    t0, t0, t1                  // t0 = vertex info
        lhu     t1, 0x0000(t0)              // t1 = min_vert_id

        lw      t0, 0x0008(t6)              // t0 = gMPCollisionVertexIDs
        sll     t1, t1, 0x0001              // t1 = offset to min_vert_data_id
        addu    t1, t0, t1                  // t1 = address of min_vert_data_id
        lhu     t1, 0x0000(t1)              // t1 = min_vert_data_id

        lw      t0, 0x0004(t6)              // t0 = gMPCollisionVertexData
        sll     at, t1, 0x0002              // at = min_vert_data_id * 4
        sll     t1, t1, 0x0001              // at = min_vert_data_id * 2
        addu    t1, at, t1                  // t1 = offset to min_vert_data
        addu    t1, t0, t1                  // t1 = min_vert_data
        lbu     t0, 0x0005(t1)              // t0 = surface_type

        sltiu   at, t0, 0x0007              // at = 1 if a Normal surface type (0x00 - 0x06)
        bnez    at, _end                    // if valid, v0 is good!
        sltiu   at, t0, 0x000C              // at = 1 if a damage surface type (0x07 - 0x0B)
        bnez    at, _get_random_int         // if not valid, get a new v0!
        sltiu   at, t0, 0x000F              // at = 1 if a MK Pipe/Platforms/RTTF surface type (0x0C - 0x0E)
        bnez    at, _end                    // if valid, v0 is good!
        sltiu   at, t0, 0x0011              // at = 1 if a damage/or Big Blue surface type (0x0F - 0x10)
        bnez    at, _get_random_int         // if not valid, get a new v0!
        lli     at, 0x0011                  // at = cool_cool_surface_1 (0x11)
        beq     at, t0, _end                // if valid, v0 is good!
        sltiu   at, t0, 0x001F              // at = 1 if a custom damage surface type (0x12 - 0x1E)
        bnez    at, _get_random_int         // if not valid, get a new v0!
        sltiu   at, t0, 0x0024              // at = 1 if a push or acid surface type (0x1F - 0x23)
        bnez    at, _end                    // if valid, v0 is good!
        nop
        b       _get_random_int             // if we get here, try again!
        nop

        _end:
        lw      sp, 0x0004(sp)              // restore stack
        lw      ra, 0x0004(sp)              // restore registers
        jr      ra
        addiu   sp, sp, 0x0030              // deallocate stack space
    }

    // @ Description
    // Sets the hill to a random line_id
    scope set_random_hill_: {
        addiu   sp, sp,-0x0030              // allocate stack space
        sw      ra, 0x0004(sp)              // ~

        lli     at, 0x0003                  // at = 3 (# of times to try to get a new hill)
        sw      at, 0x0008(sp)              // save number of tries

        _get_random:
        jal     get_random_line_id_
        nop
        sw      v0, 0x0010(sp)              // save hill_line_id

        jal     create_ground_gfx_
        or      a0, v0, r0                  // a0 = hill_line_id

        jal     is_hill_outside_blast_zone_ // v0 = TRUE if we need to try a different hill
        nop
        bnez    v0, _get_random             // if we need to try a different hill, try again
        nop

        OS.read_word(gfx, a0)               // a0 = ground gfx object
        jal     update_ground_gfx_          // update it so we can check if it's off
        nop
        OS.read_word(gfx, t0)               // t0 = ground gfx object
        lw      t0, 0x0074(t0)              // t0 = top joint
        lh      t0, 0x0054(t0)              // t0 = 0 if displayed, 2 if not
        bnez    t0, _get_random             // if it's not currently displayed, try again
        nop

        OS.read_word(hill_line_id, t1)      // t1 = current_hill_id
        lw      v0, 0x0010(sp)              // v0 = hill_line_id
        bne     t1, v0, _set_hill           // if not the same as the previous hill, set it!
        lw      at, 0x0008(sp)              // at = number of tries
        beqz    at, _end                    // if we're out of tries, just keep it the same! but don't play sound
        addiu   at, at, -0x0001             // at--
        b       _get_random                 // try again
        sw      at, 0x0008(sp)              // save number of tries

        _set_hill:
        li      t0, hill_line_id
        sw      v0, 0x0000(t0)              // set hill

        jal     0x800269C0                  // play SFX when hill changes
        lli     a0, 0x00A2                  // a0 = Training Select sound

        li      t0, contested_buffer
        sw      r0, 0x0000(t0)              // reset contested buffer

        _end:
        lw      ra, 0x0004(sp)              // restore registers
        jr      ra
        addiu   sp, sp, 0x0030              // deallocate stack space
    }

    // @ Description
    // Checks if hill is outside map bounds by using the indicator object's position
    // @ Returns
    // v0 - boolean of TRUE if outside, FALSE if within
    scope is_hill_outside_blast_zone_: {
        lli    v0, OS.FALSE                  // v0 = FALSE (within blast zone)

        // check if current hill is outside blastzone... we can use the indicator object
        OS.read_word(0x80131300, at)        // at = gMPCollisionGroundData
        OS.read_word(indicator, t0)         // t0 = gfx ground object
        lw      t0, 0x0074(t0)              // t0 = top joint
        lw      t1, 0x0010(t0)              // t1 = joint 1 (right anchor)
        lwc1    f2, 0x001C(t0)              // f2 = base x
        lwc1    f12, 0x001C(t1)             // f12 = offset x
        add.s   f12, f2, f12                // f12 = x
        lh      t6, 0x0078(at)              // t6 = blast zone right
        mtc1    t6, f6                      // f6 = blast zone right
        cvt.s.w f6, f6                      // f6 = blast zone right, float
        c.le.s  f6, f12                     // check if (blast zone right <= x)
        nop
        bc1tl   _end                        // if outside blast zone, return TRUE
        lli     v0, OS.TRUE

        lh      t8, 0x007A(at)              // t8 = blast zone left
        mtc1    t8, f8                      // f8 = blast zone left
        cvt.s.w f8, f8                      // f8 = blast zone left, float
        c.le.s  f12, f8                     // check if (x <= blast zone left)
        nop
        bc1tl   _end                        // if outside blast zone, return TRUE
        lli     v0, OS.TRUE

        lwc1    f4, 0x0020(t0)              // f4 = base y
        lwc1    f14, 0x0020(t1)             // f14 = offset y
        add.s   f14, f4, f14                // f14 = y
        lh      t2, 0x0074(at)              // t2 = blast zone top
        mtc1    t2, f2                      // f2 = blast zone top
        cvt.s.w f2, f2                      // f2 = blast zone top, float
        c.le.s  f2, f14                     // check if (blast zone top <= y)
        nop
        bc1tl   _end                        // if outside blast zone, return TRUE
        lli     v0, OS.TRUE

        lh      t4, 0x0076(at)              // t4 = blast zone bottom
        mtc1    t4, f4                      // f4 = blast zone bottom
        cvt.s.w f4, f4                      // f4 = blast zone bottom, float
        c.le.s  f14, f4                     // check if (y <= blast zone bottom)
        nop
        bc1tl   _end                        // if outside blast zone, return TRUE
        lli     v0, OS.TRUE

        _end:
        jr      ra
        nop
    }

    // @ Description
    // Updates the hill at a random interval
    scope hill_update_routine_: {
        addiu   sp, sp,-0x0030              // allocate stack space
        sw      ra, 0x0004(sp)              // ~

        OS.read_byte(Global.vs.game_status, t0)
        lli     t1, 0x0001                  // t1 = ongoing match
        bne     t0, t1, _end                // if match not started or is paused/unpausing, etc, don't update timer
        nop

        li      t0, timer
        lw      t1, 0x0000(t0)              // t1 = timer
        addiu   t2, t1, -0x0001             // t2 = t1 - 1
        beqz    t1, _new_hill               // if timer is 0, get new hill
        sw      t2, 0x0000(t0)              // update timer

        li      at, hidden_frames
        OS.read_word(gfx, t0)
        beqz    t0, _end                    // if no GFX object yet, skip
        nop
        lw      t0, 0x0074(t0)              // t0 = top joint
        lh      t0, 0x0054(t0)              // t0 = 0 if display on, 2 if off
        beqzl   t0, _check_blast_zone       // if displayed, check blast zones
        sw      r0, 0x0000(at)              // reset hidden frames to 0

        lw      t0, 0x0000(at)              // current hidden frame count
        lli     t1, 60 * 2                  // t1 = 2 seconds
        beql    t0, t1, _new_hill           // if it's been hidden for 2 seconds, get a new hill
        sw      r0, 0x0000(at)              // reset hidden frames to 0

        addiu   t0, t0, 0x0001              // t0++
        sw      t0, 0x0000(at)              // increment hidden frames

        _check_blast_zone:
        jal     is_hill_outside_blast_zone_ // v0 = TRUE if we need a new hill
        nop
        beqz    v0, _end                    // if we don't need a new hill, skip
        nop

        _new_hill:
        jal     Global.get_random_int_safe_
        lli     a0, 0x04B0                  // a0 = 20 seconds in frames

        addiu   t1, v0, 0x04B0              // t1 = 20 seconds + (0 to 20 seconds)
        li      t0, timer
        sw      t1, 0x0000(t0)              // update timer

        jal     set_random_hill_
        nop

        _end:
        lw      ra, 0x0004(sp)              // restore registers
        jr      ra
        addiu   sp, sp, 0x0030              // deallocate stack space

        hidden_frames:
        dw 0
    }

    // @ Description
    // Determines if each player is on the hill and increments score accordingly
    scope track_score_: {
        addiu   sp, sp,-0x0030              // allocate stack space
        sw      ra, 0x0004(sp)              // ~

        OS.read_byte(Global.vs.game_status, t0)
        lli     t1, 0x0001                  // t1 = ongoing match
        bne     t0, t1, _end                // if match not started or is paused/unpausing, etc, don't score
        nop

        OS.read_word(hill_line_id, t0)      // t0 = hill_line_id
        OS.read_word(Global.p_struct_head, at) // at = p1 player struct
        OS.read_byte(Global.vs.teams, t8)   // t8 = 1 if teams
        li      t7, hill_status             // t7 = hill_status
        li      t6, team_hill_status        // t6 = team_hill_status
        li      t5, king_eligible           // t5 = king_eligible

        // Initialize hill_status to all 0 (not on hill)
        sw      r0, 0x0000(t7)              // clear hill_status
        sw      r0, 0x0000(t6)              // clear team_hill_status
        sw      r0, 0x0000(t5)              // clear king_eligible

        // Determine the hill status for each player/team.
        addiu   a1, r0, -0x0001             // a1 = king = -1  (no king)
        _loop:
        lw      t1, 0x0004(at)              // t1 = player object
        beqz    t1, _next                   // if no player object, get next player struct
        lbu     t1, 0x000D(at)              // t1 = port
        lw      t2, 0x00EC(at)              // t2 = line_id
        bne     t2, t0, _next               // if not on the hill, skip
        lw      t2, 0x014C(at)              // t2 = kinetic state (0 = grounded, 1 = aerial)
        bnez    t2, _next                   // if not grounded, skip
        lw      t2, 0x0844(at)              // t2 = captured by player object
        bnez    t2, _next                   // if captured, skip
        addu    t3, t7, t1                  // t3 = hill_status
        lli     t2, 0x0001                  // t2 = 1 = on hill
        sb      t2, 0x0000(t3)              // save hill_status

        lw      t4, 0x0840(at)              // t4 = captured player object
        beqz    t4, _set_king_eligible      // if no player captured, then this player is king eligible
        lli     a2, OS.TRUE
        lw      t4, 0x0084(t4)              // t4 = captured player struct
        lbu     t4, 0x000C(t4)              // t4 = captured player's team
        bnezl   t8, pc() + 8                // if teams, take team id instead
        lbu     t1, 0x000C(at)              // t1 = team
        beq     t4, t1, _set_king_eligible  // if captured player is on the same team, then this player is king eligible
        nop
        // if here, then the player is holding another player, so they are not eligible and the hill is contested
        lli     a2, OS.FALSE
        addiu   a1, r0, -0x0002             // a1 = -2 = contested

        _set_king_eligible:
        lbu     t1, 0x000D(at)              // t1 = port
        addu    t3, t5, t1                  // t3 = king_eligible
        sb      a2, 0x0000(t3)              // save king_eligible

        lli     t2, OS.TRUE
        bnezl   t8, pc() + 8                // if teams, take team id instead
        lbu     t1, 0x000C(at)              // t1 = team
        addu    t3, t6, t1                  // t3 = team_hill_status
        sb      t2, 0x0000(t3)              // save team_hill_status

        // if here, we can set this team as the king if:
        // (1) a1 is -1 (king uncontested) OR a1 is the current team, and
        // (1) a2 is TRUE (king eligible)
        addiu   t2, r0, -0x0001             // t2 = -1
        beq     a1, t2, _check_eligible     // if king is uncontested, check if eligible
        nop
        beq     a1, t1, _next               // if already set to the current team, we good!
        nop
        // if here, it was set to a different team, so mark uncontested
        b       _next
        addiu   a1, r0, -0x0002             // a1 = -2 = contested

        _check_eligible:
        bnezl   a2, _next                   // if port is king eligible, set king
        or      a1, t1, r0                  // a1 = king = port/team
        // otherwise, consider contested now
        addiu   a1, r0, -0x0002             // a1 = -2 = contested

        _next:
        lw      at, 0x0000(at)              // at = next player struct
        bnez    at, _loop                   // loop over all player structs
        nop

        bgez    a1, _king_exists            // if a king exists, go to that logic
        addiu   t0, r0, -0x0002             // t0 = -2 = contested
        beq     a1, t0, _king_contested     // if king is contested, go to that logic
        nop

        // If here, then noone is on the hill... it will be considered contested unless the buffer is 0

        _king_exists:
        li      t7, contested_buffer
        lw      at, 0x0000(t7)              // at = contested buffer
        beqz    at, _prev_check             // if buffer is 0, we good!
        addiu   at, at, -0x0001             // at--
        sw      at, 0x0000(t7)              // update buffer
        b       _prev_check                 // if buffer had time left, we update to contested
        addiu   a1, r0, -0x0002             // a1 = king = -2 = contested

        _king_contested:
        li      t7, contested_buffer
        lli     t0, CONTESTED_BUFFER
        sw      t0, 0x0000(t7)              // set buffer

        _prev_check:
        li      t7, king
        lw      t0, 0x0000(t7)              // t0 = prev king
        sw      a1, 0x0000(t7)              // set king

        beq     a1, t0, _start_score        // if king did not change, skip
        lli     a0, 0x0115                  // a0 = Board the Platforms land sound
        bltzl   a1, _play_sfx               // if no king, play different sound
        lli     a0, 0x00A9                  // a0 = 1P Score Register sound

        _play_sfx:
        // play FGM when king changes
        jal     0x800269C0                  // play SFX when hill changes
        nop

        _start_score:
        OS.read_word(king, a1)              // a1 = king

        // Now increment the score for the king(s)
        // (Incremement for all on the same team)
        OS.read_word(time, v1)              // v1 = KOTH time target
        lli     t3, 60                      // t3 = frames per second
        multu   v1, t3                      // v1 = KOTH time target * frames per second
        mflo    v1                          // v1 = KOTH time target, frames

        li      t3, winner_time_updated
        sw      r0, 0x0000(t3)              // initialize winner_time_updated to FALSE for all teams

        OS.read_word(Global.p_struct_head, t0) // t0 = p1 player struct
        li      t7, hill_status             // t7 = hill_status
        li      t6, king_eligible           // t6 = king_eligible
        li      t5, scores                  // t5 = scores
        li      t4, team_scores             // t4 = team_scores
        _score_loop:
        lw      a0, 0x0004(t0)              // a0 = player object
        beqz    a0, _score_next             // if no player object, get next player struct
        lbu     t1, 0x000C(t0)              // t1 = team
        bne     t1, a1, _score_next         // if not the king, skip
        lbu     t2, 0x000D(t0)              // t2 = port
        addu    t3, t7, t2                  // t3 = hill_status address
        lbu     t3, 0x0000(t3)              // t3 = hill_status
        beqz    t3, _score_next             // if not on the hill, skip
        addu    t3, t6, t2                  // t3 = king_eligible address
        lbu     t3, 0x0000(t3)              // t3 = king_eligible
        beqz    t3, _score_next             // if not eligible to be king, skip
        sll     t1, t1, 0x0002              // t1 = offset to team score
        sll     t2, t2, 0x0002              // t2 = offset to score
        addu    t3, t5, t2                  // t3 = score address
        lw      t2, 0x0000(t3)              // t2 = score
        addu    a3, t4, t1                  // a3 = team score address
        lw      a2, 0x0000(a3)              // a2 = score

        bnel    a2, v1, _increment_scores   // if we haven't reached the target, increment scores
        nop

        // otherwise we need to increment the winner_times value
        li      a0, winner_times
        addu    a0, a0, t1                  // a0 = address of winner time
        lw      t1, 0x0000(a0)              // t1 = winner time
        // Going to make FFA increment 2 per frame and Teams 1 per frame
        addiu   v0, t1, 0x0002              // v0 = winner time incremented
        OS.read_byte(Global.vs.teams, t8)   // t8 = 1 if teams
        subu    v0, v0, t8                  // increment faster if not teams
        li      a3, winner_time_updated
        lbu     t1, 0x000C(t0)              // t1 = team
        addu    t1, a3, t1                  // t1 = address of winner_time_updated
        lbu     a3, 0x0000(t1)              // a3 = winner_time_updated value
        beqzl   a3, pc() + 8                // if not already updated, update value
        sw      v0, 0x0000(a0)              // update winner_time value
        lli     a3, OS.TRUE                 // a3 = TRUE
        b       _apply_gfx_routines
        sb      a3, 0x0000(t1)              // set winner_time_updated to TRUE

        _increment_scores:
        addiu   t2, t2, 0x0001              // t2 = score + 1
        sw      t2, 0x0000(t3)              // update score
        addiu   a2, a2, 0x0001              // a2 = score + 1
        sw      a2, 0x0000(a3)              // update team score

        _apply_gfx_routines:
        // apply GFX routine
        lw      t1, 0x0A28(t0)              // t1 = player gfx routine
        bnez    t1, _score_next             // if already has a routine, skip
        lbu     t1, 0x000C(t0)              // t1 = team
        li      t2, gfx_routines            // t2 = gfx_routines
        OS.read_byte(Global.vs.teams, t8)   // t8 = 1 if teams
        bnezl   t8, pc() + 8                // if teams, take team id instead
        addiu   t2, t2, team_gfx_routines - gfx_routines // t2 = team_gfx_routines
        li      t8, use_cpu_color
        addu    t8, t8, t1                  // t8 = address of use_cpu_color
        lbu     t8, 0x0000(t8)              // t8 = use_cpu_color
        sll     t1, t1, 0x0002              // t1 = offset to routine
        bnezl   t8, pc() + 8                // if CPU color should be used, use CPU color
        lli     t1, 4 * 0x0004              // t2 = offset to CPU color
        addu    t2, t2, t1                  // t2 = address of routine
        lw      t1, 0x0000(t2)              // t1 = gfx routine
        sw      t1, 0x0A28(t0)              // set player gfx routine

        _score_next:
        li      a0, winner_times
        lbu     t1, 0x000C(t0)              // t1 = team
        beq     t1, a1, _check_next         // if the king, skip
        sll     t1, t1, 0x0002              // t1 = offset to winner time
        addu    t2, a0, t1                  // t2 = address of winner time
        sw      r0, 0x0000(t2)              // reset winner time
        _check_next:
        lw      t0, 0x0000(t0)              // t0 = next player struct
        bnez    t0, _score_loop             // loop over all player structs
        nop

        _end:
        lw      ra, 0x0004(sp)              // restore registers
        jr      ra
        addiu   sp, sp, 0x0030              // deallocate stack space

        // @ Description
        // Tracks if a player is on the hill
        hill_status:
        db 0, 0, 0, 0;

        // @ Description
        // Tracks if a team is on the hill
        team_hill_status:
        db 0, 0, 0, 0;

        // @ Description
        // Tracks if a player can be king
        king_eligible:
        db 0, 0, 0, 0;

        // @ Description
        // Tracks if a team's winner_time has been updated this frame
        winner_time_updated:
        db 0, 0, 0, 0;

        // @ Description
        // The GFX routine to use per port
        gfx_routines:
        dw GFXRoutine.KOTH_RED
        dw GFXRoutine.KOTH_BLUE
        dw GFXRoutine.KOTH_YELLOW
        dw GFXRoutine.KOTH_GREEN
        dw GFXRoutine.KOTH_GRAY

        // @ Description
        // The GFX routine to use per team
        team_gfx_routines:
        dw GFXRoutine.KOTH_RED
        dw GFXRoutine.KOTH_BLUE
        dw GFXRoutine.KOTH_GREEN
        dw GFXRoutine.KOTH_YELLOW
    }

    // @ Description
    // Updates the indicators to align with scores
    // @ Arguments
    // a0 - update_indicators_ routine object
    scope update_indicators_: {
        addiu   sp, sp,-0x0030              // allocate stack space
        sw      ra, 0x0004(sp)              // ~

        lwc1    f0, 0x0084(a0)              // f0 = target time
        cvt.s.w f0, f0                      // f0 = target time, float

        li      at, indicators              // at = indicators array
        lli     t8, 0x0004                  // t8 = times to loop

        _loop:
        lw      t1, 0x0000(at)              // t1 = indicator object, if created
        beqz    t1, _next                   // skip if not created
        nop
        lw      t2, 0x0084(t1)              // t2 = score address
        lwc1    f2, 0x0000(t2)              // f2 = score
        cvt.s.w f2, f2                      // f2 = score, float

        div.s   f4, f2, f0                  // f4 = score / target time = % complete
        lui     t6, 0x4220                  // t6 = 40 = full width of indicator
        mtc1    t6, f6                      // f6 = 40 = full width of indicator
        mul.s   f8, f4, f6                  // f8 = % complete * full width = width of indicator
        trunc.w.s f8, f8                    // f8 = width of indicator, int
        swc1    f8, 0x0038(t1)              // update width

        mfc1    t0, f8                      // t0 = width
        sltiu   t0, t0, 40                  // t0 = 0 if full width
        bnez    t0, _next                   // if not full width, skip
        lw      t0, 0x0020(t1)              // t0 = flash rectangle object

        lbu     t2, 0x0043(t0)              // t2 = current alpha
        lw      t3, 0x0084(t0)              // t2 = alpha delta
        addu    t2, t2, t3                  // t2 = new alpha
        sb      t2, 0x0043(t0)              // update alpha
        beqzl   t2, pc() + 8                // if alpha is 0, update alpha delta to positive
        lli     t3, ALPHA_DELTA
        addiu   t2, t2, -ALPHA_DELTA_MAX
        beqzl   t2, pc() + 8                // if alpha is at max, update alpha delta to negative
        addiu   t3, r0, -ALPHA_DELTA
        sw      t3, 0x0084(t0)              // update alpha delta

        _next:
        addiu   t8, t8, -0x0001             // t8--
        bnez    t8, _loop                   // if not done looping, loop
        addiu   at, at, 0x0004

        _end:
        lw      ra, 0x0004(sp)              // restore registers
        jr      ra
        addiu   sp, sp, 0x0030              // deallocate stack space
    }

    // @ Description
    // Runs when a game starts and sets up KOTH. Called from Render.asm.
    scope setup_: {
        addiu   sp, sp,-0x0030              // allocate stack space
        sw      ra, 0x0004(sp)              // ~

        li      t0, VsRemixMenu.vs_mode_flag
        lw      t0, 0x0000(t0)              // t0 = vs_mode_flag
        lli     t1, VsRemixMenu.mode.KOTH
        bne     t0, t1, _end                // if not KOTH, skip
        nop

        li      t0, timer
        lli     t1, 60 * 2                  // t1 = 2 seconds
        sw      t1, 0x0000(t0)              // initialize timer to 2 seconds

        li      t0, scores
        sw      r0, 0x0000(t0)              // initialize score to 0 (p1)
        sw      r0, 0x0004(t0)              // initialize score to 0 (p2)
        sw      r0, 0x0008(t0)              // initialize score to 0 (p3)
        sw      r0, 0x000C(t0)              // initialize score to 0 (p4)

        li      t0, team_scores
        sw      r0, 0x0000(t0)              // initialize score to 0 (red)
        sw      r0, 0x0004(t0)              // initialize score to 0 (blue)
        sw      r0, 0x0008(t0)              // initialize score to 0 (green)
        sw      r0, 0x000C(t0)              // initialize score to 0 (yellow)

        li      t0, winner_times
        sw      r0, 0x0000(t0)              // initialize winner time to 0
        sw      r0, 0x0004(t0)              // initialize winner time to 0
        sw      r0, 0x0008(t0)              // initialize winner time to 0
        sw      r0, 0x000C(t0)              // initialize winner time to 0

        li      t1, gfx                     // t1 = gfx
        sw      r0, 0x0000(t1)              // initialize gfx to NULL

        li      t1, indicator               // t1 = indicator
        sw      r0, 0x0000(t1)              // initialize indicator to NULL

        li      t0, hill_line_id
        addiu   t1, r0, -0x0001             // t1 = -1
        sw      t1, 0x0000(t0)              // initialize hill_line_id to -1

        li      t0, king
        sw      t1, 0x0000(t0)              // initialize king to -1

        Render.load_file(File.KING_OF_THE_HILL_GFX, Render.file_pointer_4) // load KOTH GFX into file_pointer_4
        Render.register_routine(hill_update_routine_)
        Render.register_routine(track_score_)

        // Initialize indicators to all 0
        li      t7, indicators              // t7 = indicators
        sw      r0, 0x0000(t7)              // clear indicator p1
        sw      r0, 0x0004(t7)              // clear indicator p2
        sw      r0, 0x0008(t7)              // clear indicator p3
        sw      r0, 0x000C(t7)              // clear indicator p4
        sw      t7, 0x0008(sp)              // save to stack

        OS.read_word(Global.p_struct_head, at) // at = p1 player struct
        li      t6, scores                  // t6 = scores
        OS.read_byte(Global.vs.teams, t8)   // t8 = 1 if teams
        bnezl   t8, pc() + 8                // if teams, use team_scores instead
        addiu   t6, t6, team_scores - scores // t6 = team_scores
        sw      t6, 0x0014(sp)              // save to stack
        li      t0, colors_bar              // t0 = colors array
        bnezl   t8, pc() + 8                // if teams, use team_colors instead
        addiu   t0, t0, team_colors_bar - colors_bar // t0 = team_colors
        sw      t0, 0x0010(sp)              // store in stack
        li      t0, colors_meter            // t0 = colors array for meter
        bnezl   t8, pc() + 8                // if teams, use team_colors instead
        addiu   t0, t0, team_colors_meter - colors_meter // t0 = team_colors
        sw      t0, 0x0024(sp)              // store in stack

        lui     t1, 0x4334                  // t1 = Y = 180
        Toggles.read(entry_dragon_king_hud, t7) // t7 = 2 if off
        lli     t6, 0x0002                  // t6 = 2 = off always
        beq     t7, t6, _save_y_coord       // if off, skip
        lli     t2, 188                     // t2 = Y
        lli     t2, 16                      // t2 = Y, Dragon King position
        lli     t6, 0x0001                  // t6 = 1 = always on
        beql    t7, t6, _save_y_coord       // if on, use Dragon King position
        lui     t1, 0x4100                  // t1 = Y = 8

        // if here, check if on a Dragon King stage
        OS.read_word(Global.match_info, t7)
        lbu     t7, 0x0001(t7)              // t7 = stage_id
        lli     t6, Stages.id.DRAGONKING
        beql    t7, t6, _save_y_coord       // if Dragon King, use Dragon King position
        lui     t1, 0x4100                  // t1 = Y = 8
        lli     t6, Stages.id.DRAGONKING_REMIX
        beql    t7, t6, _save_y_coord       // if Dragon King Remix, use Dragon King position
        lui     t1, 0x4100                  // t1 = Y = 8

        lli     t2, 188                     // t2 = Y

        _save_y_coord:
        sw      t1, 0x0018(sp)              // save float Y in stack
        sh      t2, 0x001C(sp)              // save int Y in stack
        lli     t1, 70                      // t1 = X delta
        sh      t1, 0x001E(sp)              // save X delta in stack
        lli     t1, 40                      // t1 = initial X
        sw      t1, 0x0020(sp)              // save X in stack

        // Create an indicator for each port, if active
        _loop:
        lw      t1, 0x0004(at)              // t1 = player object
        beqz    t1, _next                   // if no player object, get next player struct
        sw      at, 0x000C(sp)              // save to stack
        lbu     t1, 0x000D(at)              // t1 = port
        lw      t4, 0x0024(sp)              // t4 = meter colors
        OS.read_byte(Global.vs.teams, t8)   // t8 = 1 if teams
        lw      t3, 0x0020(at)              // t3 = player type (0 = man, 1 = cpu)
        bnezl   t8, pc() + 8                // if teams, always use team color
        lli     t3, OS.FALSE
        sw      t3, 0x0028(sp)              // save CPU color boolean
        li      t8, use_cpu_color
        lbu     a0, 0x000C(at)              // a0 = team
        addu    t8, t8, a0                  // address of use_cpu_color
        sb      t3, 0x0000(t8)              // save use_cpu_color

        // Progress bar texture
        lli     a0, 0x17                    // room
        lli     a1, 0xB                     // group
        OS.read_word(Render.file_pointer_4, a2)
        addiu   a2, a2, 0x0AA8              // a2 = image footer address
        lli     a3, 0x0000                  // routine
        lh      t0, 0x001E(sp)              // t0 = X delta
        multu   t0, t1                      // mflo = port * X delta = X offset
        mflo    t0                          // t0 = X offset
        lw      t2, 0x0020(sp)              // t2 = X
        addu    t0, t0, t2                  // t0 = X for this port
        addiu   t0, t0, -0x0003             // t0 = X for texture for this port
        mtc1    t0, f0                      // f0 = X
        cvt.s.w f0, f0                      // f0 = X, float
        mfc1    s1, f0                      // ulx
        lw      s2, 0x0018(sp)              // uly
        lbu     t1, 0x000C(at)              // t1 = team
        sll     t3, t1, 0x0002              // t3 = offset to colors
        addu    s3, t4, t3                  // s3 = address of color
        lw      t3, 0x0028(sp)              // t3 = CPU color boolean
        bnezl   t3, pc() + 8                // if true, use cpu color
        addiu   s3, t4, 4 * 0x0004          // s3 = address of cpu color
        lw      s3, 0x0000(s3)              // color
        lli     s4, 0x00FF                  // shadow (BLACK)
        jal     Render.draw_texture_
        lui     s5, 0x3F80                  // scale

        lw      at, 0x000C(sp)              // at = player struct
        lbu     t1, 0x000D(at)              // t1 = port
        lbu     t3, 0x000C(at)              // t3 = team
        sll     t3, t3, 0x0002              // t3 = offset to colors
        lw      t4, 0x0010(sp)              // t4 = colors

        // Create indicator
        lli     a0, 0x17                    // room
        lli     a1, 0xB                     // group
        lh      t0, 0x001E(sp)              // t0 = X delta
        multu   t0, t1                      // mflo = port * X delta = X offset
        mflo    t0                          // t0 = X offset
        lw      t2, 0x0020(sp)              // t2 = X
        addu    s1, t0, t2                  // s1 = X for this port
        lh      s2, 0x001C(sp)              // uly
        lli     s3, 0                       // width
        lli     s4, 5                       // height
        addu    s5, t4, t3                  // s5 = address of color
        lw      t3, 0x0028(sp)              // t3 = CPU color boolean
        bnezl   t3, pc() + 8                // if cpu, use cpu color
        addiu   s5, t4, 4 * 0x0004          // s5 = address of cpu color
        lw      s5, 0x0000(s5)              // color
        jal     Render.draw_rectangle_
        lli     s6, OS.TRUE                 // enable alpha

        lw      at, 0x000C(sp)              // at = player struct
        lw      t7, 0x0008(sp)              // t7 = indicator array
        lbu     t1, 0x000D(at)              // t1 = port
        sll     t1, t1, 0x0002              // t1 = offset to indicator address
        addu    t3, t7, t1                  // t3 = indicator address
        sw      v0, 0x0000(t3)              // save indicator obj

        lw      t6, 0x0014(sp)              // t6 = team scores
        lbu     t1, 0x000C(at)              // t1 = team
        sll     t1, t1, 0x0002              // t1 = offset to score address
        addu    t3, t6, t1                  // t3 = score address
        sw      t3, 0x0084(v0)              // save score address in indicator obj

        // Draw flash rectangle
        lli     a0, 0x17                    // room
        lli     a1, 0xB                     // group
        lw      s1, 0x0030(v0)              // s1 = x
        lh      s2, 0x001C(sp)              // uly
        lli     s3, 40                      // width
        lli     s4, 5                       // height
        addiu   s5, r0, 0xFF00              // color = WHITE, no alpha
        jal     Render.draw_rectangle_
        lli     s6, OS.TRUE                 // enable alpha

        lli     t0, ALPHA_DELTA
        sw      t0, 0x0084(v0)              // initialize alpha delta

        lw      at, 0x000C(sp)              // at = player struct
        lw      s1, 0x0030(v0)              // s1 = x

        _next:
        lw      at, 0x0000(at)              // at = next player struct
        bnez    at, _loop                   // loop over all player structs
        nop

        Render.register_routine(update_indicators_)
        li      t0, time
        lw      t1, 0x0000(t0)              // t1 = time
        lli     t0, 60                      // t0 = frames per second
        multu   t1, t0                      // t1 = # of frames to win
        mflo    t1                          // ~
        sw      t1, 0x0084(v0)              // save to update_indicators_ routine object

        _end:
        lw      ra, 0x0004(sp)              // restore registers
        jr      ra
        addiu   sp, sp, 0x0030              // deallocate stack space
    }

    // @ Description
    // Makes CPUs seek out the hill, sorta.
    // This makes them ignore items and tornados, too... oh well!
    scope ai_hill_behavior_: {
        OS.patch_start(0xAF5C4, 0x80134B84)
        j       ai_hill_behavior_
        add.s   f12, f4, f8                 // original line 2 - f12 = predict_x
        _return:
        OS.patch_end()

        OS.read_word(VsRemixMenu.vs_mode_flag, t0) // t0 = vs_mode_flag
        lli     t1, VsRemixMenu.mode.KOTH
        bne     t0, t1, _end                // if not KOTH, skip
        add.s   f14, f10, f18               // f14 = predict_y

        // Use the indicator's position as the target position for the CPU
        OS.read_word(indicator, t0)         // t0 = indicator
        beqz    t0, _end                    // if this is null, skip
        nop
        lw      t3, 0x0044(t0)              // t3 = yokumono dobj, if present
        beqz    t3, _can_target             // if no dobj, then we can target since the clipping should be on
        nop
        lw      t1, 0x0084(t3)              // t1 = status
        sltiu   t1, t1, 0x0003              // t1 = 1 if the clipping is on
        addiu   t2, r0, -0x0001             // t2 = -1
        beqzl   t1, _end                    // if clipping is off, skip
        sw      t2, 0x0228(a0)              // and set target_line_id to -1
        lbu     t1, 0x0054(t3)              // t1 = hidden/shown
        lli     t3, 0x0002                  // t3 = 2 = hidden
        beql    t1, t3, _end                // if dobj is hidden, skip
        sw      t2, 0x0228(a0)              // and set target_line_id to -1
        _can_target:
        lw      t0, 0x0074(t0)              // t0 = top joint
        lwc1    f0, 0x001C(t0)              // f0 = base X
        lwc1    f2, 0x001C(t0)              // f2 = base Y
        lw      t0, 0x0010(t0)              // t0 = joint 1 (texture)
        lwc1    f4, 0x001C(t0)              // f4 = offset X
        lwc1    f6, 0x001C(t0)              // f6 = offset Y
        add.s   f0, f0, f4                  // f0 = x
        add.s   f2, f2, f6                  // f2 = y
        lui     t0, 0x43FA                  // t0 = 500
        mtc1    t0, f6                      // f6 = 500
        sub.s   f2, f2, f6                  // f2 = y, moved down

        swc1    f0, 0x022C(a0)              // set target x
        swc1    f2, 0x0230(a0)              // set target y

        OS.read_word(hill_line_id, t0)      // t0 = hill_line_id
        sw      t0, 0x00228(a0)             // set target_line_id

        j       0x80134E88                  // exit routine
        lli     v0, OS.TRUE                 // and return TRUE

        _end:
        j       _return
        addiu   t2, r0, 0x0001              // original line 1
    }

    // @ Description
    // Delays respawn
    scope delay_respawn_: {
        constant DELAY(120)

        OS.patch_start(0xB6B6C, 0x8013C12C)
        jal     delay_respawn_
        lw      s0, 0x0084(a0)              // original line 1 - s0 = player struct
        OS.patch_end()
        // turn off player camera
        OS.patch_start(0xB6B38, 0x8013C0F8)
        jal     delay_respawn_._disabled_camera
        lw      t6, 0x0B18(v0)              // original line 1 - t6 = revive wait timer
        OS.patch_end()

        OS.read_word(VsRemixMenu.vs_mode_flag, t0) // t0 = vs_mode_flag
        lli     t1, VsRemixMenu.mode.KOTH
        bne     t0, t1, _end                // if not KOTH, skip
        addiu   t6, r0, 0x002D              // original line 2 - t6 = rebirth wait = 45

        lli     t6, DELAY                   // t6 = delay

        _end:
        jr      ra
        nop

        _disabled_camera:
        OS.read_word(VsRemixMenu.vs_mode_flag, t0) // t0 = vs_mode_flag
        lli     t1, VsRemixMenu.mode.KOTH
        bne     t0, t1, _end_disabled_camera // if not KOTH, skip
        lli     t7, DELAY - 45

        bne     t6, t7, _end_disabled_camera // skip if not 45 frames in to waiting
        lbu     t0, 0x0191(v0)              // t0 = current flags containing camera flag
        ori     t0, t0, 0x0001              // turn off camera for player
        sb      t0, 0x0191(v0)              // update flags

        _end_disabled_camera:
        jr      ra
        addiu   t7, t6, 0xFFFF              // original line 2 - t7 = t6 - 1
    }
}

} // __KOTH__
