// This file contains this characters AI attacks

// Create new cpu attack behaviours
OS.align(4)
CPU_ATTACKS:
// grounded attacks
// add_attack_behaviour(table, attack, hitbox_start_frame, min_x, max_x, min_y, max_y)
AI.add_attack_behaviour(JAB,    5, 77, 345, 324, 490)
AI.add_attack_behaviour(FTILT,  8, 170, 692, 306, 436)
AI.add_attack_behaviour(UTILT,  4, -265, 432, 121, 838)
AI.add_attack_behaviour(DTILT,  9, 145, 652, 3, 181)
AI.add_attack_behaviour(FSMASH, 15, 144, 579, 245, 425)
AI.add_attack_behaviour(USMASH, 6, -346, 405, 305, 1023)
AI.add_attack_behaviour(DSMASH, 8, -268, 560, -2, 332)
AI.add_attack_behaviour(NSPG,   29, 300, 804, 290, 603)
AI.add_attack_behaviour(USPG,   16, -47, 318, 209, 884)
AI.add_attack_behaviour(DSPG,   20, -588, 783, -100, 100)
AI.add_attack_behaviour(GRAB,   6, 221, 371, 196, 346)
// we can add new grounded attacks here

AI.END_ATTACKS() // end of grounded attacks

// aerial attacks
// add_attack_behaviour(table, attack, hitbox_start_frame, min_x, max_x, min_y, max_y)
AI.add_attack_behaviour(NAIR,   4, -58, 343, 148, 329)
AI.add_attack_behaviour(FAIR,   6, -70, 453, 85, 408)
AI.add_attack_behaviour(UAIR,   2, -504, 468, -132, 944)
AI.add_attack_behaviour(DAIR,   7, -142, 285, -212, 318)
AI.add_attack_behaviour(NSPA,   29, 203, 706, 195, 506)
AI.add_attack_behaviour(USPA,   16+4, -25, 534-200, 540, 1929-1200) // added some delay and decreased total range for him not to reach so far
AI.add_attack_behaviour(DSPA,   17+20, -14+200, 764-500, -1527+1000, 52-300) // From a fullhop. Added delay to avoid overuse and compensate travel time
// we can add new aerial attacks here

AI.END_ATTACKS() // end of aerial attacks
OS.align(16)

// Set CPU behaviour
Character.table_patch_start(ai_behaviour, Character.id.DRAGONKING, 0x4)
dw      CPU_ATTACKS
OS.patch_end()

// Set CPU SD prevent routine
Character.table_patch_start(ai_attack_prevent, Character.id.DRAGONKING, 0x4)
dw    	AI.PREVENT_ATTACK.ROUTINE.YOSHI_FALCON
OS.patch_end()