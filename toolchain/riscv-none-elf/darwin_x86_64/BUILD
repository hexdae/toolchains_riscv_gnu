# toolchains/riscv-none-elf/darwin/BUILD.bazel

load("@riscv_none_elf//toolchain:config.bzl", "cc_riscv_none_elf_config")

package(default_visibility = ["//visibility:public"])

compiler = "riscv_none_elf_darwin_x86_64"

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
        "riscv-none-elf-gcc",
        "@{}//:compiler_pieces".format(compiler),
        "@{}//:gcc".format(compiler),
    ],
)

filegroup(
    name = "linker_files",
    srcs = [
        "riscv-none-elf-gcc",
        "riscv-none-elf-ld",
        "@{}//:ar".format(compiler),
        "@{}//:compiler_pieces".format(compiler),
        "@{}//:gcc".format(compiler),
        "@{}//:ld".format(compiler),
    ],
)

filegroup(
    name = "ar_files",
    srcs = [
        "riscv-none-elf-ar",
        "@{}//:ar".format(compiler),
    ],
)

filegroup(
    name = "objcopy_files",
    srcs = [
        "riscv-none-elf-objcopy",
        "@{}//:objcopy".format(compiler),
    ],
)

filegroup(
    name = "strip_files",
    srcs = [
        "riscv-none-elf-strip",
        "@{}//:strip".format(compiler),
    ],
)

cc_riscv_none_elf_config(
    name = "config",
    gcc_repo = compiler,
    gcc_version = "12.2.0",
    host_system_name = "darwin_x86_64",
    toolchain_identifier = "riscv_none_elf_darwin_x86_64",
    wrapper_path = "riscv-none-elf/darwin_x86_64",
)
