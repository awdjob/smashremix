// This file contains this characters AI attacks

// Define input sequences
WARIO_NSP_TOWARDS:
AI.STICK_X(0x7F, 0) // stick towards opponent
AI.STICK_Y(0, 0)
// Wait 40 frames so he never jumps during it
AI.PRESS_B(5)
AI.PRESS_B(5)
AI.PRESS_B(5)
AI.PRESS_B(5)
AI.PRESS_B(5)
AI.PRESS_B(5)
AI.PRESS_B(5)
AI.PRESS_B(5)
AI.STICK_X(0, 0)
AI.UNPRESS_B(0)
AI.END()
AI.add_cpu_input_routine(WARIO_NSP_TOWARDS)

WARIO_NSP_TOWARDS_JUMP:
AI.STICK_X(0x7F, 0) // stick towards opponent
AI.STICK_Y(0, 0)
// Wait 10 frames then jump
AI.PRESS_B(5)
AI.PRESS_B(5)
AI.STICK_X(0, 0)
AI.UNPRESS_B(0)
AI.STICK_Y(0x78, 1) // stick up
AI.STICK_Y(0)
AI.END()
AI.add_cpu_input_routine(WARIO_NSP_TOWARDS_JUMP)

// Create new cpu attack behaviours
OS.align(4)
CPU_ATTACKS:
// grounded attacks
// add_attack_behaviour(table, attack, hitbox_start_frame, min_x, max_x, min_y, max_y)
AI.add_attack_behaviour(JAB,    5, 45, 428, 37, 270)
AI.add_attack_behaviour(FTILT,  10, 270, 634, 102, 253)
AI.add_attack_behaviour(UTILT,  7, -197, 197, 121, 594)
AI.add_attack_behaviour(DTILT,  5, 165, 542, 43, 210)
AI.add_attack_behaviour(FSMASH, 12, 9, 918, 173, 360)
AI.add_attack_behaviour(USMASH, 14, 2, 269, 190, 762)
AI.add_attack_behaviour(DSMASH, 22, -348, 497, -44, 293)
// AI.add_attack_behaviour(NSPG,   11, 95, 1804-600, 152, 333) // TODO: for some reason, a lv10 Wario will never do this
AI.add_attack_behaviour(USPG,   6, -261, 261, 138, 2276-1000) // decreasing upwards range so he does it less often as a reaching anti-air
AI.add_attack_behaviour(DSPG,   26+10, 503, 678, 128, 1183-400) // added some delay so he aims for the frames where it will usually hit a grounded opponent
AI.add_attack_behaviour(GRAB,   6, 211, 361, 103, 253)
// we can add new grounded attacks here
AI.add_custom_attack_behaviour(AI.ROUTINE.WARIO_NSP_TOWARDS, 11, 95, 1804-400, 152, 333) // custom NSP so he can use it
AI.add_custom_attack_behaviour(AI.ROUTINE.WARIO_NSP_TOWARDS_JUMP, 11, 95, 1804-400, 152+400, 333+400) // custom NSP so he can use it. Made up jump Y range

AI.END_ATTACKS() // end of grounded attacks

// aerial attacks
// add_attack_behaviour(table, attack, hitbox_start_frame, min_x, max_x, min_y, max_y)
AI.add_attack_behaviour(NAIR,   5, -38, 153, 55, 245)
AI.add_attack_behaviour(FAIR,   5, -40, 361, 27, 255)
AI.add_attack_behaviour(UAIR,   7, -32, 227, 212, 507)
AI.add_attack_behaviour(DAIR,   7, -90, 90, -140, 147)
// AI.add_attack_behaviour(NSPA,   11, 111, 1816-600, -46+200, 469) // TODO: for some reason, a lv10 Wario will never do this
// AI.add_attack_behaviour(USPA,   0, 0, 0, 0, 0) // no attack
AI.add_attack_behaviour(DSPA,   26+10, -88, 88, -1219+400, 156) // done from a fullhop. Added some delay so he aims for lower frames and does it less often
// we can add new aerial attacks here
AI.add_custom_attack_behaviour(AI.ROUTINE.WARIO_NSP_TOWARDS, 11, 111, 1816-400, -46+200, 469) // custom NSP so he can use it
AI.add_custom_attack_behaviour(AI.ROUTINE.WARIO_NSP_TOWARDS_JUMP, 11, 111, 1816-400, -46+200+400, 469+400) // custom NSP so he can use it. Made up jump Y range

AI.END_ATTACKS() // end of aerial attacks
OS.align(16)

// Set CPU behaviour
Character.table_patch_start(ai_behaviour, Character.id.WARIO, 0x4)
dw      CPU_ATTACKS
OS.patch_end()

// Set CPU NSP long range behaviour
Character.table_patch_start(ai_long_range, Character.id.WARIO, 0x4)
dw    	AI.LONG_RANGE.ROUTINE.NONE
OS.patch_end()