scope polygon_lucas_costumes {
    // @ Description
    // Number of additional costumes
    constant NUM_EXTRA_COSTUMES(1)

    // @ Description
    // Number of parts
    constant NUM_PARTS(0x1B)

    // @ Description
    // Number of original costumes
    constant NUM_COSTUMES(6)

    parts_table:
    constant PARTS_TABLE_ORIGIN(origin())
    db NUM_EXTRA_COSTUMES       // 0x0 - number of extra costumes
    db 0x0                      // 0x1 - special part ID
    db 0x0                      // 0x2 - special part image index start
    db 0x0                      // 0x3 - costumes to skip
    fill 4 + (NUM_PARTS - 1) * 8

    Costumes.define_part(2, 1, Costumes.part_type.PALETTE)    // part 0x2_0 - torso
    Costumes.define_part(4, 1, Costumes.part_type.PALETTE)    // part 0x4_0 - left upper arm
    Costumes.define_part(5, 1, Costumes.part_type.PALETTE)    // part 0x5_0 - left lower arm
    Costumes.define_part(6, 1, Costumes.part_type.PALETTE)    // part 0x6_0 - left hand
    Costumes.define_part(8, 1, Costumes.part_type.PALETTE)    // part 0x8_0 - head
    Costumes.define_part(A, 1, Costumes.part_type.PALETTE)    // part 0xA_0 - right upper arm
    Costumes.define_part(B, 1, Costumes.part_type.PALETTE)    // part 0xB_0 - right lower arm
    Costumes.define_part(C, 1, Costumes.part_type.PALETTE)    // part 0xC_0 - right hand
    Costumes.define_part(D, 1, Costumes.part_type.PALETTE)    // part 0xD_0 - bat
    Costumes.define_part(10, 1, Costumes.part_type.PALETTE)   // part 0x10_0 - left leg
    Costumes.define_part(12, 1, Costumes.part_type.PALETTE)   // part 0x12_0 - left shoe
    Costumes.define_part(13, 1, Costumes.part_type.PALETTE)   // part 0x13_0 - left pant
    Costumes.define_part(16, 1, Costumes.part_type.PALETTE)   // part 0x10_0 - right leg
    Costumes.define_part(18, 1, Costumes.part_type.PALETTE)   // part 0x18_0 - right shoe
    Costumes.define_part(19, 1, Costumes.part_type.PALETTE)   // part 0x19_0 - right pant

    // Register extra costumes
    Costumes.register_extra_costumes_for_char(Character.id.NLUCAS)

    // Costume 0x6
    // Yellow Team
    scope costume_6 {
        palette:; insert "Polygon/yellow.bin"

        Costumes.set_palette_for_part(0, 2, 0, palette)
        Costumes.set_palette_for_part(0, 4, 0, palette)
        Costumes.set_palette_for_part(0, 5, 0, palette)
        Costumes.set_palette_for_part(0, 6, 0, palette)
        Costumes.set_palette_for_part(0, 8, 0, palette)
        Costumes.set_palette_for_part(0, A, 0, palette)
        Costumes.set_palette_for_part(0, B, 0, palette)
        Costumes.set_palette_for_part(0, C, 0, palette)
        Costumes.set_palette_for_part(0, D, 0, palette)
        Costumes.set_palette_for_part(0, 10, 0, palette)
        Costumes.set_palette_for_part(0, 12, 0, palette)
        Costumes.set_palette_for_part(0, 13, 0, palette)
        Costumes.set_palette_for_part(0, 16, 0, palette)
        Costumes.set_palette_for_part(0, 18, 0, palette)
        Costumes.set_palette_for_part(0, 19, 0, palette)

        Costumes.set_stock_icon_palette_for_costume(0, Polygon/yellow_stock_icon.bin)
    }
}
