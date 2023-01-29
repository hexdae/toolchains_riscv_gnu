ARCH = [
    "-march=rv32imc",
    "-mabi=ilp32",
]

COPTS = ARCH + [
    "-c",
    "-Wall",
    "-Wextra",
    # "-O0",
    # "-g",
    "-fmessage-length=0",
    # "--specs=nosys.specs",
    "-mcmodel=medlow",
]

LINKOPTS = ARCH + [
    # "-Wall",
    # "-Wl,--no-relax",
    # "-Wl,--gc-sections",
    "-nostdlib",
    # "-nostartfiles",
    # "-lc",
    # "-lgcc",
    # "--specs=nosys.specs",
    # "-march=rv32imc",
    # "-mabi=ilp32",
    # "-mcmodel=medlow",
    # "-Bstatic",
]
