// Stages.asm
if !{defined __STAGES__} {
define __STAGES__()
print "included Stages.asm\n"

// @ Description
// This file expands the stage select screen.

include "Color.asm"
include "FGM.asm"
include "Global.asm"
include "Item.asm"
include "OS.asm"
include "String.asm"

scope Stages {

    // @ Description
    // Stage IDs. Used in various loading sequences.
    scope id {
        // original stages
        constant PEACHS_CASTLE(0x00)
        constant SECTOR_Z(0x01)
        constant CONGO_JUNGLE(0x02)
        constant PLANET_ZEBES(0x03)
        constant HYRULE_CASTLE(0x04)
        constant YOSHIS_ISLAND(0x05)
        constant DREAM_LAND(0x06)
        constant SAFFRON_CITY(0x07)
        constant MUSHROOM_KINGDOM(0x08)
        constant DREAM_LAND_BETA_1(0x09)
        constant DREAM_LAND_BETA_2(0x0A)
        constant HOW_TO_PLAY(0x0B)
        constant MINI_YOSHIS_ISLAND(0x0C)
        constant META_CRYSTAL(0x0D)
        constant DUEL_ZONE(0x0E)
        constant RACE_TO_THE_FINISH(0x0F)
        constant FINAL_DESTINATION(0x10)
        constant BTX_FIRST(0x11)
        constant BTT_MARIO(0x11)
        constant BTT_FOX(0x12)
        constant BTT_DONKEY_KONG(0x13)
        constant BTT_SAMUS(0x14)
        constant BTT_LUIGI(0x15)
        constant BTT_LINK(0x16)
        constant BTT_YOSHI(0x17)
        constant BTT_FALCON(0x18)
        constant BTT_KIRBY(0x19)
        constant BTT_PIKACHU(0x1A)
        constant BTT_JIGGLYPUFF(0x1B)
        constant BTT_NESS(0x1C)
        constant BTP_MARIO(0x1D)
        constant BTP_FOX(0x1E)
        constant BTP_DONKEY_KONG(0x1F)
        constant BTP_SAMUS(0x20)
        constant BTP_LUIGI(0x21)
        constant BTP_LINK(0x22)
        constant BTP_YOSHI(0x23)
        constant BTP_FALCON(0x24)
        constant BTP_KIRBY(0x25)
        constant BTP_PIKACHU(0x26)
        constant BTP_JIGGLYPUFF(0x27)
        constant BTP_NESS(0x28)
        constant BTX_LAST(0x28)

        // new stages
        constant DEKU_TREE(0x29)
        constant FIRST_DESTINATION(0x2A)
        constant GANONS_TOWER(0x2B)
        constant GYM_LEADER_CASTLE(0x2C)
        constant POKEMON_STADIUM(0x2D)
        constant TALTAL(0x2E)
        constant GLACIAL(0x2F)
        constant WARIOWARE(0x30)
        constant BATTLEFIELD(0x31)
        constant FLAT_ZONE(0x32)
        constant DR_MARIO(0x33)
        constant COOLCOOL(0x34)
        constant DRAGONKING(0x35)
        constant GREAT_BAY(0x36)
        constant FRAYS_STAGE(0x37)
        constant TOH(0x38)
        constant FOD(0x39)
        constant MUDA(0x3A)
        constant MEMENTOS(0x3B)
        constant SHOWDOWN(0x3C)
        constant SPIRALM(0x3D)
        constant N64(0x3E)
        constant MUTE_DL(0x3F)
        constant MADMM(0x40)
        constant SMBBF(0x41)
        constant SMBO(0x42)
        constant BOWSERB(0x43)
        constant PEACH2(0x44)
        constant DELFINO(0x45)
        constant CORNERIA2(0x46)
        constant KITCHEN(0x47)
        constant BLUE(0x48)
        constant ONETT(0x49)
        constant ZLANDING(0x4A)
        constant FROSTY(0x4B)
        constant SMASHVILLE2(0x4C)
        constant BTT_DRM(0x4D)
        constant BTT_GND(0x4E)
        constant BTT_YL(0x4F)
        constant BATTLEFIELD_DL(0x50)
        constant BTT_DS(0x51)
        constant BTT_STG1(0x52)
        constant BTT_FALCO(0x53)
        constant BTT_WARIO(0x54)
        constant HTEMPLE(0x55)
        constant BTT_LUCAS(0x56)
        constant BTP_GND(0x57)
        constant NPC(0x58)
        constant BTP_DS(0x59)
        constant SMASHKETBALL(0x5A)
        constant BTP_DRM(0x5B)
        constant NORFAIR(0x5C)
        constant RAIDBLUE(0x5D)
        constant FALLS(0x5E)
        constant OSOHE(0x5F)
        constant YOSHI_STORY_2(0x60)
        constant WORLD1(0x61)
        constant FLAT_ZONE_2(0x62)
        constant GERUDO(0x63)
        constant BTP_YL(0x64)
        constant BTP_FALCO(0x65)
        constant BTP_POLY(0x66)
        constant HCASTLE_DL(0x67)
        constant HCASTLE_O(0x68)
        constant CONGOJ_DL(0x69)
        constant CONGOJ_O(0x6A)
        constant PCASTLE_DL(0x6B)
        constant PCASTLE_O(0x6C)
        constant BTP_WARIO(0x6D)
        constant FRAYS_STAGE_NIGHT(0x6E)
        constant GOOMBA_ROAD(0x6F)
        constant BTP_LUCAS2(0x70)
        constant SECTOR_Z_DL(0x71)
        constant SAFFRON_DL(0x72)
        constant YOSHI_ISLAND_DL(0x73)
        constant ZEBES_DL(0x74)
        constant SECTOR_Z_O(0x75)
        constant SAFFRON_O(0x76)
        constant YOSHI_ISLAND_O(0x77)
        constant DREAM_LAND_O(0x78)
        constant ZEBES_O(0x79)
        constant BTT_BOWSER(0x7A)
        constant BTP_BOWSER(0x7B)
        constant BOWSERS_KEEP(0x7C)
        constant RITH_ESSA(0x7D)
        constant VENOM(0x7E)
        constant BTT_WOLF(0x7F)
        constant BTP_WOLF(0x80)
        constant BTT_CONKER(0x81)
        constant BTP_CONKER(0x82)
        constant WINDY(0x83)
        constant DATA(0x84)
        constant CLANCER(0x85)
        constant JAPES(0x86)
        constant BTT_MARTH(0x87)
        constant GB_LAND(0x88)
        constant BTT_MTWO(0x89)
        constant BTP_MARTH(0x8A)
        constant REST(0x8B)
        constant BTP_MTWO(0x8C)
        constant CSIEGE(0x8D)
        constant YOSHIS_ISLAND_II(0x8E)
        constant FINAL_DESTINATION_DL(0x8F)
        constant FINAL_DESTINATION_TENT(0x90)
        constant COOLCOOL_REMIX(0x91)
        constant DUEL_ZONE_DL(0x92)
        constant COOLCOOL_DL(0x93)
        constant META_CRYSTAL_DL(0x94)
        constant DREAM_LAND_SR(0x95)
        constant PCASTLE_BETA(0x96)
        constant HCASTLE_REMIX(0x97)
        constant SECTOR_Z_REMIX(0x98)
        constant MUTE(0x99)
        constant HRC(0x9A)
        constant MK_REMIX(0x9B)
        constant GHZ(0x9C)
        constant SUBCON(0x9D)
        constant PIRATE(0x9E)
        constant CASINO(0x9F)
        constant BTT_SONIC(0xA0)
        constant BTP_SONIC(0xA1)
        constant MMADNESS(0xA2)
        constant RAINBOWROAD(0xA3)
        constant POKEMON_STADIUM_2(0xA4)
        constant NORFAIR_REMIX(0xA5)
        constant TOADSTURNPIKE(0xA6)
        constant TALTAL_REMIX(0xA7)
        constant BTP_SHEIK(0xA8)
        constant WINTER_DL(0xA9)
        constant BTT_SHEIK(0xAA)
        constant GLACIAL_REMIX(0xAB)
        constant BTT_MARINA(0xAC)
        constant DRAGONKING_REMIX(0xAD)
        constant BTP_MARINA(0xAE)
        constant BTT_DEDEDE(0xAF)
        constant DRACULAS_CASTLE(0xB0)
        constant INVERTED_CASTLE(0xB1)
        constant BTP_DEDEDE(0xB2)
        constant MT_DEDEDE(0xB3)
        constant EDO(0xB4)
        constant DEKU_TREE_DL(0xB5)
        constant ZLANDING_DL(0xB6)
        constant BTT_GOEMON(0xB7)
        constant FIRST_REMIX(0xB8)
        constant BTP_GOEMON(0xB9)
        constant TWILIGHT_CITY(0xBA)
        constant MELRODE(0xBB)
        constant META_REMIX(0xBC)
        constant REMIX_RTTF(0xBD)
        constant REAPERS(0xBE)
        constant SCUTTLE_TOWN(0xBF)
        constant BIG_BOOS_HAUNT(0xC0)
        constant YOSHIS_ISLAND_MELEE(0xC1)
        constant BTT_BANJO(0xC2)
        constant SPAWNED_FEAR(0xC3)
        constant SMASHVILLE_REMIX(0xC4)
        constant BTP_BANJO(0xC5)
        constant POKEFLOATS(0xC6)
        constant BIG_SNOWMAN(0xC7)
        constant DL_BETA_DL(0xC8)
        constant LMAO_CASTLE(0xC9)
        constant DISCOVERY_FALLS(0xCA)
        constant BTT_CRASH(0xCB)
        constant DISCOVERY_FALLS_REMIX(0xCC)
        constant N64_REMIX(0xCD)
        constant BTP_CRASH(0xCE)
        constant BTT_PEACH(0xCF)
        constant BTP_PEACH(0xD0)
        constant SOCCER(0xD1)
        constant TIME_TWISTER(0xD2)
        constant TIME_TWISTER_SSS(0xD3)
        constant NSANITY_BEACH(0xD4)
        constant SNOW_GO(0xD5)
        constant FUTURE_FRENZY(0xD6)

        constant MAX_STAGE_ID(0xD6)

        // not an actual id, some arbitary number Sakurai picked(?)
        constant RANDOM(0xDE)
    }

    // @ Description
    // type controls a branch that executes code for single player modes when 0x00 or skips that
    // entirely for 0x14. This branch can be found at 0x(TODO). (pulled from table @ 0xA7D20)
    scope type {
        constant PEACHS_CASTLE(0x14)
        constant SECTOR_Z(0x14)
        constant CONGO_JUNGLE(0x14)
        constant PLANET_ZEBES(0x14)
        constant HYRULE_CASTLE(0x14)
        constant YOSHIS_ISLAND(0x14)
        constant DREAM_LAND(0x14)
        constant SAFFRON_CITY(0x14)
        constant MUSHROOM_KINGDOM(0x14)
        constant DREAM_LAND_BETA_1(0x14)
        constant DREAM_LAND_BETA_2(0x14)
        constant HOW_TO_PLAY(0x00)
        constant MINI_YOSHIS_ISLAND(0x14)
        constant META_CRYSTAL(0x14)
        constant DUEL_ZONE(0x14)
        constant RACE_TO_THE_FINISH(0x00)
        constant FINAL_DESTINATION(0x00)
        constant BTP(0x00)
        constant BTT(0x00)
        constant CLONE(0x14)
    }

    // @ Description
    // Header file id for each stage (pulled from table @ 0xA7D20)
    scope header {
        // original stages
        constant PEACHS_CASTLE(0x0103)
        constant SECTOR_Z(0x0106)
        constant CONGO_JUNGLE(0x0105)
        constant PLANET_ZEBES(0x0101)
        constant HYRULE_CASTLE(0x0109)
        constant YOSHIS_ISLAND(0x0107)
        constant DREAM_LAND(0x00FF)
        constant SAFFRON_CITY(0x0108)
        constant MUSHROOM_KINGDOM(0x104)
        constant DREAM_LAND_BETA_1(0x0100)
        constant DREAM_LAND_BETA_2(0x0102)
        constant HOW_TO_PLAY(0x010B)
        constant MINI_YOSHIS_ISLAND(0x010E)
        constant META_CRYSTAL(0x10D)
        constant DUEL_ZONE(0x010C)
        constant RACE_TO_THE_FINISH(0x0127)
        constant FINAL_DESTINATION(0x010A)
        constant BTT_MARIO(0x010F)
        constant BTT_FOX(0x0110)
        constant BTT_DONKEY_KONG(0x0111)
        constant BTT_SAMUS(0x0112)
        constant BTT_LUIGI(0x0113)
        constant BTT_LINK(0x0114)
        constant BTT_YOSHI(0x0115)
        constant BTT_FALCON(0x0116)
        constant BTT_KIRBY(0x0117)
        constant BTT_PIKACHU(0x0118)
        constant BTT_JIGGLYPUFF(0x0119)
        constant BTT_NESS(0x011A)
        constant BTP_MARIO(0x011B)
        constant BTP_FOX(0x011C)
        constant BTP_DONKEY_KONG(0x011D)
        constant BTP_SAMUS(0x011E)
        constant BTP_LUIGI(0x011F)
        constant BTP_LINK(0x0120)
        constant BTP_YOSHI(0x0121)
        constant BTP_FALCON(0x0122)
        constant BTP_KIRBY(0x0123)
        constant BTP_PIKACHU(0x0124)
        constant BTP_JIGGLYPUFF(0x0125)
        constant BTP_NESS(0x0126)

        // new stages
        constant DEKU_TREE(0x0874)
        constant FIRST_DESTINATION(0x0877)
        constant GANONS_TOWER(0x087A)
        constant GYM_LEADER_CASTLE(0x087D)
        constant POKEMON_STADIUM(0x0880)
        constant TALTAL(0x0883)
        constant GLACIAL(0x0886)
        constant WARIOWARE(0x0889)
        constant BATTLEFIELD(0x0871)
        constant FLAT_ZONE(0x088C)
        constant DR_MARIO(0x088F)
        constant COOLCOOL(0x892)
        constant DRAGONKING(0x895)
        constant GREAT_BAY(0x89B)
        constant FRAYS_STAGE(0x898)
        constant TOH(0x89E)
        constant FOD(0x8A1)
        constant MUDA(0x8A5)
        constant MEMENTOS(0x8A8)
        constant SHOWDOWN(0x8B6)
        constant SPIRALM(0x8B9)
        constant N64(0x8BC)
        constant MUTE_DL(0x8BF)
        constant MADMM(0x8C2)
        constant SMBBF(0x8C5)
        constant SMBO(0x8C7)
        constant BOWSERB(0x8CA)
        constant PEACH2(0x8CD)
        constant DELFINO(0x8D0)
        constant CORNERIA2(0x8DE)
        constant KITCHEN(0x8E1)
        constant BLUE(0x8EC)
        constant ONETT(0x8F0)
        constant ZLANDING(0x8F3)
        constant FROSTY(0x90C)
        constant SMASHVILLE2(0x911)
        constant BTT_DRM(0x92B)
        constant BTT_GND(0x93A)
        constant BTT_YL(0x966)
        constant BATTLEFIELD_DL(0x941)
        constant BTT_DS(0x944)
        constant BTT_STG1(0x959)
        constant BTT_FALCO(0x960)
        constant BTT_WARIO(0x968)
        constant HTEMPLE(0x981)
        constant BTT_LUCAS(0x985)
        constant BTP_GND(0x989)
        constant NPC(0x98C)
        constant BTP_DS(0x98F)
        constant SMASHKETBALL(0x991)
        constant BTP_DRM(0x995)
        constant NORFAIR(0x998)
        constant RAIDBLUE(0x99C)
        constant FALLS(0x93C)
        constant OSOHE(0x9A0)
        constant YOSHI_STORY_2(0x9A3)
        constant WORLD1(0x9A9)
        constant FLAT_ZONE_2(0x9AB)
        constant GERUDO(0x9AD)
        constant BTP_YL(0x9B3)
        constant BTP_FALCO(0xA17)
        constant BTP_POLY(0xA19)
        constant HCASTLE_DL(0xA1B)
        constant HCASTLE_O(0xA1D)
        constant CONGOJ_DL(0xA1F)
        constant CONGOJ_O(0xA21)
        constant PCASTLE_DL(0xA23)
        constant PCASTLE_O(0xA25)
        constant BTP_WARIO(0xA2E)
        constant FRAYS_STAGE_NIGHT(0xA32)
        constant GOOMBA_ROAD(0xA4C)
        constant BTP_LUCAS2(0xA4F)
        constant SECTOR_Z_DL(0xA63)
        constant SAFFRON_DL(0xA66)
        constant YOSHI_ISLAND_DL(0xA68)
        constant ZEBES_DL(0xA6A)
        constant SECTOR_Z_O(0xA6C)
        constant SAFFRON_O(0xA65)
        constant YOSHI_ISLAND_O(0xA6F)
        constant DREAM_LAND_O(0xA71)
        constant ZEBES_O(0xA73)
        constant BTT_BOWSER(0xA7E)
        constant BTP_BOWSER(0xA82)
        constant BOWSERS_KEEP(0xA8A)
        constant RITH_ESSA(0xB78)
        constant VENOM(0xC8D)
        constant BTT_WOLF(0xC95)
        constant BTP_WOLF(0xC99)
        constant BTT_CONKER(0xC9C)
        constant BTP_CONKER(0xCAE)
        constant WINDY(0xCB4)
        constant DATA(0xCB7)
        constant CLANCER(0xCBA)
        constant JAPES(0xCC4)
        constant BTT_MARTH(0xD6E)
        constant GB_LAND(0xD74)
        constant BTT_MTWO(0xD76)
        constant BTP_MARTH(0xD78)
        constant REST(0xD7A)
        constant BTP_MTWO(0xD7D)
        constant CSIEGE(0xD7F)
        constant YOSHIS_ISLAND_II(0xD82)
        constant FINAL_DESTINATION_DL(0xD85)
        constant FINAL_DESTINATION_TENT(0xD87)
        constant COOLCOOL_REMIX(0xD89)
        constant DUEL_ZONE_DL(0xD8C)
        constant COOLCOOL_DL(0xD8E)
        constant META_CRYSTAL_DL(0xD90)
        constant DREAM_LAND_SR(0xD92)
        constant PCASTLE_BETA(0xD95)
        constant HCASTLE_REMIX(0xDEC)
        constant SECTOR_Z_REMIX(0xDEE)
        constant MUTE(0xDF9)
        constant HRC(0xDFB)
        constant MK_REMIX(0xDFE)
        constant GHZ(0xE19)
        constant SUBCON(0xE1E)
        constant PIRATE(0xE23)
        constant CASINO(0xE29)
        constant BTT_SONIC(0xE3F)
        constant BTP_SONIC(0xE43)
        constant MMADNESS(0xE4E)
        constant RAINBOWROAD(0xE63)
        constant POKEMON_STADIUM_2(0x0E69)
        constant NORFAIR_REMIX(0x0EBE)
        constant TOADSTURNPIKE(0x0EC2)
        constant TALTAL_REMIX(0x0EC0)
        constant BTP_SHEIK(0x0EDD)
        constant WINTER_DL(0x0EDF)
        constant BTT_SHEIK(0x0EF0)
        constant GLACIAL_REMIX(0x0F26)
        constant BTT_MARINA(0x0FF1)
        constant DRAGONKING_REMIX(0x0FF3)
        constant BTP_MARINA(0x0FF6)
        constant BTT_DEDEDE(0x1078)
        constant DRACULAS_CASTLE(0x1097)
        constant INVERTED_CASTLE(0x10A4)
        constant BTP_DEDEDE(0x10AE)
        constant MT_DEDEDE(0x10BA)
        constant EDO(0x10F7)
        constant DEKU_TREE_DL(0x10FB)
        constant ZLANDING_DL(0x10FD)
        constant BTT_GOEMON(0x1112)
        constant FIRST_REMIX(0x111B)
        constant BTP_GOEMON(0x111C)
        constant TWILIGHT_CITY(0x1124)
        constant MELRODE(0x1135)
        constant META_REMIX(0x1187)
        constant REMIX_RTTF(0x1189)
        constant REAPERS(0x118E)
        constant SCUTTLE_TOWN(0x1233)
        constant BIG_BOOS_HAUNT(0x1244)
        constant YOSHIS_ISLAND_MELEE(0x1247)
        constant BTT_BANJO(0x1250)
        constant SPAWNED_FEAR(0x125E)
        constant SMASHVILLE_REMIX(0x1261)
        constant BTP_BANJO(0x1266)
        constant POKEFLOATS(0x1279)
        constant BIG_SNOWMAN(0x12AC)
        constant DL_BETA_DL(0x1368)
        constant LMAO_CASTLE(0x136A)
        constant DISCOVERY_FALLS(0x1429)
        constant BTT_CRASH(0x143F)
        constant DISCOVERY_FALLS_REMIX(0x1442)
        constant N64_REMIX(0x1444)
        constant BTP_CRASH(0x144A)
        constant BTT_PEACH(0x140B)
        constant BTP_PEACH(0x14F2)
        constant SOCCER(0x13E3)
        constant TIME_TWISTER(0x1511)
        constant TIME_TWISTER_SSS(0x1518)
        constant NSANITY_BEACH(0x1519)
        constant SNOW_GO(0x151B)
        constant FUTURE_FRENZY(0x151D)
    }

    scope function {
        constant PEACHS_CASTLE(0x8010B4AC)
        constant SECTOR_Z(0x80107FCC)
        constant CONGO_JUNGLE(0x80109FB4)
        constant PLANET_ZEBES(0x80108448)
        constant HYRULE_CASTLE(0x8010AB20)
        constant YOSHIS_ISLAND(0x80108C80)
        constant DREAM_LAND(0x801066D4)
        constant SAFFRON_CITY(0x8010B2EC)
        constant MUSHROOM_KINGDOM(0x80109C0C)

        // jal ra, t9 immediately to jr ra lol
        constant CLONE(0x801056F8)
    }

    // @ Description
    // Class will help us better determine which branches to take rather than relying on stage ID
    scope class {
        constant BATTLE(0x00)
        constant RTTF(0x01)
        constant BTP(0x02)
        constant BTT(0x03)
        constant SSS_PREVIEW(0x04)
    }

    // @ Description
    // Describes the types of stage variants available
    scope variant_type {
        constant DEFAULT(0x00)
        constant DL(0x01)
        constant OMEGA(0x02)
        constant REMIX(0x03)
        constant REMIX2(0x04)
        constant REMIX3(0x05)
        constant REMIX4(0x06)
        constant REMIX5(0x07)
        constant REMIX6(0x08)
    }

    constant ICON_WIDTH(40)
    constant ICON_HEIGHT(30)

    // Layout
    constant NUM_ROWS(3)
    constant NUM_COLUMNS(6)
    constant NUM_ICONS(NUM_ROWS * NUM_COLUMNS)
    constant NUM_PAGES(0x05)

    // list of instructions that read from the stage id (A press on versus stage select screen)
    // they're in order (you're welcome)

    // DONE
    // 800FC298 - reads from table at 0x8012C520, (stage file #, stage type #)
    // solution: change li @ 0x800FC29C to custom table by stage id
    // 800FC2CC - same as above
    // solution: same as above
    // 800FC2F0 - same as above
    // solution: same as above

    // DONE
    // 80104C14 - checks if this is a BTT/BTP stage or not
    // solution: add check for > than 28
    scope id_fix_1_: {
        OS.patch_start(0x00080424, 0x80104C24)
        j       id_fix_1_
        nop
        OS.patch_end()

        addiu   at, r0, Stages.id.REMIX_RTTF    // place Remix Race to the Finish Stage ID in at
        beq     at, v0, _skip_bg_loading        // if stage is Remix Race to the Finish, it should use the same routine as Race to the Finish, which skips the bg loading proess
        nop

        li      at, function_table          // at = function table
        sll     v0, v0, 0x0002              // v0 = offset in function table
        addu    at, at, v0                  // at = address in function table
        srl     v0, v0, 0x0002              // v0 = stage_id again
        lw      at, 0x0000(at)              // at = 0 if Bonus
        bnez    at, _corrected              // adjust path as necessary
        nop

        _original:
        jal     0x801048F8                  // original line 1
        nop                                 // original line 2
        j       0x80104C2C                  // take original path back
        nop

        _corrected:
        j       0x80104C34                  // take corrected path
        nop

        _skip_bg_loading:
        li      t8, 0x80104C74              // load address for jr
        j       0x80104C4C                  // Race to the Finish Routine which skips bg loading
        nop
    }

    // DONE
    // 8010DA90 - check for id.PLANET_ZEBES (later followed by check for id.MUSHROOM_KINGDOM)
    // soltuion: do nothing, there's a default later

    // DONE
    // 801056D0 - this is actually of importance (lol), this is what function runs for each stage < 9
    //            (ie what you can access on the stage select screen by default) so "multiplayer"
    //            stages with function. jalr based on this
    // solution: either enforce hyrule id here copy the function table somewhere else
    scope id_fix_2_: {
        OS.patch_start(0x00080ED4, 0x801056D4)
        j       id_fix_2_
        nop
        _id_fix_2_return:
        OS.patch_end()

        OS.patch_start(0x00080EEC, 0x801056EC)
        lw      t9, 0x0000(t9)
        OS.patch_end()


        addiu   sp, sp,-0x0010              // allocate stack space
        sw      t0, 0x0004(sp)              // save t0
        sw      ra, 0x0008(sp)
        sw      v0, 0x000C(sp)

        jal     PokemonAnnouncer.toggle_announcer_
        nop
        bnez    v0, _normal
        nop

        jal     PokemonAnnouncer.announcer_setup_
        nop

        _normal:
        lw      ra, 0x0008(sp)
        lw      v0, 0x000C(sp)
        li      t9, function_table          // original line 1 (modified)
        slti    at, v1, 0x0009              // original line 2
        slti    t0, v1, id.BTX_LAST + 1     // check upper bound
        bnez    t0, _return                 // if (stage id is NOT a new stage), skip
        nop
        sll     t0, v1, 0x0002              // t0 = offset in function table
        addu    t0, t0, t9                  // t0 = address in function table
        lw      t0, 0x0000(t0)              // t0 = 0 if Bonus
        beqz    t0, _return                 // if (stage a new bonus stage), skip
        nop
        lli     at, OS.TRUE                 // set at

        _return:
        lw      t0, 0x0004(sp)              // restore t0
        addiu   sp, sp, 0x0010              // deallocate stack space
        j       _id_fix_2_return            // return
        nop
    }

    // TODO
    // 80116AE0 - i have NO idea (v hacky memory access)
    // solution: probably enforce hyrule id, look more into this

    // TODO
    // 80116B84 - stage id shifted (as per usual) and then added to some parameter in a0
    //            this calculated value is stored at 0x18(a1) right before this
    // solution: enforce hyrule id(?)

    // TODO
    // 80116B98 - same as above except calculated value is not stored at 0x18(a1). lw t0, 0x8(t9) where t9
    //            is the calculated value. some arithmetic is then used on t0 which is stored at 0x0014(a1)
    // soltuion: enforce hyrule id(?)

    // ALSO: figure out what the fricking heck A1 is in the last two notes
    // ok so it looks to be a function specific to each stage (on DL it renders the background chars)

    // DONE
    // 80114C9C - checks if we're playing on a board the platforms stage (greater than 10) to see
    //            if gameset or failure should happen
    // solution: add check for greater than last btx as well
    scope id_fix_5_: {
        OS.patch_start(0x0009049C, 0x80114C9C)
        j       id_fix_5_
        nop
        nop
        _id_fix_5_return:
        OS.patch_end()


        slti    at, t6, 0x0011              // original line 1
        bnez    at, _take_branch            // original line 2 (modified)
        lui     a1, 0x8011                  // original line 3

        lli     at, id.HRC
        beq     t6, at, _continue           // if HRC, show FAILURE
        lli     at, id.BTT_CRASH
        beq     t6, at, _continue           // if BTT_CRASH, show FAILURE
        lli     at, id.BTP_CRASH
        beq     t6, at, _continue           // if BTP_CRASH, show FAILURE
        nop

        li      at, function_table          // at = function table
        sll     t6, t6, 0x0002              // t6 = offset in function table
        addu    at, at, t6                  // at = address in function table
        srl     t6, t6, 0x0002              // t6 = stage_id again
        lw      at, 0x0000(at)              // at = 0 if Bonus
        bnez    at, _take_branch            // account for new stage ids
        nop

        _continue:
        j       _id_fix_5_return            // don't take branch
        nop

        _take_branch:
        j       0x80114CC8                  // branch to take
        nop
    }

    // DONE
    // 8013C2BC - same as above except does not alter gameset/failure. unsure of what this does
    // solution: same as above, probably won't hurt
    scope id_fix_6_: {
        OS.patch_start(0x000B6D00, 0x8013C2C0)
        jal     id_fix_6_
        nop
        nop
        OS.patch_end()

        OS.patch_start(0x000B6E48, 0x8013C408)
        jal     id_fix_6_
        nop
        nop
        OS.patch_end()

        OS.patch_start(0x000B6F90, 0x8013C550)
        jal     id_fix_6_
        nop
        nop
        OS.patch_end()

        slti    at, v0, 0x0011              // original line 1
        bnez    at, _take_branch            // original line 2 (modified)
        nop

        li      at, class_table             // at = class_table
        addu    at, at, v0                  // at = address of class
        lbu     at, 0x0000(at)              // at = class
        beqz    at, _take_branch            // take branch when a battle stage
        nop

        j       0x8013C2E4                  // branch to complete/failure
        nop

        _take_branch:
        j       0x8013C2EC                  // branch to battle end
        lli     at, 0x0000                  // at = 0
    }

    // @ Description
    // This uses our class table to determine which branches to take so that new stages work
    scope bonus_fix_1_: {
        constant BTP_JAL(0x8018DC38)
        constant BTT_JAL(0x8018D5C8)

        OS.patch_start(0x00080F20, 0x80105720)
        jal     bonus_fix_1_
        nop
        beq     r0, r0, 0x8010574C          // skip to end
        nop
        OS.patch_end()

        // v0 is stage_id
        li      at, class_table             // at = class_table
        addu    at, at, v0                  // at = address of class
        lbu     at, 0x0000(at)              // at = class

        beqz    at, _return                 // if at = class.BATTLE (0), then skip to end
        nop

        addiu   sp, sp,-0x0010              // allocate stack space
        sw      t0, 0x0004(sp)              // ~
        sw      t1, 0x0008(sp)              // ~
        sw      ra, 0x000C(sp)              // save registers

        lli     t0, class.BTT               // t0 = class.BTT
        li      t1, BTT_JAL                 // t1 = BTT_JAL
        beq     t0, at, _end                // if BTT, use BTT_JAL
        nop

        li      t1, BTP_JAL                 // else use BTP_JAL

        _end:
        jalr    t1                          // call routine
        nop

        lw      t0, 0x0004(sp)              // ~
        lw      t1, 0x0008(sp)              // ~
        lw      ra, 0x000C(sp)              // restore registers
        addiu   sp, sp, 0x0010              // deallocate stack space

        _return:
        jr      ra
        nop
    }

    // @ Description
    // This allows us to extend the hardcodings for targets
    scope bonus_fix_2_: {
        OS.patch_start(0x111B00, 0x8018D3C0)
        jal     bonus_fix_2_
        nop
        swc1    f20, 0x0050(sp)
        swc1    f20, 0x004C(sp)
        swc1    f20, 0x0048(sp)
        nop
        OS.patch_end()

        // t7 is stage_id
        li      t0, bonus_pointer_table    // t0 = bonus_pointer_table
        sll     t8, t7, 0x0002             // t8 = offset in bonus_pointer_table
        addu    t0, t0, t8                 // t0 = address in bonus_pointer_table
        lw      v0, 0x0000(t0)             // v0 = bonus pointer

        jr      ra
        nop
    }

    // @ Description
    // This corrects some ID checks related to determining BTT or BTP
    scope bonus_fix_3_: {
        OS.patch_start(0x11248C, 0x8018DD4C)
        jal     bonus_fix_3_
        ori     a2, a2, 0xD97C             // original line 1
        OS.patch_end()

        OS.patch_start(0x1127E8, 0x8018E0A8)
        jal     bonus_fix_3_
        lbu     t7, 0x0001(t6)             // original line 1
        OS.patch_end()

        OS.patch_start(0x1130C0, 0x8018E980)
        jal     bonus_fix_3_
        lbu     t7, 0x0001(a0)             // original line 1
        OS.patch_end()

        OS.patch_start(0x1132C8, 0x8018EB88)
        jal     bonus_fix_3_
        lbu     t7, 0x0001(v0)             // original line 1 (modified for t7 instead of t3)
        lui     a0, 0x8013                 // original line 2
        OS.patch_end()

        addiu   sp, sp,-0x0008             // allocate stack space
        sw      a1, 0x0004(sp)             // save registers

        // t7 is stage_id
        li      at, class_table            // at = class_table
        addu    at, at, t7                 // at = address of class
        lbu     at, 0x0000(at)             // at = class

        lli     a1, class.BTT              // a1 = class.BTT
        beql    a1, at, _return            // if BTT, set at to 1 and return
        lli     at, 0x0001                 // ~

        lli     at, 0x0000                 // otherwise set at to 0

        _return:
        lw      a1, 0x0004(sp)             // restore registers
        addiu   sp, sp, 0x0008             // deallocate stack space

        jr      ra                         // return
        nop
    }

    // @ Description
    // This allows us to extend the hardcodings for platforms
    scope bonus_fix_4_: {
        OS.patch_start(0x1122B4, 0x8018DB74)
        swc1    f20, 0x0050(sp)            // original line 4
        swc1    f20, 0x004C(sp)            // original line 5
        swc1    f20, 0x0048(sp)            // original line 6
        lbu     t1, 0x0001(v1)             // original line 7
        addiu   s4, sp, 0x0050             // original line 9

        // t3, t4 and v0 need to be set

        // t7 is stage_id
        li      t9, bonus_pointer_table    // t9 = bonus_pointer_table
        sll     t8, t7, 0x0002             // t8 = offset in bonus_pointer_table
        addu    t9, t9, t8                 // t9 = address in bonus_pointer_table
        lw      t0, 0x0000(t9)             // t0 = bonus pointer

        lw      t3, 0x0000(t0)             // t3 = offset 1
        lw      t4, 0x0004(t0)             // t4 = offset 2

        subu    v0, a1, t3                 // original line 8, modified
        OS.patch_end()
    }

    // @ Description
    // Disable original L/R and C button behavior
    // left
    OS.patch_start(0x0014FC54, 0x801340E4)
    addiu    a0, r0, Joypad.DL
    OS.patch_end()
    // right
    OS.patch_start(0x0014FD58, 0x801341E8)
    addiu    a0, r0, Joypad.DR
    OS.patch_end()
    // down
    OS.patch_start(0x0014FB84, 0x80134014)
    addiu    a0, r0, Joypad.DD
    OS.patch_end()
    // up
    OS.patch_start(0x0014FAB0, 0x80133F40)
    addiu    a0, r0, Joypad.DU
    OS.patch_end()

    // @ Description
    // Allows series logo drawn on wood circle to be defined for each stage using our custom table
    scope extend_series_logos_: {
        // use our offset table
        OS.patch_start(0x0014E41C, 0x801328AC)
        sw      ra, 0x0014(sp)                  // original line 4
        sw      a0, 0x0040(sp)                  // original line 5

        jal     get_stage_id_                   // v0 = stage_id
        nop
        sw      v0, 0x0044(sp)                  // save stage_id
        or      t1, v0, r0                      // t1 = stage_id
        li      t8, series_logo_table
        addu    t8, t8, v0                      // t8 = offset to series logo ID
        lbu     t8, 0x0000(t8)                  // t8 = series logo ID
        sw      t8, 0x0018(sp)                  // save series logo ID
        lli     t2, 0x000C                      // size of entries in table
        multu   t8, t2                          // mflo = offset in table

        li      v0, CharacterSelect.series_logo.table // replace lines 1-3 with our table
        b       0x801328FC
        lli     at, id.RANDOM                   // original line 19
        OS.patch_end()

        OS.patch_start(0x0014E4BC, 0x8013294C)
        mflo    t1                              // original line 2, modified to get correct offset for our table
        OS.patch_end()

        // use our position table
        OS.patch_start(0x0014E364, 0x801327F4)
        // a1 = stage_id
        lli     at, id.RANDOM                   // original line 16
        beq     a1, at, 0x8013284C              // modified random stages check
        nop
        li      v1, CharacterSelect.series_logo.table + 4 // replace lines 1-3 with our table
        li      t8, series_logo_table
        addu    t8, t8, a1                      // t8 = offset to series logo ID
        lbu     t8, 0x0000(t8)                  // t8 = series logo ID
        lli     t2, 0x000C                      // size of entries in table
        multu   t8, t2                          // mflo = offset in table
        mflo    t3                              // t3 = offset in table
        b       0x80132870                      // jump to rest of routine which sets the X/Y
        addu    v0, v1, t3                      // original line 20
        OS.patch_end()
    }

    // @ Description
    // Prevents the drawing of default stage icons
    OS.patch_start(0x0014E098, 0x80132528)
    jr      ra                              // return
    nop
    OS.patch_end()

    // @ Description
    // Prevents "Stage Select" texture from being drawn.
    OS.patch_start(0x0014DDF8, 0x80132288)
    //jr      ra                              // return immediately
    //nop
    OS.patch_end()

    // @ Description
    // Repositions "Stage Select" texture a little lower.
    OS.patch_start(0x0014DE80, 0x80132310)
    lui     at, 0x4300                      // original: lui     at, 0x42F4
    OS.patch_end()

    // @ Description
    // Prevents yellow stage name holder from being drawn.
    OS.patch_start(0x0014DEC4, 0x80132354)
    b       0x8013240C                      // skip to end of routine
    OS.patch_end()

    // @ Description
    // Repositions the blue bar behind "Stage Select" a little lower.
    OS.patch_start(0x0014DD34, 0x801321C4)
    ori     t7, t7, 0x0232                  // original line 1: ori     t7, t7, 0x0218
    ori     t8, t8, 0x021A                  // original line 2: ori     t8, t8, 0x0200
    OS.patch_end()

    // @ Description
    // Skips rendering a semitransparent rectangle on the wooden circle
    OS.patch_start(0x0014DD44, 0x801321D4)
    fill 16 * 4, 0x0 // nop 16 lines
    OS.patch_end()

    // @ Description
    // Prevents the wooden circle from being drawn.
    OS.patch_start(0x0014DBB8, 0x80132048)
//  jr      ra                              // return immediately
//  nop
    OS.patch_end()

    // @ Description
    // Prevents stage name text from being drawn.
    OS.patch_start(0x0014E2A8, 0x80132738)
    jr      ra                              // return immediately
    nop
    OS.patch_end()

    // Modifies the x/y position of the models on the stage select screen.
    OS.patch_start(0x0014F514, 0x801339A4)
//  lwc1    f16,0x0000(v0)                  // original line 1 (f16 = (float) x)
//  swc1    f16,0x0048(a0)                  // original line 2
//  lwc1    f18,0x0004(v0)                  // original line 3 (f18 = (float) y)
//  swc1    f18,0x004C(a0)                  // original line 4
    lui     t8, 0x44C8                      // t8 = (float) 1600S
    sw      t8, 0x0048(a0)                  // x = 1600
    sw      t8, 0x004C(a0)                  // y = 1600
    nop
    OS.patch_end()

    // @ Description
    // These following functions are designed to fix get_header_ for RANDOM.
    scope random_fix_1_: {
        OS.patch_start(0x0014EF2C, 0x801333BC)
        j       random_fix_1_
        nop
        _random_fix_1_return:
        OS.patch_end()

        addiu   at, r0, 0x00DE                  // original line 1

        addiu   sp, sp,-0x0010                  // allocate stack space
        sw      v0, 0x0004(sp)                  // ~
        sw      ra, 0x0008(sp)                  // restore registers

        jal     get_stage_id_                   // v0 = stage_id
        nop
        move    a0, v0                          // a0 = stage_id

        lw      v0, 0x0004(sp)                  // ~
        lw      ra, 0x0008(sp)                  // restore registers
        addiu   sp, sp, 0x0010                  // deallocate stack space
        j       _random_fix_1_return            // return
        or      s0, a0, r0                      // original line 2
    }

    scope random_fix_2_: {
        OS.patch_start(0x0014EFC4, 0x80133454)
        j       random_fix_2_
        or      a1, s0, r0                      // original line 4
        _random_fix_2_return:
        jal     0x8013390C                      // original line 3
        lw      a0, 0x4C14(a0)                  // original line 2
        OS.patch_end()

        // Ideally we'd be customizing camera position for all stages, but we aren't, so we'll just make sure all new stages are consistent
        sltiu   at, s0, id.MUSHROOM_KINGDOM + 1 // at = 1 if a vanilla stage
        beqzl   at, pc() + 8                    // if not a vanilla stage, always pretend its Peach's Castle for consistency
        lli     a1, id.PEACHS_CASTLE            // a1 = Peach's Castle
        j       _random_fix_2_return
        lui     a0, 0x8013                      // original line 1
    }

    scope random_fix_3_: {
        OS.patch_start(0x0014E950, 0x80132DE0)
        j       random_fix_3_
        nop
        _random_fix_3_return:
        OS.patch_end()

//      bne     v1, at, 0x80132E18              // check if training mode. original line 1
//      lui     t0, 0x8013                      // original line 2

        addiu   sp, sp,-0x0010                  // allocate stack space
        sw      ra, 0x0004(sp)                  // ~
        sw      v0, 0x0008(sp)                  // save registers

        jal     get_stage_id_                   // v0 = stage_id
        nop
        bne     at, v0, _take_branch
        sw      v0, 0x000C(sp)                  // save stage id

        _default:
        lw      ra, 0x0004(sp)                  // ~
        lw      v0, 0x0008(sp)                  // restore registers
        addiu   sp, sp, 0x0010                  // deallocate stack
        j       _random_fix_3_return            // return
        nop

        _take_branch:
        li      v1, background_table            // at = stage background table
        addu    v1, v1, v0                      // v1 = offset to byte in offset table
        lb      v1, 0x0000(v1)                  // v1 = parent stage id?

        lw      ra, 0x0004(sp)                  // ~
        lw      v0, 0x0008(sp)                  // restore registers
        addiu   sp, sp, 0x0010                  // deallocate stack
        j       0x80132E18                      // check if training mode (from original line 1)
        lui     t0, 0x8013                      // original line 2
    }

    // @ Description
    // Modifies the positioning of the stage model previews.
    scope set_preview_position_: {
        OS.patch_start(0x0014ECE4, 0x80133174)
//      lwc1    f4, 0x0000(v1)              // original line 1
        j       set_preview_position_
        or      v0, s0, r0                  // original line 2
        _set_preview_position_return:
        OS.patch_end()

        li      t2, zoom_table              // ~
        addu    v1, t2, t1                  // v1 = address of zoom
        lwc1    f4, 0x0000(v1)              // f4 = zoom

        li      t0, position_table
        addu    t0, t0, t1                  // t0 = address of position array pointer
        lw      t0, 0x0000(t0)              // t0 = position array address, or 0
        beqz    t0, _end                    // if no position array, skip
        nop

        lwc1    f6, 0x0000(t0)              // f6 = X position
        lwc1    f8, 0x0004(t0)              // f8 = Y position
        swc1    f6, 0x001C(t5)              // set X position
        lwc1    f6, 0x0008(t0)              // f6 = Z position
        swc1    f8, 0x0020(t5)              // set Y position
        swc1    f6, 0x0024(t5)              // set Z position

        _end:
        j       _set_preview_position_return
        nop
    }

    // @ Description
    // This functions modifies which header file is drawn based on stage_table
    scope get_header_: {
        OS.patch_start(0x0014E708, 0x80132B98)
        j       get_header_
        nop
        _get_header_return:
        OS.patch_end()

        addiu   sp, sp,-0x0010                  // allocate stack space
        sw      ra, 0x0004(sp)                  // ~
        sw      t0, 0x0008(sp)                  // ~
        sw      v0, 0x000C(sp)                  // save registers

        jal     get_stage_id_                   // v0 = stage_id
        nop
        addiu   t0, r0, id.TIME_TWISTER
        bne     v0, t0, _standard              // This branch is done for Time Twister, it loads an alternate model for the SSS
        nop
        li      v0, id.TIME_TWISTER_SSS

        _standard:
        sll     v0, v0, 0x0003                  // t0 = offset << 3 (offset * 8)
        li      t0, stage_file_table            // ~
        addu    t0, v0, t0                      // t0 = address of header file

        addu    v1, t6, t7                      // original line 1
//      lw      a0, 0x0000(v1)                  // original line 2
        lw      a0, 0x0000(t0)                  // a0 - file header id

        lw      ra, 0x0004(sp)                  // ~
        lw      t0, 0x0008(sp)                  // ~
        lw      v0, 0x000C(sp)                  // restore registers
        addiu   sp, sp, 0x0010                  // deallocate stack space
        j       _get_header_return              // return
        nop
    }

    // @ Description
    // This functions modifies which preview type is used based on stage_table
    scope get_type_: {
        OS.patch_start(0x0014E720, 0x80132BB0)
        j       get_type_
        nop
        _get_type_return:
        OS.patch_end()

        addiu   sp, sp,-0x0010                  // allocate stack space
        sw      ra, 0x0004(sp)                  // ~
        sw      t0, 0x0008(sp)                  // ~
        sw      v0, 0x000C(sp)                  // save registers

        jal     get_stage_id_                   // v0 = stage_id
        nop
        sll     v0, v0, 0x0003                  // t0 = offset << 3 (offset * 8)
        li      t0, stage_file_table            // ~
        addu    t0, v0, t0                      // t0 = address of header file
        addiu   t0, t0, 0x0004                  // t0 = address of type
        lw      t8, 0x0000(t0)                  // t8 = type

        lw      ra, 0x0004(sp)                  // ~
        lw      t0, 0x0008(sp)                  // ~
        lw      v0, 0x000C(sp)                  // resore registers
        addiu   sp, sp, 0x0010                  // deallocate stack space
        lui     at, 0x8013                      // original line 1
//      lw      t8, 0x0004(v1)                  // original line 2
        j       _get_type_return                // return
        nop
    }

    // @ Description
    // Increases the available object heap space on the stage select screen.
    // This is necessary to support the extra icons.
    // Can probably reduce how much is added, but shouldn't hurt anything.
    OS.patch_start(0x1504B4, 0x80134944)
    dw      0x00004268 + 0x2000                 // pad object heap space (0x00004289 is original amount)
    OS.patch_end()

    // @ Description
    // This updates a check on available RAM to include expansion RAM
    scope adjust_heap_check_: {
        OS.patch_start(0x9000C, 0x8011480C)
        addiu   sp, sp, -0x0020             // original line 2
        sw      ra, 0x0014(sp)              // original line 3
        jal     adjust_heap_check_
        lw      t7, 0x000C(v0)              // original line 1 - t7 = current free memory address
        OS.patch_end()

        // t6 = end of heap

        OS.read_word(CharacterSelect.expansion_expansion_ram + 4, at) // at = expansion expansion RAM end address
        bnez    at, _include_expansion_expansion_ram // if we've extended to expansion RAM, include expansion expansion RAM
        lui     t8, 0x8080                  // t8 = 0x80800000 = end of expansion RAM
        beq     t6, t8, _end                // if we've already extended the heap, then continue normally
        subu    t8, t6, t7                  // original line 4 - t8 = remaining heap space

        // if we're here, add all of expansion RAM to t8
        lui     at, 0x0400                  // at = 0x00400000 = size of expansion RAM
        addu    t8, t8, at                  // t8 = actual remaining size

        _end:
        jr      ra
        nop

        _include_expansion_expansion_ram:
        bne     t6, t8, _end                // if we've already extended the heap twice, then continue normally
        subu    t8, t6, t7                  // original line 4 - t8 = remaining heap space

        OS.read_word(CharacterSelect.expansion_expansion_ram, t7) // t7 = expansion expansion RAM start address
        subu    at, at, t7                  // at = expansion expansion RAM size
        jr      ra
        addu    t8, t8, at                  // t8 = actual remaining size
    }

    // @ Description
    // Decreases the vanilla heap space to avoid overwriting routines we use (and the game uses even!)
    // We can do this because we extend the heap to expansion RAM if we run out of vanilla heap space.
    scope reduce_heap_space_: {
        // 1p/RTTF
        OS.patch_start(0x10F888, 0x80191028)
        addiu   t1, t1, 0x03E0              // reduce from 0x80392A00 to 0x803903E0
        OS.patch_end()
        // Training
        OS.patch_start(0x116E54, 0x80190634)
        addiu   t8, t8, 0x03E0              // reduce from 0x80392A00 to 0x803903E0
        OS.patch_end()
        // Bonus
        OS.patch_start(0x113240, 0x8018EB00)
        addiu   t8, t8, 0x03E0              // reduce from 0x80392A00 to 0x803903E0
        OS.patch_end()
        // VS
        OS.patch_start(0x10B0F8, 0x8018E208)
        addiu   t6, t6, 0x03E0              // reduce from 0x80392A00 to 0x803903E0
        OS.patch_end()
        // VS Demo
        OS.patch_start(0x18CD88, 0x8018E048)
        addiu   t8, t8, 0x03E0              // reduce from 0x80392A00 to 0x803903E0
        OS.patch_end()
    }

    // @ Description
    //
    scope update_stage_icons_: {
        // a0 = stage icons base file address

        li      a1, stage_table_pages       // a1 = stage_table_pages
        li      t0, image_table             // t0 = image table start
        li      t2, stage_table             // t2 = stage_table
        li      t1, Toggles.entry_sss_layout
        lw      t1, 0x0004(t1)              // t1 = stage table index
        sll     t1, t1, 0x0002              // t1 = offset to stage_table to use
        addu    a1, a1, t1                  // a1 = address of NUM_PAGES for this stage_table
        lw      a1, 0x0000(a1)              // a1 = NUM_PAGES for this stage_table
        lli     t5, NUM_ICONS               // t5 = NUM_ICONS
        multu   a1, t5                      // a1 = NUM_ICONS * NUM_PAGES = number of stage icon addresses to calculate
        mflo    a1                          // ~
        addu    t2, t2, t1                  // t2 = address of stage_table pointer
        lw      t1, 0x0000(t2)              // t1 = current stage table
        li      t5, icon_offset_table       // t5 = icon_offset_table
        li      t6, icon_offset_random      // t6 = random icon offset
        lw      t6, 0x0000(t6)              // ~

        _loop:
        lbu     t4, 0x0000(t1)              // t4 = stage id
        lli     t2, id.RANDOM               // t2 = id.RANDOM
        beql    t4, t2, pc() + 20           // if RANDOM, then skip getting from icon_offset_table
        addu    t4, r0, t6                  // ...and use random offset instead
        sll     t4, t4, 0x0002              // t4 = offset to offset table offset (lol)
        addu    t4, t5, t4                  // t4 = address of offset
        lw      t4, 0x0000(t4)              // t4 = offset to icon image footer
        addu    t2, a0, t4                  // t4 = icon image footer address
        sw      t2, 0x0000(t0)              // set new address

        addiu   a1, a1, -0x0001             // a1 = remaining images
        addiu   t0, t0, 0x0004              // t0 = next image in image table to set
        bnezl   a1, _loop                   // if there is another image, loop
        addiu   t1, t1, 0x0001              // t1 = next stage id

        _end:
        jr      ra
        nop
    }

    // @ Description
    // Modify the code that runs after the cursor's TEXTURE_INIT_ call.
    // Do it more efficiently so we can also update the scale and color.
    OS.patch_start(0x0014E6B0, 0x80132B40)
    lli     t1, 0x0201                  // t1 = 0x201
    sh      t1, 0x0024(v0)              // set image type flags
    lui     t2, 0x3F58                  // t2 = scale = 0.84375
    sw      t2, 0x0018(v0)              // set X scale
    sw      t2, 0x001C(v0)              // set Y scale
    li      t0, Toggles.entry_hazard_mode
    jal     update_cursor_color_
    lw      a0, 0x0004(t0)              // a0 = hazard_mode
    OS.patch_end()

    // @ Description
    // The routine starting here sets the cursor position based on
    // the value passed in a1, which can be thought of as the index.
    // Let's just ignore and use our column and row values.
    OS.patch_start(0x0014E5C8, 0x80132A58)
    // a0 = object struct
    // a1 = index
    lw      t8, 0x0074(a0)              // t8 = cursor image struct

    // Set X position
    li      a1, column                  // a1 = COLUMN address
    lbu     t9, 0x0000(a1)              // t9 = COLUMN
    lli     t6, ICON_WIDTH + 2          // t6 = ICON_WIDTH
    multu   t6, t9                      // t6 = ICON_WIDTH * COLUMN
    mflo    t6                          // ~
    addiu   t7, t6, 0x0018              // t7 = X position, adjusted for left padding
    mtc1    t7, f4                      // f4 = X position
    cvt.s.w f6, f4                      // f6 = X position as float
    swc1    f6, 0x0058(t8)              // set X position

    // Set Y position
    li      a1, row                     // a1 = ROW address
    lbu     t9, 0x0000(a1)              // t9 = ROW
    lli     t6, ICON_HEIGHT + 2         // t6 = ICON_HEIGHT
    multu   t6, t9                      // t6 = ICON_HEIGHT * ROW
    mflo    t6                          // ~
    addiu   t7, t6, 0x000E              // t7 = Y position, adjusted for top padding
    mtc1    t7, f4                      // f4 = Y position
    cvt.s.w f6, f4                      // f6 = Y position as float
    swc1    f6, 0x005C(t8)              // set Y position

    jr      ra
    nop
    OS.patch_end()

    // @ Description
    // Returns an index based on column and row
    // @ Returns
    // v0 - index
    scope get_index_: {
        addiu   sp, sp,-0x0010              // allocate stack space
        sw      t0, 0x0004(sp)              // ~
        sw      t1, 0x0008(sp)              // ~
        sw      t2, 0x000C(sp)              // save registers

        li      t0, row                     // ~
        lbu     t0, 0x0000(t0)              // t0 = row
        li      t1, column                  // ~
        lbu     t1, 0x0000(t1)              // t1 = column
        lli     t2, NUM_COLUMNS             // t2 = NUM_COLUMNS
        multu   t0, t2                      // ~
        mflo    v0                          // v0 = row * NUM_COLUMNS
        addu    v0, v0, t1                  // v0 = row * NUM_COLUMNS + column

        lw      t0, 0x0004(sp)              // ~
        lw      t1, 0x0008(sp)              // ~
        lw      t2, 0x000C(sp)              // restore registers
        addiu   sp, sp, 0x0010              // deallocate stack space
        jr      ra
        nop
    }

    // @ Description
    // Checks the page and makes sure it's within bounds.
    // NOTE: I don't do this in setup_ because get_stage_id_ is called before setup_.
    scope check_valid_page_: {
        addiu   sp, sp, -0x0018             // allocate stack space
        sw      at, 0x0004(sp)              // save registers
        sw      t0, 0x0008(sp)              // ~
        sw      t1, 0x000C(sp)              // ~
        sw      t2, 0x0010(sp)              // ~

        // Initialize page
        li      t0, page_number             // t0 = page_number
        lw      at, 0x0000(t0)              // at = current page
        li      t1, stage_table_pages       // t1 = stage_table_pages
        li      t2, Toggles.entry_sss_layout
        lw      t2, 0x0004(t2)              // t2 = stage table index
        sll     t2, t2, 0x0002              // t2 = offset to stage_table to use
        addu    t1, t1, t2                  // t1 = address of NUM_PAGES for this stage_table
        lw      t2, 0x0000(t1)              // t2 = NUM_PAGES for this stage_table
        bgt     t2, at, _end                // if current page is not too high, finish
        nop

        // if here, then we need to reset the page to 0 and update the image_table_pointer
        sw      r0, 0x0000(t0)              // reset current page to 0
        li      t0, image_table_pointer     // t0 = image_table_pointer
        li      t1, image_table             // t1 = image_table start addres
        sw      t1, 0x0000(t0)              // store new image_table address

        _end:
        lw      at, 0x0004(sp)              // restore registers
        lw      t0, 0x0008(sp)              // ~
        lw      t1, 0x000C(sp)              // ~
        lw      t2, 0x0010(sp)              // ~
        jr      ra
        addiu   sp, sp, 0x0018              // deallocate stack space
    }

    // @ Description
    // returns a stage id based on cursor position
    // @ Returns
    // v0 - stage_id
    scope get_stage_id_: {
        addiu   sp, sp,-0x0018              // allocate stack space
        sw      t0, 0x0004(sp)              // ~
        sw      ra, 0x0008(sp)              // ~
        sw      t1, 0x000C(sp)              // ~
        sw      t2, 0x0010(sp)              // ~
        sw      t3, 0x0014(sp)              // save registers

        jal     check_valid_page_
        nop

        jal     get_index_                  // v0 = index
        nop
        li      t1, page_number             // ~
        lw      t1, 0x0000(t1)              // ~
        lli     t2, NUM_ICONS               // ~
        mult    t1, t2                      // multiply NUM_ICONS by page
        mflo    t1                          // ~
        addu    v0, v0, t1                  // add additional offset
        li      t0, stage_table             // t0 = address of stage table
        li      t1, Toggles.entry_sss_layout
        lw      t1, 0x0004(t1)              // t1 = stage table index
        sll     t1, t1, 0x0002              // t1 = offset to stage_table to use
        addu    t0, t0, t1                  // t0 = address of stage_table pointer
        lw      t0, 0x0000(t0)              // t0 = address of stage_table to use
        addu    t0, t0, v0                  // t0 = address of stage table + offset
        lbu     v0, 0x0000(t0)              // v0 = stage_id
        li      t0, original_stage_id
        sb      v0, 0x0000(t0)              // save stage_id without variant
        lli     t0, id.RANDOM
        beq     t0, v0, _end                // if on the random ID square, skip variant check
        nop

        beqz    t1, _check_variant          // if not on tournament layout, skip to variant check
        nop

        // checks for specific duplicate stages that require different Hazard types depending on Page
        li      t3, page_number             // ~
        lw      t3, 0x0000(t3)              // ~
        lli     t0, id.DREAM_LAND           // t0 = Dream Land stage_id
        bne     v0, t0, _dreamland_checked  // branch accordingly
        nop
        sltiu   t1, t3, 2                   // t1 = 1 if on Page 1 or 2
        beqzl   t1, _force_hazard_mode      // set Hazard 'OFF' if on Page 3 DREAM_LAND
        lli     t0, Hazards.mode.HAZARDS_OFF_MOVEMENT_ON
        _dreamland_checked:
        lli     t0, id.YOSHI_ISLAND_DL      // t0 = Yoshi's Island DL stage_id
        bne     v0, t0, _yoshi_dl_checked   // branch accordingly
        nop
        sltiu   t1, t3, 2                   // t1 = 1 if on Page 1 or 2
        bnezl   t1, _force_hazard_mode      // set Hazard 'ON' if on Page 2 YOSHI_ISLAND_DL
        lli     t0, Hazards.mode.HAZARDS_ON_MOVEMENT_ON
        _yoshi_dl_checked:
        lli     t0, id.SAFFRON_DL           // t0 = Saffron City DL stage_id
        bne     v0, t0, _saffron_dl_checked // branch accordingly
        nop
        sltiu   t1, t3, 2                   // t1 = 0 if on Page 3
        beqzl   t1, _force_hazard_mode      // set Movement 'OFF' if on Page 3 SAFFRON_DL
        lli     t0, Hazards.mode.HAZARDS_ON_MOVEMENT_OFF

        _saffron_dl_checked:
        // if we're here, use default value from table
        li      t0, tournament_hazard_mode_table
        addu    t0, t0, v0                  // t0 = address of stage's tournament hazard mode value to force
        lbu     t0, 0x0000(t0)              // t0 = stage's tournament hazard mode value to force
        _force_hazard_mode:
        li      t1, Toggles.entry_hazard_mode
        b       _end                        // skip variant check
        sw      t0, 0x0004(t1)              // update hazard mode

        _check_variant:
        li      t0, variant
        lbu     t0, 0x0000(t0)              // t0 = variant_type selected
        beqz    t0, _end                    // if no variant selected, skip
        nop
        sll     t2, v0, 0x0003              // t2 = offset in variant_table
        li      t1, variant_table           // t1 = address of variant stage_id table
        addu    t1, t1, t0                  // t1 = address of variant, unadjusted
        addiu   t1, t1, -0x0001             // t1 = address of variant, adjusted
        addu    t1, t1, t2                  // t1 = address of variant for the selected stage
        lbu     t0, 0x0000(t1)              // t0 = variant stage_id
        ori     t1, r0, 0x00FF
        bnel    t0, t1, _end                // if there is a defined variant stage_id,
        or      v0, t0, r0                  // then use it

        _end:
        lw      t0, 0x0004(sp)              // ~
        lw      ra, 0x0008(sp)              // ~
        lw      t1, 0x000C(sp)              // ~
        lw      t2, 0x0010(sp)              // ~
        lw      t3, 0x0014(sp)              // restore registers
        addiu   sp, sp, 0x0018              // deallocate stack space
        jr      ra                          // return
        nop
    }

    // @ Description
    // Updates pointers to strings so the live strings update
    scope update_text_: {
        addiu   sp, sp, -0x0010             // allocate stack space
        sw      ra, 0x0004(sp)              // save ra

        // update the stage name text
        _stage_name:
        jal     get_stage_id_               // v0 = stage_id
        nop
        li      a1, stage_name              // a1 = stage_name
        lli     a0, id.RANDOM               // a0 = random
        beql    a0, v0, _hazard_text        // don't draw RANDOM
        sw      r0, 0x0000(a1)              // set stage name to blank
        sll     v0, v0, 0x0002              // v0 = offset = stage_id * 4
        li      a2, string_table            // a2 = address of string_table
        addu    a2, a2, v0                  // a2 = address of string_table + offset
        lw      a2, 0x0000(a2)              // a2 = address of string
        sw      a2, 0x0000(a1)              // set stage name

        // update the hazards/movement on/off text
        _hazard_text:
        jal     get_stage_id_               // v0 = stage_id
        nop
        li      a0, hazards_onoff           // a0 = pointer to string
        li      a2, string_on               // a2 = string on
        li      t0, Toggles.entry_whispy_mode
        lw      t1, 0x0004(t0)              // t1 = Whispy Mode (0 if normal)
        beqz    t1, _check_saffron_hazard_rate // if normal, keep current a2
        nop
        // check if we're hovering over 'Dream Land' (or a variant thereof)
        lli     t3, id.DREAM_LAND           // t3 = Dream Land stage
        beq     t3, v0, _whispy_hazard_text // branch accordingly
        lli     t3, id.WINTER_DL            // t3 = Dream Land stage
        beq     t3, v0, _whispy_hazard_text // branch accordingly
        lli     t3, id.DREAM_LAND_O         // t3 = Dream Land stage
        beq     t3, v0, _whispy_hazard_text // branch accordingly
        lli     t3, id.DREAM_LAND_SR        // t3 = Dream Land stage
        beq     t3, v0, _whispy_hazard_text // branch accordingly
        nop
        b       _check_saffron_hazard_rate  // if not hovering over Dream Land, keep current a2
        nop

        _whispy_hazard_text:
        addiu   t0, r0, 0x0001              // J Whispy
        beq     t0, t1, _japanese           // if in J hazard mode, use current a2
        addiu   t0, r0, 0x0002              // Super Whispy
        beq     t0, t1, _super              // if in Super hazard mode, use current a2
        addiu   t0, r0, 0x0003              // Hyper Whispy
        beq     t0, t1, _hyper              // if in Hyper hazard mode, use current a2
        nop

        // check if we're hovering over 'Saffron' with a non-default Rate
        _check_saffron_hazard_rate:
        li      t0, Toggles.entry_saffron_poke_rate
        lw      t1, 0x0004(t0)              // t1 = saffron_poke_rate (0 if DEFAULT, 1 if SUPER, 2 if HYPER, 3 if "QUICK ATTACK")
        beqz    t1, _check_hazards_on_off   // if normal, keep current a2
        nop
        lli     t3, id.SAFFRON_CITY         // t3 = Saffron City stage
        bne     t3, v0, _check_hazards_on_off // branch accordingly
        nop

        _saffron_rate_hazard_text:
        addiu   t0, r0, 0x0001              // Saffron Pokemon rate "SUPER"
        beq     t0, t1, _super              // if in Super hazard mode, use current a2
        addiu   t0, r0, 0x0002              // Saffron Pokemon rate "HYPER"
        beq     t0, t1, _hyper              // if in Hyper hazard mode, use current a2
        addiu   t0, r0, 0x0003              // Saffron Pokemon rate "QUICK ATTACK"
        beq     t0, t1, _quick_attack       // if in Quick Attack hazard mode, use current a2
        nop

        _japanese:
        li      a2, string_on_j             // a2 = string on J
        beq     r0, r0, _check_hazards_on_off
        nop

        _super:
        li      a2, string_on_s             // a2 = string on S
        beq     r0, r0, _check_hazards_on_off
        nop

        _hyper:
        li      a2, string_on_h             // a2 = string on H
        beq     r0, r0, _check_hazards_on_off
        nop

        _quick_attack:
        li      a2, string_on_q             // a2 = string on Q
        beq     r0, r0, _check_hazards_on_off
        nop

        _check_hazards_on_off:
        li      t0, Toggles.entry_hazard_mode
        lw      t1, 0x0004(t0)              // t1 = hazard_mode

        li      t3, Toggles.entry_sss_layout
        lw      t3, 0x0004(t3)               // t3 = stage table index (1 if tournament)
        beqz    t3, pc() + 16                // if not on tournament layout, skip
        lli     t3, id.RANDOM                // t3 = id.RANDOM
        beql    v0, t3, pc() + 8             // if (stage_id = id.RANDOM), show (ON/ON)
        or      t1, r0, r0                   // t1 = 0 (ON/ON)

        andi    t0, t1, 0x0001              // t0 = 1 if hazard_mode is 1 or 3, 0 otherwise
        beqz    t0, _update_hazards_on_off  // if hazards on, use current a2
        nop
        li      a2, string_off              // a2 = string off
        _update_hazards_on_off:
        sw      a2, 0x0000(a0)              // update pointer

        li      a0, movement_onoff          // a0 = pointer to string
        srl     t0, t1, 0x0001              // t0 = 1 if hazard_mode is 2 or 3, 0 otherwise
        li      a2, string_on               // a2 = string on
        beqz    t0, _update_movement_on_off // if movement on, use current a2
        nop
        li      a2, string_off              // a2 = string off
        _update_movement_on_off:
        sw      a2, 0x0000(a0)              // update pointer
        nop

        // Dynamic Hazard Text (indicates what types of hazards the selected stage has available)
        jal     get_stage_id_               // v0 = stage_id
        nop

        li      t1, stage_hazard_table       // t1 = address of variant stage_id table
        addu    t1, t1, v0                   // t1 = stage_hazard_table + offset
        lbu     t1, 0x0000(t1)               // t1 = hazard_type selected

        andi    t0, t1, Hazards.type.HAZARDS // t0 = 1 if hazard_type is HAZARDS or BOTH, 0 otherwise
        bnez    t0, _dht_hazard              // branch accordingly
        lli     a1, 0x0000                   // a1 = 0 (Display On)
        lli     t0, id.RANDOM                // t0 = id.RANDOM
        bnel    v0, t0, _dht_hazard          // if (stage_id = !id.RANDOM), hide
        lli     a1, 0x0001                   // a1 = 1 (Display Off)

        _dht_hazard:
        jal     Render.toggle_group_display_
        lli     a0, 0xD                      // a0 = group

        andi    t0, t1, Hazards.type.MOVEMENT// t0 = 1 if hazard_type is MOVEMENT or BOTH, 0 otherwise
        bnez    t0, _update_freeze          // branch accordingly
        lli     a1, 0x0000                  // a1 = 0 (Display On)
        lli     t0, id.RANDOM               // t0 = id.RANDOM
        beq     v0, t0, _dht_movement       // if (stage_id = id.RANDOM), skip
        nop
        lli     a1, 0x0001                  // a1 = 1 (Display Off)
        _update_freeze:
        li      a0, dont_freeze_stage       // a0 = address of dont_freeze_stage
        sw      a1, 0x0000(a0)              // update
        _dht_movement:
        jal     Render.toggle_group_display_
        lli     a0, 0xE                     // a0 = group

        // show Layout text when there are alt layouts
        lli     a0, id.RANDOM               // a0 = random
        li      t0, original_stage_id
        lbu     v1, 0x0000(t0)              // v1 = stage_id without variant
        bnel    a0, v1, _check_layout_table // branch if not RANDOM
        lli     a1, 0x0001                  // a1 = 1 (Display Off)

        // if RANDOM, instead draw Settings text
        lli     a1, 0x0000                  // a1 = 0 (Display On)
        jal     Render.toggle_group_display_
        lli     a0, 0xF                     // a0 = group
        b       _layout_group               // don't draw layout text for RANDOM
        lli     a1, 0x0001                  // a1 = 1 (Display Off)

        _check_layout_table:
        jal     Render.toggle_group_display_
        lli     a0, 0xF                     // a0 = group
        li      t1, variant_table           // t1 = address of variant stage_id table
        sll     a2, v1, 0x0003              // a2 = offset of original stage_id
        addu    t1, t1, a2                  // t1 = address of variants for the selected stage
        lw      t3, 0x0000(t1)              // t3 = variants array, 1st half
        lw      t2, 0x0004(t1)              // t2 = variants array, 2nd half
        and     t3, t3, t2                  // t3 = full variants array will be -1 if no variants
        addiu   t2, r0, -0x0001             // t2 = 0xFFFFFFFF (no variants)
        beql    t2, t3, _layout_group       // if no variants, then don't draw layout text
        lli     a1, 0x0001                  // a1 = 1 (Display Off)

        li      t0, Toggles.entry_sss_layout
        lw      t0, 0x0004(t0)              // t0 = stage table index
        bnezl   t0, _layout_group           // if tournament layout, then don't draw layout text
        lli     a1, 0x0001                  // a1 = 1 (Display Off)

        lli     a1, 0x0000                  // a1 = 0 (Display On)
        li      t0, variant
        lbu     t0, 0x0000(t0)              // t0 = variant_type selected
        addu    t1, t1, t0                  // t1 = address of variant stage id for selected stage, offset by 1
        lbu     t1, 0xFFFF(t1)              // t1 = variant stage id for selected stage
        lli     a0, 0x00FF                  // a0 = 0x000000FF (no stage for this variant type)
        beql    t1, a0, pc() + 8            // if no variant of this type, set variant type text to default
        lli     t0, variant_type.DEFAULT    // t0 = variant_type.DEFAULT
        sll     t0, t0, 0x0002              // t0 = offset to layout text
        li      a0, layout_pointer
        li      t1, layout_text_table
        addu    t1, t1, t0                  // t1 = address of layout string pointer
        lw      t1, 0x0000(t1)              // t1 = address of layout string
        sw      t1, 0x0000(a0)              // update pointer

        _layout_group:
        jal     Render.toggle_group_display_
        lli     a0, 0xC                     // a0 = group

        li      t3, Toggles.entry_sss_layout
        lw      t3, 0x0004(t3)               // t3 = stage table index (1 if tournament)
        beqz    t3, pc() + 16                // if not on tournament layout, skip
        lli     t3, id.RANDOM                // t3 = id.RANDOM
        beql    v0, t3, color_cursor         // if (stage_id = id.RANDOM), show red cursor
        or      a0, r0, r0                   // a0 = 0 (red)

        // update cursor color
        li      t2, Toggles.entry_hazard_mode
        lw      a0, 0x0004(t2)               // a0 = hazard_mode

        li      t1, stage_hazard_table       // t1 = address of variant stage_id table
        addu    t1, t1, v0                   // t1 = stage_hazard_table + offset
        lbu     t1, 0x0000(t1)               // t1 = hazard_type selected
        xori    t0, t1, Hazards.type.BOTH    // t0 = 0 if hazard_type is BOTH, 1 otherwise
        beqz    t0, color_cursor             // branch accordingly
        lli     t0, id.RANDOM                // t0 = id.RANDOM
        beq     v0, t0, color_cursor         // if (stage_id = id.RANDOM), branch
        nop
        beqzl   t1, color_cursor             // branch if hazard_type is NONE
        or      a0, r0, r0                   // a0 = 0 (red)

        // cursor is red if visible values are ON, corresponding blue if OFF
        and     t0, t1, a0                   // t0 = 1 if hazard_mode and hazard_type are equal
        beqzl   t0, color_cursor
        or      a0, r0, r0                   // a0 = 0 (red)

        addiu   t0, r0, Hazards.type.HAZARDS // t0 = hazard_type.HAZARDS
        beql    t1, t0, color_cursor         // branch accordingly
        addiu   a0, r0, 0x0001               // a0 = 1 (light blue)
        addiu   a0, r0, 0x0002               // a0 = 2 (lighter blue)

        color_cursor:
        jal     update_cursor_color_
        nop

        lw      ra, 0x0004(sp)              // restore ra
        addiu   sp, sp, 0x0010              // deallocate stack space
        jr      ra
        nop

        string_on:;  String.insert("On")
        string_on_j:;  String.insert("On (J)")
        string_on_s:;  String.insert("On (S)")
        string_on_h:;  String.insert("On (H)")
        string_off:;   String.insert("Off")
        string_on_q:;  String.insert("On (Q)")

        layout_NORMAL:; String.insert("Def.")
        layout_DL:; String.insert("DL")
        layout_O:; String.insert('~' + 1) // Omega
        layout_remix:; String.insert("Remix")

        layout_text_table:
        dw layout_NORMAL
        dw layout_DL
        dw layout_O
        dw layout_remix
        dw layout_remix     // remix 2
        dw layout_remix     // remix 3
    }

    // @ Arguments
    // a0 - hazard mode (0 - red, 1 - light blue, 2 - lighter blue, 3 - blue)
    scope update_cursor_color_: {
        addiu   sp, sp,-0x0010              // allocate stack space
        sw      t0, 0x0004(sp)              // ~
        sw      t1, 0x0008(sp)              // ~

        li      t0, colors                  // t0 = colors
        sll     t1, a0, 0x0002              // t1 = offset to color
        addu    t0, t0, t1                  // t0 = address of color
        lw      t0, 0x0000(t0)              // t0 = color
        lui     t1, 0x8013                  // t1 = cursor object
        lw      t1, 0x4BDC(t1)              // ~
        lw      t1, 0x0074(t1)              // t1 = cursor image struct
        sw      t0, 0x0028(t1)              // update cursor color

        lw      t0, 0x0004(sp)              // ~
        lw      t1, 0x0008(sp)              // ~
        addiu   sp, sp, 0x0010              // deallocate stack space
        jr      ra                          // return
        nop

        colors:
        dw      Color.high.RED              // RED
        dw      0x0088FFFF                  // blue
        dw      0x39E5BAFF                  // lighter blue
        dw      Color.high.BLUE             // BLUE
    }

    // @ Description
    // Each of these is a former update_right_ functions by Sakurai. They have
    // been extended to update the Stages.asm cursor.
    scope right_check_: {
        OS.patch_start(0x0014FD70, 0x80134200)
        j       right_check_
        nop
        _return:
        OS.patch_end()

        // original line (if v0 == 0, skip right_)
//      beq         v0, r0, 0x801342F4      // original line 1
        beq         v0, r0, page_switch     // original line 1 (modified)
        sw          v0, 0x0020(sp)          // original line 2

        j           right_                  // usually, this would go to right_ here
        nop

        page_switch:
        addiu   sp, sp,-0x0028              // allocate stack space
        sw      ra, 0x0004(sp)              // ~
        sw      a0, 0x0008(sp)              // ~
        sw      a1, 0x000C(sp)              // ~
        sw      a2, 0x0010(sp)              // ~
        sw      v0, 0x0014(sp)              // ~
        sw      t0, 0x0018(sp)              // ~
        sw      t1, 0x001C(sp)              // ~
        sw      at, 0x0020(sp)              // save registers

        li      a1, stage_table_pages       // a1 = stage_table_pages
        li      t1, Toggles.entry_sss_layout
        lw      t1, 0x0004(t1)              // t1 = stage table index
        sll     t1, t1, 0x0002              // t1 = offset to stage_table to use
        addu    a1, a1, t1                  // a1 = address of NUM_PAGES for this stage_table
        lw      a1, 0x0000(a1)              // a1 = NUM_PAGES for this stage_table
        sw      a1, 0x0024(sp)              // save NUM_PAGES

        li      t1, roulette_cursor_timer   // t1 = roulette_cursor_timer
        _settings_shortcut_check:
        // Settings shortcut check per port
        lli     a1, 0x0000                  // a1 = loop index (port)
        _settings_shortcut_loop:
        jal     Toggles.settings_shortcut   // a0 = 1 if L was held long enough to activate Settings shortcut...
        nop
        bnezl   a0, _end                    // ...and if so, skip to end...
        sw      r0, 0x0000(t1)              // ...and reset roulette_cursor_timer
        sltiu   a2, a1, 0x0003              // at = 1 if more ports to check
        addiu   a1, a1, 0x0001              // a1 = next port
        bnez    a2, _settings_shortcut_loop
        nop

        // check for R press (increment page)
        _page_up:
        li      a0, Joypad.R                // a0 - button mask
        li      a2, Joypad.PRESSED          // a2 - type
        jal     Joypad.check_buttons_all_   // v0 = R pressed?
        nop
        beqz    v0, _page_down              // if r not pressed, skip
        nop
        li      t0, page_number             // ~
        lw      t1, 0x0000(t0)              // t1 = page number
        addiu   t1, t1, 0x0001              // increment page
        lw      at, 0x0024(sp)              // at = NUM_PAGES
        beq     at, t1, _up_warp            // if page is too high, handle case with warp
        nop
        sw      t1, 0x0000(t0)              // store page (next page)
        b       _end_update                 // don't check multiple page switches per frame
        nop

        _up_warp:
        sw      r0, 0x0000(t0)              // reset to first page
        b       _end_update                 // don't check multiple page switches per frame
        nop

        // check for Z press (decrement page)
        _page_down:
        li      a0, Joypad.Z                // a0 - button mask
        li      a2, Joypad.PRESSED          // a2 - type
        jal     Joypad.check_buttons_all_   // v0 = z pressed?
        nop
        beqz    v0, _roulette_check         // if z not pressed, skip
        nop
        li      t0, page_number             // ~
        lw      t1, 0x0000(t0)              // t1 = page number
        beqz    t1, _down_warp              // if page_number == 0, handle special case
        nop
        addiu   t1, t1,-0x0001              // decrement page
        sw      t1, 0x0000(t0)              // store page
        b       _end_update                 // skip _down_warp
        nop

        _down_warp:
        lw      t1, 0x0024(sp)              // t1 = NUM_PAGES
        addiu   t1, t1, -0x0001             // t1 = NUM_PAGES - 1
        sw      t1, 0x0000(t0)              // store page
        b       _end_update
        nop

        _roulette_check:
        li      t1, roulette_cursor_timer   // t1 = roulette_cursor_timer
        lw      a0, 0x0000(t1)              // a0 = timer for roulette (-1 if 'A' or 'Start' was pressed)
        beqz    a0, _hazard_toggle          // branch if roulette not active
        nop
        bltz    a0, _update_preview         // update preview if 'A' or 'Start' was pressed
        nop
        j       random_stage_roulette       // jump to Random Stage Roulette routine
        nop

        // check for L button press (and release) to toggle hazard mode
        _hazard_toggle:
        li      t0, Toggles.entry_sss_layout
        lw      t0, 0x0004(t0)              // t0 = stage table index (1 if tournament)
        bnez    t0, _check_random_cd        // if tournament layout, we don't allow changing hazard mode
        nop

        li      a0, Joypad.L                // a0 - button mask
        li      a2, Joypad.RELEASED         // a2 - type
        jal     Joypad.check_buttons_all_   // v0 = L pressed and released
        nop
        beqz    v0, _check_random_cd        // if not released, skip
        nop

        // Dynamic Hazard Text (inputs)
        jal     get_stage_id_               // v0 = stage_id
        nop

        li      t1, stage_hazard_table       // t1 = address of variant stage_id table
        addu    t1, t1, v0                   // t1 = stage_hazard_table + offset
        lbu     t1, 0x0000(t1)               // t1 = hazard_type selected

        li      t0, Toggles.entry_hazard_mode
        lw      a0, 0x0004(t0)               // a0 = hazard_mode

        lli     a2, id.RANDOM                // a2 = id.RANDOM
        beq     v0, a2, _both_hazard_types   // if (stage_id = id.RANDOM), use both
        addiu   a2, r0, Hazards.type.NONE    // a2 = hazard_type.NONE
        beq     t1, a2, _end                 // branch accordingly
        addiu   a2, r0, Hazards.type.HAZARDS // a2 = hazard_type.HAZARDS
        bne     t1, a2, _check_movement      // branch accordingly
        nop
        xori    a0, a0, 0x0001               // a0 between 0 and 1, or 2 and 3
        b       _update_and_play_hazard_toggle_fgm
        nop
        _check_movement:
        addiu   a2, r0, Hazards.type.MOVEMENT // a2 hazard_type.HAZARDS
        bne     t1, a2, _both_hazard_types    // branch accordingly
        nop
        xori    a0, a0, 0x0002                // a0 between 0 and 2, or 1 and 3
        b       _update_and_play_hazard_toggle_fgm
        nop

        _both_hazard_types:
        addiu   a0, a0, 0x0001               // a0 = a0 + 1
        andi    a0, a0, 0x0003               // a0 between 0 and 3

        _update_and_play_hazard_toggle_fgm:
        sw      a0, 0x0004(t0)               // update hazard_mode
        lli     a0, FGM.menu.TOGGLE          // a0 - fgm_id
        jal     FGM.play_                    // play menu sound
        nop
        b       _end
        nop

        // check for C-Down button press (when hovering over 'RANDOM') to start Roulette
        _check_random_cd:
        jal     get_stage_id_               // v0 = stage_id
        nop
        lli     a0, id.RANDOM               // a0 = id.random
        bne     a0, v0, _stage_variant      // skip c-down check if cursor is not over 'RANDOM'
        nop
        li      a0, Joypad.CD               // a0 - button mask
        li      a2, Joypad.RELEASED         // a2 - type
        jal     Joypad.check_buttons_all_   // v0 = C-Down pressed and released
        nop
        beqz    v0, _stage_variant          // if not pressed, skip
        nop

        li      t1, roulette_cursor_timer         // t1 = roulette_cursor_timer
        lli     t0, random_stage_roulette.DELAY // start timer with value at target DELAY so it fires instantly
        sw      t0, 0x0000(t1)                    // update timer
        b       _end
        nop

        // check for C-Down button press to enable cycling through stage variants
        _stage_variant:
        li      t1, Toggles.entry_sss_layout
        lw      t1, 0x0004(t1)              // t1 = stage table index
        bnez    t1, _end                    // if tournament layout, skip variant check
        nop
        li      a0, original_stage_id
        lbu     a0, 0x0000(a0)              // a0 = original stage id selected
        sll     a0, a0, 0x0003              // a0 = offset in variant_table
        li      a1, variant_table
        addu    a1, a1, a0                  // a1 = address of stage variant array
        lw      a0, 0x0000(a1)              // a0 = variant array, 1st half
        lw      a1, 0x0004(a1)              // a1 = variant array, 2nd half
        and     a1, a1, a0                  // a1 = full variants array will be -1 if no variants
        addiu   a0, r0, -0x0001             // a0 = 0xFFFFFFFF (no variants)
        beq     a1, a0, _end                // skip c-down check if no variants for the selected stage
        nop
        li      a0, Joypad.CD               // a0 - button mask
        li      a2, Joypad.RELEASED         // a2 - type
        jal     Joypad.check_buttons_all_   // v0 = C-Down pressed and released
        nop
        beqz    v0, _end                    // if not pressed, skip
        nop

        li      t0, variant
        lbu     a2, 0x0000(t0)              // a2 = variant
        beqz    a2, _loop                   // if variant type is default currently, skip
        nop                                 // otherwise we'll check if we should pretend like it was
        li      a0, original_stage_id
        lbu     a0, 0x0000(a0)              // a0 = original stage id selected
        sll     a0, a0, 0x0003              // a0 = offset in variant_table
        li      a1, variant_table
        addu    a1, a1, a0                  // a1 = address of stage variant array
        addu    a1, a1, a2                  // a1 = address of variant stage id, offset by 1
        lbu     a1, 0xFFFF(a1)              // a1 = variant stage id
        lli     t1, 0x00FF                  // t1 = 0x000000FF
        bne     a1, t1, _loop               // if there is a defined variant stage_id, don't update to 0
        nop
        sb      r0, 0x0000(t0)              // set variant to 0 so the next variant type is selected

        _loop:
        lbu     t1, 0x0000(t0)              // t1 = variant
        addiu   t1, t1, 0x0001              // t1++
        sltiu   at, t1, 0x0009              // at = 1 if t1 < 5
        beqzl   at, pc() + 8                // if t1 >= 5, then set t1 to 0
        or      t1, r0, r0                  // t1 = 0
        sb      t1, 0x0000(t0)              // save variant
        beqz    at, _update_preview         // if we hit the default one again, just quit
        nop
        // skip this variant index if no variant of this type for the selected stage
        li      a0, original_stage_id
        lbu     a0, 0x0000(a0)              // a0 = original stage id selected
        sll     a0, a0, 0x0003              // a0 = offset in variant_table
        li      a1, variant_table
        addu    a1, a1, a0                  // a1 = address of stage variant array
        addu    a1, a1, t1                  // a1 = address of variant stage id, offset by 1
        lbu     a1, 0xFFFF(a1)              // a1 = variant stage id
        lli     t1, 0x00FF                  // t1 = 0x000000FF
        beq     a1, t1, _loop               // if there is not a defined variant stage_id, auto cycle
        nop

        _update_preview:
        // update preview
        lui     a0, 0x8013
        jal     0x801329AC                  // draw logo
        lw      a0, 0x04BD8(a0)
        lui     a1, 0x8013
        lw      a1, 0x04BD8(a1)
        lui     a0, 0x8013
        jal     0x80132A58                  // position cursor
        lw      a0, 0x04BDC(a0)
        lui     a0, 0x8013
        jal     0x80132430                  // update stage_id
        lw      a0, 0x04BD8(a0)
        li      a0, roulette_cursor_timer   // a0 = roulette_cursor_timer
        lw      a0, 0x0000(a0)              // a0 = timer for roulette (-1 if 'A' or 'Start' was pressed)
        bltz    a0, pc() + 16               // if 'A' or 'Start' was pressed, update stage preview...
        nop
        bnez    a0, _end                    // ...otherwise skip if roulette is active
        nop
        jal     0x801333B4                  // update preview
        or      a0, v0, r0                  // a0 = stage_id

        _end:
        lw      ra, 0x0004(sp)              // ~
        lw      a0, 0x0008(sp)              // ~
        lw      a1, 0x000C(sp)              // ~
        lw      a2, 0x0010(sp)              // ~
        lw      v0, 0x0014(sp)              // ~
        lw      t0, 0x0018(sp)              // ~
        lw      t1, 0x001C(sp)              // ~
        lw      at, 0x0020(sp)              // restore registers
        addiu   sp, sp, 0x0028              // deallocate stack space
        j       0x801342F4                  // skip (from original line 1)
        nop

        _end_update:
        // update the image_table_pointer so the icons update based on page
        lw      t1, 0x0000(t0)              // t1 = PAGE
        li      t0, image_table_pointer     // t0 = image_table_pointer
        lli     at, NUM_ICONS               // at = NUM_ICONS
        multu   at, t1                      // at = NUM_ICONS * PAGE
        mflo    at                          // ~
        sll     at, at, 0x0002              // at = offset to first image address in image_table
        li      t1, image_table             // t1 = image_table start addres
        addu    t1, t1, at                  // t1 = new image_table start address
        sw      t1, 0x0000(t0)              // store new image_table address

        // check if Roulette is active and branch acordingly (change page without updating)
        li      t1, roulette_cursor_timer   // t1 = roulette_cursor_timer
        lw      a0, 0x0000(t1)              // a0 = timer for roulette (-1 if 'A' or 'Start' was pressed)
        bnez    a0, _update_preview         // branch if roulette is active
        nop

        lw      ra, 0x0004(sp)              // ~
        lw      a0, 0x0008(sp)              // ~
        lw      a1, 0x000C(sp)              // ~
        lw      a2, 0x0010(sp)              // ~
        lw      v0, 0x0014(sp)              // ~
        lw      t0, 0x0018(sp)              // ~
        lw      t1, 0x001C(sp)              // ~
        lw      at, 0x0020(sp)              // restore registers
        addiu   sp, sp, 0x0028              // deallocate stack space
        li      a1, 0x80134BD8              // original line 1/2
        lli     t0, 0x0001                  // spoofed cursor id
        sw      t0, 0x0000(a1)              // update cursor id
        j       right_._return              // use right_'s preview update
        nop
    }

    // right
    scope right_: {
        OS.patch_start(0x0014FD78, 0x80134208)
        j       right_
        nop
        _return:
        OS.patch_end()

        addiu   sp, sp,-0x0020              // allocate stack space
        sw      t0, 0x0004(sp)              // ~
        sw      t1, 0x0008(sp)              // ~
        sw      at, 0x000C(sp)              // ~
        sw      ra, 0x0010(sp)              // ~
        sw      a0, 0x0014(sp)              // ~
        sw      v0, 0x0018(sp)              // save registers

        li      a1, 0x80134BD8              // original line 1/2
        lli     t0, 0x0001                  // spoofed cursor id
        sw      t0, 0x0000(a1)              // update cursor id

        // check bounds
        li      t0, column                  // ~
        lbu     t1, 0x0000(t0)              // t1 = column
        slti    at, t1, NUM_COLUMNS - 1     // if (column < NUM_COLUMNS - 1)
        bnez    at, _normal                 // then go to next colum
        nop

        // update cursor (go to first column)
        sb      r0, 0x0000(t0)              // else go to first column
        b       _end                        // skip to end
        nop

        // update cursor (go right one)
        _normal:
        addi    t1, t1, 0x0001              // t1 = column++
        sb      t1, 0x0000(t0)              // update column

        _end:
        lw      t0, 0x0004(sp)              // ~
        lw      t1, 0x0008(sp)              // ~
        lw      at, 0x000C(sp)              // ~
        lw      ra, 0x0010(sp)              // ~
        lw      a0, 0x0014(sp)              // ~
        lw      v0, 0x0018(sp)              // restore registers
        addiu   sp, sp, 0x0020              // deallocate stack sapce
        j       _return                     // return
        nop


    }

    // left
    scope left_: {
        OS.patch_start(0x0014FC74, 0x80134104)
        j       left_
        nop
        _return:
        OS.patch_end()

        addiu   sp, sp,-0x0018              // allocate stack space
        sw      t0, 0x0004(sp)              // ~
        sw      t1, 0x0008(sp)              // ~
        sw      at, 0x000C(sp)              // ~
        sw      ra, 0x0010(sp)              // ~
        sw      a0, 0x0014(sp)              // save registers

        li      a1, 0x80134BD8              // original line 1/2
        lli     t0, 0x0001                  // spoofed cursor id
        sw      t0, 0x0000(a1)              // update cursor id

        // check bounds
        li      t0, column                  // ~
        lbu     t1, 0x0000(t0)              // t1 = column
        bnez    t1, _normal                 // if (!first_column)
        nop

        // update cursor (go to last column)
        lli     t1, NUM_COLUMNS - 1         // ~
        sb      t1, 0x0000(t0)              // else go to last column
        b       _end                        // skip to end
        nop

        // update cursor (go left one)
        _normal:
        addi    t1, t1,-0x0001              // t1 = column--
        sb      t1, 0x0000(t0)              // update column

        _end:
        lw      t0, 0x0004(sp)              // ~
        lw      t1, 0x0008(sp)              // ~
        lw      at, 0x000C(sp)              // ~
        lw      ra, 0x0010(sp)              // ~
        lw      a0, 0x0014(sp)              // restore registers
        addiu   sp, sp, 0x0018              // deallocate stack sapce
        j       _return
        nop
    }


    // down
    scope down_: {
        OS.patch_start(0x0014FBA4, 0x80134034)
        j       down_
        nop
        _return:
        OS.patch_end()

        addiu   sp, sp,-0x0018              // allocate stack space
        sw      t0, 0x0004(sp)              // ~
        sw      t1, 0x0008(sp)              // ~
        sw      at, 0x000C(sp)              // ~
        sw      ra, 0x0010(sp)              // ~
        sw      a0, 0x0014(sp)              // save registers

        lui     v1, 0x8013                  // original line 1
        lli     t0, 0x0001                  // ~
        sw      t0, 0x4BD8(v1)              // spoof cursor
        lw      v1, 0x4BD8(v1)              // original line 2

        // check bounds
        li      t0, row                     // ~
        lbu     t1, 0x0000(t0)              // t1 = row
        slti    at, t1, NUM_ROWS - 1        // if (row < NUM_ROWS - 1)
        bnez    at, _normal                 // then go to next colum
        nop

        // update cursor (go to first row)
        sb      r0, 0x0000(t0)              // else go to first row
        b       _end                        // skip to end
        nop

        // update cursor (go down one)
        _normal:
        addi    t1, t1, 0x0001              // t1 = row++
        sb      t1, 0x0000(t0)              // update row

        _end:
        lw      t0, 0x0004(sp)              // ~
        lw      t1, 0x0008(sp)              // ~
        lw      at, 0x000C(sp)              // ~
        lw      ra, 0x0010(sp)              // ~
        lw      a0, 0x0014(sp)              // restore registers
        addiu   sp, sp, 0x0018              // deallocate stack sapce
        j       _return
        nop
    }

    // up
    scope up_: {
        OS.patch_start(0x0014FAD0, 0x80133F60)
        j       up_
        nop
        _return:
        OS.patch_end()

        addiu   sp, sp,-0x0018              // allocate stack space
        sw      t0, 0x0004(sp)              // ~
        sw      t1, 0x0008(sp)              // ~
        sw      at, 0x000C(sp)              // ~
        sw      ra, 0x0010(sp)              // ~
        sw      a0, 0x0014(sp)              // save registers

        lui     v1, 0x8013                  // original line 1
        lli     t0, 0x0006                  // ~
        sw      t0, 0x4BD8(v1)              // spoof cursor
        lw      v1, 0x4BD8(v1)              // original line 2

        // check bounds
        li      t0, row                     // ~
        lbu     t1, 0x0000(t0)              // t1 = row
        bnez    t1, _normal                 // if (!first_row)
        nop

        // update cursor (go to last row)
        lli     t1, NUM_ROWS - 1            // ~
        sb      t1, 0x0000(t0)              // else go to last row
        b       _end                        // skip to end
        nop

        // update cursor (go up one)
        _normal:
        addi    t1, t1,-0x0001              // t1 = row--
        sb      t1, 0x0000(t0)              // update row

        _end:
        lw      t0, 0x0004(sp)              // ~
        lw      t1, 0x0008(sp)              // ~
        lw      at, 0x000C(sp)              // ~
        lw      ra, 0x0010(sp)              // ~
        lw      a0, 0x0014(sp)              // restore registers
        addiu   sp, sp, 0x0018              // deallocate stack sapce
        j       _return
        nop
    }

    // @ Description
    // Random Stage Roulette (activated by pressing C-Down on 'RANDOM')
    // Note: Stage preview is static until a Button is pressed to stop roulette (for visual sensitivity and performance)
    scope random_stage_roulette: {
        // Check for Buttons presses that can cancel the roulette
        li      t1, roulette_pressed_b      // t1 = roulette_pressed_b
        lw      a0, 0x0000(t1)              // a0 = 1 if B pressed while roulette active...
        bnezl   a0, stop_roulette           // ...and if so, stop roulette and clear roulette_pressed_b flag
        sw      r0, 0x0000(t1)              // ~

        // Note: A and Start are handled elsewhere; excluded CU CL CR Buttons (so they can be held for selecting music)
        li      a0, Joypad.B                // a0 - button mask
        li      a2, Joypad.PRESSED          // a2 - type
        jal     Joypad.check_buttons_all_   // v0 = B pressed?
        nop
        bnez    v0, stop_roulette           // if pressed, stop roulette
        nop
        // Separate check for L and CD (since it activates upon release)
        li      a0, Joypad.L + Joypad.CD    // a0 - button mask
        li      a2, Joypad.RELEASED         // a2 - type
        jal     Joypad.check_buttons_all_   // v0 = L or CD pressed and released
        nop
        bnez    v0, stop_roulette           // if pressed, stop roulette
        nop

        check_roulette_timer:
        // We check the timer so cursor updates at a reasonable speed
        constant DELAY(8)                   // frames to wait between updating cursor
        li      t1, roulette_cursor_timer   // t1 = roulette_cursor_timer
        lw      a0, 0x0000(t1)              // a0 = timer for roulette
        sltiu   t0, a0, DELAY               // t0 = 1 if a0 < DELAY
        beqzl   t0, pc() + 8                // if a0 >= 8, then set a0 to 0
        or      a0, r0, r0                  // a0 = 0
        addiu   a0, a0, 0x0001              // increment timer
        sw      a0, 0x0000(t1)              // update timer
        bnez    t0, right_check_._end       // branch if timer has not waited long enough (don't update cursor)
        nop

        // if we're here, randomly select coordinates and update cursor
        li      a1, 0x80134BD8              // original line 1/2
        lli     t0, 0x0001                  // spoofed cursor id
        sw      t0, 0x0000(a1)              // update cursor id

        randomize_coords:
        jal     Global.get_random_int_      // v0 = (0, N-1)
        lli     a0, 6                       // a0 = 6 (number of columns)
        or      t1, r0, v0                  // t1 = v0
        li      t0, column                  // t0 = COLUMN address
        sb      t1, 0x0000(t0)              // update column

        jal     Global.get_random_int_      // v0 = (0, N-1)
        lli     a0, 3                       // a0 = 3 (number of rows)
        or      t1, r0, v0                  // t1 = v0
        li      t0, row                     // t0 = ROW address
        sb      t1, 0x0000(t0)              // update row

        // check if the coordinates are that of the bottom right square 'RANDOM', and re-roll if so
        // Note: this doesn't take id into factor (some pages have extra RANDOM slots)
        lli     t1, 0x0205                  // t1 = coordinates of bottom right square
        lh      t0, 0x0000(t0)              // t0 = current column + row
        beq     t1, t0, randomize_coords    // branch accordingly
        nop
        // alternative method - check if random would be selected (and re-roll if so)
        // Note: no safety check to handle a hypothetical page consisting of entirely RANDOMs
        //// jal     get_stage_id_               // v0 = stage_id
        //// nop
        //// lli     t0, id.RANDOM               // t0 = id.RANDOM
        //// beq     v0, t0, randomize_coords    // if (stage_id == id.RANDOM), re-roll
        //// nop

        lli     a0, FGM.menu.SCROLL          // a0 - fgm_id
        jal     FGM.play_                    // play menu sound
        nop
        b       _end
        nop

        stop_roulette:
        li      t1, roulette_cursor_timer   // t1 = roulette_cursor_timer
        sw      r0, 0x0000(t1)              // reset roulette_cursor_timer

        _end:
        j       right_check_._update_preview // return
        nop
    }

    // @ Description
    // This handles A and Start presses for Roulette, so when selecting a stage it has a chance to visually update
    // v0 - 1 if pressed, 0 if not
    // t0 and t1 are safe
    scope a_: {
        OS.patch_start(0x14F9DC, 0x80133E6C)
        j       a_
        nop
        _return:
        OS.patch_end()

        // check 'awayMode'
        li      t1, Global.previous_screen
        lb      t1, 0x0000(t1)                 // t1 = previous screen
        lli     t0, Global.screen.TRAINING_CSS
        beq     t1, t0, _check_RCT             // skip if this is Training SSS
        nop
        li      t1, 0x80134C24                 // get frames elapsed on SSS
        lw      t0, 0x0000(t1)
        sltiu   t1, t0, 120                    // wait a second
        bnez    t1, _check_RCT
        nop
        li      t0, CharacterSelectDebugMenu.PlayerTag.string_table + (2 * 4)
        lw      t0, 0x0000(t0)              // t0 = 2nd tag
        lw      t0, 0x0000(t0)              // t0 = tag
        li      t1, 0x61666B00
        beql    t0, t1, _check_RCT          // branch if tag is equal
        lli     v0, OS.TRUE                 // v0 = 1 (simulate 'A' or 'Start' pressed)

        _check_RCT:
        li      t1, roulette_cursor_timer   // t1 = roulette_cursor_timer
        lw      t0, 0x0000(t1)              // t0 = timer for roulette (-1 if 'A' or 'Start' was pressed)
        bltzl   t0, _end                    // branch if we previously pressed A
        sw      r0, 0x0000(t1)              // reset roulette_cursor_timer

        // original logic
        beqz    v0, _take_branch            // v0 = 0 if neither 'A' or 'Start' are pressed
        nop

        li      t1, roulette_cursor_timer   // t1 = roulette_cursor_timer
        lw      t0, 0x0000(t1)              // t0 = timer for roulette
        beqz    t0, _end                    // branch if roulette not active
        nop
        // if we're here, 'A' was pressed with roulette timer active...
        // ...and we need to set our flag to select stage on the next frame (not this one)
        or      v0, r0, r0                  // clear v0 (remove A press flag)
        li      t1, roulette_cursor_timer   // t1 = roulette_cursor_timer
        addiu   t0, r0, -1                  // t0 = -1 (flag that 'A' was pressed)
        sw      t0, 0x0000(t1)              // update timer
        b       _take_branch                // take branch of 'A' not being pressed
        nop

        _end:
        j       _return
        nop

        _take_branch:
        j       0x80133ED0                  // return (take branch)
        nop

    }

    // This handles B presses for Roulette, so we can stop it without also exiting menu
    // v0 - 1 if pressed, 0 if not
    // t0 and t1 are safe
    scope b_: {
        OS.patch_start(0x14FA48, 0x80133ED8)
        j       b_
        nop
        _return:
        OS.patch_end()

        // original logic
        beqz    v0, _take_branch            // v0 = 0 if B not pressed
        nop

        li      t1, roulette_cursor_timer   // t1 = roulette_cursor_timer
        lw      t0, 0x0000(t1)              // t0 = timer for roulette
        beqz    t0, _end                    // branch if roulette not active
        nop
        // if we're here, 'B' was pressed with roulette timer...
        // ...and we need to ignore that input
        or      v0, r0, r0                  // clear v0 (remove B press flag)
        li      t1, roulette_pressed_b      // t1 = roulette_pressed_b
        lli     t0, OS.TRUE                 // t0 = true
        sw      t0, 0x0000(t1)              // set roulette_pressed_b to true
        b       _take_branch                // take branch of 'B' not being pressed
        nop

        _end:
        j       _return
        nop

        _take_branch:
        j       0x80133F2C              // return (take branch)
        nop
    }

    // @ Description
    // Hook starts at SSS Button Up (DU CU) check, which would normally continue to Stick Up, etcetera
    // This allows us to ignore Stick and Dpad inputs while Roulette is active
    scope directional_checks_: {
        OS.patch_start(0x14FAB4, 0x80133F44)
        j       directional_checks_
        nop
        _return:
        OS.patch_end()

        li      at, roulette_cursor_timer   // at = roulette_cursor_timer
        lw      at, 0x0000(at)              // at = timer for roulette
        bnezl   at, right_check_            // if timer is active, skip other directional checks and go straight there
        or      v0, r0, r0                  // clear v0 (remove directional press)

        _original:
        // original logic
        bnez    v0, _take_branch            // v0 = 1 if Joypad.DU pressed
        sw      v0, 0x001C(sp)              // original line 2

        _end:
        j       _return
        nop

        _take_branch:
        j       0x80133F60              // return (take branch)
        nop
    }

    // @ Description
    // Adds a stage to the random list if it's toggled on.
    // @ Arguments
    // a0 - address of entry (random stage entry)
    // a1 - stage id to add
    // a2 - 1 = all stages, 0 = only those toggled on
    // @ Returns
    // v0 - bool was_added?
    // v1 - num_stages
    scope add_stage_to_random_list_: {
        addiu   sp, sp,-0x0010              // allocate stack sapce
        sw      t0, 0x0004(sp)              // ~
        sw      t1, 0x0008(sp)              // ~
        sw      t2, 0x000C(sp)              // save registers

        // this block checks to see if a stage should be added to the table.
        _check_add:
        lli     v0, OS.FALSE                // v0 = false
        beqz    a0, _continue               // if entry is NULL, add stage
        lli     t0, OS.TRUE                 // set curr_value to true
        lw      t0, 0x0004(a0)              // t0 = curr_value

        _continue:
        li      t1, random_count            // t1 = address of random_count
        lw      v1, 0x0000(t1)              // v1 = random_count
        or      t0, t0, a2                  // t0 = 1 if we're adding all stages or the stage is toggled on, 0 otherwise
        beqz    t0, _end                    // end, return false and count
        nop

        li      t0, Toggles.entry_sss_layout
        lw      t0, 0x0004(t0)              // t0 = stage table index
        beqz    t0, _do_add                 // if not tournament layout, definitely add
        lw      t0, 0x0024(a0)              // t0 = toggle_id

        li      t2, Toggles.profile_defaults_TE
        addiu   t0, t0, -0x0001             // t0 = toggle_id, 0-based
        sll     t0, t0, 0x0002              // t0 = offset to on/off flag for TE
        addu    t2, t2, t0                  // t2 = address of on/off flag
        lw      t0, 0x0000(t2)              // t0 = 1 if it is tournament legal, 0 otherwise
        beqz    t0, _end                    // if not tournament legal, don't add
        nop

        _do_add:
        // if the stage should be added, it is added here. count is also incremented here
        addiu   v1, v1, 0x0001              // v1 = random_count++
        sw      v1, 0x0000(t1)              // update random_count
        li      t0, random_table - 1        // t0 = address of byte before random_table
        addu    t0, t0, v1                  // t0 = random_table + offset
        sb      a1, 0x0000(t0)              // add stage
        lli     v0, OS.TRUE                 // v0 = true

        _end:
        lw      t0, 0x0004(sp)              // ~
        lw      t1, 0x0004(sp)              // ~
        lw      t2, 0x0008(sp)              // restore registers
        addiu   sp, sp, 0x0010              // deallocate stack sapce
        jr      ra                          // return
        nop
    }

    // @ Description
    // Macro to (maybe) add a stage to the random list.
    macro add_to_list(entry, stage_id) {
        // a2 is set outside of this macro
        li      a0, {entry}                 // a0 - address of entry
        jal     add_stage_to_random_list_   // add stage
        lli     a1, {stage_id}              // a1 - stage id to add
    }

    // @ Description
    // Table of stage IDs
    random_table:
    fill id.MAX_STAGE_ID + 1 - 25           // We don't use the 24 BTT/BTPs nor the RTTF
    OS.align(4)

    // @ Description
    // number of stages in random_table.
    random_count:
    dw 0x00000000

    // @ Description
    // This function fixes a bug that does not allow single player stages to be loaded in training.
    // SSB typically uses *0x800A50E8 to get the stage id. The stage id is then used to find the bg
    // file. This function switches gets a working stage id based on *0x800A50E8 and stores it in
    // expansion memory. That value is read from in three known places
    // TODO: keep an eye out for more uses of this value
    scope training_id_fix_: {
        OS.patch_start(0x001145D0, 0x8018DDB0)
        addiu   sp, sp, 0xFFE8              // original line 3
        sw      ra, 0x0014(sp)              // original line 4
        jal     training_id_fix_
        nop
        OS.patch_end()

        OS.patch_start(0x0011462C, 0x8018DE0C)
        jal     training_id_fix_
        nop
        lui     t5, 0x8019                  // original line 3
        lui     t7, 0x8019                  // original line 4
        lbu     t3, 0x0001(t6)              // original line 5 modified
        OS.patch_end()

        // fix for magnifying glass colour and crashes
        OS.patch_start(0x00114680, 0x8018DE60)
        addiu   sp, sp, 0xFFE8              // original line 3
        sw      ra, 0x0014(sp)              // original line 4
        jal     training_id_fix_
        nop
        lbu     t8, 0x0001(t6)              // original line 5 modified
        OS.patch_end()

        addiu   sp, sp,-0x0010              // allocate stack space
        sw      t0, 0x0004(sp)              // ~
        sw      t1, 0x0008(sp)              // ~
        sw      t2, 0x000C(sp)              // save registers

        li      t0, 0x800A50E8              // ~
        lw      t0, 0x0000(t0)              // t0 = dereference 0x800A50E8
        lbu     t0, 0x0001(t0)              // t0 =  stage id
        li      t1, background_table        // t1 = stage id table (offset)
        addu    t1, t1, t0                  // t1 = stage id table + offset
        lbu     t0, 0x0000(t1)              // t0 = new working stage id
        li      t2, id                      // t2 = id
        sb      t0, 0x0000(t2)              // update stage id to working stage id

        lw      t0, 0x0004(sp)              // ~
        lw      t1, 0x0008(sp)              // ~
        lw      t2, 0x000C(sp)              // restore registers
        addiu   sp, sp, 0x0010              // deallocate stack space
        li      t6, id - 1                  // original line 1/2 modified
        jr      ra                          // return
        nop

        id:
        db 0x00                             // holds new stage id
        OS.align(4)
    }

    // @ Description
    // This instruction loads a hardcoded table. That table has been expanded below.
    OS.patch_start(0x00077A9C, 0x800FC29C)
    li      s0, stage_file_table
    OS.patch_end()

    // @ Description
    // These instruction load the start and end of a hardcoded table. That table has been expanded below.
    OS.patch_start(0x14D680, 0x80131B10)
    li      s0, stage_file_table        // start of stage_file_table
    OS.patch_end()
    OS.patch_start(0x14D690, 0x80131B20)
    li      s2, class_table             // start of stage_file_table
    OS.patch_end()

    // @ Description
    // This allows us to use background animation in custom stages
    scope bg_animation_: {
        // replace an ID check with our own custom check on stage class
        OS.patch_start(0x922E4, 0x80116AE4)
        jal     bg_animation_._id_check
        lui     t7, 0x800A                  // original line 1
        OS.patch_end()

        // use new table
        OS.patch_start(0x922FC, 0x80116AFC)
        beq     t7, at, 0x80116BC0          // original line 2
        sll     t8, v0, 0x0002              // original line 1 (modified)
        jal     bg_animation_._pointer_check
        nop
        nop
        OS.patch_end()

        // use new table
        OS.patch_start(0x9237C, 0x80116B7C)
        li      a0, table                   // original lines 1/2 (modified)
        lbu     t2, 0x0001(v1)              // original line 3
        lui     t5, 0x8013                  // original line 4
        sll     t3, t2, 0x0002              // t3 = offset to bg animation info array pointer
        addu    t4, a0, t3                  // original line 5
        lw      t4, 0x0000(t4)              // t4 = bg animation info array pointer
        sw      t4, 0x0018(a1)              // original line 6
        lw      t5, 0x1300(t5)              // original line 8
        or      t9, t4, r0                  // t9 = bg animation info array pointer
        nop
        OS.patch_end()

        _id_check:
        // Originally, it checked if stage_id < 9.
        // We will check our custom table for a nonzero value.
        // v0 = stage_id
        li      at, table                   // at = table
        sll     t8, v0, 0x0002              // t8 = offset to bg animation info array pointer
        addu    at, at, t8                  // at = address of bg animation info array pointer
        jr      ra
        lw      at, 0x0000(at)              // at = bg animation info array pointer (or 0 if none)

        _pointer_check:
        li      t9, table                   // t9 = table
        addu    t9, t9, t8                  // t9 = address of bg animation info array pointer
        lw      t9, 0x0000(t9)              // at = bg animation info array pointer (not 0 if here)
        jr      ra
        lw      t9, 0x0004(t9)              // t9 = 1st pointer in array

        // holds pointers to the bg animation info arrays for each stage
        table:
        constant TABLE_ORIGIN(origin())
        // the first 8 stages are located starting at 0x8012F840
        define n(0)
        while ({n} < 8) {
            dw 0x8012F840 + ({n} * 0x10)
            evaluate n({n} + 1)
        }
        fill 0x4 * (id.MAX_STAGE_ID - 7)
    }

    // @ Description
    // This allows us to set background types for custom stages
    scope bg_type: {
        constant UPPER(table >> 16)
        constant LOWER(table & 0xFFFF)

        OS.patch_start(0x80434, 0x80104C34)
        sltiu   at, t8, id.MAX_STAGE_ID    // modified original stage check
        OS.patch_end()
        OS.patch_start(0x80440, 0x80104C40)
        if LOWER > 0x7FFF {
            lui     at, (UPPER + 0x1)
        } else {
            lui     at, UPPER
        }
        addu    at, at, t8
        lw      t8, LOWER(at)
        OS.patch_end()

        // holds pointers to the bg animation info arrays for each stage
        constant DEFAULT(0x80104C9C)
        constant SECTORZ(0x80104C64)
        constant STATIC(0x80104C54)
        constant BONUS3(0x80104C74)
        constant LAST(0x80104C84)
        OS.align(16)
        table:
        constant TABLE_ORIGIN(origin())
        dw  SECTORZ                     // 0x00 - Sector Z
        dw  DEFAULT                     // 0x01 - Congo Jungle
        dw  DEFAULT                     // 0x02 - Planet Zebes
        dw  DEFAULT                     // 0x03 - Hyrule Castle
        dw  STATIC                      // 0x04 - Yoshi's Island
        dw  DEFAULT                     // 0x05 - Dream Land
        dw  DEFAULT                     // 0x06 - Saffron City
        dw  DEFAULT                     // 0x07 - Mushroom Kingdom
        dw  DEFAULT                     // 0x08 - Dream Land Beta 1
        dw  DEFAULT                     // 0x09 - Dream Land Beta 2
        dw  DEFAULT                     // 0x0A - How to Play
        dw  STATIC                      // 0x0B - Yoshi's Island (1P)
        dw  DEFAULT                     // 0x0C - Meta Crystal
        dw  DEFAULT                     // 0x0D - Batlefield
        dw  BONUS3                      // 0x0E - Race to the Finish
        dw  LAST                        // 0x0F - Final Destination
        define n((pc() - table) / 0x4)
        while ({n} <= id.MAX_STAGE_ID) {
            dw DEFAULT
            evaluate n({n} + 1)
        }
    }

    // @ Description
    // Sets up custom display
    scope setup_: {
        addiu   sp, sp,-0x0030              // allocate stack space
        sw      ra, 0x0004(sp)              // save registers

        Render.load_font()                                        // load font for strings
        Render.load_file(0xC5, Render.file_pointer_1)             // load button images into file_pointer_1
        Render.load_file(File.STAGE_ICONS, Render.file_pointer_2) // load stage icons into file_pointer_2
        Render.load_file(File.CSS_IMAGES, Render.file_pointer_3)  // load CSS images into file_pointer_3
        Render.load_file(0x11, Render.file_pointer_4)             // load file with arrows into file_pointer_4

        // every frame, update string pointers for the strings we're about to draw
        Render.register_routine(update_text_)

        // draw icons
        li      a0, Render.file_pointer_2                // a0 = pointer to base address for stock icons
        lw      a0, 0x0000(a0)                           // a0 = base address for stock icons
        jal     update_stage_icons_
        nop
        Render.draw_texture_grid(1, 4, image_table_pointer, Render.update_live_grid_, 0x220, 0x41F00000, 0x41A00000, 0xFFFFFFFF, 0xFFFFFFFF, NUM_ICONS, 6, 2)

        // draw strings and arrows
        Render.draw_texture_at_offset(4, 3, Render.file_pointer_4, 0xECE8, Render.NOOP, 0x41E80000, 0x42EA0000, 0xC0CC00FF, 0x000000FF, 0x3F200000)
        Render.draw_string(4, 3, string_page, Render.NOOP, 0x43080000, 0x42E70000, 0xFFFFFFFF, 0x3F600000, Render.alignment.LEFT)
        Render.draw_number_adjusted(4, 3, page_number, 1, Render.update_live_string_, 0x43280000, 0x42E70000, 0xFFFFFFFF, 0x3F600000, Render.alignment.LEFT)
        Render.draw_texture_at_offset(4, 3, Render.file_pointer_4, 0xEDC8, Render.NOOP, 0x438A0000, 0x42EA0000, 0xC0CC00FF, 0x000000FF, 0x3F200000)

        Render.draw_string_pointer(4, 3, stage_name, Render.update_live_string_, 0x43660000, 0x43510000, 0xFFFFFFFF, Render.FONTSIZE_DEFAULT, Render.alignment.CENTER)

        // draw button images
        Render.draw_texture_at_offset(4, 3, Render.file_pointer_1, Render.file_c5_offsets.R, Render.NOOP, 0x43808000, 0x42E50000, 0x848484FF, 0x303030FF, 0x3F800000)
        Render.draw_texture_at_offset(4, 3, Render.file_pointer_1, Render.file_c5_offsets.Z, Render.NOOP, 0x42100000, 0x42E20000, 0x848484FF, 0x303030FF, 0x3F800000)

        li      t0, Render.display_order_room
        lui     t1, 0x4000                  // t1 = 0x40000000 (render after 0x80000000)
        sw      t1, 0x0000(t0)              // update display order within rooms for our draw_texture calls

        lli     t3, ' '                     // t3 = char if not tournament layout
        li      t1, Toggles.entry_sss_layout
        lw      t1, 0x0004(t1)              // t1 = stage table index
        beqz    t1, _set_strings            // if not tournament layout, skip
        lli     t4, '('                     // t4 = char if not tournament layout

        lli     t3, ':'                     // t3 = char if tournament layout
        lli     t4, 0x00                    // t4 = char if tournament layout (terminate string)

        _set_strings:
        li      t0, string_hazards
        sb      t3, 0x0007(t0)
        sb      t4, 0x0008(t0)
        li      t0, string_movement
        sb      t3, 0x0008(t0)
        sb      t4, 0x0009(t0)

        Render.draw_string(2, 0xD, string_hazards, Render.NOOP, 0x43780000, 0x43350000, 0xFFFFFFFF, 0x3F400000, Render.alignment.RIGHT)
        Render.draw_string_pointer(2, 0xD, hazards_onoff, Render.update_live_string_, 0x437C0000, 0x43350000, 0xFFFFFFFF, 0x3F400000, Render.alignment.LEFT)
        Render.draw_string(2, 0xE, string_movement, Render.NOOP, 0x43780000, 0x433D0000, 0xFFFFFFFF, 0x3F400000, Render.alignment.RIGHT)
        Render.draw_string_pointer(2, 0xE, movement_onoff, Render.update_live_string_, 0x437C0000, 0x433D0000, 0xFFFFFFFF, 0x3F400000, Render.alignment.LEFT)
        Render.draw_string(2, 0xC, string_layout, Render.NOOP, 0x43780000, 0x43470000, 0xFFFFFFFF, 0x3F400000, Render.alignment.RIGHT)
        Render.draw_string_pointer(2, 0xC, layout_pointer, Render.update_live_string_, 0x437C0000, 0x43470000, 0xFFFFFFFF, 0x3F400000, Render.alignment.LEFT)
        Render.draw_texture_at_offset(2, 0xC, Render.file_pointer_3, 0x0688, Render.NOOP, 0x436A0000, 0x43468000, 0xC0CC00FF, 0x000000FF, 0x3F400000)
        lui     t0, 0x3F38                  // t0 = x scale
        lw      t1, 0x0074(v0)              // t1 = image struct
        sw      t0, 0x0018(t1)              // set x scale
        // Shown when hovering over 'RANDOM'
        Render.draw_string(2, 0xF, string_random_roulette, Render.NOOP, 0x43818000, 0x43470000, 0xFFFFFFFF, 0x3F400000, Render.alignment.RIGHT)
        Render.draw_texture_at_offset(2, 0xF, Render.file_pointer_3, 0x0688, Render.NOOP, 0x43788000, 0x43468000, 0xC0CC00FF, 0x000000FF, 0x3F400000)
        lui     t0, 0x3F38                  // t0 = x scale
        lw      t1, 0x0074(v0)              // t1 = image struct
        sw      t0, 0x0018(t1)              // set x scale

        // Conditionally draw L button images
        li      t1, Toggles.entry_sss_layout
        lw      t1, 0x0004(t1)              // t1 = stage table index
        bnez    t1, _end                    // if tournament layout, skip
        nop
        Render.draw_texture_at_offset(2, 0xD, Render.file_pointer_1, Render.file_c5_offsets.L_THIN, Render.NOOP, 0x436A0000, 0x43344000, 0x848484FF, 0x303030FF, 0x3F400000)
        Render.draw_texture_at_offset(2, 0xE, Render.file_pointer_1, Render.file_c5_offsets.L_THIN, Render.NOOP, 0x436A0000, 0x433C8000, 0x848484FF, 0x303030FF, 0x3F400000)

        _end:
        li      t0, Render.display_order_room
        lui     t1, Render.DISPLAY_ORDER_DEFAULT
        sw      t1, 0x0000(t0)              // reset display order with default

        lw      ra, 0x0004(sp)              // restore registers
        addiu   sp, sp, 0x0030              // deallocate stack space

        jr      ra
        nop
    }

    string_page:;  String.insert("Page")
    string_hazards:; String.insert("Hazards (  ):")
    string_movement:;  String.insert("Movement (  ):")
    string_layout:;  String.insert("Layout (  ):")
    string_random_roulette:;  String.insert("Roulette (  )")

    layout_pointer:; dw 0x00000000

    // @ Description
    // Pointers to the stage tables that are utilized via toggles
    stage_table:
    dw stage_table_normal
    dw stage_table_tournament

    // @ Description
    // Holds NUM_PAGES for each stage table
    stage_table_pages:
    dw NUM_PAGES
    dw 3

    // @ Description
    // Pointers to On/Off strings for the given toggle
    hazards_onoff:; dw 0x00000000
    movement_onoff:; dw 0x00000000

    // @ Description
    // Holds the RAM address of the stage icons
    image_table:; fill NUM_ICONS * 4 * NUM_PAGES

    // @ Description
    // Pointer to the first image for a page in image_table, used when rendering the grid
    image_table_pointer:; dw image_table

    OS.align(16)

    // @ Description
    // Stage IDs in order
    stage_table_normal:
    // page 1 (vanilla and "smash" stages)
    db id.PEACHS_CASTLE                     // 00
    db id.CONGO_JUNGLE                      // 01
    db id.HYRULE_CASTLE                     // 02
    db id.PLANET_ZEBES                      // 03
    db id.MUSHROOM_KINGDOM                  // 04
    db id.META_CRYSTAL                      // 05
    db id.YOSHIS_ISLAND                     // 06
    db id.DREAM_LAND                        // 07
    db id.SECTOR_Z                          // 08
    db id.SAFFRON_CITY                      // 09
    db id.DUEL_ZONE                         // 0A
    db id.FINAL_DESTINATION                 // 0B
    db id.DRAGONKING                        // 0C
    db id.FIRST_DESTINATION                 // 0D
    db id.DREAM_LAND_BETA_1                 // 0E
    db id.HOW_TO_PLAY                       // 0F
    db id.BATTLEFIELD                       // 10
    db id.RANDOM                            // 11
    // page 2 (original design stages)
    db id.ZLANDING                          // 12
    db id.GANONS_TOWER                      // 13
    db id.SPIRALM                           // 14
    db id.COOLCOOL                          // 15
    db id.DR_MARIO                          // 16
    db id.BOWSERB                           // 17
    db id.N64                               // 18
    db id.DEKU_TREE                         // 19
    db id.MADMM                             // 1A
    db id.GB_LAND                           // 1B
    db id.MUTE                              // 1C
    db id.KITCHEN                           // 1D
    db id.FROSTY                            // 1E
    db id.FRAYS_STAGE                       // 1F
    db id.WARIOWARE                         // 20
    db id.GYM_LEADER_CASTLE                 // 21
    db id.POKEMON_STADIUM                   // 22
    db id.RANDOM                            // 23
    // page 3 (guest stages)
    db id.TALTAL                            // 24
    db id.SMASHVILLE2                       // 25
    db id.REAPERS                           // 26
    db id.RAIDBLUE                          // 27
    db id.GREAT_BAY                         // 29
    db id.FOD                               // 2A
    db id.TOH                               // 2B
    db id.SMASHKETBALL                      // 2C
    db id.NORFAIR                           // 2D
    db id.DELFINO                           // 2E
    db id.PEACH2                            // 2F
    db id.BLUE                              // 30
    db id.ONETT                             // 31
    db id.GLACIAL                           // 32
    db id.HTEMPLE                           // 33
    db id.NPC                               // 34
    db id.FALLS                             // 35
    db id.RANDOM                            // 36
    // page 4 (more stages)
    db id.FLAT_ZONE                         // 37
    db id.OSOHE                             // 38
    db id.YOSHI_STORY_2                     // 39
    db id.GERUDO                            // 3A
    db id.GOOMBA_ROAD                       // 3B
    db id.BOWSERS_KEEP                      // 3C
    db id.RITH_ESSA                         // 3D
    db id.VENOM                             // 3E
    db id.WINDY                             // 3F
    db id.DATA                              // 40
    db id.CLANCER                           // 41
    db id.JAPES                             // 42
    db id.CSIEGE                            // 43
    db id.YOSHIS_ISLAND_II                  // 44
    db id.GHZ                               // 45
    db id.SUBCON                            // 46
    db id.PIRATE                            // 47
    db id.RANDOM                            // 48

    // page 5 (more stages)
    db id.CASINO                            // 49
    db id.MMADNESS                          // 4A
    db id.RAINBOWROAD                       // 4B
    db id.TOADSTURNPIKE                     // 4C
    db id.DRACULAS_CASTLE                   // 4D
    db id.MT_DEDEDE                         // 4E
    db id.EDO                               // 4F
    db id.TWILIGHT_CITY                     // 50
    db id.MELRODE                           // 51
    db id.SCUTTLE_TOWN                      // 52
    db id.BIG_BOOS_HAUNT                    // 53
    db id.YOSHIS_ISLAND_MELEE               // 54
    db id.SPAWNED_FEAR                      // 55
    db id.POKEFLOATS                        // 56
    db id.BIG_SNOWMAN                       // 57
    db id.DISCOVERY_FALLS                   // 58
    db id.TIME_TWISTER                      // 59
    db id.RANDOM                            // 60

    OS.align(16)

    // @ Description
    // Stage IDs in order
    stage_table_tournament:
    // Page 1 - Main Stages
    db id.DREAM_LAND                        // 00       <-- Hazards ON
    db id.FRAYS_STAGE                       // 01
    db id.FRAYS_STAGE_NIGHT                 // 02
    db id.FIRST_DESTINATION                 // 03
    db id.POKEMON_STADIUM                   // 04
    db id.POKEMON_STADIUM_2                 // 05
    db id.SMASHVILLE2                       // 06
    db id.GOOMBA_ROAD                       // 07
    db id.GYM_LEADER_CASTLE                 // 08
    db id.SAFFRON_DL                        // 09       <-- Movement ON
    db id.GANONS_TOWER                      // 0A
    db id.GLACIAL_REMIX                     // 0B
    db id.DR_MARIO                          // 0C
    db id.TALTAL                            // 0D
    db id.MELRODE                           // 0E
    db id.YOSHI_STORY_2                     // 0F
    db id.BATTLEFIELD                       // 10
    db id.RANDOM                            // 11
    // Page 2 - Viable Stages
    db id.GERUDO                            // 12
    db id.WARIOWARE                         // 13
    db id.DELFINO                           // 14
    db id.CSIEGE                            // 15
    db id.SPIRALM                           // 16
    db id.SMASHVILLE_REMIX                  // 17
    db id.YOSHI_ISLAND_DL                   // 18       <-- Hazards ON
    db id.YOSHIS_ISLAND_II                  // 19
    db id.CLANCER                           // 1A
    db id.FOD                               // 1B
    db id.FINAL_DESTINATION                 // 1C
    db id.GLACIAL                           // 1D
    db id.BIG_BOOS_HAUNT                    // 1E
    db id.GHZ                               // 1F
    db id.NPC                               // 20
    db id.BOWSERS_KEEP                      // 21
    db id.DATA                              // 22
    db id.RANDOM                            // 23
    // Page 3 - Additional DL Clones (No Hazards or Movement)
    db id.PCASTLE_DL                        // 24
    db id.CONGOJ_DL                         // 25
    db id.HCASTLE_DL                        // 26
    db id.ZEBES_DL                          // 27
    db id.SMBBF                             // 29
    db id.DUEL_ZONE_DL                      // 2A
    db id.YOSHI_ISLAND_DL                   // 2B       <-- Hazards OFF
    db id.DREAM_LAND                        // 2C       <-- Hazards OFF
    db id.SECTOR_Z_DL                       // 2D
    db id.SAFFRON_DL                        // 2E       <-- Movement OFF
    db id.FINAL_DESTINATION_DL              // 2F
    db id.META_CRYSTAL_DL                   // 30
    db id.MUTE_DL                           // 31
    db id.WINTER_DL                         // 32
    db id.DEKU_TREE_DL                      // 33
    db id.ZLANDING_DL                       // 34
    db id.BATTLEFIELD_DL                    // 35
    db id.RANDOM                            // 36

    //// Page 3 - Non-Viable
    //db id.GHZ                               // 1C
    //db id.POKEMON_STADIUM                   // 04
    //db id.MINI_YOSHIS_ISLAND                // 0D
    //db id.FOD                               // 2C
    //db id.YOSHIS_ISLAND_II                  // 28
    //db id.BATTLEFIELD                       // 10
    //db id.WARIOWARE                         // 24
    //db id.NPC                               // 28
    //db id.RANDOM                            // 0
    //db id.GHZ                               // 2D
    //db id.TOH                               // 2D
    //db id.BOWSERB                           // 17
    //db id.DATA                              // 28
    //db id.CSIEGE                            // 28
    //db id.EDO                               // 28
    //db id.RAIDBLUE                          // 2A
    //db id.GANONS_TOWER                      // 13
    //db id.BOWSERS_KEEP                      // 13
    //db id.TALTAL                            // 27
    //db id.DELFINO                           // 30
    //db id.MT_DEDEDE                         //
    //db id.REAPERS                           // 29
    //db id.FALLS                             // 06
    //db id.MMADNESS                          // 06
    //db id.CASINO                            // 06
    //db id.FLAT_ZONE_2                       // 06
    //db id.FLAT_ZONE                         // 06
    //db id.RANDOM                            // 0

    // Page 4 - Non-Viable
    db id.CORNERIA2                         //
    db id.COOLCOOL                          //
    db id.GREAT_BAY                         //
    db id.N64                               //
    db id.HTEMPLE                           //
    db id.SUBCON                            //
    db id.MADMM                             //
    db id.KITCHEN                           //
    db id.WINDY                             //
    db id.JAPES                             //
    db id.FROSTY                            //
    db id.NORFAIR                           //
    db id.VENOM                             //
    db id.RITH_ESSA                         //
    db id.PEACH2                            //
    db id.OSOHE                             //
    db id.RANDOM                            //

    // Page 4 - Non-Viable
    db id.GB_LAND                           //
    db id.DRAGONKING                        //
    db id.SHOWDOWN                          //
    db id.ONETT                             //
    db id.SMASHKETBALL                      //
    db id.WORLD1                            //
    db id.DREAM_LAND_BETA_1                 //
    db id.DREAM_LAND_BETA_2                 //
    db id.HOW_TO_PLAY                       //
    db id.RAINBOWROAD                       //
    db id.TOADSTURNPIKE                     //
    db id.DRACULAS_CASTLE                   //
    db id.BLUE                              //
    db id.DEKU_TREE                         //
    db id.ZLANDING                          //
    db id.FIRST_REMIX                       //
    db id.TWILIGHT_CITY                     //
    db id.RANDOM                            //

    OS.align(4)

    // These set up the hazards routines for stage, which generally create objects that has associated routines which create the hazards on a stage
    function_table:
    dw function.PEACHS_CASTLE
    dw function.SECTOR_Z
    dw function.CONGO_JUNGLE
    dw function.PLANET_ZEBES
    dw function.HYRULE_CASTLE
    dw function.YOSHIS_ISLAND
    dw function.DREAM_LAND
    dw function.SAFFRON_CITY
    dw function.MUSHROOM_KINGDOM

    dw OS.NULL                              // (handled elsewhere)
    dw OS.NULL                              // (handled elsewhere)
    dw OS.NULL                              // (handled elsewhere)
    dw OS.NULL                              // (handled elsewhere)
    dw OS.NULL                              // (handled elsewhere)
    dw OS.NULL                              // (handled elsewhere)
    dw OS.NULL                              // (handled elsewhere)
    dw OS.NULL                              // (handled elsewhere)
    dw OS.NULL                              // (handled elsewhere)
    dw OS.NULL                              // (handled elsewhere)
    dw OS.NULL                              // (handled elsewhere)
    dw OS.NULL                              // (handled elsewhere)
    dw OS.NULL                              // (handled elsewhere)
    dw OS.NULL                              // (handled elsewhere)
    dw OS.NULL                              // (handled elsewhere)
    dw OS.NULL                              // (handled elsewhere)
    dw OS.NULL                              // (handled elsewhere)
    dw OS.NULL                              // (handled elsewhere)
    dw OS.NULL                              // (handled elsewhere)
    dw OS.NULL                              // (handled elsewhere)
    dw OS.NULL                              // (handled elsewhere)
    dw OS.NULL                              // (handled elsewhere)
    dw OS.NULL                              // (handled elsewhere)
    dw OS.NULL                              // (handled elsewhere)
    dw OS.NULL                              // (handled elsewhere)
    dw OS.NULL                              // (handled elsewhere)
    dw OS.NULL                              // (handled elsewhere)
    dw OS.NULL                              // (handled elsewhere)
    dw OS.NULL                              // (handled elsewhere)
    dw OS.NULL                              // (handled elsewhere)
    dw OS.NULL                              // (handled elsewhere)
    dw OS.NULL                              // (handled elsewhere)

    dw function.CLONE                       // Deku Tree
    dw function.CLONE                       // First Destination
    dw function.CLONE                       // Ganon's Tower
    dw function.CLONE                       // Gym Leader Castle
    dw function.CLONE                       // Pokemon Stadium
    dw function.CLONE                       // Tal Tal
    dw function.CLONE                       // Glacial River
    dw function.CLONE                       // WarioWare
    dw function.CLONE                       // Battlefield
    dw function.CLONE                       // Flat Zone
    dw function.CLONE                       // Dr. Mario
    dw function.CLONE                       // Cool Cool Mountain
    dw function.CLONE                       // Dragon King
    dw Hazards.great_bay_setup              // Great Bay
    dw function.CLONE                       // Fray' Stage
    dw function.CLONE                       // Tower of Heaven
    dw function.CONGO_JUNGLE                // Fountain of Dreams
    dw function.CLONE                       // Muda Kingdom
    dw function.CLONE                       // Mementos
    dw function.CLONE                       // Showdown
    dw function.CLONE                       // Spiral Mountain
    dw function.CLONE                       // N64
    dw function.CLONE                       // Mute City DL
    dw function.CLONE                       // Mad Monster Mansion
    dw function.MUSHROOM_KINGDOM            // Mushroom Kingdom DL
    dw function.MUSHROOM_KINGDOM            // Mushroom Kingdom Omega
    dw function.PEACHS_CASTLE               // Bowser's Stadium
    dw function.CLONE                       // Peach's Castle II
    dw function.CLONE                       // Delfino
    dw Hazards.corneria_setup               // Corneria
    dw function.PEACHS_CASTLE               // Kitchen Island
    dw function.PEACHS_CASTLE               // Big Blue
    dw Hazards.onett_setup                  // Onett
    dw function.CLONE                       // Zebes Landing
    dw function.CLONE                       // Frosty Village
    dw function.CONGO_JUNGLE                // Smashville
    dw OS.NULL                              // Dr. Mario Break the Targets
    dw OS.NULL                              // Ganondorf Break the Targets
    dw OS.NULL                              // Young Link Break the Targets
    dw function.CLONE                       // Battlefield DL
    dw OS.NULL                              // Dark Samus Break the Targets
    dw OS.NULL                              // Stage 1 Break the Targets
    dw OS.NULL                              // Falco Break the Targets
    dw OS.NULL                              // Wario Break the Targets
    dw function.CLONE                       // Hyrule Temple
    dw OS.NULL                              // Lucas Break the Targets
    dw OS.NULL                              // Ganondorf Board the Platforms
    dw function.CLONE                       // New Pork City
    dw OS.NULL                              // Dark Samus Board the Platforms
    dw function.CONGO_JUNGLE                // Smashketball
    dw OS.NULL                              // Dr. Mario Board the Platforms
    dw function.PLANET_ZEBES                // Norfair
    dw function.CLONE                       // Raid Blue
    dw function.CONGO_JUNGLE                // Congo Falls
    dw function.CLONE                       // OSOHE
    dw function.YOSHIS_ISLAND               // Yoshi's Story II
    dw function.PEACHS_CASTLE               // World 1-1
    dw function.PEACHS_CASTLE               // Flat Zone II
    dw function.CLONE                       // Gerudo Valley
    dw OS.NULL                              // Young Link Board the Platforms
    dw OS.NULL                              // Falco Board the Platforms
    dw OS.NULL                              // Poly Board the Platforms
    dw function.HYRULE_CASTLE               // Hyrule Castle DL
    dw function.HYRULE_CASTLE               // Hyrule Castle Omega
    dw function.CONGO_JUNGLE                // Congo Jungle DL
    dw function.CONGO_JUNGLE                // Congo Jungle Omega
    dw function.PEACHS_CASTLE               // Peach's Castle DL
    dw function.PEACHS_CASTLE               // Peach's Castle Omega
    dw OS.NULL                              // Wario Board the Platforms
    dw function.CLONE                       // Fray's Stage - Night
    dw function.CLONE                       // Goomba Road
    dw OS.NULL                              // Lucas Board the Platforms
    dw function.SECTOR_Z                    // Sector Z Dreamland
    dw function.CONGO_JUNGLE                // Saffron City DL
    dw function.YOSHIS_ISLAND               // Yoshi's Island DL
    dw function.PLANET_ZEBES                // Planet Zebes DL
    dw function.SECTOR_Z                    // Sector Z Omega
    dw function.CONGO_JUNGLE                // Saffron City Omega
    dw function.YOSHIS_ISLAND               // Yoshi's Island Omega
    dw function.DREAM_LAND                  // Dreamland Omega
    dw function.PLANET_ZEBES                // Zebes Omega
    dw OS.NULL                              // Bowser Break the Targets
    dw OS.NULL                              // Bowser Board the Platforms
    dw function.PEACHS_CASTLE               // Bowser's Keep
    dw function.CLONE                       // Rith Essa
    dw function.SECTOR_Z                    // Venom
    dw OS.NULL                              // Wolf Break the Targets
    dw OS.NULL                              // Wolf Board the Platforms
    dw OS.NULL                              // Conker Break the Targets
    dw OS.NULL                              // Conker Board the Platforms
    dw function.CLONE                       // Windy
    dw function.CLONE                       // dataDyne
    dw function.CLONE                       // Planet Clancer
    dw Hazards.jungle_japes_setup           // Jungle Japes
    dw OS.NULL                              // Marth Break the Targets
    dw Hazards.gbland_setup                 // Game Boy Land
    dw OS.NULL                              // Mewtwo Break the Targets
    dw OS.NULL                              // Marth Board the Platforms
    dw SinglePlayerModes.rest_area_setup    // Allstar Rest Area
    dw OS.NULL                              // Mewtwo Board the Platforms
    dw function.CLONE                       // Castle Siege
    dw function.CLONE                       // Yoshi's Island II
    dw function.CLONE                       // Final Destination DL
    dw function.CLONE                       // Final Tentination
    dw function.CLONE                       // Cool Cool Mountain Remix
    dw function.CLONE                       // Duel Zone DL
    dw function.CLONE                       // Cool Cool DL
    dw function.CLONE                       // Meta Crystal DL
    dw function.DREAM_LAND                  // Dream Greens
    dw function.PEACHS_CASTLE               // Peach's Castle Beta
    dw function.HYRULE_CASTLE               // Hyrule Castle Remix
    dw function.SECTOR_Z                    // Sector Z Remix
    dw function.CLONE                       // Mute City
    dw function.CLONE                       // Home Run Contest
    dw function.MUSHROOM_KINGDOM            // Mushroom Kingdom Remix
    dw function.CLONE                       // Green Hill Zone
    dw function.CLONE                       // Subcon
    dw Hazards.pirate_land_setup            // Pirate Land
    dw Hazards.casino_night_setup           // Casino Night Zone
    dw OS.NULL                              // Sonic Break the Targets
    dw OS.NULL                              // Sonic Board the Platforms
    dw Hazards.metallic_madness_setup       // Metallic Madness
    dw Hazards.rainbow_road_setup           // Rainbow Road
    dw function.CLONE                       // Pokemon Stadium 2
    dw function.PLANET_ZEBES                // Norfair Remix
    dw Hazards.toads_turnpike_setup         // Toad's Turnpike
    dw function.CLONE                       // Tal Tal Heights Remix
    dw OS.NULL                              // Sheik Board the Platforms
    dw function.DREAM_LAND                  // Winter Dreamland
    dw OS.NULL                              // Sheik Break the Targets
    dw function.CLONE                       // Glacial River Remix
    dw OS.NULL                              // Marina Break the Targets
    dw function.CLONE                       // Dragon King Remix
    dw OS.NULL                              // Marina Board the Platforms
    dw OS.NULL                              // Dedede Break the Targets
    dw Hazards.draculas_castle_setup_       // Draculas Castle
    dw Hazards.draculas_castle_setup_       // Inverted Castle
    dw OS.NULL                              // Dedede Board the Platforms
    dw function.CLONE                       // Mt. Dedede
    dw function.CLONE                       // Edo Town
    dw function.CLONE                       // Deku Tree DL
    dw function.CLONE                       // Crateria/Zlanding DL
    dw OS.NULL                              // Goemon Break the Targets
    dw function.CLONE                       // First Destination Remix
    dw OS.NULL                              // Goemon BTP
    dw Hazards.twilight_city_setup          // Twilight City
    dw function.CLONE                       // Melrode
    dw function.CLONE                       // Meta Crystal Remix
    dw Hazards.remix_rttf_setup_            // Remix 1p Race to the Finish
    dw function.CLONE                       // Grim Reapers Cavern
    dw Hazards.scuttle_town_setup_          // Scuttle Town
    dw Hazards.bbh_setup_                   // Big Boo's Haunt
    dw function.CLONE                       // Yoshis Island III
    dw OS.NULL                              // Banjo BTT
    dw Hazards.spawned_fear_acid_setup_     // Spawned Fear
    dw function.CLONE                       // Smashville Remix
    dw OS.NULL                              // Banjo BTP
    dw function.CLONE                       // Pokefloats
    dw function.CLONE                       // Big Snowman
    dw function.CLONE                       // Dream Land Beta DL
    dw function.PEACHS_CASTLE               // LMAO Castle
    dw function.CLONE                       // Discovery Falls
    dw Hazards.crash_btt_setup              // Crash BTT
    dw function.CLONE                       // Discovery Falls Remix
    dw function.CLONE                       // N64 Remix
    dw Hazards.crash_btp_setup              // Crash BTP
    dw OS.NULL                              // Peach BTT
    dw OS.NULL                              // Peach BTP
    dw function.CLONE                       // Soccer
    dw Hazards.time_twister_setup_          // Time Twister
    dw function.CLONE                       // Time Twister SSS
    dw function.CLONE                       // N. Sanity Beach
    dw function.CLONE                       // Snow Go
    dw function.CLONE                       // Future Frenzy

    // @ Description
    // Offsets to image footer struct for stage icons sorted by stage id
    icon_offset_table:
    dw 0x00000978                           // Peach's Castle
    dw 0x00001338                           // Sector Z
    dw 0x00001CF8                           // Congo Jungle
    dw 0x000026B8                           // Planet Zebes
    dw 0x00003078                           // Hyrule Castle
    dw 0x00003A38                           // Yoshi's Island
    dw 0x000043F8                           // Dream Land
    dw 0x00004DB8                           // Saffron City
    dw 0x00005778                           // Mushroom Kingdom
    dw 0x00006138                           // Dream Land Beta 1
    dw 0x00006AF8                           // Dream Land Beta 2
    dw 0x000074B8                           // How to Play
    dw 0x00003A38                           // Mini Yoshi's Island
    dw 0x00007E78                           // Meta Crystal
    dw 0x00008838                           // Duel Zone
    dw 0x0000A578                           // Race to the Finish
    dw 0x000091F8                           // Final Destination
    dw 0x0000A578                           // BTT Mario
    dw 0x0000A578                           // BTT Fox
    dw 0x0000A578                           // BTT DK
    dw 0x0000A578                           // BTT Samus
    dw 0x0000A578                           // BTT Luigi
    dw 0x0000A578                           // BTT Link
    dw 0x0000A578                           // BTT Yoshi
    dw 0x0000A578                           // BTT Falcon
    dw 0x0000A578                           // BTT Kirby
    dw 0x0000A578                           // BTT Pikachu
    dw 0x0000A578                           // BTT Jigglypuff
    dw 0x0000A578                           // BTT Ness
    dw 0x0000A578                           // BTP Mario
    dw 0x0000A578                           // BTP Fox
    dw 0x0000A578                           // BTP DK
    dw 0x0000A578                           // BTP Samus
    dw 0x0000A578                           // BTP Luigi
    dw 0x0000A578                           // BTP Link
    dw 0x0000A578                           // BTP Yoshi
    dw 0x0000A578                           // BTP Falcon
    dw 0x0000A578                           // BTP Kirby
    dw 0x0000A578                           // BTP Pikachu
    dw 0x0000A578                           // BTP Jigglypuff
    dw 0x0000A578                           // BTP Ness
    dw 0x0000AF38                           // Deku Tree
    dw 0x0000B8F8                           // First Destination
    dw 0x0000C2B8                           // Ganon's Tower
    dw 0x0000CC78                           // Gym Leader Castle
    dw 0x0000D638                           // Pokemon Stadium
    dw 0x0000DFF8                           // Tal Tal
    dw 0x0000E9B8                           // Glacial River
    dw 0x0000F378                           // WarioWare
    dw 0x0000FD38                           // Battlefield
    dw 0x00023EF8                           // Flat Zone
    dw 0x000110B8                           // Dr. Mario
    dw 0x00011A78                           // Cool Cool Mountain
    dw 0x00012438                           // Dragon King
    dw 0x00012DF8                           // Great Bay
    dw 0x000137B8                           // Fray's Stage
    dw 0x00014178                           // Tower of Heaven
    dw 0x00014B38                           // Fountain of Dreams
    dw 0x000154F8                           // Muda Kingdom
    dw 0x00015EB8                           // Mementos
    dw 0x00016878                           // Showdown
    dw 0x00017238                           // Spiral Mountain
    dw 0x00017BF8                           // N64
    dw 0x000185B8                           // Mute City
    dw 0x00018F78                           // Mad Monster Mansion
    dw 0x00005778                           // Mushroom Kingdom DL
    dw 0x0001A2F8                           // Mushroom Kingdom Omega
    dw 0x0001ACB8                           // Bowser's Stadium
    dw 0x0001B678                           // Peach's Castle II
    dw 0x0001C038                           // Delfino Plaza
    dw 0x0001C9F8                           // Corneria
    dw 0x0001D3B8                           // Kitchen Island
    dw 0x0001DD78                           // Big Blue
    dw 0x0001E738                           // Onett
    dw 0x0001F0F8                           // Zebes Landing
    dw 0x0001FAB8                           // Frosty Village
    dw 0x00020478                           // Smashville
    dw 0x0000A578                           // BTT Dr. Mario
    dw 0x0000A578                           // BTT Ganondorf
    dw 0x0000A578                           // BTT Young Link
    dw 0x0000FD38                           // Battlefield DL
    dw 0x0000A578                           // BTT Dark Samus
    dw 0x0000A578                           // BTT Stage 1
    dw 0x0000A578                           // BTT Falco
    dw 0x0000A578                           // BTT Wario
    dw 0x000217F8                           // Hyrule Temple
    dw 0x0000A578                           // BTT Lucas
    dw 0x0000A578                           // BTP Ganondorf
    dw 0x000221B8                           // New Pork City
    dw 0x0000A578                           // BTP Dark Samus
    dw 0x00022B78                           // Smashketball
    dw 0x0000A578                           // BTP Dr. Mario
    dw 0x00023538                           // Norfair
    dw 0x000106F8                           // Raid Blue
    dw 0x00020E38                           // Congo Falls
    dw 0x000248B8                           // Osohe
    dw 0x00025278                           // Yoshi's Story II
    dw 0x00025C38                           // World 1-1
    dw 0x000265F8                           // Flat Zone II
    dw 0x00026FB8                           // Gerudo Valley
    dw 0x0000A578                           // BTP Young Link
    dw 0x0000A578                           // BTP Falco
    dw 0x0000A578                           // BTP Poly
    dw 0x00003078                           // Hyrule Castle DL
    dw 0x00003078                           // Hyrule Castle Omega
    dw 0x00001CF8                           // Congo Jungle DL
    dw 0x00001CF8                           // Congo Jungle Omega
    dw 0x00000978                           // Peach's Castle DL
    dw 0x00000978                           // Peach's Castle Omega
    dw 0x0000A578                           // BTP Wario
    dw 0x0003A5E8                           // Fray's Stage Night
    dw 0x00027978                           // Goomba Road
    dw 0x0000A578                           // BTP Lucas
    dw 0x00001338                           // Sector Z Dreamland
    dw 0x00004DB8                           // Saffron City Dreamland
    dw 0x00003A38                           // Yoshi's Island Dreamland
    dw 0x000026B8                           // Planet Zebes Dreamland
    dw 0x00001338                           // Sector Z Omega
    dw 0x00004DB8                           // Saffron City Omega
    dw 0x00003A38                           // Yoshi's Island Omega
    dw 0x000043F8                           // Dream Land Omega
    dw 0x000026B8                           // Planet Zebes Omega
    dw 0x0000A578                           // BTT Bowser
    dw 0x0000A578                           // BTP Bowser
    dw 0x00028338                           // Bowser's Keep
    dw 0x00028CF8                           // Rith Essa
    dw 0x000296B8                           // Venom
    dw 0x0000A578                           // BTT Wolf
    dw 0x0000A578                           // BTP Wolf
    dw 0x0000A578                           // BTT Conker
    dw 0x0000A578                           // BTP Conker
    dw 0x0002A078                           // Windy
    dw 0x0002AA38                           // dataDyne
    dw 0x0002B3F8                           // Planet Clancer
    dw 0x0002D138                           // Jungle Japes
    dw 0x0000A578                           // BTT Marth
    dw 0x0002BDB8                           // Game Boy Land
    dw 0x0000A578                           // BTT Mewtwo
    dw 0x0000A578                           // BTP Marth
    dw 0x0000A578                           // Allstar Rest Area
    dw 0x0000A578                           // BTP Mewtwo
    dw 0x0002DAF8                           // Castle Siege
    dw 0x0002C778                           // Yoshi's Island II
    dw 0x000091F8                           // Final Destination DL
    dw 0x000091F8                           // Final Tentination
    dw 0x00011A78                           // Cool Cool Mountain Remix
    dw 0x00008838                           // Duel Zone DL
    dw 0x00011A78                           // Cool Cool DL
    dw 0x00007E78                           // Meta Crystal DL
    dw 0x000043F8                           // Dream Greens
    dw 0x00000978                           // Peach's Castle Beta
    dw 0x00003078                           // Hyrule Castle Remix
    dw 0x00001338                           // Sector Z Remix
    dw 0x000185B8                           // Mute City DL
    dw 0x00005778                           // Home Run Contest
    dw 0x00005778                           // Mushroom Kingdom Remix
    dw 0x0002EE78                           // Green Hill Zone
    dw 0x0002E4B8                           // Subcon
    dw 0x0002FC58                           // Pirate Land
    dw 0x00030A38                           // Casino Night
    dw 0x0000A578                           // BTT Sonic
    dw 0x0000A578                           // BTP Sonic
    dw 0x000313F8                           // Metallic Madness
    dw 0x00031DB8                           // Rainbow Road
    dw 0x0003B958                           // Pokemon Stadium 2
    dw 0x00023538                           // Norfair Remix
    dw 0x00032778                           // Toad's Turnpike
    dw 0x0000DFF8                           // Tal Tal Heights Remix
    dw 0x0000A578                           // BTP Sheik
    dw 0x000043F8                           // Winter Dream Land
    dw 0x0000A578                           // BTT Sheik
    dw 0x0000E9B8                           // Glacial River Remix
    dw 0x0000A578                           // BTT Marina
    dw 0x00012438                           // Dragon King Remix
    dw 0x0000A578                           // BTP Marina
    dw 0x0000A578                           // BTT Dedede
    dw 0x00033138                           // Draculas Castle
    dw 0x00033138                           // Inverted Castle
    dw 0x0000A578                           // BTP Dedede
    dw 0x00033AF8                           // Mt. Dedede
    dw 0x000344B8                           // Edo Town
    dw 0x0000AF38                           // Deku Tree DL
    dw 0x0001F0F8                           // Zebes Landing DL
    dw 0x0000A578                           // BTT Goemon
    dw 0x0000B8F8                           // First Destination Remix
    dw 0x0000A578                           // BTP Goemon
    dw 0x00034E70                           // Twilight City
    dw 0x00035828                           // Melrode
    dw 0x00007E78                           // Meta Crystal Remix
    dw 0x0000A578                           // Remix 1p Race to the Finish
    dw 0x000361E0                           // Grim Reapers Cavern
    dw 0x00036B98                           // Scuttle Town
    dw 0x00037550                           // Big Boo's Haunt
    dw 0x00037F08                           // Yoshis Island Melee
    dw 0x0000A578                           // BTT Banjo
    dw 0x000388C0                           // Spawned Fear
    dw 0x0003AFA0                           // Smashville Remix
    dw 0x0000A578                           // BTP Banjo
    dw 0x00039278                           // Pokefloats
    dw 0x00039C30                           // Big Snowman
    dw 0x00006138                           // Dream Land Beta DL
    dw 0x00000978                           // LMAO Castle
    dw 0x0003C310                           // Discovery Falls
    dw 0x0000A578                           // BTT Crash
    dw 0x0003C310                           // Discovery Falls Remix
    dw 0x00017BF8                           // N64
    dw 0x0000A578                           // BTP Crash
    dw 0x0000A578                           // BTT Peach
    dw 0x0000A578                           // BTP Peach
    dw 0x00022B78                           // Soccer
    dw 0x0003CCC8                           // Time Twister
    dw 0x0003CCC8                           // Time Twister SSS
    dw 0x0003CCC8                           // N. Sanity Beach
    dw 0x0003CCC8                           // Snow Go
    dw 0x0003CCC8                           // Future Frenzy

    icon_offset_random:
    dw 0x00009BB8                           // Random

    // @ Description
    // Row the cursor is on
    row:
    db 0

    // @ Description
    // column the cursor is on
    column:
    db 0

    // @ Description
    // When there are variants, it's the stage ID of the Def. stage
    original_stage_id:
    db 0x0

    // @ Description
    // Selected stage variant
    variant:
    db 0x0

    // @ Description
    // Page number for the SSS
    page_number:
    dw 0x00000000

    // @ Description
    // Pointer to stage name address
    stage_name:
    dw 0x00000000

    // @ Description
    // Random Stage Roulette timer to control speed.
    // Nonzero if active; flag -1 if 'A' or 'Start' was pressed
    roulette_cursor_timer:
    dw 0

    // @ Description
    // Flag to handle B presses while Stage Roulette is active
    roulette_pressed_b:
    dw OS.FALSE

    zoom_table:
    float32 0.5                         // Peach's Castle
    float32 0.2                         // Sector Z
    float32 0.6                         // Congo Jungle
    float32 0.5                         // Planet Zebes
    float32 0.3                         // Hyrule Castle
    float32 0.6                         // Yoshi's Island
    float32 0.5                         // Dream Land
    float32 0.4                         // Saffron City
    float32 0.2                         // Mushroom Kingdom
    float32 0.5                         // Dream Land Beta 1
    float32 0.3                         // Dream Land Beta 2
    float32 0.5                         // How to Play
    float32 0.5                         // Mini Yoshi's Island
    float32 0.5                         // Meta Crystal
    float32 0.5                         // Duel Zone
    float32 0.5                         // Race to the Finish (Placeholder)
    float32 0.5                         // Final Destination
    float32 0.5                         // BTT Mario
    float32 0.5                         // BTT Fox
    float32 0.5                         // BTT DK
    float32 0.5                         // BTT Samus
    float32 0.5                         // BTT Luigi
    float32 0.5                         // BTT Link
    float32 0.5                         // BTT Yoshi
    float32 0.5                         // BTT Falcon
    float32 0.5                         // BTT Kirby
    float32 0.5                         // BTT Pikachu
    float32 0.5                         // BTT Jigglypuff
    float32 0.5                         // BTT Ness
    float32 0.5                         // BTP Mario
    float32 0.5                         // BTP Fox
    float32 0.5                         // BTP DK
    float32 0.5                         // BTP Samus
    float32 0.5                         // BTP Luigi
    float32 0.5                         // BTP Link
    float32 0.5                         // BTP Yoshi
    float32 0.5                         // BTP Falcon
    float32 0.5                         // BTP Kirby
    float32 0.5                         // BTP Pikachu
    float32 0.5                         // BTP Jigglypuff
    float32 0.5                         // BTP Ness
    float32 0.3                         // Deku Tree
    float32 0.5                         // First Destination
    float32 0.3                         // Ganon's Tower
    float32 0.4                         // Gym Leader Castle
    float32 0.5                         // Pokemon Stadium
    float32 0.35                        // Tal Tal
    float32 0.5                         // Glacial River
    float32 0.5                         // WarioWare
    float32 0.5                         // Battlefield
    float32 0.4                         // Flat Zone
    float32 0.5                         // Dr. Mario
    float32 0.4                         // Cool Cool Mountain
    float32 0.4                         // Dragon King
    float32 0.5                         // Great Bay
    float32 0.5                         // Fray's Stage
    float32 0.45                        // Tower of Heaven
    float32 0.5                         // Fountain of Dreams
    float32 0.5                         // Muda Kingdom
    float32 0.4                         // Mementos
    float32 0.5                         // Showdown
    float32 0.5                         // Spiral Mountain
    float32 0.4                         // N64
    float32 0.5                         // Mute City DL
    float32 0.4                         // Mad Monster Mansion
    float32 0.5                         // Mushroom Kingdom DL
    float32 0.5                         // Mushroom Kingdom Omega
    float32 0.4                         // Bowser's Stadium
    float32 0.4                         // Peach's Castle II
    float32 0.5                         // Delfino Plaza
    float32 0.4                         // Corneria
    float32 0.5                         // Kitchen Island
    float32 0.4                         // Big Blue
    float32 0.30                        // Onett
    float32 0.3                         // Zebes Landing
    float32 0.4                         // Frosty Village
    float32 0.5                         // Smashville
    float32 0.5                         // BTT Dr. Mario
    float32 0.5                         // BTT Ganondorf
    float32 0.5                         // BTT Young Link
    float32 0.5                         // Battlefield DL
    float32 0.5                         // BTT Dark Samus
    float32 0.5                         // BTT Stage 1
    float32 0.5                         // BTT Falco
    float32 0.5                         // BTT Wario
    float32 0.2                         // Hyrule Temple
    float32 0.5                         // BTT Lucas
    float32 0.5                         // BTP Ganondorf
    float32 0.4                         // New Pork City
    float32 0.5                         // BTP Dark Samus
    float32 0.5                         // Smashketball
    float32 0.5                         // BTP Dr. Mario
    float32 0.5                         // Norfair
    float32 0.4                         // Raid Blue
    float32 0.4                         // Congo Falls
    float32 0.4                         // Osohe
    float32 0.5                         // Yoshi's Island II
    float32 0.3                         // World 1-1
    float32 0.3                         // Flat Zone II
    float32 0.5                         // Gerudo Valley
    float32 0.5                         // Young Link Board the Platforms
    float32 0.5                         // Falco Board the Platforms
    float32 0.5                         // Lucas Board the Platforms
    float32 0.5                         // Hyrule Castle DL
    float32 0.5                         // Hyrule Castle Omega
    float32 0.5                         // Congo Jungle DL
    float32 0.5                         // Congo Jungle Omega
    float32 0.5                         // Peach's Castle DL
    float32 0.5                         // Peach's Castle Omega
    float32 0.5                         // Wario Board the Platforms
    float32 0.5                         // Fray's Stage - Night
    float32 0.5                         // Goomba Road
    float32 0.5                         // Lucas Board the Platforms
    float32 0.5                         // Sector Z Dream Land
    float32 0.5                         // Saffron City Dream Land
    float32 0.5                         // Yoshi's Island Dreamland
    float32 0.5                         // Planet Zebes Dreamland
    float32 0.5                         // Sector Z Omega
    float32 0.5                         // Saffron City Omega
    float32 0.5                         // Yoshi's Island Omega
    float32 0.5                         // Dream Land Omega
    float32 0.5                         // Planet Zebes Omega
    float32 0.5                         // Bowser Break the Targets
    float32 0.5                         // Bowser Board the Platforms
    float32 0.4                         // Bowser's Keep
    float32 0.3                         // Rith Essa
    float32 0.4                         // Venom
    float32 0.5                         // Wolf Break the Targets
    float32 0.5                         // Wolf Board the Platforms
    float32 0.5                         // Conker Break the Targets
    float32 0.5                         // Conker Board the Platforms
    float32 0.4                         // Windy
    float32 0.5                         // dataDyne
    float32 0.5                         // Planet Clancer
    float32 0.4                         // Jungle Japes
    float32 0.5                         // Marth Break the Targets
    float32 0.4                         // Game Boy Land
    float32 0.5                         // Mewtwo Break the Targets
    float32 0.5                         // Marth Board the Platforms
    float32 0.5                         // Allstar Rest Area
    float32 0.5                         // Mewtwo Board the Platforms
    float32 0.5                         // Castle Siege
    float32 0.5                         // Yoshi's Island II
    float32 0.5                         // Final Destination DL
    float32 0.5                         // Final Tentination
    float32 0.5                         // Cool Cool Mountain Remix
    float32 0.5                         // Duel Zone DL
    float32 0.5                         // Cool Cool DL
    float32 0.5                         // Meta Crystal DL
    float32 0.5                         // Dream Greens
    float32 0.5                         // Peach's Castle Beta
    float32 0.5                         // Hyrule Castle Remix
    float32 0.5                         // Sector Z Remix
    float32 0.4                         // Mute City
    float32 0.5                         // Home Run Contest
    float32 0.2                         // Mushroom Kingdom Remix
    float32 0.5                         // Green Hill Zone
    float32 0.3                         // Subcon
    float32 0.4                         // Pirate Land
    float32 0.4                         // Casino Night
    float32 0.5                         // Sonic Break the Targets
    float32 0.5                         // Sonic Break the Platforms
    float32 0.5                         // Metallic Madness
    float32 0.3                         // Rainbow Road
    float32 0.5                         // Pokemon Stadium 2
    float32 0.4                         // Norfair Remix
    float32 0.3                         // Toad's Turnpike
    float32 0.35                        // Tal Tal Heights Remix
    float32 0.5                         // Sheik Board the Platforms
    float32 0.5                         // Winter Dream Land
    float32 0.5                         // Sheik Break the Targets
    float32 0.5                         // Glacial River Remix
    float32 0.5                         // Marina Break the Targets
    float32 0.4                         // Dragon King Remix
    float32 0.5                         // Marina Board the Platforms
    float32 0.5                         // Dedede Break the Targets
    float32 0.3                         // Draculas Castle
    float32 0.3                         // Inverted Castle
    float32 0.5                         // Dedede Board the Platforms
    float32 0.4                         // Mt. Dedede
    float32 0.4                         // Edo Town
    float32 0.5                         // Deku Tree DL
    float32 0.5                         // Zebes Landing DL
    float32 0.5                         // BTT Goemon
    float32 0.4                         // First Destination Remix
    float32 0.5                         // BTP Goemon
    float32 0.25                        // Twilight City
    float32 0.5                         // Melrode
    float32 0.5                         // Meta Crystal Remix
    float32 0.5                         // Remix 1p Race to the Finish (Placeholder)
    float32 0.4                         // Grim Reapers Cavern
    float32 0.4                         // Scuttle Town
    float32 0.4                         // Big Boo's Haunt
    float32 0.3                         // Yoshis Island Melee
    float32 0.5                         // BTT Banjo
    float32 0.4                         // Spawned Fear
    float32 0.5                         // Smashville Remix
    float32 0.5                         // BTP Banjo
    float32 0.6                         // Pokefloats
    float32 0.5                         // Big Snowman
    float32 0.5                         // Dream Land Beta DL
    float32 0.5                         // LMAO Castle
    float32 0.5                         // Discovery Falls
    float32 0.5                         // BTT Crash
    float32 0.5                         // Discovery Falls Remix
    float32 0.5                         // N64 Remix
    float32 0.5                         // BTP Crash
    float32 0.5                         // BTT Peach
    float32 0.5                         // BTP Peach
    float32 0.5                         // Soccer
    float32 0.5                         // Time Twister
    float32 0.5                         // Time Twister SSS
    float32 0.5                         // N. Sanity Beach
    float32 0.5                         // Snow Go
    float32 0.5                         // Future Frenzy

    // @ Description
    // This holds pointers to position arrays for positioning stage previews.
    // If not set, then original positioning (0,0,0) is used.
    position_table:
    constant POSITION_TABLE_ORIGIN(origin())
    fill 4 * (id.MAX_STAGE_ID + 1)

    background_table:
    db id.PEACHS_CASTLE                 // Peach's Castle
    db id.SECTOR_Z                      // Sector Z
    db id.CONGO_JUNGLE                  // Congo Jungle
    db id.PLANET_ZEBES                  // Planet Zebes
    db id.HYRULE_CASTLE                 // Hyrule Castle
    db id.YOSHIS_ISLAND                 // Yoshi's Island
    db id.DREAM_LAND                    // Dream Land
    db id.SAFFRON_CITY                  // Saffron City
    db id.MUSHROOM_KINGDOM              // Mushroom Kingdom
    db id.DREAM_LAND                    // Dream Land Beta 1
    db id.DREAM_LAND                    // Dream Land Beta 2
    db id.DREAM_LAND                    // How to Play
    db id.YOSHIS_ISLAND                 // Yoshi's Island (1P)
    db id.SECTOR_Z                      // Meta Crystal
    db id.SECTOR_Z                      // Batlefield
    db id.SECTOR_Z                      // Race to the Finish (Placeholder)
    db id.SECTOR_Z                      // Final Destination
    db id.SECTOR_Z                      // BTT Mario
    db id.SECTOR_Z                      // BTT Fox
    db id.SECTOR_Z                      // BTT DK
    db id.SECTOR_Z                      // BTT Samus
    db id.SECTOR_Z                      // BTT Luigi
    db id.SECTOR_Z                      // BTT Link
    db id.SECTOR_Z                      // BTT Yoshi
    db id.SECTOR_Z                      // BTT Falcon
    db id.SECTOR_Z                      // BTT Kirby
    db id.SECTOR_Z                      // BTT Pikachu
    db id.SECTOR_Z                      // BTT Jigglypuff
    db id.SECTOR_Z                      // BTT Ness
    db id.SECTOR_Z                      // BTP Mario
    db id.SECTOR_Z                      // BTP Fox
    db id.SECTOR_Z                      // BTP DK
    db id.SECTOR_Z                      // BTP Samus
    db id.SECTOR_Z                      // BTP Luigi
    db id.SECTOR_Z                      // BTP Link
    db id.SECTOR_Z                      // BTP Yoshi
    db id.SECTOR_Z                      // BTP Falcon
    db id.SECTOR_Z                      // BTP Kirby
    db id.SECTOR_Z                      // BTP Pikachu
    db id.SECTOR_Z                      // BTP Jigglypuff
    db id.SECTOR_Z                      // BTP Ness
    db id.YOSHIS_ISLAND                 // Deku Tree
    db id.PEACHS_CASTLE                 // First Destination
    db id.SECTOR_Z                      // Ganon's Tower
    db id.YOSHIS_ISLAND                 // Gym Leader Castle
    db id.SECTOR_Z                      // Pokemon Stadium
    db id.PEACHS_CASTLE                 // Tal Tal Heights
    db id.PEACHS_CASTLE                 // Glacial River
    db id.SECTOR_Z                      // WarioWare
    db id.PEACHS_CASTLE                 // Battlefield
    db id.SECTOR_Z                      // Flat Zone
    db id.YOSHIS_ISLAND                 // Dr. Mario
    db id.PEACHS_CASTLE                 // Cool Cool Mountain
    db id.PEACHS_CASTLE                 // Dragon King
    db id.PEACHS_CASTLE                 // Great Bay
    db id.YOSHIS_ISLAND                 // Fray's Stage
    db id.SECTOR_Z                      // Tower of Heaven
    db id.SECTOR_Z                      // Fountain of Dreams
    db id.YOSHIS_ISLAND                 // Muda Kingdom
    db id.SECTOR_Z                      // Mementos
    db id.SECTOR_Z                      // Showdown
    db id.PEACHS_CASTLE                 // Spiral Mountain
    db id.PEACHS_CASTLE                 // N64
    db id.PEACHS_CASTLE                 // Mute City DL
    db id.SECTOR_Z                      // Mad Monster Mansion
    db id.MUSHROOM_KINGDOM              // Mushroom Kingdom DL
    db id.MUSHROOM_KINGDOM              // Mushroom Kingdom Omega
    db id.SECTOR_Z                      // Bowser's Stadium
    db id.PEACHS_CASTLE                 // Peach's Castle II
    db id.PEACHS_CASTLE                 // Delfino Plaza
    db id.PEACHS_CASTLE                 // Corneria
    db id.PEACHS_CASTLE                 // Kitchen Island
    db id.PEACHS_CASTLE                 // Big Blue
    db id.PEACHS_CASTLE                 // Onett
    db id.SECTOR_Z                      // Zebes Landing
    db id.SECTOR_Z                      // Frosty Village
    db id.PEACHS_CASTLE                 // Smashville
    db id.SECTOR_Z                      // BTT Dr. Mario
    db id.SECTOR_Z                      // BTT Ganondorf
    db id.PEACHS_CASTLE                 // BTT Young Link
    db id.PEACHS_CASTLE                 // Battlefield DL
    db id.SECTOR_Z                      // BTT Dark Samus
    db id.SECTOR_Z                      // BTT Stage 1
    db id.SECTOR_Z                      // BTT Falco
    db id.SECTOR_Z                      // BTT Wario
    db id.PEACHS_CASTLE                 // Hyrule Temple
    db id.SECTOR_Z                      // BTT Lucas
    db id.SECTOR_Z                      // BTP Ganondorf
    db id.SECTOR_Z                      // New Pork City
    db id.SECTOR_Z                      // BTP Dark Samus
    db id.SECTOR_Z                      // Smashketball
    db id.SECTOR_Z                      // BTP Dr. Mario
    db id.SECTOR_Z                      // Norfair
    db id.PEACHS_CASTLE                 // Raid Blue
    db id.PEACHS_CASTLE                 // Congo Falls
    db id.PEACHS_CASTLE                 // Osohe
    db id.PEACHS_CASTLE                 // Yoshi's Island II
    db id.PEACHS_CASTLE                 // World 1-1
    db id.SECTOR_Z                      // Flat Zone II
    db id.YOSHIS_ISLAND                 // Gerudo Valley
    db id.SECTOR_Z                      // Young Link Board the Platforms
    db id.SECTOR_Z                      // Falco Board the Platforms
    db id.SECTOR_Z                      // Poly Board the Platforms
    db id.HYRULE_CASTLE                 // Hyrule Castle DL
    db id.HYRULE_CASTLE                 // Hyrule Castle Omega
    db id.CONGO_JUNGLE                  // Congo Jungle DL
    db id.CONGO_JUNGLE                  // Congo Jungle Omega
    db id.PEACHS_CASTLE                 // Peach's Castle DL
    db id.PEACHS_CASTLE                 // Peach's Castle Omega
    db id.SECTOR_Z                      // Wario Board the Platforms
    db id.SECTOR_Z                      // Fray's Stage - Night
    db id.PEACHS_CASTLE                 // Goomba Road
    db id.SECTOR_Z                      // Lucas Board the Platforms
    db id.SECTOR_Z                      // Sector Z Dreamland
    db id.PEACHS_CASTLE                 // Saffron City Dreamland
    db id.YOSHIS_ISLAND                 // Yoshi's Island Dreamland
    db id.PLANET_ZEBES                  // Planet Zebes Dreamland
    db id.SECTOR_Z                      // Sector Z Omega
    db id.PEACHS_CASTLE                 // Saffron City Omega
    db id.YOSHIS_ISLAND                 // Yoshi's Island Omega
    db id.DREAM_LAND                    // Dream Land Omega
    db id.PLANET_ZEBES                  // Planet Zebes Omega
    db id.SECTOR_Z                      // Bowser Break the Targets
    db id.SECTOR_Z                      // Bowser Board the Platforms
    db id.CONGO_JUNGLE                  // Bowser's Keep
    db id.YOSHIS_ISLAND                 // Rith Essa
    db id.YOSHIS_ISLAND                 // Venom
    db id.SECTOR_Z                      // Wolf Break the Targets
    db id.SECTOR_Z                      // Wolf Board the Platforms
    db id.SECTOR_Z                      // Conker Break the Targets
    db id.SECTOR_Z                      // Conker Board the Platforms
    db id.PEACHS_CASTLE                 // Windy
    db id.SECTOR_Z                      // dataDyne
    db id.PEACHS_CASTLE                 // Planet Clancer
    db id.SECTOR_Z                      // Jungle Japes
    db id.SECTOR_Z                      // Marth Break the Targets
    db id.YOSHIS_ISLAND                 // Game Boy Land
    db id.SECTOR_Z                      // Mewtwo Break the Targets
    db id.SECTOR_Z                      // Marth Board the Platforms
    db id.SECTOR_Z                      // Allstar Rest Area
    db id.SECTOR_Z                      // Mewtwo Board the Platforms
    db id.PEACHS_CASTLE                 // Castle Siege
    db id.YOSHIS_ISLAND                 // Yoshi's Island II
    db id.SECTOR_Z                      // Final Destination DL
    db id.SECTOR_Z                      // Final Tentination
    db id.PEACHS_CASTLE                 // Cool Cool Mountain Remix
    db id.SECTOR_Z                      // Duel Zone DL
    db id.PEACHS_CASTLE                 // Cool Cool DL
    db id.SECTOR_Z                      // Meta Crystal DL
    db id.PEACHS_CASTLE                 // Dream Greens
    db id.PEACHS_CASTLE                 // Peach's Castle Beta
    db id.PEACHS_CASTLE                 // Hyrule Castle Remix
    db id.SECTOR_Z                      // Sector Z Remix
    db id.PEACHS_CASTLE                 // Mute City
    db id.PEACHS_CASTLE                 // Home Run Contest
    db id.MUSHROOM_KINGDOM              // Mushroom Kingdom Remix
    db id.PEACHS_CASTLE                 // Green Hill Zone
    db id.PEACHS_CASTLE                 // Subcon
    db id.PEACHS_CASTLE                 // Pirate Land
    db id.SECTOR_Z                      // Casino Night Zone
    db id.SECTOR_Z                      // Sonic Break the Targets
    db id.SECTOR_Z                      // Sonic Board the Platforms
    db id.SECTOR_Z                      // Metallic Madness
    db id.SECTOR_Z                      // Rainbow Road
    db id.SECTOR_Z                      // Pokemon Stadium 2
    db id.SECTOR_Z                      // Norfair Remix
    db id.YOSHIS_ISLAND                 // Toad's Turnpike
    db id.PEACHS_CASTLE                 // Tal Tal Heights Remix
    db id.SECTOR_Z                      // Sheik Board the Platforms
    db id.PEACHS_CASTLE                 // Winter Dream Land
    db id.SECTOR_Z                      // Sheik Break the Targets
    db id.PEACHS_CASTLE                 // Glacial River Remix
    db id.SECTOR_Z                      // Marina Break the Targets
    db id.YOSHIS_ISLAND                 // Dragon King Remix
    db id.SECTOR_Z                      // Marina Board the Platforms
    db id.SECTOR_Z                      // Dedede Break the Targets
    db id.SECTOR_Z                      // Draculas Castle
    db id.SECTOR_Z                      // Inverted Castle
    db id.SECTOR_Z                      // Dedede Board the Platforms
    db id.SECTOR_Z                      // Mt. Dedede
    db id.PEACHS_CASTLE                 // Edo Town
    db id.YOSHIS_ISLAND                 // Deku Tree DL
    db id.SECTOR_Z                      // Zebes Landing DL
    db id.SECTOR_Z                      // Goemon Break the Targets
    db id.PEACHS_CASTLE                 // First Destination Remix
    db id.SECTOR_Z                      // Goemon BTP
    db id.SECTOR_Z                      // Twilight City
    db id.YOSHIS_ISLAND                 // Melrode
    db id.SECTOR_Z                      // Meta Crystal Remix
    db id.SECTOR_Z                      // Remix 1p Race to the Finish (Placeholder)
    db id.SECTOR_Z                      // Grim Reapers Cavern
    db id.CONGO_JUNGLE                  // Scuttle Town
    db id.SECTOR_Z                      // Big Boo's Haunt
    db id.PEACHS_CASTLE                 // Yoshis Island Melee
    db id.SECTOR_Z                      // Banjo BTT
    db id.CONGO_JUNGLE                  // Spawned Fear
    db id.CONGO_JUNGLE                  // Smashville Remix
    db id.SECTOR_Z                      // Banjo BTP
    db id.PEACHS_CASTLE                 // Pokefloats
    db id.PEACHS_CASTLE                 // Big Snowman
    db id.PEACHS_CASTLE                 // Dream Land Beta DL
    db id.PEACHS_CASTLE                 // LMAO Castle
    db id.PEACHS_CASTLE                 // Discovery Falls
    db id.SECTOR_Z                      // Crash BTT
    db id.PEACHS_CASTLE                 // Discovery Falls Remix
    db id.PEACHS_CASTLE                 // N64 Remix
    db id.SECTOR_Z                      // Crash BTP
    db id.SECTOR_Z                      // Peach BTT
    db id.SECTOR_Z                      // Peach BTP
    db id.SECTOR_Z                      // Soccer
    db id.SECTOR_Z                      // Time Twister
    db id.SECTOR_Z                      // Time Twister SSS
    db id.PEACHS_CASTLE                 // N. Sanity Beach
    db id.PEACHS_CASTLE                 // Snow Go
    db id.SECTOR_Z                      // Future Frenzy
    OS.align(4)

    stage_file_table:
    // header file, type
    dw header.PEACHS_CASTLE,          type.PEACHS_CASTLE
    dw header.SECTOR_Z,               type.SECTOR_Z
    dw header.CONGO_JUNGLE,           type.CONGO_JUNGLE
    dw header.PLANET_ZEBES,           type.PLANET_ZEBES
    dw header.HYRULE_CASTLE,          type.HYRULE_CASTLE
    dw header.YOSHIS_ISLAND,          type.YOSHIS_ISLAND
    dw header.DREAM_LAND,             type.DREAM_LAND
    dw header.SAFFRON_CITY,           type.SAFFRON_CITY
    dw header.MUSHROOM_KINGDOM,       type.MUSHROOM_KINGDOM
    dw header.DREAM_LAND_BETA_1,      type.DREAM_LAND_BETA_1
    dw header.DREAM_LAND_BETA_2,      type.DREAM_LAND_BETA_2
    dw header.HOW_TO_PLAY,            type.HOW_TO_PLAY
    dw header.MINI_YOSHIS_ISLAND,     type.MINI_YOSHIS_ISLAND
    dw header.META_CRYSTAL,           type.META_CRYSTAL
    dw header.DUEL_ZONE,              type.DUEL_ZONE
    dw header.RACE_TO_THE_FINISH,     type.RACE_TO_THE_FINISH
    dw header.FINAL_DESTINATION,      type.FINAL_DESTINATION
    dw header.BTT_MARIO,              type.BTT
    dw header.BTT_FOX,                type.BTT
    dw header.BTT_DONKEY_KONG,        type.BTT
    dw header.BTT_SAMUS,              type.BTT
    dw header.BTT_LUIGI,              type.BTT
    dw header.BTT_LINK,               type.BTT
    dw header.BTT_YOSHI,              type.BTT
    dw header.BTT_FALCON,             type.BTT
    dw header.BTT_KIRBY,              type.BTT
    dw header.BTT_PIKACHU,            type.BTT
    dw header.BTT_JIGGLYPUFF,         type.BTT
    dw header.BTT_NESS,               type.BTT
    dw header.BTP_MARIO,              type.BTP
    dw header.BTP_FOX,                type.BTP
    dw header.BTP_DONKEY_KONG,        type.BTP
    dw header.BTP_SAMUS,              type.BTP
    dw header.BTP_LUIGI,              type.BTP
    dw header.BTP_LINK,               type.BTP
    dw header.BTP_YOSHI,              type.BTP
    dw header.BTP_FALCON,             type.BTP
    dw header.BTP_KIRBY,              type.BTP
    dw header.BTP_PIKACHU,            type.BTP
    dw header.BTP_JIGGLYPUFF,         type.BTP
    dw header.BTP_NESS,               type.BTP
    dw header.DEKU_TREE,              type.CLONE
    dw header.FIRST_DESTINATION,      type.CLONE
    dw header.GANONS_TOWER,           type.CLONE
    dw header.GYM_LEADER_CASTLE,      type.CLONE
    dw header.POKEMON_STADIUM,        type.CLONE
    dw header.TALTAL,                 type.CLONE
    dw header.GLACIAL,                type.CLONE
    dw header.WARIOWARE,              type.CLONE
    dw header.BATTLEFIELD,            type.CLONE
    dw header.FLAT_ZONE,              type.CLONE
    dw header.DR_MARIO,               type.CLONE
    dw header.COOLCOOL,               type.CLONE
    dw header.DRAGONKING,             type.CLONE
    dw header.GREAT_BAY,              type.CONGO_JUNGLE
    dw header.FRAYS_STAGE,            type.CLONE
    dw header.TOH,                    type.CLONE
    dw header.FOD,                    type.CONGO_JUNGLE
    dw header.MUDA,                   type.CLONE
    dw header.MEMENTOS,               type.CLONE
    dw header.SHOWDOWN,               type.CLONE
    dw header.SPIRALM,                type.CONGO_JUNGLE
    dw header.N64,                    type.CLONE
    dw header.MUTE_DL,                type.CLONE
    dw header.MADMM,                  type.CLONE
    dw header.SMBBF,                  type.MUSHROOM_KINGDOM
    dw header.SMBO,                   type.MUSHROOM_KINGDOM
    dw header.BOWSERB,                type.CLONE
    dw header.PEACH2,                 type.PEACHS_CASTLE
    dw header.DELFINO,                type.CLONE
    dw header.CORNERIA2,              type.SECTOR_Z
    dw header.KITCHEN,                type.PEACHS_CASTLE
    dw header.BLUE,                   type.PEACHS_CASTLE
    dw header.ONETT,                  type.CONGO_JUNGLE
    dw header.ZLANDING,               type.CLONE
    dw header.FROSTY,                 type.CLONE
    dw header.SMASHVILLE2,            type.CONGO_JUNGLE
    dw header.BTT_DRM,                type.BTT
    dw header.BTT_GND,                type.BTT
    dw header.BTT_YL,                 type.BTT
    dw header.BATTLEFIELD_DL,         type.CLONE
    dw header.BTT_DS,                 type.BTT
    dw header.BTT_STG1,               type.BTT
    dw header.BTT_FALCO,              type.BTT
    dw header.BTT_WARIO,              type.BTT
    dw header.HTEMPLE,                type.CLONE
    dw header.BTT_LUCAS,              type.BTT
    dw header.BTP_GND,                type.BTP
    dw header.NPC,                    type.CLONE
    dw header.BTP_DS,                 type.BTP
    dw header.SMASHKETBALL,           type.CONGO_JUNGLE
    dw header.BTP_DRM,                type.BTP
    dw header.NORFAIR,                type.PLANET_ZEBES
    dw header.RAIDBLUE,               type.CLONE
    dw header.FALLS,                  type.CONGO_JUNGLE
    dw header.OSOHE,                  type.CLONE
    dw header.YOSHI_STORY_2,          type.YOSHIS_ISLAND
    dw header.WORLD1,                 type.PEACHS_CASTLE
    dw header.FLAT_ZONE_2,            type.PEACHS_CASTLE
    dw header.GERUDO,                 type.CLONE
    dw header.BTP_YL,                 type.BTP
    dw header.BTP_FALCO,              type.BTP
    dw header.BTP_POLY,               type.BTP
    dw header.HCASTLE_DL,             type.HYRULE_CASTLE
    dw header.HCASTLE_O,              type.HYRULE_CASTLE
    dw header.CONGOJ_DL,              type.CONGO_JUNGLE
    dw header.CONGOJ_O,               type.CONGO_JUNGLE
    dw header.PCASTLE_DL,             type.PEACHS_CASTLE
    dw header.PCASTLE_O,              type.PEACHS_CASTLE
    dw header.BTP_WARIO,              type.BTP
    dw header.FRAYS_STAGE_NIGHT,      type.CLONE
    dw header.GOOMBA_ROAD,            type.CLONE
    dw header.BTP_LUCAS2,             type.BTP
    dw header.SECTOR_Z_DL,            type.SECTOR_Z
    dw header.SAFFRON_DL,             type.CONGO_JUNGLE
    dw header.YOSHI_ISLAND_DL,        type.YOSHIS_ISLAND
    dw header.ZEBES_DL,               type.PLANET_ZEBES
    dw header.SECTOR_Z_O,             type.SECTOR_Z
    dw header.SAFFRON_O,              type.CONGO_JUNGLE
    dw header.YOSHI_ISLAND_O,         type.YOSHIS_ISLAND
    dw header.DREAM_LAND_O,           type.DREAM_LAND
    dw header.ZEBES_O,                type.PLANET_ZEBES
    dw header.BTT_BOWSER,             type.BTT
    dw header.BTP_BOWSER,             type.BTP
    dw header.BOWSERS_KEEP,           type.PEACHS_CASTLE
    dw header.RITH_ESSA,              type.CLONE
    dw header.VENOM,                  type.SECTOR_Z
    dw header.BTT_WOLF,               type.BTT
    dw header.BTP_WOLF,               type.BTP
    dw header.BTT_CONKER,             type.BTT
    dw header.BTP_CONKER,             type.BTP
    dw header.WINDY,                  type.CLONE
    dw header.DATA,                   type.CLONE
    dw header.CLANCER,                type.CLONE
    dw header.JAPES,                  type.CLONE
    dw header.BTT_MARTH,              type.BTT
    dw header.GB_LAND,                type.CLONE
    dw header.BTT_MTWO,               type.BTT
    dw header.BTP_MARTH,              type.BTP
    dw header.REST,                   type.CLONE
    dw header.BTP_MTWO,               type.BTP
    dw header.CSIEGE,                 type.CLONE
    dw header.YOSHIS_ISLAND_II,       type.CLONE
    dw header.FINAL_DESTINATION_DL,   type.CLONE
    dw header.FINAL_DESTINATION_TENT, type.CLONE
    dw header.COOLCOOL_REMIX,         type.CLONE
    dw header.DUEL_ZONE_DL,           type.CLONE
    dw header.COOLCOOL_DL,            type.CLONE
    dw header.META_CRYSTAL_DL,        type.CLONE
    dw header.DREAM_LAND_SR,          type.DREAM_LAND
    dw header.PCASTLE_BETA,           type.PEACHS_CASTLE
    dw header.HCASTLE_REMIX,          type.HYRULE_CASTLE
    dw header.SECTOR_Z_REMIX,         type.SECTOR_Z
    dw header.MUTE,                   type.CLONE
    dw header.HRC,                    type.CLONE
    dw header.MK_REMIX,               type.MUSHROOM_KINGDOM
    dw header.GHZ,                    type.CLONE
    dw header.SUBCON,                 type.CLONE
    dw header.PIRATE,                 type.CLONE
    dw header.CASINO,                 type.PEACHS_CASTLE
    dw header.BTT_SONIC,              type.BTT
    dw header.BTP_SONIC,              type.BTP
    dw header.MMADNESS,               type.CLONE
    dw header.RAINBOWROAD,            type.CLONE
    dw header.POKEMON_STADIUM_2,      type.CLONE
    dw header.NORFAIR_REMIX,          type.PLANET_ZEBES
    dw header.TOADSTURNPIKE,          type.CLONE
    dw header.TALTAL_REMIX,           type.CLONE
    dw header.BTP_SHEIK,              type.BTP
    dw header.WINTER_DL,              type.DREAM_LAND
    dw header.BTT_SHEIK,              type.BTT
    dw header.GLACIAL_REMIX,          type.CLONE
    dw header.BTT_MARINA,             type.BTT
    dw header.DRAGONKING_REMIX,       type.CLONE
    dw header.BTP_MARINA,             type.BTP
    dw header.BTT_DEDEDE,             type.BTT
    dw header.DRACULAS_CASTLE,        type.CLONE
    dw header.INVERTED_CASTLE,        type.CLONE
    dw header.BTP_DEDEDE,             type.BTP
    dw header.MT_DEDEDE,              type.CLONE
    dw header.EDO,                    type.CLONE
    dw header.DEKU_TREE_DL,           type.CLONE
    dw header.ZLANDING_DL,            type.CLONE
    dw header.BTT_GOEMON,             type.BTT
    dw header.FIRST_REMIX,            type.CLONE
    dw header.BTP_GOEMON,             type.BTP
    dw header.TWILIGHT_CITY,          type.PEACHS_CASTLE
    dw header.MELRODE,                type.CLONE
    dw header.META_REMIX,             type.CLONE
    dw header.REMIX_RTTF,             type.RACE_TO_THE_FINISH
    dw header.REAPERS,                type.HYRULE_CASTLE
    dw header.SCUTTLE_TOWN,           type.CLONE
    dw header.BIG_BOOS_HAUNT,         type.CLONE
    dw header.YOSHIS_ISLAND_MELEE,    type.CLONE
    dw header.BTT_BANJO,              type.BTT
    dw header.SPAWNED_FEAR,           type.CLONE
    dw header.SMASHVILLE_REMIX,       type.CLONE
    dw header.BTP_BANJO,              type.BTP
    dw header.POKEFLOATS,             type.CLONE
    dw header.BIG_SNOWMAN,            type.CLONE
    dw header.DL_BETA_DL,             type.CLONE
    dw header.LMAO_CASTLE,            type.PEACHS_CASTLE
    dw header.DISCOVERY_FALLS,        type.CLONE
    dw header.BTT_CRASH,              type.BTT
    dw header.DISCOVERY_FALLS_REMIX,  type.CLONE
    dw header.N64_REMIX,              type.CLONE
    dw header.BTP_CRASH,              type.BTP
    dw header.BTT_PEACH,              type.BTT
    dw header.BTP_PEACH,              type.BTP
    dw header.SOCCER,                 type.CONGO_JUNGLE
    dw header.TIME_TWISTER,           type.CLONE
    dw header.TIME_TWISTER_SSS,       type.CLONE
    dw header.NSANITY_BEACH,          type.CLONE
    dw header.SNOW_GO,                type.CLONE
    dw header.FUTURE_FRENZY,          type.CLONE

    class_table:
    constant class_table_origin(origin())
    db class.BATTLE                     // Peach's Castle
    db class.BATTLE                     // Sector Z
    db class.BATTLE                     // Congo Jungle
    db class.BATTLE                     // Planet Zebes
    db class.BATTLE                     // Hyrule Castle
    db class.BATTLE                     // Yoshi's Island
    db class.BATTLE                     // Dream Land
    db class.BATTLE                     // Saffron City
    db class.BATTLE                     // Mushroom Kingdom
    db class.BATTLE                     // Dream Land Beta 1
    db class.BATTLE                     // Dream Land Beta 2
    db class.BATTLE                     // How to Play
    db class.BATTLE                     // Yoshi's Island (1P)
    db class.BATTLE                     // Meta Crystal
    db class.BATTLE                     // Batlefield
    db class.RTTF                       // Race to the Finish (Placeholder)
    db class.BATTLE                     // Final Destination
    db class.BTT                        // BTT Mario
    db class.BTT                        // BTT Fox
    db class.BTT                        // BTT DK
    db class.BTT                        // BTT Samus
    db class.BTT                        // BTT Luigi
    db class.BTT                        // BTT Link
    db class.BTT                        // BTT Yoshi
    db class.BTT                        // BTT Falcon
    db class.BTT                        // BTT Kirby
    db class.BTT                        // BTT Pikachu
    db class.BTT                        // BTT Jigglypuff
    db class.BTT                        // BTT Ness
    db class.BTP                        // BTP Mario
    db class.BTP                        // BTP Fox
    db class.BTP                        // BTP DK
    db class.BTP                        // BTP Samus
    db class.BTP                        // BTP Luigi
    db class.BTP                        // BTP Link
    db class.BTP                        // BTP Yoshi
    db class.BTP                        // BTP Falcon
    db class.BTP                        // BTP Kirby
    db class.BTP                        // BTP Pikachu
    db class.BTP                        // BTP Jigglypuff
    db class.BTP                        // BTP Ness
    fill id.MAX_STAGE_ID - id.BTX_LAST
    OS.align(4)

    bonus_pointer_table:
    constant bonus_pointer_table_origin(origin())
    dw 0                                // Peach's Castle
    dw 0                                // Sector Z
    dw 0                                // Congo Jungle
    dw 0                                // Planet Zebes
    dw 0                                // Hyrule Castle
    dw 0                                // Yoshi's Island
    dw 0                                // Dream Land
    dw 0                                // Saffron City
    dw 0                                // Mushroom Kingdom
    dw 0                                // Dream Land Beta 1
    dw 0                                // Dream Land Beta 2
    dw 0                                // How to Play
    dw 0                                // Yoshi's Island (1P)
    dw 0                                // Meta Crystal
    dw 0                                // Batlefield
    dw 0                                // Race to the Finish (Placeholder)
    dw 0                                // Final Destination
    dw 0x8018EEC4                       // BTT Mario
    dw 0x8018EED0                       // BTT Fox
    dw 0x8018EEDC                       // BTT DK
    dw 0x8018EEE8                       // BTT Samus
    dw 0x8018EEF4                       // BTT Luigi
    dw 0x8018EF00                       // BTT Link
    dw 0x8018EF0C                       // BTT Yoshi
    dw 0x8018EF18                       // BTT Falcon
    dw 0x8018EF24                       // BTT Kirby
    dw 0x8018EF30                       // BTT Pikachu
    dw 0x8018EF3C                       // BTT Jigglypuff
    dw 0x8018EF48                       // BTT Ness
    dw 0x8018EF54                       // BTP Mario
    dw 0x8018EF5C                       // BTP Fox
    dw 0x8018EF64                       // BTP DK
    dw 0x8018EF6C                       // BTP Samus
    dw 0x8018EF74                       // BTP Luigi
    dw 0x8018EF7C                       // BTP Link
    dw 0x8018EF84                       // BTP Yoshi
    dw 0x8018EF8C                       // BTP Falcon
    dw 0x8018EF94                       // BTP Kirby
    dw 0x8018EF9C                       // BTP Pikachu
    dw 0x8018EFA4                       // BTP Jigglypuff
    dw 0x8018EFAC                       // BTP Ness
    fill 4 * (id.MAX_STAGE_ID - id.BTX_LAST)

    string_peachs_castle:;          String.insert("Peach's Castle")
    string_sector_z:;               String.insert("Sector Z")
    string_congo_jungle:;           String.insert("Congo Jungle")
    string_planet_zebes:;           String.insert("Planet Zebes")
    string_hyrule_castle:;          String.insert("Hyrule Castle")
    string_yoshis_island:;          String.insert("Yoshi's Island")
    string_dream_land:;             String.insert("Dream Land")
    string_saffron_city:;           String.insert("Saffron City")
    string_mushroom_kingdom:;       String.insert("Mushroom Kingdom")
    string_dream_land_beta_1:;      String.insert("Dream Land Beta 1")
    string_dream_land_beta_2:;      String.insert("Dream Land Beta 2")
    string_how_to_play:;            String.insert("How to Play")
    string_mini_yoshis_island:;     String.insert("Mini Yoshi's Island")
    string_meta_crystal:;           String.insert("Meta Crystal")
    string_duel_zone:;              String.insert("Duel Zone")
    string_final_destination:;      String.insert("Final Destination")
    string_btp:;                    String.insert("Board the Platforms")
    string_btt:;                    String.insert("Break the Targets")

    string_table:
    constant string_table_origin(origin())
    dw string_peachs_castle
    dw string_sector_z
    dw string_congo_jungle
    dw string_planet_zebes
    dw string_hyrule_castle
    dw string_yoshis_island
    dw string_dream_land
    dw string_saffron_city
    dw string_mushroom_kingdom
    dw string_dream_land_beta_1
    dw string_dream_land_beta_2
    dw string_how_to_play
    dw string_mini_yoshis_island
    dw string_meta_crystal
    dw string_duel_zone
    dw string_dream_land                    // Race to the Finish (Placeholder)
    dw string_final_destination
    dw string_btt
    dw string_btt
    dw string_btt
    dw string_btt
    dw string_btt
    dw string_btt
    dw string_btt
    dw string_btt
    dw string_btt
    dw string_btt
    dw string_btt
    dw string_btt
    dw string_btp
    dw string_btp
    dw string_btp
    dw string_btp
    dw string_btp
    dw string_btp
    dw string_btp
    dw string_btp
    dw string_btp
    dw string_btp
    dw string_btp
    dw string_btp
    fill 4 * (id.MAX_STAGE_ID - id.BTX_LAST)

    // @ Description
    // Holds alternate BGM_IDs for each stage:
    // The index of each word corresponds to stage_id.
    // The word is split into 2 halfwords:
    // 0x0000 - Occasional BGM_ID
    // 0x0002 - Rare BGM_ID
    // 0x0004 - Rare BGM_ID 2
    alternate_music_table:
    constant alternate_music_table_origin(origin())
    fill 8 * (id.MAX_STAGE_ID + 1), 0xFF

    // @ Description
    // Holds stage IDs for each stage's variants:
    // The index corresponds to stage_id.
    // The words are split into bytes:
    // 0x0000 - DL variant stage_id
    // 0x0001 - Omega variant stage_id
    // 0x0002 - Remix variant stage_id
    // 0x0003 - Remix 2 variant stage_id
    // 0x0004 - Remix 3 variant stage_id
    // 0x0005 - Remix 4 variant stage_id
    // 0x0006 - Remix 5 variant stage_id
    // 0x0007 - Remix 6 variant stage_id
    variant_table:
    constant variant_table_origin(origin())
    fill 8 * (id.MAX_STAGE_ID + 1), 0xFF

    // Helps set vanilla stages as remix variants
    macro set_remix_variant(main_stage_id, variant_stage_id) {
        OS.patch_start(variant_table_origin + (8 * id.{main_stage_id}) + 2, variant_table + (8 * id.{main_stage_id}) + 2)
        db id.{variant_stage_id}
        OS.patch_end()
    }

    set_remix_variant(DREAM_LAND_BETA_1, DREAM_LAND_BETA_2)
    set_remix_variant(YOSHIS_ISLAND, MINI_YOSHIS_ISLAND)

    // @ Description
    // Holds custom item spawn rate weights for each stage.
    // The spawn rates are bytes and in order for each stage.
    custom_item_spawn_rate_table:
    constant custom_item_spawn_rate_table_origin(origin())
    fill Item.NUM_ITEMS * (id.MAX_STAGE_ID + 1)
    OS.align(4)

    // @ Description
    // Holds series logo IDs for each stage.
    // Series logos are in file 0x14, and offsets and positions are defined in CharacterSelect.asm.
    series_logo_table:
    constant series_logo_table_origin(origin())
    db CharacterSelect.series_logo.MARIO_BROS   // PEACHS_CASTLE(0x00)
    db CharacterSelect.series_logo.STARFOX      // SECTOR_Z(0x01)
    db CharacterSelect.series_logo.DONKEY_KONG  // CONGO_JUNGLE(0x02)
    db CharacterSelect.series_logo.METROID      // PLANET_ZEBES(0x03)
    db CharacterSelect.series_logo.ZELDA        // HYRULE_CASTLE(0x04)
    db CharacterSelect.series_logo.YOSHI        // YOSHIS_ISLAND(0x05)
    db CharacterSelect.series_logo.KIRBY        // DREAM_LAND(0x06)
    db CharacterSelect.series_logo.POKEMON      // SAFFRON_CITY(0x07)
    db CharacterSelect.series_logo.MARIO_BROS   // MUSHROOM_KINGDOM(0x08)
    db CharacterSelect.series_logo.KIRBY        // DREAM_LAND_BETA_1(0x09)
    db CharacterSelect.series_logo.KIRBY        // DREAM_LAND_BETA_2(0x0A)
    db CharacterSelect.series_logo.SMASH        // HOW_TO_PLAY(0x0B)
    db CharacterSelect.series_logo.YOSHI        // MINI_YOSHIS_ISLAND(0x0C)
    db CharacterSelect.series_logo.MARIO_BROS   // META_CRYSTAL(0x0D)
    db CharacterSelect.series_logo.SMASH        // DUEL_ZONE(0x0E)
    db CharacterSelect.series_logo.SMASH        // RACE_TO_THE_FINISH(0x0F)
    db CharacterSelect.series_logo.SMASH        // FINAL_DESTINATION(0x10)
    db CharacterSelect.series_logo.SMASH        // BTT_MARIO(0x11)
    db CharacterSelect.series_logo.SMASH        // BTT_FOX(0x12)
    db CharacterSelect.series_logo.SMASH        // BTT_DONKEY_KONG(0x13)
    db CharacterSelect.series_logo.SMASH        // BTT_SAMUS(0x14)
    db CharacterSelect.series_logo.SMASH        // BTT_LUIGI(0x15)
    db CharacterSelect.series_logo.SMASH        // BTT_LINK(0x16)
    db CharacterSelect.series_logo.SMASH        // BTT_YOSHI(0x17)
    db CharacterSelect.series_logo.SMASH        // BTT_FALCON(0x18)
    db CharacterSelect.series_logo.SMASH        // BTT_KIRBY(0x19)
    db CharacterSelect.series_logo.SMASH        // BTT_PIKACHU(0x1A)
    db CharacterSelect.series_logo.SMASH        // BTT_JIGGLYPUFF(0x1B)
    db CharacterSelect.series_logo.SMASH        // BTT_NESS(0x1C)
    db CharacterSelect.series_logo.SMASH        // BTP_MARIO(0x1D)
    db CharacterSelect.series_logo.SMASH        // BTP_FOX(0x1E)
    db CharacterSelect.series_logo.SMASH        // BTP_DONKEY_KONG(0x1F)
    db CharacterSelect.series_logo.SMASH        // BTP_SAMUS(0x20)
    db CharacterSelect.series_logo.SMASH        // BTP_LUIGI(0x21)
    db CharacterSelect.series_logo.SMASH        // BTP_LINK(0x22)
    db CharacterSelect.series_logo.SMASH        // BTP_YOSHI(0x23)
    db CharacterSelect.series_logo.SMASH        // BTP_FALCON(0x24)
    db CharacterSelect.series_logo.SMASH        // BTP_KIRBY(0x25)
    db CharacterSelect.series_logo.SMASH        // BTP_PIKACHU(0x26)
    db CharacterSelect.series_logo.SMASH        // BTP_JIGGLYPUFF(0x27)
    db CharacterSelect.series_logo.SMASH        // BTP_NESS(0x28)
    fill 4 * (id.MAX_STAGE_ID - id.BTX_LAST)
    OS.align(4)

    // @ Description
    // Holds hazard mode to be forced for each stage in the tournament layout.
    tournament_hazard_mode_table:
    constant tournament_hazard_mode_table_origin(origin())
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // PEACHS_CASTLE(0x00)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // SECTOR_Z(0x01)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // CONGO_JUNGLE(0x02)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // PLANET_ZEBES(0x03)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // HYRULE_CASTLE(0x04)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // YOSHIS_ISLAND(0x05)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // DREAM_LAND(0x06)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // SAFFRON_CITY(0x07)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // MUSHROOM_KINGDOM(0x08)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // DREAM_LAND_BETA_1(0x09)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // DREAM_LAND_BETA_2(0x0A)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // HOW_TO_PLAY(0x0B)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // MINI_YOSHIS_ISLAND(0x0C)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // META_CRYSTAL(0x0D)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // DUEL_ZONE(0x0E)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // RACE_TO_THE_FINISH(0x0F)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // FINAL_DESTINATION(0x10)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // BTT_MARIO(0x11)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // BTT_FOX(0x12)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // BTT_DONKEY_KONG(0x13)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // BTT_SAMUS(0x14)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // BTT_LUIGI(0x15)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // BTT_LINK(0x16)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // BTT_YOSHI(0x17)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // BTT_FALCON(0x18)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // BTT_KIRBY(0x19)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // BTT_PIKACHU(0x1A)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // BTT_JIGGLYPUFF(0x1B)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // BTT_NESS(0x1C)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // BTP_MARIO(0x1D)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // BTP_FOX(0x1E)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // BTP_DONKEY_KONG(0x1F)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // BTP_SAMUS(0x20)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // BTP_LUIGI(0x21)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // BTP_LINK(0x22)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // BTP_YOSHI(0x23)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // BTP_FALCON(0x24)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // BTP_KIRBY(0x25)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // BTP_PIKACHU(0x26)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // BTP_JIGGLYPUFF(0x27)
    db Hazards.mode.HAZARDS_ON_MOVEMENT_ON        // BTP_NESS(0x28)
    fill 4 * (id.MAX_STAGE_ID - id.BTX_LAST)
    OS.align(4)

    // @ Description
    // Holds whether the stage has hazards, movement or both.
    stage_hazard_table:
    constant stage_hazard_table_origin(origin())
    db Hazards.type.BOTH                // PEACHS_CASTLE(0x00)
    db Hazards.type.HAZARDS             // SECTOR_Z(0x01)
    db Hazards.type.BOTH                // CONGO_JUNGLE(0x02)
    db Hazards.type.BOTH                // PLANET_ZEBES(0x03)
    db Hazards.type.HAZARDS             // HYRULE_CASTLE(0x04)
    db Hazards.type.HAZARDS             // YOSHIS_ISLAND(0x05)
    db Hazards.type.HAZARDS             // DREAM_LAND(0x06)
    db Hazards.type.BOTH                // SAFFRON_CITY(0x07)
    db Hazards.type.HAZARDS             // MUSHROOM_KINGDOM(0x08)
    db Hazards.type.NONE                // DREAM_LAND_BETA_1(0x09)
    db Hazards.type.MOVEMENT            // DREAM_LAND_BETA_2(0x0A)
    db Hazards.type.NONE                // HOW_TO_PLAY(0x0B)
    db Hazards.type.NONE                // MINI_YOSHIS_ISLAND(0x0C)
    db Hazards.type.NONE                // META_CRYSTAL(0x0D)
    db Hazards.type.NONE                // DUEL_ZONE(0x0E)
    db Hazards.type.NONE                // RACE_TO_THE_FINISH(0x0F)
    db Hazards.type.NONE                // FINAL_DESTINATION(0x10)
    db Hazards.type.NONE                // BTT_MARIO(0x11) BTX_FIRST(0x11)
    db Hazards.type.NONE                // BTT_FOX(0x12)
    db Hazards.type.NONE                // BTT_DONKEY_KONG(0x13)
    db Hazards.type.NONE                // BTT_SAMUS(0x14)
    db Hazards.type.NONE                // BTT_LUIGI(0x15)
    db Hazards.type.NONE                // BTT_LINK(0x16)
    db Hazards.type.NONE                // BTT_YOSHI(0x17)
    db Hazards.type.NONE                // BTT_FALCON(0x18)
    db Hazards.type.NONE                // BTT_KIRBY(0x19)
    db Hazards.type.NONE                // BTT_PIKACHU(0x1A)
    db Hazards.type.NONE                // BTT_JIGGLYPUFF(0x1B)
    db Hazards.type.NONE                // BTT_NESS(0x1C)
    db Hazards.type.NONE                // BTP_MARIO(0x1D)
    db Hazards.type.NONE                // BTP_FOX(0x1E)
    db Hazards.type.NONE                // BTP_DONKEY_KONG(0x1F)
    db Hazards.type.NONE                // BTP_SAMUS(0x20)
    db Hazards.type.NONE                // BTP_LUIGI(0x21)
    db Hazards.type.NONE                // BTP_LINK(0x22)
    db Hazards.type.NONE                // BTP_YOSHI(0x23)
    db Hazards.type.NONE                // BTP_FALCON(0x24)
    db Hazards.type.NONE                // BTP_KIRBY(0x25)
    db Hazards.type.NONE                // BTP_PIKACHU(0x26)
    db Hazards.type.NONE                // BTP_JIGGLYPUFF(0x27)
    db Hazards.type.NONE                // BTP_NESS(0x28) BTX_LAST(0x28)
    fill 4 * (id.MAX_STAGE_ID - id.BTX_LAST), Hazards.type.NONE
    OS.align(4)

    // @ Description
    // This holds background music overrides for each stage
    default_music_track_table:
    constant DEFAULT_MUSIC_TRACK_TABLE_ORIGIN(origin())
    fill 2 * (id.MAX_STAGE_ID + 1), 0
    OS.align(4)

    // @ Description
    // Sets the default music track for a stage
    // If not set, value at 0x90 in main file for stage
    macro set_default_music(stage, track_id) {
        pushvar origin, base
        origin DEFAULT_MUSIC_TRACK_TABLE_ORIGIN + ({stage} * 2)
        dh      {track_id} + 1
        pullvar base, origin
    }

    variable new_stages(0)

    // @ Description
    // Updates the custom_item_spawn_rate_table
    // @ Arguments:
    // stage_id - stage ID
    // cloaking_device_rate - rate for Cloaking Device item
    // super_mushroom_rate - rate for Super Mushroom item
    // poison_mushroom_rate - rate for Poison Mushroom item
    // blue_shell_rate - rate for Spiny Shell item
    // lightning_rate - rate for Lightning item
    // deku_nut_rate - rate for Deku Nut item
    // franklin_badge_rate - rate for Franklin Badge item
    macro set_custom_item_spawn_rate(stage_id, cloaking_device_rate, super_mushroom_rate, poison_mushroom_rate, blue_shell_rate, lightning_rate, deku_nut_rate, franklin_badge_rate) {
        pushvar origin, base

        origin custom_item_spawn_rate_table_origin + ({stage_id} * Item.NUM_ITEMS)
        db     {cloaking_device_rate}
        db     {super_mushroom_rate}
        db     {poison_mushroom_rate}
        db     {blue_shell_rate}
        db     {lightning_rate}
        db     {deku_nut_rate}
        db     {franklin_badge_rate}
        db     default_item_rate        // pitfall
        db     default_item_rate        // goldengun
        db     default_item_rate        // dango
        db     default_item_rate        // p wing
        db     default_item_rate        // mrsaturn
        db     default_item_rate        // stopwatch

        pullvar base, origin
    }

    // @ Description
    // Updates the custom_item_spawn_rate_table for a single item
    // @ Arguments:
    // stage - The stage name
    // item - The custom item's name
    // rate - The rate for the item
    macro set_custom_item_spawn_rate(stage, item, rate) {
        evaluate stg_id(id.{stage})
        evaluate offset(Item.{item}.id - 0x2D) // 0x2D is the first custom item

        pushvar origin, base

        origin custom_item_spawn_rate_table_origin + ({stg_id} * Item.NUM_ITEMS) + {offset}
        db     {rate}

        pullvar base, origin
    }

    // @ Description
    // Adds a custom stage
    // TODO: beef this up so adding a stage isn't so painful
    // @ Arguments:
    // name - Short name for quick reference
    // display_name - Name to display
    // bgm - BGM_ID
    // bgm_occasional - BGM_ID for the Occasional alternate BGM, or -1 if no alternate. Example: {MIDI.id.COOLCOOLMOUNTAIN}
    // bgm_rare - BGM_ID for the Rare alternate BGM, or -1 if no alternate. Example: {MIDI.id.COOLCOOLMOUNTAIN}
    // bgm_rare2 - see above
    // tournament_legal - sets the default random stage toggle value for this stage in tournament profile... 1 if legal, 0 if not legal
    // tournament_hazard_mode - the hazard mode to force in tournament mode
    // netplay_legal - sets the default random stage toggle value for this stage in netplay profile... 1 if legal, 0 if not legal
    // can_toggle - (bool) indicates if this should be toggleable
    // class - stage class (see class scope)
    // btx_word_1 - first BTT related word in table 0x113604 or first BTP related word in table 0x113694
    // btx_word_2 - second BTT related word in table 0x113604 or second BTP related word in table 0x113694
    // btx_word_3 - third BTT related word in table 0x113604
    // variant_for_stage_id - If this stage is meant to be a variant, then this variable holds the stage_id this stage is a variant of
    // variant_type - stage variant type (see variant_type scope)
    // cloaking_device_rate - weight given to spawning the cloaking device custom item
    // super_mushroom_rate - weight given to spawning the super mushroom custom item
    // poison_mushroom_rate - weight given to spawning the poison mushroom custom item
    // blue_shell_rate - weight given to spawning the spiny shell custom item
    // lightning_rate - weight given to spawning the lightning custom item
    // deku_nut_rate - weight given to spawning the deku nut custom item
    // franklin_badge_rate - weight given to spawning the franklin badge custom item
    // series_logo - series logo ID, as defined in CharacterSelect.series_logo
    // hazard_type - indicates if the stage has hazards, movement or both
    // order - order of the stage in settings
    macro add_stage(name, display_name, bgm, bgm_occasional, bgm_rare, bgm_rare2, tournament_legal, tournament_hazard_mode, netplay_legal, can_toggle, class, btx_word_1, btx_word_2, btx_word_3, variant_for_stage_id, variant_type, cloaking_device_rate, super_mushroom_rate, poison_mushroom_rate, blue_shell_rate, lightning_rate, deku_nut_rate, franklin_badge_rate, series_logo, hazard_type, order) {

        global variable new_stages(new_stages + 1)
        evaluate new_stage_id(0x28 + new_stages)
        global define STAGE_{new_stage_id}_NAME({name})
        global define STAGE_{new_stage_id}_TITLE({display_name})
        global define STAGE_{new_stage_id}_TE({tournament_legal})
        global define STAGE_{new_stage_id}_NE({netplay_legal})
        global define STAGE_{new_stage_id}_TOGGLE({can_toggle})
        global define STAGE_{new_stage_id}_ORDER({order})
        print " - Added Stage 0x"; OS.print_hex({new_stage_id}); print ": ", {display_name}, "\n";

        string_{name}:; String.insert({display_name})

        if {class} == class.BTT {
            btx_words_{name}:
            dw    {btx_word_1}
            dw    {btx_word_2}
            dw    {btx_word_3}
        } else if {class} == class.BTP {
            btx_words_{name}:
            dw    {btx_word_1}
            dw    {btx_word_2}
        }

        pushvar origin, base

        // update class table
        origin class_table_origin + {new_stage_id}
        db     {class}

        // update bonus pointer table
        origin bonus_pointer_table_origin + ({new_stage_id} * 4)
        if {class} == class.BTT {
            dw     btx_words_{name}
        } else if {class} == class.BTP {
            dw     btx_words_{name}
        } else {
            dw     0
        }

        // update string table
        origin string_table_origin + ({new_stage_id} * 4)
        dw     string_{name}

        // update bgm music
        if {bgm} != -1 {
            set_default_music({new_stage_id}, {bgm})
        }

        // update alternate music table
        origin alternate_music_table_origin + ({new_stage_id} * 8)
        dh     {bgm_occasional}
        dh     {bgm_rare}
        dh     {bgm_rare2}

        // update variant table
        if ({variant_for_stage_id} >= 0) {
            origin variant_table_origin + ({variant_for_stage_id} * 8) + (({variant_type} - 1))
            db     {new_stage_id}
        }
        // update item spawn rate table
        set_custom_item_spawn_rate({new_stage_id}, {cloaking_device_rate}, {super_mushroom_rate}, {poison_mushroom_rate}, {blue_shell_rate}, {lightning_rate}, {deku_nut_rate}, {franklin_badge_rate})

        // update series logo table
        origin series_logo_table_origin + {new_stage_id}
        db     CharacterSelect.series_logo.{series_logo}

        // update tournament hazard mode table
        origin tournament_hazard_mode_table_origin + {new_stage_id}
        db     Hazards.mode.{tournament_hazard_mode}

        // update stage hazard table
        origin stage_hazard_table_origin + {new_stage_id}
        db     {hazard_type}
        pullvar base, origin
    }

    // @ Description
    // stage - name of stage (see id scope)
    // x, y, z - x, y, z shift (ex: -10 to shift left/up/back)
    macro add_position_array(stage, x, y, z) {
        evaluate stg_id(id.{stage})

        position_array_{stg_id}:
        float32 {x}
        float32 {y}
        float32 {z}

        pushvar origin, base

        origin POSITION_TABLE_ORIGIN + ({stg_id} * 4)
        dw position_array_{stg_id}

        pullvar base, origin
    }

    // @ Description
    // Helper for adding arrays that define bg sprite behavior.
    // Used inside stage definition files.
    // @ Arguments
    // sprite_id - 0-based index of sprite to use
    // spawn_multiple - if OS.TRUE, there is a chance it will spawn multiple sprites sometimes
    // direction - 1 = enter left, exit right; -1 = enter right, exit left; 0 = random
    // weight - Affects likelihood of this sprite info array being picked at random... chance = weight / sum of all weights
    macro add_sprite_info_array(sprite_id, spawn_multiple, direction, weight) {
        dh {sprite_id}
        dh {spawn_multiple}
        dw {direction}
        db {weight}; db 0x0; db 0x0; db 0x0
    }

    // @ Description
    // Holds info needed to render custom background animations
    scope bg_info {
        scope SMASHVILLE2 {
            include "/stages/smashville.asm"
        }
        scope PCASTLE_DL {
            include "/stages/pcastle_dl.asm"
        }
        scope PCASTLE_O {
            include "/stages/pcastle_o.asm"
        }
        scope CONGOJ_DL {
            include "/stages/congoj_dl.asm"
        }
        scope CONGOJ_O {
            include "/stages/congoj_o.asm"
        }
        scope ZEBES_DL {
            include "/stages/zebes_dl.asm"
        }
        scope ZEBES_O {
            include "/stages/zebes_o.asm"
        }
        scope SECTOR_Z_DL {
            include "/stages/sector_z_dl.asm"
        }
        scope SECTOR_Z_O {
            include "/stages/sector_z_o.asm"
        }
        scope DREAM_LAND_O {
            include "/stages/dream_land_o.asm"
        }
        scope YOSHI_ISLAND_DL {
            include "/stages/yoshi_island_dl.asm"
        }
        scope YOSHI_ISLAND_O {
            include "/stages/yoshi_island_o.asm"
        }
        scope YOSHI_STORY_2 {
            include "/stages/yoshi_story.asm"
        }
        scope JAPES {
            include "/stages/japes.asm"
        }
        scope YOSHIS_ISLAND_II {
            include "/stages/yoshi_island_II.asm"
        }

        scope DREAM_LAND_SR {
            include "/stages/dream_greens.asm"
        }

        scope PCASTLE_BETA {
            include "/stages/pcastle_beta.asm"
        }

        scope CSIEGE {
            include "/stages/csiege.asm"
        }

        scope SECTOR_Z_REMIX {
            include "/stages/sector_z_remix.asm"
        }

        scope GHZ {
            include "/stages/ghz.asm"
        }

        scope WINTER_DL {
            include "/stages/winter_dl.asm"
        }

        scope ZLANDING {
            include "/stages/zlanding.asm"
        }

        scope EDO {
            include "/stages/edo.asm"
        }

        scope SCUTTLE_TOWN {
             include "/stages/scuttletown.asm"
        }

        scope BIG_BOOS_HAUNT {
            include "/stages/bbh.asm"
        }

        scope SPIRALM {
            include "/stages/spiralm.asm"
        }

        scope SMASHVILLE_REMIX {
            include "/stages/smashville_remix.asm"
        }

        // scope LMAO_CASTLE {
            // include "/stages/lmao_castle.asm"
        // }

    }

    // @ Description
    // Adds custom stage background animation to added levels
    // @ Arguments
    // stage - name of stage (see id scope)
    macro add_bg_animation(stage) {
        evaluate stg_id(id.{stage})

        // update our bg_animation_ table to point to a new bg info struct
        pushvar origin, base
        origin bg_animation_.TABLE_ORIGIN + (0x4 * {stg_id})
        dw bg_info_{stg_id}
        pullvar base, origin

        // create custom bg info struct
        bg_info_{stg_id}:
        db bg_info.{stage}.NUM_SPRITE_INFO_ARRAYS; db 0; db 0; db 0
        dw bg_info.{stage}.sprite_info_arrays
        dw bg_info.{stage}.STAGE_FILE_OFFSET
        dw bg_info.{stage}.sprite_data
    }

    // @ Description
    // Sets the background type for a stage
    // @ Arguments
    // stage - name of stage (see id scope)
    // type - background type to use (bg_type.DEFAULT, bg_type.STATIC, bg_type.SECTORZ, bg_type.BONUS3, bg_type.LAST)
    macro set_bg_type(stage, type) {
        evaluate stg_id(id.{stage})

        // update our bg_type table
        pushvar origin, base
        origin bg_type.TABLE_ORIGIN + (0x4 * ({stg_id} - 1))
        dw {type}
        pullvar base, origin
    }

    constant default_item_rate(0x05)
    constant default_lightning_rate(0x5)
    constant default_blue_shell_rate(0x5)

    // Update custom item spawn rates for original stages
    set_custom_item_spawn_rate(id.PEACHS_CASTLE, 0x05, 0x05, 0x05, default_blue_shell_rate + 1, default_lightning_rate + 1, default_item_rate, default_item_rate)
    set_custom_item_spawn_rate(id.SECTOR_Z, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate)
    set_custom_item_spawn_rate(id.CONGO_JUNGLE, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate)
    set_custom_item_spawn_rate(id.PLANET_ZEBES, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate)
    set_custom_item_spawn_rate(id.HYRULE_CASTLE, 0x05, 0x05, 0x05, default_blue_shell_rate + 1, default_lightning_rate + 1, default_item_rate + 2, default_item_rate)
    set_custom_item_spawn_rate(id.YOSHIS_ISLAND, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate)
    set_custom_item_spawn_rate(id.DREAM_LAND, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate)
    set_custom_item_spawn_rate(id.SAFFRON_CITY, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate)
    set_custom_item_spawn_rate(id.MUSHROOM_KINGDOM, 0x05, 0x05, 0x05, default_blue_shell_rate + 1, default_lightning_rate + 1, default_item_rate, default_item_rate)
    set_custom_item_spawn_rate(id.DREAM_LAND_BETA_1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate)
    set_custom_item_spawn_rate(id.DREAM_LAND_BETA_2, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate)
    set_custom_item_spawn_rate(id.HOW_TO_PLAY, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate)
    set_custom_item_spawn_rate(id.MINI_YOSHIS_ISLAND, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate)
    set_custom_item_spawn_rate(id.META_CRYSTAL, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate)
    set_custom_item_spawn_rate(id.DUEL_ZONE, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate)
    set_custom_item_spawn_rate(id.FINAL_DESTINATION, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate)

    map 0x7E, 0x7F, 1 // temporarily make ~ be Omega

    // Add stages here
    // add_stage(name, display_name, bgm_default, bgm_occasional, bgm_rare, tournament_legal, tournament_hazard_mode, netplay_legal, can_toggle, class, btx_word_1, btx_word_2, btx_word_3, variant_for_stage_id, variant_type, cloaking_device_rate, super_mushroom_rate, poison_mushroom_rate, blue_shell_rate, lightning_rate, deku_nut_rate, franklin_badge_rate, series_logo, hazard_type
    add_stage(deku_tree, "Deku Tree", {MIDI.id.KOKIRI_FOREST}, {MIDI.id.BRAWL_OOT}, {MIDI.id.SARIA}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, 0x03, 0x02, default_item_rate + 2, default_item_rate, ZELDA, Hazards.type.NONE, 63)
    set_custom_item_spawn_rate(DEKU_TREE, DekuNut, 0x12)
    add_stage(first_destination, "First Destination",  {MIDI.id.FIRST_DESTINATION}, {MIDI.id.MULTIMAN2}, {MIDI.id.CREDITS_BRAWL}, -1, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  SMASH, Hazards.type.NONE, 80)
    add_stage(ganons_tower, "Ganon's Tower", {MIDI.id.GANONDORF_BATTLE}, {MIDI.id.MAJORA_MIDBOSS}, {MIDI.id.GANONMEDLEY}, {MIDI.id.DEATH_MOUNTAIN}, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, 0x03, 0x02, default_item_rate + 2, default_item_rate, ZELDA, Hazards.type.NONE, 90)
    add_stage(gym_leader_castle, "Gym Leader Castle", {MIDI.id.RBY_GYMLEADER}, {MIDI.id.POKEMON_CHAMPION}, {MIDI.id.POKEMON_STADIUM}, -1, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  POKEMON, Hazards.type.NONE, 98)
    add_stage(pokemon_stadium, "Pokemon Stadium", {MIDI.id.POKEMON_STADIUM}, {MIDI.id.POKEMON_CHAMPION}, {MIDI.id.POKEFLOATS}, -1, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  POKEMON, Hazards.type.NONE, 137)
    add_stage(taltal, "Tal Tal Heights", {MIDI.id.LINKS_AWAKENING_MEDLEY}, {MIDI.id.BRAWL_OOT}, {MIDI.id.GERUDO_VALLEY}, -1, OS.TRUE, HAZARDS_OFF_MOVEMENT_OFF, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, 0x03, 0x02, default_item_rate + 2, default_item_rate, ZELDA, Hazards.type.HAZARDS, 159)
    add_stage(glacial, "Glacial River", {MIDI.id.GLACIAL}, {MIDI.id.CLOCKTOWER}, {MIDI.id.ROLL}, {MIDI.id.MORRIGAN}, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  MVC, Hazards.type.NONE, 92)
    add_stage(warioware, "WarioWare, Inc.", {MIDI.id.WARIOWARE}, {MIDI.id.ASHLEYS_THEME}, {MIDI.id.MONKEY_WATCH}, -1, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  WARIO, Hazards.type.NONE, 167)
    add_stage(battlefield, "Battlefield", {MIDI.id.BATTLEFIELD}, {MIDI.id.BATTLEFIELDV2}, {MIDI.id.MULTIMAN}, -1, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  SMASH, Hazards.type.NONE, 2)
    add_stage(flat_zone, "Flat Zone", {MIDI.id.FLAT_ZONE}, {MIDI.id.FLAT_ZONE_2}, -1, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  GAME_AND_WATCH, Hazards.type.HAZARDS, 82)
    set_bg_type(FLAT_ZONE, bg_type.BONUS3)
    add_stage(dr_mario, "Dr. Mario", {MIDI.id.DR_MARIO}, {MIDI.id.CHILL}, {MIDI.id.QUEQUE}, {MIDI.id.LIPS_THEME}, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  DR_MARIO, Hazards.type.NONE, 69)
    add_stage(cool_cool_mountain, "Cool Cool Mountain", {MIDI.id.COOLCOOLMOUNTAIN}, {MIDI.id.FRAPPE_SNOWLAND}, {MIDI.id.FREEZE}, {MIDI.id.SHERBETLAND}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate + 1, default_lightning_rate + 1, default_item_rate, default_item_rate,  MARIO_BROS, Hazards.type.NONE, 56)
    add_stage(dragon_king, "Dragon King", {MIDI.id.DRAGONKING}, {MIDI.id.TARGET_TEST}, -1, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  SMASH, Hazards.type.NONE, 71)
    set_bg_type(DRAGONKING, bg_type.SECTORZ)
    add_stage(great_bay, "Great Bay", {MIDI.id.SARIA}, {MIDI.id.CLOCKTOWN}, {MIDI.id.ASTRAL_OBSERVATORY}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, 0x03, 0x02, default_item_rate + 2, default_item_rate, ZELDA, Hazards.type.MOVEMENT, 95)
    add_stage(frays_stage, "Fray's Stage", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TRAVELING}, -1, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  REMIX, Hazards.type.NONE, 85)
    add_stage(toh, "Tower of Heaven", {MIDI.id.TOWEROFHEAVEN}, {MIDI.id.PLANTATION}, {MIDI.id.FLANDRES_THEME}, {MIDI.id.STRIKE_THE_EARTH}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  TOH, Hazards.type.NONE, 164)
    add_stage(fod, "Fountain of Dreams", {MIDI.id.FOD}, {MIDI.id.NIGHTMARE}, {MIDI.id.VS_MARX}, {MIDI.id.NUTTY_NOON}, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  KIRBY, Hazards.type.MOVEMENT, 84)
    add_stage(muda, "Muda Kingdom", {MIDI.id.MUDA}, {MIDI.id.GB_MEDLEY}, {MIDI.id.EASTON_KINGDOM}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, id.GB_LAND, variant_type.REMIX, 0x05, 0x05, 0x05, default_blue_shell_rate + 1, default_lightning_rate + 1, default_item_rate, default_item_rate,  MARIO_BROS, Hazards.type.NONE, 114)
    add_stage(mementos, "Mementos", {MIDI.id.MEMENTOS}, {MIDI.id.THE_DAYS_WHEN_MY_MOTHER_WAS_THERE}, {MIDI.id.BATTLE_C1}, -1, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, id.REAPERS, variant_type.REMIX, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  PERSONA, Hazards.type.MOVEMENT, 109)
    add_stage(showdown, "Showdown", {MIDI.id.FD_BRAWL}, {MIDI.id.TABUU}, {MIDI.id.FUGUE}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.FIRST_DESTINATION, variant_type.REMIX2, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  SMASH, Hazards.type.NONE, 150)
    add_stage(spiralm, "Spiral Mountain", {MIDI.id.SPIRAL_MOUNTAIN}, {MIDI.id.BANJO_MAIN}, {MIDI.id.BK_FINALBATTLE}, {MIDI.id.TREASURE_TROVE_COVE}, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  BANJO_KAZOOIE, Hazards.type.MOVEMENT, 157)
    add_bg_animation(SPIRALM)
    add_stage(n64, "N64", {MIDI.id.N64}, {MIDI.id.TALENTSTUDIO}, {MIDI.id.REDIAL}, {MIDI.id.BLUE_RESORT}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  REMIX, Hazards.type.NONE, 121)
    set_bg_type(N64, bg_type.SECTORZ)
    add_stage(mute_dl, "Mute City DL", {MIDI.id.MUTE_CITY}, {MIDI.id.FZERO_MEDLEY}, {MIDI.id.MACHRIDER}, -1, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, id.MUTE, variant_type.DL, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  FZERO, Hazards.type.NONE, 119)
    add_stage(madmm, "Mad Monster Mansion", {MIDI.id.MADMONSTER}, {MIDI.id.MRPATCH}, {MIDI.id.VS_KLUNGO}, {MIDI.id.OLDKINGCOAL}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  BANJO_KAZOOIE, Hazards.type.NONE, 107)
    add_stage(smbbf, "Mushroom Kingdom DL", -1, {MIDI.id.UNDERGROUND}, {MIDI.id.NSMB}, -1, OS.TRUE, HAZARDS_OFF_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.MUSHROOM_KINGDOM, variant_type.DL, 0x05, 0x05, 0x05, default_blue_shell_rate + 1, default_lightning_rate + 1, default_item_rate, default_item_rate,  MARIO_BROS, Hazards.type.HAZARDS, 116)
    add_stage(smbo, "Mushroom Kingdom ~", -1, {MIDI.id.UNDERGROUND}, {MIDI.id.NSMB}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.MUSHROOM_KINGDOM, variant_type.OMEGA, 0x05, 0x05, 0x05, default_blue_shell_rate + 1, default_lightning_rate + 1, default_item_rate, default_item_rate,  MARIO_BROS, Hazards.type.HAZARDS, 115)
    add_stage(bowserb, "Bowser's Stadium", {MIDI.id.BOWSERBOSS}, {MIDI.id.BOWSERROAD}, {MIDI.id.BOWSERFINAL}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  BOWSER, Hazards.type.HAZARDS, 29)
    add_stage(peach2, "Peach's Castle II", {MIDI.id.PEACH_CASTLE}, {MIDI.id.SLIDER}, {MIDI.id.SMB3OVERWORLD}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate + 1, default_lightning_rate + 1, default_item_rate, default_item_rate,  MARIO_BROS, Hazards.type.MOVEMENT, 130)
    add_stage(delfino, "Delfino Plaza", {MIDI.id.DELFINO}, {MIDI.id.SMS_BOSS}, {MIDI.id.SMW_TITLECREDITS}, -1, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate + 1, default_lightning_rate + 1, default_item_rate, default_item_rate,  MARIO_BROS, Hazards.type.MOVEMENT, 65)
    add_stage(corneria2, "Corneria", {MIDI.id.STARFOX_MEDLEY}, {MIDI.id.AREA6}, {MIDI.id.CORNERIA}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, id.SECTOR_Z, variant_type.REMIX2, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  STARFOX, Hazards.type.HAZARDS, 59)
    add_stage(kitchen, "Kitchen Island", {MIDI.id.KITCHEN_ISLAND}, {MIDI.id.WL2_PERFECT}, {MIDI.id.STARRING_WARIO}, {MIDI.id.STONECARVING_CITY}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  WARIO, Hazards.type.MOVEMENT, 105)
    add_position_array(KITCHEN, 0, -832, 0)
    add_stage(blue, "Big Blue", {MIDI.id.BIG_BLUE}, {MIDI.id.FZEROX_MEDLEY}, {MIDI.id.FZERO_CLIMBUP}, {MIDI.id.MACHRIDER}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  FZERO, Hazards.type.BOTH, 4)
    add_stage(onett, "Onett", {MIDI.id.ONETT}, {MIDI.id.BEIN_FRIENDS}, {MIDI.id.POLLYANNA}, {MIDI.id.FOURSIDE}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate + 2,  EARTHBOUND, Hazards.type.HAZARDS, 126)
    set_custom_item_spawn_rate(ONETT, MrSaturn, 0x14)
    set_custom_item_spawn_rate(ONETT, FranklinBadge, 0x10)
    add_stage(zlanding, "Crateria", {MIDI.id.CRATERIA_MAIN}, {MIDI.id.ZEBES_LANDING}, {MIDI.id.NORFAIR}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  METROID, Hazards.type.MOVEMENT, 60)
    add_bg_animation(ZLANDING)
    add_stage(frosty, "Frosty Village", {MIDI.id.FROSTY_VILLAGE}, {MIDI.id.DKR_BOSS}, {MIDI.id.CRESCENT_ISLAND}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  DONKEY_KONG, Hazards.type.NONE, 87)
    set_bg_type(FROSTY, bg_type.SECTORZ)
    add_stage(smashville2, "Smashville", {MIDI.id.AC_TITLE}, {MIDI.id.KK_RIDER}, {MIDI.id.SMASHVILLE}, {MIDI.id.BALLOONFIGHT}, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  ANIMAL_CROSSING, Hazards.type.MOVEMENT, 152)
    set_custom_item_spawn_rate(SMASHVILLE2, Pitfall, 0x14)
    add_bg_animation(SMASHVILLE2)
    add_stage(drm_btt, "Break the Targets", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTT, 0x000056A8, 0x00005B10, 0x00005D20, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 50)
    add_stage(gnd_btt, "Break the Targets", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTT, 0x00004178, 0x000045F0, 0x00004800, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 38)
    add_stage(yl_btt, "Break the Targets", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTT, 0x00002A18, 0x00002CE0, 0x00002EF0, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 32)
    add_stage(battlefield_dl, "Battlefield DL", {MIDI.id.BATTLEFIELD}, {MIDI.id.BATTLEFIELDV2}, {MIDI.id.MULTIMAN}, -1, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.BATTLEFIELD, variant_type.DL, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  SMASH, Hazards.type.NONE, 3)
    add_stage(ds_btt, "Break the Targets", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTT, 0x00003160, 0x000036D0, 0x000038E0, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 30)
    add_stage(stg1_btt, "Break the Targets", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTT, 0x00006588, 0x00006A40, 0x00006C50, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 31)
    add_stage(falco_btt, "Break the Targets", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTT, 0x000036C0, 0x00003BB0, 0x00003DC0, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 36)
    add_stage(wario_btt, "Break the Targets", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTT, 0x00002948, 0x00002CA0, 0x00002EB0, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 37)
    add_stage(htemple, "Hyrule Temple", {MIDI.id.HYRULE_TEMPLE}, {MIDI.id.FINALTEMPLE}, {MIDI.id.DARKWORLD}, {MIDI.id.SKYWORLD}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, 0x03, 0x02, default_item_rate + 2, default_item_rate, ZELDA, Hazards.type.NONE, 103)
    add_stage(lucas_btt, "Break the Targets", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTT, 0x000032D8, 0x00003650, 0x00003860, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 35)
    add_stage(gnd_btp, "Board the Platforms", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTP, 0x00003C70, 0x00003DA8, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 16)
    add_stage(npc, "New Pork City", {MIDI.id.PORKY_MEDLEY}, {MIDI.id.UNFOUNDED_REVENGE}, {MIDI.id.PORKY}, -1, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate + 2,  EARTHBOUND, Hazards.type.NONE, 123)
    set_custom_item_spawn_rate(NPC, MrSaturn, 0x14)
    set_custom_item_spawn_rate(NPC, FranklinBadge, 0x10)
    add_stage(ds_btp, "Board the Platforms", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTP, 0x00003F10, 0x00003FC0, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 15)
    add_stage(smashketball, "Smashketball", {MIDI.id.NBA_JAM}, {MIDI.id.KENGJR}, {MIDI.id.SOCCER_MENU}, {MIDI.id.SHERBETLAND}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NBA_JAM, Hazards.type.HAZARDS, 151)
    add_stage(drm_btp, "Board the Platforms", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTP, 0x00004E08, 0x00004EC0, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 9)
    add_stage(norfair, "Norfair", {MIDI.id.NORFAIR}, {MIDI.id.VSRIDLEY}, {MIDI.id.VS_DSAMUS}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  METROID, Hazards.type.HAZARDS, 124)
    add_stage(raidblue, "Raid Blue", {MIDI.id.RAIDBLUE}, {MIDI.id.RISKNECK}, {MIDI.id.AGAVE}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  SNP, Hazards.type.NONE, 139)
    add_stage(falls, "Congo Falls", {MIDI.id.DK_RAP}, {MIDI.id.STICKERBRUSH_SYMPHONY}, {MIDI.id.GANGPLANK}, {MIDI.id.ORANGSPRINT}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  DONKEY_KONG, Hazards.type.HAZARDS, 53)
    add_stage(osohe, "Pigmask Fortress", {MIDI.id.MURASAKI}, {MIDI.id.EVEN_DRIER_GUYS}, {MIDI.id.SAMBA_DE_COMBO}, {MIDI.id.UNFOUNDED_REVENGE}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate + 2,  EARTHBOUND, Hazards.type.NONE, 131)
    set_custom_item_spawn_rate(OSOHE, MrSaturn, 0x12)
    set_custom_item_spawn_rate(OSOHE, FranklinBadge, 0x10)
    add_stage(yoshi_story_2, "Yoshi's Story", {MIDI.id.YOSHI_TALE}, {MIDI.id.OBSTACLE}, {MIDI.id.BABY_BOWSER}, -1, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  YOSHI, Hazards.type.MOVEMENT, 174)
    set_bg_type(YOSHI_STORY_2, bg_type.STATIC)
    add_bg_animation(YOSHI_STORY_2)
    add_stage(world1, "World 1-1", -1, {MIDI.id.UNDERGROUND}, {MIDI.id.NSMB}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.MUSHROOM_KINGDOM, variant_type.REMIX2, 0x05, 0x05, 0x05, default_blue_shell_rate + 1, default_lightning_rate + 1, default_item_rate, default_item_rate,  MARIO_BROS, Hazards.type.MOVEMENT, 170)
    add_stage(flat_zone_2, "Flat Zone II", {MIDI.id.FLAT_ZONE_2}, {MIDI.id.FLAT_ZONE}, -1, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.FLAT_ZONE, variant_type.REMIX, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  GAME_AND_WATCH, Hazards.type.BOTH, 83)
    set_bg_type(FLAT_ZONE_2, bg_type.BONUS3)
    add_stage(gerudo, "Gerudo Valley", {MIDI.id.GERUDO_VALLEY}, {MIDI.id.BRAWL_OOT}, -1, -1, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, 0x03, 0x02, default_item_rate + 2, default_item_rate, ZELDA, Hazards.type.NONE, 91)
    add_stage(yl_btp, "Board the Platforms", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTP, 0x00004120, 0x00004258, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 17)
    add_stage(falco_btp, "Board the Platforms", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTP, 0x00004830, 0x00004968, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 21)
    add_stage(poly_btp, "Board the Platforms", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTP, 0x000047E0, 0x00004890, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 18)
    add_stage(hcastle_dl, "Hyrule Castle DL", -1, {MIDI.id.FINALTEMPLE}, {MIDI.id.GODDESSBALLAD}, {MIDI.id.DEATH_MOUNTAIN}, OS.TRUE, HAZARDS_OFF_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.HYRULE_CASTLE, variant_type.DL, 0x05, 0x05, 0x05, 0x03, 0x02, default_item_rate + 2, default_item_rate, ZELDA, Hazards.type.HAZARDS, 101)
    add_stage(hcastle_o, "Hyrule Castle ~", -1, {MIDI.id.FINALTEMPLE}, {MIDI.id.GODDESSBALLAD}, {MIDI.id.DEATH_MOUNTAIN}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.HYRULE_CASTLE, variant_type.OMEGA, 0x05, 0x05, 0x05, 0x03, 0x02, default_item_rate + 2, default_item_rate, ZELDA, Hazards.type.HAZARDS, 100)
    add_stage(congoj_dl, "Congo Jungle DL", -1, {MIDI.id.SKERRIES}, {MIDI.id.SNAKEY_CHANTEY}, {MIDI.id.DK_MEDLEY}, OS.TRUE, HAZARDS_OFF_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.CONGO_JUNGLE, variant_type.DL, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  DONKEY_KONG, Hazards.type.HAZARDS, 55)
    add_bg_animation(CONGOJ_DL)
    add_stage(congoj_o, "Congo Jungle ~", -1, {MIDI.id.SKERRIES}, {MIDI.id.SNAKEY_CHANTEY}, {MIDI.id.DK_MEDLEY}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.CONGO_JUNGLE, variant_type.OMEGA, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  DONKEY_KONG, Hazards.type.HAZARDS, 54)
    add_bg_animation(CONGOJ_O)
    add_stage(pcastle_dl, "Peach's Castle DL", -1, {MIDI.id.BOB}, {MIDI.id.SLIDER}, {MIDI.id.WING_CAP}, OS.TRUE, HAZARDS_OFF_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.PEACHS_CASTLE, variant_type.DL, 0x05, 0x05, 0x05, default_blue_shell_rate + 1, default_lightning_rate + 1, default_item_rate, default_item_rate,  MARIO_BROS, Hazards.type.HAZARDS, 129)
    add_bg_animation(PCASTLE_DL)
    add_stage(pcastle_o, "Peach's Castle ~", -1, {MIDI.id.BOB}, {MIDI.id.SLIDER}, {MIDI.id.WING_CAP}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.PEACHS_CASTLE, variant_type.OMEGA, 0x05, 0x05, 0x05, default_blue_shell_rate + 1, default_lightning_rate + 1, default_item_rate, default_item_rate,  MARIO_BROS, Hazards.type.HAZARDS, 127)
    add_bg_animation(PCASTLE_O)
    add_stage(wario_btp, "Board the Platforms", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTP, 0x00003C70, 0x00003DA8, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 26)
    add_stage(frays_stage_night, "Fray's Stage - Night", {MIDI.id.ASTRAL_OBSERVATORY}, {MIDI.id.TOADS_TURNPIKE}, {MIDI.id.CORRIDORS_OF_TIME}, -1, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, id.FRAYS_STAGE, variant_type.DL, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  REMIX, Hazards.type.NONE, 86)
    add_stage(goomba_road, "Goomba Road", {MIDI.id.PAPER_MARIO_BATTLE}, {MIDI.id.KOOPA_BROS}, {MIDI.id.SMRPG_BATTLE}, {MIDI.id.BEWARE_THE_FORESTS_MUSHROOMS}, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate + 1, default_lightning_rate + 1, default_item_rate, default_item_rate,  MARIO_BROS, Hazards.type.NONE, 94)
    add_stage(lucas_btp2, "Board the Platforms", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTP, 0x00004C50, 0x00004D88, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 27)
    add_stage(sector_z_dl, "Sector Z DL", -1, {MIDI.id.SURPRISE_ATTACK}, {MIDI.id.CORNERIA}, {MIDI.id.TITANIA}, OS.TRUE, HAZARDS_OFF_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.SECTOR_Z, variant_type.DL, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  STARFOX, Hazards.type.HAZARDS, 148)
    add_bg_animation(SECTOR_Z_DL)
    add_position_array(SECTOR_Z_DL, 0, -832, 0)
    set_bg_type(SECTOR_Z_DL, bg_type.SECTORZ)
    add_stage(saffron_dl, "Saffron City DL", -1, {MIDI.id.GAME_CORNER}, {MIDI.id.COBALT}, {MIDI.id.GOLDENROD_CITY}, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, id.SAFFRON_CITY, variant_type.DL, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  POKEMON, Hazards.type.MOVEMENT, 145)
    add_stage(yoshi_island_dl, "Yoshi's Island DL", -1, {MIDI.id.OBSTACLE}, {MIDI.id.YOSHI_SKA}, -1, OS.TRUE, HAZARDS_OFF_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, id.YOSHIS_ISLAND, variant_type.DL, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  YOSHI, Hazards.type.HAZARDS, 172)
    add_bg_animation(YOSHI_ISLAND_DL)
    set_bg_type(YOSHI_ISLAND_DL, bg_type.STATIC)
    add_stage(zebes_dl, "Planet Zebes DL", -1, {MIDI.id.NORFAIR}, {MIDI.id.ZEBES_LANDING}, -1, OS.TRUE, HAZARDS_OFF_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.PLANET_ZEBES, variant_type.DL, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  METROID, Hazards.type.HAZARDS, 135)
    add_bg_animation(ZEBES_DL)
    add_stage(sector_z_o, "Sector Z ~", -1, {MIDI.id.SURPRISE_ATTACK}, {MIDI.id.CORNERIA}, {MIDI.id.TITANIA}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.SECTOR_Z, variant_type.OMEGA, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  STARFOX, Hazards.type.HAZARDS, 147)
    add_bg_animation(SECTOR_Z_O)
    add_position_array(SECTOR_Z_O, 0, -832, 0)
    set_bg_type(SECTOR_Z_O, bg_type.SECTORZ)
    add_stage(saffron_o, "Saffron City ~", -1, {MIDI.id.GAME_CORNER}, {MIDI.id.COBALT}, {MIDI.id.GOLDENROD_CITY}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.SAFFRON_CITY, variant_type.OMEGA, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  POKEMON, Hazards.type.NONE, 144)
    add_stage(yoshi_island_o, "Yoshi's Island ~", -1, {MIDI.id.OBSTACLE}, {MIDI.id.YOSHI_SKA}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.YOSHIS_ISLAND, variant_type.OMEGA, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  YOSHI, Hazards.type.HAZARDS, 171)
    add_bg_animation(YOSHI_ISLAND_O)
    set_bg_type(YOSHI_ISLAND_O, bg_type.STATIC)
    add_stage(dream_land_o, "Dream Land ~", -1, {MIDI.id.POP_STAR}, {MIDI.id.BUTTER_BUILDING}, {MIDI.id.NUTTY_NOON}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.DREAM_LAND, variant_type.OMEGA, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  KIRBY, Hazards.type.HAZARDS, 74)
    add_bg_animation(DREAM_LAND_O)
    add_stage(zebes_O, "Planet Zebes ~", -1, {MIDI.id.NORFAIR}, {MIDI.id.ZEBES_LANDING}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.PLANET_ZEBES, variant_type.OMEGA, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  METROID, Hazards.type.HAZARDS, 134)
    add_bg_animation(ZEBES_O)
    add_stage(bowser_btt, "Break the Targets", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTT, 0x00004040, 0x000043F0, 0x00004600, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 33)
    add_stage(bowser_btp, "Board the Platforms", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTP, 0x00003260, 0x00003398, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 24)
    add_stage(bowsers_keep, "Bowser's Keep", {MIDI.id.FIGHT_AGAINST_BOWSER}, {MIDI.id.KING_OF_THE_KOOPAS}, {MIDI.id.BIS_THEGRANDFINALE}, {MIDI.id.FF4BOSS}, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  BOWSER, Hazards.type.MOVEMENT, 28)
    add_stage(rith_essa, "Rith Essa", {MIDI.id.RITH_ESSA}, {MIDI.id.JFG_SELECT}, {MIDI.id.MARATHON}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  JET_FORCE_GEMINI, Hazards.type.NONE, 143)
    add_stage(venom, "Venom", {MIDI.id.VENOM}, {MIDI.id.STAR_WOLF}, {MIDI.id.BOSS_E}, {MIDI.id.ELADARD}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  STARFOX, Hazards.type.HAZARDS, 166)
    add_stage(wolf_btt, "Break the Targets", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTT, 0x00003238, 0x000037A0, 0x000039B0, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 48)
    add_stage(wolf_btp, "Board the Platforms", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTP, 0x00006540, 0x00006728, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 8)
    add_stage(conker_btt, "Break the Targets", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTT, 0x00005778, 0x00005CD0, 0x00005EE0, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 34)
    add_stage(conker_btp, "Board the Platforms", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTP, 0x000075C0, 0x000077A8, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 12)
    add_stage(windy, "Windy", {MIDI.id.WINDY}, {MIDI.id.OLE}, {MIDI.id.SLOPRANO}, {MIDI.id.ROCKSOLID}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  CONKER, Hazards.type.MOVEMENT, 168)
    add_stage(data, "dataDyne Central", {MIDI.id.DATADYNE}, {MIDI.id.INVESTIGATION_X}, {MIDI.id.CRADLE}, {MIDI.id.CONTROL}, OS.TRUE, HAZARDS_ON_MOVEMENT_OFF, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x35, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  PERFECT_DARK, Hazards.type.MOVEMENT, 62)
    set_custom_item_spawn_rate(DATA, GoldenGun, 0x12)
    add_stage(clancer, "Planet Clancer", {MIDI.id.TROUBLE_MAKER}, {MIDI.id.MM_TITLE}, {MIDI.id.ESPERANCE}, -1, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  MISCHIEF_MAKERS, Hazards.type.MOVEMENT, 133)
    add_stage(japes, "Jungle Japes", {MIDI.id.JUNGLEJAPES}, {MIDI.id.FOREST_INTERLUDE}, {MIDI.id.DKCTITLE}, {MIDI.id.MADMAZEMAUL}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  DONKEY_KONG, Hazards.type.HAZARDS, 104)
    add_bg_animation(JAPES)
    add_stage(marth_btt, "Break the Targets", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTT, 0x00002E78, 0x000031F0, 0x00003400, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 47)
    add_stage(gb_land, "Game Boy Land", {MIDI.id.GB_MEDLEY}, {MIDI.id.MUDA}, {MIDI.id.MUDA}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  REMIX, Hazards.type.BOTH, 89)
    set_bg_type(GB_LAND, bg_type.BONUS3)
    add_stage(mtwo_btt, "Break the Targets", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTT, 0x00004800, 0x00004B50, 0x00004D60, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 49)
    add_stage(marth_btp, "Board the Platforms", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTP, 0x000045E0, 0x000047C8, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 13)
    add_stage(rest, "Allstar Rest Area", {MIDI.id.REST}, -1, -1, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 1)
    add_stage(mtwo_btp, "Board the Platforms", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTP, 0x000059F0, 0x00005BD8, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 14)
    add_stage(csiege, "Castle Siege", {MIDI.id.FE_MEDLEY}, {MIDI.id.FIRE_EMBLEM}, {MIDI.id.WITHMILASDIVINEPROTECTION}, {MIDI.id.FE6_MEDLEY}, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  FIRE_EMBLEM, Hazards.type.NONE, 52)
    add_bg_animation(CSIEGE)
    add_stage(yoshis_island_II, "Yoshi's Island II", -1, {MIDI.id.WILDLANDS}, {MIDI.id.YOSHI_GOLF}, {MIDI.id.OBSTACLE}, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  YOSHI, Hazards.type.MOVEMENT, 173)
    set_bg_type(YOSHIS_ISLAND_II, bg_type.STATIC)
    add_bg_animation(YOSHIS_ISLAND_II)
    add_stage(final_destination_dl, "Final Destination DL", -1, {MIDI.id.FIRST_DESTINATION}, {MIDI.id.FD_BRAWL}, -1, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.FINAL_DESTINATION, variant_type.DL, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  SMASH, Hazards.type.NONE, 78)
    add_stage(final_destination_tent, "Final Tentination", -1, {MIDI.id.FIRST_DESTINATION}, {MIDI.id.FD_BRAWL}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.FINAL_DESTINATION, variant_type.REMIX, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  SMASH, Hazards.type.NONE, 79)
    add_stage(coolcool_remix, "Cool Cool Mountain SR", {MIDI.id.COOLCOOLMOUNTAIN}, {MIDI.id.FRAPPE_SNOWLAND}, {MIDI.id.FREEZE}, {MIDI.id.SHERBETLAND}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, id.COOLCOOL, variant_type.REMIX, 0x05, 0x05, 0x05, default_blue_shell_rate + 1, default_lightning_rate + 1, default_item_rate, default_item_rate,  MARIO_BROS, Hazards.type.NONE, 58)
    add_stage(duel_zone_dl, "Duel Zone DL", -1, {MIDI.id.MULTIMAN}, {MIDI.id.TABUU}, -1, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.DUEL_ZONE, variant_type.DL, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  SMASH, Hazards.type.NONE, 76)
    add_stage(coolcool_dl, "Cool Cool Mountain DL", {MIDI.id.COOLCOOLMOUNTAIN}, {MIDI.id.FRAPPE_SNOWLAND}, {MIDI.id.FREEZE}, {MIDI.id.SHERBETLAND}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, id.COOLCOOL, variant_type.DL, 0x05, 0x05, 0x05, default_blue_shell_rate + 1, default_lightning_rate + 1, default_item_rate, default_item_rate,  MARIO_BROS, Hazards.type.NONE, 57)
    add_stage(meta_crystal_dl, "Meta Crystal DL", -1, {MIDI.id.METAL_BATTLE}, {MIDI.id.EASTON_KINGDOM}, -1, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.META_CRYSTAL, variant_type.DL, 0x05, 0x05, 0x05, default_blue_shell_rate + 1, default_lightning_rate + 1, default_item_rate, default_item_rate,  MARIO_BROS, Hazards.type.NONE, 110)
    add_stage(dream_land_sr, "Dream Greens", {MIDI.id.GREEN_GREENS}, {MIDI.id.KIRBY_64_BOSS}, {MIDI.id.POP_STAR},{MIDI.id.BATTLE_AMONG_FRIENDS}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.DREAM_LAND, variant_type.REMIX, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  KIRBY, Hazards.type.HAZARDS, 73)
    add_bg_animation(DREAM_LAND_SR)
    add_stage(pcastle_beta, "Peach's Castle Beta", -1, {MIDI.id.BOB}, {MIDI.id.SLIDER}, {MIDI.id.WING_CAP}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.PEACHS_CASTLE, variant_type.REMIX, 0x05, 0x05, 0x05, default_blue_shell_rate + 1, default_lightning_rate + 1, default_item_rate, default_item_rate,  MARIO_BROS, Hazards.type.BOTH, 128)
    add_bg_animation(PCASTLE_BETA)
    add_stage(hcastle_remix, "Hyrule Castle SR", -1, {MIDI.id.FINALTEMPLE}, {MIDI.id.GODDESSBALLAD}, {MIDI.id.DEATH_MOUNTAIN}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.HYRULE_CASTLE, variant_type.REMIX, 0x05, 0x05, 0x05, 0x03, 0x02, default_item_rate + 2, default_item_rate, ZELDA, Hazards.type.HAZARDS, 102)
    add_stage(sector_z_remix, "Sector Z SR", -1, {MIDI.id.SURPRISE_ATTACK}, {MIDI.id.CORNERIA}, {MIDI.id.TITANIA}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.SECTOR_Z, variant_type.REMIX, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  STARFOX, Hazards.type.HAZARDS, 149)
    add_bg_animation(SECTOR_Z_REMIX)
    add_position_array(SECTOR_Z_REMIX, -3328, 0, 2048)
    set_bg_type(SECTOR_Z_REMIX, bg_type.SECTORZ)
    add_stage(mute, "Mute City", {MIDI.id.MUTE_CITY}, {MIDI.id.FZERO_MEDLEY}, {MIDI.id.MACHRIDER}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  FZERO, Hazards.type.BOTH, 118)
    add_stage(hrc, "Home Run Contest", {MIDI.id.TARGET_TEST}, -1, -1, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.RTTF, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  REMIX, Hazards.type.NONE, 99)
    add_stage(mk_remix, "Mushroom Kingdom SR", -1, {MIDI.id.UNDERGROUND}, {MIDI.id.NSMB}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, id.MUSHROOM_KINGDOM, variant_type.REMIX, 0x05, 0x05, 0x05, default_blue_shell_rate + 1, default_lightning_rate + 1, default_item_rate, default_item_rate,  MARIO_BROS, Hazards.type.HAZARDS, 117)
    add_stage(ghz, "Green Hill Zone", {MIDI.id.GREEN_HILL_ZONE}, {MIDI.id.EMERALDHILL}, {MIDI.id.CHEMICAL_PLANT}, {MIDI.id.LIVE_AND_LEARN}, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  SONIC, Hazards.type.MOVEMENT, 96)
    add_bg_animation(GHZ)
    add_stage(subcon, "Subcon", {MIDI.id.SMB2OVERWORLD}, {MIDI.id.SMB2_MEDLEY}, {MIDI.id.SMB2_MEDLEY}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate + 1, default_lightning_rate + 1, default_item_rate, default_item_rate,  MARIO_BROS, Hazards.type.MOVEMENT, 158)
    add_stage(pirate, "Pirate Land", {MIDI.id.PIRATELAND}, {MIDI.id.TROPICALISLAND}, {MIDI.id.WIDE_UNDERWATER}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate + 1, default_lightning_rate + 1, default_item_rate, default_item_rate,  MARIO_BROS, Hazards.type.HAZARDS, 132)
    add_stage(casino, "Casino Night Zone", {MIDI.id.CASINO_NIGHT}, {MIDI.id.SONIC2_BOSS}, {MIDI.id.GIANTWING}, {MIDI.id.OPEN_YOUR_HEART}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  SONIC, Hazards.type.HAZARDS, 51)
    add_stage(sonic_btt, "Break the Targets", -1, {MIDI.id.SONICCD_SPECIAL}, {MIDI.id.SONIC2_SPECIAL}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTT, 0x00005C40, 0x00006260, 0x00006470, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 41)
    add_stage(sonic_btp, "Board the Platforms", -1, {MIDI.id.SONICCD_SPECIAL}, {MIDI.id.SONIC2_SPECIAL}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTP, 0x00006920, 0x00006B08, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 11)
    add_stage(mmadness, "Metallic Madness", {MIDI.id.METALLIC_MADNESS}, {MIDI.id.STARDUST}, {MIDI.id.FLYINGBATTERY}, {MIDI.id.EVERYTHING}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  SONIC, Hazards.type.BOTH, 112)
    add_stage(rainbowroad, "Rainbow Road", {MIDI.id.RAINBOWROAD}, {MIDI.id.MK64_CREDITS}, {MIDI.id.SNES_RAINBOW}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate + 1, default_lightning_rate + 1, default_item_rate, default_item_rate,  MARIO_BROS, Hazards.type.BOTH, 140)
    add_stage(pokemon_stadium_2, "Pokemon Stadium 2", {MIDI.id.BATTLE_GOLD_SILVER}, {MIDI.id.KANTO_WILD_BATTLE}, {MIDI.id.SS_AQUA}, -1, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, id.POKEMON_STADIUM, variant_type.REMIX, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  POKEMON, Hazards.type.NONE, 138)
    add_stage(norfair_remix, "Norfair Remix", {MIDI.id.NORFAIR}, {MIDI.id.VSRIDLEY}, {MIDI.id.VS_DSAMUS}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, id.NORFAIR, variant_type.REMIX, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  METROID, Hazards.type.HAZARDS, 125)
    add_stage(toadsturnpike, "Toad's Turnpike", {MIDI.id.TOADS_TURNPIKE}, {MIDI.id.RACEWAYS}, {MIDI.id.WALUIGI_PINBALL}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate + 1, default_lightning_rate + 1, default_item_rate, default_item_rate,  MARIO_BROS, Hazards.type.BOTH, 163)
    add_stage(taltal_remix, "Tal Tal Heights Remix", {MIDI.id.LINKS_AWAKENING_MEDLEY}, {MIDI.id.BRAWL_OOT}, {MIDI.id.GERUDO_VALLEY}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, id.TALTAL, variant_type.REMIX, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  ZELDA, Hazards.type.HAZARDS, 160)
    add_stage(sheik_btp, "Board the Platforms", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTP, 0x00003E40, 0x00004028, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 10)
    add_stage(winter_dl, "Winter Dream Land", -1, {MIDI.id.FROZEN_HILLSIDE}, {MIDI.id.BUMPERCROPBUMP}, {MIDI.id.THEATER}, OS.TRUE, HAZARDS_OFF_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, id.DREAM_LAND, variant_type.DL, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  KIRBY, Hazards.type.HAZARDS, 169)
    add_bg_animation(WINTER_DL)
    add_stage(sheik_btt, "Break the Targets", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTT, 0x00003000, 0x00003370, 0x00003580, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 42)
    add_stage(glacial_remix, "Glacial River Remix", {MIDI.id.GLACIAL}, {MIDI.id.CLOCKTOWER}, {MIDI.id.ROLL}, {MIDI.id.SILVERSURFER}, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, id.GLACIAL, variant_type.REMIX, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  MVC, Hazards.type.NONE, 93)
    add_stage(marina_btt, "Break the Targets", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTT, 0x00003720, 0x00003C40, 0x00003E50, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 39)
    add_stage(dragonking_remix, "Dragon King Remix", {MIDI.id.DRAGONKING}, {MIDI.id.TARGET_TEST}, -1, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.DRAGONKING, variant_type.REMIX, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  SMASH, Hazards.type.NONE, 72)
    set_bg_type(DRAGONKING_REMIX, bg_type.SECTORZ)
    add_stage(marina_btp, "Board the Platforms", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTP, 0x00003980, 0x00003B68, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 7)
    add_stage(dedede_btt, "Break the Targets", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.BUMPERCROPBUMP}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTT, 0x00003858, 0x00003D10, 0x00003F20, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 40)
    add_stage(draculas_castle, "Dracula's Castle", {MIDI.id.VAMPIREKILLER}, {MIDI.id.BLOODY_TEARS}, {MIDI.id.DRACULAS_CASTLE}, {MIDI.id.IRON_BLUE_INTENTION}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  CASTLEVANIA, Hazards.type.MOVEMENT, 70)
    add_stage(inverted_castle, "Reverse Castle", {MIDI.id.IRON_BLUE_INTENTION}, {MIDI.id.DRACULAS_CASTLE}, {MIDI.id.OPUS_13}, {MIDI.id.DRACULAS_TEARS}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.DRACULAS_CASTLE, variant_type.REMIX, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  CASTLEVANIA, Hazards.type.MOVEMENT, 142)
    add_stage(dedede_btp, "Board the Platforms", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.BUMPERCROPBUMP}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTP, 0x000073A0, 0x000074D8, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 23)
    add_stage(mt_dedede, "Mt. Dedede", {MIDI.id.DEDEDE}, {MIDI.id.MK_REVENGE}, {MIDI.id.KIRBY_64_BOSS}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  KIRBY, Hazards.type.MOVEMENT, 113)
    add_stage(edo, "Edo Town", {MIDI.id.OEDO_EDO}, {MIDI.id.KAI_HIGHWAY}, {MIDI.id.MUSICAL_CASTLE}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate, GOEMON, Hazards.type.NONE, 77)
    set_custom_item_spawn_rate(EDO, Dango, 0x14)
    add_bg_animation(EDO)
    add_stage(deku_tree_dl, "Deku Tree DL", {MIDI.id.KOKIRI_FOREST}, {MIDI.id.BRAWL_OOT}, {MIDI.id.SARIA}, -1, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.DEKU_TREE, variant_type.DL, 0x05, 0x05, 0x05, 0x03, 0x02, default_item_rate + 2, default_item_rate, ZELDA, Hazards.type.NONE, 64)
    add_stage(zlanding_dl, "Crateria DL", {MIDI.id.CRATERIA_MAIN}, {MIDI.id.ZEBES_LANDING}, {MIDI.id.NORFAIR}, -1, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, id.ZLANDING, variant_type.DL, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  METROID, Hazards.type.NONE, 61)
    add_stage(goemon_btt, "Break the Targets", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTT, 0x000041B8, 0x00004610, 0x00004820, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 45)
    add_stage(first_remix, "First Destination Remix", {MIDI.id.FIRST_DESTINATION}, {MIDI.id.MULTIMAN2}, {MIDI.id.CREDITS_BRAWL}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.FIRST_DESTINATION, variant_type.REMIX, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate, SMASH, Hazards.type.NONE, 81)
    add_stage(btp_goemon, "Board the Platforms", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTP, 0x00006810, 0x00006948, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 19)
    add_stage(twilight_city, "Twilight City", {MIDI.id.TWILIGHT_CITY}, {MIDI.id.SOUTHERNISLAND}, {MIDI.id.MARINE_FORTRESS}, {MIDI.id.DRAKE_LAKE}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  WAVERACE, Hazards.type.MOVEMENT, 165)
    add_stage(melrode, "Melrode", {MIDI.id.QUEST64_BATTLE}, {MIDI.id.DECISIVE}, {MIDI.id.BIG_BRIDGE}, {MIDI.id.SHEVAT}, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  QUEST64, Hazards.type.NONE, 108)
    add_stage(meta_remix, "Meta Crystent", -1, {MIDI.id.METAL_BATTLE}, {MIDI.id.EASTON_KINGDOM}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.META_CRYSTAL, variant_type.REMIX, 0x05, 0x05, 0x05, default_blue_shell_rate + 1, default_lightning_rate + 1, default_item_rate, default_item_rate,  MARIO_BROS, Hazards.type.NONE, 111)
    add_stage(remix_rttf, "Remix 1p Race to the Finish", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.RTTF, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 141)
    set_bg_type(REMIX_RTTF, bg_type.BONUS3)
    add_stage(reapers, "Grim Reaper's Cavern", {MIDI.id.GRIMREAPERSCAVERN}, {MIDI.id.WORLD_OF_ENVY}, {MIDI.id.ARIA_OF_THE_SOUL}, -1, OS.FALSE, HAZARDS_OFF_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  JACKBROS, Hazards.type.NONE, 97)
    add_stage(scuttle_town, "Scuttle Town", {MIDI.id.SHANTAEMEDLEY}, {MIDI.id.BURNINGTOWN}, {MIDI.id.SHANTAEBOSS}, -1, OS.FALSE, HAZARDS_OFF_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  SHANTAE, Hazards.type.MOVEMENT, 146)
    add_bg_animation(SCUTTLE_TOWN)
    add_stage(big_boos_haunt, "Big Boo's Haunt", {MIDI.id.BIG_BOO}, {MIDI.id.HORROR_LAND}, {MIDI.id.GHOSTGULPING}, -1, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate, MARIO_BROS, Hazards.type.MOVEMENT, 5)
    add_bg_animation(BIG_BOOS_HAUNT)
    add_stage(yoshis_island_melee, "Dinosaur Land", {MIDI.id.SMW_ATHLETIC}, {MIDI.id.SMW_TITLECREDITS}, {MIDI.id.FORTRESS_BOSS}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate, YOSHI, Hazards.type.MOVEMENT, 66)
    add_stage(banjo_btt, "Break the Targets", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTT, 0x00005300, 0x00005970, 0x00005B80, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 46)
    add_stage(spawned_fear, "Spawned Fear", {MIDI.id.DOOM1}, {MIDI.id.RUNNING_FROM_EVIL}, {MIDI.id.GRABBAG}, {MIDI.id.FORGONE}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate, DOOM, Hazards.type.BOTH, 156)
    add_stage(smashville_remix, "Smashville Remix", {MIDI.id.ANIMAL_CROSSING}, {MIDI.id.KK_RIDER}, {MIDI.id.BUBBLEGUM_KK}, {MIDI.id.7AM}, OS.TRUE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, id.SMASHVILLE2, variant_type.REMIX, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  ANIMAL_CROSSING, Hazards.type.MOVEMENT, 153)
    set_custom_item_spawn_rate(SMASHVILLE_REMIX, Pitfall, 0x14)
    add_stage(btp_banjo, "Board the Platforms", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTP, 0x00007050, 0x00007188, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 20)
    add_bg_animation(SMASHVILLE_REMIX)
    add_stage(pokefloats, "Poke Floats", {MIDI.id.POKEFLOATS}, {MIDI.id.BATTLE_GOLD_SILVER}, {MIDI.id.GOLDENROD_CITY}, {MIDI.id.COBALT}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate, POKEMON, Hazards.type.MOVEMENT, 136)
    add_position_array(POKEFLOATS, 0, 680, 0)
    add_stage(big_snowman, "Big Snowman", {MIDI.id.BIG_SNOWMAN}, {MIDI.id.WENDYS_HOUSE}, {MIDI.id.SILVER_MOUNTAIN}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate, SNOWBOARDKIDS, Hazards.type.MOVEMENT, 6)
    add_stage(dl_beta_dl, "Dream Land Beta DL", {MIDI.id.HILLTOPCHASE}, 0x0, {MIDI.id.BUTTER_BUILDING}, {MIDI.id.BATTLE_AMONG_FRIENDS}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.TRUE, OS.TRUE, class.BATTLE, -1, -1, -1, id.DREAM_LAND_BETA_1, variant_type.DL, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate, KIRBY, Hazards.type.NONE, 75)
    add_stage(lmao_castle, "LMAO Castle", -1, {MIDI.id.BOB}, {MIDI.id.SLIDER}, {MIDI.id.BIG_BRIDGE}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.PEACHS_CASTLE, variant_type.REMIX2, 0x05, 0x05, 0x05, default_blue_shell_rate + 1, default_lightning_rate + 1, default_item_rate, default_item_rate,  MARIO_BROS, Hazards.type.BOTH, 106)
    add_stage(discovery_falls, "Discovery Falls", {MIDI.id.DISCOVERYFALLS}, -1, -1, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate, DINOPLANET, Hazards.type.NONE, 67)
    add_stage(btt_crash, "Break the Targets", -1, {MIDI.id.CRASHBONUS}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTT, 0x00005178, 0x00006510, 0x00006720, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 43)
    add_stage(discovery_falls_remix, "Discovery Falls Remix", {MIDI.id.DISCOVERYFALLS}, -1, -1, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.DISCOVERY_FALLS, variant_type.REMIX, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate, DINOPLANET, Hazards.type.NONE, 68)
    add_stage(n64_remix, "N64 Remix", {MIDI.id.N64}, {MIDI.id.TALENTSTUDIO}, {MIDI.id.REDIAL}, {MIDI.id.GREENGARDEN}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.N64, variant_type.REMIX, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate, REMIX, Hazards.type.NONE, 122)
    set_bg_type(N64_REMIX, bg_type.SECTORZ)
    add_stage(btp_crash, "Board The Platforms", -1, {MIDI.id.CRASHBONUS}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTP, 0x00006950, 0x00006B38, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 22)
    add_stage(btt_peach, "Break the Targets", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTT, 0x00005D08, 0x000061D0, 0x000063E0, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 44)
    add_stage(btp_peach, "Board The Platforms", -1, {MIDI.id.TARGET_TEST}, {MIDI.id.TARGET_TEST}, -1, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.BTP, 0x000088E0, 0x00008AC8, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 25)
    add_stage(soccer, "Soccer", {MIDI.id.SOCCER_MENU}, {MIDI.id.WILY_FIELD}, {MIDI.id.KENGJR}, {MIDI.id.NBA_JAM}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.RTTF, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  NONE, Hazards.type.NONE, 155)
    add_stage(time_twister, "Time Twister", {MIDI.id.CRASH3}, {MIDI.id.NSANITYBEACH}, {MIDI.id.HOGWILD}, {MIDI.id.CORTEX}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  CRASH, Hazards.type.MOVEMENT, 162)
    add_stage(time_twister_sss, "Time Twister", {MIDI.id.CRASH3}, {MIDI.id.NSANITYBEACH}, {MIDI.id.HOGWILD}, {MIDI.id.CORTEX}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.FALSE, class.SSS_PREVIEW, -1, -1, -1, -1, -1, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  CRASH, Hazards.type.MOVEMENT, 161)
    add_stage(nsanity_beach, "N. Sanity Beach", {MIDI.id.NSANITYBEACH}, {MIDI.id.CRASH3}, {MIDI.id.HOGWILD}, {MIDI.id.CORTEX}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.TIME_TWISTER, variant_type.REMIX, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  CRASH, Hazards.type.NONE, 120)
    add_stage(snow_go, "Snow Go", {MIDI.id.SNOWGO}, {MIDI.id.CRASH3}, {MIDI.id.HOGWILD}, {MIDI.id.CORTEX}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.TIME_TWISTER, variant_type.REMIX2, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  CRASH, Hazards.type.NONE, 154)
    add_stage(future_frenzy, "Future Frenzy", {MIDI.id.FUTUREFRENZY}, {MIDI.id.CRASH3}, {MIDI.id.HOGWILD}, {MIDI.id.CORTEX}, OS.FALSE, HAZARDS_ON_MOVEMENT_ON, OS.FALSE, OS.TRUE, class.BATTLE, -1, -1, -1, id.TIME_TWISTER, variant_type.REMIX3, 0x05, 0x05, 0x05, default_blue_shell_rate, default_lightning_rate, default_item_rate, default_item_rate,  CRASH, Hazards.type.MOVEMENT, 88)

    map 0, 0, 256 // restore string mappings

    // Alphabetize the custom stages entries
    // First, initialize the sorted_stage array
    evaluate n(0x29)
    while {n} <= Stages.id.MAX_STAGE_ID {
        global define sorted_stage_{n}({n})
        evaluate n({n}+1)
    }
    // Next, sort the indices based on track titles
    evaluate i(0x29)
    while {i} <= (Stages.id.MAX_STAGE_ID - 1) {
        evaluate j({i} + 1)
        while {j} <= (Stages.id.MAX_STAGE_ID) {
            evaluate id_i({sorted_stage_{i}})
            evaluate id_j({sorted_stage_{j}})
            variable order_i({Stages.STAGE_{id_i}_ORDER})
            variable order_j({Stages.STAGE_{id_j}_ORDER})
            if (order_i > order_j) {
                // Swap indices
                global evaluate sorted_stage_{i}({id_j})
                global evaluate sorted_stage_{j}({id_i})
            }
            evaluate j({j} + 1)
        }
        evaluate i({i} + 1)
    }

    // @ Description
    // This function replaces the logic to convert the default cursor_id to a stage_id when on stage select screen.
    // When stage select is off, it adds custom stages to the random stage functionality.
    // @ Returns
    // v0 - stage_id
    scope swap_stage_: {
        // Stage Select Screen
        OS.patch_start(0x0014F774, 0x80133C04)
//      jal     0x80132430                  // original line 1
//      nop                                 // original line 2
        jal     swap_stage_
        nop
        OS.patch_end()

        // Stage Select is off
        OS.patch_start(0x00138C9C, 0x8013AA1C)
        jal     swap_stage_._stage_select_off_begin
        nop
        OS.patch_end()

        addiu   sp, sp,-0x0014              // allocate stack space
        sw      t0, 0x0004(sp)              // ~
        sw      ra, 0x0008(sp)              // ~
        sw      at, 0x000C(sp)              // save registers

        jal     get_stage_id_               // v0 = stage_id
        nop

        // this block checks if random is selected (if not stage_id is returned)
        _check_random:
        lli     t0, id.RANDOM               // t0 = id.RANDOM
        bne     v0, t0, _end                // if (stage_id != id.RANDOM), end
        nop
        b       _get_random_stage_id
        nop

        _stage_select_off_begin:
        addiu   sp, sp,-0x0014              // allocate stack space
        sw      t0, 0x0004(sp)              // ~
        sw      ra, 0x0008(sp)              // ~
        sw      at, 0x000C(sp)              // save registers

        _get_random_stage_id:
        lli     a2, OS.FALSE                 // a2 = FALSE = only add stages toggled on
        li      t0, random_count            // ~
        sw      r0, 0x0000(t0)              // reset count

        _build_stage_list:
        add_to_list(Toggles.entry_random_stage_peachs_castle, id.PEACHS_CASTLE)
        add_to_list(Toggles.entry_random_stage_sector_z, id.SECTOR_Z)
        add_to_list(Toggles.entry_random_stage_congo_jungle, id.CONGO_JUNGLE)
        add_to_list(Toggles.entry_random_stage_planet_zebes, id.PLANET_ZEBES)
        add_to_list(Toggles.entry_random_stage_hyrule_castle, id.HYRULE_CASTLE)
        add_to_list(Toggles.entry_random_stage_yoshis_island, id.YOSHIS_ISLAND)
        add_to_list(Toggles.entry_random_stage_dream_land, id.DREAM_LAND)
        add_to_list(Toggles.entry_random_stage_saffron_city, id.SAFFRON_CITY)
        add_to_list(Toggles.entry_random_stage_mushroom_kingdom, id.MUSHROOM_KINGDOM)
        add_to_list(Toggles.entry_random_stage_duel_zone, id.DUEL_ZONE)
        add_to_list(Toggles.entry_random_stage_final_destination, id.FINAL_DESTINATION)
        add_to_list(Toggles.entry_random_stage_dream_land_beta_1, id.DREAM_LAND_BETA_1)
        add_to_list(Toggles.entry_random_stage_dream_land_beta_2, id.DREAM_LAND_BETA_2)
        add_to_list(Toggles.entry_random_stage_how_to_play, id.HOW_TO_PLAY)
        add_to_list(Toggles.entry_random_stage_mini_yoshis_island, id.MINI_YOSHIS_ISLAND)
        add_to_list(Toggles.entry_random_stage_meta_crystal, id.META_CRYSTAL)

        // Add custom Stages
        define n(0x29)
        evaluate n({n})
        while {n} <= id.MAX_STAGE_ID {
            evaluate id({sorted_stage_{n}})
            evaluate can_toggle({STAGE_{id}_TOGGLE})
            if ({can_toggle} == OS.TRUE) {
                add_to_list(Toggles.entry_random_stage_{n}, {id})
            }
            evaluate n({n}+1)
        }

        beqzl   v1, _build_stage_list       // if there were no valid entries in the random table, then use all stage_ids
        lli     a2, OS.TRUE                // a2 = TRUE = load all stages

        sw      v1, 0x0010(sp)              // remember stage count

        // this block loads from the random list using a random int
        move    a0, v1                      // a0 - range (0, N-1)
        jal     Global.get_random_int_      // v0 = (0, N-1)
        nop
        li      t0, random_table            // t0 = random_table
        addu    t0, t0, v0                  // t0 = random_table + offset
        lbu     v0, 0x0000(t0)              // v0 = stage_id

        // if there is only 1 valid stage in the random list, then we need to update last stage played
        // to avoid a crash.
        lw      v1, 0x0010(sp)              // v1 = valid stage count
        lli     a0, 0x0001                  // a0 = 1
        li      t0, Global.current_screen
        addiu   at, v0, 0x0001              // at = stage_id + 1
        beql    a0, v1, _end_random         // if only 1 valid stage, then make sure previous stage is different
        sb      at, 0x000F(t0)              // set previous stage_id to wrong value

        _end_random:
        li      at, Toggles.entry_sss_layout
        lw      at, 0x0004(at)              // at = stage table index
        beqz    at, _check_freeze           // if not on tournament layout, skip
        nop

        li      t0, tournament_hazard_mode_table
        addu    t0, t0, v0                  // t0 = address of stage's tournament hazard mode value to force
        lbu     t0, 0x0000(t0)              // t0 = stage's tournament hazard mode value to force
        li      at, Toggles.entry_hazard_mode
        sw      t0, 0x0004(at)              // update hazard mode
        b       _end
        nop

        // check if stage movement needs freezing
        _check_freeze:
        li      at, stage_hazard_table      // at = address of variant stage_id table
        addu    at, at, v0                  // at = stage_hazard_table + offset
        lbu     at, 0x0000(at)              // at = hazard_type selected
        andi    at, at, Hazards.type.MOVEMENT// at = 1 if hazard_type is MOVEMENT or BOTH, 0 otherwise
        bnezl   at, pc() + 12
        lli     at, 0x0000                  // at = 0 (freeze stage)
        lli     at, 0x0001                  // at = 1 (don't freeze stage)
        li      t0, dont_freeze_stage       // t0 = address of dont_freeze_stage
        sw      at, 0x0000(t0)              // update

        _end:
        lw      t0, 0x0004(sp)              // ~
        lw      ra, 0x0008(sp)              // ~
        lw      at, 0x000C(sp)              // restore registers
        addiu   sp, sp, 0x0014              // deallocate stack space
        jr      ra                          // return
        nop
    }

    // @ Description
    // This patch advances the RNG seed pseudorandomly when transitioning from character select
    // to stage selection. This should fix random stage/music being the same the first time without
    // causing desync issues on netplay.
    scope random_fix_: {
        OS.patch_start(0x138C50, 0x8013A9D0)
        j       random_fix_
        lui     t9, 0x800A                  // original line 2
        _return:
        OS.patch_end()

        addiu   sp, sp,-0x0020              // allocate stack space
        sw      a0, 0x0004(sp)              // ~
        sw      at, 0x0008(sp)              // ~
        sw      v0, 0x0010(sp)              // ~
        sw      v1, 0x0014(sp)              // store a0, at, v0, v1 (for safety)

        li      t8, 0x8003B6E4              // ~
        lw      t8, 0x0000(t8)              // t8 = frame count for current screen
        andi    t8, t8, 0x003F              // t8 = frame count % 64

        _loop:
        // advances rng between 1 - 64 times based on frame count when entering stage selection
        jal     0x80018910                  // this function advances the rng seed
        nop
        bnez    t8, _loop                   // loop if t8 != 0
        addiu   t8, t8,-0x0001              // subtract 1 from t8

        _end:
        lw      a0, 0x0004(sp)              // ~
        lw      at, 0x0008(sp)              // ~
        lw      v0, 0x0010(sp)              // ~
        lw      v1, 0x0014(sp)              // load a0, at, v0, v1
        addiu   sp, sp, 0x0020              // deallocate stack space

        j       _return                     // return
        lbu     t8, 0x0000(v1)              // original line 1
    }


    dont_freeze_stage:
    dw 0

}

} // __STAGES__
