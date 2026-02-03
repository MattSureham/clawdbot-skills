#!/bin/bash
# Quick Feishu voice reply - generates female voice for Feishu
# Usage: echo "Hello" | ./feishu-speak.sh
#   Or: ./feishu-speak.sh "Hello world"

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VOICE="${SAG_VOICE_ID:-Sarah}"

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

# Generate audio for Feishu
OUTPUT="/tmp/feishu-voice-$(date +%s).mp3"

sag -v "$VOICE" -o "$OUTPUT" "$MESSAGE"

echo "🔊 $OUTPUT"
echo "MEDIA:$OUTPUT"
echo ""
echo "File: $OUTPUT"
