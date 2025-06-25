// @ Description
// These constants must be defined for an item.
constant SPAWN_ITEM(stage_setting_)
constant SHOW_GFX_WHEN_SPAWNED(OS.TRUE)
constant PICKUP_ITEM_MAIN(0)
constant PICKUP_ITEM_INIT(0)
constant DROP_ITEM(0)
constant THROW_ITEM(0)
constant PLAYER_COLLISION(0)

// edit these as needed
constant ANIM_FRAMES(20)                // timer setting for changing texture
constant ANIM_SPEED_DIVISOR(0x4040)     // 4
constant BKB(25)                        // base knockback
constant KBG(100)                       // knockback growth
constant KB_ANGLE(361)                  // sakurai angle
constant DAMAGE_TYPE(1)                 // damage type
constant THROW_TIMER(50)                // x frames before ending (unused)
constant BARREL_TIMER(90)               // x frames before shooting from barrel
constant RESPAWN_TIMER(60)              // x frames to wait before respawning the ball
constant INVINCIBILITY_TIMER(90)        // x frames before vulnerable after spawning
constant BARREL_SPEED(0xC334)           // speed at which the ball shoots out of barrel
constant HIT_MULTIPLIER(0xBF59)         // deceleration multiplier to use on collision
constant GRAVITY(0x3FD33333)            // 1.65
constant MAX_SPEED(0x4387)              // 280
constant FALL_SPEED(0xC2B4)             // -90
constant FIRE_BEGIN_THRESHOLD(0x42F0)   // 120
constant FIRE_END_THRESHOLD(0x4248)     // 50
// constant HIT_FGM(0x0120)                // thud
constant HIT_FGM(37)                    // large punch sound
constant GROUND_TIMER(0x030C)
constant SHIELD_DAMAGE(30)              // 30 = amount needed to shield break with max throw and Peach's dash attack

constant FILE_OFFSET(0x1170)

constant ITEM_INFO_ARRAY_ORIGIN(origin())
item_info_array:
dw 0                                    // 0x00 - item ID
dw 0x8018D040                           // 0x04 - address of file pointer
dw FILE_OFFSET                          // 0x08 - offset to item footer
dw 0x1B000000                           // 0x0C - ? either 0x1B000000 or 0x1C000000 - possible argument
dw 0                                    // 0x10 - ?

// @ Description
// Item state table
item_state_table:
// STATE 0 - MAIN
dw main_                                // 0x14 - main
dw collision_                           // 0x18 - collision
dw collide_                             // 0x1C - hitbox collision w/ hurtbox
dw collide_                             // 0x20 - hitbox collision w/ shield
dw collide_                             // 0x24 - hitbox collision w/ shield edge
dw 0                                    // 0x28 - clang?
dw 0x80173434                           // 0x2C - hitbox collision w/ reflector
dw collide_hitbox_                      // 0x30 - hurtbox collision w/ hitbox

// STATE 1 - IN BARREL
dw barrel_main_                         // 0xA0 - main
dw 0                                    // 0xA4 - collision
dw 0                                    // 0xA8 - hitbox collision w/ hurtbox
dw 0                                    // 0xAC - hitbox collision w/ shield
dw 0                                    // 0xB0 - hitbox collision w/ shield edge
dw 0                                    // 0xB4 - clang?
dw 0                                    // 0xB8 - hitbox collision w/ reflector
dw 0                                    // 0xBC - hurtbox collision w/ hitbox

// STATE 1 - RESPAWNING
dw respawn_main_                        // 0xA0 - main
dw 0                                    // 0xA4 - collision
dw 0                                    // 0xA8 - hitbox collision w/ hurtbox
dw 0                                    // 0xAC - hitbox collision w/ shield
dw 0                                    // 0xB0 - hitbox collision w/ shield edge
dw 0                                    // 0xB4 - clang?
dw 0                                    // 0xB8 - hitbox collision w/ reflector
dw 0                                    // 0xBC - hurtbox collision w/ hitbox

scope basketball_attributes {
    constant DURATION(0x0000)
    constant GRAVITY(0x0004)
    constant MAX_SPEED(0x0008)
    constant BOUNCE(0x000C)
    constant ANGLE(0x0010)
    constant ROTATION(0x0014)
    struct:
    dw 150                                  // 0x0000 - duration (int)
    float32 1.5                             // 0x0004 - gravity
    float32 250                             // 0x0008 - max speed
    float32 0.85                            // 0x000C - bounce multiplier
    float32 0.85                            // 0x0010 - angle
    float32 0.003                           // 0x0014 - rotation speed
}

// @ Description
// Subroutine which sets up initial properties of the basketball.
// a1 - item info array
// a2 - x/y/z coordinates to create item at
// a3 - unknown x/y/z offset
scope stage_setting_: {
    addiu   sp, sp, -0x80                   // allocate stackspace
    sw      a2, 0x0050(sp)                  // save a previous sp value to sp
    sw      s0, 0x0020(sp)                  // save s0
    or      a2, a1, r0                      // a2 = a1(?)
    sw      a1, 0x004c(sp)                  // save a1(?)
    or      s0, a3, r0                      // s0 = a3 (boolean ?)
    sw      ra, 0x0024(sp)                  // save ra

    li      a1, item_info_array             // a1 = items info array
    lw      a3, 0x0050(sp)                  // a3 = unknown sp pointer
    jal     0x8016E174                      // spawn item
    sw      s0, 0x0010(sp)                  // save boolean(?) to sp
    beqz    v0, _end                        // skip if no item was spawned

    or      a3, v0, r0                      // a3 = item object
    sw      r0, 0x0040(v0)                  // set scored hoop to not set
    sw      r0, 0x0044(v0)                  // set owner damage timer to 0
    sw      r0, 0x0048(v0)                  // set barrel object to null
    lli     t1, OS.TRUE
    sw      t1, 0x0050(v0)                  // set above rim flag to TRUE
    sw      t1, 0x0068(v0)                  // set scoreable to TRUE
    lli     t1, ANIM_FRAMES
    sw      t1, 0x0054(v0)                  // set animation timer
    OS.read_word(Smashketball.type, t6)     // t6 = 0 if basketball, 1 if soccer
    sw      t6, 0x0058(v0)                  // set is_soccer flag
    OS.read_word(Smashketball.spawn_golden, t7) // t7 = 1 if soccer ball should spawn golden
    sw      t7, 0x005C(v0)                  // set is_golden flag
    lw      v0, 0x0074(v0)                  // load item position struct
    lw      t1, 0x001C(v0)                  // t1 = current x
    sw      t1, 0x0060(a3)                  // initialize previous x
    lw      t1, 0x0020(v0)                  // t1 = current y
    sw      t1, 0x0064(a3)                  // initialize previous x

    lw      a0, 0x0074(a3)                  // a0 = item first joint (joint 0)
    lw      t0, 0x0080(a0)                  // get image footer struct
    lli     t1, 0x0000                      // t1 = image index if basketball
    bnezl   t6, pc() + 8                    // if soccer, use soccer image index
    lli     t1, 0x0005                      // t1 = image index if soccer
    sh      t1, 0x0080(t0)                  // set image index

    // change palette if soccer
    lw      t1, 0x0050(a0)                  // t1 = display list
    addiu   t2, t1, -0x0150                 // t2 = soccer palette address
    bnezl   t7, pc() + 8                    // if golden, use golden palette
    addiu   t2, t1, -0x0120                 // t2 = palette address
    bnezl   t6, pc() + 8                    // if soccer, use soccer palette
    sw      t2, 0x005C(t1)                  // set soccer palette

    // rendering stuff
    addiu   t6, sp, 0x0030                  // t6 = sp + 0x30
    or      a0, a3, r0
    addiu   v1, v0, 0x001C                  // v1 = substruct in position struct
    lw      t8, 0x0000(v1)                  // load ? from substruct
    sw      t8, 0x0000(t6)                  // save value
    lw      t7, 0x0004(v1)                  // load ? from substruct
    sw      t7, 0x0004(t6)                  // save value
    lw      t8, 0x0008(v1)                  // load render/view matrix ptr?
    sw      t8, 0x0008(t6)                  // save value

    lw      s0, 0x0084(a3)                  // s0 = item struct
    sh      r0, 0x033e(s0)                  // set flag used for bomb to 0
    sw      a3, 0x0044(sp)
    sw      v1, 0x002c(sp)                  // save substruct address
    jal     0x8017279C                      // unknown. Used with bob-omb and bumper
    sw      v0, 0x0040(sp)
    lw      a0, 0x0040(sp)
    addiu   a1, r0, 0x002E                  // argument 1 = render routine index?
    jal     0x80008CC0                      // apply render routine
    or      a2, r0, r0                      // argument 2 = 0

    addiu   t0, sp, 0x0030                  // this seems related to rendering
    lw      t2, 0x0000(t0)                  // load ? from substruct
    lw      t9, 0x002C(sp)                  // save
    mtc1    r0, f4
    or      a0, s0, r0
    sw      t2, 0x0000(t9)
    lw      t1, 0x0004(t0)                  // load ? from substruct
    sw      t1, 0x0004(t9)                  // save value
    lw      t2, 0x0008(t0)                  // load ? from substruct
    sw      t2, 0x0008(t9)                  // save value

    sw      r0, 0x0248(s0)                  // disable hurtbox
    sw      r0, 0x010C(s0)                  // disable hitbox
    //disable clang
    lh      at, 0x0158(s0)                  // t0 = clang bitfield
    andi    at, at, 0x7FFF                  // ~
    sh      at, 0x0158(s0)                  // disable clang
    lli     at, INVINCIBILITY_TIMER         // ~
    sw      at, 0x01CC(s0)                  // initialize invincibility timer
    sw      r0, 0x01D0(s0)                  // hitbox refresh timer = 0
    sw      r0, 0x01D4(s0)                  // fire state flag = FALSE
    sw      r0, 0x01D8(s0)                  // gfx timer = 0
    sw      r0, 0x01DC(s0)                  // bounce x_offset = 0
    sw      r0, 0x01E0(s0)                  // bounce y_offset = 0
    sw      r0, 0x01E4(s0)                  // bounce scaling flag = FALSE
    sw      r0, 0x01E8(s0)                  // respawn flag = FALSE
    sw      r0, 0x01EC(s0)                  // percent = 0
    sw      r0, 0x01F0(s0)                  // percent timer = 0
    sw      r0, 0x01F4(s0)                  // cooldown timer = 0
    li      t0, set_golden_
    sw      t0, 0x0398(s0)                  // save routine to part of item special struct that carries unique blast wall destruction routines
    sh      r0, 0x033E(s0)                  // set flag used for bomb to 0
    lli     at, KBG                         // at = kb growth
    sw      at, 0x0140(s0)                  // overwrite
    lli     at, BKB                         // at = base knockback
    sw      at, 0x0148(s0)                  // overwrite
    lli     at, KB_ANGLE                    // at = knockback angle
    sw      at, 0x013C(s0)                  // overwrite
    addiu   v0, r0, HIT_FGM                 // v0 = HIT FGM
    sh      v0, 0x156(s0)                   // save fgm value
    lli     at, SHIELD_DAMAGE
    sw      at, 0x014C(s0)                  // overwrite shield damage
    lli     at, 4                           // at = base damage
    sw      at, 0x0110(s0)                  // overwrite base damage
    lli     at, DAMAGE_TYPE                 // at = damage type
    sw      at, 0x011C(s0)                  // overwrite damage type
    sw      s0, 0x002C(sp)

    sw      r0, 0x02C0(s0)                  // set timer to 0


    _continue:
    lbu     t4, 0x02d3(s0)                  // original code here
    ori     t5, t4, 0x0004
    sb      t5, 0x02d3(s0)
    lw      t6, 0x0040(sp)
    addiu   a0, s0, 0
    jal     0x80111EC0                      // Common subroutine seems to be used for items
    swc1    f4, 0x0038(t6)
    sw      v0, 0x0348(s0)
    FGM.play(0x430)                         // play buzzer sound
    lw      a3, 0x0044(sp)

    _end:
    lw      ra, 0x0024(sp)
    lw      s0, 0x0020(sp)
    addiu   sp, sp, 0x80
    jr      ra
    or      v0, a3, r0
}

// @ Description
// Main function for the thrown state.
scope main_: {
    addiu   sp, sp, -0x30                   // allocate stack space
    sw      ra, 0x0014(sp)                  // store ra
    sw      a0, 0x0018(sp)                  // store a0

    lw      v0, 0x0084(a0)                  // v0 = item special struct
    lw      at, 0x01E4(v0)                  // at = bounce scaling flag
    beqz    at, _continue                   // skip if bounce scaling flag = FALSE
    lw      t0, 0x0074(a0)                  // t0 = item first joint struct

    // if the bounce scaling flag was enabled, we need to reset the scale and x/y positions now that the item is being updated again
    sw      r0, 0x01E4(v0)                  // bounce scaling flag = FALSE
    lui     at, 0x3F80                      // ~
    sw      at, 0x0040(t0)                  // x_scale = 1
    sw      at, 0x0044(t0)                  // y_scale = 1
    lwc1    f2, 0x01DC(v0)                  // f2 = bounce x_offset
    lwc1    f4, 0x001C(t0)                  // ~
    sub.s   f4, f4, f2                      // ~
    swc1    f4, 0x001C(t0)                  // update x position to undo x_offset
    lwc1    f2, 0x01E0(v0)                  // f2 = bounce y_offset
    lwc1    f4, 0x0020(t0)                  // ~
    sub.s   f4, f4, f2                      // ~
    swc1    f4, 0x0020(t0)                  // update y position to undo y_offset
    sw      r0, 0x01DC(v0)                  // ~
    sw      r0, 0x01E0(v0)                  // reset x_offset and y_offset

    _continue:
    lw      at, 0x0108(v0)                  // at = kinetic state
    bnez    at, _aerial                     // branch if kinetic state != grounded
    nop

    _grounded:
    sw      r0, 0x0030(v0)                  // y speed = 0
    lwc1    f0, 0x002C(v0)                  // f0 = x speed
    lui     t0, 0x3F78                      // ~
    mtc1    t0, f2                          // f2 = 0.96875
    mul.s   f0, f0, f2                      // f0 = x speed * 0.96875
    swc1    f0, 0x002C(v0)                  // update x speed
    abs.s   f0, f0                          // f0 = absolute x speed
    lui     t0, 0x4000                      // ~
    mtc1    t0, f2                          // f2 = minimum x speed
    c.lt.s  f0, f2                          // ~
    nop                                     // ~
    bc1fl   _animate                        // branch if abs x speed > minimum x speed
    nop
    sw      r0, 0x01EC(v0)                  // percent = 0
    b       _timers                         // skip animating
    sw      r0, 0x002C(v0)                  // x speed = 0


    _aerial:
    // check barrel collision
    jal     check_basketball_barrel_collision_
    nop

    // rotation
    jal     0x801713f4                      // apply rotation
    lw      a0, 0x0018(sp)                  // a0 = item object

    lw      a0, 0x0018(sp)                  // a0 = item object
    lw      v0, 0x0084(a0)                  // v0 = item special struct
    // lw      t0, 0x01CC(v0)                  // t0 = THROW_TIMER

    // // update thrown time
    // addiu   t0, t0,-0x0001                  // decrement THROW_TIMER
    // sw      t0, 0x01CC(v0)                  // store updated THROW_TIMER

    // apply movement
    lui     at, FALL_SPEED                  // ~
    mtc1    at, f2                          // f2 = fall speed
    lwc1    f4, 0x0030(v0)                  // f4 = y velocity
    c.le.s  f2, f4                          // check if y velocity < fall speed
    li      a1, GRAVITY                     // a1 = GRAVITY
    bc1fl   pc() + 8                        // if y velocity < fall speed...
    or      a1, r0, r0                      // override gravity with 0

    addiu   a0, v0, 0                       // a0 = item struct
    jal     0x80172558                      // calcuate gravity
    lui     a2, MAX_SPEED
    jal     0x801713f4                      // apply movement
    lw      a0, 0x0018 (sp)

    _animate:
    lw      a0, 0x0018(sp)                  // a0 = item
    lw      t0, 0x0054(a0)                  // t0 = anim timer
    lw      v0, 0x0084(a0)                  // v0 = item special struct
    lwc1    f0, 0x002C(v0)                  // f0 = x speed
    lwc1    f2, 0x0030(v0)                  // f0 = y speed
    mul.s   f4, f0, f0                      // f4 = x speed * x speed
    mul.s   f2, f2, f2                      // f2 = y speed * y speed
    add.s   f2, f4, f2                      // f2 = x^2 + y^2
    sqrt.s  f2, f2                          // f2 = speed
    lui     t1, ANIM_SPEED_DIVISOR
    mtc1    t1, f4                          // f4 = ANIM_SPEED_DIVISOR
    div.s   f2, f2, f4                      // f2 = x speed / ANIM_SPEED_DIVISOR
    trunc.w.s f2, f2                        // f2 = frames to deduct - 1
    mfc1    t1, f2                          // t1 = frames to deduct - 1
    addiu   t1, t1, 0x0001                  // t1 = frames to deduct
    subu    t0, t0, t1                      // t0 = next timer value
    bgtz    t0, _timers                     // if end of timer not reached, skip
    sw      t0, 0x0054(a0)                  // update timer

    lli     t0, ANIM_FRAMES
    sw      t0, 0x0054(a0)                  // reset timer

    lw      v0, 0x0074(a0)                  // v1 = position struct
    lw      v0, 0x0080(v0)                  // v1 = image struct
    lh      at, 0x0080(v0)                  // at = current image index

    lw      t2, 0x0058(a0)                  // t2 = type = 0 if basketball, 1 if soccer
    bnezl   t2, pc() + 8                    // if soccer, adjust index
    addiu   at, at, -0x0005                 // at = current image index, adjusted

    addi    t1, r0, -0x0001                 // t1 = -1
    mtc1    r0, f2                          // f2 = 0
    c.lt.s  f0, f2                          // check if x speed < 0
    nop
    bc1tl   pc() + 8                        // if x speed < 0, rotate backwards
    lli     t1, 0x0001                      // t1 = 1
    add     t0, at, t1                      // t0 = next image struct
    slti    at, t0, 0x0005                  // at = 0 if past max image index
    beqzl   at, pc() + 8                    // if past max index, set to 0
    lli     t0, 0x0000                      // t0 = 0
    bltzl   t0, pc() + 8                    // if below 0, set to max index
    lli     t0, 0x0004                      // t0 = 4

    bnezl   t2, pc() + 8                    // if soccer, adjust index
    addiu   t0, t0, 0x0005                  // t0 = current image index, adjusted

    sh      t0, 0x0080(v0)                  // set image index

    _timers:
    lw      a0, 0x0018(sp)                  // a0 = item
    lw      v0, 0x0084(a0)                  // v0 = item special struct

    lw      t0, 0x0044(a0)                  // t0 = owner damage timer
    bnezl   t0, pc() + 8                    // if not 0, decrement
    addiu   t0, t0, -0x0001                 // t0 = next timer value
    sw      t0, 0x0044(a0)                  // set owner damage timer

    lw      t0, 0x01CC(v0)                  // t0 = barrel refresh/invincibility timer
    bnezl   t0, pc() + 8                    // if not 0, decrement
    addiu   t0, t0, -0x0001                 // t0 = next timer value
    sw      t0, 0x01CC(v0)                  // update timer value

    lw      t0, 0x01F4(v0)                  // t0 = cooldown timer
    bnezl   t0, pc() + 8                    // if not 0, decrement
    addiu   t0, t0, -0x0001                 // t0 = next timer value
    sw      t0, 0x01F4(v0)                  // update timer value

    lw      t0, 0x01F0(v0)                  // t0 = percent timer
    bnezl   t0, pc() + 8                    // if not 0, decrement
    addiu   t0, t0, -0x0001                 // t0 = next timer value
    bnez    t0, _hitbox_refresh             // skip if percent timer is active
    sw      t0, 0x01F0(v0)                  // update timer value

    lwc1    f2, 0x002C(v0)                  // f2 = x velocity
    lwc1    f4, 0x0030(v0)                  // f4 = y velocity
    mul.s   f6, f2, f2                      // f6 = x velocity squared
    mul.s   f8, f4, f4                      // f8 = y velocity squared
    add.s   f6, f6, f8                      // f6 = x velocity squared + y velocity squared
    sqrt.s  f8, f6                          // f8 = absolute velocity
    lui     at, 0x4248                      // ~
    mtc1    at, f2                          // f2 = 50
    c.le.s  f8, f2                          // check if velocity is below 50
    nop
    bc1f    _hitbox_refresh                 // skip if speed is above 50
    lw      t0, 0x01EC(v0)                  // t0 = percent
    // if speed is below 30, lose % every frame
    bnezl   t0, pc() + 8                    // if not 0, decrement
    addiu   t0, t0, -0x0001                 // t0 = next timer value
    sw      t0, 0x01EC(v0)                  // lose % while grounded

    _hitbox_refresh:
    lw      t0, 0x01D0(v0)                  // t0 = hitbox refresh timer
    bnezl   t0, pc() + 8                    // if not 0, decrement
    addiu   t0, t0, -0x0001                 // t0 = next timer value
    bnez    t0, _handle_fire                // if not zero, don't refresh
    sw      t0, 0x01D0(v0)                  // update timer value
    sw      r0, 0x0224(v0)                  // reset hit object pointer 1
    sw      r0, 0x022C(v0)                  // reset hit object pointer 2
    sw      r0, 0x0234(v0)                  // reset hit object pointer 3
    sw      r0, 0x023C(v0)                  // reset hit object pointer 4

    _handle_fire:
    jal     fire_state_manager_             // do the thing
    lw      a0, 0x0018(sp)                  // a0 = item object

    _handle_invincibility:
    lw      a0, 0x0018(sp)                  // a0 = item object
    lw      v0, 0x0084(a0)                  // v0 = item special struct
    lw      t0, 0x0248(v0)                  // t0 = hurtbox state
    bnez    t0, _check_fall                 // skip if hurtbox is enabled
    lw      t0, 0x01CC(v0)                  // t0 = invincibility timer
    lli     at, INVINCIBILITY_TIMER - 5     // ~
    beq     at, t0, _begin_flash            // begin invincibility flash after 5 frames
    lli     at, 0x1                         // ~
    bne     at, t0, _check_fall             // end invincibility on last frame of timer
    nop

    _end_invincibility:
    jal     0x80172FBC                      // itMainClearColAnim
    sw      at, 0x0248(v0)                  // enable hurtbox
    b       _check_fall                     // skip
    nop

    _begin_flash:
    lli     a1, 0x000A                      // a1 = 0xA = respawn invincibility routine
    jal     0x80172F98                      // itMainCheckSetColAnimID
    or      a2, r0, r0                      // a2 = duration = 0

    _check_fall:
    jal     check_basketball_fall_
    lw      a0, 0x0018(sp)                  // a0 = item object

    _check_scored:
    jal     check_basketball_scored_
    lw      a0, 0x0018(sp)                  // a0 = item object

    _end:
    lw      ra, 0x0014(sp)                  // load ra
    lw      a0, 0x0018(sp)                  // a0 = item object

    lw      t0, 0x0074(a0)                  // t0 = position struct
    lw      t1, 0x001C(t0)                  // t1 = current x
    sw      t1, 0x0060(a0)                  // update previous x
    lw      t1, 0x0020(t0)                  // t1 = current y
    sw      t1, 0x0064(a0)                  // update previous y

    addiu   sp, sp, 0x30                    // deallocate stack space
    jr      ra                              // return
    or      v0, r0, r0                      // return 0 (don't destroy)
}

// @ Description
// set the ball to grounded
// a0 - item object
scope set_grounded_: {
    addiu   sp, sp, -0x30                   // allocate stack space
    sw      ra, 0x0014(sp)                  // store ra
    lw      t0, 0x0084(a0)                  // t0 = item special struct
    sw      r0, 0x0108(t0)                  // kinetic state = grounded
    li      a1, item_state_table
    jal     0x80172EC8                      // change item state
    lli     a2, 0x0000                      // state = 0 (main)

    _end:
    lw      ra, 0x0014(sp)                  // load ra
    jr      ra                              // return
    addiu   sp, sp, 0x30                    // deallocate stack space
}

// @ Description
// set the ball to aerial
// a0 - item object
scope set_aerial_: {
    addiu   sp, sp, -0x30                   // allocate stack space
    sw      ra, 0x0014(sp)                  // store ra
    lw      t0, 0x0084(a0)                  // t0 = item special struct
    lli     at, 0x0001                      // ~
    sw      at, 0x0108(t0)                  // kinetic state = aerial
    li      a1, item_state_table
    jal     0x80172EC8                      // change item state
    lli     a2, 0x0000                      // state = 0 (main)

    _end:
    lw      ra, 0x0014(sp)                  // load ra
    jr      ra                              // return
    addiu   sp, sp, 0x30                    // deallocate stack space
}

// @ Description
// activates and de-activates the ball's "fire" state and hitbox, spawns fire particles
scope fire_state_manager_: {
    addiu   sp, sp, -0x30                   // allocate stack space
    sw      ra, 0x0014(sp)                  // store ra
    sw      s0, 0x0018(sp)                  // store s0

    lw      s0, 0x0084(a0)                  // s0 = item special struct
    lwc1    f2, 0x002C(s0)                  // f2 = x velocity
    lwc1    f4, 0x0030(s0)                  // f4 = y velocity
    mul.s   f6, f2, f2                      // f6 = x velocity squared
    mul.s   f8, f4, f4                      // f8 = y velocity squared
    add.s   f6, f6, f8                      // f6 = x velocity squared + y velocity squared
    sqrt.s  f4, f6                          // f4 = absolute velocity
    swc1    f4, 0x001C(sp)                  // 0x001C(sp) = absolute velocity
    lw      at, 0x01F4(s0)                  // at = cooldown timer
    bnez    at, _end                        // skip if cooldown timer is active
    lw      at, 0x01D4(s0)                  // at = fire state flag

    _check_enable:
    bnez    at, _check_disable              // skip if fire state flag = TRUE
    lui     at, FIRE_BEGIN_THRESHOLD
    mtc1    at, f2                          // f2 = velocity threshold
    c.le.s  f2, f4                          // check if velocity is above threshold
    nop
    bc1fl   _smoke_gfx                      // skip if speed is under threshold
    nop

    _begin_fire:
    FGM.play(25)
    FGM.play(183)
    lw      a0, 0x0004(s0)                  // a0 = item object
    lli     a1, GFXRoutine.id.BALL_FIRE     // a1 = id.BALL_FIRE
    jal     0x80172F98                      // itMainCheckSetColAnimID
    or      a2, r0, r0                      // a2 = duration = 0
    sw      r0, 0x01D8(s0)                  // gfx timer = 0
    lli     at, OS.TRUE                     // ~
    sw      at, 0x010C(s0)                  // enable hitbox
    b       _fire_gfx                       // create fire gfx
    sw      at, 0x01D4(s0)                  // fire state flag = TRUE

    _check_disable:
    lui     at, FIRE_END_THRESHOLD
    mtc1    at, f2                          // f2 = velocity threshold
    c.le.s  f4, f2                          // check if velocity is at or below threshold
    nop
    bc1fl   _fire_gfx                       // branch if speed is above threshold
    nop

    _end_fire:
    FGM.play(275)
    lw      a0, 0x0004(s0)                  // a0 = item object
    lli     a1, GFXRoutine.id.BALL_SMOKE    // a1 = id.BALL_SMOKE
    jal     0x80172F98                      // itMainCheckSetColAnimID
    or      a2, r0, r0                      // a2 = duration = 0
    lli     at, 000060                      // ~
    sw      at, 0x01D8(s0)                  // gfx timer = 60
    sw      r0, 0x010C(s0)                  // disable hitbox
    lwc1    f2, 0x01EC(s0)                  // ~
    cvt.s.w f2, f2                          // f2 = percent
    lui     at, 0x3F00                      // ~
    mtc1    at, f4                          // ~
    mul.s   f2, f2, f4                      // f4 = percent * 0.5
    cvt.w.s f2, f2                          // ~
    swc1    f2, 0x01EC(s0)                  // store updated percent
    b       _smoke_gfx                      // create smoke gfx
    sw      r0, 0x01D4(s0)                  // fire state flag = FALSE

    _fire_gfx:
    lw      t0, 0x01D8(s0)                  // t0 = gfx timer
    addiu   t1, t0, 0x0001                  // t1 = gfx timer, incremented
    andi    t0, t0, 0x0001                  // ~
    bnez    t0, _adjust_hitbox              // every 2nd frame, skip creating GFX
    sw      t1, 0x01D8(s0)                  // store updated gfx timer

    // create gfx
    lw      t0, 0x002C(s0)                  // t0 = x velocity
    bltz    t0, pc() + 12                   // if x velocity is negative...
    addiu   a1, r0, 0x0001                  // a1(gfx direction) = 1
    addiu   a1, r0, -0x0001                 // else, a1(gfx direction) = -1
    jal     0x800FE7B4                      // create fire gfx
    lw      a0, 0x0038(s0)                  // a0 = item x/y/z coordinates
    b       _adjust_hitbox                  // adjust hitbox
    nop

    _smoke_gfx:
    // basketball will smoke for a while after fire goes out
    lw      t0, 0x01D8(s0)                  // t0 = gfx timer
    beqz    t0, _end                        // skip if gfx timer = 0
    addiu   t1, t0,-0x0001                  // t1 = gfx timer, decremented
    andi    t0, t0, 0x0003                  // ~
    bnez    t0, _end                        // every 4th frame create GFX
    sw      t1, 0x01D8(s0)                  // store updated gfx timer

    // create gfx
    jal     0x800FE9B4                      // create smoke gfx
    lw      a0, 0x0038(s0)                  // a0 = item x/y/z coordinates
    b       _end                            // end
    nop

    _adjust_hitbox:
    lwc1    f4, 0x001C(sp)                  // f4 = absolute velocity
    lui     at, 0x3DCC                      // ~
    mtc1    at, f2                          // f2 = 0.1
    mul.s   f2, f2, f4                      // f2 = absolute velocity * 0.1
    lui     at, 0x4000                      // ~
    mtc1    at, f4                          // f4 = 2
    add.s   f2, f2, f4                      // f2 = 2 + (absolute velocity * 0.1)
    cvt.w.s f2, f2                          // convert to int
    swc1    f2, 0x0110(s0)                  // update damage
    lwc1    f14, 0x002C(s0)                 // ~
    abs.s   f14, f14                        // f14 = |x velocity|
    jal     0x8001863C                      // f0 = atan2(f12,f14)
    lwc1    f12, 0x0030(s0)                 // f12 = y velocity
    lui     at, 0x8013                      // ~
    lwc1    f2, 0xFE60(at)                  // f2 = π
    div.s   f4, f0, f2                      // f4 = atan2(x,y)/π
    lui     at, 0x4334                      // ~
    mtc1    at, f6                          // f6 = 180
    mul.s   f8, f4, f6                      // f8 = (atan2(x,y)/π) * 180
    trunc.w.s f10, f8                       // convert to int
    swc1    f10, 0x013C(s0)                 // update knockback angle

    _end:
    lw      ra, 0x0014(sp)                  // load ra
    lw      s0, 0x0018(sp)                  // load s0
    jr      ra                              // return
    addiu   sp, sp, 0x30                    // deallocate stack space
}

// @ Description
// changes to slowing state and sets hitbox refresh timer
scope collide_: {
    addiu   sp, sp, -0x30                   // allocate stackspace
    sw      ra, 0x0014(sp)                  // save return address
    sw      a0, 0x0018(sp)                  // 0x0018(sp) = player object
    lw      v0, 0x0084(a0)                  // v0 = item special struct
    lui     at, HIT_MULTIPLIER              // ~
    mtc1    at, f2                          // f2 = HIT_MULTIPLIER
    lwc1    f4, 0x002C(v0)                  // f4 = x velocity
    lwc1    f6, 0x0030(v0)                  // f6 = y velocity
    mul.s   f4, f4, f2                      // f4 = x velocity * HIT_MULTIPLIER
    mul.s   f6, f6, f2                      // f6 = y velocity * HIT_MULTIPLIER
    swc1    f4, 0x002C(v0)                  // store updated x velocity
    swc1    f6, 0x0030(v0)                  // store updated y velocity

    lli     t1, 000016                      // ~
    sw      t1, 0x01D0(v0)                  // set hitbox refresh timer to 16 frames

    _end:
    jal     set_aerial_                     // set aerial state
    nop
    lw      a0, 0x0018(sp)                  // ~
    lw      v0, 0x0084(a0)                  // v0 = item special struct
    lw      at, 0x01D4(v0)                  // at = fire state flag
    bnezl   at, pc() + 12                   // if fire state = TRUE...
    lli     a0, 0x42F                       // ...fgm = fire bounce
    lli     a0, 0x42E                       // else, fgm = default bounce
    jal     0x800269C0                      // play fgm
    nop
    lw      ra, 0x0014(sp)
    addiu   sp, sp, 0x30
    jr      ra
    or      v0, r0, r0                      // don't destroy
}

// @ Description
// Collision subroutine.
// a0 = item object
scope collision_: {
    addiu   sp, sp,-0x0058                  // allocate stack space
    sw      ra, 0x0014(sp)                  // ~
    sw      s0, 0x0040(sp)                  // ~
    sw      s1, 0x0044(sp)                  // store ra, s0, s1
    or      s0, a0, r0                      // s0 = item object
    li      s1, basketball_attributes.struct // s1 = basketball_attributes.struct

    lw      v0, 0x0084(s0)                  // v0 = item special struct
    lw      at, 0x0108(v0)                  // at = kinetic state
    bnez    at, _aerial                     // branch if kinetic state != grounded
    nop

    _grounded:
    li      a1, set_aerial_                 // a1 = set_aerial_
    jal     0x801735A0                      // generic resting collision?
    nop
    b       _end                            // skip to ending
    nop

    _aerial:
    lw      a0, 0x0084(s0)                  // ~
    addiu   a0, a0, 0x0038                  // a0 = x/y/z position
    li      a1, ConkerDSP.grenade_detect_collision_  // a1 = grenade_detect_collision_
    or      a2, s0, r0                      // a2 = item object
    jal     0x800DA034                      // collision detection
    ori     a3, r0, 0x0C21                  // bitmask (all collision types)
    sw      v0, 0x0028(sp)                  // store collision result
    or      a0, s0, r0                      // a0 = item object
    ori     a1, r0, 0x0C21                  // bitmask (all collision types)
    lw      v0, 0x0084(s0)                  // ~
    lw      at, 0x01D4(v0)                  // at = fire state flag
    bnezl   at, pc() + 12                   // if fire state = TRUE...
    lui     a2, 0x3F73                      // a2 = bounce multiplier of 0.95
    lw      a2, basketball_attributes.BOUNCE(s1) // else, a2 = default bounce multiplier
    jal     0x801737EC                      // apply collsion/bounce?
    or      a3, r0, r0                      // a3 = 0

    lw      t0, 0x0028(sp)                  // t0 = collision result
    beqz    t0, _end                        // branch if collision result = FALSE
    lw      t8, 0x0084(s0)                  // t8 = item special struct
    lhu     t0, 0x0092(t8)                  // t0 = collision flags
    andi    t0, t0, 0x0800                  // t0 = collision flags | grounded bitmask
    beqz    t0, _end                        // branch if ground collision flag = FALSE
    nop
    lwc1    f2, 0x0030(t8)                  // f2 = y speed
    mtc1    r0, f0                          // f0 = 0
    c.lt.s  f0, f2                          // ~
    nop                                     // ~
    bc1fl   _set_grounded                   // set grounded state if 0 > y speed
    nop
    abs.s   f0, f2                          // f0 = absolute y speed
    lui     t0, 0x40A0                      // ~
    mtc1    t0, f2                          // f2 = minimum y speed
    c.lt.s  f0, f2                          // ~
    nop                                     // ~
    bc1fl   _end                            // skip if abs y speed > minimum y speed
    nop

    _set_grounded:
    // if we're here, set the ball to its grounded state
    sw      r0, 0x0030(t8)                  // y speed = 0
    jal     set_grounded_                   // set grounded state
    or      a0, s0, r0                      // a0 = item object

    _end:
    lw      ra, 0x0014(sp)                  // ~
    lw      s0, 0x0040(sp)                  // ~
    lw      s1, 0x0044(sp)                  // load ra, s0, s1
    addiu   sp, sp, 0x0058                  // deallocate stack space
    jr      ra                              // return
    or      v0, r0, r0                      // return 0
}

// @ Description
// Handles hitbox collision for the basketball, causing it to be launched when hit by attacks
// a0 = item object
scope collide_hitbox_: {
    addiu   sp, sp,-0x0050                  // allocate stack space
    lw      v0, 0x0084(a0)                  // v0 = item special struct
    sw      ra, 0x0020(sp)                  // 0x0020(sp) = ra
    sw      a0, 0x0024(sp)                  // 0x0024(sp) = item object
    jal     set_aerial_                     // set aerial state
    sw      v0, 0x0028(sp)                  // 0x0028(sp) = item special struct

    // update item ownership and combo ownership
    lw      t0, 0x0028(sp)                  // t0 = item special struct
    lw      t1, 0x02A8(t0)                  // t1 = object which has ownership over the colliding hitbox
    sw      t1, 0x0008(t0)                  // update item owner
    lli     at, 0x0004                      // at = 0x4 (no combo ownership)
    beqz    t1, _calculate_movement         // skip if there isn't an object in t1
    lli     t2, 0x03E8                      // t2 = player object type
    lw      t3, 0x0000(t1)                  // t3 = object type
    bne     t2, t3, _calculate_movement     // skip if object type != player
    lw      t1, 0x0084(t1)                  // t1 = type specific special struct
    lbu     at, 0x000D(t1)                  // at = player port (for combo ownership)


    _calculate_movement:
    sb      at, 0x0015(t0)                  // update combo ownership
    lw      t6, 0x0298(t0)                  // t6 = damage
    lw      t7, 0x01EC(t0)                  // t7 = percent
    addu    t8, t7, t6                      // t8 = percent + damage
    sltiu   t5, t8, 301                     // ~
    bnezl   t5, pc() + 16                   // if updated percent < 301...
    sw      t8, 0x01EC(t0)                  // ...store updated percent
    lli     t8, 300                         // ~
    sw      t8, 0x01EC(t0)                  // else, percent = 300
    lli     at, 210                         // ~
    sw      at, 0x01F0(t0)                  // percent timer = 210
    lwc1    f0, 0x0298(t0)                  // ~
    cvt.s.w f0, f0                          // f0 = damage
    lwc1    f2, 0x01EC(t0)                  // ~
    cvt.s.w f2, f2                          // f2 = percent
    mul.s   f4, f2, f0                      // f4 = percent * damage
    lui     at, 0x3D89                      // ~
    mtc1    at, f6                          // ~
    mul.s   f6, f6, f2                      // f6 = percent / 18
    lui     at, 0x3D64                      // ~
    mtc1    at, f8                          // ~
    mul.s   f8, f8, f4                      // f8 = percent * damage / 18
    add.s   f0, f6, f8                      // f0 = p/18 + p*d/18
    lw      t2, 0x01D4(t0)                  // at = fire state flag
    bnezl   t2, pc() + 12                   // if fire state = TRUE...
    lui     t1, 0x3FE0                      // ...mult = 1.75
    lui     t1, 0x3FA0                      // else, mult = 1.25
    mtc1    t1, f2                          // f2 = mult
    mul.s   f0, f0, f2                      // f0 = (p/18 + p*d/18) * mult
    lui     t1, 0x41D0                      // ~
    mtc1    t1, f2                          // f2 = 26
    add.s   f0, f0, f2                      // f0 = knockback = ((p/18 + p*d/18) * mult) + 22

    lwc1    f2, 0x002C(t0)                  // ~
    mul.s   f2, f2, f2                      // f2 = x velocity squared
    lwc1    f4, 0x0030(t0)                  // ~
    mul.s   f4, f4, f4                      // f4 = y velocity squared
    add.s   f2, f2, f4                      // f2 = x velocity squared + y velocity squared
    sqrt.s  f2, f2                          // f2 = absolute velocity
    lw      t2, 0x01D4(t0)                  // t2 = fire state flag
    bnezl   t2, pc() + 12                   // if fire state = TRUE...
    lui     at, 0x3A9D                      // ...mult = 0.0012
    lui     at, 0x3B83                      // else, mult = 0.004

    mtc1    at, f4                          // f4 = mult
    mul.s   f2, f2, f4                      // f2 = absolute velocity * mult
    lui     at, 0x3F80                      // ~
    mtc1    at, f4                          // f4 = 1
    add.s   f2, f2, f4                      // f2 = 1 + (absolute velocity * mult)
    mul.s   f0, f0, f2                      // f0 = knockback * 1 + (absolute velocity * mult)

    // ensure knockback doesn't exceed MAX_SPEED
    lui     at, MAX_SPEED
    mtc1    at, f2                          // f2 = MAX_SPEED
    c.le.s  f0, f2                          // check if MAX_SPEED =< knockback
    nop
    bc1fl   _save_speed                     // if knockback exceeds MAX_SPEED...
    mov.s   f0, f2                          // ...knockback = MAX_SPEED

    _save_speed:
    swc1    f0, 0x002C(sp)                  // 0x002C(sp) = knockback
    swc1    f0, 0x01C8(t0)                  // current max speed = knockback
    lw      a0, 0x029C(t0)                  // a0 = knockback angle
    // this subroutine converts the int angle in a0 to radians, also handles sakurai angle
    jal     0x801409BC                      // f0 = knockback angle in rads
    lw      a2, 0x002C(sp)                  // a2 = knockback
    swc1    f0, 0x0030(sp)                  // 0x0030(sp) = knockback angle
    // ultra64 cosf function
    jal     0x80035CD0                      // f0 = cos(angle)
    mov.s   f12, f0                         // f12 = knockback angle
    lwc1    f4, 0x002C(sp)                  // f4 = knockback
    mul.s   f4, f4, f0                      // f4 = x velocity (knockback * cos(angle))
    swc1    f4, 0x0034(sp)                  // 0x0034(sp) = x velocity
    // ultra64 sinf function
    jal     0x800303F0                      // f0 = sin(angle)
    lwc1    f12, 0x0030(sp)                 // f12 = knockback angle
    lwc1    f4, 0x002C(sp)                  // f4 = knockback
    mul.s   f4, f4, f0                      // f4 = y velocity (knockback * sin(angle))
    lwc1    f2, 0x0034(sp)                  // f2 = x velocity

    lw      t0, 0x0028(sp)                  // t0 = item special struct
    lw      t1, 0x02A4(t0)                  // ~
    subu    t1, r0, t1                      // t1 = DIRECTION
    sw      t1, 0x0024(t0)                  // update item direction
    mtc1    t1, f0                          // ~
    cvt.s.w f0, f0                          // f0 = DIRECTION
    mul.s   f2, f0, f2                      // f2 = x velocity * DIRECTION
    swc1    f2, 0x002C(t0)                  // update projectile x velocity
    swc1    f4, 0x0030(t0)                  // update projectile y velocity
    lli     t1, 000016                      // ~
    sw      t1, 0x01D0(t0)                  // set hitbox refresh timer to 16 frames

    // colour animation on hit
    lw      t2, 0x01D4(t0)                  // at = fire state flag
    bnez    t2, _fire_hit                   // branch if fire state = TRUE
    lw      a0, 0x0024(sp)                  // a0 = item object

    _normal_hit:
    lli     a1, 5                           // a1 = id = 6
    jal     0x80172F98                      // itMainCheckSetColAnimID
    or      a2, r0, r0                      // a2 = duration = 0
    b       _scoreable_flag                 // update scoreable flag
    nop

    _fire_hit:
    lli     a1, GFXRoutine.id.BALL_FIRE     // a1 = id.BALL_FIRE
    jal     0x80172F98                      // itMainCheckSetColAnimID
    or      a2, r0, r0                      // a2 = duration = 0

    _scoreable_flag:
    OS.read_word(Smashketball.type, t5)     // t5 = type
    bnez    t5, _end                        // if not basketball, skip
    lw      a0, 0x0024(sp)                  // a0 = item object
    lli     t3, OS.TRUE                     // t3 = TRUE = scoreable flag
    sw      t3, 0x0068(a0)                  // update scoreable flag

    _end:
    // sw      r0, 0x0270(t0)                  // zero out hit damage so we don't run the clang function
    lw      ra, 0x0020(sp)                  // load ra
    addiu   sp, sp, 0x0050                  // deallocate stack space
    jr      ra
    or      v0, r0, r0                      // return 0 (don't destroy item)
}

// @ Description
// Checks if a Basketball item has collided with a Barrel
// @ Arguments
// a0 - item object
scope check_basketball_barrel_collision_: {
    addiu   sp, sp, -0x0030                 // allocate stack space
    sw      ra, 0x0004(sp)                  // save registers
    sw      a0, 0x0008(sp)                  // save registers
    sw      r0, 0x000C(sp)                  // initialize counter

    lw      t0, 0x0084(a0)                  // t0 = basketball item special struct
    lw      at, 0x01CC(t0)                  // t2 = barrel refresh timer
    bnez    at, _end                        // skip if refresh timer is active
    nop

    OS.read_word(0x80131180, a0)            // a0 = left barrel object
    _loop:
    beqz    a0, _end                        // skip if no barrel object
    lw      a1, 0x0008(sp)                  // a1 = basketball object
    lui     at, 0x438C                      // Need this because we jump past it
    sw      a0, 0x0010(sp)                  // save barrel object
    addiu   sp, sp, -0x0018                 // set up stack for routine
    li      ra, _return
    sw      ra, 0x0014(sp)                  // save ra for routine
    lli     a2, Action.Barrel               // a2 = Barrel action
    jal     0x8010A018                      // Jump to middle of grJungleTaruCannCheckGetDamageKind (past player checks)
    addiu   a3, sp, 0x0010                  // a3 = *kind - not important so just stuff in stack
    _return:
    beqz    v0, _next                       // if not collided, skip
    lw      t0, 0x0010(sp)                  // t0 = barrel object

    lw      a0, 0x0008(sp)                  // a0 = basketball object
    lw      t1, 0x0084(a0)                  // t1 = basketball item special struct
    sw      t0, 0x0048(a0)                  // save reference to barrel object in item
    sw      r0, 0x01CC(t1)                  // initialize shoot timer
    sw      r0, 0x01D0(t1)                  // hitbox refresh timer = 0
    sw      r0, 0x01D4(t1)                  // fire state flag = FALSE
    sw      r0, 0x01D8(t1)                  // gfx timer = 0
    sw      r0, 0x010C(t1)                  // disable hitbox
    lli     at, OS.TRUE                     // at = TRUE = scoreable flag
    sw      at, 0x0068(a0)                  // update scoreable flag

    li      a1, item_state_table
    jal     0x80172EC8                      // change item state
    lli     a2, 0x0001                      // state = 1 (in barrel)

    jal     0x800269C0                      // play enter barrel sound
    lli     a0, 282                         // a0 = barrel enter sound (nSYAudioFGMJungleTaruCannEnter)

    jal     0x800269C0                      // play crowd gasp sound
    lli     a0, 0x269                       // a0 = crowd gasp sound

    b       _end                            // no need to check other barrel
    nop

    _next:
    lw      t0, 0x000C(sp)                  // t0 = counter
    bnez    t0, _end                        // if already did both barrels, finish
    addiu   t1, t0, 0x0001                  // t1 = counter + 1
    sw      t1, 0x000C(sp)                  // update counter
    OS.read_word(0x80131180, a0)            // a0 = left barrel object
    b       _loop
    lw      a0, 0x0020(a0)                  // a0 = right barrel object

    _end:
    lw      ra, 0x0004(sp)                  // restore registers
    jr      ra
    addiu   sp, sp, 0x0030                  // deallocate stack space
}

// @ Description
// Main function for when in barrel
scope barrel_main_: {
    addiu   sp, sp, -0x30                   // allocate stack space
    sw      ra, 0x0014(sp)                  // store ra
    sw      a0, 0x0018(sp)                  // store a0

    lw      v0, 0x0084(a0)                  // v0 = item special struct

    lw      t0, 0x01CC(v0)                  // t0 = shoot timer
    addiu   t8, t0, 0x0001                  // increment shoot timer
    bnez    t0, _check_shoot                // if not first frame, skip setup
    sw      t8, 0x01CC(v0)                  // store updated shoot timer

    // turn off visibility
    lw      v1, 0x0074(a0)                  // v1 = item top joint
    lli     t0, 0x0002
    sb      t0, 0x0054(v1)                  // turn off display

    // freeze movement
    sw      r0, 0x002C(v0)                  // set X velocity to 0
    sw      r0, 0x0030(v0)                  // set Y velocity to 0
    sw      r0, 0x0034(v0)                  // set Z velocity to 0

    // position item at center of barrel
    lw      t0, 0x0048(a0)                  // t0 = barrel object
    lw      t1, 0x0074(t0)                  // t1 = barrel top joint
    lw      t2, 0x001C(t1)                  // t2 = barrel x
    sw      t2, 0x001C(v1)                  // set item x
    lw      t2, 0x0020(t1)                  // t2 = barrel y
    sw      t2, 0x0020(v1)                  // set item y
    lw      t2, 0x0024(t1)                  // t2 = barrel z
    sw      t2, 0x0024(v1)                  // set item z

    _check_shoot:
    lli     at, BARREL_TIMER - 5            // at = timer value for when to play shoot sfx
    beq     at, t8, _play_shoot_sfx         // if so, play sfx
    sltiu   at, t8, BARREL_TIMER            // at = 0 if it's time to shoot!
    bnez    at, _end                        // skip if not time to shoot
    nop

    jal     0x80109D20                      // play shoot barrel anim - grJungleTaruCannAddAnimShoot()
    lw      a0, 0x0048(a0)                  // a0 = barrel object

    lw      a0, 0x0018(sp)                  // a0 = item
    lw      v1, 0x0074(a0)                  // v1 = item top joint
    sb      r0, 0x0054(v1)                  // turn on display
    lw      v0, 0x0084(a0)                  // v0 = item special struct
    lli     a1, OS.TRUE
    sw      a1, 0x010C(v0)                  // enable hitbox
    lui     t0, BARREL_SPEED
    sw      t0, 0x0030(v0)                  // set Y velocity
    lli     at, 000010                      // ~
    sw      at, 0x01CC(v0)                  // set barrel refresh timer to 10 frames
    li      a1, item_state_table
    jal     0x80172EC8                      // change item state
    lli     a2, 0x0000                      // state = 0 (main)

    _play_shoot_sfx:
    jal     0x800269C0                      // play shoot barrel sound
    lli     a0, 281                         // a0 = barrel shoot sound (nSYAudioFGMJungleTaruCannShoot)

    _end:
    lw      ra, 0x0014(sp)                  // load ra
    addiu   sp, sp, 0x30                    // deallocate stack space
    jr      ra                              // return
    or      v0, r0, r0                      // return 0 (don't destroy)
}

// @ Description
// Checks if the Ball has fallen below the stage and sends it flying back up!
// @ Arguments
// a0 - item object
scope check_basketball_fall_: {
    addiu   sp, sp, -0x0030                 // allocate stack space
    sw      ra, 0x0004(sp)                  // save registers

    lw      t1, 0x0074(a0)                  // t1 = item position struct
    lui     at, 0xC58C                      // ~
    mtc1    at, f4                          // f4 = -4480
    lwc1    f2, 0x0020(t1)                  // f2 = ball y
    c.lt.s  f2, f4                          // check if ball is below -4480
    lw      t0, 0x0084(a0)                  // t0 = item special struct
    bc1fl   _end                            // skip if ball is above -4480
    nop

    // if the ball is below -1600
    mtc1    r0, f4                          // f4 = 0
    lwc1    f2, 0x001C(t1)                  // f2 = ball x/y
    c.lt.s  f2, f4                          // check if ball is left or right side
    lui     t4, 0x4584                      // t4 = x position = 4224 (right)
    bc1tl   pc() + 8                        // if ball is on left side...
    lui     t4, 0xC584                      // t4 = x p[osition = -4224 (left)
    lui     t5, 0xC58C                      // t5 = y position = -4480
    c.lt.s  f2, f4                          // check if ball is left or right side (is this redundant?)
    lui     t6, 0xC148                      // t6 = x velocity = -12.5 (right)
    bc1tl   pc() + 8                        // if ball is on left side...
    lui     t6, 0x4148                      // t6 = x velocity = 12.5 (left)
    lui     t7, 0x4306                      // t7 = y velocity = 134
    sw      t4, 0x001C(t1)                  // ~
    sw      t5, 0x0020(t1)                  // update x/y position
    sw      t6, 0x002C(t0)                  // ~
    sw      t7, 0x0030(t0)                  // update x/y velocity
    lli     at, 40                          // ~
    sw      at, 0x01F4(t0)                  // cooldown timer = 40 frames
    jal     0x800269C0                      // play fgm
    lli     a0, 18                          // fgm id = 18 (whoosh)

    _end:
    lw      ra, 0x0004(sp)                  // restore registers
    jr      ra
    addiu   sp, sp, 0x0030                  // deallocate stack space
}

// @ Description
// Checks if a Basketball item has been scored
// @ Arguments
// a0 - item object
scope check_basketball_scored_: {
    addiu   sp, sp, -0x0030                 // allocate stack space
    sw      ra, 0x0004(sp)                  // save registers

    lw      at, 0x0040(a0)                  // ~
    beqz    at, _end                        // skip if ball hasn't passed through hoop
    nop

    lw      t1, 0x0084(a0)                  // t1 = basketball item special struct
    sw      r0, 0x01CC(t1)                  // initialize respawn timer
    sw      r0, 0x01D0(t1)                  // hitbox refresh timer = 0
    sw      r0, 0x01D4(t1)                  // fire state flag = FALSE
    sw      r0, 0x01D8(t1)                  // gfx timer = 0
    sw      r0, 0x010C(t1)                  // disable hitbox
    sw      r0, 0x0248(t1)                  // disable hurtbox
    lli     at, OS.TRUE                     // ~
    sw      at, 0x01E8(t1)                  // respawn flag = TRUE

    li      a1, item_state_table
    jal     0x80172EC8                      // change item state
    lli     a2, 0x0002                      // state = 1 (respawning)

    _end:
    lw      ra, 0x0004(sp)                  // restore registers
    jr      ra
    addiu   sp, sp, 0x0030                  // deallocate stack space
}

// @ Description
// Main function for respawn state
scope respawn_main_: {
    addiu   sp, sp, -0x30                   // allocate stack space
    sw      ra, 0x0014(sp)                  // store ra
    sw      a0, 0x0018(sp)                  // store a0

    lw      v0, 0x0084(a0)                  // v0 = item special struct

    lw      t0, 0x01CC(v0)                  // t0 = respawn timer
    addiu   t8, t0, 0x0001                  // increment respawn timer
    bnez    t0, _check_respawn              // if not first frame, skip setup
    sw      t8, 0x01CC(v0)                  // store updated shoot timer

    // turn off visibility
    lw      v1, 0x0074(a0)                  // v1 = item top joint
    lli     t0, 0x0002
    sb      t0, 0x0054(v1)                  // turn off display

    // freeze movement
    sw      r0, 0x002C(v0)                  // set X velocity to 0
    sw      r0, 0x0030(v0)                  // set Y velocity to 0
    sw      r0, 0x0034(v0)                  // set Z velocity to 0

    _check_respawn:
    sltiu   at, t8, RESPAWN_TIMER           // at = 0 if it's time to respawn!
    bnez    at, _end                        // skip if not time to respawn
    or      v0, r0, r0                      // return 0 (don't destroy)

    lli     v0, OS.TRUE                     // signal to the ball that its time in this world has come to an end

    _end:
    lw      ra, 0x0014(sp)                  // load ra
    jr      ra                              // return
    addiu   sp, sp, 0x30                    // deallocate stack space
}

// @ Description
// Prevents fighters from entering barrel if basketball is in barrel
scope prevent_fighter_enter_barrel_: {
    OS.patch_start(0x858E0, 0x8010A0E0)
    j       prevent_fighter_enter_barrel_
    lli     t0, VsRemixMenu.mode.SMASHKETBALL
    _return:
    OS.patch_end()

    OS.read_word(VsRemixMenu.vs_mode_flag, t1)
    bne     t1, t0, _normal                 // if not Smashketball, skip
    OS.read_word(0x80046700, at)            // at = item object linked list head
    _loop:
    beqz    at, _normal                     // if no basketball object, can enter
    lli     t1, Item.Basketball.id          // Basketball
    lw      t0, 0x0084(at)                  // t0 = item struct
    lw      t0, 0x000C(t0)                  // t0 = item_id
    beq     t0, t1, _check_if_in_barrel     // if Basketball, need to check if in barrel
    nop
    b       _loop
    lw      at, 0x0004(at)                  // at = next item object

    _check_if_in_barrel:
    lw      t0, 0x0084(at)                  // t0 = basketball item special struct
    lw      t0, 0x0378(t0)                  // t0 = main routine
    li      t1, barrel_main_
    beq     t0, t1, _no_enter               // if basketball is in the barrel, don't allow entering
    nop                                     // otherwise, fall through to normal

    _normal:
    jal     0x80109CFC                      // original line 1
    sw      t2, 0x0000(a3)                  // original line 2
    j       _return
    nop

    _no_enter:
    j       0x8010A0F4                      // exit and don't allow fighter to enter barrel
    lli     v0, OS.FALSE                    // v0 = FALSE (can't enter)
}
// @ Description
// Adds hitlag to basketball bounces.
// TODO: handle FGM here for bounce as well?
// 80173874 = left wall
// 801738EC = right wall
// 8017395C = ceiling
// 801739BC = floor
scope bounce_patch_: {
    // left wall
    OS.patch_start(0xEE2B4, 0x80173874)
    jal     bounce_patch_._lwall
    or      a0, s0, r0                      // original line 2
    OS.patch_end()
    // right wall
    OS.patch_start(0xEE32C, 0x801738EC)
    jal     bounce_patch_._rwall
    sw      t4, 0x003C(sp)                  // original line 2
    OS.patch_end()
    // ceiling
    OS.patch_start(0xEE39C, 0x8017395C)
    jal     bounce_patch_._ceiling
    sw      t7, 0x003C(sp)                  // original line 2
    OS.patch_end()
    // floor
    OS.patch_start(0xEE3FC, 0x801739BC)
    jal     bounce_patch_._floor
    sw      t0, 0x003C(sp)                  // original line 2
    OS.patch_end()

    // s2 = item special struct
    _lwall:
    lui     t4, 0x3F20                      // x_scale = 0.625
    lui     t5, 0x3FE0                      // y_scale = 1.75
    lui     t6, 0x4220                      // x_offset = 40
    b       _continue
    lui     t7, 0x0000                      // y_offset = 0

    _rwall:
    lui     t4, 0x3F20                      // x_scale = 0.625
    lui     t5, 0x3FE0                      // y_scale = 1.75
    lui     t6, 0xC220                      // x_offset = -40
    b       _continue
    lui     t7, 0x0000                      // y_offset = 0

    _ceiling:
    lui     t4, 0x3FE0                      // x_scale = 1.75
    lui     t5, 0x3F20                      // y_scale = 0.625
    lui     t6, 0x0000                      // x_offset = 0
    b       _continue
    lui     t7, 0x4220                      // y_offset = 40

    _floor:
    lui     t4, 0x3FE0                      // x_scale = 1.75
    lui     t5, 0x3F20                      // y_scale = 0.625
    lui     t6, 0x0000                      // x_offset = 0
    lui     t7, 0xC220                      // y_offset = -40

    _continue:
    addiu   sp, sp, -0x0030                 // allocate stack space
    sw      ra, 0x0014(sp)                  // store ra
    sw      a0, 0x0018(sp)                  // store a0

    lw      at, 0x000C(s2)                  // at = item_id
    lli     t2, Item.Basketball.id          // t2 = Basketball id
    bne     at, t2, _end                    // skip if item isn't Basketball
    nop

    lwc1    f2, 0x002C(s2)                  // f2 = x velocity
    lwc1    f4, 0x0030(s2)                  // f4 = y velocity
    mul.s   f6, f2, f2                      // f6 = x velocity squared
    mul.s   f8, f4, f4                      // f8 = y velocity squared
    add.s   f6, f6, f8                      // f6 = x velocity squared + y velocity squared
    sqrt.s  f8, f6                          // f8 = absolute velocity

    lui     at, 0x4220                      // ~
    mtc1    at, f2                          // f2 = 40
    c.le.s  f2, f8                          // check if velocity is above 40
    nop
    bc1fl   _calculate_hitlag               // skip if speed is under 40
    nop

    // if speed is over 40, apply bounce scaling
    // t4 = x_scale, t5 = y_scale, t6 = x_offset, t7 = y offset
    lw      t2, 0x0004(s2)                  // t2 = item object
    lw      t2, 0x0074(t2)                  // t2 = item first joint struct
    sw      t4, 0x0040(t2)                  // store x_scale
    sw      t5, 0x0044(t2)                  // store y_scale
    sw      t6, 0x01DC(s2)                  // store x_offset
    sw      t7, 0x01E0(s2)                  // store y_offset
    lli     at, OS.TRUE                     // ~
    sw      at, 0x01E4(s2)                  // bounce scaling flag = TRUE
    mtc1    t6, f2                          // ~
    lwc1    f4, 0x001C(t2)                  // ~
    add.s   f4, f4, f2                      // ~
    swc1    f4, 0x001C(t2)                  // update x position with x_offset
    mtc1    t7, f2                          // ~
    lwc1    f4, 0x0020(t2)                  // ~
    add.s   f4, f4, f2                      // ~
    swc1    f4, 0x0020(t2)                  // update y position with y_offset

    _calculate_hitlag:
    lui     at, 0x3CF6                      // ~
    mtc1    at, f2                          // f2 = 0.03
    mul.s   f2, f2, f8                      // f2 = absolute velocity * 0.03
    cvt.w.s f2, f2                          // convert to int
    mfc1    at, f2                          // ~
    addiu   at, at, 1                       // at = hitlag = 1 + absolute velocity * 0.03
    sw      at, 0x0020(s2)                  // store hitlag

    _fgm:
    lw      at, 0x01E4(s2)                  // at = bounce scaling flag
    beqz    at, _end                        // skip if bounce scaling flag = FALSE
    sw      a0, 0x0018(sp)                  // store a0
    lw      at, 0x01D4(s2)                  // at = fire state flag
    bnezl   at, pc() + 12                   // if fire state = TRUE...
    lli     a0, 0x42F                       // ...fgm = fire bounce
    lli     a0, 0x42E                       // else, fgm = default bounce
    jal     0x800269C0                      // play fgm
    sw      a1, 0x001C(sp)                  // store a1
    lw      a0, 0x0018(sp)                  // ~
    lw      a1, 0x001C(sp)                  // load a0, a1

    _end:
    jal     0x800C7B08                      // apply bounce (original line 1)
    nop

    lw      ra, 0x0014(sp)                  // load ra
    jr      ra
    addiu   sp, sp, 0x0030                  // deallocate stack space
}

// @ Description
// Prevents the default bounce FGM from playing during bigger bounces.
scope prevent_bounce_fgm_: {
    // left wall
    OS.patch_start(0xEE2E4, 0x801738A4)
    jal     prevent_bounce_fgm_
    swc1    f4, 0x0044(sp)                 // original line 2
    OS.patch_end()
    // right wall
    OS.patch_start(0xEE354, 0x80173914)
    jal     prevent_bounce_fgm_
    swc1    f6, 0x0044(sp)                 // original line 2
    OS.patch_end()
    // floor
    OS.patch_start(0xEE41C, 0x801739DC)
    jal     prevent_bounce_fgm_
    swc1    f18, 0x0044(sp)                 // original line 2
    OS.patch_end()

    // s2 = item special struct
    addiu   sp, sp, -0x0030                 // allocate stack space
    sw      ra, 0x0004(sp)                  // store ra

    lw      at, 0x000C(s2)                  // at = item_id
    lli     t2, Item.Basketball.id          // t2 = Basketball id
    bne     at, t2, _fgm                    // if item isn't Basketball, play sound
    lw      at, 0x01E4(s2)                  // at = bounce scaling flag
    bnez    at, _end                        // skip if bounce scaling flag = TRUE
    nop

    _fgm:
    jal     0x800269C0                      // original line 1 (play fgm)
    nop

    _end:
    lw      ra, 0x0004(sp)                  // load ra
    jr      ra
    addiu   sp, sp, 0x0030                  // deallocate stack space
}

// @ Description
// Multiplies hitlag for attacking players when hitting a flaming Basketball
scope multiply_player_hitlag_: {
    OS.patch_start(0x5DEC8, 0x800E26C8)
    j       multiply_player_hitlag_
    sw      s0, 0x0008(sp)                  // original line 2
    _return:
    OS.patch_end()

    sw      s1, 0x000C(sp)                  // original line 1
    beqz    a2, _end                        // skip if victim object doesn't exist (this should never happen, right?)
    lli     at, 0x03F5                      // at = item gobj type
    // if there's a victim object
    lw      t0, 0x0000(a2)                  // t0 = victim gobj type
    bne     t0, at, _end                    // skip if victim gobj type != item
    lw      t0, 0x0084(a2)                  // t0 = item special struct
    beqz    t0, _end                        // skip if item special struct doesn't exist (this should never happen, right?)
    lli     at, Item.Basketball.id          // at = Basketball id
    lw      t1, 0x000C(t0)                  // t1 = item_id
    bne     t1, at, _end                    // skip if item id != Basketball
    lw      t1, 0x01D4(t0)                  // t1 = fire state flag
    beqz    t1, _end                        // skip if fire state flag = FALSE
    lui     at, 0x4000                      // at = float32 2

    // if we're here, then the player is hitting a flaming Basketball, so multiply hitlag
    sw      at, 0x07A4(a0)                  // player hitlag multiplier = 2

    _end:
    j       _return                         // return
    nop
}

// @ Description
// Multiplies hitlag for the flaming Basketball when it gets hit
scope multiply_ball_hitlag_hurtbox_: {
    OS.patch_start(0xEBDA8, 0x80171368)
    j       multiply_ball_hitlag_hurtbox_
    sw      v1, 0x001C(sp)                  // original line 2
    _return:
    OS.patch_end()

    // v1 = item special struct
    lli     at, Item.Basketball.id          // at = Basketball id
    lw      t1, 0x000C(v1)                  // t1 = item_id
    bne     t1, at, _end                    // skip if item id != Basketball
    lw      t1, 0x01D4(v1)                  // t1 = fire state flag
    bnezl   t1, _end                        // if fire state flag = TRUE...
    lui     a2, 0x4000                      // ...a2(hitlag multiplier) = float32 2

    _end:
    jal     0x800EA1C0                      // original line 1 (calculate hitlag)
    nop
    j       _return                         // return
    nop
}

// @ Description
// Adds hitlag to the Basketball item's hitbox when it collides with a player
scope add_ball_hitlag_hitbox_: {
    OS.patch_start(0x5F1D0, 0x800E39D0)
    jal     add_ball_hitlag_hitbox_
    nop
    _return:
    OS.patch_end()

    // s0 = item special struct
    // 0x004C(sp) = player struct
    // v0 = item damage
    lw      t2, 0x004C(sp)                  // t2 = player struct
    addiu   sp, sp, -0x0030                 // allocate stack space
    sw      ra, 0x0014(sp)                  // store ra
    sw      v0, 0x0018(sp)                  // store v0

    lli     at, Item.Basketball.id          // at = Basketball id
    lw      t1, 0x000C(s0)                  // t1 = item_id
    bne     t1, at, _end                    // skip if item id != Basketball
    lw      t1, 0x01D4(s0)                  // t1 = fire state flag
    beqz    t1, _end                        // skip if fire state flag = FALSE
    nop

    or      a0, v0, r0                      // a0 = damage
    lli     a1, 0x000A                      // a1 = status_id? set to 0xA like hurtbox calculation
    lui     a2, 0x4000                      // hitlag multiplier = 2
    jal     0x800EA1C0                      // v0 = calculated hitlag
    sw      a2, 0x07A4(t2)                  // player hitlag multiplier = 2

    sw      v0, 0x0020(s0)                  // store hitlag

    _end:
    lw      v0, 0x0018(sp)                  // load v0
    lw      ra, 0x0014(sp)                  // load ra
    addiu   sp, sp, 0x0030                  // deallocate stack space
    lw      a0, 0x0044(sp)                  // original line 1
    jr      ra                              // return
    sw      v0, 0x003C(sp)                  // original line 2
}

// @ Description
// Ball crossed blastzone so sets it to spawn as golden
// Top blastzone in soccer is the only way this can occur
scope set_golden_: {
    lli     v0, OS.TRUE                     // v0 = TRUE to destroy item
    li      t0, Smashketball.spawn_golden
    jr      ra
    sw      v0, 0x0000(t0)                  // set spawn_golden to TRUE
}

// // @ Description
// // Allows basketball to harm the owner
// scope allow_owner_damage_: {
    // OS.patch_start(0x60E34, 0x800E5634)
    // jal     allow_owner_damage_
    // sw      s6, 0x0088(sp)                  // original line 1
    // OS.patch_end()

    // lw      at, 0x000C(s8)                  // at = item_id
    // lli     t2, Item.Basketball.id
    // bne     at, t2, _end                    // if not Basketball, then use owner normally
    // lw      t1, 0x0008(s8)                  // original line 2 - t1 = item's owner object

    // // if here, check item's thrown timer before considering there to be no owner
    // lw      t2, 0x0044(t8)                  // t2 = thrown timer
    // beqzl   t2, _end                        // if 0, then treat as if no owner
    // lli     t1, 0x0000                      // t1 = 0 = no owner

    // _end:
    // jr      ra
    // nop
// }