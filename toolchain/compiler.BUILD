# toolchains/compiler.BUILD

package(default_visibility = ['//visibility:public'])

# export the executable files to make them available for direct use.
exports_files(glob(["bin/*"]))

# gcc executables.
filegroup(
    name = "gcc",
    srcs = glob(["bin/riscv-none-elf-gcc*"]),
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
        "lib/gcc/riscv-none-elf/**",
    ]),
)

# collection of executables.
filegroup(
    name = "compiler_components",
    srcs = [
        ":ar",
        ":as",
        ":gcc",
        ":ld",
        ":nm",
        ":objcopy",
        ":objdump",
        ":strip",
    ],
)
