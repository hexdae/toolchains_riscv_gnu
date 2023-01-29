# project/BUILD.bazel

load("@rules_cc//cc:defs.bzl", "cc_binary")
load("//examples/baremetal/startup:riscv.bzl", "COPTS")

cc_binary(
    name = "baremetal",
    srcs = ["main.c"],
    copts = COPTS,
    target_compatible_with = [
        "@platforms//cpu:riscv64",
        "@platforms//os:none",
    ],
    deps = ["//examples/baremetal/startup"],
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
