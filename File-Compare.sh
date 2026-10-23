#!/bin/bash

# Usage:
# ./check_file_ages.sh "/path/to/directory" "partial_filename"

DIRECTORY="/nextcloud-backups"
PATTERN="nextcloud"
MAX_AGE_DAYS=16

if [[ -z "$DIRECTORY" || -z "$PATTERN" ]]; then
    echo "Usage: $0 <directory> <partial_filename>"
    exit 1
fi

if [[ ! -d "$DIRECTORY" ]]; then
    echo "Directory does not exist: $DIRECTORY"
    exit 1
fi

CURRENT_EPOCH=$(date +%s)
MAX_AGE_SECONDS=$((MAX_AGE_DAYS * 24 * 60 * 60))

FOUND_MATCHES=false

while IFS= read -r -d '' FILE; do
    FOUND_MATCHES=true

    # Try to get file creation/birth time
    BIRTH_EPOCH=$(stat -c %W "$FILE" 2>/dev/null)

    # If birth time isn't available, use modification time
    if [[ "$BIRTH_EPOCH" -le 0 ]]; then
        FILE_EPOCH=$(stat -c %Y "$FILE")
    else
        FILE_EPOCH="$BIRTH_EPOCH"
    fi

    AGE_SECONDS=$((CURRENT_EPOCH - FILE_EPOCH))

    if [[ "$AGE_SECONDS" -gt "$MAX_AGE_SECONDS" ]]; then
        echo "false"
        exit 0
    fi

done < <(find "$DIRECTORY" -maxdepth 1 -type f -name "*${PATTERN}*" -print0)

# Optional: If no files matched, return False
if [[ "$FOUND_MATCHES" = false ]]; then
    echo "false"
    exit 0
fi

echo "true"