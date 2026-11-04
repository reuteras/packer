#!/bin/bash -eux
# Install SIFT Workstation with cast (https://github.com/ekristen/cast).
# Versions and checksums are pinned; update them together.

CAST_VERSION="1.0.42"
CAST_SHA256_ARM64="b527fd8592af2520ddd3457cba9538c7e80013b8c58174ab402ac69c03a0c369"
CAST_SHA256_AMD64="9775d46a42f77030407cd3ba37d5f32334d50e0d4b021ece113c23cbea2c7573"
SIFT_VERSION="v2026.10.19"
SIFT_USER="${SIFT_USER:-malware}"

export CHECKPOINT_DISABLE=1
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

cast install --user="$SIFT_USER" "teamdfir/sift-saltstack@${SIFT_VERSION}"
