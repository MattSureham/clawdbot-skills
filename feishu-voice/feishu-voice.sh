#!/bin/bash
# Feishu Voice - Generate voice for Feishu using macOS say
# Usage: ./feishu-voice.sh "Your message" [--voice NAME] [--rate N] [--output FILE]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_DIR="${FEISHU_VOICE_DIR:-/tmp}"
VOICE="${FEISHU_VOICE:-Samantha}"
RATE="${FEISHU_VOICE_RATE:-180}"

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --voice)
            VOICE="$2"
            shift 2
            ;;
        --rate)
            RATE="$2"
            shift 2
            ;;
        --output)
            OUTPUT_DIR="$2"
            shift 2
            ;;
        *)
            MESSAGE="$1"
            shift
            ;;
    esac
done

# Check dependencies
if ! command -v say &> /dev/null; then
    echo "Error: 'say' command not found. This requires macOS."
    exit 1
fi

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Generate unique filename
TIMESTAMP=$(date +%s)
OUTPUT_FILE="$OUTPUT_DIR/feishu-voice-$TIMESTAMP.aiff"

# Generate voice
echo "🔊 Generating Feishu voice message..."
echo "   Voice: $VOICE"
echo "   Rate: $RATE wpm"
echo "   Output: $OUTPUT_FILE"

# Generate using macOS say
say -v "$VOICE" -r "$RATE" -o "$OUTPUT_FILE" "$MESSAGE"

# Check if file was created
if [ ! -f "$OUTPUT_FILE" ]; then
    echo "Error: Failed to generate audio file"
    exit 1
fi

# Get duration
DURATION=$(afinfo "$OUTPUT_FILE" 2>/dev/null | grep "Duration" | awk '{print $3}' | cut -d. -f1 || echo "?")

echo ""
echo "✅ Voice message generated!"
echo "📁 File: $OUTPUT_FILE"
echo "⏱️  Duration: ${DURATION}s"
echo ""
echo "To send to Feishu, include in your reply:"
echo "   MEDIA:$OUTPUT_FILE"
