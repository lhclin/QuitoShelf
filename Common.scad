// Common Dimensions, adjust if main shelf parameter changes
panel_thickness = 5;

/* panel_height is now defined in individual customizer
// panel_height = 50; // regular
// panel_height = 150; // extra tall, under tested
// panel_height = 180;
panel_height = 40; // slim
*/

panel_length = 200;
shelf_width=215;

module venting_hole(length,radius,center=false,thickness=10)
{
    $fn=100;
    tx=center? length/2: 0;
    translate([-tx,0,0])
    hull() union() {
        // extra height for easier visualization, not really needed
        cylinder(h=thickness, r=radius, center=true);
        translate([length, 0, 0])
            cylinder(h=thickness, r=radius, center=true);
    }
}

// venting_hole(60,10,center=true);