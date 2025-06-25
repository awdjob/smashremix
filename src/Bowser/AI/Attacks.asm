// This file contains this characters AI attacks

// Define input sequences
BOWSER_SHORTHOP_FIREBREATH:
AI.UNPRESS_A();
AI.UNPRESS_B();
AI.UNPRESS_Z();
AI.STICK_Y(0);
AI.CUSTOM(1);           // press C
AI.STICK_X(0x7F, 1);    // stick x towards opponent, wait 1 frame
AI.CUSTOM(2);           // unpress C
AI.STICK_X(0, 7);       // stick x to neutral, wait 7 frames
AI.STICK_X(0, 7);       // stick x to neutral, wait 7 frames
AI.PRESS_B(1);          // press B, wait 1 frame
AI.UNPRESS_B();         // unpress B
AI.STICK_X(0x7F, 9);    // stick x towards opponent, wait 9 frames
AI.STICK_X(0);          // stick x to neutral
AI.END();
AI.add_cpu_input_routine(BOWSER_SHORTHOP_FIREBREATH)

// Create new cpu attack behaviours
OS.align(4)
CPU_ATTACKS:
// grounded attacks
// add_attack_behaviour(table, attack, hitbox_start_frame, min_x, max_x, min_y, max_y)
AI.add_attack_behaviour(JAB,    6, 108, 579, 64, 295)
AI.add_attack_behaviour(FTILT,  12, 278, 815, 67, 309)
AI.add_attack_behaviour(UTILT,  8, -438, 603, 231, 855)
AI.add_attack_behaviour(DTILT,  6, 8, 700, 10, 314)
AI.add_attack_behaviour(FSMASH, 26, -202, 697, 91, 695)
AI.add_attack_behaviour(USMASH, 15, -72, 266, 145, 881)
AI.add_attack_behaviour(DSMASH, 8, -586, 585, -11, 251)
AI.add_attack_behaviour(NSPG,   20 + 5, 100, 1000, 0, 400) // added time for fire travel distance
AI.add_attack_behaviour(USPG,   5, -273, 273, 167, 287)
AI.add_attack_behaviour(DSPG,   8, 101, 905, 101, 1386)
AI.add_attack_behaviour(GRAB,   6, 227, 593, 141, 291)
// we can add new grounded attacks here
AI.add_custom_attack_behaviour(AI.ROUTINE.BOWSER_SHORTHOP_FIREBREATH, 20 + 5, 500, 1500, 0, 500) // added time for shorthop wait, fire travel distance

AI.END_ATTACKS() // end of grounded attacks

// aerial attacks
// add_attack_behaviour(table, attack, hitbox_start_frame, min_x, max_x, min_y, max_y)
AI.add_attack_behaviour(NAIR,   4, -239, 427, -15, 367)
AI.add_attack_behaviour(FAIR,   9, 68, 656, -101, 749)
AI.add_attack_behaviour(UAIR,   7, -113, 531, 135, 746)
AI.add_attack_behaviour(DAIR,   8, -216, 193, -85, 85)
AI.add_attack_behaviour(NSPA,   20 + 5, 100, 1000, 0, 400)
AI.add_attack_behaviour(DSPA,   24 + 8, -115, 115, 101 - 150, 331) // added range down because of movement, added delay to compensate
// we can add new aerial attacks here

AI.END_ATTACKS() // end of aerial attacks
OS.align(16)

// Set CPU behaviour
Character.table_patch_start(ai_behaviour, Character.id.BOWSER, 0x4)
dw      CPU_ATTACKS
OS.patch_end()

// Set CPU SD prevent routine
Character.table_patch_start(ai_attack_prevent, Character.id.BOWSER, 0x4)
dw    	AI.PREVENT_ATTACK.ROUTINE.BOWSER_USP_DSP	// no risky down or up specials
OS.patch_end()