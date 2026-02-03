#!/bin/bash
# Quick voice reply - say anything in female voice
# Usage: echo "Hello" | ./speak.sh
#   Or: ./speak.sh "Hello world"

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

# Generate audio
OUTPUT="/tmp/voice_reply_$(date +%s).mp3"

sag -v "$VOICE" -o "$OUTPUT" "$MESSAGE"

echo "🎙️ $OUTPUT"
echo "MEDIA:$OUTPUT"
