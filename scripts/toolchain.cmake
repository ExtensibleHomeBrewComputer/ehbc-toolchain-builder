set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR m68k)

set(CMAKE_C_COMPILER    /Users/gwonminsu/.local/bin/m68k-unknown-elf-gcc)
set(CMAKE_C_FLAGS       "-ffreestanding -nostdlib -march=68030 -m68881")
set(CMAKE_CXX_COMPILER  /Users/gwonminsu/.local/bin/m68k-unknown-elf-g++)
set(CMAKE_CXX_FLAGS     "-ffreestanding -nostdlib -march=68030 -m68881")
set(CMAKE_ASM_COMPILER  /Users/gwonminsu/.local/bin/m68k-unknown-elf-as)
set(CMAKE_ASM_FLAGS     "-march=68030 -m68881")
