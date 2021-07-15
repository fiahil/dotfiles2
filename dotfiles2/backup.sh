#!/bin/sh

set -uo pipefail

echo "Starting backup"

command -v restic > /dev/null 2>&1 || { echo >&2 "restic not installed. Aborting."; exit 1; }

command -v op  > /dev/null 2>&1 && { 
    eval $(op signin trofray)

    export B2_ACCOUNT_ID=$(op get item "Backblaze B2 Backups" --fields B2_ACCOUNT_ID --format CSV)
    export B2_ACCOUNT_KEY=$(op get item "Backblaze B2 Backups" --fields B2_ACCOUNT_KEY --format CSV)
    
    export RESTIC_PASSWORD=$(op get item "Backblaze B2 Backups" --fields BACKUP_PASSWORD --format CSV)
}

[[ -z "$B2_ACCOUNT_ID" ]] && { echo >&2 "B2_ACCOUNT_ID not set. Aborting."; exit 1; }
[[ -z "$B2_ACCOUNT_KEY" ]] && { echo >&2 "B2_ACCOUNT_KEY not set. Aborting."; exit 1; }
[[ -z "$RESTIC_PASSWORD" ]] && { echo >&2 "RESTIC_PASSWORD not set. Aborting."; exit 1; }

export RESTIC_REPOSITORY="b2:fiahil-backups:$(hostname)"

# check if repo already exist
restic snapshots
if [ $? -ne 0 ]; then
    echo "> Repository not found for this machine"
    restic init
fi

restic --verbose backup        \
    --exclude ".DS_Store"      \
    --exclude "venv"           \
    --exclude ".venv"          \
    --exclude ".mypy_cache"    \
    --exclude ".pytest_cache"  \
    --exclude ".cache"         \
    --exclude "target"         \
    --exclude "data"           \
    --exclude "node_modules"   \
    --files-from "$HOME/dotfiles2/backup-files.txt"
