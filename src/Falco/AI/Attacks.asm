// This file contains this characters AI attacks

// Define input sequences

// Create new cpu attack behaviours
OS.align(4)
CPU_ATTACKS:
// grounded attacks
// add_attack_behaviour(table, attack, hitbox_start_frame, min_x, max_x, min_y, max_y)
AI.add_attack_behaviour(JAB,    3, 244, 562, 204, 316)
AI.add_attack_behaviour(FTILT,  6, 170, 606, 205, 336)
AI.add_attack_behaviour(UTILT,  6, -218, 257, 176, 701)
AI.add_attack_behaviour(DTILT,  6, 25, 447, -37, 123)
AI.add_attack_behaviour(FSMASH, 14, 380, 826, 100, 384)
AI.add_attack_behaviour(USMASH, 6, -345, 367, 139, 760)
AI.add_attack_behaviour(DSMASH, 6, -414, 420, -31, 120)
AI.add_attack_behaviour(NSPG,   17, 500, 1976, 151, 266)
AI.add_attack_behaviour(USPG,   30, 40, 1652, 249, 339)
// AI.add_attack_behaviour(DSPG,   1, -90, 90, 160, 340)
AI.add_attack_behaviour(GRAB,   6, 273, 413, 180, 320)
// we can add new grounded attacks here
AI.add_custom_attack_behaviour(AI.ROUTINE.MULTI_SHINE, 1, -90, 90, 160, 340)

AI.END_ATTACKS() // end of grounded attacks

// aerial attacks
// add_attack_behaviour(table, attack, hitbox_start_frame, min_x, max_x, min_y, max_y)
AI.add_attack_behaviour(NAIR,   4, -53, 279, 107, 371)
AI.add_attack_behaviour(FAIR,   6, 51, 347, 138, 383)
AI.add_attack_behaviour(UAIR,   6, -82, 179, 172, 633)
AI.add_attack_behaviour(DAIR,   4, -54, 193, 3, 260)
AI.add_attack_behaviour(NSPA,   17, 350, 1842, 145, 260)
AI.add_attack_behaviour(USPA,   30, 40, 1652, 249, 339)
// AI.add_attack_behaviour(DSPA,   1, -90, 90, 160, 340)
// we can add new aerial attacks here

AI.END_ATTACKS() // end of aerial attacks
OS.align(16)

// Set CPU behaviour
Character.table_patch_start(ai_behaviour, Character.id.FALCO, 0x4)
dw      CPU_ATTACKS
OS.patch_end()

// Set CPU SD prevent routine
Character.table_patch_start(ai_attack_prevent, Character.id.FALCO, 0x4)
dw    	AI.PREVENT_ATTACK.ROUTINE.FALCO_NSP
OS.patch_end()

// Set CPU NSP long range behaviour
Character.table_patch_start(ai_long_range, Character.id.FALCO, 0x4)
dw    	AI.LONG_RANGE.ROUTINE.NONE
OS.patch_end()