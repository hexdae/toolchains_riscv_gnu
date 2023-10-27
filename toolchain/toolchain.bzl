"""
This module provides functions to register an arm-none-eabi toolchain
"""

load("@riscv_none_elf//toolchain:config.bzl", "cc_riscv_none_elf_config")

hosts = ["darwin_x86_64", "linux_x86_64", "linux_aarch64", "windows_x86_32"]

def register_riscv_none_elf_toolchain(name):
    native.register_toolchains(
        "{}_macos".format(name),
        "{}_linux_x86_64".format(name),
        "{}_linux_aarch64".format(name),
        "{}_windows_x86_32".format(name),
        "{}_windows_x86_64".format(name),
    )

def riscv_none_elf_toolchain(name, target_compatible_with = [], copts = [], linkopts = []):
    """
    Create an arm-none-eabi toolchain with the given configuration.

    Args:
        name: The name of the toolchain.
        target_compatible_with: A list of constraint values to apply to the toolchain.
        copts: A list of compiler options to apply to the toolchain.
        linkopts: A list of linker options to apply to the toolchain.
    """
    for host in hosts:
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
        name = "{}_macos".format(name),
        exec_compatible_with = ["@platforms//os:macos"],
        target_compatible_with = target_compatible_with,
        toolchain = ":cc_toolchain_darwin_x86_64_{}".format(name),
        toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
    )

    native.toolchain(
        name = "{}_linux_x86_64".format(name),
        exec_compatible_with = [
            "@platforms//os:linux",
            "@platforms//cpu:x86_64",
        ],
        target_compatible_with = target_compatible_with,
        toolchain = ":cc_toolchain_linux_x86_64_{}".format(name),
        toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
    )

    native.toolchain(
        name = "{}_linux_aarch64".format(name),
        exec_compatible_with = [
            "@platforms//os:linux",
            "@platforms//cpu:aarch64",
        ],
        target_compatible_with = target_compatible_with,
        toolchain = ":cc_toolchain_linux_aarch64_{}".format(name),
        toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
    )

    native.toolchain(
        name = "{}_windows_x86_32".format(name),
        exec_compatible_with = [
            "@platforms//os:windows",
            "@platforms//cpu:x86_32",
        ],
        target_compatible_with = target_compatible_with,
        toolchain = ":cc_toolchain_windows_x86_32_{}".format(name),
        toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
    )

    native.toolchain(
        name = "{}_windows_x86_64".format(name),
        exec_compatible_with = [
            "@platforms//os:windows",
            "@platforms//cpu:x86_64",
        ],
        target_compatible_with = target_compatible_with,
        # No 64bit source is available, so we reuse the 32bit one.
        toolchain = ":cc_toolchain_windows_x86_32_{}".format(name),
        toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
    )
