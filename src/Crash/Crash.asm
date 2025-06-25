// Crash.asm

// This file contains file inclusions, action edits, and assembly for Crash Bandicoot.

scope Crash {

    scope MODEL {

        scope JAW { // special part
            constant DEFAULT(0xA0580000)
            constant BIG(0xA0580001)
            constant BIGGER(0xA0580002)
            constant TONGUE(0xA0580003)
        }

        scope EYES {    // texture
            constant DEFAULT(0xAC000000)
            constant LOOK_R(0xAC000001)
            constant LOOK_L(0xAC000002)
            constant CRAZY(0xAC000003)
            constant LOOK_UP(0xAC000004)
            constant BLINK(0xAC000005)
            constant WORRIED(0xAC000006)
        }

        scope MOUTH {   // texture
            constant DEFAULT(0xAC100000)
            constant GRIN(0xAC100001)
            constant OPEN_GRIN(0xAC100002)
            constant HALF_GRIN(0xAC100003)
            constant OPEN(0xAC100004)
            constant SAD(0xAC100005)
            constant BIG_FROWN(0xAC100006)
        }
    }

    // @ Description
    // Crash's extra actions
    scope Action {
        constant Jab3(0x0DC)
        constant Entry_R(0x0DD)
        constant Entry_L(0x0DE)
        constant NSPG(0x0DF)
        constant NSPA(0x0E0)
        constant NSPGBlocked(0x0E1)
        constant NSPABlocked(0x0E2)

        // strings!
        string_0x0DC:; String.insert("Jab3")
        string_0x0DD:; String.insert("")
        string_0x0DE:; String.insert("")
        string_0x0DF:; String.insert("SpinGround")
        string_0x0E0:; String.insert("SpinAir")
        string_0x0E1:; String.insert("SpinBlockedGround")
        string_0x0E2:; String.insert("SpinBlockedAir")
        string_0x0E5:; String.insert("DigginItBegin")
        string_0x0E6:; String.insert("DigginIt")
        string_0x0E7:; String.insert("DigginItTurn")
        string_0x0E8:; String.insert("DigginItEnd")
        string_0x0E9:; String.insert("DigginItDive")
        string_0x0EA:; String.insert("DigginItAirDive")
        string_0x0EB:; String.insert("BellyFlopGround")
        string_0x0EC:; String.insert("BellyFlopAir")
        string_0x0ED:; String.insert("BellyFlopLanding")

        action_string_table:
        dw string_0x0DC
        dw 0
        dw 0
        dw string_0x0DF
        dw string_0x0E0
        dw string_0x0E1
        dw string_0x0E2
        dw 0
        dw 0
        dw string_0x0E5
        dw string_0x0E6
        dw string_0x0E7
        dw string_0x0E8
        dw string_0x0E9
        dw string_0x0EA
        dw string_0x0EB
        dw string_0x0EC
        dw string_0x0ED
    }

    // Insert AI attack options
    // AI stuff, doing this with a new method.
    include "AI/Attacks.asm"

    insert SHOW_MODEL,"moveset/SHOW_MODEL.bin"
    // Subroutine for enabling spin hurtboxes
    SPIN_HURTBOX_ON:
    dw 0x7C280000, 0x00000014, 0x000001A4, 0x01E001A4 // set body hurtbox properties
    dw 0x70400003   // left shoulder intangible
    //dw 0x70480003   // left wrist intangible
    dw 0x70580003   // head intangible
    dw 0x70900003   // right shoulder intangible
    //dw 0x70980003   // right wrist intangible
    dw 0x70B80003   // left thigh intangible
    dw 0x70C00003   // left shin intangible
    dw 0x70E00003   // right thigh intangible
    dw 0x70E80003   // right shin intangible
    Moveset.RETURN()
    // Subroutine for enabling dig hurtboxes
    DIG_HURTBOX_ON:
    dw 0x7C280000, 0x00000064, 0x00140118, 0x01180050 // set body hurtbox properties
    dw 0x70400003   // left shoulder intangible
    dw 0x70480003   // left wrist intangible
    dw 0x70580003   // head intangible
    dw 0x70900003   // right shoulder intangible
    dw 0x70980003   // right wrist intangible
    dw 0x70B80003   // left thigh intangible
    dw 0x70C00003   // left shin intangible
    dw 0x70E00003   // right thigh intangible
    dw 0x70E80003   // right shin intangible
    Moveset.RETURN()
    // Subroutine for disabling spin hurtboxes
    SPIN_HURTBOX_OFF:
    dw 0xA4000000   // unknown
    dw 0x78000000   // reset hurtbox sizes?
    dw 0x6C000001   // set all hurtboxes to vulernable
    Moveset.RETURN()


    CSS:
    Moveset.WAIT(7);
    dw MODEL.EYES.LOOK_UP;
    Moveset.WAIT(5);
    dw 0x3800002B
    dw MODEL.JAW.BIG;
    dw MODEL.MOUTH.GRIN;
    dw MODEL.EYES.DEFAULT;
    Moveset.WAIT(28);
    dw MODEL.EYES.LOOK_UP;
    Moveset.WAIT(7);
    dw 0x3800002B
    dw MODEL.EYES.DEFAULT;
    Moveset.WAIT(13);
    dw MODEL.EYES.BLINK;
    Moveset.WAIT(9);
    dw MODEL.EYES.DEFAULT;
    Moveset.WAIT(17);
    dw MODEL.JAW.BIGGER;
    dw MODEL.EYES.CRAZY;
    dw MODEL.MOUTH.OPEN_GRIN;
    dw 0xA0500001
    dw 0xA0A00001
    Moveset.WAIT(4);
    dw 0x3800002A
    Moveset.WAIT(12);
    dw 0x3800002A
    Moveset.WAIT(12);
    dw 0x3800002A
    Moveset.WAIT(10);
    dw MODEL.EYES.DEFAULT;
    Moveset.WAIT(11);
    dw MODEL.EYES.CRAZY;
    dw 0x3800002A
    Moveset.WAIT(12);
    dw 0x3800002A
    Moveset.WAIT(9);
    dw 0x3800002A
    Moveset.WAIT(19);
    dw MODEL.JAW.DEFAULT;
    dw MODEL.EYES.BLINK;
    dw 0xA0500000
    dw 0xA0A00000
    Moveset.WAIT(7);
    dw 0x3800006E
    dw MODEL.EYES.LOOK_UP;
    Moveset.WAIT(25);
    dw 0x3800006E
    Moveset.WAIT(15);
    dw 0x3800006E
    Moveset.WAIT(22);
    dw 0x3800006E
    Moveset.WAIT(16);
    dw 0x3800006E
    Moveset.WAIT(20);
    dw MODEL.JAW.BIGGER;
    dw MODEL.EYES.CRAZY;
    dw MODEL.MOUTH.OPEN_GRIN;
    dw 0x3800002B
    dw 0x00000000

    VICTORY1:
    Moveset.WAIT(9);
    dw MODEL.JAW.BIG;
    dw MODEL.EYES.LOOK_L;
    dw MODEL.MOUTH.HALF_GRIN;
    Moveset.WAIT(21);
    dw MODEL.EYES.BLINK;
    Moveset.WAIT(4);
    dw MODEL.EYES.LOOK_L;
    Moveset.WAIT(22);
    dw MODEL.EYES.DEFAULT;
    Moveset.WAIT(6);
    dw MODEL.EYES.LOOK_R;
    Moveset.WAIT(22);
    dw MODEL.EYES.BLINK;
    Moveset.WAIT(6);
    dw MODEL.EYES.LOOK_R;
    Moveset.WAIT(14);
    dw MODEL.EYES.BLINK;
    Moveset.WAIT(5);
    dw MODEL.EYES.DEFAULT;
    dw 0xD0013F8E;
    Moveset.GO_TO(CSS + 0xC);
    

    IDLE:
    Moveset.SLOPE_CONTOUR(3);
    Moveset.WAIT(136);  // FRAME 86
    dw MODEL.EYES.BLINK; Moveset.WAIT(3); dw MODEL.EYES.DEFAULT; // he blinks
    Moveset.WAIT(172 - 86 - 3);  // FRAME 172

    dw MODEL.EYES.LOOK_R;
    Moveset.WAIT(14)
    dw MODEL.EYES.BLINK; Moveset.WAIT(3); dw MODEL.EYES.LOOK_R; // he blinks
    Moveset.WAIT(84 - 14 - 3);   // FRAME 256

    dw MODEL.EYES.DEFAULT;
    Moveset.WAIT(47);   // FRAME 303
    dw MODEL.EYES.LOOK_L;
    Moveset.WAIT(8);
    dw MODEL.EYES.DEFAULT;
    Moveset.WAIT(10);
    dw MODEL.EYES.LOOK_L;
    Moveset.WAIT(12)
    dw MODEL.EYES.BLINK; Moveset.WAIT(3); dw MODEL.EYES.LOOK_L; // he blinks
    Moveset.WAIT(111 - 8 - 10 - 12 - 3);

    dw MODEL.EYES.DEFAULT;// FRAME 414
    Moveset.WAIT(1);
    Moveset.GO_TO(IDLE);

	PIPEENTER:
	dw MODEL.JAW.BIG;
    dw MODEL.MOUTH.GRIN;
	Moveset.AFTER(8)
	Moveset.HURTBOXES(3)
	dw 0

    VICTORY3:
    dw 0x480005A0;
    dw 0xA1000000;
    dw MODEL.JAW.TONGUE
    dw MODEL.EYES.BLINK
    dw MODEL.MOUTH.OPEN
    Moveset.WAIT(60);
    dw MODEL.MOUTH.DEFAULT
    Moveset.WAIT(60);
    dw MODEL.MOUTH.OPEN
    Moveset.WAIT(60);
    dw MODEL.MOUTH.DEFAULT
    Moveset.WAIT(60);
    dw MODEL.MOUTH.OPEN
    Moveset.WAIT(60);
    dw MODEL.MOUTH.DEFAULT
    Moveset.WAIT(60);
    dw MODEL.MOUTH.OPEN
    dw 0x00000000

    POSE_1P:
    dw 0x0A0A00001; // open hand
    dw 0xA0500001; // open hand
    dw MODEL.MOUTH.SAD;
    dw MODEL.EYES.WORRIED;
    dw 0

    TAUNT:
    dw MODEL.MOUTH.HALF_GRIN;
    Moveset.WAIT(23);
    dw 0xA1000000;
    dw 0x3800002B;
    dw MODEL.JAW.BIGGER;
    dw MODEL.MOUTH.OPEN_GRIN;
    dw MODEL.EYES.CRAZY;
    Moveset.WAIT(30 - 23);
    dw 0x4400059F;
    dw 0x74000002;
    Moveset.WAIT(50 - 30);
    dw 0x74000001;
    Moveset.WAIT(85 - 50);
    dw MODEL.JAW.DEFAULT;
    dw MODEL.EYES.WORRIED;
    dw MODEL.MOUTH.SAD;
    Moveset.WAIT(100 - 85);
    dw MODEL.EYES.BLINK;
    Moveset.WAIT(114 - 100);
    dw MODEL.EYES.DEFAULT;
    dw MODEL.MOUTH.DEFAULT;
    dw 0x00000000;

    WALK:
    dw MODEL.MOUTH.HALF_GRIN;
    dw 0;

    // Insert Moveset files

    insert APPEAR, "moveset/APPEAR.bin"
    VICTORY2:; insert "moveset/VICTORY2.bin"
    CLAP:; insert "moveset/CLAP.bin"; Moveset.GO_TO(CLAP)

    insert DASH,"moveset/DASH.bin"
    insert RUN,"moveset/RUN.bin"; Moveset.GO_TO(RUN + 0x14)
    insert TURN,"moveset/TURN.bin"
    insert JUMP, "moveset/JUMP.bin"
    insert JUMPA, "moveset/JUMPA.bin"


    insert DAMAGED_FACE,"moveset/DAMAGED_FACE.bin"
    DMG_1:; Moveset.SUBROUTINE(DAMAGED_FACE); dw 0
    DMG_2:; Moveset.SUBROUTINE(DAMAGED_FACE); Moveset.GO_TO_FILE(0x758); dw 0
    FALCON_DIVE_PULLED:; Moveset.SUBROUTINE(DAMAGED_FACE); Moveset.GO_TO_FILE(0x6F0); dw 0

    DOWNBOUNCE:; insert "moveset/DOWNBOUNCE.bin"
    DOWNATTACK_D:; insert "moveset/DOWNATTACK_D.bin"
    DOWNATTACK_U:; insert "moveset/DOWNATTACK_U.bin"

    insert GRAB_RELEASE_DATA,"moveset/GRAB_RELEASE_DATA.bin"
    GRAB:; Moveset.THROW_DATA(GRAB_RELEASE_DATA); insert "moveset/GRAB.bin"
    insert THROW_F_DATA,"moveset/THROW_F_DATA.bin"
    THROW_F:; Moveset.THROW_DATA(THROW_F_DATA); insert "moveset/THROW_F.bin"
    insert THROW_B_DATA, "moveset/THROW_B_DATA.bin"
    THROW_B:; Moveset.THROW_DATA(THROW_B_DATA); insert "moveset/THROW_B.bin"

    JAB:; insert "moveset/JAB.bin"
    DASH_ATTACK:; insert "moveset/DASH_ATTACK.bin"
    insert JAB_2,"moveset/NEUTRAL2.bin"
    FTILT:; insert "moveset/FTILT.bin"
    UTILT:; insert "moveset/UTILT.bin"
    DTILT:; insert "moveset/DTILT.bin"
    FSMASH:; insert "moveset/FSMASH.bin"
    USMASH:; insert "moveset/USMASH.bin"
    DSMASH:; insert "moveset/DSMASH.bin"

    ATTACK_AIR_N:; insert "moveset/ATTACK_AIR_N.bin"
    ATTACK_AIR_F:; insert "moveset/ATTACK_AIR_F.bin"
    ATTACK_AIR_B:; insert "moveset/ATTACK_AIR_B.bin"
    ATTACK_AIR_U:; insert "moveset/ATTACK_AIR_U.bin"
    ATTACK_AIR_D:; insert "moveset/ATTACK_AIR_D.bin"

    HAMMER:; dw 0xC4000007; dw 0xBC000004; dw 0xA0580001; dw 0xAC000003; dw 0xAC100001; Moveset.SUBROUTINE(Moveset.shared.HAMMER); dw 0x04000010; dw 0x18000000; Moveset.GO_TO(HAMMER)

    NSP:; Moveset.CONCURRENT_STREAM(NSP_CONCURRENT); insert "moveset/NSP.bin"
    NSP_CONCURRENT:
    dw 0xA8000000; dw 0xA0280001                    // show spin model
    Moveset.SUBROUTINE(SPIN_HURTBOX_ON)             // enable spin hurtboxes
    Moveset.AFTER(22)                               // after 22 frames
    Moveset.SUBROUTINE(SHOW_MODEL)                  // show full model
    Moveset.SUBROUTINE(SPIN_HURTBOX_OFF)            // disable spin hurtboxes
    dw 0
    NSP_BLOCKED:; insert "moveset/NSP_BLOCKED.bin"

    USP:; insert "moveset/USP.bin"
    USP_LOOP:; insert "moveset/USP_LOOP.bin"; Moveset.GO_TO(USP_LOOP)               // loops
    USP_LANDING:; insert "moveset/USP_LANDING.bin"

    DSP_BEGIN:; insert "moveset/DSP_BEGIN.bin"

    DSP:
    Moveset.HIDE_ITEM();                            // hide held item
    dw 0xA8000000                                   // hide model
    Moveset.SUBROUTINE(DIG_HURTBOX_ON)              // enable dig hurtboxes
    dw 0
    DSP_TURN:
    Moveset.HIDE_ITEM();                            // hide held item
    dw 0xA8000000                                   // hide model
    Moveset.SUBROUTINE(DIG_HURTBOX_ON)              // enable dig hurtboxes
    Moveset.WAIT(4)                                 // wait 4 frames
    Moveset.SET_FLAG(1)                             // set temp variable 2
    dw 0

    DSP_END:; Moveset.SUBROUTINE(SHOW_MODEL); insert "moveset/DSP_END.bin"

    DSP_DIVE:; insert "moveset/DSP_DIVE.bin"

    CLIFF_ATTACK_QUICK_2:; insert "moveset/CLIFF_ATTACK_QUICK_2.bin"
    CLIFF_ATTACK_SLOW_2:; insert "moveset/CLIFF_ATTACK_SLOW_2.bin"
    insert CLIFF_CATCH, "moveset/CLIFF_CATCH.bin"
    insert CLIFF_WAIT, "moveset/CLIFF_WAIT.bin"
    insert CLIFF_ESCAPE_S2, "moveset/CLIFF_ESCAPE_S2.bin"
    insert GETUP_ROLL,"moveset/GETUP_ROLL.bin"
    insert TECH_ROLL,"moveset/TECH_ROLL.bin"
    insert TECH,"moveset/TECH.bin"

    insert SPARKLE,"moveset/SPARKLE.bin"; Moveset.GO_TO(SPARKLE)                    // loops
    insert SHIELD_BREAK,"moveset/SHIELD_BREAK.bin"; Moveset.GO_TO(SPARKLE)          // loops
    insert STUN,"moveset/STUN.bin"; Moveset.GO_TO(STUN)                            // loops
    insert SLEEP,"moveset/SLEEP.bin"; Moveset.GO_TO(SLEEP)                          // loops


    // Modify Action Parameters             // Action                       // Animation                    // Moveset Data             // Flags
    Character.edit_action_parameters(CRASH, Action.DeadU,                   File.CRASH_TUMBLE,              DMG_1,                         -1)
    Character.edit_action_parameters(CRASH, Action.ScreenKO,                File.CRASH_TUMBLE,              DMG_1,                         -1)
    Character.edit_action_parameters(CRASH, Action.Entry,                   File.CRASH_IDLE,                IDLE,                       -1)
    Character.edit_action_parameters(CRASH, 0x006,                          File.CRASH_IDLE,                IDLE,                       -1)
    Character.edit_action_parameters(CRASH, Action.Revive1,                 File.CRASH_DOWN_BOUNCE_D,       -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.Revive2,                 File.CRASH_DOWN_STAND_D,        -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.ReviveWait,              File.CRASH_IDLE,                IDLE,                       -1)
    Character.edit_action_parameters(CRASH, Action.Idle,                    File.CRASH_IDLE,                IDLE,                       -1)
    Character.edit_action_parameters(CRASH, Action.Walk1,                   File.CRASH_WALK1,               -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.Walk2,                   File.CRASH_WALK2,               WALK,                       -1)
    Character.edit_action_parameters(CRASH, Action.Walk3,                   File.CRASH_WALK3,               WALK,                       -1)
    Character.edit_action_parameters(CRASH, 0x00E,                          File.CRASH_WALK_END,            -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.Dash,                    File.CRASH_DASH,                DASH,                       -1)
    Character.edit_action_parameters(CRASH, Action.Run,                     File.CRASH_RUN,                 RUN,                        -1)
    Character.edit_action_parameters(CRASH, Action.RunBrake,                File.CRASH_RUN_BRAKE,           -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.Turn,                    File.CRASH_TURN,                -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.TurnRun,                 File.CRASH_TURN_RUN,            -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.JumpSquat,               File.CRASH_LANDING,             -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.ShieldJumpSquat,         File.CRASH_LANDING,             -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.JumpF,                   File.CRASH_JUMP_F,              JUMP,                       -1)
    Character.edit_action_parameters(CRASH, Action.JumpB,                   File.CRASH_JUMP_B,              JUMP,                       -1)
    Character.edit_action_parameters(CRASH, Action.JumpAerialF,             File.CRASH_JUMP_AERIAL_F,       JUMPA,                      -1)
    Character.edit_action_parameters(CRASH, Action.JumpAerialB,             File.CRASH_JUMP_AERIAL_B,       JUMPA,                      -1)
    Character.edit_action_parameters(CRASH, Action.Fall,                    File.CRASH_FALL,                -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.FallAerial,              File.CRASH_FALL_AERIAL,         -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.Crouch,                  File.CRASH_CROUCH,              -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.CrouchIdle,              File.CRASH_CROUCH_IDLE,         -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.CrouchEnd,               File.CRASH_CROUCH_END,          -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.LandingLight,            File.CRASH_LANDING,             -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.LandingHeavy,            File.CRASH_LANDING,             -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.Pass,                    File.CRASH_SHIELD_DROP,         -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.ShieldDrop,              File.CRASH_SHIELD_DROP,         -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.Teeter,                  File.CRASH_TEETER,              -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.TeeterStart,             File.CRASH_TEETER_START,        -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.DamageHigh1,             File.CRASH_DAMAGE_HIGH1,        DMG_1,                      -1)
    Character.edit_action_parameters(CRASH, Action.DamageHigh2,             File.CRASH_DAMAGE_HIGH2,        DMG_1,                      -1)
    Character.edit_action_parameters(CRASH, Action.DamageHigh3,             File.CRASH_DAMAGE_HIGH3,        DMG_1,                      -1)
    Character.edit_action_parameters(CRASH, Action.DamageMid1,              File.CRASH_DAMAGE_MID1,         DMG_1,                      -1)
    Character.edit_action_parameters(CRASH, Action.DamageMid2,              File.CRASH_DAMAGE_MID2,         DMG_1,                      -1)
    Character.edit_action_parameters(CRASH, Action.DamageMid3,              File.CRASH_DAMAGE_MID3,         DMG_1,                      -1)
    Character.edit_action_parameters(CRASH, Action.DamageLow1,              File.CRASH_DAMAGE_LOW1,         DMG_1,                      -1)
    Character.edit_action_parameters(CRASH, Action.DamageLow2,              File.CRASH_DAMAGE_LOW2,         DMG_1,                      -1)
    Character.edit_action_parameters(CRASH, Action.DamageLow3,              File.CRASH_DAMAGE_LOW3,         DMG_1,                      -1)
    Character.edit_action_parameters(CRASH, Action.DamageAir1,              File.CRASH_DAMAGE_AIR1,         DMG_1,                      -1)
    Character.edit_action_parameters(CRASH, Action.DamageAir2,              File.CRASH_DAMAGE_AIR2,         DMG_1,                      -1)
    Character.edit_action_parameters(CRASH, Action.DamageAir3,              File.CRASH_DAMAGE_AIR3,         DMG_1,                      -1)
    Character.edit_action_parameters(CRASH, Action.DamageElec1,             File.CRASH_DAMAGE_ELEC,         DMG_1,                      -1)
    Character.edit_action_parameters(CRASH, Action.DamageElec2,             File.CRASH_DAMAGE_ELEC,         DMG_1,                      -1)
    Character.edit_action_parameters(CRASH, Action.DamageFlyHigh,           File.CRASH_DAMAGE_FLY_HIGH,     DMG_2,                      -1)
    Character.edit_action_parameters(CRASH, Action.DamageFlyMid,            File.CRASH_DAMAGE_FLY_MID,      DMG_2,                      -1)
    Character.edit_action_parameters(CRASH, Action.DamageFlyLow,            File.CRASH_DAMAGE_FLY_LOW,      DMG_2,                      -1)
    Character.edit_action_parameters(CRASH, Action.DamageFlyTop,            File.CRASH_DAMAGE_FLY_TOP,      DMG_2,                      -1)
    Character.edit_action_parameters(CRASH, Action.DamageFlyRoll,           File.CRASH_DAMAGE_FLY_ROLL,     DMG_2,                      -1)
    Character.edit_action_parameters(CRASH, Action.WallBounce,              File.CRASH_TUMBLE,              DMG_1,                      -1)
    Character.edit_action_parameters(CRASH, Action.Tumble,                  File.CRASH_TUMBLE,              DMG_1,                      -1)
    Character.edit_action_parameters(CRASH, Action.FallSpecial,             File.CRASH_FALL_SPECIAL,        -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.LandingSpecial,          File.CRASH_LANDING,             -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.Tornado,                 File.CRASH_TUMBLE,              -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.EnterPipe,               File.CRASH_ENTER_PIPE,          PIPEENTER,                  -1)
    Character.edit_action_parameters(CRASH, Action.ExitPipe,                File.CRASH_EXIT_PIPE,           -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.ExitPipeWalk,            File.CRASH_EXIT_PIPE_WALK,      -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.CeilingBonk,             File.CRASH_CEILING_BONK,        -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.DownBounceD,             File.CRASH_DOWN_BOUNCE_D,       DOWNBOUNCE,                 -1)
    Character.edit_action_parameters(CRASH, Action.DownBounceU,             File.CRASH_DOWN_BOUNCE_U,       DOWNBOUNCE,                 -1)
    Character.edit_action_parameters(CRASH, Action.DownStandD,              File.CRASH_DOWN_STAND_D,        -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.DownStandU,              File.CRASH_DOWN_STAND_U,        -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.TechF,                   File.CRASH_TECH_F,              TECH_ROLL,                  -1)
    Character.edit_action_parameters(CRASH, Action.TechB,                   File.CRASH_TECH_B,              TECH_ROLL,                  -1)
    Character.edit_action_parameters(CRASH, Action.DownForwardD,            File.CRASH_DOWN_FORWARD_D,      GETUP_ROLL,                 -1)
    Character.edit_action_parameters(CRASH, Action.DownForwardU,            File.CRASH_DOWN_FORWARD_U,      GETUP_ROLL,                 -1)
    Character.edit_action_parameters(CRASH, Action.DownBackD,               File.CRASH_DOWN_BACK_D,         GETUP_ROLL,                 -1)
    Character.edit_action_parameters(CRASH, Action.DownBackU,               File.CRASH_DOWN_BACK_U,         GETUP_ROLL,                 -1)
    Character.edit_action_parameters(CRASH, Action.DownAttackD,             File.CRASH_DOWN_ATK_D,          DOWNATTACK_D,               -1)
    Character.edit_action_parameters(CRASH, Action.DownAttackU,             File.CRASH_DOWN_ATK_U,          DOWNATTACK_U,               -1)
    Character.edit_action_parameters(CRASH, Action.Tech,                    File.CRASH_TECH,                TECH,                       -1)
    Character.edit_action_parameters(CRASH, Action.ClangRecoil,             File.CRASH_CLANG_RECOIL,        -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.CliffCatch,              File.CRASH_CLF_CATCH,           CLIFF_CATCH,                -1)
    Character.edit_action_parameters(CRASH, Action.CliffWait,               File.CRASH_CLF_WAIT,            CLIFF_WAIT,                 -1)
    Character.edit_action_parameters(CRASH, Action.CliffQuick,              File.CRASH_CLF_Q,               -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.CliffClimbQuick1,        File.CRASH_CLF_CLM_Q1,          -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.CliffClimbQuick2,        File.CRASH_CLF_CLM_Q2,          -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.CliffSlow,               File.CRASH_CLF_S,               -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.CliffClimbSlow1,         File.CRASH_CLF_CLM_S1,          -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.CliffClimbSlow2,         File.CRASH_CLF_CLM_S2,          -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.CliffAttackQuick1,       File.CRASH_CLF_ATK_Q1,          -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.CliffAttackQuick2,       File.CRASH_CLF_ATK_Q2,          CLIFF_ATTACK_QUICK_2,       -1)
    Character.edit_action_parameters(CRASH, Action.CliffAttackSlow1,        File.CRASH_CLF_ATK_S1,          -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.CliffAttackSlow2,        File.CRASH_CLF_ATK_S2,          CLIFF_ATTACK_SLOW_2,        -1)
    Character.edit_action_parameters(CRASH, Action.CliffEscapeQuick1,       File.CRASH_CLF_ESC_Q1,          -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.CliffEscapeQuick2,       File.CRASH_CLF_ESC_Q2,          -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.CliffEscapeSlow1,        File.CRASH_CLF_ESC_S1,          -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.CliffEscapeSlow2,        File.CRASH_CLF_ESC_S2,          CLIFF_ESCAPE_S2,            -1)
    Character.edit_action_parameters(CRASH, Action.LightItemPickup,         File.CRASH_L_ITM_PICKUP,        -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.HeavyItemPickup,         File.CRASH_H_ITM_PICKUP,        -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.ItemDrop,                File.CRASH_ITM_DROP,            -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.ItemThrowDash,           File.CRASH_ITM_THROW_DASH,      -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.ItemThrowF,              File.CRASH_ITM_THROW_F,         -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.ItemThrowB,              File.CRASH_ITM_THROW_F,         -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.ItemThrowU,              File.CRASH_ITM_THROW_U,         -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.ItemThrowD,              File.CRASH_ITM_THROW_D,         -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.ItemThrowSmashF,         File.CRASH_ITM_THROW_F,         -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.ItemThrowSmashB,         File.CRASH_ITM_THROW_F,         -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.ItemThrowSmashU,         File.CRASH_ITM_THROW_U,         -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.ItemThrowSmashD,         File.CRASH_ITM_THROW_D,         -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.ItemThrowAirF,           File.CRASH_ITM_THROW_AIR_F,     -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.ItemThrowAirB,           File.CRASH_ITM_THROW_AIR_F,     -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.ItemThrowAirU,           File.CRASH_ITM_THROW_AIR_U,     -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.ItemThrowAirD,           File.CRASH_ITM_THROW_AIR_D,     -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.ItemThrowAirSmashF,      File.CRASH_ITM_THROW_AIR_F,     -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.ItemThrowAirSmashB,      File.CRASH_ITM_THROW_AIR_F,     -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.ItemThrowAirSmashU,      File.CRASH_ITM_THROW_AIR_U,     -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.ItemThrowAirSmashD,      File.CRASH_ITM_THROW_AIR_D,     -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.HeavyItemThrowF,         File.CRASH_H_ITM_THROW,         -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.HeavyItemThrowB,         File.CRASH_H_ITM_THROW,         -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.HeavyItemThrowSmashF,    File.CRASH_H_ITM_THROW,         -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.HeavyItemThrowSmashB,    File.CRASH_H_ITM_THROW,         -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.BeamSwordNeutral,        File.CRASH_ITM_JAB,             -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.BeamSwordTilt,           File.CRASH_ITM_TILT,            -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.BeamSwordSmash,          File.CRASH_ITM_SMASH,           -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.BeamSwordDash,           File.CRASH_ITM_DASH,            -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.BatNeutral,              File.CRASH_ITM_JAB,             -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.BatTilt,                 File.CRASH_ITM_TILT,            -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.BatSmash,                File.CRASH_ITM_SMASH,           -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.BatDash,                 File.CRASH_ITM_DASH,            -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.FanNeutral,              File.CRASH_ITM_JAB,             -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.FanTilt,                 File.CRASH_ITM_TILT,            -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.FanSmash,                File.CRASH_ITM_SMASH,           -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.FanDash,                 File.CRASH_ITM_DASH,            -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.StarRodNeutral,          File.CRASH_ITM_JAB,             -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.StarRodTilt,             File.CRASH_ITM_TILT,            -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.StarRodSmash,            File.CRASH_ITM_SMASH,           -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.StarRodDash,             File.CRASH_ITM_DASH,            -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.RayGunShoot,             File.CRASH_ITM_SHOOT,           -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.RayGunShootAir,          File.CRASH_ITM_SHOOT_AIR,       -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.FireFlowerShoot,         File.CRASH_ITM_SHOOT,           -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.FireFlowerShootAir,      File.CRASH_ITM_SHOOT_AIR,       -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.HammerIdle,              File.CRASH_HAMMER_IDLE,         HAMMER,                     -1)
    Character.edit_action_parameters(CRASH, Action.HammerWalk,              File.CRASH_HAMMER_WALK,         HAMMER,                     -1)
    Character.edit_action_parameters(CRASH, Action.HammerTurn,              File.CRASH_HAMMER_WALK,         HAMMER,                     -1)
    Character.edit_action_parameters(CRASH, Action.HammerJumpSquat,         File.CRASH_HAMMER_WALK,         HAMMER,                     -1)
    Character.edit_action_parameters(CRASH, Action.HammerAir,               File.CRASH_HAMMER_WALK,         HAMMER,                     -1)
    Character.edit_action_parameters(CRASH, Action.HammerLanding,           File.CRASH_HAMMER_WALK,         HAMMER,                     -1)
    Character.edit_action_parameters(CRASH, Action.ShieldOn,                File.CRASH_SHIELD_ON,           -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.ShieldOff,               File.CRASH_SHIELD_OFF,          -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.RollF,                   File.CRASH_ROLL_F,              -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.RollB,                   File.CRASH_ROLL_B,              -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.ShieldBreak,             File.CRASH_DAMAGE_FLY_TOP,      SHIELD_BREAK,               -1)
    Character.edit_action_parameters(CRASH, Action.ShieldBreakFall,         File.CRASH_TUMBLE,              -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.StunLandD,               File.CRASH_DOWN_BOUNCE_D,       -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.StunLandU,               File.CRASH_DOWN_BOUNCE_U,       -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.StunStartD,              File.CRASH_DOWN_STAND_D,        -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.StunStartU,              File.CRASH_DOWN_STAND_U,        -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.Stun,                    File.CRASH_STUN,                STUN,                       -1)
    Character.edit_action_parameters(CRASH, Action.Sleep,                   File.CRASH_STUN,                SLEEP,                      -1)
    Character.edit_action_parameters(CRASH, Action.Grab,                    File.CRASH_GRAB,                GRAB,                       -1)
    Character.edit_action_parameters(CRASH, Action.GrabPull,                File.CRASH_GRAB_PULL,           -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.ThrowF,                  File.CRASH_THROW_F,             THROW_F,                    0x50000000)
    Character.edit_action_parameters(CRASH, Action.ThrowB,                  File.CRASH_THROW_B,             THROW_B,                    -1)
    Character.edit_action_parameters(CRASH, Action.CapturePulled,           File.CRASH_CAPTURE_PULLED,      DMG_1,                      -1)
    Character.edit_action_parameters(CRASH, Action.InhalePulled,            File.CRASH_TUMBLE,              DMG_1,                      -1)
    Character.edit_action_parameters(CRASH, Action.InhaleSpat,              File.CRASH_TUMBLE,              -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.InhaleCopied,            File.CRASH_TUMBLE,              -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.EggLayPulled,            File.CRASH_CAPTURE_PULLED,      DMG_1,                      -1)
    Character.edit_action_parameters(CRASH, Action.EggLay,                  File.CRASH_IDLE,                IDLE,                       -1)
    Character.edit_action_parameters(CRASH, Action.FalconDivePulled,        File.CRASH_DAMAGE_HIGH3,        -1,                         -1)
    Character.edit_action_parameters(CRASH, 0x0B4,                          File.CRASH_TUMBLE,              -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.ThrownDKPulled,          File.CRASH_THROWN_DK_PULLED,    DMG_1,                      -1)
    Character.edit_action_parameters(CRASH, Action.ThrownMarioBros,         File.CRASH_THROWN_MARIO_BROS,   DMG_1,                      -1)
    Character.edit_action_parameters(CRASH, Action.ThrownDK,                File.CRASH_THROWN_DK,           DMG_1,                      -1)
    Character.edit_action_parameters(CRASH, Action.Thrown1,                 File.CRASH_THROWN1,             DMG_1,                      -1)
    Character.edit_action_parameters(CRASH, Action.Thrown2,                 File.CRASH_THROWN2,             DMG_1,                      -1)
    Character.edit_action_parameters(CRASH, Action.Taunt,                   File.CRASH_TAUNT,               TAUNT,                      0x10000000)
    Character.edit_action_parameters(CRASH, Action.Jab1,                    File.CRASH_JAB1,                JAB,                        -1)
    Character.edit_action_parameters(CRASH, Action.Jab2,                    0,                              0x80000000,                 0)
    Character.edit_action_parameters(CRASH, Action.DashAttack,              File.CRASH_DASH_ATTACK,         DASH_ATTACK,                -1)
    Character.edit_action_parameters(CRASH, Action.FTiltHigh,               File.CRASH_F_TILT_HIGH,         FTILT,                      -1)
    Character.edit_action_parameters(CRASH, Action.FTilt,                   File.CRASH_F_TILT,              FTILT,                      -1)
    Character.edit_action_parameters(CRASH, Action.FTiltLow,                File.CRASH_F_TILT_LOW,          FTILT,                      -1)
    Character.edit_action_parameters(CRASH, Action.UTilt,                   File.CRASH_U_TILT,              UTILT,                      0)
    Character.edit_action_parameters(CRASH, Action.DTilt,                   File.CRASH_D_TILT,              DTILT,                      0)
    Character.edit_action_parameters(CRASH, Action.FSmashHigh,              0,                              0x80000000,                 0)
    Character.edit_action_parameters(CRASH, Action.FSmashMidHigh,           0,                              0x80000000,                 0)
    Character.edit_action_parameters(CRASH, Action.FSmash,                  File.CRASH_F_SMASH,             FSMASH,                     0x40000000)
    Character.edit_action_parameters(CRASH, Action.FSmashMidLow,            0,                              0x80000000,                 0)
    Character.edit_action_parameters(CRASH, Action.FSmashLow,               0,                              0x80000000,                 0)
    Character.edit_action_parameters(CRASH, Action.USmash,                  File.CRASH_U_SMASH,             USMASH,                     -1)
    Character.edit_action_parameters(CRASH, Action.DSmash,                  File.CRASH_D_SMASH,             DSMASH,                     -1)
    Character.edit_action_parameters(CRASH, Action.AttackAirN,              File.CRASH_ATTACK_AIR_N,        ATTACK_AIR_N,               -1)
    Character.edit_action_parameters(CRASH, Action.AttackAirF,              File.CRASH_ATTACK_AIR_F,        ATTACK_AIR_F,               -1)
    Character.edit_action_parameters(CRASH, Action.AttackAirB,              File.CRASH_ATTACK_AIR_B,        ATTACK_AIR_B,               -1)
    Character.edit_action_parameters(CRASH, Action.AttackAirU,              File.CRASH_ATTACK_AIR_U,        ATTACK_AIR_U,               -1)
    Character.edit_action_parameters(CRASH, Action.AttackAirD,              File.CRASH_ATTACK_AIR_D,        ATTACK_AIR_D,               0)
    Character.edit_action_parameters(CRASH, Action.LandingAirF,             File.CRASH_LANDING_AIR_F,       -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.LandingAirB,             File.CRASH_LANDING_AIR_B,       -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.LandingAirU,             File.CRASH_LANDING_AIR_U,       -1,                         -1)
    Character.edit_action_parameters(CRASH, Action.LandingAirX,             File.CRASH_LANDING,             -1,                         -1)
    Character.edit_action_parameters(CRASH, 0xDC,                           0,                              0x80000000,                 0)
    Character.edit_action_parameters(CRASH, 0xDE,                           File.CRASH_APPEAR_L,            APPEAR,                     -1)
    Character.edit_action_parameters(CRASH, 0xDD,                           File.CRASH_APPEAR_R,            APPEAR,                     -1)
    Character.edit_action_parameters(CRASH, Action.NSPG,                    File.CRASH_NSPG,                NSP,                        0)
    Character.edit_action_parameters(CRASH, Action.NSPA,                    File.CRASH_NSPA,                NSP,                        0)
    Character.edit_action_parameters(CRASH, Action.NSPGBlocked,             File.CRASH_NSPG_BLOCKED,        NSP_BLOCKED,                0)
    Character.edit_action_parameters(CRASH, Action.NSPABlocked,             File.CRASH_NSPA_BLOCKED,        NSP_BLOCKED,                0)

    // Modify Actions               // Action           // Staling ID   // Main ASM                 // Interrupt/Other ASM      // Movement/Physics ASM         // Collision ASM
    Character.edit_action(CRASH,    Action.NSPG,        0x12,           CrashNSP.ground_main_,      0,                          CrashNSP.ground_physics_,       CrashNSP.ground_collision_)
    Character.edit_action(CRASH,    Action.NSPA,        0x12,           CrashNSP.air_main_,         0,                          CrashNSP.air_physics_,          CrashNSP.air_collision_)
    Character.edit_action(CRASH,    Action.NSPGBlocked, 0x12,           CrashNSP.blocked_main_,     0,                          0x800D8BB4,                     CrashNSP.blocked_ground_collision_)
    Character.edit_action(CRASH,    Action.NSPABlocked, 0x12,           CrashNSP.blocked_main_,     0,                          CrashNSP.blocked_air_physics_,  CrashNSP.blocked_air_collision_)

    // Add Action Parameters                // Action Name      // Base Action  // Animation                // Moveset Data             // Flags
    Character.add_new_action_params(CRASH,  DSPBegin,           -1,             File.CRASH_DSP_BEGIN,       DSP_BEGIN,                  0)
    Character.add_new_action_params(CRASH,  DSPWait,            -1,             File.CRASH_DSP_WAIT,        DSP,                        0)
    Character.add_new_action_params(CRASH,  DSPTurn,            -1,             File.CRASH_DSP_TURN,        DSP_TURN,                   0)
    Character.add_new_action_params(CRASH,  DSPEnd,             -1,             File.CRASH_DSP_ATTACK,      DSP_END,                    0)
    Character.add_new_action_params(CRASH,  DSPDive,            -1,             File.CRASH_DSP_PLATFORM,    DSP_DIVE,                   0)
    Character.add_new_action_params(CRASH,  DSPAirDive,         -1,             File.CRASH_DSP_AIR_DIVE,    DSP_DIVE,                   0)
    Character.add_new_action_params(CRASH,  USPG,               -1,             File.CRASH_USPG,            USP,                        0)
    Character.add_new_action_params(CRASH,  USPA,               -1,             File.CRASH_USPG,            USP,                        0)
    Character.add_new_action_params(CRASH,  USPLanding,         -1,             File.CRASH_USPLanding,      USP_LANDING,                0)

    // Add Actions                  // Action Name      // Base Action  //Parameters                    // Staling ID   // Main ASM                     // Interrupt/Other ASM          // Movement/Physics ASM             // Collision ASM
    Character.add_new_action(CRASH, DSPBegin,           -1,             ActionParams.DSPBegin,          0x1E,           CrashDSP.begin_main_,           0,                              0x800D8BB4,                         0x800DDF44)
    Character.add_new_action(CRASH, DSPWait,            -1,             ActionParams.DSPWait,           0x1E,           CrashDSP.wait_main_,            0,                              CrashDSP.physics_,                  CrashDSP.collision_)
    Character.add_new_action(CRASH, DSPTurn,            -1,             ActionParams.DSPTurn,           0x1E,           CrashDSP.turn_main_,            0,                              CrashDSP.physics_,                  CrashDSP.collision_)
    Character.add_new_action(CRASH, DSPEnd,             -1,             ActionParams.DSPEnd,            0x1E,           0x800D94E8,                     0,                              0x800D90E0,                         0x80156358)
    Character.add_new_action(CRASH, DSPDive,            -1,             ActionParams.DSPDive,           0x1E,           CrashDSP.dive_main_,            0,                              CrashDSP.dive_physics_,             CrashDSP.dive_collision_)
    Character.add_new_action(CRASH, DSPAirDive,         -1,             ActionParams.DSPAirDive,        0x1E,           CrashDSP.dive_main_,            0,                              CrashDSP.dive_air_physics_,         CrashDSP.dive_collision_)
    Character.add_new_action(CRASH, USPG,               -1,             ActionParams.USPG,              0x11,           CrashUSP.main_,                 CrashUSP.change_direction_,     CrashUSP.physics_,                  CrashUSP.collision_)
    Character.add_new_action(CRASH, USPA,               -1,             ActionParams.USPA,              0x11,           CrashUSP.main_,                 CrashUSP.change_direction_,     CrashUSP.physics_,                  CrashUSP.collision_)
    Character.add_new_action(CRASH, USPLanding,         -1,             ActionParams.USPLanding,        0x11,           0x800D94C4,                     0,                              0x800D8BB4,                         0x800DDEE8)


    // Modify Menu Action Parameters              // Action // Animation                // Moveset Data             // Flags
    Character.edit_menu_action_parameters(CRASH,  0x0,      File.CRASH_IDLE,            IDLE,                       -1)
    Character.edit_menu_action_parameters(CRASH,  0x1,      File.CRASH_VICTORY_1,       VICTORY1,                   -1)
    Character.edit_menu_action_parameters(CRASH,  0x2,      File.CRASH_VICTORY_2,       VICTORY2,                   -1)
    Character.edit_menu_action_parameters(CRASH,  0x3,      File.CRASH_VICTORY_3,       VICTORY3,                   0x10000000)
    Character.edit_menu_action_parameters(CRASH,  0x4,      File.CRASH_CSS,             CSS,                        -1)
    Character.edit_menu_action_parameters(CRASH,  0x5,      File.CRASH_CLAP,            CLAP,                       -1)
    Character.edit_menu_action_parameters(CRASH,  0x9,      File.CRASH_CONTINUE_FALL,   -1,                         -1)
    Character.edit_menu_action_parameters(CRASH,  0xA,      File.CRASH_CONTINUE_UP,     -1,                         -1)
    Character.edit_menu_action_parameters(CRASH,  0xD,      File.CRASH_1P_POSE,         POSE_1P,                    -1)
    Character.edit_menu_action_parameters(CRASH,  0xE,      File.CRASH_CPU_POSE,        -1,                         -1)

    Character.table_patch_start(ground_nsp, Character.id.CRASH, 0x4)
    dw      CrashNSP.ground_initial_
    OS.patch_end()
    Character.table_patch_start(air_nsp, Character.id.CRASH, 0x4)
    dw      CrashNSP.air_initial_
    OS.patch_end()
    Character.table_patch_start(ground_usp, Character.id.CRASH, 0x4)
    dw      CrashUSP.ground_initial_
    OS.patch_end()
    Character.table_patch_start(air_usp, Character.id.CRASH, 0x4)
    dw      CrashUSP.air_initial_
    OS.patch_end()
    Character.table_patch_start(ground_dsp, Character.id.CRASH, 0x4)
    dw      CrashDSP.initial_
    OS.patch_end()
    Character.table_patch_start(air_dsp, Character.id.CRASH, 0x4)
    dw      CrashDSP.dive_air_initial_
    OS.patch_end()

    // Set menu zoom size.
    Character.table_patch_start(menu_zoom, Character.id.CRASH, 0x4)
    float32 1.1
    OS.patch_end()

    // Set Kirby hat_id
    Character.table_patch_start(kirby_inhale_struct, 0x2, Character.id.CRASH, 0xC)
    dh 0x2A
    OS.patch_end()

    // Set crowd chant FGM.
    Character.table_patch_start(crowd_chant_fgm, Character.id.CRASH, 0x2)
    dh  0x05D7
    OS.patch_end()

    // Set action strings
    Character.table_patch_start(action_string, Character.id.CRASH, 0x4)
    dw  Action.action_string_table
    OS.patch_end()

    // Set default costumes
    Character.set_default_costumes(Character.id.CRASH, 0, 1, 2, 3, 1, 3, 2)
    Teams.add_team_costume(YELLOW, CRASH, 4)

    // Shield colors for costume matching
    Character.set_costume_shield_colors(CRASH, RED, RED, GREEN, BLUE, YELLOW, BLACK, ORANGE, NA)

    // Allows Crash to use his entry which is based on Samus
    Character.table_patch_start(entry_action, Character.id.CRASH, 0x8)
    dw 0xDD, 0xDE
    OS.patch_end()
    Character.table_patch_start(entry_script, Character.id.CRASH, 0x4)
    dw 0x8013DCBC       // Samus's entry routine
    OS.patch_end()

    // Set Remix 1P ending music
    Character.table_patch_start(remix_1p_end_bgm, Character.id.CRASH, 0x2)
    dh {MIDI.id.NSANITYBEACH}
    OS.patch_end()

    // Set 1P Victory Image
    SinglePlayer.set_ending_image(Character.id.CRASH, File.CRASH_VICTORY_IMAGE_BOTTOM)

    OS.align(4)
    // charged smash attack frame data
    charge_smash_frames:
    db 7        // forward
    db 2        // up
    db 4        // down
    db 0        // unused

    // Set Charge Smash attacks entry
    ChargeSmashAttacks.set_charged_smash_attacks(Character.id.CRASH, charge_smash_frames)

    // Set CPU SD prevent routine
    Character.table_patch_start(ai_attack_prevent, Character.id.CRASH, 0x4)
    dw      AI.PREVENT_ATTACK.ROUTINE.CRASH
    OS.patch_end()

    // @Description
    // Custom dair bounce function for Crash
    scope dair_bounce_: {
        OS.patch_start(0xCB32C, 0x801508EC)
        j       dair_bounce_
        lw      v1, 0x0008(v0)              // v1 = character id (original line 2)
        _return:
        OS.patch_end()

        lli     at, Character.id.NCRASH     // check if stinky crash
        beq     at, v1, _crash_behaviour        // do special crash scrimblo function
        nop
        lli     at, Character.id.CRASH
        bne     at, v1, _original           // skip if character != Crash
        nop

        // if the character is Crash, do custom DAir bounce behaviour
        // v0 = player struct
        _crash_behaviour:
        lbu     t7, 0x018D(v0)              // ~
        andi    t7, t7, 0xFFF7              // ~
        sb      t7, 0x018D(v0)              // disable fast fall flag
        lui     at, 0x4248                  // ~
        sw      at, 0x004C(v0)              // set y velocity to 50
        lli     a1, Action.AttackAirD       // a1 (action) = AttackAirD
        lui     a2, 0x420C                  // a2 (starting frame) = 35
        lui     a3, 0x3F80                  // a3 (fsm) = 1
        jal     0x800E6F24                  // change action
        sw      r0, 0x0010(sp)              // argument 4 = 0

        // end the function now
        lw      ra, 0x001C(sp)              // load ra
        jr      ra                          // return
        addiu   sp, sp, 0x0028              // deallocate stack space


        _original:
        j       _return                     // continue original function
        lli     at, 0x0005                  // original line 1
    }

    // Makes a sound when crash consumes an item
    scope crash_eat_sfx: {
        OS.patch_start(0xC0684, 0x80145C44)
        j       crash_eat_sfx
        sw      a3, 0x001C (sp)         // og line 2
        _return:
        OS.patch_end()

        lw      t7, 0x0008(a3)          // t7 = fighter id
        addiu   at, r0, Character.id.CRASH
        bne     at, t7, _original
        nop
        addiu   sp, sp, -0x10           // allocate sp
        sw      a1, 0x0008(sp)          // store healing amount
        // play Crash FGM if here
        FGM.play(0x5BF)

        lw      a1, 0x0008(sp)          // restore healing amount
        addiu   sp, sp, 0x10            // deallocate sp
        lw      a0, 0x001C(sp)          // restore a0

        _original:
        jal     0x800EA3D4              // og line 1
        nop
        j       _return
        nop
    }
}
