// plate();
keystone_mount();

// module plate()
module keystone_mount()
{
    distTop=7;
    distBottom=3;
    distHorizontal=1;

    ksWidth=14.6;
    ksHeight=16.5;
    ksHeightBack=19.7;

    depth=9.5;

    //calculated
    outerWidth=ksWidth+distHorizontal*2;
    outerHeight=ksHeight+distTop+distBottom;

    difference() {
        // outer measurements
        cube([outerWidth,depth,outerHeight]);

        // outer measurements keystone module
        translate([distHorizontal,-1,distBottom])
        cube([ksWidth,20,ksHeight]);

        // outer measurements keystone module backside
        translate([distHorizontal,1,distBottom])
        cube([ksWidth,20,ksHeightBack]);

        // bottom diff
        translate([distHorizontal,1,distBottom-distBottom+1])
        cube([ksWidth,depth-2,ksHeightBack]);

        // top diff for keystone latch
        translate([distHorizontal,1,distBottom+3])
        cube([ksWidth,depth-2,ksHeightBack]);
        
        // top diff for opening latch hole
        translate([distHorizontal+ksWidth/2-2,5,distBottom+1])
        cube([4,40,ksHeightBack]);



        // debug only
//        translate([-1,-1,-1])
//        cube([10,100,100]);
//        translate([10,-1,-1])
//        cube([100,100,100]);
    }
}
