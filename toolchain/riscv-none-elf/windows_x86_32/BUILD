# toolchains/riscv-none-elf/windows/BUILD.bazel

load("@riscv_none_elf//toolchain:config.bzl", "cc_riscv_none_elf_config")

package(default_visibility = ["//visibility:public"])

compiler = "riscv_none_elf_windows_x86_32"

filegroup(
    name = "all_files",
    srcs = [
        ":ar_files",
        ":compiler_files",
        ":linker_files",
        "@{}//:compiler_pieces".format(compiler),
    ],
)

filegroup(
    name = "compiler_files",
    srcs = [
        "riscv-none-elf-gcc.bat",
        "@{}//:compiler_pieces".format(compiler),
        "@{}//:gcc".format(compiler),
    ],
)

filegroup(
    name = "linker_files",
    srcs = [
        "riscv-none-elf-gcc.bat",
        "riscv-none-elf-ld.bat",
        "@{}//:ar".format(compiler),
        "@{}//:compiler_pieces".format(compiler),
        "@{}//:gcc".format(compiler),
        "@{}//:ld".format(compiler),
    ],
)

filegroup(
    name = "ar_files",
    srcs = [
        "riscv-none-elf-ar.bat",
        "@{}//:compiler_pieces".format(compiler),
        "@{}//:ar".format(compiler),
    ],
)

filegroup(
    name = "objcopy_files",
    srcs = [
        "riscv-none-elf-objcopy.bat",
        "@{}//:objcopy".format(compiler),
    ],
)

filegroup(
    name = "strip_files",
    srcs = [
        "riscv-none-elf-strip.bat",
        "@{}//:strip".format(compiler),
    ],
)

cc_riscv_none_elf_config(
    name = "config",
    gcc_repo = compiler,
    gcc_version = "12.2.0",
    host_system_name = "x86-windows",
    toolchain_identifier = "riscv_none_elf_windows_x86_32",
    wrapper_ext = ".bat",
    wrapper_path = "riscv-none-elf/windows_x86_32",
)
