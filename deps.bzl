"""deps.bzl"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@riscv_none_elf//toolchain:toolchain.bzl", "register_riscv_none_elf_toolchain")

def riscv_none_elf_deps(name = "", extra_cflags = [], extra_ldflags = []):
    """Workspace dependencies for the arm none eabi gcc toolchain

    Args:
        name: not needed
        extra_cflags: list of compiler options
        extra_ldflags: list of linker options
    """

    http_archive(
        name = "riscv_none_elf_darwin_x86_64",
        build_file = "@riscv_none_elf//toolchain:compiler.BUILD",
        sha256 = "08508cc24201452a8f82bb12f9ee9474704d2d5db342205ae25567baca8de061",
        strip_prefix = "xpack-riscv-none-elf-gcc-12.2.0-1",
        url = "https://github.com/xpack-dev-tools/riscv-none-elf-gcc-xpack/releases/download/v12.2.0-1/xpack-riscv-none-elf-gcc-12.2.0-1-darwin-x64.tar.gz",
    )

    http_archive(
        name = "riscv_none_elf_darwin_arm64",
        build_file = "@riscv_none_elf//toolchain:compiler.BUILD",
        sha256 = "4a0044c4c8e3115abe32030b80a136ab987fc2a0712b0ddf62d11d369a5ad521",
        strip_prefix = "xpack-riscv-none-elf-gcc-12.2.0-1",
        url = "https://github.com/xpack-dev-tools/riscv-none-elf-gcc-xpack/releases/download/v12.2.0-1/xpack-riscv-none-elf-gcc-12.2.0-1-darwin-arm64.tar.gz",
    )

    http_archive(
        name = "riscv_none_elf_linux_x86_64",
        build_file = "@riscv_none_elf//toolchain:compiler.BUILD",
        sha256 = "04b5f45d609b221505e9232b1b63ae6cdb17d0a23f13ce9c231fc4008753a58a",
        strip_prefix = "xpack-riscv-none-elf-gcc-12.2.0-1",
        url = "https://github.com/xpack-dev-tools/riscv-none-elf-gcc-xpack/releases/download/v12.2.0-1/xpack-riscv-none-elf-gcc-12.2.0-1-linux-x64.tar.gz",
    )

    http_archive(
        name = "riscv_none_elf_linux_aarch64",
        build_file = "@riscv_none_elf//toolchain:compiler.BUILD",
        sha256 = "68ff464c907c8160308a32babba49ccb0493e480520d5c8513373301e65e7ee2",
        strip_prefix = "xpack-riscv-none-elf-gcc-12.2.0-1",
        url = "https://github.com/xpack-dev-tools/riscv-none-elf-gcc-xpack/releases/download/v12.2.0-1/xpack-riscv-none-elf-gcc-12.2.0-1-linux-arm64.tar.gz",
    )

    http_archive(
        name = "riscv_none_elf_windows_x86_64",
        build_file = "@riscv_none_elf//toolchain:compiler.BUILD",
        sha256 = "1edf87d32975619076d3df558b8c1218daa54947f47b06c7ea9edb99e2290548",
        strip_prefix = "xpack-riscv-none-elf-gcc-12.2.0-1",
        url = "https://github.com/xpack-dev-tools/riscv-none-elf-gcc-xpack/releases/download/v12.2.0-1/xpack-riscv-none-elf-gcc-12.2.0-1-win32-x64.zip",
    )

def register_default_riscv_none_elf_toolchains():
    register_riscv_none_elf_toolchain("//toolchain:riscv32")
    register_riscv_none_elf_toolchain("//toolchain:riscv64")
