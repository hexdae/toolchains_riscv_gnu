"""
This module provides functions to register an arm-none-eabi toolchain
"""

load("@riscv_none_elf//toolchain:config.bzl", "cc_riscv_none_elf_config")

hosts = {
    "darwin_x86_64": ["@platforms//os:macos", "@platforms//cpu:x86_64"],
    "darwin_arm64": ["@platforms//os:macos", "@platforms//cpu:arm64"],
    "linux_x86_64": ["@platforms//os:linux", "@platforms//cpu:x86_64"],
    "linux_aarch64": ["@platforms//os:linux", "@platforms//cpu:arm64"],
    "windows_x86_64": ["@platforms//os:windows", "@platforms//cpu:x86_64"],
}

def riscv_none_elf_toolchain(name, target_compatible_with = [], copts = [], linkopts = []):
    """
    Create an arm-none-eabi toolchain with the given configuration.

    Args:
        name: The name of the toolchain.
        target_compatible_with: A list of constraint values to apply to the toolchain.
        copts: A list of compiler options to apply to the toolchain.
        linkopts: A list of linker options to apply to the toolchain.
    """
    for host, exec_compatible_with in hosts.items():
        cc_riscv_none_elf_config(
            name = "config_{}_{}".format(host, name),
            gcc_repo = "riscv_none_elf_{}".format(host),
            gcc_version = "12.2.0",
            host_system_name = host,
            toolchain_identifier = "riscv_none_elf_{}_{}".format(host, name),
            toolchain_bins = "@riscv_none_elf_{}//:compiler_components".format(host),
            copts = copts,
            linkopts = linkopts,
        )

        native.cc_toolchain(
            name = "cc_toolchain_{}_{}".format(host, name),
            all_files = "@riscv_none_elf_{}//:compiler_pieces".format(host),
            ar_files = "@riscv_none_elf_{}//:ar_files".format(host),
            compiler_files = "@riscv_none_elf_{}//:compiler_files".format(host),
            dwp_files = ":empty",
            linker_files = "@riscv_none_elf_{}//:linker_files".format(host),
            objcopy_files = "@riscv_none_elf_{}//:objcopy".format(host),
            strip_files = "@riscv_none_elf_{}//:strip".format(host),
            supports_param_files = 0,
            toolchain_config = ":config_{}_{}".format(host, name),
            toolchain_identifier = "riscv_none_elf_{}_{}".format(host, name),
        )

        native.toolchain(
            name = "{}_{}".format(name, host),
            exec_compatible_with = exec_compatible_with,
            target_compatible_with = target_compatible_with,
            toolchain = ":cc_toolchain_{}_{}".format(host, name),
            toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
        )

def register_riscv_none_elf_toolchain(name):
    for host in hosts:
        native.register_toolchains("{}_{}".format(name, host))
