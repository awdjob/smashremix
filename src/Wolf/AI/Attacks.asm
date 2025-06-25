// This file contains this characters AI attacks

// I really tried making Wolf use his usp properly
// but he doesn't really get stweetspots
// and worst of all he tends to SD a lot

// WOLF_LOW_USP:
// AI.UNPRESS_A();
// AI.UNPRESS_B();
// AI.UNPRESS_Z();
// AI.STICK_X(0x7F)           // stick x towards opponent
// AI.STICK_Y(0x78)           // stick y up
// AI.PRESS_B(1);             // press B, wait 1 frame
// AI.STICK_Y(0xB0, 9);       // stick y down, wait 9 frames
// AI.STICK_Y(0xB0, 9);       // stick y down, wait 9 frames
// AI.STICK_Y(0xB0, 9);       // stick y down, wait 9 frames
// AI.UNPRESS_B(0);           // unpress B
// AI.STICK_X(0);             // stick x to neutral
// AI.STICK_Y(0);             // stick y to neutral
// AI.END();
// AI.add_cpu_input_routine(WOLF_LOW_USP)

// WOLF_HIGH_USP:
// AI.UNPRESS_A();
// AI.UNPRESS_B();
// AI.UNPRESS_Z();
// AI.STICK_X(0x7F)           // stick x towards opponent
// AI.STICK_Y(0x78)           // stick y up
// AI.PRESS_B(9);             // press B, wait 9 frames
// AI.PRESS_B(9);             // press B, wait 9 frames
// AI.PRESS_B(9);             // press B, wait 9 frames
// AI.UNPRESS_B(0);           // unpress B
// AI.STICK_X(0);             // stick x to neutral
// AI.STICK_Y(0);             // stick y to neutral
// AI.END();
// AI.add_cpu_input_routine(WOLF_HIGH_USP)

// Create new cpu attack behaviours
OS.align(4)
CPU_ATTACKS:
// grounded attacks
// add_attack_behaviour(table, attack, hitbox_start_frame, min_x, max_x, min_y, max_y)
AI.add_attack_behaviour(JAB,    3, -62, 497, 201, 571)
AI.add_attack_behaviour(FTILT,  7, 221, 506, 83, 240)
AI.add_attack_behaviour(UTILT,  5, -41, 240, 182, 788)
AI.add_attack_behaviour(DTILT,  4, 251, 564, -29, 160)
AI.add_attack_behaviour(FSMASH, 12, 453, 779, 124, 326)
AI.add_attack_behaviour(USMASH, 9, -385+100, 353-100, 175, 1006) // Reduced X range because from the ground he usually does dsmash anyways. This should improve anti-air upsmashes
AI.add_attack_behaviour(DSMASH, 8, -437, 455, -66, 261)
AI.add_attack_behaviour(NSPG,   33, 800, 3000, 200, 400) // Approximate. In this amount of frames it should be around the min X range
// AI.add_attack_behaviour(DSPG,   1, -100, 100, 159, 359)
AI.add_attack_behaviour(GRAB,   6, 162, 292, 236, 366)
// we can add new grounded attacks here
// AI.add_custom_attack_behaviour(AI.ROUTINE.WOLF_LOW_USP, 15, 1400, 1600, 400, 800)
// AI.add_custom_attack_behaviour(AI.ROUTINE.WOLF_HIGH_USP, 15, 1400, 1600, 1200, 1400)
AI.add_custom_attack_behaviour(AI.ROUTINE.MULTI_SHINE, 1, -100, 100, 159, 359)

AI.END_ATTACKS() // end of grounded attacks

// aerial attacks
// add_attack_behaviour(table, attack, hitbox_start_frame, min_x, max_x, min_y, max_y)
AI.add_attack_behaviour(NAIR,   4, -89, 307, 55, 244)
AI.add_attack_behaviour(FAIR,   4, 51, 488, 114, 681)
AI.add_attack_behaviour(UAIR,   5, -383, 304, 199, 717)
AI.add_attack_behaviour(DAIR,   7, -141, 120, -99, 316)
AI.add_attack_behaviour(NSPA,   33, 800, 3000, 200, 400) // Approximate. In this amount of frames it should be around the min X range
AI.add_attack_behaviour(DSPA,   1, -100, 100, 159, 359)
// we can add new aerial attacks here
// AI.add_custom_attack_behaviour(AI.ROUTINE.WOLF_LOW_USP, 15, 1400, 1600, 400+1200, 800+1200) // adding range up because he expects to be falling during startup
// AI.add_custom_attack_behaviour(AI.ROUTINE.WOLF_HIGH_USP, 15, 1400, 1600, 1200+1200, 1400+1200) // adding range up because he expects to be falling during startup

AI.END_ATTACKS() // end of aerial attacks
OS.align(16)

// Set CPU behaviour
Character.table_patch_start(ai_behaviour, Character.id.WOLF, 0x4)
dw      CPU_ATTACKS
OS.patch_end()

// Set CPU SD prevent routine
Character.table_patch_start(ai_attack_prevent, Character.id.WOLF, 0x4)
dw    	AI.PREVENT_ATTACK.ROUTINE.USP
OS.patch_end()

// Set CPU NSP long range behaviour
Character.table_patch_start(ai_long_range, Character.id.WOLF, 0x4)
dw    	AI.LONG_RANGE.ROUTINE.NSP_SHOOT
OS.patch_end()