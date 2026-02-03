#!/bin/bash
# Feishu Voice - Generate voice for Feishu messages
# Usage: ./feishu-voice.sh "Your message here" [--voice NAME] [--style STYLE]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_DIR="${FEISHU_VOICE_DIR:-/tmp}"
VOICE="${SAG_VOICE_ID:-Sarah}"
MAX_DURATION=60  # seconds, for Feishu compatibility

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --voice)
            VOICE="$2"
            shift 2
            ;;
        --style)
            STYLE="$2"
            shift 2
            ;;
        --output)
            OUTPUT_DIR="$2"
            shift 2
            ;;
        --max-duration)
            MAX_DURATION="$2"
            shift 2
            ;;
        *)
            MESSAGE="$1"
            shift
            ;;
    esac
done

# Check dependencies
if ! command -v sag &> /dev/null; then
    echo "Error: sag not found. Install with:"
    echo "  brew install steipete/tap/sag"
    echo ""
    echo "Then set your API key:"
    echo "  export ELEVENLABS_API_KEY=\"your_key\""
    exit 1
fi

# Check API key
if [ -z "$ELEVENLABS_API_KEY" ]; then
    echo "Error: ELEVENLABS_API_KEY not set"
    echo "  export ELEVENLABS_API_KEY=\"your_api_key\""
    exit 1
fi

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Generate unique filename
TIMESTAMP=$(date +%s)
OUTPUT_FILE="$OUTPUT_DIR/feishu-voice-$TIMESTAMP.mp3"

# Build command
CMD="sag -v \"$VOICE\" -o \"$OUTPUT_FILE\""

# Add style if specified (Feishu-friendly styles)
if [ -n "$STYLE" ]; then
    CMD="$CMD \"[$STYLE] $MESSAGE\""
else
    CMD="$CMD \"$MESSAGE\""
fi

# Generate voice
echo "🔊 Generating Feishu voice message..."
echo "   Voice: $VOICE"
echo "   Style: ${STYLE:-none}"
echo "   Output: $OUTPUT_FILE"

eval "$CMD"

# Check if file was created
if [ ! -f "$OUTPUT_FILE" ]; then
    echo "Error: Failed to generate audio file"
    exit 1
fi

# Get duration (using afinfo or ffprobe)
DURATION=0
if command -v ffprobe &> /dev/null; then
    DURATION=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$OUTPUT_FILE" 2>/dev/null || echo "0")
elif command -v afinfo &> /dev/null; then
    DURATION=$(afinfo "$OUTPUT_FILE" 2>/dev/null | grep "Duration" | awk '{print $3}' | cut -d. -f1 || echo "0")
fi

echo ""
echo "✅ Voice message generated!"
echo "📁 File: $OUTPUT_FILE"
echo "⏱️  Duration: ${DURATION}s"
echo ""

# Check duration limit
if [ "$DURATION" -gt "$MAX_DURATION" ] 2>/dev/null; then
    echo "⚠️  Warning: Audio is ${DURATION}s, longer than Feishu's ${MAX_DURATION}s limit."
    echo "   Consider shorter messages for better compatibility."
    echo ""
fi

# Output for Clawdbot to include
echo "To send to Feishu, include in your reply:"
echo "   MEDIA:$OUTPUT_FILE"
echo ""
echo "Or use the file path directly:"
echo "   $OUTPUT_FILE"
