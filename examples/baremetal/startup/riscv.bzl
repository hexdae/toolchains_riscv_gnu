ARCH = [
    "-march=rv32imc",
    "-mabi=ilp32",
]

COPTS = ARCH + [
    "-c",
    "-Wall",
    "-Wextra",
    "-fmessage-length=0",
    "-mcmodel=medlow",
]

LINKOPTS = ARCH + [
    "-nostdlib",
]
