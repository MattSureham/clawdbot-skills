---
name: cad-gen
description: "Generate CAD 3D models using FreeCAD Python API. Supports parametric modeling, STL/STEP/DXF export, and rendering."
metadata:
  {
    "openclaw":
      {
        "emoji": "📐",
        "requires": { "bins": ["freecad", "python3"] },
        "install":
          [
            {
              "id": "brew",
              "kind": "brew",
              "formula": "freecad",
              "bins": ["freecadcmd"],
              "label": "Install FreeCAD (brew)",
            },
          ],
      },
  }
---

# CAD Gen Skill

Generate CAD 3D models using FreeCAD Python API. Perfect for parametric modeling, 3D printing, and CAD automation.

## Features

- **Natural Language → 3D Model** - Describe what you want, get the model
- **Parametric Modeling** - Adjust dimensions via parameters
- **Multiple Formats** - Export to STL, STEP, DXF, PNG
- **Batch Generation** - Create multiple variants at once
- **Rendering** - Generate photorealistic renders

## Usage

### Basic Generation

```bash
# Generate a simple box
clawdbot exec --command "bash /path/to/cad-gen.sh --shape box --width 50 --height 30 --depth 20"

# Generate a cylinder
clawdbot exec --command "bash /path/to/cad-gen.sh --shape cylinder --diameter 25 --height 40"

# Generate from description
clawdbot exec --command "bash /path/to/cad-gen.sh --describe 'a box with a hole in the middle'"
```

### Export Options

```bash
# Export to STL (3D printing)
clawdbot exec --command "bash /path/to/cad-gen.sh --shape box --output-format stl"

# Export to STEP (CAD software exchange)
clawdbot exec --command "bash /path/to/cad-gen.sh --shape cylinder --output-format step"

# Export to DXF (2D drawings)
clawdbot exec --command "bash /path/to/cad-gen.sh --shape box --output-format dxf"

# Generate render image
clawdbot exec --command "bash /path/to/cad-gen.sh --shape box --render"
```

### Parametric Models

```bash
# With parameters
clawdbot exec --command "bash /path/to/cad-gen.sh --template bracket --params 'width=100,height=50,thickness=3'"

# Adjust existing model
clawdbot exec --command "bash /path/to/cad-gen.sh --input model.fcstd1 --modify 'change_height=60'"
```

### Batch Generation

```bash
# Generate multiple sizes
clawdbot exec --command "bash /path/to/cad-gen.sh --batch sizes.json"

# Where sizes.json contains:
# [
#   {"name": "small", "width": 20, "height": 20},
#   {"name": "medium", "width": 40, "height": 40},
#   {"name": "large", "width": 60, "height": 60}
# ]
```

## Templates

See [templates/README.md](templates/README.md) for example parametric templates:

- **bracket** - L-shaped bracket with mounting holes
- **gear** - Involute gear
- **pcb-holder** - PCB holder with clips

## Output

Generated files saved to `~/clawd/cad-output/`:
- `model.stl` - STL for 3D printing
- `model.step` - STEP for CAD software
- `model.dxf` - DXF for 2D drawings
- `model.png` - Rendered image

## Configuration

Environment variables:
- `CAD_OUTPUT_DIR` - Output directory (default: ~/clawd/cad-output)
- `FREECAD_PATH` - FreeCAD library path (auto-detected)

## Examples

### Simple Shapes

```bash
# Box
--shape box --width 50 --height 30 --depth 20

# Cylinder
--shape cylinder --diameter 25 --height 40 --segments 50

# Sphere
--shape sphere --diameter 30 --segments 64

# Cone
--shape cone --diameter-base 30 --diameter-top 10 --height 40

# Torus
--shape torus --diameter-major 50 --diameter-minor 10 --segments 48
```

### Advanced

```bash
# Filleted box
--shape box --width 50 --height 30 --depth 20 --fillet-radius 5

# Hollow cylinder
--shape cylinder --diameter 25 --height 40 --wall-thickness 3

# Chamfered edge
--shape box --width 50 --height 30 --depth 20 --chamfer-size 2
```

## Notes

- Requires FreeCAD installed with `freecadcmd`
- For complex models, consider using FreeCAD GUI directly
- Large models may take time to render
