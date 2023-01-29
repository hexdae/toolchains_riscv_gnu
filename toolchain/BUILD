# toolchains/BUILD.bazel

load("@rules_cc//cc:defs.bzl", "cc_toolchain")

cc_toolchain(
    name = "cc_toolchain_darwin",
    all_files = "//toolchain/riscv-none-elf/darwin_x86_64:all_files",
    ar_files = "//toolchain/riscv-none-elf/darwin_x86_64:ar_files",
    compiler_files = "//toolchain/riscv-none-elf/darwin_x86_64:compiler_files",
    dwp_files = ":empty",
    linker_files = "//toolchain/riscv-none-elf/darwin_x86_64:linker_files",
    objcopy_files = "//toolchain/riscv-none-elf/darwin_x86_64:objcopy_files",
    strip_files = "//toolchain/riscv-none-elf/darwin_x86_64:strip_files",
    supports_param_files = 0,
    toolchain_config = "//toolchain/riscv-none-elf/darwin_x86_64:config",
    toolchain_identifier = "riscv_none_elf_darwin",
)

cc_toolchain(
    name = "cc_toolchain_linux_x86_64",
    all_files = "//toolchain/riscv-none-elf/linux_x86_64:all_files",
    ar_files = "//toolchain/riscv-none-elf/linux_x86_64:ar_files",
    compiler_files = "//toolchain/riscv-none-elf/linux_x86_64:compiler_files",
    dwp_files = ":empty",
    linker_files = "//toolchain/riscv-none-elf/linux_x86_64:linker_files",
    objcopy_files = "//toolchain/riscv-none-elf/linux_x86_64:objcopy_files",
    strip_files = "//toolchain/riscv-none-elf/linux_x86_64:strip_files",
    supports_param_files = 0,
    toolchain_config = "//toolchain/riscv-none-elf/linux_x86_64:config",
    toolchain_identifier = "riscv_none_elf_linux_x86_64",
)

cc_toolchain(
    name = "cc_toolchain_linux_aarch64",
    all_files = "//toolchain/riscv-none-elf/linux_aarch64:all_files",
    ar_files = "//toolchain/riscv-none-elf/linux_aarch64:ar_files",
    compiler_files = "//toolchain/riscv-none-elf/linux_aarch64:compiler_files",
    dwp_files = ":empty",
    linker_files = "//toolchain/riscv-none-elf/linux_aarch64:linker_files",
    objcopy_files = "//toolchain/riscv-none-elf/linux_aarch64:objcopy_files",
    strip_files = "//toolchain/riscv-none-elf/linux_aarch64:strip_files",
    supports_param_files = 0,
    toolchain_config = "//toolchain/riscv-none-elf/linux_aarch64:config",
    toolchain_identifier = "riscv_none_elf_linux_aarch64",
)

cc_toolchain(
    name = "cc_toolchain_windows_x86_32",
    all_files = "//toolchain/riscv-none-elf/windows_x86_32:all_files",
    ar_files = "//toolchain/riscv-none-elf/windows_x86_32:ar_files",
    compiler_files = "//toolchain/riscv-none-elf/windows_x86_32:compiler_files",
    dwp_files = ":empty",
    linker_files = "//toolchain/riscv-none-elf/windows_x86_32:linker_files",
    objcopy_files = "//toolchain/riscv-none-elf/windows_x86_32:objcopy_files",
    strip_files = "//toolchain/riscv-none-elf/windows_x86_32:strip_files",
    supports_param_files = 0,
    toolchain_config = "//toolchain/riscv-none-elf/windows_x86_32:config",
    toolchain_identifier = "riscv_none_elf_windows_x86_32",
)

toolchain(
    name = "macos",
    exec_compatible_with = [
        "@platforms//os:macos",
    ],
    target_compatible_with = [
        "@platforms//os:none",
        "@platforms//cpu:riscv64",
    ],
    toolchain = ":cc_toolchain_darwin",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

toolchain(
    name = "linux_x86_64",
    exec_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
    target_compatible_with = [
        "@platforms//os:none",
        "@platforms//cpu:riscv64",
    ],
    toolchain = ":cc_toolchain_linux_x86_64",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

toolchain(
    name = "linux_aarch64",
    exec_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:aarch64",
    ],
    target_compatible_with = [
        "@platforms//os:none",
        "@platforms//cpu:riscv64",
    ],
    toolchain = ":cc_toolchain_linux_aarch64",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

toolchain(
    name = "windows_x86_32",
    exec_compatible_with = [
        "@platforms//os:windows",
        "@platforms//cpu:x86_32",
    ],
    target_compatible_with = [
        "@platforms//os:none",
        "@platforms//cpu:riscv64",
    ],
    toolchain = ":cc_toolchain_windows_x86_32",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

toolchain(
    name = "windows_x86_64",
    exec_compatible_with = [
        "@platforms//os:windows",
        "@platforms//cpu:x86_64",
    ],
    target_compatible_with = [
        "@platforms//os:none",
        "@platforms//cpu:riscv64",
    ],
    # No 64bit source is available, so we reuse the 32bit one.
    toolchain = ":cc_toolchain_windows_x86_32",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)
