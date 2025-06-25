// This file contains this characters AI attacks

// Define a input sequences
ROY_NSP_N_U_U:
AI.UNPRESS_A();
AI.UNPRESS_B();
AI.UNPRESS_Z();
AI.STICK_Y(0);
AI.STICK_X(0x7F)        // stick towards opponent
AI.PRESS_B(8)           // press B, wait 8 frames
AI.UNPRESS_B(8);        // unpress B, wait 8 frames
AI.STICK_Y(0x38, 0)     // stick up, wait 0 frames
AI.PRESS_B(8)           // press B, wait 8 frames
AI.UNPRESS_B(8);        // unpress B, wait 8 frames
AI.PRESS_B(8)           // press B, wait 8 frames
AI.UNPRESS_B(8);        // unpress B, wait 8 frames
AI.STICK_X(0)           // return stick to neutral
AI.STICK_Y(0)           // return stick to neutral
AI.END();
AI.add_cpu_input_routine(ROY_NSP_N_U_U)

// Second hit down has more hitlag and needs to be a bit more delayed
ROY_NSP_N_D_D:
AI.UNPRESS_A();
AI.UNPRESS_B();
AI.UNPRESS_Z();
AI.STICK_Y(0);
AI.STICK_X(0x7F)        // stick towards opponent
AI.PRESS_B(8)           // press B, wait 8 frames
AI.UNPRESS_B(8);        // unpress B, wait 8 frames
AI.STICK_Y(-0x38, 0)    // stick down, wait 0 frames
AI.PRESS_B(9)           // press B, wait 9 frames
AI.UNPRESS_B(9);        // unpress B, wait 9 frames
AI.PRESS_B(9)           // press B, wait 9 frames
AI.UNPRESS_B(9);        // unpress B, wait 9 frames
AI.STICK_X(0)           // return stick to neutral
AI.STICK_Y(0)           // return stick to neutral
AI.END();
AI.add_cpu_input_routine(ROY_NSP_N_D_D)

ROY_NSP_N_N_N:
AI.UNPRESS_A();
AI.UNPRESS_B();
AI.UNPRESS_Z();
AI.STICK_Y(0);
AI.STICK_X(0x7F)        // stick towards opponent
AI.PRESS_B(8)           // press B, wait 8 frames
AI.UNPRESS_B(8);        // unpress B, wait 8 frames
AI.STICK_Y(0, 0)        // stick neutral, wait 0 frames
AI.PRESS_B(8)           // press B, wait 8 frames
AI.UNPRESS_B(8);        // unpress B, wait 8 frames
AI.PRESS_B(8)           // press B, wait 8 frames
AI.UNPRESS_B(8);        // unpress B, wait 8 frames
AI.STICK_X(0)           // return stick to neutral
AI.STICK_Y(0)           // return stick to neutral
AI.END();
AI.add_cpu_input_routine(ROY_NSP_N_N_N)

ROY_DSP_HELD_10F:
AI.UNPRESS_A();
AI.UNPRESS_B();
AI.UNPRESS_Z();
AI.STICK_Y(-0x38)       // stick down, wait 0 frames
// hold B for the initial 11 frames
AI.PRESS_B(5)           // press B, wait 5 frames
AI.PRESS_B(6)           // press B, wait 5 frames
// here onwards we're actually charging the move
AI.PRESS_B(5)           // press B, wait 5 frames
AI.PRESS_B(5)           // press B, wait 5 frames
AI.UNPRESS_B(0);        // unpress B, wait 9 frames
AI.STICK_X(0)           // return stick to neutral
AI.STICK_Y(0)           // return stick to neutral
AI.END();
AI.add_cpu_input_routine(ROY_DSP_HELD_10F)

ROY_DSP_HELD_20F:
AI.UNPRESS_A();
AI.UNPRESS_B();
AI.UNPRESS_Z();
AI.STICK_Y(-0x38)       // stick down, wait 0 frames
// hold B for the initial 11 frames
AI.PRESS_B(5)           // press B, wait 5 frames
AI.PRESS_B(6)           // press B, wait 5 frames
// here onwards we're actually charging the move
AI.PRESS_B(5)           // press B, wait 5 frames
AI.PRESS_B(5)           // press B, wait 5 frames
AI.PRESS_B(5)           // press B, wait 5 frames
AI.PRESS_B(5)           // press B, wait 5 frames
AI.UNPRESS_B(0);        // unpress B, wait 9 frames
AI.STICK_X(0)           // return stick to neutral
AI.STICK_Y(0)           // return stick to neutral
AI.END();
AI.add_cpu_input_routine(ROY_DSP_HELD_20F)

// Create new cpu attack behaviours
OS.align(4)
CPU_ATTACKS:
// Editor note: Some move ranges will have reduced range to make him go for sweetspots.
// The original range is kept for reference.

// grounded attacks
// add_attack_behaviour(table, attack, hitbox_start_frame, min_x, max_x, min_y, max_y)
AI.add_attack_behaviour(JAB,    4, 110, 440-50, 105, 586)
AI.add_attack_behaviour(FTILT,  7, 91, 737-100, -13, 701)
AI.add_attack_behaviour(UTILT,  5, -372+100, 423-100, 190, 851-100)
AI.add_attack_behaviour(DTILT,  6, 64, 722-100, -18, 212)
AI.add_attack_behaviour(FSMASH, 14, 205, 913-150, -9, 761)
AI.add_attack_behaviour(USMASH, 15, -91, 213, 244, 908)
AI.add_attack_behaviour(DSMASH, 6, -581+150, 689-150, -77, 285)
AI.add_attack_behaviour(NSPG,   3, 197, 715, 40, 741)
AI.add_attack_behaviour(USPG,   8, 108, 694, 37, 871) // got by upBing into a bob-omb on Battlefield platform, which interrupted the move
AI.add_attack_behaviour(DSPG,   11+4, -123+200, 717-400, -23, 733-400)
AI.add_attack_behaviour(GRAB,   6, 175, 443, 208, 377)
// we can add new grounded attacks here
AI.add_custom_attack_behaviour(AI.ROUTINE.ROY_NSP_N_N_N, 3, 197, 715, 40, 741) // NSP sequence N N N
AI.add_custom_attack_behaviour(AI.ROUTINE.ROY_NSP_N_U_U, 3, 197, 715, 40, 741) // NSP sequence N U U
AI.add_custom_attack_behaviour(AI.ROUTINE.ROY_NSP_N_D_D, 3, 197, 715, 40, 741) // NSP sequence N D D

AI.add_custom_attack_behaviour(AI.ROUTINE.ROY_DSP_HELD_10F, 11+10+4, -123+200, 717-400, -23, 733-400)
AI.add_custom_attack_behaviour(AI.ROUTINE.ROY_DSP_HELD_20F, 11+20+4, -123+200, 717-400, -23, 733-400)

AI.END_ATTACKS() // end of grounded attacks

// aerial attacks
// add_attack_behaviour(table, attack, hitbox_start_frame, min_x, max_x, min_y, max_y)
AI.add_attack_behaviour(NAIR,   5, -431, 473-50, 17, 639)
AI.add_attack_behaviour(FAIR,   4, -49, 574-50, -152, 649)
AI.add_attack_behaviour(UAIR,   5, -503, 397, 242, 792-100)
AI.add_attack_behaviour(DAIR,   6, -492, 475, -256+50, 490)
// AI.add_attack_behaviour(NSPA,   0, 0, 0, 0, 0) // no attack
// AI.add_attack_behaviour(USPA,   8, 0, 100, 54, 100) // no attack
AI.add_attack_behaviour(DSPA,   11+4, -165+200, 721-400, -23, 690-400)
// we can add new aerial attacks here

// AI.add_custom_attack_behaviour(AI.ROUTINE.ROY_DSP_HELD_10F, 11+10+4, -165+300, 721-300, -23, 690-400) // removing this since he spams it too much
// AI.add_custom_attack_behaviour(AI.ROUTINE.ROY_DSP_HELD_20F, 11+20+4, -165, 721-100, -23, 690-100) // removing this since he spams it too much

AI.END_ATTACKS() // end of aerial attacks
OS.align(16)

// Set CPU behaviour
Character.table_patch_start(ai_behaviour, Character.id.ROY, 0x4)
dw      CPU_ATTACKS
OS.patch_end()

// Set CPU NSP long range behaviour
Character.table_patch_start(ai_long_range, Character.id.ROY, 0x4)
dw      AI.LONG_RANGE.ROUTINE.NONE
OS.patch_end()

// Set CPU SD prevent routine
Character.table_patch_start(ai_attack_prevent, Character.id.ROY, 0x4)
dw    	AI.PREVENT_ATTACK.ROUTINE.MARIO
OS.patch_end()