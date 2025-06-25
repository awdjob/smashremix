// Lanky.asm

// This file contains file inclusions, action edits, and assembly for the one and only Lanky Kong.

scope Lanky {
    // Model Commands
    scope MODEL {
        scope WEAPON {
            constant HIDE(0xA097FFFF)
            constant SHOW(0xA0900000)
        }
        scope HAND_L {
            constant DEFAULT(0xA0500000)
            constant CLOSED(0xA0500001)
        }
        scope HAND_R {
            constant DEFAULT(0xA0880000)
            constant CLOSED(0xA0880001)
        }
        scope HEAD {
            constant DEFAULT(0xA0600000)
            constant OPEN_MOUTH(0xA0600001)
            constant INFLATED(0xA0600002)
            constant DAMAGE(0xA0600003)
        }
        scope EYES {
            constant DEFAULT(0xAC000000)
            constant DAMAGE(0xAC000001)
        }
    }

    // @ Description
    // Lanky's extra actions
    scope Action {
        constant Jab3(0x0DC)
        constant EntryR(0x0DD)
        constant EntryL(0x0DE)
        constant NSPG(0x0DF)
        constant NSPA(0x0E0)

        // strings!
        string_0x0DC:; String.insert("Jab3")
        string_0x0DD:; String.insert("")
        string_0x0DE:; String.insert("")
        string_0x0DF:; String.insert("GrapeShooterGround")
        string_0x0E0:; String.insert("GrapeShooterAir")
        string_0x0E5:; String.insert("BaboonBalloonBeginGround")
        string_0x0E6:; String.insert("BaboonBalloonBeginAir")
        string_0x0E7:; String.insert("BaboonBalloonMove")
        string_0x0E8:; String.insert("BaboonBalloonTurn")
        string_0x0E9:; String.insert("BaboonBalloonEnd")
        string_0x0EA:; String.insert("BaboonBalloonDamage")
        string_0x0EB:; String.insert("OrangStandBeginGround")
        string_0x0EC:; String.insert("OrangStandWaitGround")
        string_0x0ED:; String.insert("OrangStandEndGround")
        string_0x0EE:; String.insert("OrangStandCancelGround")
        string_0x0EF:; String.insert("OrangStandTurn")
        string_0x0F0:; String.insert("OrangStandMove")
        string_0x0F1:; String.insert("OrangStandTaunt")
        string_0x0F2:; String.insert("OrangStandLanding")
        string_0x0F3:; String.insert("OrangStandJumpSquat")
        string_0x0F4:; String.insert("OrangStandJump")
        string_0x0F5:; String.insert("OrangStandPlatDrop")
        string_0x0F6:; String.insert("OrangStandBeginAir")
        string_0x0F7:; String.insert("OrangStandWaitAir")
        string_0x0F8:; String.insert("OrangStandEndAir")
        string_0x0F9:; String.insert("OrangStandCancelAir")

        action_string_table:
        dw string_0x0DC
        dw 0
        dw 0
        dw string_0x0DF
        dw string_0x0E0
        dw 0
        dw 0
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
        dw string_0x0EE
        dw string_0x0EF
        dw string_0x0F0
        dw string_0x0F1
        dw string_0x0F2
        dw string_0x0F3
        dw string_0x0F4
        dw string_0x0F5
        dw string_0x0F6
        dw string_0x0F7
        dw string_0x0F8
        dw string_0x0F9
    }

    // Insert AI attack options
    include "AI/Attacks.asm"

    // Insert Moveset files

	CSS:
	Moveset.WAIT(6)
	Moveset.VOICE(1510)
	dw 0

	IDLE:
    Moveset.SLOPE_CONTOUR(3)                        // slope contour
	dw 0

    insert DAMAGED_FACE,"moveset/DAMAGED_FACE.bin"
    DMG_1:; Moveset.SUBROUTINE(DAMAGED_FACE); dw 0
    DMG_2:; Moveset.SUBROUTINE(DAMAGED_FACE); Moveset.GO_TO_FILE(0x758); dw 0
    FALCON_DIVE_PULLED:; Moveset.SUBROUTINE(DAMAGED_FACE); Moveset.GO_TO_FILE(0x6F0); dw 0

    insert TECH_ROLL,"moveset/TECH_ROLL.bin"
    insert TECH,"moveset/TECH.bin"

    insert SPARKLE,"moveset/SPARKLE.bin"; Moveset.GO_TO(SPARKLE)                 // loops
    insert SHIELD_BREAK,"moveset/SHIELD_BREAK.bin"; Moveset.GO_TO(SPARKLE)       // loops
    insert STUN, "moveset/STUN.bin"; Moveset.GO_TO(STUN)                         // loops
    insert SLEEP, "moveset/SLEEP.bin"; Moveset.GO_TO(SLEEP)                      // loops

    DOWN_ATTACK_D:; insert "moveset/DOWN_ATTACK_D.bin"
    DOWN_ATTACK_U:; insert "moveset/DOWN_ATTACK_U.bin"

    CLIFF_ATTACK_QUICK_2:; insert "moveset/CLIFF_ATTACK_QUICK_2.bin"
    CLIFF_ATTACK_SLOW_2:; insert "moveset/CLIFF_ATTACK_SLOW_2.bin"

	TAUNT:
	Moveset.WAIT(16)
    Moveset.CREATE_GFX(0, 13, 0, 0, 0, 0, 0, 0)     // jump smoke gfx
	Moveset.VOICE(1528)
	Moveset.WAIT(44-16)
    Moveset.SFX(77)                                // play land sound
	Moveset.WAIT(54-44)
    Moveset.CREATE_GFX(0, 13, 0, 0, 0, 0, 0, 0)     // jump smoke gfx
	Moveset.VOICE(1528)
	Moveset.WAIT(83-54)
    Moveset.SFX(77)                          // play land sound
	Moveset.WAIT(89-83)
    Moveset.CREATE_GFX(0, 13, 0, 0, 0, 0, 0, 0)     // jump smoke gfx
	Moveset.VOICE(1512)
	Moveset.WAIT(118-89)
    Moveset.SFX(77)
	dw 0

	VICTORY3:
	dw MODEL.HAND_R.CLOSED
	dw MODEL.HAND_L.CLOSED
	dw 0xA0680000
    dw MODEL.HEAD.INFLATED
    Moveset.LOOP(9);
    Moveset.WAIT(30)
    dw 0x98916800, 0x00000000, 0x00000000, 0x000000A0 // music note
    Moveset.END_LOOP();
    Moveset.AFTER(306)
    dw MODEL.HEAD.DEFAULT
	dw 0

	VICTORY2:
	dw 0

    JUMP_VOICE_ARRAY:; dh 1509; dh 1514; dh 1515; OS.align(4)
    JUMP_F:
    Moveset.SFX(94)
    Moveset.RANDOM_SFX(100, 0x1, 0x3, JUMP_VOICE_ARRAY)
    Moveset.CREATE_GFX(0, 13, 0, 0, 0, 0, 0, 0)     // jump smoke gfx
    dw 0

    JUMP_B:
    Moveset.SFX(94)
    Moveset.VOICE(1510)
    Moveset.CREATE_GFX(0, 13, 0, 0, 0, 0, 0, 0)     // jump smoke gfx
    dw 0

    JUMP_AERIAL:
    Moveset.SFX(83)
    Moveset.LOOP(2)
    Moveset.CREATE_GFX(0, 11, 0, 0, 0, 100, 100, 100)   // footstep smoke gfx
    Moveset.WAIT(6)
    Moveset.END_LOOP()
    dw 0

    insert GRAB_RELEASE_DATA,"moveset/GRAB_RELEASE_DATA.bin"
    GRAB:; Moveset.THROW_DATA(GRAB_RELEASE_DATA); insert "moveset/GRAB.bin"
    GRAB_PULL:; insert "moveset/GRAB_PULL.bin"
    insert F_THROW_DATA,"moveset/F_THROW_DATA.bin"
    F_THROW:; Moveset.THROW_DATA(F_THROW_DATA); insert "moveset/F_THROW.bin"
    insert B_THROW_DATA,"moveset/B_THROW_DATA.bin"
    B_THROW:; Moveset.THROW_DATA(B_THROW_DATA); insert "moveset/B_THROW.bin"

    JAB_1:; insert "moveset/JAB_1.bin"
    JAB_2:; insert "moveset/JAB_2.bin"
    JAB_3:; insert "moveset/JAB_3.bin"
    DASH_ATTACK:; insert "moveset/DASH_ATTACK.bin"
    F_TILT_HIGH:; insert "moveset/F_TILT_HIGH.bin"
    F_TILT:; insert "moveset/F_TILT.bin"
    F_TILT_LOW:; insert "moveset/F_TILT_LOW.bin"
    U_TILT:; insert "moveset/U_TILT.bin"
    D_TILT:; insert "moveset/D_TILT.bin"
    F_SMASH_HIGH:; insert "moveset/F_SMASH_HIGH.bin"
    F_SMASH:; insert "moveset/F_SMASH.bin"
    F_SMASH_LOW:; insert "moveset/F_SMASH_LOW.bin"
    U_SMASH:; insert "moveset/U_SMASH.bin"
    D_SMASH:; insert "moveset/D_SMASH.bin"
    ATTACK_AIR_N:; insert "moveset/ATTACK_AIR_N.bin"
    ATTACK_AIR_F:; insert "moveset/ATTACK_AIR_F.bin"
    ATTACK_AIR_B:; insert "moveset/ATTACK_AIR_B.bin"
    ATTACK_AIR_U:; insert "moveset/ATTACK_AIR_U.bin"
    ATTACK_AIR_D:; insert "moveset/ATTACK_AIR_D.bin"

    LANDING_AIR_D:; insert "moveset/LANDING_AIR_D.bin"

    ENTRY:; insert "moveset/ENTRY.bin"

    NSPG:
    dw 0x98004C00, 0x00000000, 0xFF4C0000, 0x00000000
    NSP:
    dw MODEL.WEAPON.SHOW
    Moveset.HIDE_ITEM()
    Moveset.SFX(44)                                 // click
    Moveset.AFTER(4)
    Moveset.VOICE(1516)                             // YEH
    dw MODEL.HEAD.OPEN_MOUTH
    Moveset.AFTER(20)
    Moveset.SET_FLAG(0)                             // spawn projectile
    Moveset.SET_FLAG(1)                             // allow cancel
    Moveset.HURTBOXES(3)                            // intangible
    Moveset.CREATE_GFX(18, 31, 0, -300, 0, 20, 20, 20) // spark on grape shooter
    Moveset.SFX(1520)                               // grape shooter sound
    Moveset.SFX(42)                                 // whoosh sound
    dw MODEL.HEAD.INFLATED
    Moveset.AFTER(22)
    Moveset.HURTBOXES(1)                            // vulnerable
    Moveset.AFTER(28)
    dw MODEL.HEAD.DEFAULT
    Moveset.AFTER(36)
    dw 0x58000000                                   // disallow cancel
    dw 0

    NSPA:
    dw 0x98004000, 0x00000000, 0xFF6A0000, 0x00000000
    Moveset.GO_TO(NSP)

    USP_BEGIN:
    Moveset.WAIT(4)
    dw MODEL.HEAD.INFLATED
    Moveset.SFX(1522)                               // inflate himself
    dw 0x3C0005F5                                   // play FGM but interrupt when action changes
    Moveset.CREATE_GFX(0, 13, 0, 0, 0, 0, 0, 0)     // jump smoke gfx
    Moveset.WAIT(3)
    Moveset.VOICE(1526)                             // WOOHOO
    dw 0

    USP_MOVE:
    dw MODEL.HEAD.INFLATED
    dw 0x7C280000, 0x0000FFCE, 0x000000FA, 0x011800DC // set body hurtbox properties
    dw 0x7C300000, 0x00000014, 0x0000014A, 0x014A014A // set torso hurtbox properties
    dw 0

    USP_END:
    dw MODEL.HEAD.INFLATED
    Moveset.WAIT(4)
    Moveset.SFX(1523)
    Moveset.WAIT(2)
    dw 0x0C01A090, 0x00960000, 0x00000000, 0x5A464003, 0x00020000 // hitbox
    Moveset.LOOP(6)
    Moveset.CREATE_GFX(13, 18, 0, 0, 0, 0, 0, 0)    // smoke trail from mouth
    Moveset.WAIT(2)
    Moveset.END_LOOP()
    Moveset.END_HITBOXES()
    Moveset.WAIT(6)
    dw MODEL.HEAD.OPEN_MOUTH
    dw 0

    USP_CONCURRENT:
    Moveset.CREATE_GFX(13, 18, 0, 0, 0, 0, 0, 0)    // smoke trail from mouth
    Moveset.WAIT(8)
    Moveset.GO_TO(USP_CONCURRENT)                   // loops

    USP_DAMAGE:
    Moveset.CONCURRENT_STREAM(USP_CONCURRENT)
    dw MODEL.HEAD.INFLATED
    dw MODEL.EYES.DAMAGE
    dw 0x3C0005F4                                   // play FGM but interrupt when action changes
    Moveset.GO_TO_FILE(0x758); dw 0

    USP_TURN:
    dw MODEL.HEAD.INFLATED
    dw 0x7C280000, 0x0000FFCE, 0x000000FA, 0x011800DC // set body hurtbox properties
    dw 0x7C300000, 0x00000014, 0x0000014A, 0x014A014A // set torso hurtbox properties
    Moveset.WAIT(4)                                 // wait 4 frames
    Moveset.SET_FLAG(0)                             // set temp variable 1
    dw 0

    FALL_SPECIAL:
    dw MODEL.HEAD.OPEN_MOUTH
    dw 0

    DSPG_BEGIN:
    Moveset.WAIT(3)                                 // wait 3 frames
    Moveset.SFX(116)                                // play footstep sound
    Moveset.WAIT(4)                                 // wait 4 frames
    Moveset.VOICE(1517)                             // HUP
    dw 0

    DSPG_END:
    Moveset.WAIT(8)                                 // wait 8 frames
    Moveset.SFX(77)                                 // play landing sound
    Moveset.CREATE_GFX(0, 11, 0, 0, -60, 0, 0, 0)   // footstep smoke gfx
    dw 0

    DSPA_BEGIN:
    Moveset.WAIT(7)                                 // wait 7 frames
    Moveset.VOICE(1517)                             // HUP
    dw 0

    DSPA_END:
    Moveset.WAIT(6)                                 // wait 8 frames
    Moveset.SFX(179)                                // play whoosh sound
    Moveset.CREATE_GFX(0, 11, 0, 0, -60, 0, 0, 0)   // footstep smoke gfx
    dw 0

    HUP_1_ARRAY:; dh 1514; dh 1527; dh 1528; OS.align(4)
    HUP_2_ARRAY:; dh 1515; dh 1529; dh 1530; OS.align(4)

    DSP_MOVE:
    Moveset.SLOPE_CONTOUR(4)                        // full slope contour
    Moveset.CREATE_GFX(0, 11, 0, 0, -120, 0, 60, 0) // footstep smoke gfx
    Moveset.SFX(121)                                // play dash sound
    Moveset.WAIT(10)                                // wait 10 frames
    DSP_MOVE_LOOP:
    Moveset.SFX(116)                                // play footstep sound
    Moveset.RANDOM_SFX(100, 0x1, 0x3, HUP_1_ARRAY)  // HUP
    Moveset.CREATE_GFX(0, 11, 0, 0, 50, 0, 0, 0)    // footstep smoke gfx
    Moveset.WAIT(20)                                // wait 20 frames
    Moveset.SFX(116)                                // play footstep sound
    Moveset.RANDOM_SFX(100, 0x1, 0x3, HUP_2_ARRAY)  // HUP
    Moveset.CREATE_GFX(0, 11, 0, 0, 50, 0, 0, 0)    // footstep smoke gfx
    Moveset.WAIT(20)                                // wait 20 frames
    Moveset.GO_TO(DSP_MOVE_LOOP)                    // loop

    DSP_TURN:
    Moveset.WAIT(4)                                 // wait 4 frames
    Moveset.SET_FLAG(1)                             // set temp variable 2
    dw 0

    DSP_JUMP:
    Moveset.VOICE(1517)                             // HUP
    Moveset.CREATE_GFX(0, 13, 0, 0, 0, 0, 0, 0)     // jump smoke gfx
    dw 0

    DSP_LANDING:; insert "moveset/DSP_LANDING.bin"

    DSP_TAUNT:
    Moveset.AFTER(10)
    Moveset.VOICE(1513)                             // NOO NEE NOO
    dw MODEL.HEAD.OPEN_MOUTH
    Moveset.AFTER(90)
    dw MODEL.HEAD.DEFAULT
    dw 0

    DSP_CANCEL:
    dw 0xD0004060                                   // fsm
    Moveset.WAIT(12)                                // wait 12 frames
    dw 0xD0004200                                   // fsm
    dw 0

    // Modify Action Parameters             // Action                       // Animation                    // Moveset Data             // Flags
    Character.edit_action_parameters(LANKY, Action.DeadU,                   File.LANKY_TUMBLE,              DMG_1,                      -1)
    Character.edit_action_parameters(LANKY, Action.ScreenKO,                File.LANKY_TUMBLE,              DMG_1,                      -1)
    Character.edit_action_parameters(LANKY, Action.Entry,                   File.LANKY_IDLE,                -1,                         -1)
    Character.edit_action_parameters(LANKY, 0x006,                          File.LANKY_IDLE,                -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.Revive1,                 File.LANKY_DOWN_BOUNCE_D,       -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.Revive2,                 File.LANKY_DOWN_STAND_D,        -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.ReviveWait,              File.LANKY_IDLE,                IDLE,                       -1)
    Character.edit_action_parameters(LANKY, Action.Idle,                    File.LANKY_IDLE,                IDLE,                       -1)
    Character.edit_action_parameters(LANKY, Action.Walk1,                   File.LANKY_WALK1,               -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.Walk2,                   File.LANKY_WALK2,               -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.Walk3,                   File.LANKY_WALK3,               -1,                         -1)
    Character.edit_action_parameters(LANKY, 0x00E,                          File.LANKY_WALK_END,            -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.Dash,                    File.LANKY_DASH,                -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.Run,                     File.LANKY_RUN,                 -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.RunBrake,                File.LANKY_RUN_BRAKE,           -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.Turn,                    File.LANKY_TURN,                -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.TurnRun,                 File.LANKY_TURN_RUN,            -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.JumpSquat,               File.LANKY_LANDING,             -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.ShieldJumpSquat,         File.LANKY_LANDING,             -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.JumpF,                   File.LANKY_JUMP_F,              JUMP_F,                     -1)
    Character.edit_action_parameters(LANKY, Action.JumpB,                   File.LANKY_JUMP_B,              JUMP_B,                     -1)
    Character.edit_action_parameters(LANKY, Action.JumpAerialF,             File.LANKY_JUMP_AERIAL_F,       JUMP_AERIAL,                -1)
    Character.edit_action_parameters(LANKY, Action.JumpAerialB,             File.LANKY_JUMP_AERIAL_B,       JUMP_AERIAL,                -1)
    Character.edit_action_parameters(LANKY, Action.Fall,                    File.LANKY_FALL,                -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.FallAerial,              File.LANKY_FALL_AERIAL,         -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.Crouch,                  File.LANKY_CROUCH,              -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.CrouchIdle,              File.LANKY_CROUCH_IDLE,         -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.CrouchEnd,               File.LANKY_CROUCH_END,          -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.LandingLight,            File.LANKY_LANDING,             -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.LandingHeavy,            File.LANKY_LANDING,             -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.Pass,                    File.LANKY_SHIELD_DROP,         -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.ShieldDrop,              File.LANKY_SHIELD_DROP,         -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.Teeter,                  File.LANKY_TEETER,              -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.TeeterStart,             File.LANKY_TEETER_START,        -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.DamageHigh1,             File.LANKY_DAMAGE_HIGH1,        DMG_1,                      -1)
    Character.edit_action_parameters(LANKY, Action.DamageHigh2,             File.LANKY_DAMAGE_HIGH2,        DMG_1,                      -1)
    Character.edit_action_parameters(LANKY, Action.DamageHigh3,             File.LANKY_DAMAGE_HIGH3,        DMG_1,                      -1)
    Character.edit_action_parameters(LANKY, Action.DamageMid1,              File.LANKY_DAMAGE_MID1,         DMG_1,                      -1)
    Character.edit_action_parameters(LANKY, Action.DamageMid2,              File.LANKY_DAMAGE_MID2,         DMG_1,                      -1)
    Character.edit_action_parameters(LANKY, Action.DamageMid3,              File.LANKY_DAMAGE_MID3,         DMG_1,                      -1)
    Character.edit_action_parameters(LANKY, Action.DamageLow1,              File.LANKY_DAMAGE_LOW1,         DMG_1,                      -1)
    Character.edit_action_parameters(LANKY, Action.DamageLow2,              File.LANKY_DAMAGE_LOW2,         DMG_1,                      -1)
    Character.edit_action_parameters(LANKY, Action.DamageLow3,              File.LANKY_DAMAGE_LOW3,         DMG_1,                      -1)
    Character.edit_action_parameters(LANKY, Action.DamageAir1,              File.LANKY_DAMAGE_AIR1,         DMG_1,                      -1)
    Character.edit_action_parameters(LANKY, Action.DamageAir2,              File.LANKY_DAMAGE_AIR2,         DMG_1,                      -1)
    Character.edit_action_parameters(LANKY, Action.DamageAir3,              File.LANKY_DAMAGE_AIR3,         DMG_1,                      -1)
    Character.edit_action_parameters(LANKY, Action.DamageElec1,             File.LANKY_DAMAGE_ELEC,         DMG_1,                      -1)
    Character.edit_action_parameters(LANKY, Action.DamageElec2,             File.LANKY_DAMAGE_ELEC,         DMG_1,                      -1)
    Character.edit_action_parameters(LANKY, Action.DamageFlyHigh,           File.LANKY_DAMAGE_FLY_HIGH,     DMG_2,                      -1)
    Character.edit_action_parameters(LANKY, Action.DamageFlyMid,            File.LANKY_DAMAGE_FLY_MID,      DMG_2,                      -1)
    Character.edit_action_parameters(LANKY, Action.DamageFlyLow,            File.LANKY_DAMAGE_FLY_LOW,      DMG_2,                      -1)
    Character.edit_action_parameters(LANKY, Action.DamageFlyTop,            File.LANKY_DAMAGE_FLY_TOP,      DMG_2,                      -1)
    Character.edit_action_parameters(LANKY, Action.DamageFlyRoll,           File.LANKY_DAMAGE_FLY_ROLL,     DMG_2,                      -1)
    Character.edit_action_parameters(LANKY, Action.WallBounce,              File.LANKY_TUMBLE,              DMG_1,                      -1)
    Character.edit_action_parameters(LANKY, Action.Tumble,                  File.LANKY_TUMBLE,              DMG_1,                      -1)
    Character.edit_action_parameters(LANKY, Action.FallSpecial,             File.LANKY_FALL_SPECIAL,        FALL_SPECIAL,               -1)
    Character.edit_action_parameters(LANKY, Action.LandingSpecial,          File.LANKY_LANDING,             -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.Tornado,                 File.LANKY_TUMBLE,              -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.EnterPipe,               File.LANKY_ENTER_PIPE,          -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.ExitPipe,                File.LANKY_EXIT_PIPE,           -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.ExitPipeWalk,            File.LANKY_EXIT_PIPE_WALK,      -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.CeilingBonk,             File.LANKY_CEILING_BONK,        -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.DownBounceD,             File.LANKY_DOWN_BOUNCE_D,       -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.DownBounceU,             File.LANKY_DOWN_BOUNCE_U,       -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.DownStandD,              File.LANKY_DOWN_STAND_D,        -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.DownStandU,              File.LANKY_DOWN_STAND_U,        -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.TechF,                   File.LANKY_TECH_F,              TECH_ROLL,                  -1)
    Character.edit_action_parameters(LANKY, Action.TechB,                   File.LANKY_TECH_B,              TECH_ROLL,                  -1)
    Character.edit_action_parameters(LANKY, Action.DownForwardD,            File.LANKY_DOWN_FORWARD_D,      -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.DownForwardU,            File.LANKY_DOWN_FORWARD_U,      -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.DownBackD,               File.LANKY_DOWN_BACK_D,         -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.DownBackU,               File.LANKY_DOWN_BACK_U,         -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.DownAttackD,             File.LANKY_DOWN_ATK_D,          DOWN_ATTACK_D,              -1)
    Character.edit_action_parameters(LANKY, Action.DownAttackU,             File.LANKY_DOWN_ATK_U,          DOWN_ATTACK_U,              -1)
    Character.edit_action_parameters(LANKY, Action.Tech,                    File.LANKY_TECH,                TECH,                       -1)
    Character.edit_action_parameters(LANKY, Action.ClangRecoil,             File.LANKY_CLANG_RECOIL,        -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.CliffCatch,              File.LANKY_CLF_CATCH,           -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.CliffWait,               File.LANKY_CLF_WAIT,            -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.CliffQuick,              File.LANKY_CLF_Q,               -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.CliffClimbQuick1,        File.LANKY_CLF_CLM_Q1,          -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.CliffClimbQuick2,        File.LANKY_CLF_CLM_Q2,          -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.CliffSlow,               File.LANKY_CLF_S,               -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.CliffClimbSlow1,         File.LANKY_CLF_CLM_S1,          -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.CliffClimbSlow2,         File.LANKY_CLF_CLM_S2,          -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.CliffAttackQuick1,       File.LANKY_CLF_ATK_Q1,          -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.CliffAttackQuick2,       File.LANKY_CLF_ATK_Q2,          CLIFF_ATTACK_QUICK_2,       -1)
    Character.edit_action_parameters(LANKY, Action.CliffAttackSlow1,        File.LANKY_CLF_ATK_S1,          -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.CliffAttackSlow2,        File.LANKY_CLF_ATK_S2,          CLIFF_ATTACK_SLOW_2,        -1)
    Character.edit_action_parameters(LANKY, Action.CliffEscapeQuick1,       File.LANKY_CLF_ESC_Q1,          -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.CliffEscapeQuick2,       File.LANKY_CLF_ESC_Q2,          -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.CliffEscapeSlow1,        File.LANKY_CLF_ESC_S1,          -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.CliffEscapeSlow2,        File.LANKY_CLF_ESC_S2,          -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.LightItemPickup,         File.LANKY_L_ITM_PICKUP,        -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.HeavyItemPickup,         File.LANKY_H_ITM_PICKUP,        -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.ItemDrop,                File.LANKY_ITM_DROP,            -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.ItemThrowDash,           File.LANKY_ITM_THROW_DASH,      -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.ItemThrowF,              File.LANKY_ITM_THROW_F,         -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.ItemThrowB,              File.LANKY_ITM_THROW_F,         -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.ItemThrowU,              File.LANKY_ITM_THROW_U,         -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.ItemThrowD,              File.LANKY_ITM_THROW_D,         -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.ItemThrowSmashF,         File.LANKY_ITM_THROW_F,         -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.ItemThrowSmashB,         File.LANKY_ITM_THROW_F,         -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.ItemThrowSmashU,         File.LANKY_ITM_THROW_U,         -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.ItemThrowSmashD,         File.LANKY_ITM_THROW_D,         -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.ItemThrowAirF,           File.LANKY_ITM_THROW_AIR_F,     -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.ItemThrowAirB,           File.LANKY_ITM_THROW_AIR_F,     -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.ItemThrowAirU,           File.LANKY_ITM_THROW_AIR_U,     -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.ItemThrowAirD,           File.LANKY_ITM_THROW_AIR_D,     -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.ItemThrowAirSmashF,      File.LANKY_ITM_THROW_AIR_F,     -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.ItemThrowAirSmashB,      File.LANKY_ITM_THROW_AIR_F,     -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.ItemThrowAirSmashU,      File.LANKY_ITM_THROW_AIR_U,     -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.ItemThrowAirSmashD,      File.LANKY_ITM_THROW_AIR_D,     -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.HeavyItemThrowF,         File.LANKY_H_ITM_THROW,         -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.HeavyItemThrowB,         File.LANKY_H_ITM_THROW,         -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.HeavyItemThrowSmashF,    File.LANKY_H_ITM_THROW,         -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.HeavyItemThrowSmashB,    File.LANKY_H_ITM_THROW,         -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.BeamSwordNeutral,        File.LANKY_ITM_JAB,             -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.BeamSwordTilt,           File.LANKY_ITM_TILT,            -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.BeamSwordSmash,          File.LANKY_ITM_SMASH,           -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.BeamSwordDash,           File.LANKY_ITM_DASH,            -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.BatNeutral,              File.LANKY_ITM_JAB,             -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.BatTilt,                 File.LANKY_ITM_TILT,            -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.BatSmash,                File.LANKY_ITM_SMASH,           -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.BatDash,                 File.LANKY_ITM_DASH,            -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.FanNeutral,              File.LANKY_ITM_JAB,             -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.FanTilt,                 File.LANKY_ITM_TILT,            -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.FanSmash,                File.LANKY_ITM_SMASH,           -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.FanDash,                 File.LANKY_ITM_DASH,            -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.StarRodNeutral,          File.LANKY_ITM_JAB,             -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.StarRodTilt,             File.LANKY_ITM_TILT,            -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.StarRodSmash,            File.LANKY_ITM_SMASH,           -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.StarRodDash,             File.LANKY_ITM_DASH,            -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.RayGunShoot,             File.LANKY_ITM_SHOOT,           -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.RayGunShootAir,          File.LANKY_ITM_SHOOT_AIR,       -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.FireFlowerShoot,         File.LANKY_ITM_SHOOT,           -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.FireFlowerShootAir,      File.LANKY_ITM_SHOOT_AIR,       -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.HammerIdle,              File.LANKY_HAMMER_IDLE,         -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.HammerWalk,              File.LANKY_HAMMER_WALK,         -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.HammerTurn,              File.LANKY_HAMMER_WALK,         -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.HammerJumpSquat,         File.LANKY_HAMMER_WALK,         -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.HammerAir,               File.LANKY_HAMMER_WALK,         -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.HammerLanding,           File.LANKY_HAMMER_WALK,         -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.ShieldOn,                File.LANKY_SHIELD_ON,           -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.ShieldOff,               File.LANKY_SHIELD_OFF,          -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.RollF,                   File.LANKY_ROLL_F,              -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.RollB,                   File.LANKY_ROLL_B,              -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.ShieldBreak,             File.LANKY_DAMAGE_FLY_TOP,      SHIELD_BREAK,               -1)
    Character.edit_action_parameters(LANKY, Action.ShieldBreakFall,         File.LANKY_TUMBLE,              -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.StunLandD,               File.LANKY_DOWN_BOUNCE_D,       -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.StunLandU,               File.LANKY_DOWN_BOUNCE_U,       -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.StunStartD,              File.LANKY_DOWN_STAND_D,        -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.StunStartU,              File.LANKY_DOWN_STAND_U,        -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.Stun,                    File.LANKY_STUN,                STUN,                       -1)
    Character.edit_action_parameters(LANKY, Action.Sleep,                   File.LANKY_STUN,                SLEEP,                      -1)
    Character.edit_action_parameters(LANKY, Action.Grab,                    File.LANKY_GRAB,                GRAB,                       -1)
    Character.edit_action_parameters(LANKY, Action.GrabPull,                File.LANKY_GRAB_PULL,           GRAB_PULL,                  -1)
    Character.edit_action_parameters(LANKY, Action.ThrowF,                  File.LANKY_THROW_F,             F_THROW,                    0x50000000)
    Character.edit_action_parameters(LANKY, Action.ThrowB,                  File.LANKY_THROW_B,             B_THROW,                    0x10000000)
    Character.edit_action_parameters(LANKY, Action.CapturePulled,           File.LANKY_CAPTURE_PULLED,      DMG_1,                      -1)
    Character.edit_action_parameters(LANKY, Action.InhalePulled,            File.LANKY_TUMBLE,              DMG_1,                      -1)
    Character.edit_action_parameters(LANKY, Action.InhaleSpat,              File.LANKY_TUMBLE,              -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.InhaleCopied,            File.LANKY_TUMBLE,              -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.EggLayPulled,            File.LANKY_CAPTURE_PULLED,      DMG_1,                      -1)
    Character.edit_action_parameters(LANKY, Action.EggLay,                  File.LANKY_IDLE,                IDLE,                       -1)
    Character.edit_action_parameters(LANKY, Action.FalconDivePulled,        File.LANKY_DAMAGE_HIGH3,        -1,                         -1)
    Character.edit_action_parameters(LANKY, 0x0B4,                          File.LANKY_TUMBLE,              -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.ThrownDKPulled,          File.LANKY_THROWN_DK_PULLED,    DMG_1,                      -1)
    Character.edit_action_parameters(LANKY, Action.ThrownMarioBros,         File.LANKY_THROWN_MARIO_BROS,   DMG_1,                      -1)
    Character.edit_action_parameters(LANKY, Action.ThrownDK,                File.LANKY_THROWN_DK,           DMG_1,                      -1)
    Character.edit_action_parameters(LANKY, Action.Thrown1,                 File.LANKY_THROWN1,             DMG_1,                      -1)
    Character.edit_action_parameters(LANKY, Action.Thrown2,                 File.LANKY_THROWN2,             DMG_1,                      -1)
    Character.edit_action_parameters(LANKY, Action.Taunt,                   File.LANKY_TAUNT,               TAUNT,                      -1)
    Character.edit_action_parameters(LANKY, Action.Jab1,                    File.LANKY_JAB1,                JAB_1,                      -1)
    Character.edit_action_parameters(LANKY, Action.Jab2,                    File.LANKY_JAB2,                JAB_2,                      -1)
    Character.edit_action_parameters(LANKY, Action.DashAttack,              File.LANKY_DASH_ATK,            DASH_ATTACK,                -1)
    Character.edit_action_parameters(LANKY, Action.FTiltHigh,               File.LANKY_F_TILT_HIGH,         F_TILT_HIGH,                -1)
    Character.edit_action_parameters(LANKY, Action.FTilt,                   File.LANKY_F_TILT,              F_TILT,                     -1)
    Character.edit_action_parameters(LANKY, Action.FTiltLow,                File.LANKY_F_TILT_LOW,          F_TILT_LOW,                 -1)
    Character.edit_action_parameters(LANKY, Action.UTilt,                   File.LANKY_U_TILT,              U_TILT,                     0)
    Character.edit_action_parameters(LANKY, Action.DTilt,                   File.LANKY_D_TILT,              D_TILT,                     0)
    Character.edit_action_parameters(LANKY, Action.FSmashHigh,              File.LANKY_F_SMASH_HIGH,        F_SMASH_HIGH,               -1)
    Character.edit_action_parameters(LANKY, Action.FSmashMidHigh,           0,                              0x80000000,                 0)
    Character.edit_action_parameters(LANKY, Action.FSmash,                  File.LANKY_F_SMASH,             F_SMASH,                    -1)
    Character.edit_action_parameters(LANKY, Action.FSmashMidLow,            0,                              0x80000000,                 0)
    Character.edit_action_parameters(LANKY, Action.FSmashLow,               File.LANKY_F_SMASH_LOW,         F_SMASH_LOW,                -1)
    Character.edit_action_parameters(LANKY, Action.USmash,                  File.LANKY_U_SMASH,             U_SMASH,                    -1)
    Character.edit_action_parameters(LANKY, Action.DSmash,                  File.LANKY_D_SMASH,             D_SMASH,                    -1)
    Character.edit_action_parameters(LANKY, Action.AttackAirN,              File.LANKY_ATTACK_AIR_N,        ATTACK_AIR_N,               -1)
    Character.edit_action_parameters(LANKY, Action.AttackAirF,              File.LANKY_ATTACK_AIR_F,        ATTACK_AIR_F,               0)
    Character.edit_action_parameters(LANKY, Action.AttackAirB,              File.LANKY_ATTACK_AIR_B,        ATTACK_AIR_B,               -1)
    Character.edit_action_parameters(LANKY, Action.AttackAirU,              File.LANKY_ATTACK_AIR_U,        ATTACK_AIR_U,               -1)
    Character.edit_action_parameters(LANKY, Action.AttackAirD,              File.LANKY_ATTACK_AIR_D,        ATTACK_AIR_D,               0)
    Character.edit_action_parameters(LANKY, Action.LandingAirF,             File.LANKY_LANDING_AIR_F,       -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.LandingAirB,             File.LANKY_LANDING_AIR_B,       -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.LandingAirU,             0,                              0x80000000,                 0)
    Character.edit_action_parameters(LANKY, Action.LandingAirD,             File.LANKY_LANDING_AIR_D,       LANDING_AIR_D,              0)
    Character.edit_action_parameters(LANKY, Action.LandingAirX,             File.LANKY_LANDING,             -1,                         -1)
    Character.edit_action_parameters(LANKY, Action.Jab3,                    File.LANKY_JAB3,                JAB_3,                      -1)
    Character.edit_action_parameters(LANKY, Action.EntryR,                  File.LANKY_APPEAR_R,            ENTRY,                      0x40000000)
    Character.edit_action_parameters(LANKY, Action.EntryL,                  File.LANKY_APPEAR_L,            ENTRY,                      0x40000000)
    Character.edit_action_parameters(LANKY, Action.NSPG,                    File.LANKY_NSPG,                NSPG,                       -1)
    Character.edit_action_parameters(LANKY, Action.NSPA,                    File.LANKY_NSPA,                NSPA,                       -1)
    Character.edit_action_parameters(LANKY, 0xE1,                           0,                              0x80000000,                 0)
    Character.edit_action_parameters(LANKY, 0xE2,                           0,                              0x80000000,                 0)
    Character.edit_action_parameters(LANKY, 0xE3,                           0,                              0x80000000,                 0)
    Character.edit_action_parameters(LANKY, 0xE4,                           0,                              0x80000000,                 0)

    // Modify Actions             // Action             // Staling ID   // Main ASM         // Interrupt/Other ASM      // Movement/Physics ASM     // Collision ASM
    Character.edit_action(LANKY,  Action.EntryR,        -1,             0x8013DA94,         0,                          0x8013DB2C,                 0x800DE348)
    Character.edit_action(LANKY,  Action.EntryL,        -1,             0x8013DA94,         0,                          0x8013DB2C,                 0x800DE348)
    Character.edit_action(LANKY,  Action.NSPG,          -1,             LankyNSP.main_,     -1,                         -1,                         -1)
    Character.edit_action(LANKY,  Action.NSPA,          -1,             LankyNSP.main_,     -1,                         -1,                         -1)

    // Add Action Parameters                // Action Name      // Base Action  // Animation                // Moveset Data             // Flags
    Character.add_new_action_params(LANKY,  USPGBegin,          -1,             File.LANKY_USPG,            USP_BEGIN,                  0)
    Character.add_new_action_params(LANKY,  USPABegin,          -1,             File.LANKY_USPA,            USP_BEGIN,                  0)
    Character.add_new_action_params(LANKY,  USPMove,            -1,             File.LANKY_USP_MOVE,        USP_MOVE,                   0)
    Character.add_new_action_params(LANKY,  USPTurn,            -1,             File.LANKY_USP_TURN,        USP_TURN,                   0)
    Character.add_new_action_params(LANKY,  USPEnd,             -1,             File.LANKY_USP_END,         USP_END,                    0)
    Character.add_new_action_params(LANKY,  USPDamage,          -1,             File.LANKY_USP_DAMAGE,      USP_DAMAGE,                 0)
    Character.add_new_action_params(LANKY,  DSPGBegin,          -1,             File.LANKY_DSPG,            DSPG_BEGIN,                 0)
    Character.add_new_action_params(LANKY,  DSPGWait,           -1,             File.LANKY_DSP_IDLE,        0x80000000,                 0)
    Character.add_new_action_params(LANKY,  DSPGEnd,            -1,             File.LANKY_DSP_END,         DSPG_END,                   0)
    Character.add_new_action_params(LANKY,  DSPGCancel,         -1,             File.LANKY_DSP_END,         DSP_CANCEL,                 0)
    Character.add_new_action_params(LANKY,  DSPTurn,            -1,             File.LANKY_DSP_TURN,        DSP_TURN,                   0)
    Character.add_new_action_params(LANKY,  DSPMove,            -1,             File.LANKY_DSP_WALK,        DSP_MOVE,                   0)
    Character.add_new_action_params(LANKY,  DSPTaunt,           -1,             File.LANKY_DSP_TAUNT,       DSP_TAUNT,                  0)
    Character.add_new_action_params(LANKY,  DSPLanding,         -1,             File.LANKY_DSP_JUMPSQUAT,   DSP_LANDING,                0)
    Character.add_new_action_params(LANKY,  DSPJumpSquat,       -1,             File.LANKY_DSP_JUMPSQUAT,   0x80000000,                 0)
    Character.add_new_action_params(LANKY,  DSPJump,            -1,             File.LANKY_DSP_JUMP,        DSP_JUMP,                   0)
    Character.add_new_action_params(LANKY,  DSPPlatDrop,        -1,             File.LANKY_DSP_DROP,        0x80000000,                 0)
    Character.add_new_action_params(LANKY,  DSPABegin,          -1,             File.LANKY_DSPA,            DSPA_BEGIN,                 0)
    Character.add_new_action_params(LANKY,  DSPAWait,           -1,             File.LANKY_DSP_FALL,        0x80000000,                 0)
    Character.add_new_action_params(LANKY,  DSPAEnd,            -1,             File.LANKY_DSP_END_AIR,     DSPA_END,                   0)
    Character.add_new_action_params(LANKY,  DSPACancel,         -1,             File.LANKY_DSP_END_AIR,     DSP_CANCEL,                 0)

    // Add Actions                  // Action Name      // Base Action  //Parameters                    // Staling ID   // Main ASM                     // Interrupt/Other ASM          // Movement/Physics ASM             // Collision ASM
    Character.add_new_action(LANKY, USPGBegin,          -1,             ActionParams.USPGBegin,         0x11,           LankyUSP.begin_main_,           0,                              0x800D8BB4,                         LankyUSP.begin_ground_collision_)
    Character.add_new_action(LANKY, USPABegin,          -1,             ActionParams.USPABegin,         0x11,           LankyUSP.begin_main_,           0,                              0x800D91EC,                         LankyUSP.begin_air_collision_)
    Character.add_new_action(LANKY, USPMove,            -1,             ActionParams.USPMove,           0x11,           LankyUSP.main_,                 0,                              LankyUSP.physics_,                  LankyUSP.collision_)
    Character.add_new_action(LANKY, USPTurn,            -1,             ActionParams.USPTurn,           0x11,           LankyUSP.turn_main_,            0,                              LankyUSP.physics_,                  LankyUSP.collision_)
    Character.add_new_action(LANKY, USPEnd,             -1,             ActionParams.USPEnd,            0x11,           LankyUSP.end_main_,             0,                              0x800D9160,                         LankyUSP.collision_)
    Character.add_new_action(LANKY, USPDamage,          -1,             ActionParams.USPDamage,         0x11,           0x8014053C,                     0x8014070C,                     LankyUSP.damage_physics_,           0x8014093C)
    Character.add_new_action(LANKY, DSPGBegin,          -1,             ActionParams.DSPGBegin,         0x1E,           LankyDSP.begin_main_,           0,                              0x800D8BB4,                         0x800DDF44)
    Character.add_new_action(LANKY, DSPGWait,           -1,             ActionParams.DSPGWait,          0x1E,           LankyDSP.ground_wait_main_,     0,                              LankyDSP.ground_physics_,           LankyDSP.ground_collision_)
    Character.add_new_action(LANKY, DSPGEnd,            -1,             ActionParams.DSPGEnd,           0x1E,           0x800D94C4,                     0,                              0x800D8BB4,                         0x800DDF44)
    Character.add_new_action(LANKY, DSPGCancel,         -1,             ActionParams.DSPGCancel,        0x1E,           LankyDSP.cancel_main_,          0,                              0x800D8BB4,                         0x800DDF44)
    Character.add_new_action(LANKY, DSPTurn,            -1,             ActionParams.DSPTurn,           0x1E,           LankyDSP.turn_main_,            0,                              LankyDSP.ground_physics_,           LankyDSP.ground_collision_)
    Character.add_new_action(LANKY, DSPMove,            -1,             ActionParams.DSPMove,           0x1E,           LankyDSP.move_main_,            0,                              LankyDSP.ground_physics_,           LankyDSP.ground_collision_)
    Character.add_new_action(LANKY, DSPTaunt,           -1,             ActionParams.DSPTaunt,          0x1E,           LankyDSP.landing_main_,         0,                              0x800D8BB4,                         LankyDSP.ground_collision_)
    Character.add_new_action(LANKY, DSPLanding,         -1,             ActionParams.DSPLanding,        0x1E,           LankyDSP.landing_main_,         0,                              0x800D8BB4,                         LankyDSP.ground_collision_)
    Character.add_new_action(LANKY, DSPJumpSquat,       -1,             ActionParams.DSPJumpSquat,      0x1E,           LankyDSP.jumpsquat_main_,       LankyDSP.jumpsquat_interrupt_,  0x800D8BB4,                         LankyDSP.ground_collision_)
    Character.add_new_action(LANKY, DSPJump,            -1,             ActionParams.DSPJump,           0x1E,           LankyDSP.jump_main_,            0,                              0x800D9160,                         LankyDSP.air_collision_)
    Character.add_new_action(LANKY, DSPPlatDrop,        -1,             ActionParams.DSPPlatDrop,       0x1E,           LankyDSP.jump_main_,            0,                              0x800D9160,                         LankyDSP.air_collision_)
    Character.add_new_action(LANKY, DSPABegin,          -1,             ActionParams.DSPABegin,         0x1E,           LankyDSP.begin_main_,           0,                              0x800D9160,                         LankyDSP.air_collision_)
    Character.add_new_action(LANKY, DSPAWait,           -1,             ActionParams.DSPAWait,          0x1E,           LankyDSP.air_wait_main_,        0,                              0x800D9160,                         LankyDSP.air_collision_)
    Character.add_new_action(LANKY, DSPAEnd,            -1,             ActionParams.DSPAEnd,           0x1E,           0x800D94E8,                     0,                              0x800D9160,                         0x800DE978)
    Character.add_new_action(LANKY, DSPACancel,         -1,             ActionParams.DSPACancel,        0x1E,           LankyDSP.cancel_main_,          0,                              0x800D9160,                         0x800DE978)

    // Modify Menu Action Parameters              // Action // Animation                // Moveset Data             // Flags
    Character.edit_menu_action_parameters(LANKY,  0x0,      File.LANKY_IDLE,            IDLE,                       -1)
    Character.edit_menu_action_parameters(LANKY,  0x1,      File.LANKY_VICTORY_1,       CSS,                        -1)
    Character.edit_menu_action_parameters(LANKY,  0x2,      File.LANKY_VICTORY_2,       VICTORY2,                   -1)
    Character.edit_menu_action_parameters(LANKY,  0x3,      File.LANKY_VICTORY_3,       VICTORY3,                   -1)
    Character.edit_menu_action_parameters(LANKY,  0x4,      File.LANKY_VICTORY_1,       CSS,                        -1)
    Character.edit_menu_action_parameters(LANKY,  0x5,      File.LANKY_CLAP,            0x80000000,                 -1)
    Character.edit_menu_action_parameters(LANKY,  0x9,      File.LANKY_CONTINUE_FALL,   -1,                         -1)
    Character.edit_menu_action_parameters(LANKY,  0xA,      File.LANKY_CONTINUE_UP,     -1,                         -1)
    Character.edit_menu_action_parameters(LANKY,  0xD,      File.LANKY_1P_POSE,         -1,                         -1)
    Character.edit_menu_action_parameters(LANKY,  0xE,      File.LANKY_DUO_POSE,        -1,                         -1)

    Character.table_patch_start(air_nsp, Character.id.LANKY, 0x4)
    dw      LankyNSP.air_initial_
    OS.patch_end()
    Character.table_patch_start(ground_nsp, Character.id.LANKY, 0x4)
    dw      LankyNSP.ground_initial_
    OS.patch_end()
    Character.table_patch_start(air_usp, Character.id.LANKY, 0x4)
    dw      LankyUSP.air_initial_
    OS.patch_end()
    Character.table_patch_start(ground_usp, Character.id.LANKY, 0x4)
    dw      LankyUSP.ground_initial_
    OS.patch_end()
    Character.table_patch_start(air_dsp, Character.id.LANKY, 0x4)
    dw      LankyDSP.air_initial_
    OS.patch_end()
    Character.table_patch_start(ground_dsp, Character.id.LANKY, 0x4)
    dw      LankyDSP.ground_initial_
    OS.patch_end()

    // Add Jab 3
    Character.table_patch_start(jab_3_timer, Character.id.LANKY, 0x4)
    dw set_jab_3_timer_
    OS.patch_end()

    // Set entry action
    Character.table_patch_start(entry_action, Character.id.LANKY, 0x8)
    dw Action.EntryR, Action.EntryL
    OS.patch_end()
    // Adds Tag Barrel to entry.
    Character.table_patch_start(entry_script, Character.id.LANKY, 0x4)
    dw 0x8013DCAC                         // routine typically used by DK to load Barrel, now used for Tag Barrel
    OS.patch_end()

    // Set default costumes
    Character.set_default_costumes(Character.id.LANKY, 0, 1, 2, 3, 1, 0, 2)
    Teams.add_team_costume(YELLOW, LANKY, 0x4)

    // Shield colors for costume matching
    Character.set_costume_shield_colors(LANKY, BLUE, RED, GREEN, MAGENTA, YELLOW, PURPLE, WHITE, NA)

    // Set Kirby hat_id
    Character.table_patch_start(kirby_inhale_struct, 0x2, Character.id.LANKY, 0xC)
    dh 0x2E
    OS.patch_end()

    // Set menu zoom size.
    Character.table_patch_start(menu_zoom, Character.id.LANKY, 0x4)
    float32 1.05
    OS.patch_end()

    // Set crowd chant FGM.
    Character.table_patch_start(crowd_chant_fgm, Character.id.LANKY, 0x2)
    dh  0x05DC
    OS.patch_end()

    // Set action strings
    Character.table_patch_start(action_string, Character.id.LANKY, 0x4)
    dw  Action.action_string_table
    OS.patch_end()

    // Set 1P Victory Image
    SinglePlayer.set_ending_image(Character.id.LANKY, File.SINGLEPLAYER_VICTORY_IMAGE_BOTTOM)

    // Set Remix 1P ending music
    Character.table_patch_start(remix_1p_end_bgm, Character.id.LANKY, 0x2)
    dh {MIDI.id.ORANGSPRINT}
    OS.patch_end()

    // Set Charge Smash attacks entry
    ChargeSmashAttacks.set_charged_smash_attacks(Character.id.LANKY, ChargeSmashAttacks.entry_lanky)

    // Set 1P Victory Image
    SinglePlayer.set_ending_image(Character.id.LANKY, File.LANKY_VICTORY_IMAGE_BOTTOM)

    // @ Description
    // Jump table patch which sets the jab 3 timer.
    scope set_jab_3_timer_: {
        lui     at, 0x4228                  // ~
        mtc1    at, f4                      // f4 = 42
        j       0x8014EBA4                  // return
        swc1    f4, 0x0150(v1)              // jab 3 timer = 42
    }
}