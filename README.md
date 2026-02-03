# clawdbot-skills

Custom Clawdbot skills for personal use and sharing.

## Available Skills

### 📦 star-gazer
Track GitHub repositories with the most star gains.

**Prerequisites:**
- GitHub Personal Access Token with `repo` scope

**Usage:**
```bash
export GITHUB_TOKEN="your_github_token"

# Run the tracker
clawdbot exec --command "bash /path/to/star-gazer.sh"

# Dry-run (no API calls)
clawdbot exec --command "bash /path/to/star-gazer.sh --dry-run"
```

**Output:**
- Top 5 repos with most stars gained today
- Data saved to `~/.clawdbot/star-tracker.json`

---

### 📐 cad-gen
Generate CAD 3D models using FreeCAD Python API.

**Prerequisites:**
```bash
# Install FreeCAD
brew install freecad

# Verify installation
freecadcmd --version
```

**Usage:**
```bash
# Generate a box (mm)
clawdbot exec --command "bash /path/to/cad-gen.sh --shape box --width 50 --height 30 --depth 20"

# Generate a cylinder
clawdbot exec --command "bash /path/to/cad-gen.sh --shape cylinder --diameter 25 --height 40"

# Generate with filleted edges
clawdbot exec --command "bash /path/to/cad-gen.sh --shape box --width 50 --height 30 --depth 20 --fillet-radius 5"

# Export to all formats
clawdbot exec --command "bash /path/to/cad-gen.sh --shape box --width 50 --all-formats"

# Generate sphere
clawdbot exec --command "bash /path/to/cad-gen.sh --shape sphere --diameter 30 --segments 64"

# Generate cone/frustum
clawdbot exec --command "bash /path/to/cad-gen.sh --shape cone --diameter-base 30 --diameter-top 10 --height 40"

# Generate torus
clawdbot exec --command "bash /path/to/cad-gen.sh --shape torus --diameter-major 50 --diameter-minor 10"
```

**Parameters:**
| Shape | Required Parameters |
|-------|---------------------|
| box | `--width`, `--height`, `--depth` |
| cylinder | `--diameter`, `--height` |
| sphere | `--diameter` |
| cone | `--diameter-base`, `--diameter-top`, `--height` |
| torus | `--diameter-major`, `--diameter-minor` |

**Optional Parameters:**
| Parameter | Description |
|-----------|-------------|
| `--segments` | Number of segments (default: 50) |
| `--fillet-radius` | Fillet radius for box (mm) |
| `--chamfer-size` | Chamfer size for box (mm) |
| `--output-format` | stl, step, or dxf (default: stl) |
| `--all-formats` | Export in all formats |
| `--render` | Generate render image |

**Output Directory:** `~/clawd/cad-output/`

**Output Files:**
| Format | Extension | Use Case |
|--------|-----------|----------|
| STL | `.stl` | 3D printing |
| STEP | `.step` | CAD software exchange |
| DXF | `.dxf` | 2D drawings |
| FreeCAD | `.fcstd1` | Editable source |

---

## Adding New Skills

1. Create a folder: `<skill-name>/`
2. Add `SKILL.md` with documentation
3. Add executable scripts
4. Submit a PR or push directly

**Skill Structure:**
```
<skill-name>/
├── SKILL.md          # Required: Documentation
├── <skill-name>.sh   # Optional: Shell wrapper
└── scripts/          # Optional: Python/other scripts
    └── *.py
```

## License

MIT
