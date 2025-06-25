// This file contains this characters AI attacks

// Define a input sequences
CRASH_DASH_NSP:
AI.UNPRESS_A();
AI.UNPRESS_B();
AI.UNPRESS_Z();
dh 0xA37F                       // stick x towards opponent. wait(2)
dh 0x0221                       // press B
dh 0xB700                       // wait 7
AI.UNPRESS_A();
AI.UNPRESS_B();
AI.END();
AI.add_cpu_input_routine(CRASH_DASH_NSP)

// Create new cpu attack behaviours
OS.align(4)
CPU_ATTACKS:
// grounded attacks
// add_attack_behaviour(table, attack, hitbox_start_frame, min_x, max_x, min_y, max_y)
AI.add_attack_behaviour(DSPG,   30 + 1 + 5, -400, -200, -100, 200)
AI.add_attack_behaviour(DSMASH, 10,     -250, 250, 10, 100)
AI.add_attack_behaviour(DTILT,  6,      -10, 400, -150, 200)
AI.add_attack_behaviour(FSMASH, 13,     120, 475, 20, 350)
AI.add_attack_behaviour(FTILT,  9,      60, 300, 20, 350)
AI.add_attack_behaviour(GRAB,   6,      50, 340, 65, 355)
AI.add_attack_behaviour(JAB,    4,      70, 250, 65, 300)
AI.add_attack_behaviour(NSPG,   1,     -225, 225, 10, 300)
AI.add_attack_behaviour(USPG,   6,     -225, 225, 150, 250)
AI.add_attack_behaviour(USMASH, 7,    -120, 250, 50, 450)
AI.add_attack_behaviour(UTILT,  4,     50, 100, 25, 400)
// we can add new grounded attacks here
AI.add_custom_attack_behaviour(AI.ROUTINE.CRASH_DASH_NSP,  2, 200, 1000, -10, 600) // dash NSP, custom attack
AI.END_ATTACKS() // end of grounded attacks

// aerial attacks
// add_attack_behaviour(table, attack, hitbox_start_frame, min_x, max_x, min_y, max_y)
AI.add_attack_behaviour(USPA,   6,      -225, 225, -150, 250)
AI.add_attack_behaviour(DSPA,   0,     0, 0, 0, 0) // no attack
AI.add_attack_behaviour(FAIR,   8,     -443, 450, -50, 380)
AI.add_attack_behaviour(NAIR,   5,      -300, 300, 15, 250)
AI.add_attack_behaviour(NSPA,   1,     -225, 225, 10, 300)
AI.add_attack_behaviour(UAIR,   6,      -273, 459, -3, 634)
AI.add_attack_behaviour(DAIR,   12,      -80, 80, -200, 150)
// we can add new aerial attacks here

AI.END_ATTACKS() // end of aerial attacks
OS.align(16)

// Set CPU behaviour
Character.table_patch_start(ai_behaviour, Character.id.CRASH, 0x4)
dw      CPU_ATTACKS
OS.patch_end()

// Set CPU NSP long range behaviour
Character.table_patch_start(ai_long_range, Character.id.CRASH, 0x4)
dw      AI.LONG_RANGE.ROUTINE.NONE
OS.patch_end()