#!/usr/bin/env bash
# QEMU ARM64 wrapper for Packer on macOS Apple Silicon.
# The Packer QEMU plugin generates args incompatible with the ARM64 virt machine:
#   - "-drive if=scsi,media=cdrom" requires a legacy SCSI bus (not present in virt)
# This wrapper converts the CD-ROM drive to use virtio-scsi instead.

QEMU=/opt/homebrew/bin/qemu-system-aarch64
NEW_ARGS=()
SCSI_ADDED=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        -drive)
            val="$2"
            if [[ "$val" == *"if=scsi"*"media=cdrom"* ]]; then
                # Add virtio-scsi controller once, before the CD-ROM device
                if ! $SCSI_ADDED; then
                    NEW_ARGS+=("-device" "virtio-scsi-pci,id=scsi0")
                    SCSI_ADDED=true
                fi
                # Convert if=scsi to if=none so the drive can be attached via device
                val="${val/if=scsi/if=none}"
                # Extract drive id (e.g. id=cdrom0)
                if [[ "$val" =~ id=([^,]+) ]]; then
                    drive_id="${BASH_REMATCH[1]}"
                else
                    drive_id="cdrom0"
                    val="${val},id=${drive_id}"
                fi
                NEW_ARGS+=("-drive" "$val")
                NEW_ARGS+=("-device" "scsi-cd,bus=scsi0.0,drive=${drive_id}")
            else
                NEW_ARGS+=("-drive" "$val")
            fi
            shift 2
            ;;
        *)
            NEW_ARGS+=("$1")
            shift
            ;;
    esac
done

exec "$QEMU" "${NEW_ARGS[@]}"
