load("@toolchains_riscv_gnu//toolchain:toolchain.bzl", "riscv_none_elf_toolchain")

riscv_none_elf_toolchain(
    name = "riscv32_imac",
    copts = [
        "-march=rv32imac",
        "-mabi=ilp32",
        "-mcmodel=medlow",
        "-c",
        "-Wall",
        "-Wextra",
        "-fmessage-length=0",
    ],
    linkopts = [
        "-march=rv32imac",
        "-mabi=ilp32",
        "-mcmodel=medlow",
        "-nostdlib",
        "-nostartfiles",
    ],
    target_compatible_with = [
        "@platforms//cpu:riscv32",
        "@platforms//os:none",
        "//test/constraints/march:imac",
    ],
)
