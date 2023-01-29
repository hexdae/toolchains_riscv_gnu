load("@rules_cc//cc:defs.bzl", "cc_library")
load("riscv.bzl", "COPTS", "LINKOPTS")

cc_library(
    name = "startup",
    srcs = [
        "entry.S",
        "start.c",
    ],
    copts = COPTS,
    linkopts = LINKOPTS + ["-T$(location :linker.ld)"],
    target_compatible_with = [
        "@platforms//cpu:riscv64",
        "@platforms//os:none",
    ],
    visibility = ["//visibility:public"],
    deps = [":linker.ld"],
)
