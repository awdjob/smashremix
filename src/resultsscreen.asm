// ResultsScreen.asm
// thanks to tehzz for providing documentation

include "OS.asm"
include "Global.asm"

scope ResultsScreen {
    // @ Description
    // Patch which changes the results screen loading routine, loads the files for the characters
    // present in the match, rather than all character files.
    scope load_character_files_: {
        OS.patch_start(0x157DF8, 0x80138C58)
        j       load_character_files_
        nop
        nop
        nop
        nop
        nop
        nop
        _return:
        OS.patch_end()

        li      s0, Global.vs.p1            // ~
        jal     0x800D786C                  // load character
        lbu     a0, 0x0003(s0)              // a0 = p1 character
        li      s0, Global.vs.p2            // ~
        jal     0x800D786C                  // load character
        lbu     a0, 0x0003(s0)              // a0 = p2 character
        li      s0, Global.vs.p3            // ~
        jal     0x800D786C                  // load character
        lbu     a0, 0x0003(s0)              // a0 = p3 character
        li      s0, Global.vs.p4            // ~
        jal     0x800D786C                  // load character
        lbu     a0, 0x0003(s0)              // a0 = p4 character
        j       _return                     // return
        nop
    }

    // @ Description
    // Patch which substitutes working character/opponent ids (0-11) for vs records.
    scope vs_record_fix_: {
        // get character id
        OS.patch_start(0x150DD4, 0x80131C34)
        jal     _character
        nop
        or      s4, at, r0                  // update character id
        OS.patch_end()
        // get opponent id
        OS.patch_start(0x150F08, 0x80131D68)
        jal     _opponent
        nop
        or      v0, at, r0                  // update character id
        OS.patch_end()

        _character:
        addu    t5, r0, ra                  // save ra
        lbu     s4, 0x0023(v0)              // s4 = character id (original line 1)

        // check if remix character
        slti    t6, s4, Character.id.BOSS   // t6 = 0 if > Ness character ID
        beqz    t6, _skip_character
        nop

        divu    t7, at                      // original line 2
        jal     _get_id                     // get id
        or      at, s4, r0                  // at = character id
        or      s4, at, r0                  // update character id
        addu    ra, r0, t5                  // restore ra
        jr      ra
        sll     t5, s4, 0x2                 // original line 3

        _opponent:
        lbu     v0, 0x0023(v1)              // v0 = opponent id (original line 1)
        // check if remix character
        slti    t6, v0, Character.id.BOSS   // t6 = 0 if > Ness character ID
        beqz    t6, _skip_opponent
        nop

        sll     t6, s1, 0x2                 // original line 2
        addu    t0, t7, t6                  // original line 3
        or      at, v0, r0                  // at = opponent id

        _get_id:
        sll     at, at, 0x0002              // at = id * 4
        li      t6, Character.vs_record.table
        addu    t6, t6, at                  // t6 = vs_record.table + (id * 4)
        jr      ra                          // return
        lw      at, 0x0000(t6)              // at = new id

        _skip_character:
        j       0x80131DD8
        addiu   s2, s2, 0x0001              // increment port index

        _skip_opponent:
        j       0x80131DC8
        addiu   s1, s1, 0x0001              // increment port index
    }

    // @ Description
    // Stores the port index in the player structs on the VS results screen.
    // This is useful in CharEnvColor.asm and Size.asm, at least.
    scope fix_port_index_: {
        OS.patch_start(0x152B68, 0x801339C8)
        jal     fix_port_index_
        sb      t3, 0x03B(sp)               // original line 1
        OS.patch_end()

        sb      a1, 0x0039(sp)              // set port index

        jr      ra
        sb      t4, 0x003C(sp)              // original line 2
    }

    // @ Description
    // Patch which gets the FGM id for the winning character from an extended table.
    scope get_winner_fgm_: {
        OS.patch_start(0x00151164, 0x80131FC4)
        j       get_winner_fgm_
        nop
        _return:
        jal     0x800269C0                  // play FGM (original line 3)
        nop
        OS.patch_end()

        sll     t7, v0, 0x0002              // t7 = character_id * 4 (original line 1)
        li      a0, Character.winner_fgm.table
        addu    a0, a0, t7                  // a0 = winner_fgm.table + (id * 4)
        lw      a0, 0x0000(a0)              // a0 = FGM id for winning character
        j       _return
        nop
    }

    // @ Description
    // Extends the series logo offset table so we can use more than the original character logos
    scope winner_logo_fix_: {
        OS.patch_start(0x151E18, 0x80132C78)
        jal     winner_logo_fix_
        nop
        OS.patch_end()

        // v1 is offset in table (character id * 4)

        li      t7, series_logo_offset_table  // t7 = series_logo_offset_table address
        addu    t7, t7, v1                    // t7 = address of logo offset
        lw      t7, 0x0000(t7)                // t7 = logo offset

        jr      ra                            // return
        nop
    }

    // @ Description
    // Extends the series logo offset table so we can use more than the original character logos
    scope winner_logo_zoom_fix_: {
        OS.patch_start(0x151E64, 0x80132CC4)
        jal     winner_logo_zoom_fix_
        nop
        OS.patch_end()

        // t8 is offset in table (character id * 4)

        li      t5, series_logo_zoom_table   // t5 = series_logo_zoom_table address
        addu    t5, t5, t8                    // t5 = address of logo zoom offset
        lw      t5, 0x0000(t5)                // t5 = logo offset

        jr      ra                            // return
        nop
    }

    // @ Description
    // Extends the series logo offset table so we can use more than the original character logos
    scope winner_logo_color_fix_: {
        OS.patch_start(0x151E88, 0x80132CE8)
        jal     winner_logo_color_fix_
        nop
        OS.patch_end()

        // t1 is offset in table (character id * 4)

        li      t3, series_logo_color_table    // t3 = series_logo_color_table address
        addu    t3, t3, t1                    // t3 = address of logo offset
        lw      t3, 0x0000(t3)                // t3 = logo offset

        jr      ra                            // return
        nop
    }

    // @ Description
    // Patch which substitutes a working character id for determining the player label height.
    // TODO: add support for extending the label height tables, rather than using id substitution
    scope label_height_fix_: {
        // get character id (2 player match?)
        OS.patch_start(0x152D00, 0x80133B60)
        jal     label_height_fix_
        sw      v1, 0x0028(sp)              // original line 2
        OS.patch_end()
        // get character id (3+ player match?)
        OS.patch_start(0x152D58, 0x80133BB8)
        jal     label_height_fix_
        sw      v1, 0x0028(sp)              // original line 2
        OS.patch_end()
        // get character id (no contest)
        OS.patch_start(0x152DB0, 0x80133C10)
        jal     label_height_fix_
        sw      v1, 0x0028(sp)              // original line 2
        OS.patch_end()

        addiu   sp, sp,-0x0008              // allocate stack space
        sw      ra, 0x0004(sp)              // store ra
        jal     0x80133148                  // Result.getCharFromPlayer (original line 1)
        nop
        sll     v0, v0, 0x0002              // v0 = character id * 4
        li      t6, Character.label_height.table
        addu    t6, t6, v0                  // t6 = label_height.table + (id * 4)
        lw      v0, 0x0000(t6)              // v0 = new character id
        lw      ra, 0x0004(sp)              // load ra
        jr      ra                          // return
        addiu   sp, sp, 0x0008              // deallocate stack space
    }

    // @ Description
    // Patch which gets the "WINS" string left x position for the winner from an extended table.
    // Also changes the WINS! to WIN! for J characters and B&K.
    scope get_str_wins_lx_: {
        OS.patch_start(0x1534DC, 0x8013433C)
        j       get_str_wins_lx_
        nop
        _return:
        OS.patch_end()

        // t5 = char_id
        // t4 = char_id * 4
        // a0 = pointer to WINS! string
        // a0 + 0xC = pointer to WIN! string (lmao)

        lli     t6, Character.id.DRAGONKING // t6 = DRAGONKING
        beql    t5, t6, _get_lx             // if DRAGONKING, keep "WINS" text.
        nop

        li      a1, Character.sound_type.table
        addu    a1, a1, t5                  // a1 = address of sound type
        lbu     t6, 0x0000(a1)              // t6 = sound type
        lli     a1, Character.sound_type.J  // a1 = J sound type
        beql    a1, t6, _get_lx             // if not a J character, skip
        addiu   a0, a0, 0x000C              // if J character, move the pointer to "WIN!"

        lli     t6, Character.id.BANJO      // t6 = BANJO
        beql    t5, t6, _get_lx             // if BANJO, set to WIN!
        addiu   a0, a0, 0x000C              // a0 = offset to "WIN!"

        _get_lx:
        li      t6, Character.str_wins_lx.table
        addu    t6, t6, t4                  // t6 = str_win_lx.table + (id * 4)
        lw      a1, 0x0000(t6)              // a1 = left x position of "WINS" string
        j       _return                     // return
        nop
    }

    // @ Description
    // Patch which gets the string pointer, left x position, and x scaling for the winning
    // character's name string from extended tables.
    scope get_str_winner_info_: {
        OS.patch_start(0x1535E0, 0x80134440)
        j       get_str_winner_info_
        nop
        nop
        nop
        nop
        nop
        _return:
        OS.patch_end()

        // v1 = id * 4
        li      t5, Character.str_winner_scale.table
        addu    t5, t5, v1                  // t5 = str_winner_scale.table + (id * 4)
        lwc1    f4, 0x0000(t5)              // f4 = string x scale
        li      t5, Character.str_winner_lx.table
        addu    t5, t5, v1                  // t5 = str_winner_lx.table + (id * 4)
        lw      a1, 0x0000(t5)              // a1 = string left x position
        li      t5, Character.str_winner_ptr.table
        addu    t5, t5, v1                  // t5 = str_winner_ptr.table + (id * 4)
        lw      a0, 0x0000(t5)              // a0 = string pointer
        j       _return                     // return
        nop
    }

    // @ Description
    // Allows ampersands to be drawn
    scope add_ampersand_: {
        // Modify the char to index routine
        OS.patch_start(0x1530C8, 0x80133F28)
        beql    a0, at, _return             // if 0x20, it's a space
        lli     v0, 0x001C                  // v0 = 0x1C
        lli     at, 0x0021                  // at = '!'
        beql    a0, at, _return             // if '!', set index
        lli     v0, 0x001A                  // v0 = 0x1A
        lli     at, 0x002E                  // at = '.'
        beql    a0, at, _return             // if '.', set index
        lli     v0, 0x001B                  // v0 = 0x1B
        lli     at, 0x0026                  // at = '&'
        beql    a0, at, _return             // if '&', set index
        lli     v0, 0x001D                  // v0 = 0x1D

        addiu   v0, a0, 0xFFBF              // v0 = index for letter

        _return:
        jr      ra
        nop
        OS.patch_end()

        // If ampersand, set offset manually
        OS.patch_start(0x1532F4, 0x80134154)
        jal     add_ampersand_._texture
        lw      t3, 0x0000(s2)              // original line 1 - t3 = offset to letter
        OS.patch_end()

        // If ampersand, set width manually
        OS.patch_start(0x15337C, 0x801341DC)
        jal     add_ampersand_._width
        lwc1    f16, 0x0114(t8)             // original line 1 - f16 = width
        OS.patch_end()

        _texture:
        lli     t4, 0x001D                  // t4 = 0x1D
        beql    v1, t4, pc() + 8            // if the index is 0x1D, then use ampersand offset
        lli     t3, 0x8348 + 0x0010         // t3 = offset to ampersand

        jr      ra
        lw      t4, 0x0018(s5)              // original line 2 - t4 = file with letters

        _width:
        lli     t4, 0x001D * 4              // t4 = 0x1D * 4
        lui     t3, 0x4208                  // t3 = width of ampersand
        beql    s1, t4, pc() + 8            // if the index is 0x1D, then use ampersand width
        mtc1    t3, f16                     // f16 = width of ampersand

        jr      ra
        mul.s   f18, f16, f22               // original line 2
    }

    // @ Description
    // Patch which adjusts the max number of characters in the bgm jump table, and loads the
    // victory bgm address from an extended table.
    scope get_victory_bgm_: {
        OS.patch_start(0x1578CC, 0x8013872C)
        constant UPPER(Character.winner_bgm.table >> 16)
        constant LOWER(Character.winner_bgm.table & 0xFFFF)
        sltiu   at, v0, Character.NUM_CHARACTERS
        beq     at, r0, 0x80138818          // original line 2
        or      a0, r0, r0                  // original line 3
        sll     t6, v0, 0x2                 // original line 4
        if LOWER > 0x7FFF {
            lui     at, (UPPER + 0x1)       // modified original line 5
        } else {
            lui     at, UPPER               // modified original line 5
        }
        addu    at, at, t6                  // original line 6
        lw      t6, LOWER(at)               // original line 7
        OS.patch_end()
    }

    // @ Description
    // Adds a victory bgm routine for winner_bgm.table
    macro add_victory_bgm(bgm) {
        or      a0, r0, r0                  // original line 1
        jal     0x80020AB4                  // play bgm (original line 2)
        ori     a1, r0, {bgm}               // a1 = bgm id (modified original line 3)
        j       0x80138824                  // original line 4
        lw      ra, 0x0014(sp)              // original line 5
    }

    // @ Description
    // Checks for winning player's input to pick a victory animation
    // Note: Kirby character check is intact, so it will only randomly pick 2 animations unless manually overridden
    scope victory_animations_: {
        OS.patch_start(0x152638, 0x80133498)
        j       pick_victory_animation_     // Kirby branch
        nop
        OS.patch_end()

        OS.patch_start(0x152650, 0x801334B0)
        j       pick_victory_animation_     // Non-Kirby branch
        nop
        _return:
        OS.patch_end()

        // a1 = winning player's port (0-3)
        // v0 = currently selected random animation
        // a0 is safe to edit
        pick_victory_animation_:
        // Check if the winning player is holding a C-button and override random int if so (borrowed from Joypad.check_buttons_)
        lli     a0, 000010                  // ~
        mult    a1, a0                      // ~
        mflo    a0                          // a0 = offset
        li      t1, Joypad.struct           // t1 = Joypad.struct
        addu    t1, t1, a0                  // t1 = struct + offset
        lhu     t1, 0x0000(t1)              // t1 = button mask

        andi    a0, t1, 0x000F              // a0 = 0 if no c button pressed
        beqz    a0, _end                    // branch accordingly
        nop

        andi    a0, t1, Joypad.CR           // a0 = 1 if CR pressed
        bnezl   a0, _end                    // branch accordingly
        addiu   v0, r0, 0x0002              // v0 = 2 (victory animation 3)

        andi    a0, t1, Joypad.CL           // a0 = 1 if CL pressed
        bnezl   a0, _end                    // branch accordingly
        addiu   v0, r0, 0x0001              // v0 = 1 (victory animation 2)

        // if we're here, CU or CD were pressed
        or      v0, r0, r0                  // v0 = 0 (victory animation 1)

        _end:
        sll     t1, v0, 2                   // original line 1 (note: original Kirby branch used t0)
        addu    v0, sp, t1                  // original line 2
        j       _return                     // return
        nop
    }

    // @ Description
    // Logo offsets in file 0x23
    scope series_logo: {
        constant MARIO_BROS(0x0990)
        constant STARFOX(0x21D0)
        constant DONKEY_KONG(0x1348)
        constant METROID(0x1860)
        constant ZELDA(0x2520)
        constant YOSHI(0x2F10)
        constant FZERO(0x3828)
        constant KIRBY(0x3E68)
        constant POKEMON(0x4710)
        constant EARTHBOUND(0x5A00)
        constant SMASH(0x5E10)
        constant DR_MARIO(0x6420)
        constant BOWSER(0x8340)
        constant CONKER(0x8D70)
        constant WARIO(0x9040)
        constant FIRE_EMBLEM(0x97F8)
        constant SONIC(0xA1B8)
        constant MISCHIEF_MAKERS(0xAD18)
        constant GOEMON(0xB888)
        constant BANJO_KAZOOIE(0xC6B8)
        constant CRASH_BANDICOOT(0xDBC8)
    }

    // @ Description
    // logo zoom offsets
    scope series_logo_zoom: {
        constant MARIO_BROS(0x0000)
        constant STARFOX(0x1940)
        constant DONKEY_KONG(0x0B00)
        constant METROID(0x1470)
        constant ZELDA(0x22B0)
        constant YOSHI(0x2690)
        constant FZERO(0x2FF0)
        constant KIRBY(0x3900)
        constant POKEMON(0x3F40)
        constant EARTHBOUND(0x4840)
        constant SMASH(POKEMON)
        constant DR_MARIO(MARIO_BROS)
        constant BOWSER(0x8448)
        constant CONKER(0x8E78)
        constant WARIO(0x9148)
        constant FIRE_EMBLEM(0x9900)
        constant SONIC(0xA2C0)
        constant MISCHIEF_MAKERS(0xAE20)
        constant GOEMON(0xB990)
        constant BANJO_KAZOOIE(0xC7C0)
        constant CRASH_BANDICOOT(0xDCD0)
    }

    // @ Description
    // logo color offsets
    scope series_logo_color: {
        constant MARIO_BROS(0x0A14)
        constant STARFOX(0x2254)
        constant DONKEY_KONG(0x13CC)
        constant METROID(0x18E4)
        constant ZELDA(0x25A4)
        constant YOSHI(0x2F94)
        constant FZERO(0x38AC)
        constant KIRBY(0x3EEC)
        constant POKEMON(0x4794)
        constant EARTHBOUND(0x5A84)
        constant SMASH(POKEMON)
        constant DR_MARIO(0x64A4)
        constant BOWSER(0x84A0)
        constant CONKER(0x8ED0)
        constant WARIO(MARIO_BROS)
        constant FIRE_EMBLEM(0x9958)
        constant SONIC(0xA318)
        constant MISCHIEF_MAKERS(0xAE78)
        constant GOEMON(0xB9E8)
        constant BANJO_KAZOOIE(0xC818)
        constant CRASH_BANDICOOT(0xDD28)
    }

    // @ Description
    // extended logo offset table
    series_logo_offset_table:
    constant series_logo_offset_table_origin(origin())
    dw series_logo.MARIO_BROS               // Mario
    dw series_logo.STARFOX                  // Fox
    dw series_logo.DONKEY_KONG              // Donkey Kong
    dw series_logo.METROID                  // Samus
    dw series_logo.MARIO_BROS               // Luigi
    dw series_logo.ZELDA                    // Link
    dw series_logo.YOSHI                    // Yoshi
    dw series_logo.FZERO                    // Captain Falcon
    dw series_logo.KIRBY                    // Kirby
    dw series_logo.POKEMON                  // Pikachu
    dw series_logo.POKEMON                  // Jigglypuff
    dw series_logo.EARTHBOUND               // Ness
    dw series_logo.SMASH
    dw series_logo.MARIO_BROS
    dw series_logo.SMASH
    dw series_logo.SMASH
    dw series_logo.SMASH
    dw series_logo.SMASH
    dw series_logo.SMASH
    dw series_logo.SMASH
    dw series_logo.SMASH
    dw series_logo.SMASH
    dw series_logo.SMASH
    dw series_logo.SMASH
    dw series_logo.SMASH
    dw series_logo.SMASH
    dw series_logo.DONKEY_KONG
    dw 0x00000000
    dw 0x00000000
    // add space for new characters
    fill (series_logo_offset_table + (Character.NUM_CHARACTERS * 0x4)) - pc()

    // @ Description
    // extended logo color table
    series_logo_color_table:
    constant series_logo_color_table_origin(origin())
    dw series_logo_color.MARIO_BROS               // Mario
    dw series_logo_color.STARFOX                  // Fox
    dw series_logo_color.DONKEY_KONG              // Donkey Kong
    dw series_logo_color.METROID                  // Samus
    dw series_logo_color.MARIO_BROS               // Luigi
    dw series_logo_color.ZELDA                    // Link
    dw series_logo_color.YOSHI                    // Yoshi
    dw series_logo_color.FZERO                    // Captain Falcon
    dw series_logo_color.KIRBY                    // Kirby
    dw series_logo_color.POKEMON                  // Pikachu
    dw series_logo_color.POKEMON                  // Jigglypuff
    dw series_logo_color.EARTHBOUND               // Ness
    dw series_logo_color.SMASH
    dw series_logo_color.MARIO_BROS
    dw series_logo_color.SMASH
    dw series_logo_color.SMASH
    dw series_logo_color.SMASH
    dw series_logo_color.SMASH
    dw series_logo_color.SMASH
    dw series_logo_color.SMASH
    dw series_logo_color.SMASH
    dw series_logo_color.SMASH
    dw series_logo_color.SMASH
    dw series_logo_color.SMASH
    dw series_logo_color.SMASH
    dw series_logo_color.SMASH
    dw series_logo_color.DONKEY_KONG
    dw 0x00000000
    dw 0x00000000
    // add space for new characters
    fill (series_logo_color_table + (Character.NUM_CHARACTERS * 0x4)) - pc()

    // @ Description
    // extended logo zoom table
    series_logo_zoom_table:
    constant series_logo_zoom_table_origin(origin())
    dw series_logo_zoom.MARIO_BROS               // Mario
    dw series_logo_zoom.STARFOX                  // Fox
    dw series_logo_zoom.DONKEY_KONG              // Donkey Kong
    dw series_logo_zoom.METROID                  // Samus
    dw series_logo_zoom.MARIO_BROS               // Luigi
    dw series_logo_zoom.ZELDA                    // Link
    dw series_logo_zoom.YOSHI                    // Yoshi
    dw series_logo_zoom.FZERO                    // Captain Falcon
    dw series_logo_zoom.KIRBY                    // Kirby
    dw series_logo_zoom.POKEMON                  // Pikachu
    dw series_logo_zoom.POKEMON                  // Jigglypuff
    dw series_logo_zoom.EARTHBOUND               // Ness
    dw series_logo_zoom.SMASH                    // Boss
    dw series_logo_zoom.MARIO_BROS
    dw series_logo_zoom.SMASH
    dw series_logo_zoom.SMASH
    dw series_logo_zoom.SMASH
    dw series_logo_zoom.SMASH
    dw series_logo_zoom.SMASH
    dw series_logo_zoom.SMASH
    dw series_logo_zoom.SMASH
    dw series_logo_zoom.SMASH
    dw series_logo_zoom.SMASH
    dw series_logo_zoom.SMASH
    dw series_logo_zoom.SMASH
    dw series_logo_zoom.SMASH
    dw series_logo_zoom.DONKEY_KONG
    dw 0x00000000
    dw 0x00000000
    // add space for new characters
    fill (series_logo_zoom_table + (Character.NUM_CHARACTERS * 0x4)) - pc()

    // @ Description
    // Adds results screen parameters for a character.
    // @ Arguments
    // id - character id to modify
    // fgm - announcer voice FGM id
    // logo - series logo to use
    // label_y - character id to copy label height from (0-11)
    // wins_lx - float32 left x position of "WINS!" string
    // string - character name string
    // str_lx - float32 left x position of name string
    // str_scale - float32 x scaling of name string
    // bgm - victory BGM id
    macro add_to_results_screen(id, fgm, logo, label_y, wins_lx, string, str_lx, str_scale, bgm) {
        evaluate n({id})

        // add announcer FGM
        Character.table_patch_start(winner_fgm, {id}, 0x4)
        dw  {fgm}
        OS.patch_end()

        pushvar base, origin

        // add logo offset
        origin series_logo_offset_table_origin + ({id} * 0x4)
        define logo_offset(series_logo.{logo})
        dw  {logo_offset}

        // add logo color
        origin series_logo_color_table_origin + ({id} * 0x4)
        define logo_color(series_logo_color.{logo})
        dw  {logo_color}

        // add logo zoom
        origin series_logo_zoom_table_origin + ({id} * 0x4)
        define logo_zoom(series_logo_zoom.{logo})
        dw  {logo_zoom}

        pullvar origin, base

        // add player label height
        Character.table_patch_start(label_height, {id}, 0x4)
        dw  {label_y}
        OS.patch_end()

        // add "WINS!" string lx
        Character.table_patch_start(str_wins_lx, {id}, 0x4)
        float32 {wins_lx}
        OS.patch_end()

        // add character name string
        string_character_{n}:
        db  "{string}"; db 0x00
        OS.align(4)

        // add name string pointer, lx, scale
        Character.table_patch_start(str_winner_ptr, {id}, 0x4)
        dw  string_character_{n}
        OS.patch_end()
        Character.table_patch_start(str_winner_lx, {id}, 0x4)
        float32 {str_lx}
        OS.patch_end()
        Character.table_patch_start(str_winner_scale, {id}, 0x4)
        float32 {str_scale}
        OS.patch_end()

        // add victory bgm routine
        bgm_character_{n}:
        add_victory_bgm({bgm})

        // add bgm routine pointer
        Character.table_patch_start(winner_bgm, {id}, 0x4)
        dw  bgm_character_{n}
        OS.patch_end()
    }

    // ADD CHARACTERS TO RESULTS SCREEN
                          // id                  fgm                                         logo             label_y               wins_lx  string           str_lx  str_scale  bgm
    add_to_results_screen(Character.id.METAL,    FGM.announcer.names.METAL_MARIO,            MARIO_BROS,      Character.id.MARIO,   185,     METAL MARIO,     20,     0.55,      0x0C)
    add_to_results_screen(Character.id.NMARIO,   FGM.announcer.names.NFIGHTER,               SMASH,           Character.id.MARIO,   185,     POLY MARIO,      20,     0.6,       0x0B)
    add_to_results_screen(Character.id.NFOX,     FGM.announcer.names.NFIGHTER,               SMASH,           Character.id.MARIO,   185,     POLY FOX,        20,     0.8,       0x0B)
    add_to_results_screen(Character.id.NDONKEY,  FGM.announcer.names.NFIGHTER,               SMASH,           Character.id.MARIO,   180,     POLY DK,         25,     0.85,      0x0B)
    add_to_results_screen(Character.id.NSAMUS,   FGM.announcer.names.NFIGHTER,               SMASH,           Character.id.MARIO,   185,     POLY SAMUS,      20,     0.6,       0x0B)
    add_to_results_screen(Character.id.NLUIGI,   FGM.announcer.names.NFIGHTER,               SMASH,           Character.id.MARIO,   185,     POLY LUIGI,      20,     0.75,      0x0B)
    add_to_results_screen(Character.id.NLINK,    FGM.announcer.names.NFIGHTER,               SMASH,           Character.id.MARIO,   185,     POLY LINK,       20,     0.8,       0x0B)
    add_to_results_screen(Character.id.NYOSHI,   FGM.announcer.names.NFIGHTER,               SMASH,           Character.id.MARIO,   185,     POLY YOSHI,      20,     0.65,      0x0B)
    add_to_results_screen(Character.id.NCAPTAIN, FGM.announcer.names.NFIGHTER,               SMASH,           Character.id.MARIO,   185,     POLY FALCON,     20,     0.55,      0x0B)
    add_to_results_screen(Character.id.NKIRBY,   FGM.announcer.names.NFIGHTER,               SMASH,           Character.id.MARIO,   185,     POLY KIRBY,      20,     0.7,       0x0B)
    add_to_results_screen(Character.id.NPIKACHU, FGM.announcer.names.NFIGHTER,               SMASH,           Character.id.MARIO,   185,     POLY PIKACHU,    20,     0.55,      0x0B)
    add_to_results_screen(Character.id.NJIGGLY,  FGM.announcer.names.NFIGHTER,               SMASH,           Character.id.MARIO,   185,     POLY PUFF,       20,     0.75,      0x0B)
    add_to_results_screen(Character.id.NNESS,    FGM.announcer.names.NFIGHTER,               SMASH,           Character.id.MARIO,   185,     POLY NESS,       20,     0.75,      0x0B)
    add_to_results_screen(Character.id.GDONKEY,  FGM.announcer.names.GDK,                    DONKEY_KONG,     Character.id.DK,      185,     GIANT DK,        20,     0.8,       0x0E)
    add_to_results_screen(Character.id.BOSS,     FGM.announcer.names.MASTERHAND,             SMASH,           Character.id.BOSS,    185,     MASTER HAND,     20,     0.55,      0x0B)

    add_to_results_screen(Character.id.FALCO,    FGM.announcer.names.FALCO,                  STARFOX,         Character.id.FOX,     170,     FALCO,           30,     1,         {MIDI.id.FALCO_VICTORY})
    add_to_results_screen(Character.id.GND,      FGM.announcer.names.GANONDORF,              ZELDA,           Character.id.CAPTAIN, 185,     GANONDORF,       20,     0.6,       {MIDI.id.GANON_VICTORY})
    add_to_results_screen(Character.id.YLINK,    FGM.announcer.names.YOUNG_LINK,             ZELDA,           Character.id.LINK,    185,     YOUNG LINK,      20,     0.65,      {MIDI.id.YOUNGLINK_VICTORY})
    add_to_results_screen(Character.id.DRM,      FGM.announcer.names.DR_MARIO,               DR_MARIO,        Character.id.MARIO,   185,     DR. MARIO,       20,     0.75,      {MIDI.id.DRMARIO_VICTORY})
    add_to_results_screen(Character.id.DSAMUS,   FGM.announcer.names.DSAMUS,                 METROID,         Character.id.SAMUS,   185,     DARK SAMUS,      20,     0.6,       {MIDI.id.DSAMUS_VICTORY})
    add_to_results_screen(Character.id.WARIO,    FGM.announcer.names.WARIO,                  WARIO,           Character.id.MARIO,   175,     WARIO,           25,     1,         {MIDI.id.WARIO_VICTORY})
    add_to_results_screen(Character.id.ELINK,    FGM.announcer.names.ELINK,                  ZELDA,           Character.id.LINK,    170,     E LINK,          40,     1,         0x15)
    add_to_results_screen(Character.id.JSAMUS,   FGM.announcer.names.SAMUS,                  METROID,         Character.id.SAMUS,   185,     J SAMUS,         35,     0.8,       0x0D)
    add_to_results_screen(Character.id.JNESS,    FGM.announcer.names.NESS,                   EARTHBOUND,      Character.id.NESS,    180,     J NESS,          40,     1,         0x11)
    add_to_results_screen(Character.id.LUCAS,    FGM.announcer.names.LUCAS,                  EARTHBOUND,      Character.id.NESS,    170,     LUCAS,           30,     1,         {MIDI.id.LUCAS_VICTORY})
    add_to_results_screen(Character.id.JLINK,    FGM.announcer.names.LINK,                   ZELDA,           Character.id.LINK,    170,     J LINK,          50,     1,         0x15)
    add_to_results_screen(Character.id.JFALCON,  FGM.announcer.names.FALCON,                 FZERO,           Character.id.CAPTAIN, 185,     J C. FALCON,     30,     0.65,      0x13)
    add_to_results_screen(Character.id.JFOX,     FGM.announcer.names.JFOX,                   STARFOX,         Character.id.FOX,     170,     J FOX,           50,     1,         0x10)
    add_to_results_screen(Character.id.JMARIO,   FGM.announcer.names.MARIO,                  MARIO_BROS,      Character.id.MARIO,   200,     J MARIO,         25,     1,         0x0C)
    add_to_results_screen(Character.id.JLUIGI,   FGM.announcer.names.LUIGI,                  MARIO_BROS,      Character.id.LUIGI,   180,     J LUIGI,         45,     1,         0x0C)
    add_to_results_screen(Character.id.JDK,      FGM.announcer.names.DK,                     DONKEY_KONG,     Character.id.DK,      195,     D.1KONG,         30,     1,         0x0E)
    add_to_results_screen(Character.id.EPIKA,    FGM.announcer.names.EPIKA,                  POKEMON,         Character.id.PIKACHU, 185,     E PIKACHU,       25,     0.75,      0x14)
    add_to_results_screen(Character.id.JPUFF,    FGM.announcer.names.JPUFF,                  POKEMON,         Character.id.JIGGLYPUFF, 185,  P1U1R1I1N,       50,     1,         0x14)
    add_to_results_screen(Character.id.EPUFF,    FGM.announcer.names.EPUFF,                  POKEMON,         Character.id.JIGGLYPUFF, 185,  PUMMELUFF,       20,     0.7,       0x14)
    add_to_results_screen(Character.id.JKIRBY,   FGM.announcer.names.KIRBY,                  KIRBY,           Character.id.KIRBY,   190,     J KIRBY,         35,     1,         0x0F)
    add_to_results_screen(Character.id.JYOSHI,   FGM.announcer.names.YOSHI,                  YOSHI,           Character.id.YOSHI,   195,     J YOSHI,         30,     1,         0x12)
    add_to_results_screen(Character.id.JPIKA,    FGM.announcer.names.PIKACHU,                POKEMON,         Character.id.PIKACHU, 195,     J PIKACHU,       35,     0.75,      0x14)
    add_to_results_screen(Character.id.ESAMUS,   FGM.announcer.names.ESAMUS,                 METROID,         Character.id.SAMUS,   175,     E SAMUS,         35,     0.75,      0x0D)
    add_to_results_screen(Character.id.BOWSER,   FGM.announcer.names.BOWSER,                 BOWSER,          Character.id.YOSHI,   175,     BOWSER,          25,     0.85,      {MIDI.id.BOWSER_VICTORY})
    add_to_results_screen(Character.id.GBOWSER,  FGM.announcer.names.GBOWSER,                BOWSER,          Character.id.YOSHI,   180,     GIGA BOWSER,     20,     0.55,      {MIDI.id.BOWSER_VICTORY})
    add_to_results_screen(Character.id.PIANO,    FGM.announcer.names.PIANO,                  MARIO_BROS,      Character.id.KIRBY,   185,     MAD PIANO,       20,     0.65,      -1)
    add_to_results_screen(Character.id.WOLF,     FGM.announcer.names.WOLF,                   STARFOX,         Character.id.FOX,     160,     WOLF,            40,     1,         {MIDI.id.WOLF_VICTORY})
    add_to_results_screen(Character.id.CONKER,   FGM.announcer.names.CONKER,                 CONKER,          Character.id.FOX,     180,     CONKER,          20,     0.9,      {MIDI.id.CONKER_VICTORY})
    add_to_results_screen(Character.id.MTWO,     FGM.announcer.names.MEWTWO,                 POKEMON,         Character.id.SAMUS,   185,     MEWTWO,          20,     0.8,       {MIDI.id.MEWTWO_VICTORY})
    add_to_results_screen(Character.id.MARTH,    FGM.announcer.names.MARTH,                  FIRE_EMBLEM,     Character.id.CAPTAIN, 185,     MARTH,           20,     1,         {MIDI.id.MARTH_VICTORY})
    add_to_results_screen(Character.id.SONIC,    FGM.announcer.names.SONIC,                  SONIC,           Character.id.FOX,     165,     SONIC,           35,     1,         {MIDI.id.SONIC_VICTORY})
    add_to_results_screen(Character.id.SANDBAG,  FGM.announcer.names.MARTH,                  YOSHI,           Character.id.CAPTAIN, 175,     SANDBAG,         25,     1,         0x0B)
    add_to_results_screen(Character.id.SSONIC,   FGM.announcer.names.SSONIC,                 SONIC,           Character.id.FOX,     170,     SUPER SONIC,     20,     0.55,      {MIDI.id.SONIC_VICTORY})
    add_to_results_screen(Character.id.SHEIK,    FGM.announcer.names.SHEIK,                  ZELDA,           Character.id.CAPTAIN, 160,     SHEIK,           40,     1,         {MIDI.id.SHEIK_VICTORY})
    add_to_results_screen(Character.id.MARINA,   FGM.announcer.names.MARINA,                 MISCHIEF_MAKERS, Character.id.CAPTAIN, 180,     M1AR1I111NA,     25,     0.85,      {MIDI.id.MARINA_VICTORY})
    add_to_results_screen(Character.id.DEDEDE,   FGM.announcer.names.DEDEDE,                 KIRBY,           Character.id.CAPTAIN, 175,     DEDEDE,          25,     0.9,      {MIDI.id.DEDEDE_VICTORY})
    add_to_results_screen(Character.id.GOEMON,   FGM.announcer.names.GOEMON,                 GOEMON,          Character.id.CAPTAIN, 170,     GOEMON,          25,     0.75,      {MIDI.id.GOEMON_VICTORY})
    add_to_results_screen(Character.id.PEPPY,    FGM.announcer.names.PEPPY,                  STARFOX,         Character.id.FOX,     170,     PEPPY,           30,     1,         0x10)
    add_to_results_screen(Character.id.SLIPPY,   FGM.announcer.names.SLIPPY,                 STARFOX,         Character.id.FOX,     180,     SLIPPY,          25,     1,         0x10)
    add_to_results_screen(Character.id.BANJO,    FGM.announcer.names.BANJO,                  BANJO_KAZOOIE,   Character.id.CAPTAIN, 210,     BAN1JO2&2KAZOOI1E,20,    0.5,       {MIDI.id.BANJO_VICTORY})
    add_to_results_screen(Character.id.MLUIGI,   FGM.announcer.names.MLUIGI,                 MARIO_BROS,      Character.id.MARIO,   185,     METAL LUIGI,     20,     0.65,      0x0C)
    add_to_results_screen(Character.id.EBI,      FGM.announcer.names.EBI,                    GOEMON,          Character.id.CAPTAIN, 180,     EBISUMARU,       20,     0.65,      {MIDI.id.GOEMON_VICTORY})
    add_to_results_screen(Character.id.DRAGONKING, FGM.announcer.names.DRAGONKING,           SMASH,           Character.id.CAPTAIN, 170,     D.1KING,         30,     1,         {MIDI.id.DKING_VICTORY})
    add_to_results_screen(Character.id.CRASH,    FGM.announcer.names.CRASH,                  CRASH_BANDICOOT, Character.id.CAPTAIN, 170,     CRASH,           30,     1,         {MIDI.id.CRASH_VICTORY})
    add_to_results_screen(Character.id.PEACH,    FGM.announcer.names.PEACH,                  MARIO_BROS,      Character.id.CAPTAIN, 170,     PEACH,           30,     1,         {MIDI.id.PEACH_VICTORY})
    add_to_results_screen(Character.id.ROY,      FGM.announcer.names.ROY,                    FIRE_EMBLEM,     Character.id.CAPTAIN, 160,     ROY,             50,     1,         {MIDI.id.MARTH_VICTORY})
    add_to_results_screen(Character.id.DRL,      FGM.announcer.names.DRL,                    DR_MARIO,        Character.id.LUIGI,   175,     DR. LUIGI,       25,     0.85,      {MIDI.id.DRMARIO_VICTORY})
    add_to_results_screen(Character.id.LANKY,    FGM.announcer.names.LANKY,                  DONKEY_KONG,     Character.id.DK,      185,     LAN2KY KONG,      25,     0.55,     {MIDI.id.LANKY_VICTORY})
    // ADD NEW CHARACTERS HERE

    // REMIX POLYGONS
    add_to_results_screen(Character.id.NFALCO,   FGM.announcer.names.NFIGHTER,               SMASH,           Character.id.FOX,     185,     POLY FALCO,      20,     0.6,       0x0B)
    add_to_results_screen(Character.id.NGND,     FGM.announcer.names.NFIGHTER,               SMASH,           Character.id.CAPTAIN, 185,     POLY GANON,      20,     0.55,      0x0B)
    add_to_results_screen(Character.id.NWARIO,   FGM.announcer.names.NFIGHTER,               SMASH,           Character.id.MARIO,   185,     POLY WARIO,      20,     0.6,       0x0B)
    add_to_results_screen(Character.id.NLUCAS,   FGM.announcer.names.NFIGHTER,               SMASH,           Character.id.NESS,    185,     POLY LUCAS,      20,     0.6,       0x0B)
    add_to_results_screen(Character.id.NBOWSER,  FGM.announcer.names.NFIGHTER,               SMASH,           Character.id.YOSHI,   185,     POLY BOWSER,     20,     0.55,      0x0B)
    add_to_results_screen(Character.id.NWOLF,    FGM.announcer.names.NFIGHTER,               SMASH,           Character.id.FOX,     185,     POLY WOLF,       20,     0.65,      0x0B)
    add_to_results_screen(Character.id.NDRM,     FGM.announcer.names.NFIGHTER,               SMASH,           Character.id.MARIO,   185,     POLY DR. MARIO,  20,     0.45,      0x0B)
    add_to_results_screen(Character.id.NSONIC,   FGM.announcer.names.NFIGHTER,               SMASH,           Character.id.FOX,     185,     POLY SONIC,      20,     0.65,      0x0B)
    add_to_results_screen(Character.id.NSHEIK,   FGM.announcer.names.NFIGHTER,               SMASH,           Character.id.CAPTAIN, 180,     POLY SHEIK,      20,     0.66,      0x0B)
    add_to_results_screen(Character.id.NMARINA,  FGM.announcer.names.NFIGHTER,               SMASH,           Character.id.CAPTAIN, 180,     POLY MARINA,     20,     0.55,      0x0B)
    add_to_results_screen(Character.id.NDSAMUS,  FGM.announcer.names.NFIGHTER,               SMASH,           Character.id.SAMUS,   180,     POLY D. SAMUS,   20,     0.5,       0x0B)
    add_to_results_screen(Character.id.NMARTH,   FGM.announcer.names.NFIGHTER,               SMASH,           Character.id.CAPTAIN, 185,     POLY MARTH,      20,     0.6,       0x0B)
    add_to_results_screen(Character.id.NMTWO,    FGM.announcer.names.NFIGHTER,               SMASH,           Character.id.SAMUS,   185,     POLY MEWTWO,     20,     0.52,      0x0B)
    add_to_results_screen(Character.id.NDEDEDE,  FGM.announcer.names.NFIGHTER,               SMASH,           Character.id.CAPTAIN, 180,     POLY DEDEDE,     20,     0.55,      0x0B)
    add_to_results_screen(Character.id.NYLINK,   FGM.announcer.names.NFIGHTER,               SMASH,           Character.id.LINK,    180,     POLY Y. LINK,    20,     0.63,      0x0B)
    add_to_results_screen(Character.id.NGOEMON,  FGM.announcer.names.NFIGHTER,               SMASH,           Character.id.MARIO,   185,     POLY GOEMON,     20,     0.52,      0x0B)
    add_to_results_screen(Character.id.NCONKER,  FGM.announcer.names.NFIGHTER,               SMASH,           Character.id.FOX,     180,     POLY CONKER,     20,     0.55,      0x0B)
    add_to_results_screen(Character.id.NBANJO,   FGM.announcer.names.NFIGHTER,               SMASH,           Character.id.CAPTAIN, 185,     POLY BANJO,      20,     0.6,       0x0B)
    add_to_results_screen(Character.id.NPEACH,   FGM.announcer.names.NFIGHTER,               SMASH,           Character.id.CAPTAIN, 185,     POLY PEACH,      20,     0.6,       0x0B)
    add_to_results_screen(Character.id.NCRASH,   FGM.announcer.names.NFIGHTER,               SMASH,           Character.id.CAPTAIN, 185,     POLY CRASH,      20,     0.6,       0x0B)
}
}
