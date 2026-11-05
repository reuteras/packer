#!/bin/bash
# Update the pinned SIFT and cast versions (and cast SHA256s) in sift.sh.
# Only stable releases at least COOLDOWN_DAYS old are considered.
# Prints a Markdown summary of the changes; prints nothing if up to date.
set -euo pipefail

COOLDOWN_DAYS="${COOLDOWN_DAYS:-7}"
SIFT_SCRIPT="${SIFT_SCRIPT:-$(cd "$(dirname "$0")/.." && pwd)/packer-ubuntu/scripts/sift.sh}"

# Newest stable release of repo $1 whose tag matches regex $2 and is past the cooldown.
latest_release() {
	gh api "repos/$1/releases?per_page=50" --jq "
		[.[] | select(.draft == false and .prerelease == false)
		     | select(.tag_name | test(\"$2\"))
		     | select((.published_at | fromdateiso8601) <= (now - $COOLDOWN_DAYS * 86400))]
		| sort_by(.published_at) | last | .tag_name // empty"
}

current() { sed -n "s/^$1=\"\(.*\)\"$/\1/p" "$SIFT_SCRIPT"; }

# True if version $2 is newer than $1.
is_newer() { [[ "$1" != "$2" && "$(printf '%s\n%s\n' "$1" "$2" | sort -V | tail -n1)" == "$2" ]]; }

set_var() {
	local tmp
	tmp=$(mktemp)
	sed "s|^$1=\".*\"$|$1=\"$2\"|" "$SIFT_SCRIPT" >"$tmp"
	cat "$tmp" >"$SIFT_SCRIPT"
	rm -f "$tmp"
}

sift_current=$(current SIFT_VERSION)
cast_current=$(current CAST_VERSION)
[[ -n "$sift_current" && -n "$cast_current" ]] || {
	echo "Could not read current versions from $SIFT_SCRIPT" >&2
	exit 1
}

sift_latest=$(latest_release teamdfir/sift-saltstack '^v[0-9]{4}\\.[0-9]{2}\\.[0-9]{2}$')
cast_tag=$(latest_release ekristen/cast '^v[0-9]+\\.[0-9]+\\.[0-9]+$')
cast_latest="${cast_tag#v}"

if [[ -n "$sift_latest" ]] && is_newer "$sift_current" "$sift_latest"; then
	set_var SIFT_VERSION "$sift_latest"
	echo "- SIFT: \`$sift_current\` → \`$sift_latest\` ([release](https://github.com/teamdfir/sift-saltstack/releases/tag/$sift_latest), [diff](https://github.com/teamdfir/sift-saltstack/compare/$sift_current...$sift_latest))"
fi

if [[ -n "$cast_latest" ]] && is_newer "$cast_current" "$cast_latest"; then
	tmp_dir=$(mktemp -d)
	trap 'rm -rf "$tmp_dir"' EXIT
	gh release download "$cast_tag" -R ekristen/cast -D "$tmp_dir" \
		-p checksums.txt -p "cast-$cast_tag-linux-arm64.deb" -p "cast-$cast_tag-linux-amd64.deb"
	# Make sure the published checksums match the actual release assets.
	(cd "$tmp_dir" && grep -E "  cast-$cast_tag-linux-(arm64|amd64)\.deb$" checksums.txt | shasum -a 256 -c - >&2)
	sha_arm64=$(awk -v f="cast-$cast_tag-linux-arm64.deb" '$2 == f { print $1 }' "$tmp_dir/checksums.txt")
	sha_amd64=$(awk -v f="cast-$cast_tag-linux-amd64.deb" '$2 == f { print $1 }' "$tmp_dir/checksums.txt")
	[[ ${#sha_arm64} -eq 64 && ${#sha_amd64} -eq 64 ]] || {
		echo "Missing checksums for cast $cast_tag" >&2
		exit 1
	}
	set_var CAST_VERSION "$cast_latest"
	set_var CAST_SHA256_ARM64 "$sha_arm64"
	set_var CAST_SHA256_AMD64 "$sha_amd64"
	echo "- cast: \`$cast_current\` → \`$cast_latest\` ([release](https://github.com/ekristen/cast/releases/tag/$cast_tag), [diff](https://github.com/ekristen/cast/compare/v$cast_current...$cast_tag)); SHA256s from \`checksums.txt\`, verified against the downloaded \`.deb\` files"
fi
