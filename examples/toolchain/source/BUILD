# project/BUILD.bazel

load("@rules_cc//cc:defs.bzl", "cc_binary")
load("@aspect_bazel_lib//lib:transitions.bzl", "platform_transition_filegroup")

cc_library(
    name = "startup",
    srcs = [
        "startup/entry.S",
        "startup/start.c",
    ],
    linkopts = ["-T$(location :startup/linker.ld)"],
    target_compatible_with = [
        "@platforms//os:none",
        "//constraints/march:imac",
    ],
    visibility = ["//visibility:public"],
    deps = [":startup/linker.ld"],
)

cc_binary(
    name = "baremetal",
    srcs = ["main.c"],
    deps = [":startup"],
)

platform_transition_filegroup(
    name = "elf_rv32imac",
    srcs = [":baremetal"],
    target_platform = "//platforms:rv32imac",
    visibility = ["//visibility:public"],
)

platform_transition_filegroup(
    name = "elf_rv64imac",
    srcs = [":baremetal"],
    target_platform = "//platforms:rv64imac",
    visibility = ["//visibility:public"],
)
