// J Falcon.asm

// This file contains file inclusions, action edits, and assembly for J Captain Falcon.

scope JFalcon {
    // Insert Moveset files
    insert NEUTRAL2, "moveset/NEUTRAL2.bin"
    insert NEUTRAL3, "moveset/NEUTRAL3.bin"

    // Modify Action Parameters             // Action               // Animation                // Moveset Data             // Flags
    Character.edit_action_parameters(JFALCON, Action.Jab2,           -1,                         NEUTRAL2,                   -1)
    Character.edit_action_parameters(JFALCON, 0xDC,                  -1,                         NEUTRAL3,                   -1)

    // Modify Menu Action Parameters             // Action          // Animation                // Moveset Data             // Flags


    // Set crowd chant FGM.
     Character.table_patch_start(crowd_chant_fgm, Character.id.JFALCON, 0x2)
     dh  0x031E
     OS.patch_end()

    // Set Remix 1P ending music
    Character.table_patch_start(remix_1p_end_bgm, Character.id.JFALCON, 0x2)
    dh {MIDI.id.FZERO_CLIMBUP}
    OS.patch_end()

    // Set action strings
    Character.table_patch_start(action_string, Character.id.JFALCON, 0x4)
    dw  Action.CAPTAIN.action_string_table
    OS.patch_end()

    // Update variants with same model
    Character.table_patch_start(variants_with_same_model, Character.id.JFALCON, 0x4)
    db      Character.id.CAPTAIN
    db      Character.id.NONE
    db      Character.id.NONE
    db      Character.id.NONE
    OS.patch_end()
}
