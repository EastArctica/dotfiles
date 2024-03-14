#!/bin/bash

# Check if checkupdates-with-aur is available
if ! command -v checkupdates-with-aur &> /dev/null; then
    echo "checkupdates-with-aur not installed"
    exit 1
fi

updates=$(checkupdates-with-aur)

# Fix: Check if updates is empty before counting
if [ -z "$updates" ]; then
    update_count=0
else
    update_count=$(echo "$updates" | wc -l)
fi

if [ "$update_count" -gt 0 ]; then
    class="available"
else
    class="none"
fi

echo "{\"text\": \"$update_count updates\", \"tooltip\": \"$updates\", \"class\": \"$class\"}"

