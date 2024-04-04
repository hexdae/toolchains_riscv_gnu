"""Download the lastes github release for a given toolchain"""

import argparse
import urllib.request
import json
import os

XPACK = {
    "owner": "xpack-dev-tools",
    "repo": "{prefix}-gcc-xpack",
    "url": "https://github.com/xpack-dev-tools/{prefix}-gcc-xpack/releases/download/v{version}/xpack-{prefix}-gcc-{version}-{system}.{ext}",
    "sha_url": "https://github.com/xpack-dev-tools/{prefix}-gcc-xpack/releases/download/v{version}/xpack-{prefix}-gcc-{version}-{system}.{ext}.sha",
    "strip": "xpack-{prefix}-gcc-{version}",
}

riscv_none_elf = {
    "template": XPACK,
    "name": "riscv_none_elf",
    "prefix": "riscv-none-elf",
    "hosts": {
        "darwin_arm64": "darwin-arm64",
        "darwin_x86_64": "darwin-x64",
        "linux_aarch64": "linux-arm64",
        "linux_x86_64": "linux-x64",
        "windows_x86_64": "win32-x64",
    },
}


def download_sha(url):
    """Download the SHA256 checksum of a file from a given URL"""
    try:
        with urllib.request.urlopen(url) as response:
            if response.getcode() == 200:
                return response.read().decode("utf-8").split()[0]
    except urllib.error.HTTPError as e:
        exit(f"{e}: {url}")


def github_release_tags(owner, repo, count=1):
    """Get the latest release tags from a GitHub repository"""
    releases_url = f"https://api.github.com/repos/{owner}/{repo}/releases"
    response = urllib.request.urlopen(releases_url)
    releases = json.loads(response.read().decode())
    return [release["tag_name"][1:] for release in reversed(releases[:count])]



def generate_archive(name, prefix, version, system, template):
    """Generate an archive dictionary for a given toolchain"""
    info = {
        "prefix": prefix,
        "version": version,
        "system": system,
        "ext": "zip" if "win32" in system else "tar.gz",
    }
    url = template["url"].format(**info)
    sha256 = download_sha(template["sha_url"].format(**info))
    return {
        "name": name,
        "url": url,
        "sha256": sha256,
        "strip_prefix": template["strip"].format(**info),
    }


def generate_release(name, prefix, hosts, template, releases):
    """Generate a release dictionary for a given toolchain"""
    return {
        version: [
            generate_archive(
                name=f"{name}_{host}",
                prefix=prefix,
                version=version,
                system=system,
                template=template,
            )
            for host, system in hosts.items()
        ]
        for version in github_release_tags(
            owner=template["owner"],
            repo=template["repo"].format(prefix=prefix),
            count=releases,
        )
    }


def main():
    """Main function to generate and print release information"""
    parser = argparse.ArgumentParser()
    parser.add_argument("--toolchain", choices=["riscv-none-elf"])
    parser.add_argument("--releases", default=1, type=int)
    args = parser.parse_args()

    # Make the script well behaved when running under bazel
    if os.environ.get("BUILD_WORKING_DIRECTORY"):
        os.chdir(os.environ["BUILD_WORKING_DIRECTORY"])

    if args.toolchain == "riscv-none-elf":
        release = generate_release(**riscv_none_elf, releases=args.releases)
        print(json.dumps(release, indent=4))


if __name__ == "__main__":
    main()
