# project/BUILD.bazel

load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library")

cc_library(
    name = "mock_library",
    srcs = ["lib.cc"],
    hdrs = ["lib.h"],
    copts = [
        "-march=rv32ima",
        "-mabi=ilp32",
    ],
    includes = ["includes"],
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

genrule(
    name = "mock_bin",
    srcs = [":mock_binary"],
    outs = ["mock.bin"],
    cmd = "$(execpath @riscv_none_elf//:objcopy) -O binary $< $@",
    tools = ["@riscv_none_elf//:objcopy"],
)

genrule(
    name = "mock_hex",
    srcs = [":mock_binary"],
    outs = ["mock.hex"],
    cmd = "$(execpath @riscv_none_elf//:objcopy) -O ihex $< $@",
    tools = ["@riscv_none_elf//:objcopy"],
)
