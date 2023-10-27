load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library")

RISCV32_IMAC = [
    "@platforms//cpu:riscv32",
    "@platforms//os:none",
    "//constraints:imac",
]

cc_library(
    name = "startup",
    srcs = [
        "entry.S",
        "start.c",
    ],
    linkopts = ["-T$(location :linker.ld)"],
    target_compatible_with = RISCV32_IMAC,
    deps = [":linker.ld"],
    alwayslink = True,
)

cc_binary(
    name = "baremetal",
    srcs = ["main.c"],
    target_compatible_with = RISCV32_IMAC,
    deps = [":startup"],
)

genrule(
    name = "bin",
    srcs = [":baremetal"],
    outs = ["baremetal.bin"],
    cmd = "$(execpath @riscv_none_elf//:objcopy) -O binary $< $@",
    tools = ["@riscv_none_elf//:objcopy"],
)

genrule(
    name = "hex",
    srcs = [":baremetal"],
    outs = ["baremetal.hex"],
    cmd = "$(execpath @riscv_none_elf//:objcopy) -O ihex $< $@",
    tools = ["@riscv_none_elf//:objcopy"],
)

genrule(
    name = "size",
    srcs = [":baremetal"],
    outs = ["baremetal.size"],
    cmd = "$(execpath @riscv_none_elf//:size) $< > $@",
    tools = ["@riscv_none_elf//:size"],
)
