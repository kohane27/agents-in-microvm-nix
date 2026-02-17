{ pkgs, ... }:
{
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "terrax" ''
      #!/usr/bin/env bash
      set -e

      HOST_WORKSPACE_ROOT="/home/username/.local/share/microvms/terrax/workspace"
      VM_SERVICE="microvm@terrax.service"
      SSH_HOST="microvm"

      TARGET_DIR="''${1:-.}"

      if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        echo "Usage: terrax [directory]"
        echo "Mounts the directory into the terrax microvm and SSHs into it."
        echo "Defaults to current directory if no argument provided."
        exit 0
      fi

      TARGET_DIR=$(realpath "$TARGET_DIR")

      if [ ! -d "$TARGET_DIR" ]; then
        echo "Error: Directory '$TARGET_DIR' does not exist."
        exit 1
      fi

      if systemctl is-active --quiet "$VM_SERVICE"; then
        echo "Stopping $VM_SERVICE..."
        doas systemctl stop "$VM_SERVICE"
      fi

      mkdir -p "$HOST_WORKSPACE_ROOT"

      STALE_MOUNT="$HOST_WORKSPACE_ROOT/mount"
      if [ -d "$STALE_MOUNT" ] && mountpoint -q "$STALE_MOUNT"; then
        echo "Cleaning up stale mount: $STALE_MOUNT"
        doas umount "$STALE_MOUNT"
        rmdir "$STALE_MOUNT" || true
      fi

      if mountpoint -q "$HOST_WORKSPACE_ROOT"; then
        echo "Unmounting previous workspace..."
        if ! doas umount "$HOST_WORKSPACE_ROOT"; then
          echo "Standard unmount failed (busy), trying lazy unmount..."
          sleep 1
          doas umount -l "$HOST_WORKSPACE_ROOT" || { echo "Failed to unmount even lazily!"; exit 1; }
        fi
      fi

      echo "Mounting $TARGET_DIR to workspace..."
      doas mount --bind "$TARGET_DIR" "$HOST_WORKSPACE_ROOT"

      echo "Starting $VM_SERVICE..."
      doas systemctl start "$VM_SERVICE"

      echo -n "Waiting for VM to be ready..."
      MAX_RETRIES=60
      for ((i=0; i<MAX_RETRIES; i++)); do
        if ssh -q -o ConnectTimeout=2 -o BatchMode=yes "$SSH_HOST" exit; then
          echo " Ready."
          break
        fi
        sleep 1
        echo -n "."
      done

      if [ $i -eq $MAX_RETRIES ]; then
        echo " Timeout waiting for VM."
        exit 1
      fi

      # Setup microvm env
      ssh -t "$SSH_HOST" "
        cd /tmp/workspace || { echo 'Failed to enter workspace'; exit 1; }
        exec claude --dangerously-skip-permissions
      "
    '')
  ];
}
