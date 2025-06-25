// This file contains this characters AI attacks

// Define input sequences

// Create new cpu attack behaviours
OS.align(4)
CPU_ATTACKS:
// grounded attacks
// add_attack_behaviour(table, attack, hitbox_start_frame, min_x, max_x, min_y, max_y)
AI.add_attack_behaviour(JAB,    6, 16, 428, 9, 261)
AI.add_attack_behaviour(FTILT,  10, -228, 450, -72, 545)
AI.add_attack_behaviour(UTILT,  8, -445, 345, -59, 538)
AI.add_attack_behaviour(DTILT,  7, 156, 545, -7, 154)
AI.add_attack_behaviour(FSMASH, 14, -282, 561, -24, 614)
AI.add_attack_behaviour(USMASH, 9, -407, 396, 105, 671)
AI.add_attack_behaviour(DSMASH, 9, -500, 554, 10, 263)
AI.add_attack_behaviour(NSPG,   30, 600, 2000, 0, 800) // around this min x location at this frame
AI.add_attack_behaviour(USPG,   5, -340, 340, 135, 279)
AI.add_attack_behaviour(DSPG,   44, 1000, 3000, 0, 1000) // trying to make him go for it sometimes
AI.add_attack_behaviour(GRAB,   6, 149, 299, 157, 307)
// we can add new grounded attacks here

AI.END_ATTACKS() // end of grounded attacks

// aerial attacks
// add_attack_behaviour(table, attack, hitbox_start_frame, min_x, max_x, min_y, max_y)
AI.add_attack_behaviour(NAIR,   4, -118, 230, 45, 242)
AI.add_attack_behaviour(FAIR,   9, -409, 505, -19, 400)
AI.add_attack_behaviour(UAIR,   5, -98, 89, 307, 539)
AI.add_attack_behaviour(DAIR,   5, -79, 140, -52, 223)
AI.add_attack_behaviour(NSPA,   30, 600, 2000, -800, 800) // around this min x location at this frame
AI.add_attack_behaviour(USPA,   5, -340, 340, 135, 279+300) // adding a bit of range up, but not too much to avoid overuse
AI.add_attack_behaviour(DSPA,   44, 1000, 3000, -1000, 1000) // trying to make him go for it sometimes
// we can add new aerial attacks here

AI.END_ATTACKS() // end of aerial attacks
OS.align(16)

// Set CPU behaviour
Character.table_patch_start(ai_behaviour, Character.id.YLINK, 0x4)
dw      CPU_ATTACKS
OS.patch_end()