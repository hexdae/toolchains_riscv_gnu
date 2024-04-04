load("@toolchains_riscv_gnu//toolchain:toolchain.bzl", "riscv_none_elf_toolchain")

riscv_none_elf_toolchain(
    name = "rv32imac",
    copts = [
        "-march=rv32imac",
        "-mabi=ilp32",
        "-mcmodel=medlow",
        "-fdiagnostics-color=always",
        "-fmessage-length=0",
        "-Wall",
        "-Wextra",
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
        "//constraints/march:imac",
    ],
)

riscv_none_elf_toolchain(
    name = "rv64imac",
    copts = [
        "-march=rv64imac",
        "-mabi=lp64",
        "-mcmodel=medany",
        "-fdiagnostics-color=always",
        "-fmessage-length=0",
        "-Wall",
        "-Wextra",
    ],
    linkopts = [
        "-march=rv64imac",
        "-mabi=lp64",
        "-mcmodel=medany",
        "-nostdlib",
        "-nostartfiles",
    ],
    target_compatible_with = [
        "@platforms//cpu:riscv64",
        "@platforms//os:none",
        "//constraints/march:imac",
    ],
)
