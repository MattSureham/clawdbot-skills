# CAD Gen Templates

Example parametric templates for CAD Gen.

## Bracket Template

A simple L-shaped bracket with mounting holes.

```bash
# Generate bracket
./cad-gen.sh --template bracket --params "width=100,height=50,thickness=3"
```

## Gear Template

A simple involute gear.

```bash
# Generate gear
./cad-gen.sh --template gear --params "teeth=20,module=2,pitch_diameter=40"
```

## PCB Holder Template

A simple PCB holder with clips.

```bash
# Generate PCB holder
./cad-gen.sh --template pcb-holder --params "width=80,height=50,thickness=2"
```

## Adding New Templates

1. Create a new Python file in `templates/`
2. Implement a function: `create_<template_name>(generator, params)`
3. Register the template in `templates/__init__.py`

Example template structure:

```python
def create_my_template(generator, params):
    width = params.get('width', 50)
    height = params.get('height', 30)
    
    # Create the model
    obj = generator.create_box(width=width, height=height, depth=10)
    
    return obj
```
