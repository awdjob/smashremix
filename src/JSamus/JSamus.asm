// JSamus.asm

// This file contains file inclusions, action edits, and assembly for JSamus.

scope JSamus {
    // Insert Moveset files
    insert USMASH, "moveset/USMASH.bin"
    insert UP_SPECIAL_AIR, "moveset/UP_SPECIAL_AIR.bin"
    insert UP_SPECIAL_GROUND, "moveset/UP_SPECIAL_GROUND.bin"
    insert NEUTRAL2, "moveset/NEUTRAL2.bin"


    // Modify Action Parameters             // Action               // Animation                // Moveset Data             // Flags
    Character.edit_action_parameters(JSAMUS, Action.Jab2,           -1,                         NEUTRAL2,                   -1)
    Character.edit_action_parameters(JSAMUS, Action.USmash,         -1,                         USMASH,                     -1)
    Character.edit_action_parameters(JSAMUS, 0xE3,                  -1,                         UP_SPECIAL_GROUND,          -1)
    Character.edit_action_parameters(JSAMUS, 0xE4,                  -1,                         UP_SPECIAL_AIR,             -1)

     // Modify Actions            // Action             // Staling ID   // Main ASM                 // Interrupt/Other ASM          // Movement/Physics ASM         // Collision ASM

    // Modify Menu Action Parameters                // Action          // Animation                // Moveset Data             // Flags

    // Set menu zoom size.
    Character.table_patch_start(menu_zoom, Character.id.JSAMUS, 0x4)
    float32 1.05
    OS.patch_end()

    // Set crowd chant FGM.
    Character.table_patch_start(crowd_chant_fgm, Character.id.JSAMUS, 0x2)
    dh  0x0317
    OS.patch_end()

    // Set action strings
    Character.table_patch_start(action_string, Character.id.JSAMUS, 0x4)
    dw  Action.SAMUS.action_string_table
    OS.patch_end()

    // Set Remix 1P ending music
    Character.table_patch_start(remix_1p_end_bgm, Character.id.JSAMUS, 0x2)
    dh {MIDI.id.CRATERIA_MAIN}
    OS.patch_end()

    // Update variants with same model
    Character.table_patch_start(variants_with_same_model, Character.id.JSAMUS, 0x4)
    db      Character.id.SAMUS
    db      Character.id.ESAMUS
    db      Character.id.NONE
    db      Character.id.NONE
    OS.patch_end()
}
