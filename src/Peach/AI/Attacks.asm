// Peach.asm

// This file contains Peach's AI attacks

OS.align(4)

// Create new cpu attack behaviours
CPU_ATTACKS:
// grounded attacks
// add_attack_behaviour(table, attack, hitbox_start_frame, min_x, max_x, min_y, max_y)
AI.add_attack_behaviour(JAB,    3,      92, 398, 209, 340)
AI.add_attack_behaviour(FTILT,  6,      -16, 506, 25, 671)
AI.add_attack_behaviour(UTILT,  7,     -150, 255, 348, 681)
AI.add_attack_behaviour(DTILT,  7,      11, 503, -9, 242)
AI.add_attack_behaviour(FSMASH, 15,     -105, 512, 33, 706)
AI.add_attack_behaviour(USMASH, 13,    -135, 106, 141, 783)
AI.add_attack_behaviour(DSMASH, 5,      -362, 361, 18, 133)
AI.add_attack_behaviour(NSPG,   20,     29, 934, 163, 278)
AI.add_attack_behaviour(USPG,   4,      20, 100, 300, 1000)
AI.add_attack_behaviour(DSPG,   15,     1500, 3000, -200, 800) // pull turnip at long range
AI.add_attack_behaviour(GRAB,   6,      190, 332, 270, 412)
// we can add new grounded attacks here

AI.END_ATTACKS() // end of grounded attacks
// aerial attacks
// add_attack_behaviour(table, attack, hitbox_start_frame, min_x, max_x, min_y, max_y)
AI.add_attack_behaviour(NAIR,   3,      -164, 304, 123, 525)
AI.add_attack_behaviour(FAIR,   15,     7, 374, 4, 467)
AI.add_attack_behaviour(UAIR,   7,      -91, 82, 278, 667)
AI.add_attack_behaviour(DAIR,   9,      -104, 215, -236, 303)
AI.add_attack_behaviour(NSPA,   20,     -54, 169, 159, 279)
AI.add_attack_behaviour(USPA,   4,      20, 100, 300, 1000)
// we can add new aerial attacks here

AI.END_ATTACKS() // end of aerial attacks
OS.align(16)

// Set CPU behaviour
Character.table_patch_start(ai_behaviour, Character.id.PEACH, 0x4)
dw      CPU_ATTACKS
OS.patch_end()

// Set CPU NSP long range behaviour
Character.table_patch_start(ai_long_range, Character.id.PEACH, 0x4)
dw    	AI.LONG_RANGE.ROUTINE.NONE
OS.patch_end()

// Set CPU SD prevent routine
Character.table_patch_start(ai_attack_prevent, Character.id.PEACH, 0x4)
dw    	AI.PREVENT_ATTACK.ROUTINE.MARIO
OS.patch_end()