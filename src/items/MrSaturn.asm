// Coded by HaloFactory
// @ Description
// These constants must be defined for an item.
constant SPAWN_ITEM(stage_setting_)
constant SHOW_GFX_WHEN_SPAWNED(OS.TRUE)
constant PICKUP_ITEM_MAIN(pickup_)
constant PICKUP_ITEM_INIT(prepickup_)
constant DROP_ITEM(falling_initial_)
constant THROW_ITEM(throw_initial_)
constant PLAYER_COLLISION(0)

// edit these as needed
constant BASE_DAMAGE(2)                 // base damage
constant BKB(25)                        // base knockback
constant KBG(60)                        // knockback growth
constant KB_ANGLE(361)
constant THROW_TIMER(50)                // x frames before ending (unused)
constant SLOW_TIMER(30)                 // x frames before ending (unused)
constant SLOW_MULTIPLIER(0x3F70)        // deceleration multiplier to use for slowing state
constant HIT_MULTIPLIER(0xBE00)         // deceleration multiplier to use on player collision
constant HIT_Y_VELOCITY(0x4220)
constant GRAVITY(0x3FE0999A)
constant THROWN_SPEED(0x42C8)
constant HIT_FGM(0x0038)                // shell sound
constant GROUND_TIMER(0x030C)
constant SHIELD_DAMAGE(30)              // 30 = amount needed to shield break with max throw and Peach's dash attack
constant WAIT_TIME(120)                 // frames until he starts to walk
constant WALK_TIME(25 * 60)

constant FILE_OFFSET(0x10B0)

constant ITEM_INFO_ARRAY_ORIGIN(origin())
item_info_array:
dw 0                                    // 0x00 - item ID
dw 0x8018D040                           // 0x04 - address of file pointer
dw FILE_OFFSET                          // 0x08 - offset to item footer
dw 0x1B000000                           // 0x0C - ? either 0x1B000000 or 0x1C000000 - possible argument
dw 0                                    // 0x10 - ?

dw 0x801744C0                           // 0x14 - ? spawn behavior? (using Maxim Tomato)
dw ground_collision                     // 0x18 - ? ground collision
dw 0                                    // 0x1C - ?
dw 0, 0, 0, 0                           // 0x20 - 0x2C - ?

// @ Description
// Item state table
item_state_table:
// STATE 0 - PREPICKUP - GROUNDED
dw wait_main                            // 0x00 - main
dw grounded_wait_collision              // 0x04 - collision
dw 0                                    // 0x08 - hitbox collision w/ hurtbox
dw 0                                    // 0x0C - hitbox collision w/ shield
dw 0                                    // 0x10 - hitbox collision w/ shield edge
dw 0                                    // 0x14 - clang?
dw 0                                    // 0x18 - hitbox collision w/ reflector
dw 0                                    // 0x1C - hurtbox collision w/ hitbox

// STATE 1 - PREPICKUP - AERIAL
dw 0x801744C0                           // 0x20 - main
dw ground_collision                           // 0x24 - collision
dw 0                                    // 0x28 - hitbox collision w/ hurtbox
dw 0                                    // 0x2C - hitbox collision w/ shield
dw 0                                    // 0x30 - hitbox collision w/ shield edge
dw 0                                    // 0x34 - clang?
dw 0                                    // 0x38 - hitbox collision w/ reflector
dw 0                                    // 0x3C - hurtbox collision w/ hitbox

// STATE 2 - PICKUP
dw held_main                            // 0x40 - main
dw 0                                    // 0x44 - collision
dw 0                                    // 0x48 - hitbox collision w/ hurtbox
dw 0                                    // 0x4C - hitbox collision w/ shield
dw 0                                    // 0x50 - hitbox collision w/ shield edge
dw 0                                    // 0x54 - clang?
dw 0                                    // 0x58 - hitbox collision w/ reflector
dw 0                                    // 0x5C - hurtbox collision w/ hitbox

// STATE 3 - THROWN
dw thrown_main_                         // 0x60 - main
dw ground_collision                     // 0x64 - collision
dw throw_collide_                       // 0x68 - hitbox collision w/ hurtbox
dw throw_collide_                       // 0x6C - hitbox collision w/ shield
dw 0x801733E4                           // 0x70 - hitbox collision w/ shield edge
dw throw_collide_                       // 0x74 - clang?
dw reflect_                             // 0x78 - hitbox collision w/ reflector
dw throw_collide_hitbox_                // 0x7C - hurtbox collision w/ hitbox

// STATE 4 - FALLING
dw 0x801744C0                           // 0x20 - main
dw ground_collision                     // 0x24 - collision
dw 0                                    // 0x28 - hitbox collision w/ hurtbox
dw 0                                    // 0x2C - hitbox collision w/ shield
dw 0                                    // 0x30 - hitbox collision w/ shield edge
dw 0                                    // 0x34 - clang?
dw 0                                    // 0x38 - hitbox collision w/ reflector
dw 0                                    // 0x3C - hurtbox collision w/ hitbox

// STATE 5 - WALKING
dw walking_main                         // 0x20 - main
dw grounded_check_collision_            // 0x24 - collision
dw 0                                    // 0x28 - hitbox collision w/ hurtbox
dw 0                                    // 0x2C - hitbox collision w/ shield
dw 0                                    // 0x30 - hitbox collision w/ shield edge
dw 0                                    // 0x34 - clang?
dw 0                                    // 0x38 - hitbox collision w/ reflector
dw 0                                    // 0x3C - hurtbox collision w/ hitbox

// @ Description
// Based on 0x8017ADD4 for red shell
scope grounded_check_collision_: {
    addiu   sp, sp, -0x20                // begin
    sw      ra, 0x001c(sp)                // save registers
    sw      s0, 0x0018(sp)                // ~
    lw      s0, 0x0084(a0)

    li      a1, falling_initial_         // a1 = set_aerial routine

    jal     0x801735A0                    // this routine will check if the item has left a platform
    sw      a0, 0x0020(sp)
    beqzl   v0, _end
    lw      ra, 0x001C(sp)
    lhu     t6, 0x008E(s0)
    andi    t7, t6, 0x0021
    beqzl   t7, _end
    lw      ra, 0x001C(sp)
    lwc1    f4, 0x002C(s0)
    neg.s   f6, f4
    swc1    f6, 0x002C(s0)
    jal     0x80172508
    lw      a0, 0x0020(sp)
    jal     0x8017279c                    // unknown
    lw      a0, 0x0020(sp)
    lwc1    f8, 0x0358(s0)
    neg.s   f10, f8
    swc1    f10, 0x0358(s0)
    lw      ra, 0x001c(sp)

    _end:
    lw      s0, 0x0018(sp)                // end
    addiu   sp, sp,0x20
    jr      ra
    or      v0, r0, r0
}

// copy of 801744FC
scope grounded_wait_collision: {
    OS.routine_begin(0x20)
    li      a1, falling_initial_
    jal     0x801735A0
    nop
    addiu   v0, r0, 0   // return 0
    OS.routine_end(0x20)
}

// @ Description
// Subroutine which sets up initial properties of waddle dee/doo.
// a1 - item info array
// a2 - x/y/z coordinates to create item at
// a3 - unknown x/y/z offset
scope stage_setting_: {
    addiu   sp, sp, -0x80               // allocate stackspace
    sw      a2, 0x0050(sp)              // save a previous sp value to sp
    sw      s0, 0x0020(sp)              // save s0
    or      a2, a1, r0                  // a2 = a1(?)
    sw      a1, 0x004c(sp)              // save a1(?)
    or      s0, a3, r0                  // s0 = a3 (boolean ?)
    sw      ra, 0x0024(sp)              // save ra

    li      a1, item_info_array         // a1 = items info array
    lw      a3, 0x0050(sp)              // a3 = unknown sp pointer
    jal     0x8016E174                  // spawn item
    sw      s0, 0x0010(sp)              // save boolean(?) to sp
    beqz    v0, _end                    // skip if no item was spawned

    or      a3, v0, r0                  // a3 = item object
    lw      v0, 0x0074(v0)              // load item position struct


    lw      a0, 0x0074(a3)                  // a0 = item first joint (joint 0)
    lw      t0, 0x0080(a0)                  // get image footer struct
    addiu   t1, r0, 5
    sh      t1, 0x0080(t0)                  // set image index


    // rendering stuff
    addiu   t6, sp, 0x0030              // t6 = sp + 0x30
    or      a0, a3, r0
    addiu   v1, v0, 0x001C              // v1 = substruct in position struct
    lw      t8, 0x0000(v1)              // load ? from substruct
    sw      t8, 0x0000(t6)              // save value
    lw      t7, 0x0004(v1)              // load ? from substruct
    sw      t7, 0x0004(t6)              // save value
    lw      t8, 0x0008(v1)              // load render/view matrix ptr?
    sw      t8, 0x0008(t6)              // save value

    lw      s0, 0x0084(a3)              // s0 = item struct
    sh      r0, 0x033e(s0)              // set flag used for bomb to 0
    sw      a3, 0x0044(sp)
    sw      v1, 0x002c(sp)              // save substruct address
    jal     0x8017279C                  // unknown. Used with bob-omb and bumper
    sw      v0, 0x0040(sp)
    lw      a0, 0x0040(sp)
    addiu   a1, r0, 0x002E              // argument 1 = render routine index?
    jal     0x80008CC0                  // apply render routine
    or      a2, r0, r0                  // argument 2 = 0

    addiu   t0, sp, 0x0030              // this seems related to rendering
    lw      t2, 0x0000(t0)              // load ? from substruct
    lw      t9, 0x002C(sp)              // save
    mtc1    r0, f4
    or      a0, s0, r0
    sw      t2, 0x0000(t9)
    lw      t1, 0x0004(t0)              // load ? from substruct
    sw      t1, 0x0004(t9)              // save value
    lw      t2, 0x0008(t0)              // load ? from substruct
    sw      t2, 0x0008(t9)              // save value

    //sw      r0, 0x0248(s0)                  // disable hurtbox
    sw      r0, 0x010C(s0)                  // disable hitbox
    sw      r0, 0x01CC(s0)                  // rotation direction = 0
    sw      r0, 0x01D0(s0)                  // hitbox refresh timer = 0
    sw      r0, 0x01D4(s0)                  // hitbox collision flag = FALSE
    sw      r0, 0x0398(s0)                  // save routine to part of item special struct that carries unique blast wall destruction routines
    sh      r0, 0x033E(s0)                  // set flag used for bomb to 0
    lli     at, KBG                         // at = kb growth
    sw      at, 0x0140(s0)                  // overwrite
    lli     at, BKB                         // at = base knockback
    sw      at, 0x0148(s0)                  // overwrite
    lli     at, KB_ANGLE                    // at = knockback angle
    sw      at, 0x013C(s0)                  // overwrite
    addiu   v0, r0, HIT_FGM                 // v0 = HIT FGM
    sh      v0, 0x156(s0)                   // save fgm value
    sw      s0, 0x002C(sp)

    lli     at, SHIELD_DAMAGE
    sw      at, 0x014C(s0)                  // overwrite shield damage
    lli     at, 6                           // at = base damage
    sw      at, 0x0110(s0)                  // overwrite base damage
    addiu   t1, r0, 6                       // t1 = image index
    lw      s0, 0x002C(sp)
    lw      t4, 0x0004(s0)                  // t4 = obj
    lw      a0, 0x0074(t4)                  // a0 = item first joint (joint 0)
    lw      t0, 0x0080(a0)                  // get image footer struct
    sh      t1, 0x0080(t0)                  // set image index

    addiu   at, r0, WAIT_TIME               // at = time to wait before entering walking state
    sw      at, 0x02C0(s0)                  // set wait time


    lbu     t4, 0x02d3(s0)                  // original code here
    ori     t5, t4, 0x0004
    sb      t5, 0x02d3(s0)
    lw      t6, 0x0040(sp)
    addiu   a0, s0, 0
    jal     0x80111EC0                      // Common subroutine seems to be used for items
    swc1    f4, 0x0038(t6)
    lw      a3, 0x0044(sp)
    sw      v0, 0x0348(s0)
    addiu   at, r0, 1
    sw      at, 0x0024(s0)                  // set direction

    sw      r0, 0x0358(s0)                  // set shell velocity x to 0 to avoid errors in vanilla shell routines

    _end:
    lw      ra, 0x0024(sp)
    lw      s0, 0x0020(sp)
    addiu   sp, sp, 0x80
    jr      ra
    or      v0, a3, r0
}

// copied 80174524
// different transition routine
scope ground_collision: {
    addiu   sp, sp, -0x18
    sw      ra, 0x0014 (sp)
    lui     a1, 0x3E99

    li      a3, wait_initial        // a3 = transition routine
    ori     a1, a1, 0x999A
    jal     0x80173b24              // common routine for when items land
    lui     a2, 0x3f00
    lw      ra, 0x0014 (sp)
    jr      ra
    addiu   sp, sp, 0x18
}

// set to state 1
scope wait_initial: {
    OS.routine_begin(0x20)
    jal     0x80172E74      //  enable item pickup
    sw      a0, 0x0018(sp)
    lw      a0, 0x0018(sp)

    // set wait timer
    lw      v0, 0x0084(a0)
    addiu   at, r0, WAIT_TIME               // at = time to wait before entering walking state
    sw      at, 0x02C0(v0)                  // set wait time

    li      a1, item_state_table
    jal     0x80172EC8                      // change item state
    addiu   a2, r0, 0x0000                  // state = 0(grounded wait)
    OS.routine_end(0x20)
}

// grounded
scope wait_main: {
    OS.routine_begin(0x20)
    sw      a0, 0x001C(sp)  // store item

    lw      v0, 0x0084(a0)  // item struct
    lw      t0, 0x02C0(v0)  // get wait time
    addiu   t0, t0, -1      // subtract 1
    bnez    t0, _end
    sw      t0, 0x02C0(v0)  // save timer

    _start_walk:
    li      a1, item_state_table
    jal     0x80172EC8                      // change item state
    addiu   a2, r0, 0x0005                  // state = 5(walk)
    lw      a0, 0x001C(sp)          // restore item
    lw      v0, 0x0084(a0)
    addiu   at, r0, WALK_TIME
    sw      at, 0x02C0(v0)      // set walking timer

    _end:
    addiu   v0, r0, 0         // don't destroy item
    OS.routine_end(0x20)
}

// mr saturn grounded walking
scope walking_main: {
    OS.routine_begin(0x20)
    lw      v0, 0x0084(a0)      // item struct
    sw      a0, 0x001C(sp)

    // timer
    lw      t0, 0x02C0(v0)      // get wait time
    addiu   t0, t0, -1          // subtract 1
    beqzl   t0, _end            // destroy item if timer is up
    addiu   v0, r0, 1           // destroy mr saturn
    sw      t0, 0x02C0(v0)      // save timer

    jal     0x8017AC84          // edge detect function (from red shell)
    nop

    lw      a0, 0x001C(sp)
    beqz    v0, _move
    lw      v1, 0x0084(a0)      // v1 = item struct

    // if here, switch direction
    lw      t2, 0x0024(v1)      // load current facing direction
    addiu   at, r0, 0xFFFF
    beql    at, t2, _set_direction
    addiu   at, r0, 0xFFFF      // set left
    addiu   at, r0, 0x0001      // set right

    _set_direction:
    sw      at, 0x0024(v1)      // ~

    _move:
    lw      at, 0x0024(v1)      // load direction
    addiu   t1, r0, 0xFFFF
    beql    at, t1, _set_velocity
    lui     t0, 0xC100  // left
    lui     t0, 0x4100  // right

    _set_velocity:
    sw      t0, 0x002C(v1)      // set x velocity
    jal     _update_x_scale
    nop

    // animate him
    jal     _animate_saturn
    nop

    addiu   v0, r0, 0           // don't destroy item

    _end:
    OS.routine_end(0x20)
}

// a0 = item obj
scope _update_x_scale: {
    OS.routine_begin(0x20)
    lw      v1, 0x0084(a0)
    lw      t0, 0x0024(v1)      // t0 = current direction
    addiu   at, r0, 1           // at = RIGHT
    beql    at, t0, _continue
    lui     t1, 0x3F80          // t1 = 1.0
    lui     t1, 0xBF80          // or t1 = -1.0
    _continue:
    lw      t2, 0x0074(a0)      // t2 = rendering struct
    sw      t1, 0x0040(t2)      // update x scale
    OS.routine_end(0x20)
}

// a0 = item obj
scope _update_held_x_scale: {
    OS.routine_begin(0x20)
    lw      v1, 0x0084(a0)
    lw      t0, 0x0024(v1)      // t0 = current direction
    addiu   at, r0, 1           // at = RIGHT
    beql    at, t0, _continue
    lui     t1, 0x3F80          // t1 = 1.0
    lui     t1, 0xBF80          // or t1 = -1.0
    _continue:
    lw      t2, 0x0074(a0)      // t2 = rendering struct
    lw      t2, 0x0010(t2)      // t2 = held rendering struct
    sw      t1, 0x0040(t2)      // update x scale
    OS.routine_end(0x20)
}

// animation for mr saturns grounded walk
scope _animate_saturn: {
    lw      at, 0x0084(a0)
    lw      t0, 0x02C0(at)                  // load timer
    sll     t0, t0, 30
    bnez    t0, _end
    lw      v0, 0x0074(a0)                  // v1 = position struct
    lw      v0, 0x0080(v0)                  // v1 = image struct
    lh      at, 0x0080(v0)                  // get current image index
    addiu   t0, r0, 4
    beql    at, t0, _update_image
    lli     at, 5                           // image index 1...
    lli     at, 4                           // ...or image index 2

    _update_image:
    sh      at, 0x0080(v0)                  // set image index
    _end:
    jr      ra
    nop
}

// this animates Mr. Saturn while he is held
scope held_main: {
    OS.routine_begin(0x20)
    sw      a0, 0x001C(sp)
    jal     _animate_held_saturn
    nop

    // update x scale
    lw      a0, 0x001C(sp)
    lw      v1, 0x0084(a0)
    lw      t0, 0x0008(v1)  // t0 = player owner
    beqz    t0, _timer      // skip update x scale if no player owner
    nop
    lw      t1, 0x0084(t0)  // t1 = player struct
    lw      t0, 0x0044(t1)  // load player direction
    sw      t0, 0x0024(v1)  // overwrite mr saturn direction with players current direction

    jal     _update_held_x_scale
    nop
    lw      a0, 0x001C(sp)

    _timer:
    lw      at, 0x0084(a0)
    lw      t0, 0x02C0(at)                  // load timer
    addiu   t0, t0, 1                       // timer += 1
    sw      t0, 0x02C0(at)                  // update timer
    addiu   v0, r0, 0                       // don't destroy this item
    OS.routine_end(0x20)
}

scope _animate_held_saturn: {
    lw      at, 0x0084(a0)
    lw      t0, 0x02C0(at)                  // load timer
    sll     t0, t0, 30
    bnez    t0, _end
    lw      v0, 0x0074(a0)                  // v1 = position struct
    lw      v0, 0x0010(v0)                  // v1 = image struct
    lw      v0, 0x0080(v0)                  // v1 = image struct
    lh      at, 0x0080(v0)                  // get current image index
    addiu   t0, r0, 4
    beql    at, t0, _update_image
    lli     at, 5                           // image index 1...
    lli     at, 4                           // ...or image index 2

    _update_image:
    sh      at, 0x0080(v0)                  // set image index
    _end:
    jr      ra
    nop
}

// @ Description
scope throw_initial_: {
    addiu   sp, sp, -0x28
    sw      ra, 0x0014(sp)
    sw      a0, 0x001C(sp)

    lw      v1, 0x0084(a0)
    addiu   at, r0, 1
    //sw      at, 0x0248(v1)                  // enable hurtbox

    li      a1, item_state_table
    jal     0x80172EC8                      // change item state
    addiu   a2, r0, 0x0003                  // state = 3(thrown)

    // update x scale
    jal     _update_x_scale
    lw      a0, 0x001C(sp)

    lw      ra, 0x0014(sp)
    jr      ra
    addiu   sp, sp, 0x28
}

// @ Description
scope reflected_initial_: {
    addiu   sp, sp, -0x30
    sw      ra, 0x0014(sp)
    sw      a0, 0x0018(sp)
	lw		v1, 0x0084(a0)			        // v1 = item special struct
    lli     at, THROW_TIMER                 // ~
    sw      at, 0x01CC(v1)                  // store THROW_TIMER
    li      a1, item_state_table
    lw      a0, 0x0018(sp)
    jal     0x80172EC8                      // change item state
    addiu   a2, r0, 0x0003                  // state = 3(thrown)
    lw      a0, 0x0018(sp)                  // ~
    lw      t6, 0x0084(a0)                  // t6 = item special struct
    lw      ra, 0x0014 (sp)
    jr      ra
    addiu   sp, sp, 0x30
}

// @ Description
// initial routine for falling state
scope falling_initial_: {
    addiu   sp, sp, -0x30
    sw      ra, 0x0014(sp)
    lw      v1, 0x0084(a0)                  // v1 = item special struct
    sw      r0, 0x010C(v1)                  // disable hitbox

    // don't randomly despawn
    lbu     t7, 0x02CE(v1)                  // load bitmask
    andi    t8, t7, 0xFFFD                  // modify bitmask with flag
    sb      t8, 0x02CE(v1)                  // write bitmask

    lli     at, 0x5674                      // some large amount
    sh      at, 0x02D2(v1)                  // set ground timer so it disappears quickly
    sw      r0, 0x0248(v1)                  // disable hurtbox

    li      a1, item_state_table
    jal     0x80172EC8                      // change item state
    addiu   a2, r0, 0x0004                  // state = 4(falling)
    lw      ra, 0x0014(sp)
    jr      ra
    addiu   sp, sp, 0x30
}

// @ Description
// Main function for the thrown state.
scope thrown_main_: {
	addiu	sp, sp, -0x30                   // allocate stack space
	sw   	ra, 0x0014(sp)                  // store ra
    sw   	a0, 0x0018(sp)                  // store a0

    // rotation
    jal  	0x801713f4                      // apply rotation
    lw   	a0, 0x0018(sp)                  // a0 = item object

    lw   	a0, 0x0018(sp)                  // a0 = item object
    lw      v0, 0x0084(a0)                  // v0 = item special struct
    lw      t0, 0x01CC(v0)                  // t0 = THROW_TIMER

    // update thrown time
    addiu   t0, t0,-0x0001                  // decrement THROW_TIMER
    sw      t0, 0x01CC(v0)                  // store updated THROW_TIMER

    // apply movement
    li      a1, GRAVITY
    addiu   a0, v0, 0                       // a0 = item struct
    jal     0x80172558                      // calcuate gravity
    lui     a2, THROWN_SPEED
    jal     0x801713f4                      // apply movement
    lw      a0, 0x0018 (sp)

    _end:
	lw   	ra, 0x0014(sp)                  // load ra
	addiu	sp, sp, 0x30                    // deallocate stack space
	jr   	ra                              // return
	or   	v0, r0, r0                      // return 0 (don't destroy)
}

// @ Description
// changes to slowing state and sets hitbox refresh timer
scope throw_collide_: {
    addiu   sp, sp, -0x20                   // allocate stackspace
    sw      ra, 0x0014(sp)                  // save return address
    lw      v0, 0x0084(a0)                  // v0 = item special struct
    lui     at, HIT_MULTIPLIER              // ~
    mtc1    at, f2                          // f2 = HIT_MULTIPLIER
    lwc1    f4, 0x002C(v0)                  // f4 = x velocity
    //lwc1    f6, 0x0030(v0)                  // f6 = y velocity
    mul.s   f4, f4, f2                      // f4 = x velocity * HIT_MULTIPLIER
    //mul.s   f6, f6, f2                      // f6 = y velocity * HIT_MULTIPLIER
    lui     at, HIT_Y_VELOCITY
    swc1    f4, 0x002C(v0)                  // store updated x velocity
    jal     falling_initial_                   // begin slowing down
    sw      at, 0x0030(v0)                  // store updated y velocity

    _end:
    jal     Global.get_random_int_          // random int
    addiu   a0, r0, 3                       // 3 possible combinations
    jal     0x800269C0                      // play FGM
    addiu   a0, v0, 0x5FD                   // a0 = mr saturn FGM + 0, 1 or 2

    lw      ra, 0x0014(sp)
    addiu   sp, sp, 0x20
    jr      ra
    or      v0, r0, r0				        // don't destroy
}

// @ Description
// changes to slowing state and sets hitbox refresh timer
scope throw_collide_hitbox_: {
    addiu   sp, sp, -0x20                   // allocate stackspace
    sw      ra, 0x0014(sp)                  // save return address
    lw      v0, 0x0084(a0)                  // v0 = item special struct
    lui     at, HIT_MULTIPLIER              // ~
    mtc1    at, f2                          // f2 = HIT_MULTIPLIER
    lwc1    f4, 0x002C(v0)                  // f4 = x velocity
    //lwc1    f6, 0x0030(v0)                  // f6 = y velocity
    mul.s   f4, f4, f2                      // f4 = x velocity * HIT_MULTIPLIER
    //mul.s   f6, f6, f2                      // f6 = y velocity * HIT_MULTIPLIER
    lui     at, HIT_Y_VELOCITY
    swc1    f4, 0x002C(v0)                  // store updated x velocity

    sw      r0, 0x0248(v0)                  // disable hurtbox

    jal     falling_initial_                   // begin slowing down
    sw      at, 0x0030(v0)                  // store updated y velocity

    _end:
    lw      ra, 0x0014(sp)
    addiu   sp, sp, 0x20
    jr      ra
    or      v0, r0, r0				        // don't destroy
}


// @ Description
// Collision detection subroutine for boomerang.
scope detect_collision_: {
    // Copy beginning of subroutine 0x801737B8
    OS.copy_segment(0xEE0F4, 0x88)
    beql    v0, r0, _end                    // modify branch
    lhu     t5, 0x0056(s0)                  // ~
    jal     0x800DD59C                      // ~
    or      a0, s0, r0                      // ~
    lhu     t0, 0x005A(s0)                  // ~
    lhu     t5, 0x0056(s0)                  // original logic
    // Remove ground collision lines
    // Copy end of subroutine
    _end:
    OS.copy_segment(0xEE1CC, 0x2C)
}

// @ Description
// Reflect subroutine for shuriken
scope reflect_: {
    addiu   sp, sp, -0x20                   // allocate stackspace
    sw      ra, 0x0014(sp)                  // save return address

    jal     0x80173434                      // generic reflect routine
    sw		a0, 0x0018(sp)			        // save item object
    jal     reflected_initial_              // change item state
    lw      a0, 0x0018(sp)                  // a0 = item object

    lw      ra, 0x0014(sp)                  // load ra
    addiu   sp, sp, 0x20                    // deallocate stack space
    jr      ra                              // return
    or      v0, r0, r0                      // don't destroy
}

// @ Description
// I don't think this routine will run since the drop routine is based on toma
scope prepickup_: {
    addiu   sp, sp, -0x18
    sw      ra, 0x0014 (sp)
    jal     0x80177218                  // subroutine disables hurtbox
    sw      a0, 0x0018(sp)              // store a0

    li      a1, item_state_table        // a1 = state table
    lw      a0, 0x0018(sp)              // original line - idk why it loads a0 when it hasn't changed

    jal     0x80172ec8                  // change item state
    addiu   a2, r0, 0x0002              // state = 2 (picked up)

    lw      ra, 0x0014 (sp)
    jr      ra
    addiu   sp, sp, 0x18
}

// @ Description
// Main item pickup routine
scope pickup_: {
    // a0 = player struct
    // a2 = item object
    // Continue after damage restore routine in tomato/heart pickup routine
    sw      a2, 0x0018(sp)              // save a2 to where the rest of the routine expects it
    j       0x80145C4C
    sw      a3, 0x001C(sp)              // save a3 to where the rest of the routine expects it
}