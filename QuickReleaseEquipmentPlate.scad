// modules here are for creating quick release plate for
// specific equipments. It uses modules in other quick release files

// use <QuickReleaseUniversalPlate.scad>
include <Common.scad>
use <QuickReleaseBasePlate.scad>
use <QuickReleaseUniversalPlate.scad>
use <KeystoneMount.scad>

/* [Making] */
Making="HP Elitedesk Mini"; // ["HP Elitedesk Mini","YuLinca 8 port Network Switch","TP-Link TLSG1008D","Netgear GS208"]

/* No need to turn on this code yet
// Some Equipment Plate ignores Shelf Height
Shelf_Height="40mm Slim"; // ["40mm Slim","50mm Standard","150mm","180mm","Custom"]
// When Shelf Height is set to Custom
Custom_Shelf_Height=40;
*/
             
/* [Hidden] */

/* No need to turn on this code yet
shelf_height=(Shelf_Height=="40mm Slim") ? 40 :
             (Shelf_Height=="50mm Standard") ? 50 :
             (Shelf_Height=="150mm") ? 150 :
             (Shelf_Height=="180mm") ? 180 : 
             (Shelf_Height=="Custom") ? Custom_Shelf_Height : 0;
*/

if (Making=="HP Elitedesk Mini") {
    hp_elitedesk_mini_plate();
} else if (Making=="YuLinca 8 port Network Switch") {
    yulinca_8port_plate();
} else if (Making=="TP-Link TLSG1008D") {
    tplink_TLSG1008D_plate();
} else if (Making=="Netgear GS208") {
    Netgear_GS208_plate();
}

// ----------------
// Mini PC 1L Plate
// ----------------
// mini_pc_1L_plate is based on the popular 1L mini pc format
// used by HP, Dell and Lenovo. Plate is designed to use M4x8 screws,
// but M4x6 to M4x12 will work
// right_keystone is older code, keystone at the right hand side
module mini_pc_1L_plate_right_keystone()
{
    xoffset=panel_thickness; // account for the slider slot
    yoffset=6.5; // measured front plate thickness of an HP G3 mini
    
    screw_plate(
        40+xoffset,40+yoffset,4,
        140+xoffset,40+yoffset,4,
        140+xoffset,140+yoffset,4,
        40+xoffset,140+yoffset,4);
    
    kw=30;
    ksw=13.6;//hard coded
    tkz=15;
    tkx=shelf_width-kw+ksw/2;
    difference()
    {
        front_cover(align="right",width=kw,panel_height=50);
        translate([tkx,0,tkz])
            hull()keystone_mount();
    }
    translate([tkx,0,tkz])
            keystone_mount();
}

module mini_pc_1L_plate() // currently keystone is on left hand side
{
    xstart=shelf_width-panel_thickness-140; // account for the slider slot
    yoffset=6.5; // measured front plate thickness of an HP G3 mini
    
    screw_plate(
        xstart,40+yoffset,4,
        xstart+100,40+yoffset,4,
        xstart+100,140+yoffset,4,
        xstart,140+yoffset,4);
    
    kw=30;
    ksw=16.6;//hard coded
    tkz=15;
    tkx=(kw-ksw)/2;
    difference()
    {
        front_cover(align="left",width=kw,panel_height=50);
        translate([tkx,0,tkz])
            hull()keystone_mount();
    }
    translate([tkx,0,tkz])
            keystone_mount();
}

// -----------------
// HP Elitedesk Mini
// -----------------
module hp_elitedesk_mini_plate()
{
    // tested with elitedesk G2 and G3
    mini_pc_1L_plate();
}

// -----------------------------
// YuLinca 8 port Network Switch
// -----------------------------
module yulinca_8port_plate()
{
    universal_back_screw_plate(
        equipment_width=190,screw_plate_pos=2,panel_height=40);
}

// --------------------------------
// TP-Link TLSG1008D Network Switch
// --------------------------------
module tplink_TLSG1008D_plate()
{
    ew=165;
    ed=110;
    eh=30;
    
    bracket_plate(ew=ew,ed=ed,eh=eh);
}

// ----------------------------
// Netgear GS208 Network Switch
// ----------------------------
module Netgear_GS208_plate()
{
    ew=152;
    ed=92;
    eh=26;
    
    bracket_plate(ew=ew,ed=ed,eh=eh);
}


// -------------------------
// No name brand HDMI switch
// -------------------------
module No_name_hdmi_switch_plate()
{
    ew=200;
    ed=80;
    eh=30;
    
    bracket_plate(ew=ew,ed=ed,eh=eh);
}

// --------------------------------------------------
// For equipments with generic 100mm wall mount holes
// --------------------------------------------------
// Don't use. The design sucks
module generic_100mm_wallmount_plate()
{
    // this plate is not practical
    xoffset=panel_thickness;
    yoffset=0;
    
    screw_plate(
        50+xoffset,60+yoffset,3,
        150+xoffset,60+yoffset,3,
        plate_style="half",
        screw_style="printed",
        vented=2);
    
    translate([0,120,0])
        universal_back_panel();
}

// Testing
// yulinca_8port_plate();
// hp_elitedesk_mini_plate();
// network_switch_plate();
// hdmi_switch_plate();
// mini_pc_1L_plate();
// 8_keystone_plate();
// tplink_TLSG1008D_plate();
