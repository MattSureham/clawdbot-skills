#!/bin/bash
# Quick Feishu voice reply - uses macOS say (free!)
# Usage: echo "Hello" | ./feishu-speak.sh
#   Or: ./feishu-speak.sh "Hello world"

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VOICE="${FEISHU_VOICE:-Samantha}"
RATE="${FEISHU_VOICE_RATE:-180}"

# Get message from stdin or argument
if [ -p /dev/stdin ]; then
    MESSAGE=$(cat)
elif [ -n "$1" ]; then
    MESSAGE="$1"
else
    echo "Usage: $0 \"Your message here\""
    echo "   Or: echo \"Hello\" | $0"
    exit 1
fi

# Generate audio
OUTPUT="/tmp/feishu-voice-$(date +%s).aiff"

say -v "$VOICE" -r "$RATE" -o "$OUTPUT" "$MESSAGE"

echo "🔊 $OUTPUT"
echo "MEDIA:$OUTPUT"
