// This file contains this characters AI attacks

// Create new cpu attack behaviours
OS.align(4)
CPU_ATTACKS:
// grounded attacks
// add_attack_behaviour(table, attack, hitbox_start_frame, min_x, max_x, min_y, max_y)
AI.add_attack_behaviour(JAB,    4, 22, 529, 190, 390)
AI.add_attack_behaviour(FTILT,  6, -29, 427, 134, 634)
AI.add_attack_behaviour(UTILT,  6, -177, 173, 146, 729)
AI.add_attack_behaviour(DTILT,  8, 136, 814, 45, 245)
AI.add_attack_behaviour(FSMASH, 10, 250, 1002, 106, 932)
AI.add_attack_behaviour(USMASH, 10, -482, 448, -88, 1143)
AI.add_attack_behaviour(DSMASH, 10, -680, 671, 30, 333)
AI.add_attack_behaviour(NSPG,   70, 700, 1000, 200, 600)
// AI.add_attack_behaviour(USPG,   14+20, -125+400, 1591-300, 34+600, 3229-1000) // had to remove to avoid SD -- decreasing upwards range so he does it less often
AI.add_attack_behaviour(DSPG,   15, 97, 287, 265, 455)
AI.add_attack_behaviour(GRAB,   12, 160, 886, 78, 519)
// we can add new grounded attacks here

AI.END_ATTACKS() // end of grounded attacks

// aerial attacks
// add_attack_behaviour(table, attack, hitbox_start_frame, min_x, max_x, min_y, max_y)
AI.add_attack_behaviour(NAIR,   4, -605, 579, 140, 449)
AI.add_attack_behaviour(FAIR,   8, -12, 417, 104, 702)
AI.add_attack_behaviour(UAIR,   3, -180, 384, 232, 973)
AI.add_attack_behaviour(DAIR,   12, -127, 123, 130, 445)
AI.add_attack_behaviour(NSPA,   70, 700, 1000, 200, 600)
// AI.add_attack_behaviour(USPA,   16, 159, 539, 227, 377)
AI.add_attack_behaviour(DSPA,   15, 97, 287, 265, 455)

// we can add new aerial attacks here

AI.END_ATTACKS() // end of aerial attacks
OS.align(16)

// Set CPU behaviour
Character.table_patch_start(ai_behaviour, Character.id.PIANO, 0x4)
dw      CPU_ATTACKS
OS.patch_end()

// Set CPU NSP long range behaviour
Character.table_patch_start(ai_long_range, Character.id.PIANO, 0x4)
dw    	AI.LONG_RANGE.ROUTINE.NSP_SHOOT
OS.patch_end()

// Set CPU SD prevent routine
Character.table_patch_start(ai_attack_prevent, Character.id.PIANO, 0x4)
dw    	AI.PREVENT_ATTACK.ROUTINE.MARIO
OS.patch_end()