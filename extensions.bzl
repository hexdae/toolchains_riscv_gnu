"""Module extension for toolchains"""

load("@toolchains_riscv_gnu//toolchain/archives:riscv_none_elf.bzl", "riscv_none_elf")
load("@toolchains_riscv_gnu//:deps.bzl", "riscv_none_elf_deps")

def _semver(version):
    """Parse a semantic version string into a list of integers."""
    parts = [int(i.split("-")[0]) for i in version.split(".")]
    return struct(
        major = parts[0],
        minor = parts[1],
        patch = parts[2],
    )

def _module_toolchain(tag, deps):
    """Return a module toolchain."""
    return struct(
        tag = tag,
        deps = deps,
    )

def _compare_versions(left, right):
    """Compare two semantic versions."""
    left = _semver(left)
    right = _semver(right)

    # (a < b): -1, (a > b): 1, (a == b): 0.
    compare = lambda a, b: int(a > b) - int(a < b)

    return compare(left.major, right.major) or \
           compare(left.minor, right.minor) or \
           compare(left.patch, right.patch) or \
           0

def _max_version(versions):
    """Obtains the minimum version from the list of version strings."""
    if versions:
        maximum = versions.pop(0)
        for version in versions:
            if _compare_versions(maximum, version) < 0:
                maximum = version
        return maximum
    return None

def _min_version(versions):
    """Obtains the minimum version from the list of version strings."""
    if versions:
        minimum = versions.pop(0)
        for version in versions:
            if _compare_versions(minimum, version) > 0:
                minimum = version
        return minimum
    return None

def _riscv_toolchain_impl(ctx):
    """Implement the module extension."""

    available_toolchains = [
        _module_toolchain(
            tag = lambda mod: mod.tags.riscv_none_elf,
            deps = riscv_none_elf_deps,
        ),
    ]

    for toolchain in available_toolchains:
        versions = [attr.version for mod in ctx.modules for attr in toolchain.tag(mod)]
        selected = _min_version(versions)
        if selected:
            toolchain.deps(version = selected)

riscv_toolchain = module_extension(
    implementation = _riscv_toolchain_impl,
    tag_classes = {
        "riscv_none_elf": tag_class(attrs = {
            "version": attr.string(default = _max_version(riscv_none_elf.keys())),
        }),
    },
)
