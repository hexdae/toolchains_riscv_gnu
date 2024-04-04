<p align="center">

<a href="https://github.com/hexdae/toolchains_riscv_gnu/blob/master/LICENSE">
    <img alt="GitHub license" src="https://img.shields.io/github/license/hexdae/toolchains_riscv_gnu?color=success">
</a>

<a href="https://github.com/hexdae/toolchains_riscv_gnu/stargazers">
    <img alt="GitHub stars" src="https://img.shields.io/github/stars/hexdae/toolchains_riscv_gnu?color=success">
</a>

<a href="https://github.com/hexdae/toolchains_riscv_gnu/issues">
    <img alt="GitHub issues" src="https://img.shields.io/github/issues/hexdae/toolchains_riscv_gnu">
</a>

<a href="https://github.com/hexdae/toolchains_riscv_gnu/actions">
    <img alt="CI" src="https://github.com/hexdae/toolchains_riscv_gnu/actions/workflows/ci.yml/badge.svg">
</a>

</p>

<p align="center">

<img src="https://asnaghi.me/images/bazel-arm.png" width="400px"/>

</p>

The goal of the project is to make arm cross compilation toolchains readily
available (and customizable) for bazel developers.

If this project was useful to you, give it a ⭐️ and I'll keep improving it!

## Features

- [MODULE support](#bzlmod)
- [WORKSPACE support](#workspace)
- [Direct access to gcc tools](#direct-access-to-gcc-tools)
- [Custom toolchain support](#custom-toolchain)
- [Examples](./examples)
- Remote execution support
- Linux, MacOS, Windows

## Use the toolchain from this repo

## .bazelrc

And this to your `.bazelrc`

```bash
# .bazelrc

# Build using platforms by default
build --incompatible_enable_cc_toolchain_resolution
```

## Bzlmod

```python
bazel_dep(name = "toolchains_riscv_gnu", version = "0.0.1")

# Toolchains: riscv-none-elf
riscv_toolchain = use_extension("@toolchains_riscv_gnu//:extensions.bzl", "riscv_toolchain")
riscv_toolchain.riscv_none_elf(version = "13.2.1")
use_repo(
    riscv_toolchain,
    "riscv_none_elf",
    "riscv_none_elf_darwin_arm64",
    "riscv_none_elf_darwin_x86_64",
    "riscv_none_elf_linux_aarch64",
    "riscv_none_elf_linux_x86_64",
    "riscv_none_elf_windows_x86_64",
)

register_toolchains("@riscv_none_elf//toolchain:all")
```

## WORKSPACE

Add this git repository to your WORKSPACE to use the compiler

```python
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
http_archive(
    name = "rules_cc",
    sha256 = "2037875b9a4456dce4a79d112a8ae885bbc4aad968e6587dca6e64f3a0900cdf",
    strip_prefix = "rules_cc-0.0.9",
    urls = ["https://github.com/bazelbuild/rules_cc/releases/download/0.0.9/rules_cc-0.0.9.tar.gz"],
)

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
git_repository(
    name = "toolchains_riscv_gnu",
    remote = "https://github.com/hexdae/toolchains_riscv_gnu",
    branch = "main",
)

load("@toolchains_riscv_gnu//:deps.bzl", "riscv_none_elf_deps")
riscv_none_elf_deps()
register_toolchains("@riscv_none_elf//toolchain:all")
```

Now Bazel will automatically use `riscv-none-elf-gcc` as a compiler.

## Custom toolchain

If you want to bake certain compiler flags in to your toolchain, you can define a custom `riscv-none-elf` toolchain in your repo.

In a BUILD file:

```python
# path/to/toolchains/BUILD

load("@toolchains_riscv_gnu//toolchain:toolchain.bzl", "riscv_none_elf_toolchain")
riscv_none_elf_toolchain(
    name = "custom_toolchain",
    target_compatible_with = [
        "<your additional constraints>",
    ],
    copts = [
        "<your additional copts>",
    ],
    linkopts = [
        "<your additional linkopts>",
    ],
)
```

And in your WORKSPACE / MODULE file:

```python
register_toolchains("@//path/to/toolchains:all")
```

Be careful about registering the default toolchains when using a custom one

## Direct access to gcc tools

If you need direct access to `gcc` tools, they are available as `@riscv_none_elf//:<tool>`. For example, the following `genrules` could be used to produce `.bin` and `.hex` artifacts from a generic `.out` target.

```python

cc_binary(
    name = "target.out"
    srcs = [...],
    deps = [...],
    copts = [...],
    ...
)

genrule(
    name = "bin",
    srcs = [":target.out"],
    outs = ["target.bin"],
    cmd = "$(execpath @riscv_none_elf//:objcopy) -O binary $< $@",
    tools = ["@riscv_none_elf//:objcopy"],
)

genrule(
    name = "hex",
    srcs = [":target.out"],
    outs = ["target.hex"],
    cmd = "$(execpath @riscv_none_elf//:objcopy) -O ihex $< $@",
    tools = ["@riscv_none_elf//:objcopy"],
)
```

## Remote execution

This toolchain is compatible with remote execution, see [`remote.yml`](.github/workflows/remote.yml)

## Building with the ARM Linux toolchain on Windows

The Windows maximum path length limitation may cause build failures with the
`arm-none-linux-gnueabihf` toolchain. In some cases, it's enough to avoid this
by setting a shorter output directory. Add this to your `.bazelrc` file:

```
startup --output_user_root=C:/tmp
```

See [avoid long path issues][1] for more information.

[1]: https://bazel.build/configure/windows#long-path-issues
