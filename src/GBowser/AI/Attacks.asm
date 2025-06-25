// This file contains this characters AI attacks

// Create new cpu attack behaviours
OS.align(4)
CPU_ATTACKS:
// grounded attacks
// add_attack_behaviour(table, attack, hitbox_start_frame, min_x, max_x, min_y, max_y)
AI.add_attack_behaviour(JAB,    6, 211, 1061, 129, 535)
AI.add_attack_behaviour(FTILT,  16, 504, 1544, 121, 584)
AI.add_attack_behaviour(UTILT,  11, -838, 1103, 240, 1580)
AI.add_attack_behaviour(DTILT,  10, 60, 1312, -9, 533)
AI.add_attack_behaviour(FSMASH, 34, -365, 1753, 189, 1255)
AI.add_attack_behaviour(USMASH, 23, -423, 820, 20, 1644)
AI.add_attack_behaviour(DSMASH, 10, -1095, 1062, -30, 457)
AI.add_attack_behaviour(NSPG,   20+5, 300, 1200, 0, 500) // added time for fire travel distance
AI.add_attack_behaviour(USPG,   5, -519, 519, 296, 544)
AI.add_attack_behaviour(DSPG,   8, 285, 1693, 285, 2584)
AI.add_attack_behaviour(GRAB,   6, 435, 1085, 275, 525)
// we can add new grounded attacks here

AI.END_ATTACKS() // end of grounded attacks

// aerial attacks
// add_attack_behaviour(table, attack, hitbox_start_frame, min_x, max_x, min_y, max_y)
AI.add_attack_behaviour(NAIR,   9, -456, 802, -49, 687)
AI.add_attack_behaviour(FAIR,   12, 15, 1408, -564, 1571)
AI.add_attack_behaviour(UAIR,   13, -240, 996, 238, 1394)
AI.add_attack_behaviour(DAIR,   10, -418, 375, -175, 175)
AI.add_attack_behaviour(NSPA,   20+5, 300, 1200, 0, 500)
AI.add_attack_behaviour(DSPA,   24+8, -230, 230, 170-150, 630-150) // added range down because of movement, added delay to compensate
// we can add new aerial attacks here

AI.END_ATTACKS() // end of aerial attacks
OS.align(16)

// Set CPU behaviour
Character.table_patch_start(ai_behaviour, Character.id.GBOWSER, 0x4)
dw      CPU_ATTACKS
OS.patch_end()

// Set CPU SD prevent routine
Character.table_patch_start(ai_attack_prevent, Character.id.GBOWSER, 0x4)
dw    	AI.PREVENT_ATTACK.ROUTINE.GBOWSER
OS.patch_end()