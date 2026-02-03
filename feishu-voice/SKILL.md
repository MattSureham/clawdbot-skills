---
name: feishu-voice
description: "Send voice replies to Feishu using macOS built-in say command. Free and works out of the box!"
metadata:
  {
    "openclaw":
      {
        "emoji": "🔊",
        "requires": { "bins": ["say"] },
        "install": [],
      },
  }
---

# Feishu Voice Skill

Send voice replies to Feishu using macOS built-in `say` command.

## Why macOS say?

✅ **100% Free** - No API keys needed
✅ **Works instantly** - Built into macOS
✅ **Feishu compatible** - MP3 format supported
✅ **Multiple voices** - Choose different speakers

## Available Voices

List all available voices:
```bash
say -v "?" | head -20
```

**Popular female voices:**
- Victoria - Professional
- Samantha - Friendly
- Karen - Australian
- Grace - Singaporean
- Tessa - South African

## Usage

### For Feishu

When you want a voice reply, say:
- "Reply with voice in Feishu"
- "Send voice to Feishu"
- "🔊 in Feishu"

### Manual Voice Generation

```bash
# Generate with default voice
clawdbot exec --command "bash /path/to/feishu-voice.sh 'Hello from voice'"

# With specific female voice
clawdbot exec --command "bash /path/to/feishu-voice.sh 'Hello' --voice Samantha"

# With slow, clear speech
clawdbot exec --command "bash /path/to/feishu-voice.sh 'Clear message' --voice Victoria --rate 150"
```

### Quick Voice

```bash
# Quick reply
clawdbot exec --command "bash /path/to/feishu-speak.sh 'Quick message'"
```

## Voice Options

| Option | Description |
|--------|-------------|
| `--voice NAME` | Voice to use (default: Samantha) |
| `--rate N` | Speaking rate (words per minute, default: 180) |
| `--output FILE` | Output file path |

### Voice Examples

```bash
# Professional
say -v Victoria "Professional message" -o professional.mp3

# Friendly
say -v Samantha "Friendly greeting" -o friendly.mp3

# Slow and clear
say -v Karen -r 150 "Slow and clear" -o slow.mp3

# All available voices
say -v "?"  # Lists all voices
```

## Feishu Compatibility

**Supported formats:**
- AIFF (native)
- MP3 (via afconvert)

**Recommended:**
- Keep under 60 seconds
- Use clear speech rate (150-180 wpm)
- AIFF format for best quality

```bash
# Convert AIFF to MP3 (if needed)
afconvert -f MP3 -d MP3 input.aiff output.mp3
```

## Examples

### Voice Styles for Feishu

```bash
# Warm greeting
say -v Samantha -r 170 "Hey! Got your message." -o greeting.aiff

# Curious question
say -v Victoria -r 160 "What do you think about this?" -o question.aiff

# Friendly update
say -v Samantha -r 180 "Just checking in with you!" -o update.aiff

# Whispered (use lower rate and softer voice)
say -v "Grace" -r 140 "[whispers] I have something to tell you" -o whisper.aiff
```

### Sending to Feishu

After generating audio, include in your Feishu reply:

```bash
# Generate the audio
clawdbot exec --command "bash /path/to/feishu-voice.sh 'Your message'"

# Include in response
# MEDIA:/tmp/feishu-voice-XXX.aiff
```

## Advanced

### Rate Reference

| Rate | Description |
|------|-------------|
| 100 | Very slow |
| 150 | Clear, slow |
| 180 | Normal |
| 220 | Fast |
| 260 | Very fast |

### Voice Characteristics

| Voice | Gender | Style |
|-------|--------|-------|
| Samantha | Female | Friendly, American |
| Victoria | Female | Professional, American |
| Karen | Female | Clear, Australian |
| Grace | Female | Soft, Singaporean |
| Tessa | Female | South African |
| Daniel | Male | British |

## Notes

- Audio saved to `/tmp/feishu-voice-*.aiff`
- AIFF format works with Feishu
- No API keys or accounts needed
- 100% free, unlimited usage
