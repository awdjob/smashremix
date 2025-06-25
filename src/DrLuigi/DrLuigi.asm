// DrLuigi.asm

// This file contains file inclusions, action edits, and assembly for DrLuigi.

scope DrLuigi {
    // Insert Moveset files
    TAUNT:; insert "moveset/TAUNT.bin"
    insert JAB_1,"moveset/JAB_1.bin"
    insert JAB_2,"moveset/JAB_2.bin"
    insert JAB_3,"moveset/JAB_3.bin"
    insert DASH_ATTACK,"moveset/DASH_ATTACK.bin"
    insert FTILT,"moveset/FORWARD_TILT.bin"
    insert UTILT,"moveset/UP_TILT.bin"
    insert DTILT,"moveset/DOWN_TILT.bin"
    insert FSMASH_HI,"moveset/FORWARD_SMASH_HIGH.bin"
    insert FSMASH_M_HI,"moveset/FORWARD_SMASH_MID_HIGH.bin"
    insert FSMASH,"moveset/FORWARD_SMASH.bin"
    insert FSMASH_LO,"moveset/FORWARD_SMASH_LOW.bin"
    insert USMASH,"moveset/UP_SMASH.bin"
    insert DSMASH,"moveset/DOWN_SMASH.bin"
    insert NAIR,"moveset/NEUTRAL_AERIAL.bin"
    FAIR:; insert "moveset/FORWARD_AERIAL.bin"
    insert BAIR,"moveset/BACK_AERIAL.bin"
    insert UAIR,"moveset/UP_AERIAL.bin"
    insert DAIR,"moveset/DOWN_AERIAL.bin"
    insert USP_GROUND, "moveset/USP_G.bin"
    insert USP_AIR, "moveset/USP_A.bin"
    DSP_GROUND:; insert "moveset/DOWN_SPECIAL_GROUND.bin"
    DSP_AIR:; insert "moveset/DOWN_SPECIAL_AIR.bin"
    FTHROW:; Moveset.THROW_DATA(FTHROWDATA); insert "moveset/FTHROW.bin"
    insert FTHROWDATA, "moveset/FTHROWDATA.bin"
    BTHROW:; Moveset.THROW_DATA(BTHROWDATA); insert "moveset/BTHROW.bin"
    insert BTHROWDATA, "moveset/BTHROWDATA.bin"
    insert NSP_GROUND, "moveset/NEUTRAL_SPECIAL_GROUND.bin"
    insert NSP_AIR, "moveset/NEUTRAL_SPECIAL_AIR.bin"
    insert VICTORY_1, "moveset/VICTORY_1.bin"

    // Insert AI attack options
    include "AI/Attacks.asm"

    // Modify Action Parameters             // Action               // Animation                // Moveset Data             // Flags
    Character.edit_action_parameters(DRL,   Action.Taunt,           -1,                         TAUNT,                      -1)
    Character.edit_action_parameters(DRL,   Action.Jab1,            -1,                         JAB_1,                      -1)
    Character.edit_action_parameters(DRL,   Action.Jab2,            -1,                         JAB_2,                      -1)
    Character.edit_action_parameters(DRL,   Action.DashAttack,      -1,                         DASH_ATTACK,                -1)
    Character.edit_action_parameters(DRL,   Action.FTiltHigh,       -1,                         FTILT,                      -1)
    Character.edit_action_parameters(DRL,   Action.FTilt,           -1,                         FTILT,                      -1)
    Character.edit_action_parameters(DRL,   Action.FTiltLow,        -1,                         FTILT,                      -1)
    Character.edit_action_parameters(DRL,   Action.UTilt,           File.DRL_UTILT,             UTILT,                       0)
    Character.edit_action_parameters(DRL,   Action.DTilt,           -1,                         DTILT,                      -1)
    Character.edit_action_parameters(DRL,   Action.FSmashHigh,      -1,                         FSMASH_HI,                  -1)
    Character.edit_action_parameters(DRL,   Action.FSmashMidHigh,   -1,                         FSMASH_M_HI,                -1)
    Character.edit_action_parameters(DRL,   Action.FSmash,          -1,                         FSMASH,                     -1)
    Character.edit_action_parameters(DRL,   Action.FSmashMidLow,    -1,                         FSMASH_LO,                  -1)
    Character.edit_action_parameters(DRL,   Action.FSmashLow,       -1,                         FSMASH_LO,                  -1)
    Character.edit_action_parameters(DRL,   Action.USmash,          -1,                         USMASH,                     -1)
    Character.edit_action_parameters(DRL,   Action.DSmash,          -1,                         DSMASH,                     -1)
    Character.edit_action_parameters(DRL,   Action.AttackAirN,      -1,                         NAIR,                       -1)
    Character.edit_action_parameters(DRL,   Action.AttackAirF,      File.DRL_ATTACKAIRF,        FAIR,                       -1)
    Character.edit_action_parameters(DRL,   Action.AttackAirB,      -1,                         BAIR,                       -1)
    Character.edit_action_parameters(DRL,   Action.AttackAirU,      -1,                         UAIR,                       -1)
    Character.edit_action_parameters(DRL,   Action.AttackAirD,      File.DRL_ATTACKAIRD,        DAIR,                       0)
    Character.edit_action_parameters(DRL,   Action.LandingAirF,     0,                          0x80000000,                 -1)
    Character.edit_action_parameters(DRL,   0xDC,                   File.DRL_JAB3,              JAB_3,                      0x40000000)
    Character.edit_action_parameters(DRL,   0xDF,                   -1,                         NSP_GROUND,                 -1)
    Character.edit_action_parameters(DRL,   0xE0,                   -1,                         NSP_AIR,                    -1)
    Character.edit_action_parameters(DRL,   0xE1,                   -1,                         USP_GROUND,                 -1)
    Character.edit_action_parameters(DRL,   0xE2,                   -1,                         USP_AIR,                    -1)
    Character.edit_action_parameters(DRL,   0xE3,                   -1,                         DSP_GROUND,                 -1)
    Character.edit_action_parameters(DRL,   0xE4,                   -1,                         DSP_AIR,                    -1)
    Character.edit_action_parameters(DRL,   Action.ThrowF,          -1,                         FTHROW,                     -1)
    Character.edit_action_parameters(DRL,   Action.ThrowB,          File.DRM_BTHROW,            BTHROW,                     0x50000000)

    // Modify Menu Action Parameters                // Action           // Animation                // Moveset Data             // Flags
    Character.edit_menu_action_parameters(DRL,      0x3,                File.DRL_VICTORY_1,         VICTORY_1,                  0)

    // Modify Actions             // Action         // Staling ID   // Main ASM                 // Interrupt/Other ASM                  // Movement/Physics ASM                         // Collision ASM
    Character.edit_action(DRL, 0xDC,             -1,             0x800D94C4,                 0x00000000,                             0x800D8C14,                                     0x800DDF44)

    // @ Description
    // Dr. Luigi's extra actions
    scope Action {
        constant Jab3(0x0DC)
        constant Appear1(0x0DD)
        constant Appear2(0x0DE)
        constant Capsule(0x0DF)
        constant CapsuleAir(0x0E0)
        constant SuperJumpPunch(0x0E1)
        constant SuperJumpPunchAir(0x0E2)
        constant MarioTornado(0x0E3)
        constant MarioTornadoAir(0x0E4)

        // strings!
        //string_0x0DC:; String.insert("Jab3")
        //string_0x0DD:; String.insert("Appear1")
        //string_0x0DE:; String.insert("Appear2")
        string_0x0DF:; String.insert("Megavitamin")
        string_0x0E0:; String.insert("MegavitaminAir")
        //string_0x0E1:; String.insert("SuperJumpPunch")
        //string_0x0E2:; String.insert("SuperJumpPunchAir")
        //string_0x0E3:; String.insert("MarioTornado")
        //string_0x0E4:; String.insert("MarioTornadoAir")

        action_string_table:
        dw Action.COMMON.string_jab3
        dw Action.COMMON.string_appear1
        dw Action.COMMON.string_appear2
        dw string_0x0DF
        dw string_0x0E0
        dw Action.MARIO.string_0x0E1
        dw Action.MARIO.string_0x0E2
        dw Action.LUIGI.string_0x0E3
        dw Action.LUIGI.string_0x0E4
    }

    // Set crowd chant FGM.
    Character.table_patch_start(crowd_chant_fgm, Character.id.DRL, 0x2)
    dh  0x0452
    OS.patch_end()

    // Set action strings
    Character.table_patch_start(action_string, Character.id.DRL, 0x4)
    dw  Action.action_string_table
    OS.patch_end()

    // Set Remix 1P ending music
    Character.table_patch_start(remix_1p_end_bgm, Character.id.DRL, 0x2)
    dh {MIDI.id.CHILL}
    OS.patch_end()

    // Set default costumes
    Character.set_default_costumes(Character.id.DRL, 0, 1, 2, 4, 2, 1, 6)
    Teams.add_team_costume(YELLOW, DRL, 3)

    // Shield colors for costume matching
    Character.set_costume_shield_colors(DRL, WHITE, CYAN, PINK, YELLOW, ORANGE, BLACK, GREEN, PURPLE)

    // Set Kirby hat_id
    Character.table_patch_start(kirby_inhale_struct, 0x2, Character.id.DRL, 0xC)
    dh 0x2D
    OS.patch_end()

    // Set 1P Victory Image
    SinglePlayer.set_ending_image(Character.id.DRL, File.DRL_VICTORY_IMAGE_BOTTOM)

    // Set Charge Smash attacks entry
    ChargeSmashAttacks.set_charged_smash_attacks(Character.id.DRL, ChargeSmashAttacks.entry_mario)

    // Set pipe turn rotation for DRL
    Character.table_patch_start(pipe_turn, Character.id.DRL, 0x1)
    db      OS.TRUE;     OS.patch_end();
}
