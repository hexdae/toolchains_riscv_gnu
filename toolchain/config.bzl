# toolchains/riscv-none-elf/darwin/config.bzl

load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")
load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl", "feature", "flag_group", "flag_set", "tool_path")

def wrapper_path(ctx, tool):
    wrapped_path = "{}/riscv-none-elf-{}{}".format(ctx.attr.wrapper_path, tool, ctx.attr.wrapper_ext)
    return tool_path(name = tool, path = wrapped_path)

def _impl(ctx):
    tool_paths = [
        wrapper_path(ctx, "gcc"),
        wrapper_path(ctx, "ld"),
        wrapper_path(ctx, "ar"),
        wrapper_path(ctx, "cpp"),
        wrapper_path(ctx, "gcov"),
        wrapper_path(ctx, "nm"),
        wrapper_path(ctx, "objdump"),
        wrapper_path(ctx, "strip"),
    ]

    include_paths = [
        "external/{}/riscv-none-elf/include".format(ctx.attr.gcc_repo),
        "external/{}/lib/gcc/riscv-none-elf/{}/include".format(ctx.attr.gcc_repo, ctx.attr.gcc_version),
        "external/{}/lib/gcc/riscv-none-elf/{}/include-fixed".format(ctx.attr.gcc_repo, ctx.attr.gcc_version),
        "external/{}/riscv-none-elf/include/c++/{}/".format(ctx.attr.gcc_repo, ctx.attr.gcc_version),
        "external/{}/riscv-none-elf/include/c++/{}/riscv-none-elf/".format(ctx.attr.gcc_repo, ctx.attr.gcc_version),
    ]

    linker_paths = [
        "external/{}/riscv-none-elf/lib".format(ctx.attr.gcc_repo),
        "external/{}/lib/gcc/riscv-none-elf/{}".format(ctx.attr.gcc_repo, ctx.attr.gcc_version),
    ]

    libs = [
        "libc.a",
        "libgcc.a",
    ]

    toolchain_compiler_flags = feature(
        name = "compiler_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = [
                    ACTION_NAMES.assemble,
                    ACTION_NAMES.preprocess_assemble,
                    ACTION_NAMES.linkstamp_compile,
                    ACTION_NAMES.c_compile,
                    ACTION_NAMES.cpp_compile,
                    ACTION_NAMES.cpp_header_parsing,
                    ACTION_NAMES.cpp_module_compile,
                    ACTION_NAMES.cpp_module_codegen,
                    ACTION_NAMES.lto_backend,
                    ACTION_NAMES.clif_match,
                ],
                flag_groups = [
                    flag_group(flags = ["-I%{include_paths}"], iterate_over = "include_paths"),
                    flag_group(flags = [
                        "-no-canonical-prefixes",
                    ]),
                ],
            ),
        ],
    )

    toolchain_linker_flags = feature(
        name = "linker_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = [
                    ACTION_NAMES.linkstamp_compile,
                ],
                flag_groups = [
                    flag_group(flags = ["-L%{linker_paths}"], iterate_over = "linker_paths"),
                    flag_group(flags = ["-l%{libs}"], iterate_over = "libs"),
                    flag_group(flags = [
                        "-no-canonical-prefixes",
                    ]),
                ],
            ),
        ],
    )

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        toolchain_identifier = ctx.attr.toolchain_identifier,
        host_system_name = ctx.attr.host_system_name,
        target_system_name = "riscv-none-elf",
        target_cpu = "riscv-none-elf",
        target_libc = "gcc",
        compiler = ctx.attr.gcc_repo,
        abi_version = "eabi",
        abi_libc_version = ctx.attr.gcc_version,
        tool_paths = tool_paths,
        features = [
            toolchain_compiler_flags,
            toolchain_linker_flags,
        ],
    )

cc_riscv_none_elf_config = rule(
    implementation = _impl,
    attrs = {
        "toolchain_identifier": attr.string(default = ""),
        "host_system_name": attr.string(default = ""),
        "wrapper_path": attr.string(default = ""),
        "wrapper_ext": attr.string(default = ""),
        "gcc_repo": attr.string(default = ""),
        "gcc_version": attr.string(default = ""),
    },
    provides = [CcToolchainConfigInfo],
)
