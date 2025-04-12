include <Common.scad>
use <threads.scad>

/* [Making] */
Making="Plate Stoppers"; // ["Plate Stoppers","Side Clip Back Slim","Side Clip Back Regular","Side Clips Air Vent","Mounting Screw 25mm","Mounting Screw 40mm"]

/* [Hidden] */
if (Making=="Plate Stoppers") {
    4_stoppers();
} else if (Making=="Side Clip Back Slim") {
    side_clip_back(height=40-2*panel_thickness-2);
} else if (Making=="Side Clip Back Regular") {
    side_clip_back(height=50-2*panel_thickness-2);
} else if (Making=="Side Clips Air Vent") {
    4_side_clips();
} else if (Making=="Mounting Screw 25mm") {
    universal_mount_screw(25);
} else if (Making=="Mounting Screw 40mm") {
    universal_mount_screw(40);
}

// 3mm stopper (fake M3 screw)
module 3mm_stopper(tolerance=0.15)
{
    $fn=100;
    translate([0,0,5+2])
        cylinder(h=10,r=1.5-tolerance,center=true);
    translate([0,0,1])
    cylinder(h=2,r=3,center=true);
}

module universal_mount_screw(length=25)
{   
    // mounting screw for the shelves
    // use 25 for standard length, 40 for long
    $fn=100;
    difference() {
    union() {
    scale([0.95,0.95,1])
         MetricBolt(12,length);
    // replace will round head because
    // it is meant to be hand cranked
    translate([0,0,6])
    cylinder(h=12,r=10,center=true);
    } // union
    cylinder(h=6,r=10,center=true);
    }// difference
    /* known good configuration
    scale([0.95,0.95,1])
         MetricBolt(12,20);
    */
}
module left_side_clip(height=40)
{
    $fn=100;
    tolerance=1;
    h=height-3*tolerance;
    
    translate([-3*panel_thickness-tolerance,0,0]) // move to left side
    {
    cube([2*panel_thickness+tolerance,panel_thickness,h]);
        
    translate([panel_thickness+tolerance,0,0])
        mirror([0,1,0]) 
            rotate([0,0,-2]) // extra torque for the clip 
                cube([panel_thickness,panel_thickness*5,h]);
        
        
    hull()
    {
    cube([panel_thickness,2*panel_thickness+tolerance,h]);
    translate([panel_thickness/2,2.5*panel_thickness+tolerance,h/2])
        cylinder(h=h,r=panel_thickness/2,center=true);
    }
    hull()
    {    
    translate([panel_thickness,2*panel_thickness+tolerance,0])
        cube([2*panel_thickness+tolerance,panel_thickness,h]);
    translate([panel_thickness/2,2.5*panel_thickness+tolerance,h/2])
        cylinder(h=h,r=panel_thickness/2,center=true);
    }
    } // translate to left side of Z plane
}

// connecting shelves side-by-side at the back
module side_clip_back(height=40)
{
    left_side_clip(height=height);
    mirror([1,0,0])
       left_side_clip(height=height);
}

// connecting shelves side-by-side using
// the air vents
module side_clip_airvent_left()
{    
    $fn=100;
    
    tolerance = 0.2;
    vent_size=2; // from shelf code
    clip_height=vent_size - tolerance;
    
    shelf_distance=panel_thickness*2+1.5;
    
    translate([-shelf_distance/2,0,0])
    {
    difference() {
        cylinder(h=clip_height,r=vent_size,center=true);
        translate([0,-vent_size,-clip_height/2])
            cube([vent_size*2,vent_size*2,clip_height]);
    }
    rotate([0,90,0])
    cylinder(h=shelf_distance/2,d=clip_height);
    }
}
module side_clip_airvent()
{
    side_clip_airvent_left();
    mirror([1,0,0]) side_clip_airvent_left();
}

module 4_side_clips()
{
    side_clip_airvent();
    translate([0,10,0])
        side_clip_airvent();
    translate([0,20,0])
        side_clip_airvent();
    translate([0,30,0])
        side_clip_airvent();    
}

module 4_stoppers()
{
    // for quick printing
    3mm_stopper();
    translate([10,10,0])
        3mm_stopper();
    translate([0,10,0])
        3mm_stopper();
    translate([10,0,0])
        3mm_stopper();
}




