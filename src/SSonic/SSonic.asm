// SSonic.asm

// This file contains file inclusions, action edits, and assembly for Super Sonic.

scope SSonic {
    // Insert Moveset files
    insert USMASH,"moveset/UP_SMASH.bin"

    insert BLINK,"moveset/BLINK.bin"; Moveset.GO_TO(BLINK)            // loops
    IDLE:
    dw 0xBC000003                                   // set slope contour state
    Moveset.SUBROUTINE(BLINK)                   // blink
    dw 0x0400005A; Moveset.SUBROUTINE(BLINK)    // wait 90 frames then blink
    dw 0x0400000A; Moveset.SUBROUTINE(BLINK)    // wait 10 frames then blink
    dw 0x04000050; Moveset.GO_TO(IDLE)         // loop

    RUN:
    // dw  0x0C010160
    // dw  0x00D00000
    // dw  0x00000000
    // dw  0x5A482003
    // dw  0x00420F00
    insert RUN_LOOP,"moveset/RUN.bin"; Moveset.GO_TO(RUN_LOOP)            // loops
    insert NAIR,"moveset/NEUTRAL_AERIAL.bin"
    insert FAIR,"moveset/FORWARD_AERIAL.bin"
    insert BAIR,"moveset/BACK_AERIAL.bin"
    insert UAIR,"moveset/UP_AERIAL.bin"
    insert DAIR,"moveset/DOWN_AERIAL.bin"
    insert JAB1,"moveset/JAB1.bin"
    insert JAB2,"moveset/JAB2.bin"
    insert JAB3,"moveset/JAB3.bin"
    insert UTILT,"moveset/UTILT.bin"
    insert DTILT,"moveset/DTILT.bin"
    insert FTILT,"moveset/FTILT.bin"
    insert FTILT_HIGH,"moveset/FTILT_HIGH.bin"
    insert FTILT_LOW,"moveset/FTILT_LOW.bin"
    insert DSMASH,"moveset/DSMASH.bin"
    insert FSMASH_HIGH,"moveset/FSMASH_HIGH.bin"
    insert FSMASH_MID_HIGH,"moveset/FSMASH_MID_HIGH.bin"
    insert FSMASH,"moveset/FSMASH.bin"
    insert FSMASH_MID_LOW,"moveset/FSMASH_MID_LOW.bin"
    insert FSMASH_LOW,"moveset/FSMASH_LOW.bin"
    DASH_ATTACK:; Moveset.CONCURRENT_STREAM(DASH_ATTACK_CONCURRENT); insert "moveset/DASH_ATTACK.bin"
    DASH_ATTACK_CONCURRENT:
    dw 0x04000005; dw 0xA8000000; dw 0xA0300001     // wait 5 frames then show ball model
    dw 0x0400000F; Moveset.SUBROUTINE(Sonic.SHOW_MODEL) // wait 15 frames then show full model
    dw 0                                            // terminate moveset commands

    insert NSP_CHARGE,"moveset/NSP_CHARGE.bin"
    insert NSP_MOVE,"moveset/NSP_MOVE.bin"
    // insert DSP_BEGIN,"moveset/DSP_BEGIN.bin"
    // insert DSP_CHARGE,"moveset/DSP_CHARGE.bin"
    // insert DSP_AIR_CHARGE,"moveset/DSP_AIR_CHARGE.bin"
    // insert DSP_MOVE,"moveset/DSP_MOVE.bin"
    // insert DSP_AIR_MOVE,"moveset/DSP_AIR_MOVE.bin"
    // insert DSP_AIR_JUMP,"moveset/DSP_AIR_JUMP.bin"
    DSP_EMERALDS:; insert "moveset/DSP_EMERALDS.bin"
    insert USP_BEGIN,"moveset/USP_BEGIN.bin"
    insert USP_END,"moveset/USP_END.bin"
    insert USP_END_A,"moveset/USP_END_A.bin"

    insert TECH_ROLL,"moveset/TECH_ROLL.bin"
    insert FROLL, "moveset/FROLL.bin"
    insert BROLL, "moveset/BROLL.bin"

    insert TEETERING, "moveset/TEETERING.bin"

    BTHROW:; Moveset.THROW_DATA(BTHROW_DATA); insert "moveset/BTHROW.bin"
    insert BTHROW_DATA,"moveset/BTHROW_DATA.bin"

    insert CSS, "moveset/CSS.bin"
    insert ENTRY, "moveset/ENTRY.bin"

    // Insert AI attack options
    include "AI/Attacks.asm"

    // Modify Action Parameters              // Action               // Animation                // Moveset Data             // Flags
    Character.edit_action_parameters(SSONIC, Action.Idle,            File.SSONIC_IDLE,           IDLE,                       -1)
    Character.edit_action_parameters(SSONIC, 0x06,                   File.SSONIC_IDLE,           IDLE,                       -1)
    Character.edit_action_parameters(SSONIC, Action.Entry,           File.SSONIC_IDLE,           IDLE,                       -1)
    Character.edit_action_parameters(SSONIC, Action.ReviveWait,      File.SSONIC_IDLE,           IDLE,                       -1)
    Character.edit_action_parameters(SSONIC, Action.EggLay,          File.SSONIC_IDLE,           IDLE,                       -1)
    Character.edit_action_parameters(SSONIC, Action.Tech,            File.SONIC_TECH,            Sonic.TECH_STAND,           -1)
    Character.edit_action_parameters(SSONIC, Action.TechF,           File.SONIC_TECHF,           Sonic.TECH_ROLL,            -1)
    Character.edit_action_parameters(SSONIC, Action.TechB,           File.SONIC_TECHB,           Sonic.TECH_ROLL,            -1)
    Character.edit_action_parameters(SSONIC, Action.RollF,           -1,                         FROLL,                      -1)
    Character.edit_action_parameters(SSONIC, Action.RollB,           -1,                         BROLL,                      -1)
    Character.edit_action_parameters(SSONIC, Action.CliffCatch,      File.SONIC_CLIFF_CATCH,     -1,                         -1)
    Character.edit_action_parameters(SSONIC, Action.CliffSlow,       File.SONIC_CLIFF_SLOW,      -1,                         -1)
    Character.edit_action_parameters(SSONIC, Action.CliffWait,       File.SONIC_CLIFF_WAIT,      -1,                         -1)
    Character.edit_action_parameters(SSONIC, Action.CliffQuick,      File.SONIC_CLIFF_QUICK,     -1,                         -1)
    Character.edit_action_parameters(SSONIC, Action.CliffClimbQuick1, File.SONIC_CLIFF_CLIMB_QUICK1, -1,                     -1)
    Character.edit_action_parameters(SSONIC, Action.CliffClimbQuick2, File.SONIC_CLIFF_CLIMB_QUICK2, -1,                     -1)
    Character.edit_action_parameters(SSONIC, Action.CliffAttackQuick1, File.SONIC_CLIFF_CLIMB_QUICK1, -1,                    -1)
    Character.edit_action_parameters(SSONIC, Action.CliffAttackQuick2, File.SONIC_CLIFF_ATTACK_QUICK2, Sonic.EDGEATTACKF,    -1)
    Character.edit_action_parameters(SSONIC, Action.CliffEscapeQuick1, File.SONIC_CLIFF_CLIMB_QUICK1, -1,                    -1)
    Character.edit_action_parameters(SSONIC, Action.CliffEscapeQuick2, File.SONIC_CLIFF_ESCAPE_QUICK2, Sonic.CLIFF_ESCAPE2,  -1)
    Character.edit_action_parameters(SSONIC, Action.DeadU,           File.SONIC_TUMBLE,          Sonic.DMG_1,                -1)
    Character.edit_action_parameters(SSONIC, Action.ScreenKO,        File.SONIC_TUMBLE,          Sonic.DMG_1,                -1)
    Character.edit_action_parameters(SSONIC, Action.Tumble,          File.SONIC_TUMBLE,          Sonic.DMG_1,                -1)
    Character.edit_action_parameters(SSONIC, Action.WallBounce,      File.SONIC_TUMBLE,          Sonic.DMG_1,                -1)
    Character.edit_action_parameters(SSONIC, Action.Tornado,         File.SONIC_TUMBLE,          -1,                         -1)
    Character.edit_action_parameters(SSONIC, Action.ShieldBreakFall, File.SONIC_TUMBLE,          -1,                         -1)
    Character.edit_action_parameters(SSONIC, Action.ShieldBreak,     -1,                         Sonic.SHIELD_BREAK,         -1)
    Character.edit_action_parameters(SSONIC, Action.InhalePulled,    File.SONIC_TUMBLE,          Sonic.DMG_1,                -1)
    Character.edit_action_parameters(SSONIC, Action.InhaleSpat,      File.SONIC_TUMBLE,          -1,                         -1)
    Character.edit_action_parameters(SSONIC, Action.InhaleCopied,    File.SONIC_TUMBLE,          -1,                         -1)
    Character.edit_action_parameters(SSONIC, 0xB4,                   File.SONIC_TUMBLE,          Sonic.UNKNOWN_0B4,          -1)
    Character.edit_action_parameters(SSONIC, Action.FalconDivePulled, -1,                        Sonic.FALCON_DIVE_PULLED,   -1)

    Character.edit_action_parameters(SSONIC, Action.ThrownDK,        -1,                         Sonic.DMG_1,                -1)
    Character.edit_action_parameters(SSONIC, Action.ThrownDKPulled,  -1,                         Sonic.DMG_1,                -1)
    Character.edit_action_parameters(SSONIC, Action.ThrownMarioBros, -1,                         Sonic.DMG_1,                -1)
    Character.edit_action_parameters(SSONIC, Action.Thrown1,         -1,                         Sonic.DMG_1,                -1)
    Character.edit_action_parameters(SSONIC, Action.Thrown2,         -1,                         Sonic.DMG_1,                -1)
    Character.edit_action_parameters(SSONIC, Action.ThrownFoxB,      0x2C8,                      Sonic.DMG_1,                -1)
    Character.edit_action_parameters(SSONIC, Action.EggLayPulled,    -1,                         Sonic.DMG_1,                -1)
    Character.edit_action_parameters(SSONIC, Action.CapturePulled,   -1,                         Sonic.DMG_1,                -1)

    Character.edit_action_parameters(SSONIC, Action.Stun,            File.SONIC_STUN,            Sonic.STUN,                 -1)
    Character.edit_action_parameters(SSONIC, Action.Sleep,           File.SONIC_STUN,            Sonic.ASLEEP,               -1)
    Character.edit_action_parameters(SSONIC, Action.ShieldDrop,      File.SONIC_SHIELD_DROP,     -1,                         -1)
    Character.edit_action_parameters(SSONIC, Action.Pass,            File.SONIC_SHIELD_DROP,     -1,                         -1)
    Character.edit_action_parameters(SSONIC, Action.Crouch,          File.SONIC_CROUCH,          -1,                         -1)
    Character.edit_action_parameters(SSONIC, Action.CrouchIdle,      File.SONIC_CROUCH_IDLE,     -1,                         -1)
    Character.edit_action_parameters(SSONIC, Action.CrouchEnd,       File.SONIC_CROUCH_END,      -1,                         -1)
    Character.edit_action_parameters(SSONIC, Action.Walk1,           File.SONIC_WALK1,           -1,                         -1)
    Character.edit_action_parameters(SSONIC, Action.Walk2,           File.SONIC_WALK2,           -1,                         -1)
    Character.edit_action_parameters(SSONIC, Action.Walk3,           File.SONIC_WALK3,           -1,                         -1)
    Character.edit_action_parameters(SSONIC, Action.Dash,            File.SSONIC_DASH,           -1,                         -1)
    Character.edit_action_parameters(SSONIC, Action.Run,             File.SSONIC_RUN,            RUN,                        -1)
    Character.edit_action_parameters(SSONIC, Action.RunBrake,        File.SONIC_RUN_BRAKE,       Sonic.RUNSTOP,              -1)
    Character.edit_action_parameters(SSONIC, Action.TurnRun,         File.SONIC_RUN_TURN,        -1,                         -1)
    Character.edit_action_parameters(SSONIC, Action.JumpF,           File.SONIC_JUMP_F,          Sonic.JUMP,                 -1)
    Character.edit_action_parameters(SSONIC, Action.JumpB,           File.SONIC_JUMP_B,          Sonic.JUMP,                 -1)
    Character.edit_action_parameters(SSONIC, Action.JumpAerialF,     File.SONIC_JUMP_AF,         Sonic.JUMP_2,               -1)
    Character.edit_action_parameters(SSONIC, Action.JumpAerialB,     File.SONIC_JUMP_AB,         Sonic.JUMP_2,               -1)
    Character.edit_action_parameters(SSONIC, Action.Fall,            File.SONIC_FALL,            -1,                         -1)
    Character.edit_action_parameters(SSONIC, Action.FallAerial,      File.SONIC_FALL2,           -1,                         -1)
    Character.edit_action_parameters(SSONIC, Action.JumpSquat,       File.SONIC_JUMPSQUAT,       -1,                         -1)
    Character.edit_action_parameters(SSONIC, Action.ShieldJumpSquat, File.SONIC_JUMPSQUAT,       -1,                         -1)
    Character.edit_action_parameters(SSONIC, Action.LandingLight,    File.SONIC_JUMPSQUAT,       -1,                         -1)
    Character.edit_action_parameters(SSONIC, Action.LandingHeavy,    File.SONIC_JUMPSQUAT,       -1,                         -1)
    Character.edit_action_parameters(SSONIC, Action.LandingSpecial,  File.SONIC_JUMPSQUAT,       -1,                         -1)
    Character.edit_action_parameters(SSONIC, Action.LandingAirX,     File.SONIC_JUMPSQUAT,       -1,                         -1)
    Character.edit_action_parameters(SSONIC, Action.FallSpecial,     File.SONIC_SFALL,           -1,                         -1)
    Character.edit_action_parameters(SSONIC, Action.Taunt,           File.SONIC_TAUNT,           Sonic.TAUNT,                -1)
    Character.edit_action_parameters(SSONIC, Action.Grab,            File.SONIC_GRAB,            -1,                         -1)
    Character.edit_action_parameters(SSONIC, Action.GrabPull,        File.SONIC_GRAB_PULL,       -1,                         -1)
    Character.edit_action_parameters(SSONIC, Action.ThrowF,          File.SONIC_THROWF,          Sonic.FTHROW,               -1)
    Character.edit_action_parameters(SSONIC, Action.ThrowB,          File.SONIC_THROWB,          BTHROW,                     -1)

    Character.edit_action_parameters(SSONIC, Action.Jab1,            File.SONIC_JAB1,            JAB1,                       -1)
    Character.edit_action_parameters(SSONIC, Action.Jab2,            File.SONIC_JAB2,            JAB2,                       -1)
    Character.edit_action_parameters(SSONIC, 0xDC,                   File.SONIC_JAB3,            JAB3,                       -1)
    Character.edit_action_parameters(SSONIC, Action.DashAttack,      File.SONIC_DASH_ATTACK,     DASH_ATTACK,                -1)
    Character.edit_action_parameters(SSONIC, Action.FTiltHigh,       File.SONIC_FTILT_HIGH,      FTILT_HIGH,                 -1)
    Character.edit_action_parameters(SSONIC, Action.FTiltMidHigh,    0,                          0x80000000,                  0)
    Character.edit_action_parameters(SSONIC, Action.FTilt,           File.SONIC_FTILT,           FTILT,                      -1)
    Character.edit_action_parameters(SSONIC, Action.FTiltMidLow,     0,                          0x80000000,                  0)
    Character.edit_action_parameters(SSONIC, Action.FTiltLow,        File.SONIC_FTILT_LOW,       FTILT_LOW,                  -1)
    Character.edit_action_parameters(SSONIC, Action.UTilt,           File.SONIC_UTILT,           UTILT,                      -1)
    Character.edit_action_parameters(SSONIC, Action.DTilt,           File.SONIC_DTILT,           DTILT,                      -1)
    Character.edit_action_parameters(SSONIC, Action.FSmashHigh,      File.SONIC_FSMASH_HIGH,     FSMASH_HIGH,                0x00000000)
    Character.edit_action_parameters(SSONIC, Action.FSmashMidHigh,   File.SONIC_FSMASH_MID_HIGH, FSMASH_MID_HIGH,            0x00000000)
    Character.edit_action_parameters(SSONIC, Action.FSmash,          File.SONIC_FSMASH,          FSMASH,                     0x00000000)
    Character.edit_action_parameters(SSONIC, Action.FSmashMidLow,    File.SONIC_FSMASH_MID_LOW,  FSMASH_MID_LOW,             0x00000000)
    Character.edit_action_parameters(SSONIC, Action.FSmashLow,       File.SONIC_FSMASH_LOW,      FSMASH_LOW,                 0x00000000)
    Character.edit_action_parameters(SSONIC, Action.USmash,          File.SONIC_USMASH,          USMASH,                     -1)
    Character.edit_action_parameters(SSONIC, Action.DSmash,          File.SONIC_DSMASH,          DSMASH,                     -1)
    Character.edit_action_parameters(SSONIC, Action.AttackAirN,      File.SONIC_NAIR,            NAIR,                       -1)
    Character.edit_action_parameters(SSONIC, Action.AttackAirF,      File.SONIC_FAIR,            FAIR,                       -1)
    Character.edit_action_parameters(SSONIC, Action.AttackAirB,      File.SONIC_BAIR,            BAIR,                       -1)
    Character.edit_action_parameters(SSONIC, Action.AttackAirU,      File.SONIC_UAIR,            UAIR,                       -1)
    Character.edit_action_parameters(SSONIC, Action.AttackAirD,      File.SONIC_DAIR,            DAIR,                       -1)

    Character.edit_action_parameters(SSONIC, Action.EnterPipe,       File.SONIC_ENTER_PIPE,      -1,                        -1)
    Character.edit_action_parameters(SSONIC, Action.ExitPipe,        File.SONIC_EXIT_PIPE,       -1,                        -1)
    Character.edit_action_parameters(SSONIC, Action.DownStandU,      File.SONIC_DOWNSTANDU,      -1,                        -1)
    Character.edit_action_parameters(SSONIC, Action.StunLandU,       File.SONIC_DOWNBOUNCEU,      -1,                       -1)
    Character.edit_action_parameters(SSONIC, Action.StunStartU,      File.SONIC_DOWNSTANDU,      -1,                        -1)
    Character.edit_action_parameters(SSONIC, Action.Revive1,         File.SONIC_DOWNBOUNCED,      -1,                       -1)
    Character.edit_action_parameters(SSONIC, Action.Revive2,         File.SONIC_DOWNSTANDD,      -1,                        -1)
    Character.edit_action_parameters(SSONIC, Action.DownStandD,      File.SONIC_DOWNSTANDD,      -1,                        -1)
    Character.edit_action_parameters(SSONIC, Action.StunLandD,       File.SONIC_DOWNBOUNCED,      -1,                       -1)
    Character.edit_action_parameters(SSONIC, Action.StunStartD,      File.SONIC_DOWNSTANDD,      -1,                        -1)
    Character.edit_action_parameters(SSONIC, Action.DownBounceU,     File.SONIC_DOWNBOUNCEU,     Sonic.DOWNBOUNCE,          -1)
    Character.edit_action_parameters(SSONIC, Action.DownBounceD,     File.SONIC_DOWNBOUNCED,     Sonic.DOWNBOUNCE,          -1)
    Character.edit_action_parameters(SSONIC, Action.DownAttackU,     File.SONIC_DOWNATTACKU,     Sonic.DOWNATTACKU,         -1)
    Character.edit_action_parameters(SSONIC, Action.DownBackU,       File.SONIC_DOWNBACKU,       -1,                        -1)
    Character.edit_action_parameters(SSONIC, Action.DownBackD,       File.SONIC_DOWNBACKD,       -1,                        -1)
    Character.edit_action_parameters(SSONIC, Action.DownForwardD,    File.SONIC_DOWNFORWARDD,    -1,                        -1)
    Character.edit_action_parameters(SSONIC, Action.DownForwardU,    File.SONIC_DOWNFORWARDU,    -1,                        -1)
    Character.edit_action_parameters(SSONIC, 0xE4,                   File.SONIC_USP_SPRING,      Sonic.USP,                  0x00000000)
    Character.edit_action_parameters(SSONIC, 0xEC,                   File.SSONIC_DSP,            DSP_EMERALDS,              0)
    Character.edit_action_parameters(SSONIC, 0xF1,                   File.SSONIC_DSPA,           DSP_EMERALDS,              0)

    Character.edit_action_parameters(SSONIC, Action.Teeter,          File.SSONIC_TEETER,         TEETERING,                  -1)
    Character.edit_action_parameters(SSONIC, Action.TeeterStart,     File.SSONIC_TEETER_START,   -1,                         -1)

    Character.edit_action_parameters(SSONIC, 0xDF,                   File.SSONIC_ENTRY_RIGHT,    ENTRY,                      -1)
    Character.edit_action_parameters(SSONIC, 0xE0,                   File.SSONIC_ENTRY_LEFT,     ENTRY,                      -1)

    Character.edit_action_parameters(SSONIC, Action.DamageHigh1,     -1,                         Sonic.DMG_1,                      -1)
    Character.edit_action_parameters(SSONIC, Action.DamageHigh2,     -1,                         Sonic.DMG_1,                      -1)
    Character.edit_action_parameters(SSONIC, Action.DamageHigh3,     -1,                         Sonic.DMG_1,                      -1)
    Character.edit_action_parameters(SSONIC, Action.DamageMid1,      -1,                         Sonic.DMG_1,                      -1)
    Character.edit_action_parameters(SSONIC, Action.DamageMid2,      -1,                         Sonic.DMG_1,                      -1)
    Character.edit_action_parameters(SSONIC, Action.DamageMid3,      -1,                         Sonic.DMG_1,                      -1)
    Character.edit_action_parameters(SSONIC, Action.DamageLow1,      -1,                         Sonic.DMG_1,                      -1)
    Character.edit_action_parameters(SSONIC, Action.DamageLow2,      -1,                         Sonic.DMG_1,                      -1)
    Character.edit_action_parameters(SSONIC, Action.DamageLow3,      -1,                         Sonic.DMG_1,                      -1)
    Character.edit_action_parameters(SSONIC, Action.DamageAir1,      -1,                         Sonic.DMG_1,                      -1)
    Character.edit_action_parameters(SSONIC, Action.DamageAir2,      -1,                         Sonic.DMG_1,                      -1)
    Character.edit_action_parameters(SSONIC, Action.DamageAir3,      -1,                         Sonic.DMG_1,                      -1)
    Character.edit_action_parameters(SSONIC, Action.DamageElec1,     -1,                         Sonic.DMG_1,                      -1)
    Character.edit_action_parameters(SSONIC, Action.DamageElec2,     -1,                         Sonic.DMG_1,                      -1)
    Character.edit_action_parameters(SSONIC, Action.DamageFlyHigh,   -1,                         Sonic.DMG_2,                      -1)
    Character.edit_action_parameters(SSONIC, Action.DamageFlyMid,    -1,                         Sonic.DMG_2,                      -1)
    Character.edit_action_parameters(SSONIC, Action.DamageFlyLow,    -1,                         Sonic.DMG_2,                      -1)
    Character.edit_action_parameters(SSONIC, Action.DamageFlyTop,    -1,                         Sonic.DMG_2,                      -1)
    Character.edit_action_parameters(SSONIC, Action.DamageFlyRoll,   -1,                         Sonic.DMG_2,                      -1)



    // Add Action Parameters                // Action Name      // Base Action  // Animation                // Moveset Data             // Flags
    Character.add_new_action_params(SSONIC,  DSP_Ground_Charge,  -1,             File.SONIC_CHARGE_LOOP,    Sonic.DSP_CHARGE,           0)
    Character.add_new_action_params(SSONIC,  DSP_Ground_Move,    -1,             File.SONIC_SPIN_LOOP_FAST, Sonic.DSP_MOVE,             0x10000000)
    Character.add_new_action_params(SSONIC,  DSP_Ground_End,     -1,             File.SONIC_CROUCH_END,     0x80000000,                 0)
    Character.add_new_action_params(SSONIC,  DSP_Air_Charge,     -1,             File.SONIC_CHARGE_LOOP,    Sonic.DSP_AIR_CHARGE,       0)
    Character.add_new_action_params(SSONIC,  DSP_Air_Move,       -1,             File.SONIC_JUMP_F,         Sonic.DSP_AIR_MOVE,         0)
    Character.add_new_action_params(SSONIC,  DSP_Air_Jump,       -1,             File.SONIC_JUMP_F,         Sonic.DSP_AIR_JUMP,         0)
    Character.add_new_action_params(SSONIC,  DSP_Air_End,        -1,             File.SONIC_CROUCH_END,     0x80000000,                 0)
    Character.add_new_action_params(SSONIC,  NSP_Begin,          -1,             File.SSONIC_NSP_BEGIN,     NSP_CHARGE,                 0)
    Character.add_new_action_params(SSONIC,  NSP_Move,           -1,             File.SSONIC_NSP_MOVE,      NSP_MOVE,                   0x10000000)
    Character.add_new_action_params(SSONIC,  NSP_Locked_Move,    -1,             File.SSONIC_NSP_MOVE,      NSP_MOVE,                   0x10000000)
    Character.add_new_action_params(SSONIC,  USP_Ground_Begin,   -1,             File.SSONIC_USPG_BEGIN,    USP_BEGIN,                  0)
    Character.add_new_action_params(SSONIC,  USP_Ground_End,     -1,             File.SSONIC_USPG_END,      USP_END,                    0)
    Character.add_new_action_params(SSONIC,  USP_Air_Begin,      -1,             File.SSONIC_USPA_BEGIN,    USP_BEGIN,                  0)
    Character.add_new_action_params(SSONIC,  USP_Air_End,        -1,             File.SSONIC_USPA_END,      USP_END_A,                  0)


    // Modify Actions            // Action          // Staling ID   // Main ASM                 // Interrupt/Other ASM          // Movement/Physics ASM         // Collision ASM
    Character.edit_action(SSONIC, 0xDC,              -1,             0x8014FE40,                0x00000000,                     0x800D8CCC,                     0x800DDF44)
    Character.edit_action(SSONIC, 0xEC,              -1,             0x800D94C4,                0,                              -1,                             -1)
    Character.edit_action(SSONIC, 0xF1,              -1,             0x800D94E8,                0,                              -1,                             -1)

    // Add Actions                   // Action Name     // Base Action  //Parameters                        // Staling ID   // Main ASM                     // Interrupt/Other ASM          // Movement/Physics ASM             // Collision ASM
    Character.add_new_action(SSONIC,  DSP_Ground_Charge, -1,             ActionParams.DSP_Ground_Charge,     0x1E,           SonicDSP.ground_charge_main_,   0,                              0x800D8BB4,                         SonicDSP.ground_charge_collision_)
    Character.add_new_action(SSONIC,  DSP_Ground_Move,   -1,             ActionParams.DSP_Ground_Move,       0x1E,           SonicDSP.ground_move_main_,     0,                              SonicDSP.ground_move_physics_,      SonicDSP.ground_move_collision_)
    Character.add_new_action(SSONIC,  DSP_Ground_End,    -1,             ActionParams.DSP_Ground_End,        0x1E,           0x800D94C4,                     0,                              0x800D8BB4,                         SonicDSP.ground_end_collision_)
    Character.add_new_action(SSONIC,  DSP_Air_Charge,    -1,             ActionParams.DSP_Air_Charge,        0x1E,           SonicDSP.air_charge_main_,      0,                              0x800D91EC,                         SonicDSP.air_charge_collision_)
    Character.add_new_action(SSONIC,  DSP_Air_Move,      -1,             ActionParams.DSP_Air_Move,          0x1E,           SonicDSP.air_move_main_,        SonicDSP.air_move_interrupt_,   SonicDSP.air_movement_physics_,     SonicDSP.air_move_collision_)
    Character.add_new_action(SSONIC,  DSP_Air_Jump,      -1,             ActionParams.DSP_Air_Jump,          0x1E,           SonicDSP.air_move_main_,        SonicDSP.air_move_interrupt_,   SonicDSP.air_movement_physics_,     SonicDSP.air_move_collision_)
    Character.add_new_action(SSONIC,  DSP_Air_End,       -1,             ActionParams.DSP_Air_End,           0x1E,           0x800D94E8,                     0,                              0x800D91EC,                         SonicDSP.air_end_collision_)
    Character.add_new_action(SSONIC,  NSP_Begin,         -1,             ActionParams.NSP_Begin,             0x11,           SonicNSP.ssonic_begin_main_,    0,                              0,                                  0x800DE958)
    Character.add_new_action(SSONIC,  NSP_Move,          -1,             ActionParams.NSP_Move,              0x11,           SonicNSP.ssonic_move_main_,     0,                              SonicNSP.move_physics_,             SonicNSP.ssonic_move_collision_)
    Character.add_new_action(SSONIC,  NSP_Locked_Move,   -1,             ActionParams.NSP_Locked_Move,       0x11,           SonicNSP.ssonic_move_main_,     0,                              SonicNSP.move_physics_,             SonicNSP.ssonic_move_collision_)
    Character.add_new_action(SSONIC,  USP_Ground_Begin,  -1,             ActionParams.USP_Ground_Begin,      0x11,           SSonicUSP.begin_main_,          0,                              0x800D8BB4,                         SSonicUSP.ground_begin_collision_)
    Character.add_new_action(SSONIC,  USP_Ground_Move,   -1,             -1,                                 0x11,           SSonicUSP.move_main_,           0,                              SSonicUSP.move_physics_,            SSonicUSP.ground_move_collision_)
    Character.add_new_action(SSONIC,  USP_Ground_End,    -1,             ActionParams.USP_Ground_End,        0x11,           SSonicUSP.ground_end_main_,     SSonicUSP.ground_end_interrupt_, 0x800D8BB4,                        SSonicUSP.end_collision_)
    Character.add_new_action(SSONIC,  USP_Air_Begin,     -1,             ActionParams.USP_Air_Begin,         0x11,           SSonicUSP.begin_main_,          0,                              0x800D91EC,                         SSonicUSP.air_begin_collision_)
    Character.add_new_action(SSONIC,  USP_Air_Move,      -1,             -1,                                 0x11,           SSonicUSP.move_main_,           0,                              SSonicUSP.move_physics_,            SSonicUSP.air_move_collision_)
    Character.add_new_action(SSONIC,  USP_Air_End,       -1,             ActionParams.USP_Air_End,           0x11,           SSonicUSP.air_end_main_,        SSonicUSP.air_end_interrupt_,   0x800D9160,                         SSonicUSP.end_collision_)

    // Modify Menu Action Parameters              // Action          // Animation                // Moveset Data             // Flags
    Character.edit_menu_action_parameters(SSONIC, 0x0,               File.SSONIC_IDLE,           IDLE,                       -1)
    Character.edit_menu_action_parameters(SSONIC, 0x1,               File.SSONIC_VICTORY1,       0x80000000,                 -1)
    Character.edit_menu_action_parameters(SSONIC, 0x2,               File.SSONIC_VICTORY2,       0x80000000,                 -1)
    Character.edit_menu_action_parameters(SSONIC, 0x3,               File.SSONIC_CSS,            CSS,                        -1)
    Character.edit_menu_action_parameters(SSONIC, 0x4,               File.SSONIC_CSS,            CSS,                        -1)
    Character.edit_menu_action_parameters(SSONIC, 0x5,               File.SONIC_CLAP,            Sonic.CLAP,                 -1)
    Character.edit_menu_action_parameters(SSONIC, 0x9,               File.SONIC_PUPPET_FALL,     -1,                         -1)
    Character.edit_menu_action_parameters(SSONIC, 0xA,               File.SONIC_PUPPET_UP,       -1,                         -1)
    Character.edit_menu_action_parameters(SSONIC, 0xD,               File.SSONIC_1P_POSE,        0x80000000,                 -1)
    Character.edit_menu_action_parameters(SSONIC, 0xE,               File.SSONIC_1P_CPU_POSE,    0x80000000,                 -1)

    Character.table_patch_start(variant_original, Character.id.SSONIC, 0x4)
    dw      Character.id.SONIC // set Sonic as original character (not Fox, who SSONIC is a clone of)
    OS.patch_end()

    // Set menu zoom size.
    Character.table_patch_start(menu_zoom, Character.id.SSONIC, 0x4)
    float32 0.95
    OS.patch_end()

    // Set crowd chant FGM.
    Character.table_patch_start(crowd_chant_fgm, Character.id.SSONIC, 0x2)
    dh  0x03F9
    OS.patch_end()

    // Set Kirby copy power and hat_id
    Character.table_patch_start(kirby_inhale_struct, Character.id.SSONIC, 0xC)
    dh Character.id.SSONIC
    dh 0x2F
    OS.patch_end()

    // Set default costumes
    Character.set_default_costumes(Character.id.SSONIC, 0, 1, 4, 5, 3, 1, 2)
    Teams.add_team_costume(YELLOW, SSONIC, 0x0)

    // Set default costume shield colors
    Character.set_costume_shield_colors(SSONIC, YELLOW, AZURE, LIME, RED, PURPLE, MAGENTA, NA, NA)

    Character.table_patch_start(ground_usp, Character.id.SSONIC, 0x4)
    dw      SSonicUSP.ground_begin_initial_
    OS.patch_end()
    Character.table_patch_start(air_usp, Character.id.SSONIC, 0x4)
    dw      SSonicUSP.air_begin_initial_
    OS.patch_end()

    Character.table_patch_start(ground_nsp, Character.id.SSONIC, 0x4)
    dw      SonicNSP.ssonic_begin_initial_
    OS.patch_end()
    Character.table_patch_start(air_nsp, Character.id.SSONIC, 0x4)
    dw      SonicNSP.ssonic_begin_initial_
    OS.patch_end()

    Character.table_patch_start(ground_dsp, Character.id.SSONIC, 0x4)
    dw      SSonicDSP.ground_initial_
    OS.patch_end()
    Character.table_patch_start(air_dsp, Character.id.SSONIC, 0x4)
    dw      SSonicDSP.air_initial_
    OS.patch_end()

    // Use Mario's initial/grounded script.
    Character.table_patch_start(initial_script, Character.id.SSONIC, 0x4)
    dw 0x800D7DCC
    OS.patch_end()
    Character.table_patch_start(grounded_script, Character.id.SSONIC, 0x4)
    dw 0x800DE428
    OS.patch_end()

    // Set action strings
    Character.table_patch_start(action_string, Character.id.SSONIC, 0x4)
    dw  Action.action_string_table
    OS.patch_end()

    // Adds Tails to entry.
    Character.table_patch_start(entry_script, Character.id.SSONIC, 0x4)
    dw 0x8013DD68                           // skips entry script
    OS.patch_end()

    // @ Description
    // Super Sonic's extra actions
    scope Action {
        constant Jab3(0x0DC)
        constant Appear1(0x0DF)
        constant Appear2(0x0E0)
        // constant Spring(0x0E4)
        constant SpinDashChargeGround(0xF6)
        constant SpinDashGround(0xF7)
        constant SpinDashEndGround(0xF8)
        constant SpinDashChargeAir(0xF9)
        constant SpinDashAir(0xFA)
        constant SpinDashJumpAir(0xFB)
        constant SpinDashendAir(0xFC)
        constant SonicRushStart(0xFD)
        constant SonicRush(0xFE)
        constant SonicRush2(0xFF)
        constant SonicSpeedBegin(0x100)
        constant SonicSpeedMove(0x101)
        constant SonicSpeedEnd(0x102)
        constant SonicSpeedBeginAir(0x103)
        constant SonicSpeedMoveAir(0x104)
        constant SonicSpeedEndAir(0x105)

        // strings!
        string_0xEC:; String.insert("SonicChaos")
        string_0xF1:; String.insert("SonicChaosAir")
        string_0xFD:; String.insert("SonicRushBegin")
        string_0xFE:; String.insert("SonicRush")
        string_0xFF:; String.insert("SonicRush")
        string_0x100:; String.insert("SonicSpeedBegin")
        string_0x101:; String.insert("SonicSpeedMove")
        string_0x102:; String.insert("SonicSpeedEnd")
        string_0x103:; String.insert("SonicSpeedBeginAir")
        string_0x104:; String.insert("SonicSpeedMoveAir")
        string_0x105:; String.insert("SonicSpeedEndAir")

        action_string_table:
        dw Action.COMMON.string_jab3
        dw 0
        dw 0
        dw 0
        dw 0
        dw 0
        dw 0
        dw 0
        dw 0
        dw 0
        dw 0
        dw 0
        dw 0
        dw 0
        dw 0
        dw 0
        dw string_0xEC
        dw 0
        dw 0
        dw 0
        dw 0
        dw string_0xF1
        dw 0
        dw 0
        dw 0
        dw 0
        dw 0
        dw 0
        dw 0
        dw 0
        dw 0
        dw 0
        dw 0
        dw string_0xFD
        dw string_0xFE
        dw string_0xFF
        dw string_0x100
        dw string_0x101
        dw string_0x102
        dw string_0x103
        dw string_0x104
        dw string_0x105
    }

    // initial function for ssonic emeralds
    // based on 0x80100FA4 efManagerFoxReflectorMakeEffect
    scope emerald_graphic_init_: {
        addiu   sp, sp,-0x0018              // allocate stack space
        sw      a0, 0x0018(sp)              // ~
        sw      ra, 0x0014(sp)              // store a0, ra
        li		a0, emerald_graphic_struct  // ~
        jal     0x800FDB1C                  // efManagerMakeEffectForce
        nop
        lw      a1, 0x0018(sp)              // a1 = player object
        beqz    v0, _end                    // skip if no gfx object could be created
        or      a0, v0, r0                  // a0 = gfx object

        lw      v1, 0x0084(a0)              // v1 = gfx special struct
        sw      a1, 0x0004(v1)              // store player object
        lw      t6, 0x0084(a1)              // t6 = player struct
        lw      t8, 0x0074(a0)              // t8 = gfx top joint
        lw      t7, 0x08E8(t6)              // ~
        sw      t7, 0x0084(t8)              // store reference to player top joint in gfx top joint
        lli     t9, 0x0004                  // ~
        sw      r0, 0x0018(v1)              // ~
        jal     0x8000DF34                  // animation update
        sw      t9, 0x001C(v1)              // set unknown values

        _end:
        lw      ra, 0x0014(sp)              // load ra
        jr      ra                          // return
        addiu   sp, sp, 0x0018              // deallocate stack space
    }

    // this struct needs updated whenever Reflector File updated
    OS.align(16)
    emerald_graphic_struct:
    dw  0x060F0000
    dw  Character.SSONIC_file_7_ptr
    OS.copy_segment(0xA98F4, 0x8)
    dw  emerald_graphic_update_
    dw  0x80014038
    dw  0x00000930
    dw  0x00000000
    dw  0x00001B08
    dw  0x00000000

    // main update function for ssonic emeralds
    // loosely based on 0x80100ED4 efManagerFoxReflectorProcUpdate
    scope emerald_graphic_update_: {
        addiu   sp, sp,-0x0028              // allocate stack space
        sw      ra, 0x001C(sp)              // ~
        sw      s0, 0x0018(sp)              // store registers
        lw      a2, 0x0084(a0)              // a2 = effect special struct
        or      s0, a0, r0                  // s0 = effect object
        lw      t0, 0x0004(a2)              // ~
        lw      t0, 0x0084(t0)              // t0 = player struct
        lw      t1, 0x0040(t0)              // t1 = hit lag frames remaining
        bnez    t1, _continue               // if in hit lag, skip animation update routine
        sw      a2, 0x0024(sp)              // 0x0024(sp) = effect special struct
        jal     0x8000DF34                  // animation update
        nop

        _continue:
        mtc1    r0, f4                      // ~
        lwc1    f6, 0x0078(s0)              // ~
        c.le.s  f6, f4                      // original logic, check if animation has ended
        nop
        bc1fl   _end                        // skip if animation end has not been reached
        nop

        // if the animation has ended, destroy the effect object
        jal     0x800FD4F8                  // efManagerSetPrevStructAlloc
        lw      a0, 0x0024(sp)              // a0 = effect special struct
        jal     0x80009A84                  // gcEjectGObj
        or      a0, s0, r0                  // a0 = effect object

        _end:
        lw      s0, 0x0018(sp)              // ~
        lw      ra, 0x001C(sp)              // load registers
        jr      ra                          // return
        addiu   sp, sp, 0x0028              // deallocate stack space
    }

    // Set Remix 1P ending music
    Character.table_patch_start(remix_1p_end_bgm, Character.id.SSONIC, 0x2)
    dh {MIDI.id.EVERYTHING}
    OS.patch_end()
}
