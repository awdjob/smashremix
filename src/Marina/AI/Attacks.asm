// This file contains this characters AI attacks

// Create new cpu attack behaviours
OS.align(4)
CPU_ATTACKS:
// grounded attacks
// add_attack_behaviour(table, attack, hitbox_start_frame, min_x, max_x, min_y, max_y)
AI.add_attack_behaviour(JAB,    3, 132, 484, 192, 315)
AI.add_attack_behaviour(FTILT,  8, 161, 612, 121, 321)
AI.add_attack_behaviour(UTILT,  6, -304, 365, 167, 576)
AI.add_attack_behaviour(DTILT,  7, 54, 471, -13, 292)
AI.add_attack_behaviour(FSMASH, 13, 379, 1206, -30, 340)
AI.add_attack_behaviour(USMASH, 12, -62, 208, 261, 715)
AI.add_attack_behaviour(DSMASH, 8, -362, 354, 2, 199)
AI.add_attack_behaviour(NSPG,   19, 302, 1304, 146, 286)
AI.add_attack_behaviour(USPG,   10+5, -21+100, 449-300, 315+400, 2029-1000) // not using full range to avoid overuse/sourspot
AI.add_attack_behaviour(GRAB,   6, 233, 373, 202, 342)
// AI.add_attack_behaviour(DSPG)
// we can add new grounded attacks here

AI.END_ATTACKS() // end of grounded attacks

// aerial attacks
// add_attack_behaviour(table, attack, hitbox_start_frame, min_x, max_x, min_y, max_y)
AI.add_attack_behaviour(NAIR,   5, -95, 227, 70, 240)
AI.add_attack_behaviour(FAIR,   6, 9, 424, 53, 296)
AI.add_attack_behaviour(UAIR,   6, -8, 399, 114, 563)
AI.add_attack_behaviour(DAIR,   8, -123, 211, -211, 185)
AI.add_attack_behaviour(NSPA,   19, 266, 1096, 146, 286)
AI.add_attack_behaviour(USPA,   10+5, -23+100, 435-300, 310+400, 1869-1000) // not using full range to avoid overuse/sourspot
// AI.add_attack_behaviour(DSPA)
// we can add new aerial attacks here

AI.END_ATTACKS() // end of aerial attacks
OS.align(16)

// Set CPU behaviour
Character.table_patch_start(ai_behaviour, Character.id.MARINA, 0x4)
dw      CPU_ATTACKS
OS.patch_end()

// Set CPU SD prevent routine
Character.table_patch_start(ai_attack_prevent, Character.id.MARINA, 0x4)
dw    	AI.PREVENT_ATTACK.ROUTINE.MARINA_NSP
OS.patch_end()