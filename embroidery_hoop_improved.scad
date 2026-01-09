/*==============================================================================
  PARAMETRIC EMBROIDERY HOOP
  
  Original Design by: Braden Sunwold
  Original Model: https://www.printables.com/model/505535-parametric-embroidery-hoop
  
  Modified and Enhanced by: One-Hoopy-Frood
  Repository: https://github.com/One-Hoopy-Frood/OpenSCAD-Embroidery-Hoop-Generator-parametric-
  
  Licensed under: Creative Commons Attribution 4.0 International (CC BY 4.0)
  https://creativecommons.org/licenses/by/4.0/
  
  Description:
  Fully parametric embroidery hoop system consisting of:
  - Inner Ring (tension ring) - can be solid puck or hollow hoop
  - Outer Ring (clamp ring) - adjustable tension hoop with gap
  - Tightening Knob - with hex bolt and nut recesses
  
  This derivative adds:
  - Optional solid inner ring (puck mode)
  - Rounded top corners - bottom stays square for support-free printing
  - Anti-slip grip texture OR retention groove (mutually exclusive)
  - Support-free groove profile with 45° walls
  - Standard hardware size presets (M6, 1/4")
  - Fabric thickness presets for easy gap configuration
  
  Version: 14
  
==============================================================================*/

/* [Hidden] */
// Rendering quality
$fn = 100;
// Corner rounding radius when enabled (mm)
corner_radius = 0.8;
// Rendering colors
color_inner_ring = "Gold";
color_outer_ring = "CornflowerBlue";
color_knob = "LightSteelBlue";
color_ghost_knob_alpha = 0.3;
color_preview_text = "Red";
color_preview_text_alpha = 0.6;
// Fixed internal dimensions
hex_recess_material_remaining = 6;
grip_bump_size = 1;
groove_edge_clearance = 3;

/* [Part Selection] */
// Which part(s) to generate
Part_to_Render = "all"; // [all:All Parts, inner:Inner Ring Only, outer:Outer Ring Only, knob:Knob Only, assembly:Assembly View]

/* [Inner Ring - PRIMARY DIMENSION] */
// *** THIS SETS THE WORKING HOOP SIZE - Outer ring auto-sizes to fit ***
Inner_Ring_Diameter_mm = 178;
// Height of inner ring (mm)
Inner_Ring_Height_mm = 13;
// Wall thickness of inner ring (mm)
Inner_Ring_Wall_mm = 5;
// Solid disc instead of hollow ring
Inner_Ring_Solid_Puck = false;
// Rounded top corners
Inner_Ring_Rounded_Corners = true;

/* [Inner Ring - Grip Texture] */
// Add grip dots (disabled if groove enabled)
Inner_Ring_Grip_Dots = true;
// Grip dot density
Inner_Ring_Grip_Density = 2; // [1:Low, 2:Medium, 3:High]

/* [Inner Ring - Retention Groove] */
// Add groove for rubber band (disables grip dots)
Inner_Ring_Groove = false;
// Groove distance from top (mm)
Inner_Ring_Groove_Offset_mm = 6;
// Groove width (mm)
Inner_Ring_Groove_Width_mm = 2;
// Groove depth (mm)
Inner_Ring_Groove_Depth_mm = 1;

/* [Outer Ring - Auto-sized from Inner Ring] */
// Fabric thickness preset
Outer_Ring_Fabric_Type = 2; // [0:Silk/Organza, 1:Cotton/Linen, 2:T-shirt/Quilting, 3:Canvas/Twill, 4:Denim/Upholstery]
// Extra gap when loosened (mm)
Outer_Ring_Extra_Gap_mm = 1;
// Rounded top corners (includes clamp brackets)
Outer_Ring_Rounded_Corners = true;

/* [Clamp Hardware] */
// Bolt and nut size
Clamp_Hardware_Size = "M6"; // [M6:M6 Metric, quarter_inch:1/4 inch Imperial]
// Bracket width (mm)
Clamp_Bracket_Width_mm = 11;

/* [Tightening Knob] */
// Knob diameter (mm)
Knob_Diameter_mm = 13;
// Knob height (mm)
Knob_Height_mm = 20;

/* [Assembly View] */
// Explode distance (mm)
Assembly_Explode_mm = 0;

//==============================================================================
// INTERNAL PARAMETER MAPPING
//==============================================================================

// Part selection
part_to_render = Part_to_Render;

// Inner ring dimensions
hoop_diameter = Inner_Ring_Diameter_mm;
ring_height = Inner_Ring_Height_mm;
ring_wall_thickness = Inner_Ring_Wall_mm;
inner_ring_solid_puck = Inner_Ring_Solid_Puck;
inner_ring_rounded = Inner_Ring_Rounded_Corners;

// Grip texture - DISABLED if groove is enabled
add_grip_texture = Inner_Ring_Grip_Dots && !Inner_Ring_Groove;
grip_texture_density = Inner_Ring_Grip_Density;

// Retention groove
add_retention_groove = Inner_Ring_Groove;
groove_offset_from_top = Inner_Ring_Groove_Offset_mm;
groove_height = Inner_Ring_Groove_Width_mm;
groove_depth = Inner_Ring_Groove_Depth_mm;

// Outer ring
fabric_type = Outer_Ring_Fabric_Type;
gap_open_additional = Outer_Ring_Extra_Gap_mm;
outer_ring_rounded = Outer_Ring_Rounded_Corners;

// Hardware
hardware_size = Clamp_Hardware_Size;
bracket_width_mm = Clamp_Bracket_Width_mm;

// Knob
knob_diameter = Knob_Diameter_mm;
knob_height = Knob_Height_mm;

// Assembly
assembly_explode_distance = Assembly_Explode_mm;

// Edge radius (applied when rounded corners enabled)
inner_ring_edge_radius = inner_ring_rounded ? corner_radius : 0;
outer_ring_edge_radius = outer_ring_rounded ? corner_radius : 0;

//==============================================================================
// HARDWARE SPECIFICATIONS
//==============================================================================

bolt_hole_diameter = hardware_size == "M6" ? 6.5 : 6.85;
hex_nut_width = hardware_size == "M6" ? 10 : 11.1;
hex_nut_height = hardware_size == "M6" ? 5 : 5.5;

//==============================================================================
// FABRIC GAP LOOKUP
//==============================================================================

fabric_gap_values = [0.2, 0.3, 0.4, 0.6, 0.8];
fabric_gap_names = ["Silk/Organza", "Cotton/Linen", "T-shirt/Quilting", "Canvas/Twill", "Denim/Upholstery"];
gap_closed = fabric_gap_values[fabric_type];

//==============================================================================
// CALCULATED CONSTANTS
//==============================================================================

// Outer ring diameter calculations - DERIVED FROM INNER RING
closed_diameter = hoop_diameter + (gap_closed * 2);
open_diameter = closed_diameter + (gap_open_additional * 2);
open_circumference = open_diameter * PI;
closed_circumference = closed_diameter * PI;
gap_angle = 360 * (open_circumference - closed_circumference) / closed_circumference;
gap_chord = open_circumference * gap_angle / 360;

// Bracket dimensions
bracket_width = ring_wall_thickness + ring_height;
bracket_thickness = bracket_width_mm;

// Hex recess depth (punches through outer surface by 1mm)
hex_recess_depth = bracket_thickness - hex_recess_material_remaining + 1;

// Grip texture
grip_spacing = grip_texture_density == 1 ? 4 : (grip_texture_density == 2 ? 3 : 2);
grip_surface_diameter = hoop_diameter;

// Groove safety limits
function validate_groove_offset(offset, height, ring_h) = 
    max(groove_edge_clearance + height/2, 
        min(offset, ring_h - groove_edge_clearance - height/2));

function validate_groove_height(height, ring_h) =
    min(height, ring_h - (2 * groove_edge_clearance));

safe_groove_offset = validate_groove_offset(groove_offset_from_top, groove_height, ring_height);
safe_groove_height = validate_groove_height(groove_height, ring_height);

// 45-degree groove calculations
groove_actual_top_width = safe_groove_height;
groove_actual_bottom_width = max(0, safe_groove_height - groove_depth * 2);

// Warning flags
groove_offset_adjusted = abs(safe_groove_offset - groove_offset_from_top) > 0.01;
bracket_too_thin = bracket_thickness < (hex_recess_material_remaining + hex_nut_height);

// Knob collision detection
knob_center_x = open_diameter/2 + ring_wall_thickness/2 + ring_wall_thickness/2 + bracket_width/2;
outer_ring_outer_radius = (open_diameter + ring_wall_thickness * 2) / 2;
knob_collides = (knob_center_x - knob_diameter/2) < outer_ring_outer_radius;

// Calculated outer ring diameter for display
outer_ring_diameter = open_diameter + ring_wall_thickness * 2;

//==============================================================================
// CONSOLE OUTPUT
//==============================================================================

echo("═══════════════════════════════════════════════════");
echo("EMBROIDERY HOOP v14 - Parameter Summary");
echo("═══════════════════════════════════════════════════");
echo("");
echo("*** INNER RING (Primary - sets hoop working size) ***");
echo(str("  Diameter: ", hoop_diameter, "mm"));
echo(str("  Height: ", ring_height, "mm"));
echo(str("  Wall: ", ring_wall_thickness, "mm"));
echo(str("  Mode: ", inner_ring_solid_puck ? "SOLID PUCK" : "HOLLOW HOOP"));
echo(str("  Corners: ", inner_ring_rounded ? "Rounded" : "Square"));

echo("");
echo("*** OUTER RING (Auto-calculated from inner ring) ***");
echo(str("  Outer Diameter: ", outer_ring_diameter, "mm (auto)"));
echo(str("  Fabric: ", fabric_gap_names[fabric_type], " (", gap_closed, "mm gap)"));
echo(str("  Corners: ", outer_ring_rounded ? "Rounded" : "Square"));

if (add_retention_groove) {
    echo("");
    echo("*** RETENTION GROOVE (grip dots disabled) ***");
    echo(str("  Offset: ", safe_groove_offset, "mm from top"));
    echo(str("  Size: ", safe_groove_height, "mm wide x ", groove_depth, "mm deep"));
    echo("  Profile: 45° walls (support-free)");
    if (groove_actual_bottom_width <= 0) {
        echo("  Shape: V-groove");
    } else {
        echo(str("  Shape: Trapezoid (", groove_actual_bottom_width, "mm flat bottom)"));
    }
    if (groove_offset_adjusted) {
        echo(str("  ⚠ Offset adjusted from ", groove_offset_from_top, "mm for clearance"));
    }
} else if (add_grip_texture) {
    echo("");
    echo(str("*** GRIP DOTS: ", 
             grip_texture_density == 1 ? "Low" : (grip_texture_density == 2 ? "Medium" : "High"),
             " density ***"));
}

echo("");
echo(str("*** HARDWARE: ", hardware_size == "M6" ? "M6 Metric" : "1/4\" Imperial", " ***"));
echo(str("  Bolt hole: ", bolt_hole_diameter, "mm"));
echo(str("  Hex nut: ", hex_nut_width, "mm"));

if (bracket_too_thin) {
    echo("  ⚠ Bracket may be too thin for hex recess");
}

if (knob_collides) {
    echo("");
    echo(str("⚠ WARNING: Knob (", knob_diameter, "mm) may collide with outer ring"));
}

echo("");
echo("✓ Bottom edges square for support-free 3D printing");
echo("═══════════════════════════════════════════════════");

//==============================================================================
// MODULE: ROUNDED CYLINDER
//==============================================================================

module rounded_cylinder(diameter, height, edge_radius=0) {
    if (edge_radius <= 0) {
        cylinder(d = diameter, h = height);
    } else {
        safe_radius = min(edge_radius, diameter/4, height/2);
        
        rotate_extrude(convexity=10) {
            difference() {
                square([diameter/2, height]);
                
                translate([diameter/2 - safe_radius, height - safe_radius])
                    difference() {
                        square([safe_radius + 0.01, safe_radius + 0.01]);
                        circle(r = safe_radius, $fn = 32);
                    }
            }
        }
    }
}

//==============================================================================
// MODULE: ROUNDED CUBE (top edges only, bottom stays square for printing)
// Rounds the top 4 vertical edges, keeps bottom flat
//==============================================================================

module rounded_cube_top(size, radius) {
    // size = [x, y, z], radius = corner radius
    x = size[0];
    y = size[1];
    z = size[2];
    r = min(radius, x/2, y/2, z/2);
    
    if (r <= 0) {
        cube(size);
    } else {
        hull() {
            // Bottom corners - square (no rounding for print bed)
            translate([0, 0, 0]) cube([x, y, 0.01]);
            
            // Top corners - rounded vertical edges
            translate([r, r, z - r])
                sphere(r = r, $fn = 16);
            translate([x - r, r, z - r])
                sphere(r = r, $fn = 16);
            translate([r, y - r, z - r])
                sphere(r = r, $fn = 16);
            translate([x - r, y - r, z - r])
                sphere(r = r, $fn = 16);
            
            // Vertical edges connecting bottom to top spheres
            translate([r, r, 0]) cylinder(r = r, h = z - r, $fn = 16);
            translate([x - r, r, 0]) cylinder(r = r, h = z - r, $fn = 16);
            translate([r, y - r, 0]) cylinder(r = r, h = z - r, $fn = 16);
            translate([x - r, y - r, 0]) cylinder(r = r, h = z - r, $fn = 16);
        }
    }
}

//==============================================================================
// MODULE: GRIP TEXTURE
//==============================================================================

module grip_texture(diameter, height) {
    bump_count = floor(diameter * PI / grip_spacing);
    
    for (angle = [0:360/bump_count:360]) {
        rotate([0, 0, angle])
            translate([diameter/2, 0, 0])
            for (z = [grip_spacing:grip_spacing:height - grip_spacing]) {
                translate([0, 0, z])
                    sphere(d = grip_bump_size, $fn = 16);
            }
    }
}

//==============================================================================
// MODULE: RETENTION GROOVE (45° walls for support-free printing)
//==============================================================================

module retention_groove(diameter, groove_z, depth, height) {
    top_half_width = height / 2;
    bottom_half_width = max(0, (height - depth * 2) / 2);
    
    rotate_extrude(convexity=10) {
        translate([diameter/2 - depth, groove_z, 0]) {
            if (bottom_half_width > 0) {
                // Trapezoid shape
                polygon(points=[
                    [0, -bottom_half_width],
                    [0, bottom_half_width],
                    [depth + 0.1, top_half_width],
                    [depth + 0.1, -top_half_width]
                ]);
            } else {
                // V-groove (triangle)
                polygon(points=[
                    [0, 0],
                    [depth + 0.1, top_half_width],
                    [depth + 0.1, -top_half_width]
                ]);
            }
        }
    }
}

//==============================================================================
// MODULE: INNER RING
//==============================================================================

module inner_ring() {
    union() {
        difference() {
            if (inner_ring_solid_puck) {
                rounded_cylinder(
                    diameter = hoop_diameter,
                    height = ring_height,
                    edge_radius = inner_ring_edge_radius
                );
            } else {
                difference() {
                    rounded_cylinder(
                        diameter = hoop_diameter,
                        height = ring_height,
                        edge_radius = inner_ring_edge_radius
                    );
                    translate([0, 0, -1])
                        cylinder(d = hoop_diameter - ring_wall_thickness * 2, h = ring_height + 2);
                }
            }
            
            if (add_retention_groove) {
                groove_z = ring_height - safe_groove_offset;
                retention_groove(
                    diameter = hoop_diameter,
                    groove_z = groove_z,
                    depth = groove_depth,
                    height = safe_groove_height
                );
            }
        }
        
        if (add_grip_texture) {
            grip_texture(grip_surface_diameter, ring_height);
        }
    }
}

//==============================================================================
// MODULE: OUTER RING
//==============================================================================

module outer_ring() {
    union() {
        difference() {
            rounded_cylinder(
                diameter = open_diameter + ring_wall_thickness * 2,
                height = ring_height,
                edge_radius = outer_ring_edge_radius
            );
            
            translate([0, 0, -1])
                cylinder(d = open_diameter, h = ring_height + 2);
            
            translate([open_diameter/2, 0, 0])
                cube([ring_wall_thickness * 4, gap_chord, ring_height * 4], center = true);
        }
        
        translate([open_diameter/2 + ring_wall_thickness/2, gap_chord/2, 0])
            clamping_bracket(has_hex_recess = false);
        
        translate([open_diameter/2 + ring_wall_thickness/2, -gap_chord/2, 0])
            mirror([0, 1, 0])
            clamping_bracket(has_hex_recess = true);
    }
}

//==============================================================================
// MODULE: CLAMPING BRACKET
// When outer_ring_rounded is true, top edges are rounded
// Bottom always stays square for 3D printing
//==============================================================================

module clamping_bracket(has_hex_recess = false) {
    bracket_size = [ring_wall_thickness + bracket_width, bracket_thickness, ring_height];
    
    difference() {
        // Bracket body - rounded or square based on outer ring setting
        if (outer_ring_rounded) {
            rounded_cube_top(bracket_size, corner_radius);
        } else {
            cube(bracket_size);
        }
        
        // Bolt through-hole
        translate([ring_wall_thickness/2 + bracket_width/2, -1, ring_height/2])
            rotate([270, 0, 0])
            cylinder(h = bracket_thickness + 2, d = bolt_hole_diameter);
        
        // Hex recess (left bracket only)
        if (has_hex_recess) {
            translate([ring_wall_thickness/2 + bracket_width/2, 
                      bracket_thickness - hex_recess_depth + 1,
                      ring_height/2])
                rotate([270, 0, 0])
                cylinder(h = hex_recess_depth, d = hex_nut_width, $fn = 6);
        }
    }
}

//==============================================================================
// MODULE: TIGHTENING KNOB
//==============================================================================

module tightening_knob() {
    difference() {
        union() {
            cylinder(h = knob_height, d = knob_diameter);
            
            ridge_count = floor(knob_diameter * PI / 4);
            for(angle = [0:360/ridge_count:360]) {
                rotate([0, 0, angle])
                    translate([knob_diameter/2, 0, 0])
                    hull() {
                        translate([0, 0, 2])
                            sphere(d = 2);
                        translate([0, 0, knob_height - 2])
                            sphere(d = 2);
                    }
            }
        }
        
        translate([0, 0, -1])
            cylinder(h = knob_height + 2, d = bolt_hole_diameter);
        
        translate([0, 0, knob_height - hex_nut_height])
            cylinder(h = hex_nut_height + 1, d = hex_nut_width, $fn = 6);
    }
}

//==============================================================================
// MAIN RENDERING
//==============================================================================

if (part_to_render == "all") {
    color(color_inner_ring)
        inner_ring();
    
    color(color_outer_ring)
        outer_ring();
    
    color(color_knob)
        tightening_knob();
}

if (part_to_render == "assembly") {
    color(color_inner_ring)
        translate([0, 0, -assembly_explode_distance])
        inner_ring();
    
    color(color_outer_ring)
        outer_ring();
    
    // Ghost knob in assembly view
    bolt_hole_x = open_diameter/2 + ring_wall_thickness + bracket_width/2;
    bolt_hole_z = ring_height/2;
    knob_base_y = gap_chord/2 + bracket_thickness;
    
    color(color_knob, alpha = color_ghost_knob_alpha)
        translate([bolt_hole_x, knob_base_y, bolt_hole_z])
        rotate([270, 0, 0])
        tightening_knob();
    
    color(color_preview_text, alpha = color_preview_text_alpha)
        translate([bolt_hole_x, knob_base_y + knob_height/2, bolt_hole_z + knob_diameter/2 + 3])
        rotate([90, 0, 90])
        linear_extrude(0.5)
        text("PREVIEW ONLY", size = 3, halign = "center", valign = "center");
}

if (part_to_render == "inner") {
    color(color_inner_ring)
        inner_ring();
}

if (part_to_render == "outer") {
    color(color_outer_ring)
        outer_ring();
}

if (part_to_render == "knob") {
    color(color_knob)
        tightening_knob();
}

//==============================================================================
// END OF FILE
//==============================================================================
