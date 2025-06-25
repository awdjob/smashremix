// This file contains this characters AI attacks

// Define input sequences

// Create new cpu attack behaviours
OS.align(4)
CPU_ATTACKS:
// grounded attacks
// add_attack_behaviour(table, attack, hitbox_start_frame, min_x, max_x, min_y, max_y)
AI.add_attack_behaviour(JAB,    4, 143, 486, 244, 409)
AI.add_attack_behaviour(FTILT,  6, 85, 679, 38, 362)
AI.add_attack_behaviour(UTILT,  6, -515, 477, 202, 1015)
AI.add_attack_behaviour(DTILT,  5, 21, 654, 9, 287)
AI.add_attack_behaviour(FSMASH, 18, 296, 751, 179, 379)
AI.add_attack_behaviour(USMASH, 10, -105, 105, 267, 868)
AI.add_attack_behaviour(DSMASH, 14, 116, 466, 18, 341)
AI.add_attack_behaviour(NSPG,   24, 800, 3000, 100, 400)
// AI.add_attack_behaviour(USPG,   0, 0, 0, 0, 0) // no attack
AI.add_attack_behaviour(DSPG,   15, 224+200, 799, 317, 427) // added min_x to avoid close up use
AI.add_attack_behaviour(GRAB,   6, 260, 410, 222, 372)
// we can add new grounded attacks here

AI.END_ATTACKS() // end of grounded attacks

// aerial attacks
// add_attack_behaviour(table, attack, hitbox_start_frame, min_x, max_x, min_y, max_y)
AI.add_attack_behaviour(NAIR,   5, -175, 100, -9, 381)
AI.add_attack_behaviour(FAIR,   5, -45, 420, -22, 398)
AI.add_attack_behaviour(UAIR,   6, -523, 538, -55, 801)
AI.add_attack_behaviour(DAIR,   8, -397, 327, -308, 179)
AI.add_attack_behaviour(NSPA,   24, 800, 3000, 100, 400)
// AI.add_attack_behaviour(USPA,   0, 0, 0, 0, 0) // no attack
AI.add_attack_behaviour(DSPA,   15, 224+200, 799, 252, 362) // added min_x to avoid close up use
// we can add new aerial attacks here

AI.END_ATTACKS() // end of aerial attacks
OS.align(16)

// Set CPU behaviour
Character.table_patch_start(ai_behaviour, Character.id.MTWO, 0x4)
dw      CPU_ATTACKS
OS.patch_end()

// Set CPU SD prevent routine
Character.table_patch_start(ai_attack_prevent, Character.id.MTWO, 0x4)
dw    	AI.PREVENT_ATTACK.ROUTINE.NONE
OS.patch_end()

// Set CPU NSP long range behaviour
Character.table_patch_start(ai_long_range, Character.id.MTWO, 0x4)
dw    	AI.LONG_RANGE.ROUTINE.NSP_SHOOT
OS.patch_end()