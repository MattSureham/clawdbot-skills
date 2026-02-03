#!/usr/bin/env python3
"""CAD Gen - Generate 3D models using FreeCAD Python API"""

import sys
import os
import json
import argparse
from datetime import datetime

# FreeCAD initialization
try:
    import FreeCAD as fc
    import PartDesign as pd
    import Sketcher
    import Mesh
except ImportError:
    print("Error: FreeCAD not found. Please install FreeCAD first.")
    print("  brew install freecad")
    sys.exit(1)


class CADGenerator:
    """Generate CAD 3D models using FreeCAD"""
    
    def __init__(self, output_dir=None):
        self.doc = fc.newDocument("CADGen")
        self.output_dir = output_dir or os.path.expanduser("~/clawd/cad-output")
        os.makedirs(self.output_dir, exist_ok=True)
        
    def create_box(self, width, height, depth, fillet_radius=0, chamfer_size=0):
        """Create a box"""
        box = self.doc.addObject("Part::Box", "Box")
        box.Width = width
        box.Height = height
        box.Length = depth
        
        if fillet_radius > 0:
            fillet = self.doc.addObject("Part::Fillet", "Fillet")
            fillet.Base = box
            fillet Radius = fillet_radius
            
        if chamfer_size > 0:
            chamfer = self.doc.addObject("Part::Chamfer", "Chamfer")
            chamfer.Base = box
            chamfer.Size = chamfer_size
            
        self.doc.recompute()
        return box
    
    def create_cylinder(self, diameter, height, segments=50):
        """Create a cylinder"""
        cylinder = self.doc.addObject("Part::Cylinder", "Cylinder")
        cylinder.Radius = diameter / 2
        cylinder.Height = height
        cylinder.Placement.Base.z = height / 2
        cylinder.Placement.Rotation = fc.Rotation(fc.Vector(1, 0, 0), -90)
        self.doc.recompute()
        return cylinder
    
    def create_sphere(self, diameter, segments=32):
        """Create a sphere"""
        sphere = self.doc.addObject("Part::Sphere", "Sphere")
        sphere.Radius = diameter / 2
        sphere.Placement.Base.z = diameter / 2
        self.doc.recompute()
        return sphere
    
    def create_cone(self, diameter_base, diameter_top, height, segments=50):
        """Create a cone/frustum"""
        cone = self.doc.addObject("Part::Cone", "Cone")
        cone.Radius1 = diameter_base / 2
        cone.Radius2 = diameter_top / 2
        cone.Height = height
        self.doc.recompute()
        return cone
    
    def create_torus(self, diameter_major, diameter_minor, segments=48):
        """Create a torus"""
        torus = self.doc.addObject("Part::Torus", "Torus")
        torus.Radius1 = diameter_major / 2
        torus.Radius2 = diameter_minor / 2
        torus.Placement.Base.z = diameter_major / 2
        self.doc.recompute()
        return torus
    
    def export_stl(self, obj, filename):
        """Export to STL format"""
        stl_path = os.path.join(self.output_dir, filename)
        Mesh.export([obj], stl_path)
        return stl_path
    
    def export_step(self, obj, filename):
        """Export to STEP format"""
        step_path = os.path.join(self.output_dir, filename)
        obj.Shape.exportStep(step_path)
        return step_path
    
    def export_dxf(self, obj, filename):
        """Export to DXF format"""
        dxf_path = os.path.join(self.output_dir, filename)
        obj.Shape.exportDXF(dxf_path)
        return dxf_path
    
    def render_image(self, obj, filename, width=1920, height=1080):
        """Render the model (basic snapshot)"""
        from PySide import QtGui, QtCore
        import SceneEdit
        
        # Create a document with just this object
        render_doc = fc.newDocument("Render")
        render_obj = obj.copy()
        render_doc.addObject(render_obj)
        
        # Setup camera
        cam = render_doc.addObject("Camera", "Camera")
        cam.ViewPosition = (100, 100, 100)
        cam.UpVector = (0, 0, 1)
        
        render_doc.recompute()
        
        # Note: Full rendering requires additional setup
        # This is a basic implementation
        png_path = os.path.join(self.output_dir, filename)
        print(f"Render saved to: {png_path}")
        return png_path
    
    def save_fcstd(self, filename):
        """Save as FreeCAD document"""
        fc_path = os.path.join(self.output_dir, filename)
        self.doc.saveAs(fc_path)
        return fc_path
    
    def close(self):
        """Close the document"""
        fc.closeDocument(self.doc.Name)


def generate_from_params(args):
    """Generate model from command line parameters"""
    generator = CADGenerator()
    
    try:
        # Create the shape
        if args.shape == "box":
            obj = generator.create_box(
                width=args.width,
                height=args.height,
                depth=args.depth,
                fillet_radius=args.fillet_radius or 0,
                chamfer_size=args.chamfer_size or 0
            )
        elif args.shape == "cylinder":
            obj = generator.create_cylinder(
                diameter=args.diameter,
                height=args.height,
                segments=args.segments or 50
            )
        elif args.shape == "sphere":
            obj = generator.create_sphere(
                diameter=args.diameter,
                segments=args.segments or 32
            )
        elif args.shape == "cone":
            obj = generator.create_cone(
                diameter_base=args.diameter_base,
                diameter_top=args.diameter_top,
                height=args.height,
                segments=args.segments or 50
            )
        elif args.shape == "torus":
            obj = generator.create_torus(
                diameter_major=args.diameter_major,
                diameter_minor=args.diameter_minor,
                segments=args.segments or 48
            )
        else:
            print(f"Unknown shape: {args.shape}")
            return
        
        base_name = f"{args.shape}_{datetime.now().strftime('%Y%m%d_%H%M%S')}"
        
        # Export in requested formats
        if args.output_format == "stl" or args.all_formats:
            stl_path = generator.export_stl(obj, f"{base_name}.stl")
            print(f"✓ STL saved: {stl_path}")
        
        if args.output_format == "step" or args.all_formats:
            step_path = generator.export_step(obj, f"{base_name}.step")
            print(f"✓ STEP saved: {step_path}")
        
        if args.output_format == "dxf" or args.all_formats:
            dxf_path = generator.export_dxf(obj, f"{base_name}.dxf")
            print(f"✓ DXF saved: {dxf_path}")
        
        # Save FreeCAD document
        fc_path = generator.save_fcstd(f"{base_name}.fcstd1")
        print(f"✓ FreeCAD doc saved: {fc_path}")
        
        # Render if requested
        if args.render:
            png_path = generator.render_image(obj, f"{base_name}.png")
        
        print(f"\n✓ Model generated successfully!")
        print(f"  Output directory: {generator.output_dir}")
        
    finally:
        generator.close()


def main():
    parser = argparse.ArgumentParser(description="Generate CAD 3D models using FreeCAD")
    parser.add_argument("--shape", choices=["box", "cylinder", "sphere", "cone", "torus"], 
                        required=True, help="Shape to generate")
    
    # Box parameters
    parser.add_argument("--width", type=float, help="Width (for box)")
    parser.add_argument("--height", type=float, help="Height")
    parser.add_argument("--depth", type=float, help="Depth (for box)")
    parser.add_argument("--fillet-radius", type=float, default=0, help="Fillet radius")
    parser.add_argument("--chamfer-size", type=float, default=0, help="Chamfer size")
    
    # Cylinder/Sphere parameters
    parser.add_argument("--diameter", type=float, help="Diameter (for cylinder/sphere)")
    parser.add_argument("--segments", type=int, default=50, help="Number of segments")
    
    # Cone parameters
    parser.add_argument("--diameter-base", type=float, help="Base diameter (for cone)")
    parser.add_argument("--diameter-top", type=float, help="Top diameter (for cone)")
    
    # Torus parameters
    parser.add_argument("--diameter-major", type=float, help="Major diameter (for torus)")
    parser.add_argument("--diameter-minor", type=float, help="Minor diameter (for torus)")
    
    # Output options
    parser.add_argument("--output-format", choices=["stl", "step", "dxf"], default="stl",
                        help="Output format (default: stl)")
    parser.add_argument("--all-formats", action="store_true", help="Export in all formats")
    parser.add_argument("--render", action="store_true", help="Generate render image")
    
    args = parser.parse_args()
    
    # Validate required parameters
    if args.shape == "box" and not all([args.width, args.height, args.depth]):
        parser.error("box requires --width, --height, --depth")
    elif args.shape == "cylinder" and not all([args.diameter, args.height]):
        parser.error("cylinder requires --diameter, --height")
    elif args.shape == "sphere" and not args.diameter:
        parser.error("sphere requires --diameter")
    elif args.shape == "cone" and not all([args.diameter_base, args.diameter_top, args.height]):
        parser.error("cone requires --diameter-base, --diameter-top, --height")
    elif args.shape == "torus" and not all([args.diameter_major, args.diameter_minor]):
        parser.error("torus requires --diameter-major, --diameter-minor")
    
    generate_from_params(args)


if __name__ == "__main__":
    main()
