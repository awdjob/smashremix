// @ Description
// These constants must be defined for an item.
constant SPAWN_ITEM(_stage_setting)
constant SHOW_GFX_WHEN_SPAWNED(OS.FALSE)
constant PICKUP_ITEM_MAIN(0)
constant PICKUP_ITEM_INIT(0)
constant DROP_ITEM(0)
constant PLAYER_COLLISION(0)
constant THROW_ITEM(0)

// 8027E850 00000000 00000000 00000000
// 18000000 00000000 00000000 00000000
// 00000000 00960096 0096013D 0000FEC3
// 00C3012C 16864180 0007904A 31051800
// 0E4390E4 32000000

// @ Description
// Offset to item in file.
constant FILE_OFFSET(0x0BB0) // hitmonlee offset = 0BB0

// @ Description
// Item info array
item_info_array:
constant ITEM_INFO_ARRAY_ORIGIN(origin())
dw 0x00000000                           // 0x00 - item ID (will be updated by Item.add_item
dw 0x8018D040                           // 0x04 - address of file pointer (this is a hardcoded address that leads to Japes Header)
dw FILE_OFFSET                          // 0x08 - offset to item footer
dw 0x1B000000                           // 0x0C - ? either 0x1B000000 or 0x1C000000 - possible argument
dw 0x00000000                           // 0x10 - hitbox enabler
// state 0 - spawn
dw 0x80182AE0                           // 0x14 - state 0 main
dw 0x80182B34                           // 0x18 - state 0 collision
dw 0x00000000                           // 0x1C - state 0 hitbox collision w/ hurtbox
dw 0x00000000                           // 0x20 - state 0 hitbox collision w/ shield
dw 0x00000000                           // 0x24 - state 0 hitbox collision w/ shield edge
dw 0x00000000                           // 0x28 - state 0 unknown (maybe absorb)
dw 0x00000000                           // 0x2C - state 0 hitbox collision w/ reflector
STATE_TABLE:
// state 1
dw 0x80182630       // main
dw 0x80182660       // collision
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
// state 2 - grounded
dw 0x801826D0       // main
dw 0x80182714       // collision
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
// state 3 - attack
dw 0x80182764       // main
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0
dw 0

// based on hitmon 0x80182B74
scope _stage_setting: {
    addiu   sp, sp, -0x38
    sw      s0, 0x0020(sp)
    or      s0, a3, r0
    sw      a1, 0x003c(sp)
    or      a3, a2, r0
    sw      ra, 0x0024(sp)
    sw      a2, 0x0040(sp)
    li      a1, item_info_array // a1 = item info array for this item
    lw      a2, 0x003c(sp)
    jal     0x8016E174   // create item
    sw      s0, 0x0010(sp)
    beqz    v0, _end     // branch if no item spawned
    or      s0, v0, r0   // return 0

    // if here, pokemon spawned
    lw      v1, 0x0084(v0)
    lw      a0, 0x0074(v0)
    mtc1    r0, f0
    lui     at, 0x4180
    mtc1    at, f4
    addiu   t6, r0, 0x0016
    sh      t6, 0x033E(v1)
    swc1    f0, 0x0034(v1)
    swc1    f0, 0x002c(v1)
    swc1    f4, 0x0030(v1)
    addiu   a1, r0, 0x0048
    or      a2, r0, r0
    sw      v1, 0x002c(sp)
    jal     0x80008CC0
    sw      a0, 0x0030(sp)
    lw      t7, 0x003c(sp)
    lw      a0, 0x0030(sp)
    lw      v1, 0x002c(sp)
    lw      t9, 0x0000(t7)
    lui     t4, 0x0001
    addiu   t4, t4, 0x1f40
    sw      t9, 0x001c(a0)
    lw      t8, 0x0004(t7)
    lui     t6, 0x0001
    addiu   t6, t6, 0x3624
    sw      t8, 0x0020(a0)
    lw      t9, 0x0008(t7)
    lwc1    f6, 0x0020(a0)
    addiu   a2, r0, 0x0000
    sw      t9, 0x0024(a0)
    lw      t0, 0x02D4(v1)
    lh      t1, 0x002E(t0)
    mtc1    t1, f8
    nop
    cvt.s.w f10, f8
    sub.s   f16, f6, f10
    swc1    f16, 0x0020(a0)
    lw      t2, 0x02D4(v1)
    lw      t3, 0x0000(t2)
    subu    t5, t3, t4
    jal     0x8000BD1C
    addu    a1, t5, t6
    jal     0x800269C0
    addiu   a0, r0, 0x013E
    or      a0, s0, r0
    addiu   a1, r0, 0x0012
    jal     0x8000A14C
    lw      a2, 0x0028(s0)

    _end:
    lw      ra, 0x0024(sp)
    or      v0, s0, r0
    lw      s0, 0x0020(sp)
    jr      ra
    addiu   sp, sp, 0x38
}