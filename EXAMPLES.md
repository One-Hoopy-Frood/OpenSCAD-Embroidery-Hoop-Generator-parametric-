# Example Configurations

Copy and paste these parameter sets into OpenSCAD's Customizer for quick setup.

## Standard 7" Embroidery Hoop
```
part_to_render = "all"
hoop_diameter_inches = 7
ring_height = 13
ring_wall_thickness = 5
inner_ring_solid_puck = false
inner_ring_top_chamfer = 0.5
inner_ring_bottom_chamfer = 0.5
outer_ring_top_chamfer = 0.5
outer_ring_bottom_chamfer = 0.5
add_retention_groove = false
add_hex_hardware_recesses = true
gap_closed = 0.3
gap_open_additional = 1
hex_nut_height = 3.5
hex_nut_width = 8
bolt_hole_diameter = 5
```

## Hoop with Fabric Retention (5")
```
hoop_diameter_inches = 5
ring_height = 13
inner_ring_solid_puck = false
add_retention_groove = true
groove_offset_from_top = 6.5
groove_profile = "elliptical"
groove_height = 2
groove_depth = 1
add_hex_hardware_recesses = true
```

## Solid Canvas Stretcher Frame (8")
```
hoop_diameter_inches = 8
ring_height = 18
ring_wall_thickness = 6
inner_ring_solid_puck = true
inner_ring_top_chamfer = 1
inner_ring_bottom_chamfer = 1
outer_ring_top_chamfer = 1
outer_ring_bottom_chamfer = 1
add_retention_groove = false
add_hex_hardware_recesses = true
```

## Miniature Hoop (3")
```
hoop_diameter_inches = 3
ring_height = 10
ring_wall_thickness = 4
inner_ring_solid_puck = false
add_retention_groove = false
add_hex_hardware_recesses = true
gap_closed = 0.25
hex_nut_height = 2.4
hex_nut_width = 5.5
bolt_hole_diameter = 3
```

## Heavy Duty Quilting Hoop (10")
```
hoop_diameter_inches = 10
ring_height = 20
ring_wall_thickness = 7
inner_ring_solid_puck = false
inner_ring_top_chamfer = 1.5
inner_ring_bottom_chamfer = 1.5
outer_ring_top_chamfer = 1.5
outer_ring_bottom_chamfer = 1.5
add_retention_groove = true
groove_profile = "elliptical"
groove_height = 3
groove_depth = 1.5
add_hex_hardware_recesses = true
hex_nut_height = 5
hex_nut_width = 10
bolt_hole_diameter = 6
```

## Portable 4" with Retention
```
hoop_diameter_inches = 4
ring_height = 11
ring_wall_thickness = 4
inner_ring_solid_puck = false
add_retention_groove = true
groove_offset_from_top = 5.5
groove_profile = "rectangular"
groove_height = 1.5
groove_depth = 0.8
add_hex_hardware_recesses = true
```

## Test Print (Fast)
```
hoop_diameter_inches = 3
ring_height = 8
ring_wall_thickness = 3
$fn = 50  # Add this directly in code, not Customizer
```

---

**Hardware Sizing Notes:**

M3 Hardware (Miniature/Delicate):
- hex_nut_height = 2.4
- hex_nut_width = 5.5
- bolt_hole_diameter = 3

M4 Hardware (Small):
- hex_nut_height = 3.2
- hex_nut_width = 7
- bolt_hole_diameter = 4

M5 Hardware (Standard):
- hex_nut_height = 3.5-4
- hex_nut_width = 8
- bolt_hole_diameter = 5

M6 Hardware (Heavy Duty):
- hex_nut_height = 5
- hex_nut_width = 10
- bolt_hole_diameter = 6

#6-32 Hardware (Imperial Small):
- hex_nut_height = 3
- hex_nut_width = 5.5
- bolt_hole_diameter = 3.5

1/4"-20 Hardware (Imperial Standard):
- hex_nut_height = 5
- hex_nut_width = 11
- bolt_hole_diameter = 6.35
