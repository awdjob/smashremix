// PAL.asm
if !{defined __PAL__} && {defined MAKE_PAL} {
define __PAL__()
print "included PAL.asm\n"

// @ Description
// Converts to PAL compatible ROM
// Only supports PAL60
// Shout out Gent

scope PAL {

    // @ Description
    // This sets osTvType to NTSC on Boot.
    // It uses a trick to run instructions off the ROM directly since our expansion RAM isn't loaded yet
    scope update_tv_type_: {
        // Let's put this before the start of our custom ASM...
        // This way it doesn't exist in RAM, since that's not necessary,
        // which keeps all offsets the same for both PAL and non-PAL
        constant update_tv_type_rom_address(0x02400000 - 0x30)

        OS.patch_start(0x1000, 0x80000400)
        li       t0, update_tv_type_rom_address | 0xB0000000
        jr       t0
        nop
        update_tv_type_return_:
        OS.patch_end()

        pushvar origin, base
        origin update_tv_type_rom_address
        lui     t0, 0x8000
        lli     t1, 0x0001                  // t1 = NTSC osTvType (1 = NTSC, 0 = PAL, 2 = MPAL)
        sw      t1, 0x0300(t0)              // set osTvType
        lui     t0, 0x8004                  // original line 1
        lui     t1, 0x0006                  // original line 2
        addiu   t0, t0, 0xFAD0              // original line 3
        li      t2, update_tv_type_return_
        jr      t2
        ori     t1, t1, 0x1EA0              // original line 4
        OS.patch_end()
    }

    // Set Region to PAL
    pushvar origin, base
    origin 0x3E
    db 'P'
    OS.patch_end()

    // VI Settings?
    pushvar origin, base
    origin 0x3DF3C
    dw 0x0404233A
    dw 0x00000271
    dw 0x00150C69
    dw 0x0C6F0C6E
    dw 0x00800300
    dw 0x00000200
    dw 0x00000000
    dw 0x00000280
    dw 0x00000400
    dw 0x005F0239
    dw 0x0009026B
    dw 0x00000002
    dw 0x00000280
    dw 0x00000400
    dw 0x005F0239
    dw 0x0009026B
    OS.patch_end()

    // VI Settings?
    pushvar origin, base
    origin 0x3E0BC
    dw 0x0404233A
    dw 0x00000271
    dw 0x00150C69
    dw 0x0C6F0C6E
    dw 0x00800300
    dw 0x00000200
    dw 0x00000000
    dw 0x00000280
    dw 0x00000400
    dw 0x005F0239
    dw 0x0009026B
    dw 0x00000002
    dw 0x00000280
    dw 0x00000400
    dw 0x005F0239
    dw 0x0009026B
    OS.patch_end()

    // VI Settings?
    pushvar origin, base
    origin 0x3E10C
    dw 0x0404233A
    dw 0x00000271
    dw 0x00150C69
    dw 0x0C6F0C6E
    dw 0x00800300
    dw 0x00000200
    dw 0x00000000
    dw 0x00000280
    dw 0x00000400
    dw 0x005F0239
    dw 0x0009026B
    dw 0x00000002
    dw 0x00000280
    dw 0x00000400
    dw 0x005F0239
    dw 0x0009026B
    OS.patch_end()
}

} // __PAL__
