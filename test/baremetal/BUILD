# project/BUILD.bazel

load("@rules_cc//cc:defs.bzl", "cc_binary")
load("@aspect_bazel_lib//lib:transitions.bzl", "platform_transition_filegroup")

cc_binary(
    name = "baremetal",
    srcs = ["main.c"],
    deps = ["//test/baremetal/startup"],
)

platform_transition_filegroup(
    name = "elf",
    srcs = [":baremetal"],
    target_platform = "//test/platforms:riscv32_imac",
)

genrule(
    name = "bin",
    srcs = [":elf"],
    outs = ["baremetal.bin"],
    cmd = "$(execpath @riscv_none_elf//:objcopy) -O binary $< $@",
    tools = ["@riscv_none_elf//:objcopy"],
)

genrule(
    name = "hex",
    srcs = [":elf"],
    outs = ["baremetal.hex"],
    cmd = "$(execpath @riscv_none_elf//:objcopy) -O ihex $< $@",
    tools = ["@riscv_none_elf//:objcopy"],
    visibility = ["//visibility:public"],
)

genrule(
    name = "size",
    srcs = [":elf"],
    outs = ["baremetal.size"],
    cmd = "$(execpath @riscv_none_elf//:size) $< > $@",
    tools = ["@riscv_none_elf//:size"],
)
