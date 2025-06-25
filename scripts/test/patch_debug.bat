assembler\bass.exe -o "ssb64asm.z64" -create main.asm -create -sym logfile.log -d DEBUG > output.log
assembler\chksum64.exe "ssb64asm.z64" > nul
assembler\rn64crc.exe -u > nul
@echo %cmdcmdline%|find /i """%~f0""">nul && pause