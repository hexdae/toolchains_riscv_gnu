# project/BUILD.bazel

load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library")
load("@aspect_bazel_lib//lib:transitions.bzl", "platform_transition_filegroup")

platform(
    name = "riscv32",
    constraint_values = [
        "@platforms//cpu:riscv32",
        "@platforms//os:none",
    ],
)

cc_library(
    name = "mock_library",
    srcs = ["lib.cc"],
    hdrs = ["lib.h"],
    copts = [
        "-march=rv32ima",
        "-mabi=ilp32",
    ],
    includes = ["includes"],
    target_compatible_with = [
        "@platforms//cpu:riscv32",
        "@platforms//os:none",
    ],
)

cc_binary(
    name = "mock_binary",
    srcs = ["main.cc"],
    copts = [
        "-march=rv32ima",
        "-mabi=ilp32",
    ],
    linkopts = [
        "-nostartfiles",
        "-Wl,--entry,main",
    ],
    deps = [":mock_library"],
)

platform_transition_filegroup(
    name = "elf",
    srcs = [":mock_binary"],
    target_platform = ":riscv32",
)

genrule(
    name = "bin",
    srcs = [":elf"],
    outs = ["mock.bin"],
    cmd = "$(execpath @riscv_none_elf//:objcopy) -O binary $< $@",
    tools = ["@riscv_none_elf//:objcopy"],
)

genrule(
    name = "hex",
    srcs = [":elf"],
    outs = ["mock.hex"],
    cmd = "$(execpath @riscv_none_elf//:objcopy) -O ihex $< $@",
    tools = ["@riscv_none_elf//:objcopy"],
    visibility = ["//visibility:public"],
)
