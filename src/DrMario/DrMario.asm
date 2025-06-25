// DrMario.asm

// This file contains file inclusions, action edits, and assembly for Dr. Mario.

scope DrMario {
    // Insert Moveset files
    insert TAUNT,"moveset/TAUNT.bin"
    insert JAB_1,"moveset/JAB_1.bin"
    insert JAB_2,"moveset/JAB_2.bin"
    insert JAB_3,"moveset/JAB_3.bin"
    insert DASH_ATTACK,"moveset/DASH_ATTACK.bin"
    insert FTILT_HI,"moveset/FORWARD_TILT_HIGH.bin"
    insert FTILT,"moveset/FORWARD_TILT.bin"
    insert FTILT_LO,"moveset/FORWARD_TILT_LOW.bin"
    insert UTILT,"moveset/UP_TILT.bin"
    insert DTILT,"moveset/DOWN_TILT.bin"
    insert FSMASH_HI,"moveset/FORWARD_SMASH_HIGH.bin"
    insert FSMASH_M_HI,"moveset/FORWARD_SMASH_MID_HIGH.bin"
    insert FSMASH,"moveset/FORWARD_SMASH.bin"
    insert FSMASH_M_LO,"moveset/FORWARD_SMASH_MID_LOW.bin"
    insert FSMASH_LO,"moveset/FORWARD_SMASH_LOW.bin"
    insert USMASH,"moveset/UP_SMASH.bin"
    insert DSMASH,"moveset/DOWN_SMASH.bin"
    insert NAIR,"moveset/NEUTRAL_AERIAL.bin"
    insert FAIR,"moveset/FORWARD_AERIAL.bin"
    insert BAIR,"moveset/BACK_AERIAL.bin"
    insert UAIR,"moveset/UP_AERIAL.bin"
    insert DAIR,"moveset/DOWN_AERIAL.bin"
    insert NSP_GROUND, "moveset/NEUTRAL_SPECIAL_GROUND.bin"
    insert NSP_AIR, "moveset/NEUTRAL_SPECIAL_AIR.bin"
    insert USP, "moveset/UP_SPECIAL.bin"
    insert DSP_GROUND, "moveset/DOWN_SPECIAL_GROUND.bin"
    insert DSP_AIR, "moveset/DOWN_SPECIAL_AIR.bin"
    BTHROW:; Moveset.THROW_DATA(BTHROWDATA); insert "moveset/BTHROW.bin"
    insert BTHROWDATA, "moveset/BTHROWDATA.bin"
    insert VICTORY_1, "moveset/VICTORY_1.bin"
    insert VICTORY_2, "moveset/VICTORY_2.bin"

    // Insert AI attack options
    include "AI/Attacks.asm"

    // Modify Action Parameters             // Action               // Animation                // Moveset Data             // Flags
    Character.edit_action_parameters(DRM,   Action.Taunt,           File.DRM_TAUNT,             TAUNT,                      -1)
    Character.edit_action_parameters(DRM,   Action.Jab1,            -1,                         JAB_1,                      -1)
    Character.edit_action_parameters(DRM,   Action.Jab2,            -1,                         JAB_2,                      -1)
    Character.edit_action_parameters(DRM,   Action.DashAttack,      -1,                         DASH_ATTACK,                -1)
    Character.edit_action_parameters(DRM,   Action.FTiltHigh,       -1,                         FTILT_HI,                   -1)
    Character.edit_action_parameters(DRM,   Action.FTilt,           -1,                         FTILT,                      -1)
    Character.edit_action_parameters(DRM,   Action.FTiltLow,        -1,                         FTILT_LO,                   -1)
    Character.edit_action_parameters(DRM,   Action.UTilt,           -1,                         UTILT,                      -1)
    Character.edit_action_parameters(DRM,   Action.DTilt,           -1,                         DTILT,                      -1)
    Character.edit_action_parameters(DRM,   Action.FSmashHigh,      -1,                         FSMASH_HI,                  -1)
    Character.edit_action_parameters(DRM,   Action.FSmashMidHigh,   -1,                         FSMASH_M_HI,                -1)
    Character.edit_action_parameters(DRM,   Action.FSmash,          -1,                         FSMASH,                     -1)
    Character.edit_action_parameters(DRM,   Action.FSmashMidLow,    -1,                         FSMASH_M_LO,                -1)
    Character.edit_action_parameters(DRM,   Action.FSmashLow,       -1,                         FSMASH_LO,                  -1)
    Character.edit_action_parameters(DRM,   Action.USmash,          -1,                         USMASH,                     -1)
    Character.edit_action_parameters(DRM,   Action.DSmash,          -1,                         DSMASH,                     -1)
    Character.edit_action_parameters(DRM,   Action.AttackAirN,      -1,                         NAIR,                       -1)
    Character.edit_action_parameters(DRM,   Action.AttackAirF,      File.DRM_FAIR,              FAIR,                       -1)
    Character.edit_action_parameters(DRM,   Action.AttackAirB,      -1,                         BAIR,                       -1)
    Character.edit_action_parameters(DRM,   Action.AttackAirU,      -1,                         UAIR,                       -1)
    Character.edit_action_parameters(DRM,   Action.AttackAirD,      File.DRM_DAIR,              DAIR,                       0)
    Character.edit_action_parameters(DRM,   0xDC,                   -1,                         JAB_3,                      -1)
    Character.edit_action_parameters(DRM,   0xDF,                   -1,                         NSP_GROUND,                 -1)
    Character.edit_action_parameters(DRM,   0xE0,                   -1,                         NSP_AIR,                    -1)
    Character.edit_action_parameters(DRM,   0xE1,                   -1,                         USP,                        -1)
    Character.edit_action_parameters(DRM,   0xE2,                   -1,                         USP,                        -1)
    Character.edit_action_parameters(DRM,   0xE3,                   -1,                         DSP_GROUND,                 -1)
    Character.edit_action_parameters(DRM,   0xE4,                   -1,                         DSP_AIR,                    -1)
    Character.edit_action_parameters(DRM,   Action.ThrowB,          File.DRM_BTHROW,            BTHROW,                     0x50000000)

    // Modify Menu Action Parameters                // Action           // Animation                // Moveset Data             // Flags
    Character.edit_menu_action_parameters(DRM,      0x2,                File.DRM_VICTORY_1,         VICTORY_1,                  0x10000000)
    Character.edit_menu_action_parameters(DRM,      0x3,                File.DRM_VICTORY_2,         VICTORY_2,                  0x10000000)
    Character.edit_menu_action_parameters(DRM,      0xE,                File.DRM_1P_CPU_POSE,       0x80000000,                 -1)

     Character.table_patch_start(variants, Character.id.DRM, 0x4)
    db      Character.id.NONE
    db      Character.id.NDRM // set as POLYGON variant for DRM
    db      Character.id.NONE
    db      Character.id.NONE
    OS.patch_end()

    Character.table_patch_start(variant_original, Character.id.NDRM, 0x4)
    dw      Character.id.DRM // set Dr. Mario as original character (not Mario, who NDRM is a clone of)
    OS.patch_end()

    // Set crowd chant FGM.
    Character.table_patch_start(crowd_chant_fgm, Character.id.DRM, 0x2)
    dh  0x02EB
    OS.patch_end()

    // Set Kirby hat_id
    Character.table_patch_start(kirby_inhale_struct, 0x2, Character.id.DRM, 0xC)
    dh 0x10
    OS.patch_end()

    // Set default costumes
    Character.set_default_costumes(Character.id.DRM, 0, 1, 2, 4, 1, 3, 4)
    Teams.add_team_costume(YELLOW, DRM, 0x5)

    // Shield colors for costume matching
    Character.set_costume_shield_colors(DRM, WHITE, PINK, BLACK, AZURE, LIME, YELLOW, NA, NA)

    // @ Description
    // Dr. Mario's extra actions
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
        dw Action.MARIO.string_0x0E3
        dw Action.MARIO.string_0x0E4
    }

    // Set action strings
    Character.table_patch_start(action_string, Character.id.DRM, 0x4)
    dw  Action.action_string_table
    OS.patch_end()

    // Set Remix 1P ending music
    Character.table_patch_start(remix_1p_end_bgm, Character.id.DRM, 0x2)
    dh {MIDI.id.DR_MARIO}
    OS.patch_end()
}
