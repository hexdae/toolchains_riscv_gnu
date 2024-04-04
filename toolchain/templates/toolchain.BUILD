"""
This BUILD file defines the toolchain targets for bzlmod consumers. It is
rendered into the //toolchain package of the generated toolchain repository.
For example, "@riscv_none_elf//toolchain:*"
"""

package(default_visibility = ["//visibility:public"])

load(
    "@toolchains_riscv_gnu//toolchain:toolchain.bzl",
    "%toolchain_name%_toolchain",
    "target_constraints",
)

[
    %toolchain_name%_toolchain(
        name = name,
        version = "%version%",
        target_compatible_with = constraints,
    )
    for name, constraints in target_constraints['%toolchain_prefix%'].items()
]
