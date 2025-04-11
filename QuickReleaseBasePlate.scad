// These are the foundation plates of which other plates are
// built. The file also has utilities for the common tasks

include <Common.scad>
use <KeystoneMount.scad>

/* [Making] */
Making="Vented"; // ["Vented","Drawer","Keystones","Solid Full","Solid Half","Solid Quarter","Screw"]
Height="40mm Slim"; // ["40mm Slim","50mm Standard","150mm","180mm","Custom"]
CustomHeight=40;
Keystones=8;

/* [Screw Plate Parameters] */
Diameter=4;
X1=57.5; Y1=46.5;
X2=157.5; Y2=46.5;
X3=57.5; Y3=146.5;
X4=157.5; Y4=146.5;
Vented=0;

/* [Hidden] */
panel_height=(Height=="40mm Slim") ? 40 :
             (Height=="50mm Standard") ? 50 :
             (Height=="150mm") ? 150 :
             (Height=="180mm") ? 180 : 
             (Height=="Custom") ? CustomHeight : 0; 

if (Making=="Vented") {
    quick_release_vented_plate();
} else if (Making=="Drawer") {
    drawer_plate();
} else if (Making=="Keystones") {
    keystone_plate(Keystones);
} else if (Making=="Solid Full") {
    quick_release_solid_plate(plate_style="full");
} else if (Making=="Solid Half") {
    quick_release_solid_plate(plate_style="half");
} else if (Making=="Solid Quarter") {
    quick_release_solid_plate(plate_style="quarter");
} else if (Making=="Screw") {
    screw_plate(
        sx1=X1,sy1=Y1,sd1=Diameter,
        sx2=X2,sy2=Y2,sd2=Diameter,
        sx3=X3,sy3=Y3,sd3=Diameter,
        sx4=X4,sy4=Y4,sd4=Diameter,
        vented=Vented);
}

// -----------
// Solid Plate
// -----------
// Solid plate contains all the required features
module quick_release_solid_plate(
    screw_holes=true,hint_text=true,
    plate_style="full" // full, half, quarter depth
    ) 
{
    difference(){
    // Base plate - TODO, replace hard code parameters
    translate([0,panel_length,0])
        rotate([90,0,0])
        linear_extrude(panel_length)
        polygon([[0,0],[0,2.5],[5,5],
            [shelf_width-5,5],[shelf_width,2.5],[shelf_width,0]]);
        
    // screw holes for securing quick release plate
    if (screw_holes)    
        quick_release_screw_holes();
    
    // removal for non-full plates
    if (plate_style=="half") {
        translate([0,panel_length/2,0])
        cube([shelf_width,panel_length/2,panel_thickness],center=false);
    }
    else if (plate_style=="quarter") {
        translate([0,panel_length/4,0])
        cube([shelf_width,panel_length*3/4,panel_thickness],center=false);
    }
        
    // bevel the back bottom for easy insertion
    by = plate_style=="half" ? panel_length/2 : 
         plate_style=="quarter" ? panel_length/4 :
         panel_length;
    translate([shelf_width/2,by,0])
    rotate([45,0,0])
    cube([shelf_width, 2, 2], center=true);    
        
    if (hint_text) {
        // Mark the back of the quick release plate. Linux probably
        // needs to install true type fonts
        translate([shelf_width/2, panel_length-15,panel_thickness-0.4])
        linear_extrude(2)
        text("BACK",font="Arial",size=10,halign="center");
    }

}// difference
} // module

// ------------
// Vented Plate
// ------------
// Vented solid plate with up to 3 big vent holes
module quick_release_vented_plate(vented=3)
{
    difference(){
        // Base plate
        quick_release_solid_plate();
    
        // removing material for air vents
        base_plate_air_vents(vented=vented);
    }
}

// -----------
// Screw Plate
// -----------
// plate with screws holes for equipment with screw bottom
//
// Up to 4 screws can be specified (x,y position relative the front
// left corner of the plate, screw diameter)
//
// For solid plate, it supports shortening the plate
//
// For vented plate(vented>0), caller can specify how many vents to make
// 
// For screw_style, currently only should use "real" screws (i.e. metal
// screws to be added on after print). Print screws are too flaky to be
// used in practice
module screw_plate(
    sx1=0,sy1=0,sd1=0,
    sx2=0,sy2=0,sd2=0,
    sx3=0,sy3=0,sd3=0,
    sx4=0,sy4=0,sd4=0,
    plate_style="full",
    screw_style="real", // real, printed
    vented=0
)
{
    // real screw are for, real screws to be screwed into the plate after printing
    // printed screw will simulate top mounting M3 screws for wall mounting 
    // the equipment, and
    // screw diamenter will be used to determine the riser size only
    difference()
    {
        if (vented > 0) {
            quick_release_vented_plate(vented=vented);
        } else {
            quick_release_solid_plate(plate_style=plate_style);
        }
        screw_plate_hole(sx=sx1,sy=sy1,sd=sd1,riseronly=true,screw_style=screw_style);
        screw_plate_hole(sx=sx2,sy=sy2,sd=sd2,riseronly=true,screw_style=screw_style);
        screw_plate_hole(sx=sx3,sy=sy3,sd=sd3,riseronly=true,screw_style=screw_style);
        screw_plate_hole(sx=sx4,sy=sy4,sd=sd4,riseronly=true,screw_style=screw_style);
    }
    
    screw_plate_hole(sx=sx1,sy=sy1,sd=sd1,riseronly=false,screw_style=screw_style);
    screw_plate_hole(sx=sx2,sy=sy2,sd=sd2,riseronly=false,screw_style=screw_style);
    screw_plate_hole(sx=sx3,sy=sy3,sd=sd3,riseronly=false,screw_style=screw_style);
    screw_plate_hole(sx=sx4,sy=sy4,sd=sd4,riseronly=false,screw_style=screw_style);
}

// ------------
// Drawer Plate
// ------------
// Drawer Plate makes a drawer. It and its utilities serves as a foundation for
// plates with side and back panels
module drawer_plate()
{   
    quick_release_solid_plate(screw_holes=false,hint_text=false);
    difference() 
    {
        front_cover();
        translate([shelf_width/2,0,panel_height*2/3])
        rotate([90,0,0])
        venting_hole(shelf_width/6, panel_height/8,center=true); // drawer handle
    }
    
    // side panels
    translate([5,0,panel_thickness])
    cube([panel_thickness,panel_length,
          panel_height-panel_thickness-4]);
    translate([shelf_width-10,0,panel_thickness])
    cube([panel_thickness,panel_length,
          panel_height-panel_thickness-4]);
    
    translate([0,panel_length,panel_thickness])
        back_cover();
}

// ---------------------
// Keystone Mount Plates
// ---------------------
module keystone_plate(keystones=8)
{
    stones=keystones < 1 ? 1 : keystones; // don't div by 0
    
    quick_release_solid_plate(plate_style="quarter");
    
    ksw=16.6;
    // ksz=15; // hard code, no good for slim built
    ksz=(panel_height - 26) / 2; // 26 is approximate height of keystone
    
    margin=12; // we need some space on the left and right to access the stop holes
    ks_space=(shelf_width-2*margin)/stones;
    
    difference() {
        front_cover();
        for (i=[0:stones-1]) {
            ksx=i*ks_space+margin+(ks_space-ksw)/2;
            
            translate([ksx,0,ksz])
                hull()keystone_mount();
        }
    }
    for (i=[0:stones-1]) {
            ksx=i*ks_space+margin+(ks_space-ksw)/2;
            
            translate([ksx,0,ksz])
                color("red") keystone_mount();
    }
}

// ---------
// Utilities
// ---------

// Make a screw hole on plate
module screw_plate_hole(
    sx=0,sy=0,sd=0,riseronly=false,screw_style="real")
{
    $fn=100;
    tolerance = 1;
    if (sd > 0)
    {
        // quick estimate of head diameter based on metric screw
        hd = sd >= 8 ? sd * 1.5 + tolerance * 2 : sd * 2 + tolerance;
        hr = hd/2;
        sr = sd/2 + tolerance/2;
        
        riser_d = hd * 1.5; // guess
        riser_h = panel_thickness*1.5;
        
        slope_h = panel_thickness/2 -1; // the -1 is for a bit extra strength at the top of the screw hole
        
        difference()
        {
            // screw riser
            {
                translate([sx,sy,riser_h/2]) {
                    if (screw_style=="real")
                    {
                        cylinder(h=riser_h,r=riser_d/2,center=true);
                    }
                    if (!riseronly && (screw_style=="printed"))
                    {
                        // fake a M3 screw
                        translate([0,0,2])
                            cylinder(h=2,r=1.5-0.1,center=true);
                        translate([0,0,1+2]) //head
                            cylinder(h=1.5,r1=1.5,r2=3,center=true);
                    }
                }
            }
           
            if (!riseronly)
            {
                if (screw_style=="real") {
                    // screw hole
                    translate([sx,sy,riser_h/2])
                        cylinder(h=riser_h,r=sr,center=true);
                    // screw head hole
                    translate([sx,sy,panel_thickness/2])
                        cylinder(h=panel_thickness,r=hr,center=true);
                    // slight slope for cleaner printing
                    translate([sx,sy,panel_thickness+slope_h/2])
                        cylinder(h=slope_h,r1=hr,r2=sr,center=true);
                } 
            }
        } // difference    
    }
}


module front_cover(
    align="center",
    width=0 // full width
)
{
    w = width > 0 ? width : shelf_width;
    
    tx = align=="center" ? shelf_width/2 - w/2 :
         align=="left" ? 0 :
         shelf_width - w; // right
    
    translate([tx,0,0])
             cube([w,panel_thickness,panel_height-2]);
}

module back_cover()
{
     translate([5,-5,0])
     cube([shelf_width-10,panel_thickness,
        panel_height-panel_thickness-4]);
}






        