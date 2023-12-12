# toolchains/compiler.BUILD

package(default_visibility = ["//visibility:public"])

# export the executable files to make them available for direct use.
exports_files(glob(["**"], exclude_directories = 0))

# gcc executables.
filegroup(
    name = "gcc",
    srcs = glob(["bin/riscv-none-elf-gcc*"]),
)

# cpp executables.
filegroup(
    name = "cpp",
    srcs = glob(["bin/riscv-none-elf-cpp*"]),
)

# gcov executables.
filegroup(
    name = "gcov",
    srcs = glob(["bin/riscv-none-elf-gcov*"]),
)

# gdb executables.
filegroup(
    name = "gdb",
    srcs = glob(["bin/riscv-none-elf-gdb*"]),
)

# ar executables.
filegroup(
    name = "ar",
    srcs = glob(["bin/riscv-none-elf-ar*"]),
)

# ld executables.
filegroup(
    name = "ld",
    srcs = glob(["bin/riscv-none-elf-ld*"]),
)

# nm executables.
filegroup(
    name = "nm",
    srcs = glob(["bin/riscv-none-elf-nm*"]),
)

# objcopy executables.
filegroup(
    name = "objcopy",
    srcs = glob(["bin/riscv-none-elf-objcopy*"]),
)

# objdump executables.
filegroup(
    name = "objdump",
    srcs = glob(["bin/riscv-none-elf-objdump*"]),
)

# strip executables.
filegroup(
    name = "strip",
    srcs = glob(["bin/riscv-none-elf-strip*"]),
)

# as executables.
filegroup(
    name = "as",
    srcs = glob(["bin/riscv-none-elf-as*"]),
)

# readelf executables.
filegroup(
    name = "readelf",
    srcs = glob(["bin/riscv-none-elf-readelf*"]),
)

# size executables.
filegroup(
    name = "size",
    srcs = glob(["bin/riscv-none-elf-size*"]),
)

# libraries and headers.
filegroup(
    name = "compiler_pieces",
    srcs = glob([
        "libexec/**",
        "riscv-none-elf/**",
        "lib/**",
        "lib/gcc/riscv-none-elf/**",
    ]),
)

filegroup(
    name = "ar_files",
    srcs = [
        ":ar",
        ":compiler_pieces",
        ":gcc",
    ],
)

# files for executing compiler.
filegroup(
    name = "compiler_files",
    srcs = [
        ":compiler_pieces",
        ":cpp",
        ":gcc",
    ],
)

filegroup(
    name = "linker_files",
    srcs = [
        ":ar",
        ":compiler_pieces",
        ":gcc",
        ":ld",
    ],
)

# collection of executables.
filegroup(
    name = "compiler_components",
    srcs = [
        ":ar",
        ":as",
        ":compiler_pieces",
        ":cpp",
        ":gcc",
        ":gcov",
        ":ld",
        ":nm",
        ":objcopy",
        ":objdump",
        ":strip",
    ],
)
