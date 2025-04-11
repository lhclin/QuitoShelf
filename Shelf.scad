include <Common.scad>
use <QuickReleaseBasePlate.scad>


making="shelf";
// making="test";
// making="top cover"; // full size cover
// making="short top cover"; // short top cover. For cosmetic use
// making="10inch1U"; // not finished

if (making=="shelf")
{
    shelf(shelf_style="regular");
}
else if (making=="top cover")
{
    // top shelf is just a modified shelf
    // without side panels
    rotate([180,0,0]) // prefer printing orientation
    shelf(shelf_style="top cover");
}
else if (making=="short top cover")
{
    // just make a full cover and chop it in half :)
    rotate([180,0,0]) // prefer printing orientation
    intersection()
    {
    shelf(shelf_style="top cover");
    translate([0,0,-panel_thickness*2])
        cube([shelf_width+panel_thickness*2,
             panel_length/3,panel_thickness*4]);
    }
}
else if (making=="10inch1U")
{
    // Not completed yet
    shelf(shelf_style="10inch1U");
} 
else if (making=="test")
{
    // testing code
    // side_panel();
    cross_brace(40);
}

module cross_brace(height)
{
    $fn=100;
    translate([0,panel_thickness/2,0]){
    hull() {
    translate([0,0,0])
        rotate([90,0,0])
            cylinder(h=panel_thickness,d=panel_thickness,center=true);
    translate([shelf_width,0,height])
        rotate([90,0,0])
            cylinder(h=panel_thickness,d=panel_thickness,center=true);
    }
    hull() {
    translate([shelf_width,0,0])
        rotate([90,0,0])
            cylinder(h=panel_thickness,d=panel_thickness,center=true);
    translate([0,0,height])
        rotate([90,0,0])
            cylinder(h=panel_thickness,d=panel_thickness,center=true);
    }
    }
}

module locking_latch(t=0,mirror=false){
    $fn=100;
    ht=t/2;
    mz=mirror? 1 : 0;
    mirror([0,0,mz])
    {
    translate([-ht,-ht,-ht])
    cube([5+t,10+t,2.5+t]); // no lock
    
    // lock
    // Note: the lock radius needs to be quite smaller
    // than the tolerance in the latch. Or it's not
    // going to fit. Kinda hard code for now as
    // the tolerance is going to be about 0.5mm
        
    // lock radius
    // lr=1; // old code too big
    // lr=0.25; // too small
    lr=0.35; // ad hoc
        
    translate([5+ht // size of no-lock latch + half tolerance
               -(lr+ht), // lock radius, adjusted by half tolerance
               5,2.5+ht])
    rotate([90,0,0])
        cylinder(h=10+t,r=lr+ht,center=true);
    }
}

module side_panel_plate()
{
    difference()
    {
    union()
    {
    // Generic solid plate
    cube([panel_height,
              panel_length + panel_thickness, // account for the back panel
              panel_thickness]);
        
    // stacking latch front and middle,locking
    translate([panel_height,5,0])
       locking_latch(0);
    translate([panel_height,2/3*panel_length,0])
       locking_latch(0);
        
    // stacking latch back
    // back latches are L-shape non-locking
    translate([panel_height,panel_length-10,0])
    {
        cube([5,10,2.5]); // the long straight edge
        translate([0,10,-2.5]) // the shorter L edge
            cube([5,2.5,5]); 
    }

    }
    
    // venting holes - don't bother making venting
    // holes for very narrow build's. It will be either broken or
    // funny looking
    if (panel_height >= 40)
    {
    hole_width=2;
    hole_spacing=5;
    hole_length = 20;
    
    holes = panel_length / (hole_width + hole_spacing) - 2;
    offset=panel_height - 30;
    for (i = [0:holes]) {
        translate([offset,10+i* (hole_width + hole_spacing), 0])
            venting_hole(hole_length,hole_width / 2);
    }
    }
    } // difference
}

module side_panel(
    shelf_style="regular" // regular,top cover,10inch1U
)
{    
    tolerance = 2; // this affects the rail only, original was 1, too tight
    
    translate([panel_thickness, 0, 0]) 
    rotate([0,-90,0])    // transform to shelf orientation
    union(){
        // Plate
        side_panel_plate();
        if (shelf_style == "regular") // other style has no rail
        {
            // rail_z_offset = side == 1 ? -panel_thickness : panel_thickness;
            rail_z_offset = -panel_thickness;
            
            // rail
            translate([panel_thickness + tolerance, 
                       panel_thickness + tolerance,
                       rail_z_offset])
                union(){
                    // rail itself
                cube([panel_thickness, 
                      panel_length - (panel_thickness + tolerance), 
                      panel_thickness]);
                    // extra inclination to reduce printing spaghetti
                rotate([90,0,180])
                    linear_extrude(
                      panel_length - (panel_thickness + tolerance))
                     polygon([[0,0],[0,5],[2.5,5]]);
                }
                
            // back panel for rigidity and a stop for quick release plate
            translate([0, panel_length, rail_z_offset])
                cube([panel_height, panel_thickness, panel_thickness]);
                
            // bracing for tall shelf. Starting
            // at 80mm, create a cross brace of 40mm tall
            // printing support is likely required
            brace_start=0;
            delta=180;
            // if (panel_height >= brace_start+delta) 
            {
            }
        }       
    }
}

module bottom_panel(
    shelf_style="regular" // regular,top cover,10inch1U
)
{
    difference() {
        // base solid panel
        // account for 2 side panels
        cube([shelf_width + 2*panel_thickness, 
            panel_length+panel_thickness, // account space for back panel
            panel_thickness+(shelf_style=="top cover"?1:0)]);
    
        // In the case of making a top cover,
        // we are still keeping the air vents and
        // screws. They will be covered by a thin
        // solid layer visually, to save material and
        // weight. However, this means 3D printing
        // upside down for no-support printing
        
        // removing material for air vents
        translate([panel_thickness, 0, 0]) // accounting for side panel
        base_plate_air_vents();
    
        // screw holes for securing quick release plate
        translate([panel_thickness, 0, 0]) // accounting for side panel
        quick_release_screw_holes();
    } // difference
    
    // back panel for rigidity. Adjust back panel for
    // top cover to fit into side panels
    bpw_adjust = shelf_style=="top cover" ? -5.5 : 0; 
    
    translate([panel_thickness - bpw_adjust, 
                   panel_length,        
                   (shelf_style=="top cover"?-1:1)*panel_thickness])
        cube([shelf_width/2, 
                panel_thickness,    
                panel_thickness]);
} // bottom_panel

module shelf_left(
    shelf_style="regular" // regular,top cover,10inch1U
)
{
    difference() 
    {
        // shift to middle of x axis
        translate([-(shelf_width/2+panel_thickness),0,0])
        
        difference() {
        // solid part of shelf
        union(){
            if(shelf_style!="top cover")
            {
                side_panel(shelf_style=shelf_style); // left panel
            }

            // doing a full bottom panel, but only      
            // going to use
            // half of it in later code
            translate([0,0,-panel_thickness]) 
                bottom_panel(shelf_style=shelf_style);
        }
        
        // Below are parts to be removed
            
        // space for the stacking latches
        lt=0.5; // latch tolerence for the hole
        hlt=lt/2;
    
        // front latch
        translate([2.5,5,-5]) // move to designed position    
            // re-oriented latch to match old code
            translate([2.5,0,0]) rotate([0,-90,0]) 
                locking_latch(lt);
        
        // middle latch
        translate([2.5,panel_length*2/3,-5]) // move to designed position    
            // re-oriented latch to match old code
            translate([2.5,0,0]) rotate([0,-90,0]) 
                locking_latch(lt);

        // back latch
        translate([2.5,panel_length-10,-5])
        translate([-hlt,-hlt,-hlt])
        { 
        cube([2.5+lt,10+lt,5+lt]);
            translate([0,10,0])
        cube([5+lt,2.5+lt,5+lt]);
        }
        } // difference
                
        // Chopped everying with positive x value so we
        // left with a clean left half to combine with right half later
        translate([0,0,-panel_thickness])
        cube([shelf_width/2+panel_thickness,
              panel_length+panel_thickness,
              panel_height+panel_thickness+20] // 20 - for the latch
        );
    } // difference
}
    
// ------------------
// Main object: shelf
// ------------------
module shelf(
    shelf_style="regular" // regular,top cover,10inch1U
)
{
   difference() 
   {
       union() { // add up the parts
           // left+right shelf re-oriented
           translate([shelf_width/2+panel_thickness, 0, 0]) 
           {
               shelf_left(shelf_style=shelf_style);
               mirror([1,0,0]) shelf_left(shelf_style=shelf_style);
           }
           // add the cross brace if shelf is tall
           zstart=80;
           // 30 gives enough space for the smallest side clip
           delta=max(30,panel_height-zstart-panel_thickness*4);
           if (panel_height >= zstart + delta)
               translate([panel_thickness,panel_length,zstart])
               cross_brace(delta);
        } //union
   
   // Below are code for rounding the exterior edges
   
   // Based on a dimension (215+2sidepanel)x(200+backpanel)x
   // panel_height+panel_thickness
   $fn=100;
   er=3;
   hw=shelf_width+2*panel_thickness;
   hl=panel_length+panel_thickness;
   // need extra hulling height because the bottom shelf is
   // is actually one panel thickness below the zero Z plane 
   hh=panel_height+2*panel_thickness; 
   hph=panel_height / 2;
   difference()
   {
      translate([0,0,-5])
      cube([hw,hl,hh]);
      hull(){
         translate([er,er,hph])
            cylinder(hh,er,er,true);
         translate([-er,er,hph])
            translate([hw,0,0])
            cylinder(hh,er,er,true);
         translate([er,-er,hph])
            translate([0,hl,0])
            cylinder(hh,er,er,true);
         translate([-er,-er,hph])
            translate([hw,hl,0])
            cylinder(hh,er,er,true);
     } // hull
   } // difference (create rounding block)
   
   } // difference (perform rounding)
   
   // Any parts outside of the rounded shelf should be here
   if (shelf_style=="10inch1U")
   {
       //TODO
   }
}
    
    
