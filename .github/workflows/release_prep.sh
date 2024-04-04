#!/usr/bin/env bash

set -o errexit -o nounset -o pipefail

# Set by GH actions, see
# https://docs.github.com/en/actions/learn-github-actions/environment-variables#default-environment-variables
TAG=${GITHUB_REF_NAME}
# The prefix is chosen to match what GitHub generates for source archives
# This guarantees that users can easily switch from a released artifact to a source archive
# with minimal differences in their code (e.g. strip_prefix remains the same)
PREFIX="/toolchains_riscv_gnu-${TAG:1}"
ARCHIVE="/toolchains_riscv_gnu-$TAG.tar.gz"

# NB: configuration for 'git archive' is in /.gitattributes
git archive --format=tar --prefix=${PREFIX}/ ${TAG} | gzip > $ARCHIVE
SHA=$(shasum -a 256 $ARCHIVE | awk '{print $1}')

cat << EOF
## Using Bzlmod with Bazel 6 or greater

1. (Bazel 6 only) Enable with \`common --enable_bzlmod\` in \`.bazelrc\`.
2. Add to your \`MODULE.bazel\` file:

\`\`\`starlark
bazel_dep(name = "toolchains_riscv_gnu", version = "${TAG:1}")

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
\`\`\`
EOF
