// Common Dimensions, adjust if main shelf parameter changes
panel_thickness = 5;

/* panel_height is now defined in individual customizer
   and renamed to shelf_height
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

// Common air vents for shelf and plate
module base_plate_air_vents(vented=3)
{
    vent_to_side=30;
    vent_radius=20;
    vent_length=shelf_width - 2 * vent_to_side;
    vent_to_front=40; // this is to the middle of the vent
    vent_spacing=60; 
    
    if (vented > 2)
        translate([vent_to_side,vent_to_front,0])
            venting_hole(vent_length,vent_radius);
    if (vented > 1)
        translate([vent_to_side,vent_to_front + vent_spacing,0])
            venting_hole(vent_length,vent_radius);
    if (vented > 0)
        translate([vent_to_side,vent_to_front + 2*vent_spacing,0])
            venting_hole(vent_length,vent_radius);
}

// Make the screw holes for inserting stops. Stop
// positions are shared between shelves and plates
// Stops can be printed or M3 screw
module quick_release_screw_holes()
{
    // based on quick release plate area, 10mm offset from each corner
    // M3 screw holes
    $fn=100;
    offset=10;
    
    // 0.1mm tolerance for screws
    translate([offset,offset,2.5])
        cylinder(h=5, r=1.6, center = true);
    translate([shelf_width-offset,offset,2.5])
        cylinder(h=5, r=1.6, center = true);
    translate([shelf_width-offset,panel_length-offset,2.5])
        cylinder(h=5, r=1.6, center = true);
    translate([offset,panel_length-offset,2.5])
        cylinder(h=5, r=1.6, center = true);
}
