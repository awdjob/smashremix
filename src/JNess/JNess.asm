// JNess.asm

// This file contains file inclusions, action edits, and assembly for JNess.

scope JNess {
    // Insert Moveset files
    insert UTILT, "moveset/UTILT.bin"
    insert DSMASH, "moveset/DSMASH.bin"
    insert NEUTRAL2, "moveset/NEUTRAL2.bin"
    insert UAIR, "moveset/UAIR.bin"
    insert USMASH, "moveset/USMASH.bin"
    insert FSMASH, "moveset/FSMASH.bin"
    insert PKTHUNDER2, "moveset/PKTHUNDER2.bin"

    // -1 means no change from the character from which this one was cloned
    // Modify Action Parameters             // Action               // Animation                // Moveset Data             // Flags
    Character.edit_action_parameters(JNESS, Action.Jab2,            -1,                         NEUTRAL2,                   -1)
    Character.edit_action_parameters(JNESS, Action.AttackAirU,      -1,                         UAIR,                       -1)
    Character.edit_action_parameters(JNESS, Action.UTilt,           -1,                         UTILT,                      -1)
    Character.edit_action_parameters(JNESS, Action.USmash,          -1,                         USMASH,                     -1)
    Character.edit_action_parameters(JNESS, Action.DSmash,          -1,                         DSMASH,                     -1)
    Character.edit_action_parameters(JNESS, Action.FSmash,          -1,                         FSMASH,                     -1)
    Character.edit_action_parameters(JNESS, 0xEC,                   -1,                         PKTHUNDER2,                 -1)
    Character.edit_action_parameters(JNESS, 0xE7,                   -1,                         PKTHUNDER2,                 -1)

    // Modify Menu Action Parameters        // Action          // Animation                // Moveset Data             // Flags

        // Set crowd chant FGM.
    Character.table_patch_start(crowd_chant_fgm, Character.id.JNESS, 0x2)
    dh  0x031D
    OS.patch_end()

    // Set action strings
    Character.table_patch_start(action_string, Character.id.JNESS, 0x4)
    dw  Action.NESS.action_string_table
    OS.patch_end()

    // Set Remix 1P ending music
    Character.table_patch_start(remix_1p_end_bgm, Character.id.JNESS, 0x2)
    dh {MIDI.id.POLLYANNA}
    OS.patch_end()

    // Set special Jump2 physics
    Character.table_patch_start(ness_jump, Character.id.JNESS, 0x1)
    db      OS.TRUE;     OS.patch_end();

    // Update variants with same model
    Character.table_patch_start(variants_with_same_model, Character.id.JNESS, 0x4)
    db      Character.id.NESS
    db      Character.id.NONE
    db      Character.id.NONE
    db      Character.id.NONE
    OS.patch_end()

}
