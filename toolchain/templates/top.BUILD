"""
This BUILD file marks the top-level package of the generated toolchain
repository, i.e., the targets defined here appear in the workspace as
"@riscv_none_elf//:*" for riscv-none-elf toolchains.
"""

load("@toolchains_riscv_gnu//toolchain:toolchain.bzl", "hosts", "tools")

package(default_visibility = ["//visibility:public"])

TOOLS = tools + ["bin"]

[
    config_setting(
        name = host,
        constraint_values = constraint_values,
    )
    for host, constraint_values in hosts['%toolchain_prefix%'].items()
]

[
    filegroup(
        name = tool,
        srcs = select({
            host: ["@%toolchain_name%_{}//:{}".format(host, tool)]
            for host in hosts['%toolchain_prefix%'].keys()
        }),
        target_compatible_with = select({
            host: constraint_values
            for host, constraint_values in hosts['%toolchain_prefix%'].items()
        } | {
            "//conditions:default": ["@platforms//:incompatible"],
        }),
    )
    for tool in TOOLS
]
