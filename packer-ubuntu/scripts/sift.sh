#!/bin/bash -eux
# Install SIFT Workstation with cast (https://github.com/ekristen/cast).
# Versions and checksums are pinned; update them together.

CAST_VERSION="1.0.42"
CAST_SHA256_ARM64="b527fd8592af2520ddd3457cba9538c7e80013b8c58174ab402ac69c03a0c369"
CAST_SHA256_AMD64="9775d46a42f77030407cd3ba37d5f32334d50e0d4b021ece113c23cbea2c7573"
SIFT_VERSION="v2026.10.19"
SIFT_USER="${SIFT_USER:-malware}"
# Set SIFT_STRICT=1 to fail the build if any SIFT salt state fails.
SIFT_STRICT="${SIFT_STRICT:-0}"

export CHECKPOINT_DISABLE=1
# Packer runs this with "sudo -E", which keeps HOME=/home/$SIFT_USER. Salt
# states that run as root would then create root-owned files in the user's
# home (e.g. ~/.local), which breaks later per-user steps like pipx and r2pm.
export HOME=/root
export DEBIAN_FRONTEND=noninteractive

case "$(dpkg --print-architecture)" in
arm64) ARCH=arm64 CAST_SHA256="$CAST_SHA256_ARM64" ;;
amd64) ARCH=amd64 CAST_SHA256="$CAST_SHA256_AMD64" ;;
*)
	echo "Unsupported architecture: $(dpkg --print-architecture)"
	exit 1
	;;
esac

tmp_dir=$(mktemp -d)
trap 'rm -rf "$tmp_dir"' EXIT

deb="cast-v${CAST_VERSION}-linux-${ARCH}.deb"
wget --quiet -O "$tmp_dir/$deb" "https://github.com/ekristen/cast/releases/download/v${CAST_VERSION}/${deb}"
echo "$CAST_SHA256  $tmp_dir/$deb" | sha256sum --check --strict
dpkg -i "$tmp_dir/$deb"

user_home=$(getent passwd "$SIFT_USER" | cut -d: -f6)

# Warn about root-owned files in the user's home; they break per-user tools.
check_home_ownership() {
	local root_owned
	root_owned=$(find "$user_home" -user root 2>/dev/null | head -20)
	if [[ -n "$root_owned" ]]; then
		echo "WARNING: root-owned files in $user_home:"
		echo "$root_owned"
	fi
}

if cast install --user="$SIFT_USER" "teamdfir/sift-saltstack@${SIFT_VERSION}"; then
	check_home_ownership
	exit 0
fi

# SIFT pulls many third-party downloads and some break between releases.
# List every failed state and keep the logs instead of discarding the VM.
set +x
log_dir=/var/cache/cast/installer/logs
echo "SIFT installation finished with failed states:"
python3 - "$log_dir/results.yaml" <<'PY' || true
import sys
import yaml

with open(sys.argv[1]) as f:
    results = (yaml.safe_load(f) or {}).get("local", {})
failed = sorted(
    (r for r in results.values() if isinstance(r, dict) and r.get("result") is False),
    key=lambda r: r.get("__run_num__", 0),
)
knock_on = [r for r in failed if str(r.get("comment", "")).startswith("One or more requisite failed")]
root = [r for r in failed if r not in knock_on]
for r in root:
    comment = " ".join(str(r.get("comment", "")).split())
    print(f"  [{r.get('__sls__', '?')}] {r.get('__id__', '?')}: {comment}")
    changes = r.get("changes")
    if isinstance(changes, dict) and "retcode" in changes:
        output = str(changes.get("stderr") or changes.get("stdout") or "").splitlines()
        print(f"    exit code {changes['retcode']}, last lines of output:")
        for line in output[-20:]:
            print(f"      {line}")
if knock_on:
    print(f"  ...and {len(knock_on)} states skipped because of the failures above:")
    print("     " + ", ".join(sorted({r.get("__sls__", "?") for r in knock_on})))
print(f"{len(failed)} of {len(results)} states failed ({len(root)} root causes).")
PY

check_home_ownership
mkdir -p "$user_home/sift-install-logs"
cp "$log_dir"/* "$user_home/sift-install-logs/" || true
chown -R "$SIFT_USER:" "$user_home/sift-install-logs"
echo "Logs copied to $user_home/sift-install-logs."

if [[ "$SIFT_STRICT" == "1" ]]; then
	exit 1
fi
