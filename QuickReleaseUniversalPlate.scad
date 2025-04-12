// Modules here are the universal mounting plates. By
// specifying parameters, plates can be generated and later
// modified

include <Common.scad>
use <QuickReleaseBasePlate.scad>
use <threads.scad>

/* [Making] */
Making="Side Screw"; // ["Side Screw","Back Screw","Bracket"]
Shelf_Height="40mm Slim"; // ["40mm Slim","50mm Standard","150mm","180mm","Custom"]
// When Shelf Height is set to Custom
Custom_Shelf_Height=40;

Equipment_Width=120;
// Bracket Plate Only
Equipment_Depth=100;
// Bracket Plate Only
Equipment_Height=32;

// Back Screw Plate Only - 0,1,2,3
Back_Screw_Plate_Position=1;

/* [Back Screw Parameters] */
/* [Hidden] */
// bracket_plate(ew=172,ed=100,eh=32);

if (Making=="Side Screw") {
    universal_side_screw_plate(equipment_width=Equipment_Width);
} else if (Making=="Back Screw") {
    universal_back_screw_plate(equipment_width=Equipment_Width,screw_plate_pos=Back_Screw_Plate_Position);
} else if (Making=="Bracket") {
    bracket_plate(ew=Equipment_Width,ed=Equipment_Depth,eh=Equipment_Height);
}

panel_height=(Shelf_Height=="40mm Slim") ? 40 :
             (Shelf_Height=="50mm Standard") ? 50 :
             (Shelf_Height=="150mm") ? 150 :
             (Shelf_Height=="180mm") ? 180 : 
             (Shelf_Height=="Custom") ? Custom_Shelf_Height : 0;

// ----------------------------------------
// Universl Mounting Plate with side screws
// ----------------------------------------
module universal_side_screw_plate(equipment_width=120)
{
    // designed for several width sizes: 120,150,170. Should work up to 170mm
    quick_release_vented_plate();
    
    width_tolerance=1;
    cover_width=(shelf_width-equipment_width) / 2 - width_tolerance;
    
    front_cover(align="left",width=cover_width);
    front_cover(align="right",width=cover_width);
    
    translate([cover_width,0,panel_thickness])
        // Important: we can't mirror side panel to create another here
        // because it has screw threads, which can't be mirrored
        universal_side_screw_panel(psuedo_mirror=true);
    
    translate([shelf_width-cover_width,0,panel_thickness])
        universal_side_screw_panel();
}

// -----------------------------------------
// Universal Mounting Plate with back screws
// -----------------------------------------
module universal_back_screw_plate(equipment_width=180,screw_plate_pos=0)
{
    // designed for equipment wider than 170mm. The mounting screws
    // are at the back, which is not ideal as many connectors are
    // there
    
    // screw_plate_pos = 0,1,2,3 to control how far away the screw
    // plate is to the front of the shelf
    // 0 is closest to the front. 3 is furthest away
    
    // A 10mm latch cover is provided to hold the equipment in place
    quick_release_vented_plate();
    
    width_tolerance=1;
    cover_width=(shelf_width-equipment_width) / 2 - width_tolerance;
    
    front_cover(align="left",width=cover_width+10);
    front_cover(align="right",width=cover_width+10);
    
    if (equipment_width <= 190)
    {
        // Side panels
    translate([cover_width,0,panel_thickness])
        mirror([1,0,0]) universal_back_screw_panel();
    
    translate([shelf_width-cover_width,0,panel_thickness])
        universal_back_screw_panel();
    }
    
     // Add the screw back panel
     ty=(screw_plate_pos < 4) ?
         lookup(screw_plate_pos, [
             [0,80],
             [1,120],
             [2,140],
             [3,185]]) : 120;
     translate([0,ty,panel_thickness])
        universal_back_panel();
}

// ------------
// Bracket Plate
// -------------
// Specify the equipement width, depth, and height
// The plate, and a set of top mounting bracket are
// generated
//
// Use this type of plate when the universal screw
// plates are not desirable
module bracket_plate(ew=0,ed=0,eh=0)
{
    wt=10;
    hwt=wt/2;
    
    // If the equipment width is too wide,
    // turn on the oversize protection
    
    // for over deep equipment, another 
    // module is needed
    width_limit=shelf_width -
                2 * (panel_thickness+1) - // slider
                2 * hwt; // space needed to the latch
    oversize = ew > width_limit;
    bew = oversize ? width_limit : ew;
    
    difference() {
    union(){
        quick_release_solid_plate();
        translate([shelf_width/2,ed/2+wt,panel_thickness])
            equipment_bracket(w=bew,d=ed,h=eh,
                 oversize=oversize);
    }
    // remove some print material for weight and air flow
    chop_width=width_limit;
    translate([(shelf_width-chop_width)/2+wt,ed+4*wt, 0])
    cube([chop_width-2*wt,panel_length,eh]);
    
    /* old code for material removal
    translate([(shelf_width-bew)/2+wt,ed+4*wt, 0])
    cube([bew-2*wt,ed,eh]);
    */
    } // difference
}

// -----------------------------------
// Utilities for Universal Screw Mount
// -----------------------------------

// side panel for Universal Side Screw Mount
module universal_side_screw_panel(
    psuedo_mirror=false,
    make_screw=true)
{
     ydist=panel_length/4;
     zdist=(panel_height-12)/2;
    
     nut_thickness=8;
    
     // caller cannot mirror this panel because of screw thread 
     // Instead, will do a pseudo mirroring here
     px=psuedo_mirror?-panel_thickness:0;
     nx=psuedo_mirror?(panel_thickness-nut_thickness):0;
    
     translate([px,0,0]) union(){
     difference()
     {
         // from drawer code, may be later combine the two
         cube([panel_thickness,panel_length,
               panel_height-panel_thickness-4]);

         if (make_screw) {
         for(i=[1:3])
         {
             translate([nx,i*ydist,zdist])         
              rotate([0,90,0]) rotate([0,0,90])
                  hull() MetricNut(12,thickness=nut_thickness);
         } // for
         } // if
     } // difference
     
     if (make_screw) {
         for(i=[1:3])
         {
         translate([nx,i*ydist,zdist])         
              rotate([0,90,0]) rotate([0,0,90])
                  MetricNut(12,thickness=nut_thickness);
         }
     } // if
     }// union
}

// side panel for Universal Back Screw Mount
module universal_back_screw_panel()
{
     // the panel for universal back screw is a modified
     // version of universal side screw panel. Back screw version
     // is shorter, no screw thread, no pseudo mirror code
     // and air vented
    
     difference() 
     {
         intersection() {
             universal_side_screw_panel(make_screw=false);
             cube([panel_thickness,100,panel_height]); // cut short
         }
         translate([0,15,(panel_height-10)/2])
         rotate([90,0,90])
         venting_hole(70,panel_height/4);
     }
}

// Back panel for Universal Mount with back screws
module universal_back_panel()
{
    nut_thickness=8;
    
    xdist=(shelf_width-panel_thickness*2) / 4;
    zdist=(panel_height-panel_thickness-4) / 2; // from back_cover code
    ny=-(panel_thickness-nut_thickness);
    
    vxstart=xdist/2+panel_thickness;
    vxdist=xdist;
    
    difference() {
            back_cover();
    
            for(i=[1:3]) {
                translate([panel_thickness+i*xdist,ny,zdist])
                rotate([90,0,0])
                    hull() MetricNut(12,thickness=nut_thickness);
            }
            
            for(i=[0:3]) {
                translate([vxstart+i*vxdist,0,panel_height/2])
                    rotate([180,0,0]) rotate([0,90,90]) venting_hole(20,12);
            }
            
                    
    } // difference
    for(i=[1:3]) {
                translate([panel_thickness+i*xdist,ny,zdist])
                rotate([90,0,0])
                    MetricNut(12,thickness=nut_thickness);
    }   
    
}

// ---------------------------
// Utilities for Bracket Plate
// ---------------------------
module equipment_L_bracket(h,oversize,reduce_bracket=false) {
    wt=10;
    hwt=wt/2;
     
    $fn=100;
    difference() 
    {
        translate([wt,wt,0])
            cylinder(h=h,r=wt,center=false);
        
        // reduce bracket, cut off the holder a little
        // to accomodate possible plugs on the equipment
        // It also gives a slim look
        if (reduce_bracket) {
            translate([hwt*3,0,0])
                color("red")cube([hwt,wt,h]);
        }
        
        // cut off for normal size bracket
        translate([hwt,wt,0])
            cube([hwt*3,wt,h]);
        
        // cut off more for oversize bracket
        if (oversize)
        {
            translate([0,wt,0])
                cube([hwt*4,wt,h]);
        }        
        
        translate([wt, hwt, h/2]) // screw
            cylinder(h=h, r=1.6, center = true);
    }
}

module equipment_bracket_left(
    w,d,h,oversize,reduce_bracket=true
) 
{
    wt=10;
    hwt=wt/2;
    
    // Lower Left L bracket 
    translate([-w/2-hwt,-d/2-wt,0])
        equipment_L_bracket(h,oversize,reduce_bracket=
            reduce_bracket);
    mirror([0,1,0]) translate([-w/2-hwt,-d/2-wt,0])
        equipment_L_bracket(h,oversize,reduce_bracket=
            reduce_bracket);
}

module equipment_bracket_cover(
    w,d,h)
{
    wt=10;
    hwt=wt/2;
    difference()
    {
        hull()
        equipment_bracket_left(
            w,d,panel_thickness,
            oversize=false,
            reduce_bracket=true);
        translate([-w/2+hwt
                   ,-d/2-hwt,0])        
            cylinder(h=h*5, r=1.6, center = true);
        translate([-w/2+hwt
                   ,d/2+hwt,0])        
            cylinder(h=h, r=1.6, center = true);
    }
}

module equipment_bracket(
    w,d,h,oversize)
{
    wt=10; // wall thickness
    hwt=wt/2;
    
    equipment_bracket_left(w,d,h,oversize);
    mirror([1,0,0]) equipment_bracket_left(w,d,h,oversize);
    
    // generate the covers
    $fn=100;
    translate([shelf_width,0,-panel_thickness]) // move it out of way
    equipment_bracket_cover(w=w,d=d,h=h);
    
    translate([shelf_width+4*wt,0,-panel_thickness]) // move it out of way
    equipment_bracket_cover(w=w,d=d,h=h);
}

// Testing
//universal_back_panel();
