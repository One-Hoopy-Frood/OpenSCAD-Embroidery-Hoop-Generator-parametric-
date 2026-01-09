# Embroidery Hoop Quick Reference Guide

## 🎯 Common Configurations

### Standard Embroidery Hoop
Perfect for traditional hand embroidery work.
```
part_to_render = "all"
hoop_diameter_inches = 7
ring_height = 13
inner_ring_solid_puck = false
add_retention_groove = false
add_hex_hardware_recesses = true
```

### Hoop with Fabric Retention
Includes groove for elastic/rubber band to secure fabric edges.
```
inner_ring_solid_puck = false
add_retention_groove = true
groove_offset_from_top = 6.5
groove_profile = "elliptical"
groove_height = 2
groove_depth = 1
```

### Solid Canvas Stretcher
Rigid frame for canvas or heavy fabric.
```
inner_ring_solid_puck = true
ring_height = 15-20
ring_wall_thickness = 5-7
add_retention_groove = false
```

### Miniature/Test Hoop
Quick print for testing or small projects.
```
hoop_diameter_inches = 3
ring_height = 10
$fn = 50  (edit in code for faster rendering)
```

## 📏 Dimensional Reference

### Common Hoop Sizes
| Diameter | Use Case |
|----------|----------|
| 3-4" | Ornaments, patches, small details |
| 5-6" | Standard projects, portability |
| 7-8" | Large embroidery, quilting |
| 9-12" | Professional work, large designs |

### Hardware Sizes
| Type | Bolt Ø | Nut Width | Nut Height |
|------|--------|-----------|------------|
| M3 | 3mm | 5.5mm | 2.4mm |
| M4 | 4mm | 7mm | 3.2mm |
| M5 | 5mm | 8mm | 4mm |
| M6 | 6mm | 10mm | 5mm |
| #6-32 | 3.5mm | 5.5mm | 3mm |
| 1/4"-20 | 6.35mm | 11mm | 5mm |

### Print Tolerance Guidelines
- **Tight Fit**: gap_closed = 0.2mm
- **Normal**: gap_closed = 0.3-0.4mm
- **Loose**: gap_closed = 0.5-0.6mm

## ⚙️ Parameter Interactions

### Groove Constraints
```
Safe Zone = Ring Height - (2 × 3mm clearance)

Min Offset = 3mm + (groove_height / 2)
Max Offset = ring_height - 3mm - (groove_height / 2)

Example with 13mm ring height, 2mm groove:
  Safe Zone = 13mm - 6mm = 7mm available
  Min Offset = 4mm
  Max Offset = 9mm
```

### Chamfer Guidelines
- **Subtle**: 0.3-0.5mm (barely visible, improves print)
- **Moderate**: 0.8-1.2mm (noticeable, comfortable)
- **Heavy**: 1.5-2.5mm (decorative, very rounded)
- **Maximum**: 3mm (limited by geometry)

## 🖨️ Print Settings Quick Ref

### Layer Heights
- **Draft**: 0.28mm (fast test prints)
- **Standard**: 0.2mm (good balance)
- **Fine**: 0.12-0.15mm (best surface)

### Infill Recommendations
| Part | Infill | Reason |
|------|--------|--------|
| Inner Ring | 20-30% | Keeps weight down |
| Outer Ring | 20-30% | Balance of strength/speed |
| Knob | 50-100% | Needs strength for torque |

### Print Times (Approximate)
7" hoop at 0.2mm, 30% infill:
- Inner Ring: ~2-3 hours
- Outer Ring: ~3-4 hours
- Knob: ~1 hour
- **Total**: ~6-8 hours

## 🔧 Troubleshooting Checklist

### Inner Ring Too Loose
- [ ] Decrease `gap_closed` by 0.1mm
- [ ] Verify printer calibration
- [ ] Check filament shrinkage

### Outer Ring Too Tight
- [ ] Increase `gap_closed` by 0.1mm
- [ ] Reduce `ring_wall_thickness` slightly
- [ ] Sand inner surface lightly

### Groove Not Deep Enough
- [ ] Increase `groove_depth` by 0.2-0.5mm
- [ ] Check console for auto-adjustments
- [ ] Verify groove isn't being truncated

### Hex Nut Won't Fit
- [ ] Measure actual nut dimensions
- [ ] Add 0.3-0.5mm to `hex_nut_width`
- [ ] Check `hex_nut_height` matches your hardware

### Bolt Hole Too Tight
- [ ] Increase `bolt_hole_diameter` by 0.2-0.5mm
- [ ] Try different bolt (some variation exists)
- [ ] Drill/ream hole after printing

## 💡 Pro Tips

1. **First Print**: Start with 3-4" diameter to test fit and settings
2. **Smooth Operation**: Add chamfers (0.5mm) to all edges
3. **Better Grip**: Increase groove depth to 1.5mm for thick elastic
4. **Heavy Fabric**: Use solid puck mode with 18-20mm height
5. **Print Orientation**: Always print flat (largest face down)
6. **Post-Processing**: Light sanding on friction surfaces
7. **Assembly**: Test fit before installing hardware
8. **Storage**: Hang assembled hoops to prevent warping

## 📊 Parameter Limits

```
Hoop Diameter: 3" - 12" (76mm - 305mm)
Ring Height: 8mm - 25mm
Wall Thickness: 3mm - 10mm
Groove Height: 0.5mm - 5mm
Groove Depth: 0.3mm - 3mm
Chamfer Sizes: 0mm - 3mm
```

## 🚀 Optimization for Speed

Quick prints (sacrifice some quality):
```
$fn = 50  (instead of 100)
ring_height = 10
wall_thickness = 4
infill = 15%
layer_height = 0.28mm
```

Quality prints (slower but better):
```
$fn = 150  (or even 200)
layer_height = 0.12mm
infill = 30%+
4+ perimeters
```

---

**Remember**: When in doubt, check the console output in OpenSCAD for automatic adjustment warnings and validation messages!

**Repository**: https://github.com/One-Hoopy-Frood/OpenSCAD-Embroidery-Hoop-Generator-parametric-

Last Updated: January 2026
