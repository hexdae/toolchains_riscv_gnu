# toolchain/BUILD

load("@riscv_none_elf//toolchain:toolchain.bzl", "riscv_none_elf_toolchain")

riscv_none_elf_toolchain(
    name = "riscv32",
    target_compatible_with = [
        "@platforms//cpu:riscv32",
        "@platforms//os:none",
    ],
)


riscv_none_elf_toolchain(
    name = "riscv64",
    target_compatible_with = [
        "@platforms//cpu:riscv64",
        "@platforms//os:none",
    ],
)
