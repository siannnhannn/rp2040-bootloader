# SConscript.py

# ruff: noqa: F821

from SCons.Script import (
    Import,
    Return,
    SConscript,
)


Import("env")

stage2 = SConscript(
    "stage2/SConscript.py",
    exports=[
        "env",
    ],
)

bootloader = env.Program(
    target="bootloader",
    source=[
        "crt0.S",
        "vectors.S",
        "main.c",
    ]
    + stage2,
)

Return("bootloader")
