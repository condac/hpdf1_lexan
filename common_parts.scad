include <tunable_constants.scad>;
common_flat_screw_tap();
module common_flat_screw_tap(l = 10, l2 = 0) {
    // l2 is amount of the screw that are bigger for sliding through the hole
    tap_z = 1.9;
    union() {
        cylinder(d = C_M3_DIAMETER_THREAD, h= l);
        cylinder(d = C_M3_DIAMETER, h= l2);
        translate([0,0,-0.1+0.1]) cylinder(d1 = 6.5, d2= C_M3_DIAMETER_THREAD, h= tap_z);
        translate([0,0,-0.1]) cylinder(d = 6.5, h= 0.3);
    }
}

module common_button_screw_tap(l = 10, l2 = 0) {
    
    tap_z = 1.1;
    union() {
        cylinder(d = C_M3_DIAMETER_THREAD, h= l);
        cylinder(d = C_M3_DIAMETER, h= l2);
        translate([0,0,-4]) cylinder(d = 6, h=4);
    }
}

module roundedcube(xdim ,ydim ,zdim,rdim){
    hull(){
        fn=30;
        translate([rdim,rdim,0]) cylinder(r=rdim, h=zdim, $fn=fn);
        translate([xdim-rdim,rdim,0])cylinder(r=rdim, h=zdim, $fn=fn);

        translate([rdim,ydim-rdim,0]) cylinder(r=rdim, h=zdim, $fn=fn);
        translate([xdim-rdim,ydim-rdim,0]) cylinder(r=rdim, h=zdim, $fn=fn);
    }
}

module cylinder_outer(height,radius,fn){
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn);
}