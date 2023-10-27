load("@riscv_none_elf//toolchain:toolchain.bzl", "riscv_none_elf_toolchain")

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
        "-nostdlib",
    ],
    target_compatible_with = [
        "@platforms//cpu:riscv32",
        "@platforms//os:none",
        "//constraints:imac",
    ],
)
