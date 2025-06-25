scope polygon_crash_costumes {
    // @ Description
    // Number of additional costumes
    constant NUM_EXTRA_COSTUMES(1)

    // @ Description
    // Number of parts
    constant NUM_PARTS(0x21)

    // @ Description
    // Number of original costumes
    constant NUM_COSTUMES(6)

    parts_table:
    constant PARTS_TABLE_ORIGIN(origin())
    // part 0x0 never has images, so we can store extra info here
    db NUM_EXTRA_COSTUMES       // 0x0 - number of extra costumes
    db 0x0                      // 0x1 - special part ID
    db 0x0                      // 0x2 - special part image index start
    db 0x0                      // 0x3 - costumes to skip
    fill 4 + (NUM_PARTS - 1) * 8

    Costumes.define_part(1, 1, Costumes.part_type.PALETTE)      // part 0x1_0 -  PolygonPart
    Costumes.define_part(2, 1, Costumes.part_type.PALETTE)      // part 0x2_0 -  PolygonPart
    Costumes.define_part(4, 1, Costumes.part_type.PALETTE)      // part 0x4_0 -  PolygonPart
    Costumes.define_part(5, 1, Costumes.part_type.PALETTE)      // part 0x5_0 -  PolygonPart
    Costumes.define_part(6, 1, Costumes.part_type.PALETTE)      // part 0x6_0 -  PolygonPart
    Costumes.define_part(7, 1, Costumes.part_type.PALETTE)      // part 0x7_0 -  PolygonPart
    Costumes.define_part(E, 1, Costumes.part_type.PALETTE)      // part 0xE_0 -  PolygonPart
    Costumes.define_part(F, 1, Costumes.part_type.PALETTE)      // part 0xG_0 -  PolygonPart
    Costumes.define_part(10, 1, Costumes.part_type.PALETTE)      // part 0x10_0 - PolygonPart
    Costumes.define_part(13, 1, Costumes.part_type.PALETTE)      // part 0x13_0 - PolygonPart
    Costumes.define_part(14, 1, Costumes.part_type.PALETTE)      // part 0x14_0 - PolygonPart
    Costumes.define_part(16, 1, Costumes.part_type.PALETTE)     // part 0x16_0 - PolygonPart
    Costumes.define_part(18, 1, Costumes.part_type.PALETTE)     // part 0x18_0 - PolygonPart
    Costumes.define_part(19, 1, Costumes.part_type.PALETTE)     // part 0x19_0 - PolygonPart
    Costumes.define_part(1B, 1, Costumes.part_type.PALETTE)     // part 0x1b_0 - PolygonPart

    // Register extra costumes
    Costumes.register_extra_costumes_for_char(Character.id.NCRASH)

    // Costume 0x6
    // Yellow Team
    scope costume_6 {
        palette:; insert "Polygon/yellow.bin"

        Costumes.set_palette_for_part(0, 1, 0, palette)
        Costumes.set_palette_for_part(0, 2, 0, palette)
        Costumes.set_palette_for_part(0, 4, 0, palette)
        Costumes.set_palette_for_part(0, 5, 0, palette)
        Costumes.set_palette_for_part(0, 6, 0, palette)
        Costumes.set_palette_for_part(0, 7, 0, palette)
        Costumes.set_palette_for_part(0, E, 0, palette)
        Costumes.set_palette_for_part(0, F, 0, palette)
        Costumes.set_palette_for_part(0, 10,0, palette)
        Costumes.set_palette_for_part(0, 13,0, palette)
        Costumes.set_palette_for_part(0, 14,0, palette)
        Costumes.set_palette_for_part(0, 16, 0, palette)
        Costumes.set_palette_for_part(0, 18, 0, palette)
        Costumes.set_palette_for_part(0, 19, 0, palette)
        Costumes.set_palette_for_part(0, 1B, 0, palette)

        Costumes.set_stock_icon_palette_for_costume(0, Polygon/yellow_stock_icon.bin)
    }
}
