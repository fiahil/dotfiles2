#!/bin/sh

set -uo pipefail

echo "Starting backup"

command -v restic > /dev/null 2>&1 || { echo >&2 "restic not installed. Aborting."; exit 1; }

command -v op  > /dev/null 2>&1 && {
    eval $(op signin)

    export B2_ACCOUNT_ID=$(op item get "Backblaze B2 Backups" --fields B2_ACCOUNT_ID --format human-readable)
    export B2_ACCOUNT_KEY=$(op item get "Backblaze B2 Backups" --fields B2_ACCOUNT_KEY --format human-readable)

    export RESTIC_PASSWORD=$(op item get "Backblaze B2 Backups" --fields BACKUP_PASSWORD --format human-readable)
}

[[ -z "$B2_ACCOUNT_ID" ]] && { echo >&2 "B2_ACCOUNT_ID not set. Aborting."; exit 1; }
[[ -z "$B2_ACCOUNT_KEY" ]] && { echo >&2 "B2_ACCOUNT_KEY not set. Aborting."; exit 1; }
[[ -z "$RESTIC_PASSWORD" ]] && { echo >&2 "RESTIC_PASSWORD not set. Aborting."; exit 1; }

export RESTIC_REPOSITORY="b2:fiahil-backups:$(hostname)"

# check if repo already exist
restic snapshots 2>&1 > /dev/null
if [ $? -ne 0 ]; then
    echo "> Repository not found for this machine"
    restic init
fi

case $1 in
    "status")
        echo "> status"
        restic snapshots
        ;;
    "run")
        echo "> starting backups"

        restic --verbose backup        \
            --exclude ".DS_Store"      \
            --exclude "venv"           \
            --exclude ".venv"          \
            --exclude ".mypy_cache"    \
            --exclude ".pytest_cache"  \
            --exclude ".ruff_cache"    \
            --exclude "__pycache__"    \
            --exclude ".cache"         \
            --exclude "target"         \
            --exclude "data"           \
            --exclude "node_modules"   \
            --exclude "artefacts"      \
            --files-from "$HOME/dotfiles2/backup-files.txt"
        ;;
    "cleanup")
        echo "> starting cleanup"

        restic forget                 \
            --keep-last 6             \
            --keep-monthly 6
        ;;
    *)
        echo "> USAGE [status | run | cleanup]"
        exit 1
        ;;
esac
