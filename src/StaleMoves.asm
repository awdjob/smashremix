// StaleMoves.asm (code by goombapatrol)
if !{defined __STALEMOVES__} {
define __STALEMOVES__()
print "included StaleMoves.asm\n"

// @ Description
// Move Staling (and Freshening)
// Default    = attacks go stale, then gradually get less stale when a different move is used in between until 'Fresh' again
// Disabled   = attacks are always 1.00x, no staling is applied
// Lenient    = Moves unstale quicker (only takes 1 non-consecutive move)
// Strict     = using a move twice in a row will deal only 1% damage
// Waitforit  = Vanilla staling logic, different table; slot 4 is '2.00x' instead of '0.96x'
// Reverse/CS = attacks gradually get stronger when used consecutively, drop to 'Fresh' value when different move is used
//      Reverse starts at 'stale' 0.75x multiplier and caps at 1.00x
//      Cheap Shot starts at normal 1.00x and gets boosted beyond that
//      Note: only attacks that hit are taken into account (as vanilla does)
//      Note: Slashes inidicate Vanilla staling logic. Commas indicate consecutive logic.
//
//                       Fresh -> multiplier levels
// 0 = DEFAULT          (1.00x -> 0.75x/ 0.82x/ 0.89x/ 0.96x)
// 1 = DISABLED         (1.00x -> 1.00x)
// 2 = LENIENT          (1.00x -> 0.75x)
// 3 = STRICT           (1.00x -> 0.01x/ 0.82x/ 0.89x/ 0.96x)
// 4 = WAIT FOR IT      (1.00x -> 0.75x/ 0.82x/ 0.89x/ 1.75x)
// 5 = REVERSE          (0.75x -> 0.82x, 0.89x, 0.96x, 1.00x)
// 6 = CHEAP SHOT       (1.00x -> 1.25x, 1.36x, 1.50x, 1.75x)

scope stale_moves: {

    // @ Description
    // Get Stale Move Multiplier
    // Based off subroutine starting @ 0x800EA470
    // a0 = port
    // a1 = current attack_id
    // s0 = current motion_count
    // a3 = loop index
    // v0 = start_array index
    // t0 = address of stale_info array
    // t4, t6 are safe
    OS.patch_start(0x65CDC, 0x800EA4DC)
        j       stale_moves.check_toggle
        nop
        _check_stale_toggle_return:
        OS.patch_end()

        check_toggle:
        li      at, 0x8012B820              // at = address of Vanilla Stale Table
        li      t1, Toggles.entry_move_staling
        lw      t1, 0x0004(t1)              // t1 = move_staling (0 if 'DEFAULT', 1 if 'DISABLED', 2 if 'LENIENT', 3 if 'STRICT', 4 if 'WAIT FOR IT', 5 if 'REVERSE', 6 if 'CHEAP SHOT')
        beqz    t1, _original               // if DEFAULT, return to original subroutine
        nop

        lli     at, 3                       // at = 3 ('STRICT')
        beq     t1, at, _original_strict    // if 'STRICT', return to original subroutine (with a different table)
        lli     at, 4                       // at = 4 ('WAIT FOR IT')
        beq     t1, at, _original_wfi       // if 'WAIT FOR IT', return to original subroutine (with a different table)
        nop

        lli     at, 1                       // at = 1 (DISABLED)
        beql    t1, at, fresh_multiplier    // branch accordingly (no staling, always 1.00x)
        addiu   a3, a3, -1                  // a3 = -1 (fresh)

        // loop through the stale queue to count consecutive attacks
        // (check for the same attack_id with a different motion_count)
        // p1 stale queue is at 0x801909E4
        loop_stale_queue:
        addu    v1, t0, t9                  // v1 = stale_info array + offset
        lhu     t1, 0x0080(v1)              // t1 = attack_id in stale_info array
        bne     a1, t1, done_checking_queue // branch if current attack_id != stale_info attack_id
        nop

        table_id_matched:
        // load previous stale value if current attack_id and motion_count == most recent stale_info attack_id and motion_count
        // (duplicate motion_count will occur from multi-hit moves, such as Fox UAIR)
        bnez    a3, checked_motion_count    // skip check if not on first loop
        nop
        lhu     t2, 0x0082(v1)                // t2 = motion_count in stale_info array
        bne     s0, t2, checked_motion_count  // branch if current motion_count is different than recent motion_count
        nop
        // if we're here, this attack should be treated as the same staleness as its initial hit
        li      s0, preserved_stale_value   // s0 = address of preserved_stale_value
        addu    s0, s0, a0                  // s0 = preserved_stale_value + port offset
        lb      a3, 0x0000(s0)              // a3 = stale value for that player
        b       done_checking_queue         // branch
        nop

        checked_motion_count:
        nop                                 // note: removed original logic here that checked if current_array == starting_array, then a3--
        beqz    v0, wrap_index              // if at array start, wrap to end
        addiu   a3, a3, 0x0001              // a3++
        b       check_index_count           // branch to update index
        addiu   v0, v0, 0xFFFF              // decrement index

        wrap_index:
        addiu   v0, r0, 0x0004              // wrap index to array_count - 1

        check_index_count:
        slti    at, a3, 0x0004              // if a3 < array_count, continue loop
        bnezl   at, loop_stale_queue        // branch back to loop start
        sll     t9, v0, 2                   // t9 = v0 * 4
        nop                                 // if here, a3 = 4 (all 4 stale slots match attack_id)

        done_checking_queue:
        addiu   a3, a3, -1                  // a3-- (adjust index for table)
        bltz    a3, fresh_multiplier        // a3 < 0 if there are no attack_id matches in table (if so, skip)
        nop
        sll     t3, a3, 2                   // t3 = a3 * 4 (offset)

        li      at, Toggles.entry_move_staling
        lw      at, 0x0004(at)              // at = move_staling (0 if 'DEFAULT', 1 if 'DISABLED', 2 if 'LENIENT', 3 if 'STRICT', 4 if 'WAIT FOR IT', 5 if 'REVERSE', 6 if 'CHEAP SHOT')
        lli     s0, 2                       // s0 = 2 (LENIENT)
        beq     at, s0, lenient             // branch accordingly
        lli     s0, 3                       // s0 = 3 (STRICT)
        beq     at, s0, strict              // branch accordingly
        lli     s0, 5                       // s0 = 5 (REVERSE)
        beq     at, s0, reverse             // branch accordingly
        lli     s0, 6                       // s0 = 6 (CHEAP SHOT)
        beq     at, s0, cheap_shot          // branch accordingly
        nop

        strict:
        nop
        lui     at, 0x3C00                  // f0 = 0.01x (1% damage)
        b       _end                        // return stale multiplier
        mtc1    at, f0
        lenient:
        lui     at, 0x3F40                  // f0 = 0.75x (vanilla stalest damage)
        b       _end                        // return stale multiplier
        mtc1    at, f0
        reverse:
        li      at, reverse_stale_table     // at = reverse_stale_table
        b       apply_table_offset
        nop
        cheap_shot:
        li      at, cheap_shot_stale_table  // at = cheap_shot_stale_table

        apply_table_offset:
        addu    at, at, t3                  // at = selected table + offset to multiplier
        b       _end                        // return corresponding stale multiplier
        lwc1    f0, 0x0000(at)              // f0 = stale multiplier

        fresh_multiplier:
        li      s0, Toggles.entry_move_staling
        lw      s0, 0x0004(s0)              // s0 = move_staling (0 if 'DEFAULT', 1 if 'DISABLED', 2 if 'LENIENT', 3 if 'STRICT', 4 if 'WAIT FOR IT', 5 if 'REVERSE', 6 if 'CHEAP SHOT')
        lli     at, 5                       // at = 5 (REVERSE)
        bnel    s0, at, pc() + 12           // branch accordingly
        lui     at, 0x3F80                  // f0 = 1.00x (fresh value)
        lui     at, 0x3F40                  // f0 = 0.75x (reverse fresh value)
        mtc1    at, f0
        nop

        _end:
        addiu   a3, a3, 1                   // a3++
        li      s0, preserved_stale_value   // s0 = address of preserved_stale_value
        addu    s0, s0, a0                  // s0 = preserved_stale_value + port offset
        sb      a3, 0x0000(s0)              // store stale value for that player

        _return:
        lw      s0, 0x0004(sp)              // restore s0
        jr      ra                          // return
        addiu   sp, sp, 0x08                // restore stack pointer

        _original_strict:
        li      at, strict_stale_table      // at = address of 'STRICT' Stale Table
        b       _original
        nop
        _original_wfi:
        li      at, waitforit_stale_table   // at = address of 'WAIT FOR IT' Stale Table

        _original:
        addu    v1, t0, t9                  // original line 1 (stale_info array + offset)
        j       _check_stale_toggle_return
        lhu     t1, 0x0080(v1)              // original line 2 (load attack_id in stale_info array)

    // @ Description
    // This is for Vanilla staling logic routine
    // we already set at = stale table above, so don't change it here
    OS.patch_start(0x65CF8, 0x800EA4F8)
        nop                                 // original line is: lui  at, 0x8013
        OS.patch_end()
    OS.patch_start(0x65D04, 0x800EA504)
        lwc1    f0, 0x0000(at)              // original line is: lwc1 f0, 0xB820(at)
        OS.patch_end()

        // alternative approach i scrapped; keeping for historical reasons
        // lenient_stale_table:
        // 0.96F, 0.89F, 0.82F, 0.75F
        // dw 0x3F75C28F, 0x3F63D70A, 0x3F51EB85, 0x3F400000

        reverse_stale_table:
        // 0.82F, 0.89F, 0.96F, 1.00F
        dw 0x3F51EB85, 0x3F63D70A, 0x3F75C28F, 0x3F800000

        cheap_shot_stale_table:
        // 1.25F, 1.36F, 1.50F, 1.75F
        dw 0x3FA00000, 0x3FAE147B, 0x3FC00000, 0x3FE00000

        strict_stale_table:
        // 0.01F, 0.82F, 0.89F, 0.96F
        dw 0x3C000000, 0x3F51EB85, 0x3F63D70A, 0x3F75C28F

        waitforit_stale_table:
        // 0.75F, 0.82F, 0.89F, 1.75F
        dw 0x3F400000, 0x3F51EB85, 0x3F63D70A, 0x3FE00000

        // vanilla stale table @ 0x8012B820
        // 0.75F, 0.82F, 0.89F, 0.96F
        // dw 0x3F400000, 0x3F51EB85, 0x3F63D70A, 0x3F75C28F

        // for tracking multi hit motion_id moves
        preserved_stale_value:
        db -1,-1,-1,-1

}

} // __STALEMOVES__
