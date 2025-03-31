#!/usr/bin/env bash

GH_REPO="https://github.com/stackitcloud/stackit-cli"
TOOL_NAME="stackitcli"
TOOL_TEST="stackit --version"

curl_opts=(-fsSL)

# NOTE: You might want to remove this if stackitcli is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

get_cpu() {
	local machine_hardware_name
	machine_hardware_name=${ASDF_STACKITCLI_OVERWRITE_ARCH:-"$(uname -m)"}

	case "$machine_hardware_name" in
	'x86_64') local cpu_type="amd64" ;;
	'powerpc64le' | 'ppc64le') local cpu_type="ppc64le" ;;
	'aarch64') local cpu_type="arm64" ;;
	'armv7l') local cpu_type="arm" ;;
	*) local cpu_type="$machine_hardware_name" ;;
	esac

	echo "$cpu_type"
}

get_arch() {
	uname | tr '[:upper:]' '[:lower:]'
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

		chmod +x "$install_path/stackit"

		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
	list_github_tags
}
