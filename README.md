# clawdbot-skills

Custom Clawdbot skills for personal use and sharing.

## 📋 Menu

| Skill | Description |
|-------|-------------|
| [📦 star-gazer](#-star-gazer) | Track GitHub repositories with most star gains |
| [📐 cad-gen](#-cad-gen) | Generate CAD 3D models using FreeCAD |
| [🎙️ voice-mode](#-voice-mode) | Switch between text and voice replies |
| [🔊 feishu-voice](#-feishu-voice) | Send voice replies to Feishu |

---

## 📦 star-gazer

Track GitHub repositories with the most star gains.

<details>
<summary><b>Prerequisites</b></summary>

- GitHub Personal Access Token with `repo` scope

```bash
export GITHUB_TOKEN="your_github_token"
```
</details>

<details>
<summary><b>Usage</b></summary>

```bash
# Run the tracker
clawdbot exec --command "bash /path/to/star-gazer.sh"

# Dry-run (no API calls)
clawdbot exec --command "bash /path/to/star-gazer.sh --dry-run"
```

**Output:**
- Top 5 repos with most stars gained today
- Data saved to `~/.clawdbot/star-tracker.json`
</details>

---

## 📐 cad-gen

Generate CAD 3D models using FreeCAD Python API.

<details>
<summary><b>Prerequisites</b></summary>

```bash
# Install FreeCAD
brew install freecad

# Verify installation
freecadcmd --version
```
</details>

<details>
<summary><b>Basic Usage</b></summary>

```bash
# Generate a box (mm)
clawdbot exec --command "bash /path/to/cad-gen.sh --shape box --width 50 --height 30 --depth 20"

# Generate a cylinder
clawdbot exec --command "bash /path/to/cad-gen.sh --shape cylinder --diameter 25 --height 40"

# Export to all formats
clawdbot exec --command "bash /path/to/cad-gen.sh --shape box --width 50 --all-formats"
```
</details>

<details>
<summary><b>Parameters</b></summary>

| Shape | Required Parameters |
|-------|---------------------|
| box | `--width`, `--height`, `--depth` |
| cylinder | `--diameter`, `--height` |
| sphere | `--diameter` |
| cone | `--diameter-base`, `--diameter-top`, `--height` |
| torus | `--diameter-major`, `--diameter-minor` |

| Parameter | Description |
|-----------|-------------|
| `--segments` | Number of segments (default: 50) |
| `--fillet-radius` | Fillet radius for box (mm) |
| `--chamfer-size` | Chamfer size for box (mm) |
| `--output-format` | stl, step, or dxf (default: stl) |
| `--all-formats` | Export in all formats |
</details>

<details>
<summary><b>Output</b></summary>

**Directory:** `~/clawd/cad-output/`

| Format | Extension | Use Case |
|--------|-----------|----------|
| STL | `.stl` | 3D printing |
| STEP | `.step` | CAD software exchange |
| DXF | `.dxf` | 2D drawings |
| FreeCAD | `.fcstd1` | Editable source |
</details>

---

## 🎙️ voice-mode

Switch between text and voice replies. Use female voice for responses.

<details>
<summary><b>Prerequisites</b></summary>

```bash
# Install sag (ElevenLabs TTS)
brew install steipete/tap/sag

# Set API key
export ELEVENLABS_API_KEY="your_api_key"
```
</details>

<details>
<summary><b>Popular Female Voices</b></summary>

- Sarah - Warm, friendly (recommended)
- Jessica - Professional
- Emily - Casual, young
- Bella - Soft, gentle

```bash
# Set default voice
export SAG_VOICE_ID="Sarah"
```
</details>

<details>
<summary><b>Usage</b></summary>

```bash
# Generate voice reply
clawdbot exec --command "bash /path/to/voice-mode.sh 'Hello!'"

# With specific voice
clawdbot exec --command "bash /path/to/voice-mode.sh 'Hello!' --voice Sarah"

# With style
clawdbot exec --command "bash /path/to/voice-mode.sh 'Secret' --style whispers"
```

**Voice Styles:**
- `[whispers]` - Soft, quiet
- `[excited]` - Enthusiastic
- `[curious]` - Inquisitive
- `[laughs]` - With laughter
- `[sighs]` - Sighing
</details>

<details>
<summary><b>Output</b></summary>

- Audio saved to `/tmp/voice_*.mp3`
- Include in reply: `MEDIA:/tmp/voice-XXX.mp3`
</details>

---

## 🔊 feishu-voice

Send voice replies to Feishu. Optimized for Feishu audio message format.

<details>
<summary><b>Prerequisites</b></summary>

```bash
# Install sag (ElevenLabs TTS)
brew install steipete/tap/sag

# Set API key
export ELEVENLABS_API_KEY="your_api_key"

# Set default voice (recommended)
export SAG_VOICE_ID="Sarah"
```
</details>

<details>
<summary><b>Usage</b></summary>

```bash
# Generate voice for Feishu
clawdbot exec --command "bash /path/to/feishu-voice.sh 'Hello from voice'"

# With specific voice
clawdbot exec --command "bash /path/to/feishu-voice.sh 'Hello' --voice Sarah"

# Quick speak
clawdbot exec --command "bash /path/to/feishu-speak.sh 'Quick message'"
```
</details>

<details>
<summary><b>Feishu-Specific Styles</b></summary>

- `[whispers]` - Intimate, personal
- `[curious]` - Engaging question
- `[excited]` - Enthusiastic greeting
</details>

<details>
<summary><b>Output</b></summary>

- **Format:** MP3 (Feishu compatible)
- **Max Duration:** 60 seconds recommended
- **Location:** `/tmp/feishu-voice-*.mp3`
- **Include in Feishu:** `MEDIA:/tmp/feishu-voice-XXX.mp3`
</details>

---

## ➕ Adding New Skills

1. Create a folder: `<skill-name>/`
2. Add `SKILL.md` with documentation
3. Add executable scripts
4. Push to this repository

**Skill Structure:**
```
<skill-name>/
├── SKILL.md          # Required: Documentation
├── <skill-name>.sh   # Optional: Shell wrapper
└── scripts/          # Optional: Python/other scripts
    └── *.py
```

---

## 📝 License

MIT
