from SCons.Action import Action
from SCons.Builder import BuilderBase
from SCons.Script.SConscript import SConsEnvironment

def generate(env: SConsEnvironment) -> None:
    if env.Detect("Incbin"):
        return
    
    builder: BuilderBase = env.Builder(
            action=Action(
                "./site_scons/incbin.py --section .app --path $SOURCE --output $TARGET", "$INCBINCOMSTR",
            ),
    )

    env["BUILDERS"]["Incbin"] = builder

def exists(env: SConsEnvironment) -> bool:
    return env.Detect("Incbin")
