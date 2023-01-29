# BUILD

package(default_visibility = ["//visibility:public"])

config_setting(
    name = "darwin",
    constraint_values = [
        "@platforms//os:macos",
    ],
)

config_setting(
    name = "linux",
    constraint_values = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
    ],
)

config_setting(
    name = "windows",
    constraint_values = [
        "@platforms//cpu:x86_64",
        "@platforms//os:windows",
    ],
)

filegroup(
    name = "gcc",
    srcs = select({
        "darwin": ["@riscv_none_elf_darwin_x86_64//:bin/riscv-none-elf-gcc"],
        "linux": ["@riscv_none_elf_linux_x86_64//:bin/riscv-none-elf-gcc"],
        "windows": ["@riscv_none_elf_windows_x86_32//:bin/riscv-none-elf-gcc.exe"],
    }),
)

filegroup(
    name = "ar",
    srcs = select({
        "darwin": ["@riscv_none_elf_darwin_x86_64//:bin/riscv-none-elf-ar"],
        "linux": ["@riscv_none_elf_linux_x86_64//:bin/riscv-none-elf-ar"],
        "windows": ["@riscv_none_elf_windows_x86_32//:bin/riscv-none-elf-ar.exe"],
    }),
)

filegroup(
    name = "ld",
    srcs = select({
        "darwin": ["@riscv_none_elf_darwin_x86_64//:bin/riscv-none-elf-ld"],
        "linux": ["@riscv_none_elf_linux_x86_64//:bin/riscv-none-elf-ld"],
        "windows": ["@riscv_none_elf_windows_x86_32//:bin/riscv-none-elf-ld.exe"],
    }),
)

filegroup(
    name = "nm",
    srcs = select({
        "darwin": ["@riscv_none_elf_darwin_x86_64//:bin/riscv-none-elf-nm"],
        "linux": ["@riscv_none_elf_linux_x86_64//:bin/riscv-none-elf-nm"],
        "windows": ["@riscv_none_elf_windows_x86_32//:bin/riscv-none-elf-nm.exe"],
    }),
)

filegroup(
    name = "objcopy",
    srcs = select({
        "darwin": ["@riscv_none_elf_darwin_x86_64//:bin/riscv-none-elf-objcopy"],
        "linux": ["@riscv_none_elf_linux_x86_64//:bin/riscv-none-elf-objcopy"],
        "windows": ["@riscv_none_elf_windows_x86_32//:bin/riscv-none-elf-objcopy.exe"],
    }),
)

filegroup(
    name = "objdump",
    srcs = select({
        "darwin": ["@riscv_none_elf_darwin_x86_64//:bin/riscv-none-elf-objdump"],
        "linux": ["@riscv_none_elf_linux_x86_64//:bin/riscv-none-elf-objdump"],
        "windows": ["@riscv_none_elf_windows_x86_32//:bin/riscv-none-elf-objdump.exe"],
    }),
)

filegroup(
    name = "strip",
    srcs = select({
        "darwin": ["@riscv_none_elf_darwin_x86_64//:bin/riscv-none-elf-strip"],
        "linux": ["@riscv_none_elf_linux_x86_64//:bin/riscv-none-elf-strip"],
        "windows": ["@riscv_none_elf_windows_x86_32//:bin/riscv-none-elf-strip.exe"],
    }),
)

filegroup(
    name = "as",
    srcs = select({
        "darwin": ["@riscv_none_elf_darwin_x86_64//:bin/riscv-none-elf-as"],
        "linux": ["@riscv_none_elf_linux_x86_64//:bin/riscv-none-elf-as"],
        "windows": ["@riscv_none_elf_windows_x86_32//:bin/riscv-none-elf-as.exe"],
    }),
)

filegroup(
    name = "gdb",
    srcs = select({
        "darwin": ["@riscv_none_elf_darwin_x86_64//:bin/riscv-none-elf-gdb"],
        "linux": ["@riscv_none_elf_linux_x86_64//:bin/riscv-none-elf-gdb"],
        "windows": ["@riscv_none_elf_windows_x86_32//:bin/riscv-none-elf-gdb.exe"],
    }),
)
