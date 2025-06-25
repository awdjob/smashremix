// This file contains this characters AI attacks

// Create new cpu attack behaviours
OS.align(4)
CPU_ATTACKS:
// grounded attacks
// add_attack_behaviour(table, attack, hitbox_start_frame, min_x, max_x, min_y, max_y)
AI.add_attack_behaviour(JAB,    3, 248, 605, 180, 325)
AI.add_attack_behaviour(FTILT,  5, 20, 610, 111, 693)
AI.add_attack_behaviour(UTILT,  5, -173, 537, 17, 712)
AI.add_attack_behaviour(DTILT,  4, 95, 540, 60, 308)
AI.add_attack_behaviour(FSMASH, 12, 247, 943, 126, 469)
AI.add_attack_behaviour(USMASH, 12, -52, 98, 644, 795) // sweetspot only, got by using a bob-omb on a platform
AI.add_attack_behaviour(DSMASH, 5, -383, 380, 17, 337)
AI.add_attack_behaviour(NSPG,   12, 1000, 2000, 200, 300)
// AI.add_attack_behaviour(USPG,   15, 157, 531, 253, 2134-1000) // decreasing upwards range so he does it less often
AI.add_attack_behaviour(DSPG,   25, 27+1200, 631+1000, -353+653, 516+400) // initial state moves Sheik about ~(1000, 600)
AI.add_attack_behaviour(GRAB,   6, 213, 363, 213, 363)
// we can add new grounded attacks here

AI.END_ATTACKS() // end of grounded attacks

// aerial attacks
// add_attack_behaviour(table, attack, hitbox_start_frame, min_x, max_x, min_y, max_y)
AI.add_attack_behaviour(NAIR,   4, -166, 313, -67, 226)
AI.add_attack_behaviour(FAIR,   5, 58, 503, -49, 413)
AI.add_attack_behaviour(UAIR,   4, -66, 215, 244, 598)
AI.add_attack_behaviour(DAIR,   5, -150, 140, -83, 299)
AI.add_attack_behaviour(NSPA,   12, 800, 1800, 800, 1800)
// AI.add_attack_behaviour(USPA,   16, 159, 539, 227, 377)
AI.add_attack_behaviour(DSPA,   25, 27+1200, 631+1000, -353+653, 516+400) // initial state moves Sheik about ~(1000, 600)
// we can add new aerial attacks here

AI.END_ATTACKS() // end of aerial attacks
OS.align(16)

// Set CPU behaviour
Character.table_patch_start(ai_behaviour, Character.id.SHEIK, 0x4)
dw      CPU_ATTACKS
OS.patch_end()

// Set CPU SD prevent routine
Character.table_patch_start(ai_attack_prevent, Character.id.SHEIK, 0x4)
dw    	AI.PREVENT_ATTACK.ROUTINE.NONE
OS.patch_end()

// Set CPU NSP long range behaviour
Character.table_patch_start(ai_long_range, Character.id.SHEIK, 0x4)
dw    	AI.LONG_RANGE.ROUTINE.NSP_SHOOT
OS.patch_end()