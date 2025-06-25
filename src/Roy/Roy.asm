// Roy.asm

// This file contains file inclusions, action edits, and assembly for Roy.

scope Roy {

	// Image commands used by moveset files
	scope EYES: {
		constant OPEN(0xAC000000)
		constant DAMAGE(0xAC000006)
	}
	scope MOUTH: {
		constant NORMAL(0xAC100000)
		constant DAMAGE(0xAC100006)
	}

    DOWN_BOUNCE:
	dw EYES.DAMAGE; dw MOUTH.DAMAGE;
	Moveset.GO_TO(Moveset.shared.DOWN_BOUNCE)

    // Insert Moveset files
    insert BLINK,"moveset/BLINK.bin"
    IDLE:
    dw 0xbc000003                               // set slope contour state
    Moveset.SUBROUTINE(BLINK)                   // blink
    dw 0x04000050; Moveset.SUBROUTINE(BLINK)    // wait 80 frames then blink
    dw 0x04000014; Moveset.SUBROUTINE(BLINK)    // wait 20 frames then blink
    dw 0x04000050; Moveset.GO_TO(IDLE)          // wait 80 frames then loop

    insert JUMP,"moveset/JUMP.bin"
    insert JUMP_AERIAL,"moveset/JUMP_AERIAL.bin"
    insert TEETER,"moveset/TEETER.bin"
    insert TEETER_START,"moveset/TEETER_START.bin"

    insert DOWN_STAND,"moveset/DOWN_STAND.bin"
    insert DAMAGED_FACE,"moveset/DAMAGED_FACE.bin"
    DMG_1:; Moveset.SUBROUTINE(DAMAGED_FACE); dw 0
    DMG_2:; Moveset.SUBROUTINE(DAMAGED_FACE); Moveset.GO_TO_FILE(0x270); dw 0
    FALCON_DIVE_PULLED:; Moveset.SUBROUTINE(DAMAGED_FACE); Moveset.GO_TO_FILE(0xF44); dw 0
    UNKNOWN_0B4:; Moveset.SUBROUTINE(DAMAGED_FACE); Moveset.GO_TO_FILE(0xF58); dw 0
    insert SPARKLE,"moveset/SPARKLE.bin"; Moveset.GO_TO(SPARKLE)                    // loops
    insert SHIELD_BREAK,"moveset/SHIELD_BREAK.bin"; Moveset.GO_TO(SPARKLE)          // loops
    insert STUN, "moveset/STUN.bin"; Moveset.GO_TO(STUN)                            // loops
    insert ASLEEP, "moveset/ASLEEP.bin"; Moveset.GO_TO(ASLEEP)                      // loops

    insert DOWN_ATTACK_D,"moveset/DOWN_ATTACK_D.bin"
    insert DOWN_ATTACK_U,"moveset/DOWN_ATTACK_U.bin"
    insert TECH_ROLL,"moveset/TECH_ROLL.bin"
    insert TECH,"moveset/TECH.bin"
    insert ROLL_F,"moveset/ROLL_F.bin"
    insert ROLL_B,"moveset/ROLL_B.bin"

    insert EDGE_GRAB, "moveset/EDGE_GRAB.bin"
    insert EDGE_IDLE, "moveset/EDGE_IDLE.bin"
    insert EDGE_ATTACK_QUICK_2, "moveset/EDGE_ATTACK_QUICK_2.bin"
    insert EDGE_ATTACK_SLOW_2, "moveset/EDGE_ATTACK_SLOW_2.bin"

    insert TAUNT,"moveset/TAUNT.bin"
    insert GRAB_RELEASE_DATA,"moveset/GRAB_RELEASE_DATA.bin"
    GRAB:; Moveset.THROW_DATA(GRAB_RELEASE_DATA); insert "moveset/GRAB.bin"
    insert THROW_F_DATA,"moveset/THROW_F_DATA.bin"
    THROW_F:; Moveset.THROW_DATA(THROW_F_DATA); insert "moveset/THROW_F.bin"
    insert THROW_B_DATA,"moveset/THROW_B_DATA.bin"
    THROW_B:; Moveset.THROW_DATA(THROW_B_DATA); insert "moveset/THROW_B.bin"
    insert JAB_1,"moveset/JAB_1.bin"
    insert DASH_ATTACK,"moveset/DASH_ATTACK.bin"
    insert F_TILT,"moveset/F_TILT.bin"
    insert U_TILT,"moveset/U_TILT.bin"
    insert D_TILT,"moveset/D_TILT.bin"
    insert F_SMASH,"moveset/F_SMASH.bin"
    U_SMASH:; insert "moveset/U_SMASH.bin"
    D_SMASH:; insert "moveset/D_SMASH.bin"

    insert ATTACK_AIR_N,"moveset/ATTACK_AIR_N.bin"
    insert ATTACK_AIR_F,"moveset/ATTACK_AIR_F.bin"
    insert ATTACK_AIR_B,"moveset/ATTACK_AIR_B.bin"
    insert ATTACK_AIR_U,"moveset/ATTACK_AIR_U.bin"
    insert ATTACK_AIR_D,"moveset/ATTACK_AIR_D.bin"

    insert USP_CONCURRENT,"moveset/USP_CONCURRENT.bin"
    USP:; Moveset.CONCURRENT_STREAM(USP_CONCURRENT); insert "moveset/USP.bin"
    insert DSP_BEGIN,"moveset/DSP_BEGIN.bin"

    DSP_WAIT:
    Moveset.HIDE_ITEM();
    Moveset.CONCURRENT_STREAM(DSP_CONCURRENT);  // looping graphics
    Moveset.WAIT(1); dw 0xB1F80000;// after 1 frame, overlay 1
    dw 0x3C0005C0;  // loop fgm
    Moveset.WAIT(155);
    DSP_SCREEN_SHAKE_LOOP:
    Moveset.SCREEN_SHAKE(0);
    Moveset.WAIT(8);
    Moveset.GO_TO(DSP_SCREEN_SHAKE_LOOP);
    dw 0;
    DSP_CONCURRENT:
    insert DSP_WAIT_LOOP,"moveset/DSP_WAIT_LOOP.bin"; Moveset.GO_TO(DSP_WAIT_LOOP) // loops

    insert DSP_END,"moveset/DSP_END.bin"
    insert DSP_END_STRONG,"moveset/DSP_END_STRONG.bin"
    insert NSP_1,"moveset/NSP_1.bin"
    insert NSP_2_HIGH,"moveset/NSP_2_HIGH.bin"
    insert NSP_2,"moveset/NSP_2.bin"
    insert NSP_2_LOW,"moveset/NSP_2_LOW.bin"
    insert NSP_3_HIGH,"moveset/NSP_3_HIGH.bin"
    insert NSP_3,"moveset/NSP_3.bin"
    insert NSP_3_LOW,"moveset/NSP_3_LOW.bin"

    insert ENTRY,"moveset/ENTRY.bin"
    insert CLAP,"moveset/CLAP.bin"
    insert SELECT,"moveset/SELECT.bin"
    VICTORY_1:; Moveset.CONCURRENT_STREAM(SELECT); insert "moveset/VICTORY_1.bin"
    insert VICTORY_2,"moveset/VICTORY_2.bin"
    insert VICTORY_3,"moveset/VICTORY_3.bin"

    // Insert AI attack options
    include "AI/Attacks.asm"

    // @ Description
    // Roy's extra actions
    scope Action {
        constant Entry_R(0xDC)
        constant Entry_L(0xDD)
        constant USPG(0xDE)
        constant USPA(0xDF)
        constant NSPG_1(0xE0)
        constant NSPG_2_High(0xE1)
        constant NSPG_2_Mid(0xE2)
        constant NSPG_2_Low(0xE3)
        constant NSPG_3_High(0xE4)
        constant NSPG_3_Mid(0xE5)
        constant NSPG_3_Low(0xE6)
        constant NSPA_1(0xE7)
        constant NSPA_2_High(0xE8)
        constant NSPA_2_Mid(0xE9)
        constant NSPA_2_Low(0xEA)
        constant NSPA_3_High(0xEB)
        constant NSPA_3_Mid(0xEC)
        constant NSPA_3_Low(0xED)
        //constant ?(0xEE)
        constant DSP_G_Begin(0xEF)
        constant DSP_G_Wait(0xF0)
        constant DSP_G_End(0xF1)
        constant DSP_G_Strong_End(0xF2)
        constant DSP_A_Begin(0xF3)
        constant DSP_A_Wait(0xF4)
        constant DSP_A_End(0xF5)
        constant DSP_A_Strong_End(0xF6)

        // strings!
        string_0x0DE:; String.insert("Blazer")
        string_0x0DF:; String.insert("BlazerAir")
        string_0x0E0:; String.insert("DoubleEdgeDance1")
        string_0x0E1:; String.insert("DoubleEdgeDance2High")
        string_0x0E2:; String.insert("DoubleEdgeDance2Mid")
        string_0x0E3:; String.insert("DoubleEdgeDance2Low")
        string_0x0E4:; String.insert("DoubleEdgeDance3High")
        string_0x0E5:; String.insert("DoubleEdgeDance3Mid")
        string_0x0E6:; String.insert("DoubleEdgeDance3Low")
        string_0x0E7:; String.insert("DoubleEdgeDance1Air")
        string_0x0E8:; String.insert("DoubleEdgeDance2HighAir")
        string_0x0E9:; String.insert("DoubleEdgeDance2MidAir")
        string_0x0EA:; String.insert("DoubleEdgeDance2LowAir")
        string_0x0EB:; String.insert("DoubleEdgeDance3HighAir")
        string_0x0EC:; String.insert("DoubleEdgeDance3MidAir")
        string_0x0ED:; String.insert("DoubleEdgeDance3LowAir")
        // string_0x0EE;: String.insert("?")
        string_0x0EF:; String.insert("FlareBladeStart")
        string_0x0F0:; String.insert("FlareBladeCharge")
        string_0x0F1:; String.insert("FlareBladeAttack")
        string_0x0F2:; String.insert("FlareBladeStrongAttack")
        string_0x0F3:; String.insert("FlareBladeStartAir")
        string_0x0F4:; String.insert("FlareBladeChargeAir")
        string_0x0F5:; String.insert("FlareBladeAttackAir")
        string_0x0F6:; String.insert("FlareBladeStrongAttackAir")

        action_string_table:
        dw Action.COMMON.string_appear1
        dw Action.COMMON.string_appear2
        dw string_0x0DE
        dw string_0x0DF
        dw string_0x0E0
        dw string_0x0E1
        dw string_0x0E2
        dw string_0x0E3
        dw string_0x0E4
        dw string_0x0E5
        dw string_0x0E6
        dw string_0x0E7
        dw string_0x0E8
        dw string_0x0E9
        dw string_0x0EA
        dw string_0x0EB
        dw string_0x0EC
        dw string_0x0ED
        dw 0 //dw string_0x0EE
        dw string_0x0EF
        dw string_0x0F0
        dw string_0x0F1
        dw string_0x0F2
        dw string_0x0F3
        dw string_0x0F4
        dw string_0x0F5
        dw string_0x0F6
    }

    // Modify Action Parameters             // Action                       // Animation                        // Moveset Data             // Flags
    Character.edit_action_parameters(ROY, Action.DeadU,                   File.MARTH_TUMBLE,                  DMG_1,                      -1)
    Character.edit_action_parameters(ROY, Action.ScreenKO,                File.MARTH_TUMBLE,                  DMG_1,                      -1)
    Character.edit_action_parameters(ROY, Action.Entry,                   File.MARTH_IDLE,                    -1,                         -1)
    Character.edit_action_parameters(ROY, 0x006,                          File.MARTH_IDLE,                    -1,                         -1)
    Character.edit_action_parameters(ROY, Action.Revive1,                 File.MARTH_DOWN_BOUNCE_D,           -1,                         -1)
    Character.edit_action_parameters(ROY, Action.Revive2,                 File.MARTH_DOWN_STAND_D,            -1,                         -1)
    Character.edit_action_parameters(ROY, Action.ReviveWait,              File.MARTH_IDLE,                    IDLE,                       -1)
    Character.edit_action_parameters(ROY, Action.Idle,                    File.MARTH_IDLE,                    IDLE,                       -1)
    Character.edit_action_parameters(ROY, Action.Walk1,                   File.MARTH_WALK_1,                  -1,                         -1)
    Character.edit_action_parameters(ROY, Action.Walk2,                   File.MARTH_WALK_2,                  -1,                         -1)
    Character.edit_action_parameters(ROY, Action.Walk3,                   File.MARTH_WALK_3,                  -1,                         -1)
    Character.edit_action_parameters(ROY, 0x00E,                          File.MARTH_WALK_END,                -1,                         -1)
    Character.edit_action_parameters(ROY, Action.Dash,                    File.MARTH_DASH,                    -1,                         -1)
    Character.edit_action_parameters(ROY, Action.Run,                     File.MARTH_RUN,                     -1,                         -1)
    Character.edit_action_parameters(ROY, Action.RunBrake,                File.MARTH_RUN_BRAKE,               -1,                         -1)
    Character.edit_action_parameters(ROY, Action.Turn,                    File.MARTH_TURN,                    -1,                         -1)
    Character.edit_action_parameters(ROY, Action.TurnRun,                 File.MARTH_TURN_RUN,                -1,                         -1)
    Character.edit_action_parameters(ROY, Action.JumpSquat,               File.MARTH_LANDING,                 -1,                         -1)
    Character.edit_action_parameters(ROY, Action.ShieldJumpSquat,         File.MARTH_LANDING,                 -1,                         -1)
    Character.edit_action_parameters(ROY, Action.JumpF,                   File.MARTH_JUMP_F,                  JUMP,                       -1)
    Character.edit_action_parameters(ROY, Action.JumpB,                   File.MARTH_JUMP_B,                  JUMP,                       -1)
    Character.edit_action_parameters(ROY, Action.JumpAerialF,             File.MARTH_JUMP_AERIAL_F,           JUMP_AERIAL,                -1)
    Character.edit_action_parameters(ROY, Action.JumpAerialB,             File.MARTH_JUMP_AERIAL_B,           JUMP_AERIAL,                -1)
    Character.edit_action_parameters(ROY, Action.Fall,                    File.MARTH_FALL,                    -1,                         -1)
    Character.edit_action_parameters(ROY, Action.FallAerial,              File.MARTH_FALL_AERIAL,             -1,                         -1)
    Character.edit_action_parameters(ROY, Action.Crouch,                  File.MARTH_CROUCH,                  -1,                         -1)
    Character.edit_action_parameters(ROY, Action.CrouchIdle,              File.MARTH_CROUCH_IDLE,             -1,                         -1)
    Character.edit_action_parameters(ROY, Action.CrouchEnd,               File.MARTH_CROUCH_END,              -1,                         -1)
    Character.edit_action_parameters(ROY, Action.LandingLight,            File.MARTH_LANDING,                 -1,                         -1)
    Character.edit_action_parameters(ROY, Action.LandingHeavy,            File.MARTH_LANDING,                 -1,                         -1)
    Character.edit_action_parameters(ROY, Action.Pass,                    File.MARTH_PASS,                    -1,                         -1)
    Character.edit_action_parameters(ROY, Action.ShieldDrop,              File.MARTH_PASS,                    -1,                         -1)
    Character.edit_action_parameters(ROY, Action.Teeter,                  File.MARTH_TEETER,                  TEETER,                     -1)
    Character.edit_action_parameters(ROY, Action.TeeterStart,             File.MARTH_TEETER_START,            TEETER_START,               -1)
    Character.edit_action_parameters(ROY, Action.DamageHigh1,             File.MARTH_DAMAGE_HIGH_1,           DMG_1,                      -1)
    Character.edit_action_parameters(ROY, Action.DamageHigh2,             File.MARTH_DAMAGE_HIGH_2,           DMG_1,                      -1)
    Character.edit_action_parameters(ROY, Action.DamageHigh3,             File.MARTH_DAMAGE_HIGH_3,           DMG_1,                      -1)
    Character.edit_action_parameters(ROY, Action.DamageMid1,              File.MARTH_DAMAGE_MID_1,            DMG_1,                      -1)
    Character.edit_action_parameters(ROY, Action.DamageMid2,              File.MARTH_DAMAGE_MID_2,            DMG_1,                      -1)
    Character.edit_action_parameters(ROY, Action.DamageMid3,              File.MARTH_DAMAGE_MID_3,            DMG_1,                      -1)
    Character.edit_action_parameters(ROY, Action.DamageLow1,              File.MARTH_DAMAGE_LOW_1,            DMG_1,                      -1)
    Character.edit_action_parameters(ROY, Action.DamageLow2,              File.MARTH_DAMAGE_LOW_2,            DMG_1,                      -1)
    Character.edit_action_parameters(ROY, Action.DamageLow3,              File.MARTH_DAMAGE_LOW_3,            DMG_1,                      -1)
    Character.edit_action_parameters(ROY, Action.DamageAir1,              File.MARTH_DAMAGE_AIR_1,            DMG_1,                      -1)
    Character.edit_action_parameters(ROY, Action.DamageAir2,              File.MARTH_DAMAGE_AIR_2,            DMG_1,                      -1)
    Character.edit_action_parameters(ROY, Action.DamageAir3,              File.MARTH_DAMAGE_AIR_3,            DMG_1,                      -1)
    Character.edit_action_parameters(ROY, Action.DamageElec1,             File.MARTH_DAMAGE_ELEC,             DMG_1,                      -1)
    Character.edit_action_parameters(ROY, Action.DamageElec2,             File.MARTH_DAMAGE_ELEC,             DMG_1,                      -1)
    Character.edit_action_parameters(ROY, Action.DamageFlyHigh,           File.MARTH_DAMAGE_FLY_HIGH,         DMG_2,                      -1)
    Character.edit_action_parameters(ROY, Action.DamageFlyMid,            File.MARTH_DAMAGE_FLY_MID,          DMG_2,                      -1)
    Character.edit_action_parameters(ROY, Action.DamageFlyLow,            File.MARTH_DAMAGE_FLY_LOW,          DMG_2,                      -1)
    Character.edit_action_parameters(ROY, Action.DamageFlyTop,            File.MARTH_DAMAGE_FLY_TOP,          DMG_2,                      -1)
    Character.edit_action_parameters(ROY, Action.DamageFlyRoll,           File.MARTH_DAMAGE_FLY_ROLL,         DMG_2,                      -1)
    Character.edit_action_parameters(ROY, Action.WallBounce,              File.MARTH_TUMBLE,                  DMG_1,                      -1)
    Character.edit_action_parameters(ROY, Action.Tumble,                  File.MARTH_TUMBLE,                  DMG_1,                      -1)
    Character.edit_action_parameters(ROY, Action.FallSpecial,             File.MARTH_FALL_SPECIAL,            -1,                         -1)
    Character.edit_action_parameters(ROY, Action.LandingSpecial,          File.MARTH_LANDING,                 -1,                         -1)
    Character.edit_action_parameters(ROY, Action.Tornado,                 File.MARTH_TUMBLE,                  -1,                         -1)
    Character.edit_action_parameters(ROY, Action.EnterPipe,               File.MARTH_ENTER_PIPE,              -1,                         -1)
    Character.edit_action_parameters(ROY, Action.ExitPipe,                File.MARTH_EXIT_PIPE,               -1,                         -1)
    Character.edit_action_parameters(ROY, Action.ExitPipeWalk,            File.MARTH_EXIT_PIPE_WALK,          -1,                         -1)
    Character.edit_action_parameters(ROY, Action.CeilingBonk,             File.MARTH_CEILING_BONK,            -1,                         -1)
    Character.edit_action_parameters(ROY, Action.DownBounceD,             File.MARTH_DOWN_BOUNCE_D,           DOWN_BOUNCE,                -1)
    Character.edit_action_parameters(ROY, Action.DownBounceU,             File.MARTH_DOWN_BOUNCE_U,           DOWN_BOUNCE,                -1)
    Character.edit_action_parameters(ROY, Action.DownStandD,              File.MARTH_DOWN_STAND_D,            DOWN_STAND,                 -1)
    Character.edit_action_parameters(ROY, Action.DownStandU,              File.MARTH_DOWN_STAND_U,            DOWN_STAND,                 -1)
    Character.edit_action_parameters(ROY, Action.TechF,                   File.MARTH_TECH_F,                  TECH_ROLL,                  -1)
    Character.edit_action_parameters(ROY, Action.TechB,                   File.MARTH_TECH_B,                  TECH_ROLL,                  -1)
    Character.edit_action_parameters(ROY, Action.DownForwardD,            File.MARTH_DOWN_FORWARD_D,          -1,                         -1)
    Character.edit_action_parameters(ROY, Action.DownForwardU,            File.MARTH_DOWN_FORWARD_U,          -1,                         -1)
    Character.edit_action_parameters(ROY, Action.DownBackD,               File.MARTH_DOWN_BACK_D,             -1,                         -1)
    Character.edit_action_parameters(ROY, Action.DownBackU,               File.MARTH_DOWN_BACK_U,             -1,                         -1)
    Character.edit_action_parameters(ROY, Action.DownAttackD,             File.MARTH_DOWN_ATTACK_D,           DOWN_ATTACK_D,              -1)
    Character.edit_action_parameters(ROY, Action.DownAttackU,             File.MARTH_DOWN_ATTACK_U,           DOWN_ATTACK_U,              -1)
    Character.edit_action_parameters(ROY, Action.Tech,                    File.MARTH_TECH,                    TECH,                       -1)
    Character.edit_action_parameters(ROY, 0x053,                          File.MARTH_UNKNOWN_053,             -1,                         -1)
    Character.edit_action_parameters(ROY, Action.CliffCatch,              File.MARTH_CLIFF_CATCH,             EDGE_GRAB,                  -1)
    Character.edit_action_parameters(ROY, Action.CliffWait,               File.MARTH_CLIFF_WAIT,              EDGE_IDLE,                  -1)
    Character.edit_action_parameters(ROY, Action.CliffQuick,              File.MARTH_CLIFF_QUICK,             -1,                         -1)
    Character.edit_action_parameters(ROY, Action.CliffClimbQuick1,        File.MARTH_CLIFF_CLIMB_QUICK_1,     -1,                         -1)
    Character.edit_action_parameters(ROY, Action.CliffClimbQuick2,        File.MARTH_CLIFF_CLIMB_QUICK_2,     -1,                         -1)
    Character.edit_action_parameters(ROY, Action.CliffSlow,               File.MARTH_CLIFF_SLOW,              -1,                         -1)
    Character.edit_action_parameters(ROY, Action.CliffClimbSlow1,         File.MARTH_CLIFF_CLIMB_SLOW_1,      -1,                         -1)
    Character.edit_action_parameters(ROY, Action.CliffClimbSlow2,         File.MARTH_CLIFF_CLIMB_SLOW_2,      -1,                         -1)
    Character.edit_action_parameters(ROY, Action.CliffAttackQuick1,       File.MARTH_CLIFF_ATTACK_QUICK_1,    -1,                         -1)
    Character.edit_action_parameters(ROY, Action.CliffAttackQuick2,       File.MARTH_CLIFF_ATTACK_QUICK_2,    EDGE_ATTACK_QUICK_2,        -1)
    Character.edit_action_parameters(ROY, Action.CliffAttackSlow1,        File.MARTH_CLIFF_ATTACK_SLOW_1,     -1,                         -1)
    Character.edit_action_parameters(ROY, Action.CliffAttackSlow2,        File.MARTH_CLIFF_ATTACK_SLOW_2,     EDGE_ATTACK_SLOW_2,         -1)
    Character.edit_action_parameters(ROY, Action.CliffEscapeQuick1,       File.MARTH_CLIFF_ESCAPE_QUICK_1,    -1,                         -1)
    Character.edit_action_parameters(ROY, Action.CliffEscapeQuick2,       File.MARTH_CLIFF_ESCAPE_QUICK_2,    -1,                         -1)
    Character.edit_action_parameters(ROY, Action.CliffEscapeSlow1,        File.MARTH_CLIFF_ESCAPE_SLOW_1,     -1,                         -1)
    Character.edit_action_parameters(ROY, Action.CliffEscapeSlow2,        File.MARTH_CLIFF_ESCAPE_SLOW_2,     -1,                         -1)
    Character.edit_action_parameters(ROY, Action.LightItemPickup,         File.MARTH_LIGHT_ITEM_PICKUP,       -1,                         -1)
    Character.edit_action_parameters(ROY, Action.HeavyItemPickup,         File.MARTH_HEAVY_ITEM_PICKUP,       -1,                         -1)
    Character.edit_action_parameters(ROY, Action.ItemDrop,                File.MARTH_ITEM_DROP,               -1,                         -1)
    Character.edit_action_parameters(ROY, Action.ItemThrowDash,           File.MARTH_ITEM_THROW_DASH,         -1,                         -1)
    Character.edit_action_parameters(ROY, Action.ItemThrowF,              File.MARTH_ITEM_THROW,              -1,                         -1)
    Character.edit_action_parameters(ROY, Action.ItemThrowB,              File.MARTH_ITEM_THROW,              -1,                         -1)
    Character.edit_action_parameters(ROY, Action.ItemThrowU,              File.MARTH_ITEM_THROW_U,            -1,                         -1)
    Character.edit_action_parameters(ROY, Action.ItemThrowD,              File.MARTH_ITEM_THROW_D,            -1,                         -1)
    Character.edit_action_parameters(ROY, Action.ItemThrowSmashF,         File.MARTH_ITEM_THROW,              -1,                         -1)
    Character.edit_action_parameters(ROY, Action.ItemThrowSmashB,         File.MARTH_ITEM_THROW,              -1,                         -1)
    Character.edit_action_parameters(ROY, Action.ItemThrowSmashU,         File.MARTH_ITEM_THROW_U,            -1,                         -1)
    Character.edit_action_parameters(ROY, Action.ItemThrowSmashD,         File.MARTH_ITEM_THROW_D,            -1,                         -1)
    Character.edit_action_parameters(ROY, Action.ItemThrowAirF,           File.MARTH_ITEM_THROW_AIR,          -1,                         -1)
    Character.edit_action_parameters(ROY, Action.ItemThrowAirB,           File.MARTH_ITEM_THROW_AIR,          -1,                         -1)
    Character.edit_action_parameters(ROY, Action.ItemThrowAirU,           File.MARTH_ITEM_THROW_AIR_U,        -1,                         -1)
    Character.edit_action_parameters(ROY, Action.ItemThrowAirD,           File.MARTH_ITEM_THROW_AIR_D,        -1,                         -1)
    Character.edit_action_parameters(ROY, Action.ItemThrowAirSmashF,      File.MARTH_ITEM_THROW_AIR,          -1,                         -1)
    Character.edit_action_parameters(ROY, Action.ItemThrowAirSmashB,      File.MARTH_ITEM_THROW_AIR,          -1,                         -1)
    Character.edit_action_parameters(ROY, Action.ItemThrowAirSmashU,      File.MARTH_ITEM_THROW_AIR_U,        -1,                         -1)
    Character.edit_action_parameters(ROY, Action.ItemThrowAirSmashD,      File.MARTH_ITEM_THROW_AIR_D,        -1,                         -1)
    Character.edit_action_parameters(ROY, Action.HeavyItemThrowF,         File.MARTH_HEAVY_ITEM_THROW,        -1,                         -1)
    Character.edit_action_parameters(ROY, Action.HeavyItemThrowB,         File.MARTH_HEAVY_ITEM_THROW,        -1,                         -1)
    Character.edit_action_parameters(ROY, Action.HeavyItemThrowSmashF,    File.MARTH_HEAVY_ITEM_THROW,        -1,                         -1)
    Character.edit_action_parameters(ROY, Action.HeavyItemThrowSmashB,    File.MARTH_HEAVY_ITEM_THROW,        -1,                         -1)
    Character.edit_action_parameters(ROY, Action.BeamSwordNeutral,        File.MARTH_ITEM_NEUTRAL,            Marth.BEAMSWORD_JAB,        -1)
    Character.edit_action_parameters(ROY, Action.BeamSwordTilt,           File.MARTH_ITEM_TILT,               Marth.BEAMSWORD_TILT,       -1)
    Character.edit_action_parameters(ROY, Action.BeamSwordSmash,          File.MARTH_ITEM_SMASH,              Marth.BEAMSWORD_SMASH,      -1)
    Character.edit_action_parameters(ROY, Action.BeamSwordDash,           File.MARTH_ITEM_DASH_ATTACK,        Marth.BEAMSWORD_DASH,       -1)
    Character.edit_action_parameters(ROY, Action.BatNeutral,              File.MARTH_ITEM_NEUTRAL,            Marth.BAT_JAB,              -1)
    Character.edit_action_parameters(ROY, Action.BatTilt,                 File.MARTH_ITEM_TILT,               Marth.BAT_TILT,             -1)
    Character.edit_action_parameters(ROY, Action.BatSmash,                File.MARTH_ITEM_SMASH,              Marth.BAT_SMASH,            -1)
    Character.edit_action_parameters(ROY, Action.BatDash,                 File.MARTH_ITEM_DASH_ATTACK,        Marth.BAT_DASH,             -1)
    Character.edit_action_parameters(ROY, Action.FanNeutral,              File.MARTH_ITEM_NEUTRAL,            Marth.FAN_JAB,              -1)
    Character.edit_action_parameters(ROY, Action.FanTilt,                 File.MARTH_ITEM_TILT,               Marth.FAN_TILT,             -1)
    Character.edit_action_parameters(ROY, Action.FanSmash,                File.MARTH_ITEM_SMASH,              Marth.FAN_SMASH,            -1)
    Character.edit_action_parameters(ROY, Action.FanDash,                 File.MARTH_ITEM_DASH_ATTACK,        Marth.FAN_DASH,             -1)
    Character.edit_action_parameters(ROY, Action.StarRodNeutral,          File.MARTH_ITEM_NEUTRAL,            Marth.STARROD_JAB,          -1)
    Character.edit_action_parameters(ROY, Action.StarRodTilt,             File.MARTH_ITEM_TILT,               Marth.STARROD_TILT,         -1)
    Character.edit_action_parameters(ROY, Action.StarRodSmash,            File.MARTH_ITEM_SMASH,              Marth.STARROD_SMASH,        -1)
    Character.edit_action_parameters(ROY, Action.StarRodDash,             File.MARTH_ITEM_DASH_ATTACK,        Marth.STARROD_DASH,         -1)
    Character.edit_action_parameters(ROY, Action.RayGunShoot,             File.MARTH_ITEM_SHOOT,              -1,                         -1)
    Character.edit_action_parameters(ROY, Action.RayGunShootAir,          File.MARTH_ITEM_SHOOT_AIR,          -1,                         -1)
    Character.edit_action_parameters(ROY, Action.FireFlowerShoot,         File.MARTH_ITEM_SHOOT,              -1,                         -1)
    Character.edit_action_parameters(ROY, Action.FireFlowerShootAir,      File.MARTH_ITEM_SHOOT_AIR,          -1,                         -1)
    Character.edit_action_parameters(ROY, Action.HammerIdle,              File.MARTH_HAMMER_IDLE,             Marth.HAMMER,               -1)
    Character.edit_action_parameters(ROY, Action.HammerWalk,              File.MARTH_HAMMER_MOVE,             Marth.HAMMER,               -1)
    Character.edit_action_parameters(ROY, Action.HammerTurn,              File.MARTH_HAMMER_MOVE,             Marth.HAMMER,               -1)
    Character.edit_action_parameters(ROY, Action.HammerJumpSquat,         File.MARTH_HAMMER_MOVE,             Marth.HAMMER,               -1)
    Character.edit_action_parameters(ROY, Action.HammerAir,               File.MARTH_HAMMER_MOVE,             Marth.HAMMER,               -1)
    Character.edit_action_parameters(ROY, Action.HammerLanding,           File.MARTH_HAMMER_MOVE,             Marth.HAMMER,               -1)
    Character.edit_action_parameters(ROY, Action.ShieldOn,                File.MARTH_SHIELD_ON,               -1,                         -1)
    Character.edit_action_parameters(ROY, Action.ShieldOff,               File.MARTH_SHIELD_OFF,              -1,                         -1)
    Character.edit_action_parameters(ROY, Action.RollF,                   File.MARTH_ROLL_F,                  ROLL_F,                     -1)
    Character.edit_action_parameters(ROY, Action.RollB,                   File.MARTH_ROLL_B,                  ROLL_B,                     -1)
    Character.edit_action_parameters(ROY, Action.ShieldBreak,             File.MARTH_DAMAGE_FLY_TOP,          SHIELD_BREAK,               -1)
    Character.edit_action_parameters(ROY, Action.ShieldBreakFall,         File.MARTH_TUMBLE,                  SPARKLE,                    -1)
    Character.edit_action_parameters(ROY, Action.StunLandD,               File.MARTH_DOWN_BOUNCE_D,           -1,                         -1)
    Character.edit_action_parameters(ROY, Action.StunLandU,               File.MARTH_DOWN_BOUNCE_U,           -1,                         -1)
    Character.edit_action_parameters(ROY, Action.StunStartD,              File.MARTH_DOWN_STAND_D,            -1,                         -1)
    Character.edit_action_parameters(ROY, Action.StunStartU,              File.MARTH_DOWN_STAND_U,            -1,                         -1)
    Character.edit_action_parameters(ROY, Action.Stun,                    File.MARTH_STUN,                    STUN,                       -1)
    Character.edit_action_parameters(ROY, Action.Sleep,                   File.MARTH_STUN,                    ASLEEP,                     -1)
    Character.edit_action_parameters(ROY, Action.Grab,                    File.MARTH_GRAB,                    GRAB,                       -1)
    Character.edit_action_parameters(ROY, Action.GrabPull,                File.MARTH_GRAB_PULL,               -1,                         -1)
    Character.edit_action_parameters(ROY, Action.ThrowF,                  File.MARTH_THROW_F,                 THROW_F,                    -1)
    Character.edit_action_parameters(ROY, Action.ThrowB,                  File.MARTH_THROW_B,                 THROW_B,                    -1)
    Character.edit_action_parameters(ROY, Action.CapturePulled,           File.MARTH_CAPTURE_PULLED,          DMG_1,                      -1)
    Character.edit_action_parameters(ROY, Action.InhalePulled,            File.MARTH_TUMBLE,                  DMG_1,                      -1)
    Character.edit_action_parameters(ROY, Action.InhaleSpat,              File.MARTH_TUMBLE,                  -1,                         -1)
    Character.edit_action_parameters(ROY, Action.InhaleCopied,            File.MARTH_TUMBLE,                  -1,                         -1)
    Character.edit_action_parameters(ROY, Action.EggLayPulled,            File.MARTH_CAPTURE_PULLED,          DMG_1,                      -1)
    Character.edit_action_parameters(ROY, Action.EggLay,                  File.MARTH_IDLE,                    -1,                         -1)
    Character.edit_action_parameters(ROY, Action.FalconDivePulled,        File.MARTH_DAMAGE_HIGH_3,           FALCON_DIVE_PULLED,         -1)
    Character.edit_action_parameters(ROY, 0x0B4,                          File.MARTH_TUMBLE,                  UNKNOWN_0B4,                -1)
    Character.edit_action_parameters(ROY, Action.ThrownDKPulled,          File.MARTH_THROWN_DK_PULLED,        DMG_1,                      -1)
    Character.edit_action_parameters(ROY, Action.ThrownMarioBros,         File.MARTH_THROWN_MARIO_BROS,       DMG_1,                      -1)
    Character.edit_action_parameters(ROY, 0x0B7,                          -1,                                 -1,                         -1)
    Character.edit_action_parameters(ROY, Action.ThrownDK,                File.MARTH_THROWN_DK,               DMG_1,                      -1)
    Character.edit_action_parameters(ROY, Action.Thrown1,                 File.MARTH_THROWN_1,                DMG_1,                      -1)
    Character.edit_action_parameters(ROY, Action.Thrown2,                 File.MARTH_THROWN_2,                DMG_1,                      -1)
    Character.edit_action_parameters(ROY, Action.Thrown3,                 -1,                                 -1,                         -1)
    Character.edit_action_parameters(ROY, 0x0BC,                          -1,                                 -1,                         -1)
    Character.edit_action_parameters(ROY, Action.Taunt,                   File.ROY_TAUNT,                     TAUNT,                      -1)
    Character.edit_action_parameters(ROY, Action.Jab1,                    File.ROY_JAB_1,                     JAB_1,                      -1)
    Character.edit_action_parameters(ROY, Action.Jab2,                    0,                                  0x80000000,                 0)
    Character.edit_action_parameters(ROY, Action.DashAttack,              File.ROY_DASH_ATTACK,               DASH_ATTACK,                -1)
    Character.edit_action_parameters(ROY, Action.FTiltHigh,               0,                                  0x80000000,                 0)
    Character.edit_action_parameters(ROY, Action.FTiltMidHigh,            0,                                  0x80000000,                 0)
    Character.edit_action_parameters(ROY, Action.FTilt,                   File.MARTH_F_TILT,                  F_TILT,                     -1)
    Character.edit_action_parameters(ROY, Action.FTiltMidLow,             0,                                  0x80000000,                 0)
    Character.edit_action_parameters(ROY, Action.FTiltLow,                0,                                  0x80000000,                 0)
    Character.edit_action_parameters(ROY, Action.UTilt,                   File.ROY_U_TILT,                    U_TILT,                     -1)
    Character.edit_action_parameters(ROY, Action.DTilt,                   File.MARTH_D_TILT,                  D_TILT,                     -1)
    Character.edit_action_parameters(ROY, Action.FSmashHigh,              0,                                  0x80000000,                 0)
    Character.edit_action_parameters(ROY, Action.FSmashMidHigh,           0,                                  0x80000000,                 0)
    Character.edit_action_parameters(ROY, Action.FSmash,                  File.MARTH_F_SMASH,                 F_SMASH,                    -1)
    Character.edit_action_parameters(ROY, Action.FSmashMidLow,            0,                                  0x80000000,                 0)
    Character.edit_action_parameters(ROY, Action.FSmashLow,               0,                                  0x80000000,                 0)
    Character.edit_action_parameters(ROY, Action.USmash,                  File.MARTH_U_SMASH,                 U_SMASH,                    0)
    Character.edit_action_parameters(ROY, Action.DSmash,                  File.MARTH_D_SMASH,                 D_SMASH,                    -1)
    Character.edit_action_parameters(ROY, Action.AttackAirN,              File.MARTH_ATTACK_AIR_N,            ATTACK_AIR_N,               -1)
    Character.edit_action_parameters(ROY, Action.AttackAirF,              File.MARTH_ATTACK_AIR_F,            ATTACK_AIR_F,               -1)
    Character.edit_action_parameters(ROY, Action.AttackAirB,              File.MARTH_ATTACK_AIR_B,            ATTACK_AIR_B,               -1)
    Character.edit_action_parameters(ROY, Action.AttackAirU,              File.MARTH_ATTACK_AIR_U,            ATTACK_AIR_U,               -1)
    Character.edit_action_parameters(ROY, Action.AttackAirD,              File.MARTH_ATTACK_AIR_D,            ATTACK_AIR_D,               -1)
    Character.edit_action_parameters(ROY, Action.LandingAirN,             -1,                                 -1,                         -1)
    Character.edit_action_parameters(ROY, Action.LandingAirF,             File.MARTH_LANDING_AIR_F,           -1,                         -1)
    Character.edit_action_parameters(ROY, Action.LandingAirB,             File.MARTH_LANDING_AIR_B,           -1,                         -1)
    Character.edit_action_parameters(ROY, Action.LandingAirU,             -1,                                 -1,                         -1)
    Character.edit_action_parameters(ROY, Action.LandingAirD,             -1,                                 -1,                         -1)
    Character.edit_action_parameters(ROY, Action.LandingAirX,             File.MARTH_LANDING,                 -1,                         -1)
    Character.edit_action_parameters(ROY, Action.Entry_R,                 File.MARTH_ENTRY,                   ENTRY,                      0x40000000)
    Character.edit_action_parameters(ROY, Action.Entry_L,                 File.MARTH_ENTRY,                   ENTRY,                      0x40000000)
    Character.edit_action_parameters(ROY, Action.USPG,                    File.MARTH_USP_GROUND,              USP,                        0)
    Character.edit_action_parameters(ROY, Action.USPA,                    File.MARTH_USP_AIR,                 USP,                        0)
    Character.edit_action_parameters(ROY, Action.NSPG_1,                  File.MARTH_NSPG_1,                  NSP_1,                      0)
    Character.edit_action_parameters(ROY, Action.NSPG_2_High,             File.MARTH_NSPG_2_HI,               NSP_2_HIGH,                 0)
    Character.edit_action_parameters(ROY, Action.NSPG_2_Mid,              File.MARTH_NSPG_2,                  NSP_2,                      0)
    Character.edit_action_parameters(ROY, Action.NSPG_2_Low,              File.MARTH_NSPG_2_LO,               NSP_2_LOW,                  0)
    Character.edit_action_parameters(ROY, Action.NSPG_3_High,             File.MARTH_NSPG_3_HI,               NSP_3_HIGH,                 0x40000000)
    Character.edit_action_parameters(ROY, Action.NSPG_3_Mid,              File.MARTH_NSPG_3,                  NSP_3,                      0x40000000)
    Character.edit_action_parameters(ROY, Action.NSPG_3_Low,              File.MARTH_NSPG_3_LO,               NSP_3_LOW,                  0x40000000)
    Character.edit_action_parameters(ROY, Action.NSPA_1,                  File.MARTH_NSPA_1,                  NSP_1,                      0)
    Character.edit_action_parameters(ROY, Action.NSPA_2_High,             File.MARTH_NSPA_2_HI,               NSP_2_HIGH,                 0)
    Character.edit_action_parameters(ROY, Action.NSPA_2_Mid,              File.MARTH_NSPA_2,                  NSP_2,                      0)
    Character.edit_action_parameters(ROY, Action.NSPA_2_Low,              File.MARTH_NSPA_2_LO,               NSP_2_LOW,                  0)
    Character.edit_action_parameters(ROY, Action.NSPA_3_High,             File.MARTH_NSPA_3_HI,               NSP_3_HIGH,                 0)
    Character.edit_action_parameters(ROY, Action.NSPA_3_Mid,              File.MARTH_NSPA_3,                  NSP_3,                      0)
    Character.edit_action_parameters(ROY, Action.NSPA_3_Low,              File.MARTH_NSPA_3_LO,               NSP_3_LOW,                  0)
    Character.edit_action_parameters(ROY, 0x0EE,                          0,                                  0x80000000,                 0)

    // Modify Actions            // Action              // Staling ID   // Main ASM                 // Interrupt/Other ASM          // Movement/Physics ASM         // Collision ASM
    Character.edit_action(ROY, Action.Entry_R,        0,              0x8013DA94,                 0,                              0x8013DB2C,                     0x800DE348)
    Character.edit_action(ROY, Action.Entry_L,        0,              0x8013DA94,                 0,                              0x8013DB2C,                     0x800DE348)
    Character.edit_action(ROY, Action.USPG,           0x11,           MarthUSP.main_,             MarthUSP.change_direction_,     MarthUSP.physics_,              MarthUSP.collision_)
    Character.edit_action(ROY, Action.USPA,           0x11,           MarthUSP.main_,             MarthUSP.change_direction_,     MarthUSP.physics_,              MarthUSP.collision_)
    Character.edit_action(ROY, Action.NSPG_1,         0x12,           MarthNSP.ground_main_,      0,                              0x800D8CCC,                     MarthNSP.ground_collision_)
    Character.edit_action(ROY, Action.NSPG_2_High,    0x12,           MarthNSP.ground_main_,      0,                              0x800D8CCC,                     MarthNSP.ground_collision_)
    Character.edit_action(ROY, Action.NSPG_2_Mid,     0x12,           MarthNSP.ground_main_,      0,                              0x800D8CCC,                     MarthNSP.ground_collision_)
    Character.edit_action(ROY, Action.NSPG_2_Low,     0x12,           MarthNSP.ground_main_,      0,                              0x800D8CCC,                     MarthNSP.ground_collision_)
    Character.edit_action(ROY, Action.NSPG_3_High,    0x12,           MarthNSP.ground_main_,      0,                              0x800D8CCC,                     MarthNSP.ground_collision_)
    Character.edit_action(ROY, Action.NSPG_3_Mid,     0x12,           MarthNSP.ground_main_,      0,                              0x800D8CCC,                     MarthNSP.ground_collision_)
    Character.edit_action(ROY, Action.NSPG_3_Low,     0x12,           MarthNSP.ground_main_,      0,                              0x800D8CCC,                     MarthNSP.ground_collision_)
    Character.edit_action(ROY, Action.NSPA_1,         0x12,           MarthNSP.air_main_,         0,                              0x800D91EC,                     MarthNSP.air_collision_)
    Character.edit_action(ROY, Action.NSPA_2_High,    0x12,           MarthNSP.air_main_,         0,                              0x800D91EC,                     MarthNSP.air_collision_)
    Character.edit_action(ROY, Action.NSPA_2_Mid,     0x12,           MarthNSP.air_main_,         0,                              0x800D91EC,                     MarthNSP.air_collision_)
    Character.edit_action(ROY, Action.NSPA_2_Low,     0x12,           MarthNSP.air_main_,         0,                              0x800D91EC,                     MarthNSP.air_collision_)
    Character.edit_action(ROY, Action.NSPA_3_High,    0x12,           MarthNSP.air_main_,         0,                              0x800D91EC,                     MarthNSP.air_collision_)
    Character.edit_action(ROY, Action.NSPA_3_Mid,     0x12,           MarthNSP.air_main_,         0,                              0x800D91EC,                     MarthNSP.air_collision_)
    Character.edit_action(ROY, Action.NSPA_3_Low,     0x12,           MarthNSP.air_main_,         0,                              0x800D91EC,                     MarthNSP.air_collision_)

    // Modify Menu Action Parameters             // Action      // Animation                // Moveset Data             // Flags
    // TODO: add game over and continue
    Character.edit_menu_action_parameters(ROY, 0x0,           File.MARTH_MENU_IDLE,       IDLE,                       -1)
    Character.edit_menu_action_parameters(ROY, 0x1,           File.ROY_VICTORY_1,         VICTORY_1,                  -1)
    Character.edit_menu_action_parameters(ROY, 0x2,           File.ROY_VICTORY_2,         VICTORY_2,                  -1)
    Character.edit_menu_action_parameters(ROY, 0x3,           File.ROY_VICTORY_3,         VICTORY_3,                  -1)
    Character.edit_menu_action_parameters(ROY, 0x4,           File.ROY_VICTORY_1,         SELECT,                     -1)
    Character.edit_menu_action_parameters(ROY, 0x5,           File.MARTH_CLAP,            CLAP,                       -1)
    Character.edit_menu_action_parameters(ROY, 0x9,           File.MARTH_GAME_OVER,       -1,                         -1)
    Character.edit_menu_action_parameters(ROY, 0xA,           File.MARTH_GAME_CONTINUE,   -1,                         -1)
    Character.edit_menu_action_parameters(ROY, 0xD,           File.ROY_1P_POSE,           0x80000000,                 -1)
    Character.edit_menu_action_parameters(ROY, 0xE,           File.MARTH_POSE_1P_CPU,     0x80000000,                 -1)

    // Add Action Parameters                // Action Name      // Base Action  // Animation                // Moveset Data             // Flags
    Character.add_new_action_params(ROY,  DSP_Ground_Begin,   -1,             File.ROY_DSPG_BEGIN,      DSP_BEGIN,                  0)
    Character.add_new_action_params(ROY,  DSP_Ground_Wait,    -1,             File.ROY_DSPG_WAIT,       DSP_WAIT,                   0)
    Character.add_new_action_params(ROY,  DSP_Ground_End,     -1,             File.ROY_DSPG_END,        DSP_END,                    0)
    Character.add_new_action_params(ROY,  DSP_Ground_Strong_End,     -1,      File.ROY_DSPG_END,        DSP_END_STRONG,             0)
    Character.add_new_action_params(ROY,  DSP_Air_Begin,      -1,             File.ROY_DSPA_BEGIN,      DSP_BEGIN,                  0)
    Character.add_new_action_params(ROY,  DSP_Air_Wait,       -1,             File.ROY_DSPA_WAIT,       DSP_WAIT,                   0)
    Character.add_new_action_params(ROY,  DSP_Air_End,        -1,             File.ROY_DSPA_END,        DSP_END,                    0)
    Character.add_new_action_params(ROY,  DSP_Air_Strong_End,        -1,      File.ROY_DSPA_END,        DSP_END_STRONG,             0)

    // Add Actions                  // Action Name      // Base Action  //Parameters                        // Staling ID   // Main ASM                     // Interrupt/Other ASM          // Movement/Physics ASM             // Collision ASM
    Character.add_new_action(ROY, DSP_Ground_Begin,   -1,             ActionParams.DSP_Ground_Begin,      0x1E,           RoyDSP.ground_begin_main_,    0,                              0x800D8BB4,                         RoyDSP.ground_collision_)
    Character.add_new_action(ROY, DSP_Ground_Wait,    -1,             ActionParams.DSP_Ground_Wait,       0x1E,           RoyDSP.ground_wait_main_,     0,                              0x800D8BB4,                         RoyDSP.ground_collision_)
    Character.add_new_action(ROY, DSP_Ground_End,     -1,             ActionParams.DSP_Ground_End,        0x1E,           RoyDSP.end_main_,             0,                              0x800D8BB4,                         RoyDSP.ground_collision_)
    Character.add_new_action(ROY, DSP_Ground_Strong_End,-1,           ActionParams.DSP_Ground_Strong_End, 0x1E,           RoyDSP.end_main_,             0,                              0x800D8BB4,                         RoyDSP.ground_collision_)
    Character.add_new_action(ROY, DSP_Air_Begin,      -1,             ActionParams.DSP_Air_Begin,         0x1E,           RoyDSP.air_begin_main_,       0,                              0x800D90E0,                         RoyDSP.air_collision_)
    Character.add_new_action(ROY, DSP_Air_Wait,       -1,             ActionParams.DSP_Air_Wait,          0x1E,           RoyDSP.air_wait_main_,        0,                              0x800D90E0,                         RoyDSP.air_collision_)
    Character.add_new_action(ROY, DSP_Air_End,        -1,             ActionParams.DSP_Air_End,           0x1E,           RoyDSP.end_main_,             0,                              0x800D91EC,                         RoyDSP.air_collision_)
    Character.add_new_action(ROY, DSP_Air_Strong_End, -1,             ActionParams.DSP_Air_Strong_End,    0x1E,           RoyDSP.end_main_,             0,                              0x800D91EC,                         RoyDSP.air_collision_)

    Character.table_patch_start(air_nsp, Character.id.ROY, 0x4)
    dw      MarthNSP.air_1_initial_
    OS.patch_end()
    Character.table_patch_start(ground_nsp, Character.id.ROY, 0x4)
    dw      MarthNSP.ground_1_initial_
    OS.patch_end()
    Character.table_patch_start(air_usp, Character.id.ROY, 0x4)
    dw      MarthUSP.air_initial_
    OS.patch_end()
    Character.table_patch_start(ground_usp, Character.id.ROY, 0x4)
    dw      MarthUSP.ground_initial_
    OS.patch_end()
    Character.table_patch_start(air_dsp, Character.id.ROY, 0x4)
    dw      RoyDSP.air_begin_initial_
    OS.patch_end()
    Character.table_patch_start(ground_dsp, Character.id.ROY, 0x4)
    dw      RoyDSP.ground_begin_initial_
    OS.patch_end()

    // Use Mario's initial/grounded script.
    Character.table_patch_start(initial_script, Character.id.ROY, 0x4)
    dw 0x800D7DCC
    OS.patch_end()
    Character.table_patch_start(grounded_script, Character.id.ROY, 0x4)
    dw 0x800DE428
    OS.patch_end()

    // Set menu zoom size.
    Character.table_patch_start(menu_zoom, Character.id.ROY, 0x4)
    float32 0.93
    OS.patch_end()

    // Set crowd chant FGM.
    Character.table_patch_start(crowd_chant_fgm, Character.id.ROY, 0x2)
    dh  0x05AA
    OS.patch_end()

    // Set Kirby hat_id
    Character.table_patch_start(kirby_inhale_struct, 0x2, Character.id.ROY, 0xC)
    dh 0x2C
    OS.patch_end()

    // Set default costumes
    Character.set_default_costumes(Character.id.ROY, 0, 1, 2, 3, 1, 3, 2)
    Teams.add_team_costume(YELLOW, ROY, 0x4)

    // Shield colors for costume matching
    Character.set_costume_shield_colors(ROY, BLUE, RED, GREEN, BLUE, YELLOW, BLACK, NA, NA)

    // Set action strings
    Character.table_patch_start(action_string, Character.id.ROY, 0x4)
    dw  Action.action_string_table
    OS.patch_end()

    // Set Magnifying Glass Scale Override
    Character.table_patch_start(magnifying_glass_zoom, Character.id.ROY, 0x2)
    dh  0x0068
    OS.patch_end()

    // Allows Roy to use his entry which is similar to Link
    Character.table_patch_start(entry_action, Character.id.ROY, 0x8)
    dw 0xDC, 0xDD
    OS.patch_end()
    Character.table_patch_start(entry_script, Character.id.ROY, 0x4)
    dw roy_entry_routine_
    OS.patch_end()

    // Set Remix 1P ending music
    Character.table_patch_start(remix_1p_end_bgm, Character.id.ROY, 0x2)
    dh {MIDI.id.FE_MEDLEY}
    OS.patch_end()

    // Set 1P Victory Image
    SinglePlayer.set_ending_image(Character.id.ROY, File.ROY_VICTORY_IMAGE_BOTTOM)

    OS.align(4)
    // charged smash attack frame data
    charge_smash_frames:
    db 7        // forward
    db 7        // up
    db 3        // down
    db 0        // unused

    // Set Charge Smash attacks entry
    ChargeSmashAttacks.set_charged_smash_attacks(Character.id.ROY, charge_smash_frames)

    // Set CPU SD prevent routine
    Character.table_patch_start(ai_attack_prevent, Character.id.ROY, 0x4)
    dw      AI.PREVENT_ATTACK.ROUTINE.MARIO
    OS.patch_end()

    // @ Description
    // Entry routine for Roy. Sets the correct facing direction and then jumps to Link's entry routine.
    scope roy_entry_routine_: {
        lw      a1, 0x0B1C(s0)              // a1 = direction
        addiu   at, r0,-0x0001              // at = -1 (left)
        beql    a1, at, _end                // branch if direction = left...
        sw      v1, 0x0B24(s0)              // ...and enable reversed direction flag

        _end:
        j       0x8013DCCC                  // jump to Link's entry routine to load entry object
        nop
    }
}
