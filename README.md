# Improved Parametric Embroidery Hoop

## Attribution

**Original Design:** Braden Sunwold  
**Original Model:** https://www.printables.com/model/505535-parametric-embroidery-hoop  
**License:** Creative Commons Attribution 4.0 International (CC BY 4.0)

This is an enhanced derivative with extensive new features while maintaining the excellent original functionality.

---

## What's New in This Version

### 🎯 Core Improvements

1. **Organized Customizer Interface**
   - Parameters grouped into logical categories
   - Clear, descriptive labels for all settings
   - Helpful tooltips and descriptions
   - Proper embroidery terminology

2. **Intelligent Parameter Validation**
   - Real-time sanity checks prevent invalid configurations
   - Automatic adjustment with console warnings when settings conflict
   - 3mm minimum clearance from groove to ring edges
   - Echo statements provide clear feedback during generation

### ✨ New Features

#### Inner Ring Enhancements
- **Solid Puck Mode**: Option to create a solid disc instead of hollow ring
- **Independent Chamfers**: Separate control for top and bottom edge chamfers
- **Retention Groove**: Optional groove for rubber band or string
  - Adjustable offset from top
  - Two profile shapes: elliptical (rounded) or rectangular
  - Configurable height and depth
  - Automatic safety positioning (maintains 3mm from edges)

#### Outer Ring Enhancements
- **Independent Chamfers**: Separate control for top and bottom edge chamfers
- Enhanced visual consistency

#### Hardware Integration
- **Configurable Hex Hardware Recesses**
  - Optional hex nut recess on clamping bracket
  - Bolt clearance holes with proper sizing
  - Countersink recesses for bolt heads
  - Ready for future imperial/metric hardware presets
  - Can be completely disabled for alternative fastening methods

#### Rendering Options
- **Selective Part Generation**: Render only what you need
  - All parts together
  - Inner ring only
  - Outer ring only
  - Knob only
  - Assembly view
- **Exploded Assembly View**: Adjustable separation for visualization

---

## How to Use

### Basic Steps

1. **Open in OpenSCAD** (version 2021.01 or newer recommended)
2. **Open the Customizer** (Window → Customizer or F3)
3. **Adjust parameters** in the organized sections
4. **Preview** your design (F5)
5. **Render** when satisfied (F6)
6. **Export** STL files for printing

### Parameter Guide

#### What to Generate
- Choose which parts to render
- Use "assembly" to see how parts fit together
- Use "explode distance" to separate parts for clarity

#### Basic Dimensions
- **Hoop Diameter**: Inner diameter in inches (actual fabric area)
- **Ring Height**: Thickness of both rings
- **Wall Thickness**: How thick the hoop material is

#### Inner Ring Configuration
- **Solid Puck**: Creates a flat disc instead of a hollow ring
  - Use for maximum rigidity
  - Great for very small hoops
  - Still works with retention groove
- **Chamfers**: Round the top and bottom edges independently
  - Reduces sharp corners
  - Improves handling comfort
  - Helps with print quality

#### Retention Groove
- **Purpose**: Holds rubber band or string to secure fabric edges
- **Offset from Top**: Where groove sits vertically
  - Automatically adjusted if too close to edges
  - Console will warn if adjusted
- **Profile Shape**:
  - **Elliptical**: Smooth, rounded groove (recommended)
  - **Rectangular**: Sharp-edged groove
- **Height**: Vertical size of groove
- **Depth**: How far groove cuts into ring wall

#### Outer Ring Gap Settings
- **Gap Closed**: Minimum clearance when clamped (typically 0.2-0.5mm)
- **Gap Open Additional**: How much wider when loose

#### Hardware Recesses
- **Enable/Disable**: Toggle hex hardware features
- **Nut Height**: Thickness of hex nut (M5 = 4mm, 1/4" = 5mm)
- **Nut Width**: Distance across flats (M5 = 8mm, 1/4" = 7mm)
- **Bolt Diameter**: Through-hole size (M5 = 5mm, 1/4" = 6.35mm)
- **Countersink**: Clearance for bolt head

---

## Printing Recommendations

### Settings
- **Layer Height**: 0.2mm (standard) or 0.15mm (fine detail)
- **Infill**: 20-30% (inner/outer rings), 50%+ (knob)
- **Perimeters**: 3-4 for strength
- **Support**: Not needed for any parts

### Print Orientation
- **Inner Ring**: Flat on bed (bottom down)
- **Outer Ring**: Flat on bed (bottom down)
- **Knob**: Flat on bed (grip ridges up)

### Material Recommendations
- **PLA**: Good rigidity, easy to print
- **PETG**: More flexible, better for fabric tension
- **TPU**: Experimental - soft grip, but may be too flexible

---

## Common Use Cases

### Standard Embroidery Hoop
```
- Solid Puck: false
- Add Retention Groove: false
- Add Hex Hardware: true
```

### Hoop with Fabric Edge Retention
```
- Solid Puck: false
- Add Retention Groove: true
- Groove Profile: elliptical
- Groove Height: 2mm
- Groove Depth: 1mm
```

### Solid Stretching Frame (for canvas)
```
- Solid Puck: true
- Add Retention Groove: false
- Ring Height: 15-20mm (increased rigidity)
```

### Prototype/Test Print (fast)
```
- Hoop Diameter: 3-4 inches
- $fn: 50 (in code, for speed)
```

---

## Safety Checks and Warnings

The design includes automatic validation:

### Groove Safety
- Minimum 3mm from top edge
- Minimum 3mm from bottom edge
- Auto-adjusts parameters if too close
- Console warnings explain adjustments

### Example Console Output
```
═══════════════════════════════════════════════════
EMBROIDERY HOOP - Parameter Validation
═══════════════════════════════════════════════════
Hoop Diameter: 177.8mm (7 inches)
Ring Height: 13mm
Wall Thickness: 5mm
───────────────────────────────────────────────────
GROOVE PARAMETERS:
⚠ WARNING: Groove offset adjusted from 2mm to 4mm 
to maintain 3mm clearance from edges
✓ Groove height: 2mm
✓ Groove depth: 1mm
✓ Groove profile: elliptical
───────────────────────────────────────────────────
✓ Inner ring: HOLLOW HOOP mode
═══════════════════════════════════════════════════
```

---

## Future Enhancements (Roadmap)

- [ ] Hardware size presets dropdown (M3, M4, M5, #6-32, 1/4"-20, etc.)
- [ ] Pre-defined hoop size templates
- [ ] Multiple groove configurations
- [ ] Alternative clamping mechanisms
- [ ] Magnetic closure option
- [ ] Decorative patterns on outer ring

---

## Troubleshooting

### OpenSCAD Customizer Not Showing Parameters
- **Solution**: Make sure you're using OpenSCAD 2021.01 or newer
- Ensure Customizer window is open (Window → Customizer)

### Groove Appears in Wrong Location
- **Check**: Console output for automatic adjustments
- **Fix**: Increase ring height or reduce groove height

### Parts Don't Fit Together
- **Check**: Gap settings may be too tight
- **Fix**: Increase "gap_closed" to 0.4-0.5mm
- Test print tolerance with small sample

### Hex Nut Won't Fit
- **Check**: Measure your actual nut dimensions
- **Fix**: Adjust hex_nut_width (add 0.2-0.4mm tolerance)

---

## Contributing

This is an open-source derivative under CC BY 4.0. Feel free to:
- Fork and modify
- Submit improvements
- Share your makes
- Provide feedback

**Please maintain attribution chain:**
1. Original: Braden Sunwold (https://www.printables.com/model/505535-parametric-embroidery-hoop)
2. This derivative: One-Hoopy-Frood (https://github.com/One-Hoopy-Frood/OpenSCAD-Embroidery-Hoop-Generator-parametric-)
3. Your derivative: [Next person]

---

## Version History

### Version 2.0 (This Version)
- Complete rewrite with organized parameters
- Added solid puck mode
- Added retention groove with safety checks
- Independent chamfer controls
- Configurable hex hardware recesses
- Comprehensive console feedback
- Improved documentation

### Version 1.0 (Original)
- Basic parametric hoop design
- Fixed dimensions
- Original by Braden Sunwold

---

## License

This work is licensed under Creative Commons Attribution 4.0 International (CC BY 4.0).

You are free to:
- **Share** — copy and redistribute in any medium or format
- **Adapt** — remix, transform, and build upon the material for any purpose

Under the following terms:
- **Attribution** — You must give appropriate credit, provide a link to the license, and indicate if changes were made

Full license: https://creativecommons.org/licenses/by/4.0/

---

## Questions or Issues?

For questions about this derivative:
- GitHub Issues: https://github.com/One-Hoopy-Frood/OpenSCAD-Embroidery-Hoop-Generator-parametric-/issues
- GitHub Repository: https://github.com/One-Hoopy-Frood/OpenSCAD-Embroidery-Hoop-Generator-parametric-

For questions about the original design:
- Visit: https://www.printables.com/model/505535-parametric-embroidery-hoop
