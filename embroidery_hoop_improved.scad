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
  - Independent edge chamfers
  - Optional groove for rubber band/string retention
  - Configurable groove profiles (elliptical/rectangular)
  - Hex hardware recesses with future hardware size presets
  - Comprehensive parameter validation and safety checks
  
==============================================================================*/

// RENDERING QUALITY
$fn = 100; // [20:200] Circle smoothness (higher = smoother but slower)

/* [What to Generate] */
// Select which part(s) to render
part_to_render = "all"; // [all:All Parts, inner:Inner Ring Only, outer:Outer Ring Only, knob:Knob Only, assembly:Assembly View]

/* [Basic Dimensions] */
// Outer diameter of finished hoop (inner ring size)
hoop_diameter_inches = 7; // [3:0.5:12]
// Height of both inner and outer rings
ring_height = 13; // [8:1:25]
// Wall thickness of the hoop rings
ring_wall_thickness = 5; // [3:0.5:10]

/* [Inner Ring (Tension Ring) Configuration] */
// Make inner ring a solid disc instead of hollow ring
inner_ring_solid_puck = false;
// Chamfer size on top edge of inner ring
inner_ring_top_chamfer = 0.5; // [0:0.1:3]
// Chamfer size on bottom edge of inner ring
inner_ring_bottom_chamfer = 0.5; // [0:0.1:3]

/* [Outer Ring (Clamp Ring) Gap Settings] */
// Minimum gap between rings when clamped (clearance)
gap_closed = 0.3; // [0.1:0.05:1]
// Additional gap opening when unclamped
gap_open_additional = 1; // [0.5:0.1:3]

/* [Outer Ring (Clamp Ring) Appearance] */
// Chamfer size on top edge of outer ring
outer_ring_top_chamfer = 0.5; // [0:0.1:3]
// Chamfer size on bottom edge of outer ring
outer_ring_bottom_chamfer = 0.5; // [0:0.1:3]

/* [Retention Groove (For Rubber Band/String)] */
// Add groove around outer surface of inner ring
add_retention_groove = false;
// Distance from top of inner ring to groove center
groove_offset_from_top = 6.5; // [3:0.5:20]
// Cross-sectional profile shape of groove
groove_profile = "elliptical"; // [elliptical:Elliptical (Rounded), rectangular:Rectangular]
// Vertical height of groove
groove_height = 2; // [0.5:0.1:5]
// Depth of groove into ring wall
groove_depth = 1; // [0.3:0.1:3]

/* [Hardware Recesses] */
// Add hex nut and bolt recesses for clamping mechanism
add_hex_hardware_recesses = true;
// Hex nut height (standard M5 nut is 4mm, 1/4" nut is 5mm)
hex_nut_height = 3.5; // [2:0.5:8]
// Hex nut width across flats (M5 is 8mm, 1/4" is 7mm)
hex_nut_width = 8; // [5:0.5:15]
// Bolt clearance hole diameter (M5 is 5mm, 1/4" is 6.35mm)
bolt_hole_diameter = 5; // [3:0.1:10]
// Countersink depth for bolt head on knob side
bolt_countersink_depth = 4; // [2:0.5:8]
// Countersink diameter for bolt head
bolt_countersink_diameter = 7; // [5:0.5:12]

/* [Clamp Bracket Dimensions] */
// Width of clamping brackets
bracket_width_mm = 11; // [8:1:20]

/* [Advanced Settings] */
// Show assembly with parts separated for visualization
assembly_explode_distance = 0; // [0:5:50]

//==============================================================================
// CALCULATED CONSTANTS AND SAFETY LIMITS
//==============================================================================

// Convert inches to millimeters
hoop_diameter = hoop_diameter_inches * 25.4;

// Calculate circumferences and angles
inner_circumference = hoop_diameter * PI;
closed_diameter = hoop_diameter + (gap_closed * 2);
open_diameter = closed_diameter + (gap_open_additional * 2);
closed_circumference = closed_diameter * PI;
open_circumference = open_diameter * PI;
gap_angle = 360 * (open_circumference - closed_circumference) / closed_circumference;
gap_chord = open_circumference * gap_angle / 360;

// Clamping mechanism dimensions
bracket_width = ring_wall_thickness + ring_height;
bracket_thickness = bracket_width_mm;

// Minimum safe distance from groove to ring edges
groove_edge_clearance = 3; // Minimum 3mm from top or bottom

// Calculate safe groove parameters
function validate_groove_offset(offset, height, ring_h) = 
    max(groove_edge_clearance + height/2, 
        min(offset, ring_h - groove_edge_clearance - height/2));

function validate_groove_height(height, ring_h) =
    min(height, ring_h - (2 * groove_edge_clearance));

// Apply safety validations
safe_groove_offset = validate_groove_offset(
    groove_offset_from_top, 
    groove_height, 
    ring_height
);

safe_groove_height = validate_groove_height(groove_height, ring_height);

// Warning flags for user feedback
groove_offset_adjusted = abs(safe_groove_offset - groove_offset_from_top) > 0.01;
groove_height_adjusted = abs(safe_groove_height - groove_height) > 0.01;

//==============================================================================
// PARAMETER VALIDATION AND USER WARNINGS
//==============================================================================

echo("═══════════════════════════════════════════════════");
echo("EMBROIDERY HOOP - Parameter Validation");
echo("═══════════════════════════════════════════════════");
echo(str("Hoop Diameter: ", hoop_diameter, "mm (", hoop_diameter_inches, " inches)"));
echo(str("Ring Height: ", ring_height, "mm"));
echo(str("Wall Thickness: ", ring_wall_thickness, "mm"));

if (add_retention_groove) {
    echo("───────────────────────────────────────────────────");
    echo("GROOVE PARAMETERS:");
    if (groove_offset_adjusted) {
        echo(str("⚠ WARNING: Groove offset adjusted from ", 
                 groove_offset_from_top, "mm to ", 
                 safe_groove_offset, "mm to maintain ", 
                 groove_edge_clearance, "mm clearance from edges"));
    } else {
        echo(str("✓ Groove offset: ", safe_groove_offset, "mm from top"));
    }
    
    if (groove_height_adjusted) {
        echo(str("⚠ WARNING: Groove height reduced from ", 
                 groove_height, "mm to ", 
                 safe_groove_height, "mm to fit within ring"));
    } else {
        echo(str("✓ Groove height: ", safe_groove_height, "mm"));
    }
    
    echo(str("✓ Groove depth: ", groove_depth, "mm"));
    echo(str("✓ Groove profile: ", groove_profile));
}

if (inner_ring_solid_puck) {
    echo("───────────────────────────────────────────────────");
    echo("✓ Inner ring: SOLID PUCK mode");
} else {
    echo("───────────────────────────────────────────────────");
    echo("✓ Inner ring: HOLLOW HOOP mode");
}

echo("═══════════════════════════════════════════════════");

//==============================================================================
// MODULE: CHAMFERED CYLINDER
//==============================================================================

module chamfered_cylinder(diameter, height, top_chamfer=0, bottom_chamfer=0) {
    rotate_extrude(convexity=10) {
        polygon([
            // Bottom edge
            [0, 0],
            [diameter/2, 0],
            [diameter/2 - bottom_chamfer, bottom_chamfer],
            // Side wall
            [diameter/2 - bottom_chamfer, height - top_chamfer],
            // Top edge
            [diameter/2, height - top_chamfer],
            [diameter/2, height],
            [0, height]
        ]);
    }
}

//==============================================================================
// MODULE: INNER RING (TENSION RING)
//==============================================================================

module inner_ring() {
    difference() {
        // Base ring or solid puck
        if (inner_ring_solid_puck) {
            // Solid disc with chamfers
            chamfered_cylinder(
                diameter = hoop_diameter,
                height = ring_height,
                top_chamfer = inner_ring_top_chamfer,
                bottom_chamfer = inner_ring_bottom_chamfer
            );
        } else {
            // Hollow ring with chamfers
            difference() {
                chamfered_cylinder(
                    diameter = hoop_diameter,
                    height = ring_height,
                    top_chamfer = inner_ring_top_chamfer,
                    bottom_chamfer = inner_ring_bottom_chamfer
                );
                // Hollow out the center
                translate([0, 0, -1])
                    cylinder(d = hoop_diameter - ring_wall_thickness * 2, h = ring_height + 2);
            }
        }
        
        // Add retention groove if enabled
        if (add_retention_groove) {
            translate([0, 0, safe_groove_offset]) {
                if (groove_profile == "elliptical") {
                    // Elliptical groove profile
                    rotate_extrude(convexity=10)
                        translate([hoop_diameter/2 - groove_depth/2, 0, 0])
                        scale([groove_depth/safe_groove_height, 1, 1])
                        circle(d = safe_groove_height);
                } else {
                    // Rectangular groove profile
                    rotate_extrude(convexity=10)
                        translate([hoop_diameter/2 - groove_depth, -safe_groove_height/2, 0])
                        square([groove_depth, safe_groove_height]);
                }
            }
        }
    }
}

//==============================================================================
// MODULE: OUTER RING (CLAMP RING)
//==============================================================================

module outer_ring() {
    union() {
        // Main outer hoop with gap and chamfers
        difference() {
            chamfered_cylinder(
                diameter = open_diameter + ring_wall_thickness * 2,
                height = ring_height,
                top_chamfer = outer_ring_top_chamfer,
                bottom_chamfer = outer_ring_bottom_chamfer
            );
            
            // Hollow out center
            translate([0, 0, -1])
                cylinder(d = open_diameter, h = ring_height + 2);
            
            // Create gap for clamping
            translate([open_diameter/2, 0, 0])
                cube([ring_wall_thickness * 4, gap_chord, ring_height * 4], center = true);
        }
        
        // Clamping bracket 1 (with bolt hole)
        translate([open_diameter/2 + ring_wall_thickness/2, gap_chord/2, 0])
            clamping_bracket(has_nut_recess = false);
        
        // Clamping bracket 2 (with hex nut recess)
        translate([open_diameter/2 + ring_wall_thickness/2, -gap_chord/2, 0])
            mirror([0, 1, 0])
            clamping_bracket(has_nut_recess = true);
    }
}

//==============================================================================
// MODULE: CLAMPING BRACKET
//==============================================================================

module clamping_bracket(has_nut_recess = false) {
    difference() {
        // Bracket body
        cube([ring_wall_thickness + bracket_width, bracket_thickness, ring_height]);
        
        // Through-hole for bolt
        if (add_hex_hardware_recesses) {
            translate([ring_wall_thickness/2 + bracket_width/2, 0, ring_height/2])
                rotate([90, 0, 0])
                cylinder(h = 100, d = bolt_hole_diameter, center = true);
            
            // Hex nut recess (on one bracket only)
            if (has_nut_recess) {
                translate([ring_wall_thickness/2 + bracket_width/2, 0, ring_height/2])
                    rotate([90, 0, 0])
                    cylinder(h = hex_nut_height * 2, d = hex_nut_width, center = true, $fn = 6);
            }
            
            // Countersink for bolt head on opposite side
            translate([ring_wall_thickness/2 + bracket_width/2, bracket_thickness, ring_height/2])
                rotate([90, 0, 0])
                cylinder(h = bolt_countersink_depth * 2, d = hex_nut_width, center = true);
        } else {
            // Simple through-hole if hardware recesses disabled
            translate([ring_wall_thickness/2 + bracket_width/2, 0, ring_height/2])
                rotate([90, 0, 0])
                cylinder(h = 100, d = 5, center = true);
        }
    }
}

//==============================================================================
// MODULE: TIGHTENING KNOB
//==============================================================================

module tightening_knob() {
    difference() {
        union() {
            // Main knob body
            cylinder(h = 20, d = ring_height);
            
            // Grip ridges around perimeter
            for(angle = [40:40:360]) {
                rotate([0, 0, angle])
                    translate([ring_height/2, 0, 0])
                    hull() {
                        translate([0, 0, 2])
                            sphere(d = 2);
                        translate([0, 0, 18])
                            sphere(d = 2);
                    }
            }
        }
        
        if (add_hex_hardware_recesses) {
            // Through-hole for bolt shaft
            cylinder(h = 50, d = bolt_hole_diameter, center = true);
            
            // Countersink for bolt head
            translate([0, 0, 11])
                cylinder(h = 20, d = bolt_countersink_diameter, center = true);
            
            // Hex recess for bolt head
            translate([0, 0, 11])
                cylinder(h = 20, d = hex_nut_width, center = true, $fn = 6);
        } else {
            // Simple through-hole if hardware recesses disabled
            cylinder(h = 50, d = 5, center = true);
        }
    }
}

//==============================================================================
// MAIN RENDERING LOGIC
//==============================================================================

if (part_to_render == "all" || part_to_render == "assembly") {
    // Assembly view with optional explosion
    color("SteelBlue")
        translate([0, 0, -assembly_explode_distance])
        inner_ring();
    
    color("CornflowerBlue")
        outer_ring();
    
    color("LightSteelBlue")
        translate([
            open_diameter/2 + ring_wall_thickness/2 + ring_wall_thickness/2 + bracket_width/2,
            0,
            ring_height/2 + assembly_explode_distance
        ])
        rotate([0, 90, 0])
        tightening_knob();
}

if (part_to_render == "inner") {
    inner_ring();
}

if (part_to_render == "outer") {
    outer_ring();
}

if (part_to_render == "knob") {
    tightening_knob();
}

//==============================================================================
// END OF FILE
//==============================================================================
