#!/bin/bash
# CAD Gen - Generate CAD 3D models using FreeCAD
# Usage: ./cad-gen.sh --shape box --width 50 --height 30 --depth 20

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PYTHON_SCRIPT="$SCRIPT_DIR/scripts/cad_gen.py"
OUTPUT_DIR="${CAD_OUTPUT_DIR:-$HOME/clawd/cad-output}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if FreeCAD is installed
check_dependencies() {
    if ! command -v freecadcmd &> /dev/null; then
        log_error "FreeCAD not found. Please install first:"
        echo "  brew install freecad"
        exit 1
    fi
    
    if [ ! -f "$PYTHON_SCRIPT" ]; then
        log_error "Python script not found: $PYTHON_SCRIPT"
        exit 1
    fi
    
    # Create output directory
    mkdir -p "$OUTPUT_DIR"
}

# Show help
show_help() {
    cat << EOF
CAD Gen - Generate CAD 3D models using FreeCAD

Usage: $(basename "$0") [OPTIONS]

Options:
  --shape SHAPE         Shape to generate (box, cylinder, sphere, cone, torus)
  --width WIDTH         Width (for box) [mm]
  --height HEIGHT       Height [mm]
  --depth DEPTH         Depth (for box) [mm]
  --diameter DIAMETER   Diameter (for cylinder, sphere) [mm]
  --diameter-base D     Base diameter (for cone) [mm]
  --diameter-top D      Top diameter (for cone) [mm]
  --diameter-major D    Major diameter (for torus) [mm]
  --diameter-minor D    Minor diameter (for torus) [mm]
  --segments N          Number of segments (default: 50)
  --fillet-radius R     Fillet radius (for box) [mm]
  --chamfer-size C      Chamfer size (for box) [mm]
  --output-format FMT   Output format: stl, step, dxf (default: stl)
  --all-formats         Export in all formats
  --render              Generate render image
  --help                Show this help

Examples:
  # Generate a box
  $(basename "$0") --shape box --width 50 --height 30 --depth 20

  # Generate a cylinder
  $(basename "$0") --shape cylinder --diameter 25 --height 40

  # Generate with all output formats
  $(basename "$0") --shape box --width 50 --height 30 --all-formats

  # Generate with filleted edges
  $(basename "$0") --shape box --width 50 --height 30 --depth 20 --fillet-radius 5

Output saved to: $OUTPUT_DIR

EOF
}

# Parse arguments and run FreeCAD
run_freecad() {
    log_info "Generating CAD model..."
    
    # Run the Python script with all arguments
    freecadcmd "$PYTHON_SCRIPT" "$@"
    
    log_info "Done! Files saved to: $OUTPUT_DIR"
}

# Main
main() {
    if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        show_help
        exit 0
    fi
    
    check_dependencies
    run_freecad "$@"
}

main "$@"
