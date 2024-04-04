load("@rules_cc//cc:defs.bzl", "cc_library")

cc_library(
    name = "startup",
    srcs = [
        "entry.S",
        "start.c",
    ],
    linkopts = ["-T$(location :linker.ld)"],
    target_compatible_with = [
        "@platforms//cpu:riscv32",
        "@platforms//os:none",
        "//test/constraints/march:imac",
    ],
    visibility = ["//visibility:public"],
    deps = [":linker.ld"],
)
