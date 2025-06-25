// Crash.asm
if !{defined __CRASH__} {
define __CRASH__()
print "included Crash.asm\n"

scope Crash {
    // @ Description
    // These patches disable button checks for the debugger by changing the contents of a0 from
    // random button masks to none.
    OS.patch_start(0x00024088, 0x80023488)
    lli     a0, 0x0000
    OS.patch_end()
    OS.patch_start(0x000240A0, 0x800234A0)
    lli     a0, 0x0000
    OS.patch_end()
    OS.patch_start(0x000240B8, 0x800234B8)
    lli     a0, 0x0000
    OS.patch_end()
    OS.patch_start(0x000240D0, 0x800234D0)
    lli     a0, 0x0000
    OS.patch_end()
    OS.patch_start(0x000240E8, 0x800234E8)
    lli     a0, 0x0000
    OS.patch_end()

    // @ Description
    // Open crash debugger automatically without waiting for input sequence
    // Normally requires: Z+L+R, DU+CU, DL+A, DR+B, DD+CD
    OS.patch_start(0x23E04, 0x80023204)
    j       0x80023278      // skip button checks (syErrorReportCPUBreakFault)
    nop
    OS.patch_end()
    OS.patch_start(0x2426C, 0x8002366C)
    j       0x800236E0      // skip button checks (syErrorPrintf)
    nop
    OS.patch_end()
    OS.patch_start(0x24080, 0x80023480)
    j       0x800234F4      // skip button checks (syErrorFileLoaderThread8)
    nop                     // note: Same one as "disable button checks" above
    OS.patch_end()

}

} // __CRASH__