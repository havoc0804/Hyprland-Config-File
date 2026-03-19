#!/bin/bash

# Path to wallpapers (inside dotfiles repo)
WALLDIR="$HOME/dotfiles/Wallpapers"

# Persistent index
INDEX_FILE="$HOME/.cache/wall_index"
mkdir -p "$(dirname "$INDEX_FILE")"
[ -f "$INDEX_FILE" ] || echo 1 > "$INDEX_FILE"  # start at wallpaper 1
INDEX=$(cat "$INDEX_FILE")

# Count wallpapers
COUNT=$(ls "$WALLDIR" | wc -l)

# Determine direction
case "$1" in
  next)
    INDEX=$(( (INDEX % COUNT) + 1 ))  # wraps from x -> 1
    ;;
  prev)
    INDEX=$(( (INDEX - 2 + COUNT) % COUNT + 1 ))  # wraps from 1 -> x
    ;;
  *)
    echo "Usage: $0 next|prev"
    exit 1
    ;;
esac

# Save updated index
echo "$INDEX" > "$INDEX_FILE"

# Apply wallpaper
swww img "$WALLDIR/$INDEX" --transition-type wipe --transition-duration 0.8
