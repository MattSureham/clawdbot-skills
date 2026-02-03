---
name: voice-mode
description: "Switch between text and voice replies. Use female voice for responses. Powered by ElevenLabs TTS."
metadata:
  {
    "openclaw":
      {
        "emoji": "🎙️",
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

# Voice Mode Skill

Reply with a female voice using ElevenLabs TTS.

## Setup

**Required environment variable:**
```bash
export ELEVENLABS_API_KEY="your_api_key"
```

**Recommended female voices:**
```bash
# List all available voices
sag voices

# Popular female voices:
# - Sarah (default female)
# - Jessica  
# - Emily
# - Bella
# - Olivia
```

**Set preferred voice:**
```bash
export ELEVENLABS_VOICE_ID="voice_id_here"
# Or use name: export SAG_VOICE_ID="Sarah"
```

## Usage

### Voice Reply

When you want a voice reply, say:
- "Reply with voice"
- "Use female voice"
- "Say this in voice"
- "🎙️"

I'll generate audio and send it as a media attachment.

### Manual Voice Generation

```bash
# Generate with default female voice
clawdbot exec --command "sag -o /tmp/voice.mp3 'Hello, this is a voice reply'"

# Generate with specific female voice
clawdbot exec --command "sag -v Sarah -o /tmp/voice.mp3 'Hello from Sarah'"

# Generate with different style
clawdbot exec --command "sag -v Bella '[whispers] Hello there' -o /tmp/voice.mp3"
```

### Voice Styles

Add audio tags for expression:
- `[whispers]` - Soft, quiet voice
- `[excited]` - Enthusiastic
- `[curious]` - Inquisitive tone
- `[laughs]` - With laughter
- `[sighs]` - Sighing

Example:
```bash
sag -v Emily -o /tmp/voice.mp3 "[whispers] I have a secret to tell you"
```

## Configuration

Set default female voice:
```bash
# In ~/.clawdbot/clawdbot.json or environment
export SAG_VOICE_ID="Sarah"    # Voice name
export ELEVENLABS_VOICE_ID=""  # Or use voice ID directly
```

## Examples

### Voice Styles

```bash
# Calm and gentle
sag -v Sarah -o calm.mp3 "[whispers] Take your time"

# Enthusiastic
sag -v Jessica -o excited.mp3 "[excited] This is amazing!"

# Curious
sag -v Emily -o curious.mp3 "[curious] What do you think?"

# With emotion
sag -v Bella -o emotional.mp3 "[laughs] That's so funny!"
```

### Sending Voice Reply

When generating a voice reply for you:
```bash
# Generate the audio
sag -v Sarah -o /tmp/reply.mp3 "Your message here"

# Include in response
# MEDIA:/tmp/reply.mp3
```

## Notes

- Audio saved to `/tmp/` by default
- Supports multiple languages with `--lang` flag
- Maximum length depends on ElevenLabs tier
- Use `--normalize auto` for better pronunciation
