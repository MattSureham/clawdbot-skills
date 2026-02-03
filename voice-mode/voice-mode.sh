#!/bin/bash
# Voice Mode - Generate female voice replies
# Usage: ./voice-mode.sh "Your message here" [--voice NAME] [--style STYLE]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_DIR="${VOICE_OUTPUT_DIR:-/tmp}"
VOICE="${SAG_VOICE_ID:-Sarah}"
STYLE=""

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

# Build command
OUTPUT_FILE="$OUTPUT_DIR/voice_$(date +%s).mp3"
CMD="sag -v \"$VOICE\" -o \"$OUTPUT_FILE\""

# Add style if specified
if [ -n "$STYLE" ]; then
    CMD="$CMD \"[$STYLE] $MESSAGE\""
else
    CMD="$CMD \"$MESSAGE\""
fi

# Generate voice
echo "🎙️ Generating voice reply..."
echo "   Voice: $VOICE"
echo "   Style: ${STYLE:-none}"
echo "   Output: $OUTPUT_FILE"

eval "$CMD"

echo ""
echo "✅ Voice reply generated!"
echo "📁 File: $OUTPUT_FILE"
echo ""
echo "To use in Clawdbot, include in your reply:"
echo "   MEDIA:$OUTPUT_FILE"
