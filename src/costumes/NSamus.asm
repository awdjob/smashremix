scope polygon_samus_costumes {
    // @ Description
    // Number of additional costumes
    constant NUM_EXTRA_COSTUMES(1)

    // @ Description
    // Number of parts
    constant NUM_PARTS(0x20)

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

    Costumes.define_part(1, 1, Costumes.part_type.PALETTE)                         // part 0x1_0 - pelvis
    Costumes.define_part(2, 1, Costumes.part_type.PALETTE)                         // part 0x2_0 - torso
    // Costumes.define_special_parts_for_part(2, 3)                                   // part 0x2_0_0 - morphball none? not used
    // Costumes.add_special_part(2, 1, 1, Costumes.part_type.PALETTE)                 // part 0x2_1_0 - morphball large
    // Costumes.add_special_part(2, 2, 1, Costumes.part_type.PALETTE)                 // part 0x2_2_0 - morphball small
    Costumes.define_part(4, 1, Costumes.part_type.PALETTE)                         // part 0x4_0 - left upper arm
    Costumes.define_part(5, 1, Costumes.part_type.PALETTE)                         // part 0x5_0 - left lower arm
    Costumes.define_part(6, 1, Costumes.part_type.PALETTE)                         // part 0x6_0 - left hand
    Costumes.define_part(9, 1, Costumes.part_type.PALETTE)                         // part 0x9_0 - head
    Costumes.define_part(B, 1, Costumes.part_type.PALETTE)                         // part 0xB_0 - right upper arm
    Costumes.define_part(C, 1, Costumes.part_type.PALETTE)                         // part 0xC_0 - right lower arm
    Costumes.define_part(17, 1, Costumes.part_type.PALETTE)                        // part 0x17_0 - left upper leg
    Costumes.define_part(18, 1, Costumes.part_type.PALETTE)                        // part 0x18_0 - left lower leg
    Costumes.define_part(1A, 1, Costumes.part_type.PALETTE)                        // part 0x1A_0 - left foot
    Costumes.define_part(1C, 1, Costumes.part_type.PALETTE)                        // part 0x1C_0 - right upper leg
    Costumes.define_part(1D, 1, Costumes.part_type.PALETTE)                        // part 0x1D_0 - right lower leg
    Costumes.define_part(1F, 1, Costumes.part_type.PALETTE)                        // part 0x1F_0 - right foot

    // Register extra costumes
    Costumes.register_extra_costumes_for_char(Character.id.NSAMUS)

    // Costume 0x6
    // Yellow Team
    scope costume_0x6 {
        palette:; insert "Polygon/yellow.bin"

        Costumes.set_palette_for_part(0, 1, 0, palette)
        Costumes.set_palette_for_part(0, 2, 0, palette)
        // Costumes.set_palette_for_special_part(0, 2, 1, 0, palette)
        // Costumes.set_palette_for_special_part(0, 2, 2, 0, palette)
        Costumes.set_palette_for_part(0, 4, 0, palette)
        Costumes.set_palette_for_part(0, 5, 0, palette)
        Costumes.set_palette_for_part(0, 6, 0, palette)
        Costumes.set_palette_for_part(0, 9, 0, palette)
        Costumes.set_palette_for_part(0, B, 0, palette)
        Costumes.set_palette_for_part(0, C, 0, palette)
        Costumes.set_palette_for_part(0, 17, 0, palette)
        Costumes.set_palette_for_part(0, 18, 0, palette)
        Costumes.set_palette_for_part(0, 1A, 0, palette)
        Costumes.set_palette_for_part(0, 1C, 0, palette)
        Costumes.set_palette_for_part(0, 1D, 0, palette)
        Costumes.set_palette_for_part(0, 1F, 0, palette)

        Costumes.set_stock_icon_palette_for_costume(0, Polygon/yellow_stock_icon.bin)
    }

}
