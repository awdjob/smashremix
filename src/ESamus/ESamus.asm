// ESamus.asm

// This file contains file inclusions, action edits, and assembly for ESamus.

scope ESamus {
    // Insert Moveset files
    insert BAIR, "moveset/BAIR.bin"
    insert DAIR, "moveset/DAIR.bin"


    // Modify Action Parameters             // Action                       // Animation                // Moveset Data             // Flags
    Character.edit_action_parameters(ESAMUS, Action.AttackAirB,             -1,                         BAIR,                       -1)
    Character.edit_action_parameters(ESAMUS, Action.AttackAirD,             -1,                         DAIR,                       -1)

     // Modify Actions            // Action             // Staling ID   // Main ASM                 // Interrupt/Other ASM          // Movement/Physics ASM         // Collision ASM

    // Modify Menu Action Parameters                // Action          // Animation                // Moveset Data             // Flags

    // Set crowd chant FGM.
    Character.table_patch_start(crowd_chant_fgm, Character.id.ESAMUS, 0x2)
    dh  0x0265
    OS.patch_end()

    // Set action strings
    Character.table_patch_start(action_string, Character.id.ESAMUS, 0x4)
    dw  Action.SAMUS.action_string_table
    OS.patch_end()

    // Set Remix 1P ending music
    Character.table_patch_start(remix_1p_end_bgm, Character.id.ESAMUS, 0x2)
    dh {MIDI.id.CRATERIA_MAIN}
    OS.patch_end()

    // Update variants with same model
    Character.table_patch_start(variants_with_same_model, Character.id.ESAMUS, 0x4)
    db      Character.id.SAMUS
    db      Character.id.JSAMUS
    db      Character.id.NONE
    db      Character.id.NONE
    OS.patch_end()
}
