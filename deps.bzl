"""deps.bzl"""

load("@toolchains_riscv_gnu//toolchain/archives:riscv_none_elf.bzl", "riscv_none_elf")
load("@toolchains_riscv_gnu//toolchain:toolchain.bzl", "tools")

def _riscv_gnu_cross_hosted_platform_specific_repo_impl(repository_ctx):
    """Defines a host-specific repository for the ARM GNU toolchain."""
    repository_ctx.download_and_extract(
        sha256 = repository_ctx.attr.sha256,
        url = repository_ctx.attr.url,
        stripPrefix = repository_ctx.attr.strip_prefix,
    )

    repository_ctx.template(
        "BUILD.bazel",
        Label("@toolchains_riscv_gnu//toolchain:templates/compiler.BUILD"),
        substitutions = {
            "%toolchain_prefix%": repository_ctx.attr.toolchain_prefix,
            "%version%": repository_ctx.attr.version.split("-")[0],
            "%bin_extension%": ".exe" if "windows" in repository_ctx.name else "",
            "%tools%": "{}".format(repository_ctx.attr.tools),
        },
    )

    for patch in repository_ctx.attr.patches:
        repository_ctx.patch(patch, strip = 1)

riscv_gnu_cross_hosted_platform_specific_repo = repository_rule(
    implementation = _riscv_gnu_cross_hosted_platform_specific_repo_impl,
    attrs = {
        "sha256": attr.string(mandatory = True),
        "url": attr.string(mandatory = True),
        "toolchain_prefix": attr.string(mandatory = True),
        "version": attr.string(mandatory = True),
        "strip_prefix": attr.string(),
        "patches": attr.label_list(),
        "tools": attr.string_list(default = tools),
        "exec_compatible_with": attr.string_list(),
    },
)

def _riscv_gnu_toolchain_repo_impl(repository_ctx):
    """Defines the top-level toolchain repository."""
    repository_ctx.template(
        "BUILD",
        Label("@toolchains_riscv_gnu//toolchain:templates/top.BUILD"),
        substitutions = {
            "%toolchain_name%": repository_ctx.attr.toolchain_name,
            "%version%": repository_ctx.attr.version,
            "%toolchain_prefix%": repository_ctx.attr.toolchain_prefix,
        },
    )

    repository_ctx.template(
        "toolchain/BUILD",
        Label("@toolchains_riscv_gnu//toolchain:templates/toolchain.BUILD"),
        substitutions = {
            "%toolchain_name%": repository_ctx.attr.toolchain_name,
            "%version%": repository_ctx.attr.version,
            "%toolchain_prefix%": repository_ctx.attr.toolchain_prefix,
        },
    )

    repository_ctx.template(
        "toolchain/toolchain.bzl",
        Label("@toolchains_riscv_gnu//toolchain:templates/toolchain.bazel"),
        substitutions = {
            "%toolchain_name%": repository_ctx.attr.toolchain_name,
            "%version%": repository_ctx.attr.version,
            "%toolchain_prefix%": repository_ctx.attr.toolchain_prefix,
            "%hosts%": "{}".format(repository_ctx.attr.hosts),
        },
    )

    for repo in repository_ctx.attr.hosts.keys():
        repository_ctx.template(
            "toolchain/{}/BUILD".format(repo),
            Label("@toolchains_riscv_gnu//toolchain:templates/alias.BUILD"),
            substitutions = {
                "%repo%": repo,
                "%tools%": "{}".format(repository_ctx.attr.tools),
            },
        )

toolchains_riscv_gnu_repo = repository_rule(
    implementation = _riscv_gnu_toolchain_repo_impl,
    attrs = {
        "toolchain_name": attr.string(mandatory = True),
        "toolchain_prefix": attr.string(mandatory = True),
        "version": attr.string(mandatory = True),
        "hosts": attr.string_list_dict(mandatory = True),
        "tools": attr.string_list(default = tools),
    },
)

def toolchains_riscv_gnu_deps(toolchain, toolchain_prefix, version, archives):
    """Define dependencies for a riscv toolchain.

    Args:
        toolchain: The name of the toolchain.
        toolchain_prefix: The prefix of the toolchain.
        version: The version of the toolchain.
        archives: A dictionary of version to archive attributes.
    """
    archive = archives.get(version)

    if not archive:
        fail("Version {} not available in {}".format(version, archives.keys()))

    toolchains_riscv_gnu_repo(
        name = toolchain,
        toolchain_name = toolchain,
        toolchain_prefix = toolchain_prefix,
        version = version,
        hosts = {
            repo["name"]: repo["exec_compatible_with"]
            for repo in archive
        },
    )

    for attrs in archive:
        riscv_gnu_cross_hosted_platform_specific_repo(
            toolchain_prefix = toolchain_prefix,
            version = version,
            **attrs
        )

def riscv_none_elf_deps(version = "13.2.0-2", archives = riscv_none_elf):
    """Workspace dependencies for the arm none eabi gcc toolchain

    Args:
        version: The version of the toolchain to use. If None, the latest version is used.
        archives: A dictionary of version to archive attributes.
    """
    toolchains_riscv_gnu_deps(
        "riscv_none_elf",
        "riscv-none-elf",
        version,
        archives,
    )
