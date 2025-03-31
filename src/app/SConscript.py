from SCons.Script import (
    Import,
    Return,
) 

Import("env")

link_flags = list(
    filter(
        lambda x: not x.startswith("-Wl,--script="),
        env["LINKFLAGS"],
    )
)

link_flags += ["-Wl,--script=ld/app.ld"]

app = env.Program(
        "app",
        source=[
            "vectors.S",
            "app_main.c",
            "app_header.c",
            "crt0.S",
        ],
        LIBS = [],
        LINKFLAGS=link_flags,
)

app_bin = env.ObjCopy(
    "app.bin",
    app,
    OBJCOPYFLAGS="--output-target=binary",
)

app = env.Incbin("app.S", app_bin)

Return("app")
