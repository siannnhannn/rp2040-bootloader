# SConstruct.py

import os

from SCons.Environment import Environment
from SCons.Script import (
    ARGUMENTS,
    SConscript,
)
from SCons.Variables import (
    BoolVariable,
    EnumVariable,
    Variables,
)


vars = Variables("overrides.py", ARGUMENTS)

vars.AddVariables(
    EnumVariable(
        "stage2",
        help="stage2 selection",
        default="w25q080",
        allowed_values=("w25q080",),
    ),
    BoolVariable(
        "verbose_output",
        help="enable verbose output",
        default=False,
    ),
)


arch = "armv6s-m"
cpu = "cortex-m0plus"


env = Environment(
    ENV={
        "PATH": os.environ["PATH"],
        "TERM": os.environ.get("TERM"),
    },
    tools=[
        "default",
        "Stage2Crc32",
        "github.jacobkoziej.scons-tools.Binutils.ObjCopy",
    ],
    variables=vars,
)
env.Replace(
    AR="arm-none-eabi-ar",
    AS="arm-none-eabi-gcc",
    CC="arm-none-eabi-gcc",
    CXX="arm-none-eabi-g++",
    LINK="arm-none-eabi-gcc",
    OBJCOPY="arm-none-eabi-objcopy",
    RANLIB="arm-none-eabi-gcc-ranlib",
    PROGSUFFIX=".elf",
)

common_flags = [
    "-O0",
    "-Wall",
    "-Wextra",
    "-Wl,--library-path=ld",
    "-Wl,--no-warn-rwx-segments",
    "-Wl,--script=ld/bootloader.ld",
    "-Wpedantic",
    "-fdata-sections",
    "-ffunction-sections",
    "-ggdb",
    "-nostartfiles",
    "-std=c2x",
    f"-march={arch}",
    f"-mcpu={cpu}",
]

env.AppendUnique(
    ASFLAGS=common_flags,
    CCFLAGS=common_flags,
    LINKFLAGS=common_flags,
)

if not env["verbose_output"]:
    env.AppendUnique(
        ARCOMSTR="ar $TARGET",
        ASCOMSTR="as $TARGET",
        ASPPCOMSTR="as $TARGET",
        CCCOMSTR="cc $TARGET",
        CXXCOMSTR="c++ $TARGET",
        LINKCOMSTR="ld $TARGET",
        OBJCOPYCOMSTR="objcopy $TARGET",
        RANLIBCOMSTR="ranlib $TARGET",
        STAGE2CRC32COMSTR="crc32 $TARGET",
    )


build = "build"

src = SConscript(
    "src/SConscript.py",
    exports=[
        "env",
    ],
    variant_dir=f"{build}/src",
)
