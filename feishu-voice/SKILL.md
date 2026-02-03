---
name: feishu-voice
description: "Generate and send voice replies to Feishu. Converts text to speech using ElevenLabs and sends as Feishu audio messages."
metadata:
  {
    "openclaw":
      {
        "emoji": "🔊",
        "requires": { "bins": ["sag"], "env": ["ELEVENLABS_API_KEY"] },
        "install":
          [
            {
              "id": "brew",
              "kind": "brew",
              "formula": "steipete/tap/sag",
              "bins": ["sag"],
              "label": "Install sag (TTS)",
            },
          ],
      },
  }
---

# Feishu Voice Skill

Send voice replies to Feishu using ElevenLabs TTS.

## Setup

**Required environment variable:**
```bash
export ELEVENLABS_API_KEY="your_api_key"
```

**Recommended female voices for Feishu:**
```bash
# Set default voice
export SAG_VOICE_ID="Sarah"    # Friendly female voice
# Or use voice ID directly
export ELEVENLABS_VOICE_ID="voice_id"
```

**Popular female voices:**
- Sarah - Warm, friendly
- Jessica - Professional
- Emily - Casual, young
- Bella - Soft, gentle

## Usage

### For Feishu

When you want a voice reply in Feishu, say:
- "Reply with voice in Feishu"
- "Send voice to Feishu"
- "🔊 in Feishu"

The skill will:
1. Generate audio using ElevenLabs
2. Save to a format Feishu can send
3. Prepare for attachment in Feishu message

### Manual Voice Generation

```bash
# Generate with default female voice
clawdbot exec --command "bash /path/to/feishu-voice.sh 'Hello from voice'"

# With specific voice
clawdbot exec --command "bash /path/to/feishu-voice.sh 'Hello' --voice Sarah"

# With style
clawdbot exec --command "bash /path/to/feishu-voice.sh 'Secret' --style whispers"
```

### Feishu-Specific Styles

For Feishu audio messages, these styles work well:
- `[whispers]` - Intimate, personal
- `[curious]` - Engaging
- `[excited]` - Enthusiastic greeting
- Standard (no tags) - Professional

## Feishu Audio Format

Feishu supports:
- **Audio messages**: MP3 format, under 2MB recommended
- **Duration**: Keep under 60 seconds for best compatibility

```bash
# Check audio duration
afinfo /tmp/feishu-voice.mp3 | grep Duration

# Or
ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 /tmp/feishu-voice.mp3
```

## Configuration

Set default voice in `~/.clawdbot/clawdbot.json`:
```json
{
  "feishu": {
    "voice": {
      "enabled": true,
      "defaultVoice": "Sarah",
      "maxDuration": 60
    }
  }
}
```

## Examples

### Voice Styles for Feishu

```bash
# Warm greeting (recommended for Feishu)
sag -v Sarah -o /tmp/voice.mp3 "Hey! Got your message."

# Curious question
sag -v Emily -o /tmp/voice.mp3 "[curious] What do you think about this?"

# Friendly update
sag -v Jessica -o /tmp/voice.mp3 "Just wanted to check in with you!"

# Whispered secret
sag -v Bella -o /tmp/voice.mp3 "[whispers] I have something to tell you"
```

### Sending to Feishu

After generating audio, include in your Feishu reply:

```bash
# Generate the audio
clawdbot exec --command "bash /path/to/feishu-voice.sh 'Your message'"

# Include in response
# MEDIA:/tmp/feishu-voice-XXX.mp3
```

## Notes

- Keep audio under 60 seconds for Feishu
- MP3 format works best
- File saved to `/tmp/feishu-voice-*.mp3`
- Delete old files periodically to save space
