include <tunable_constants.scad>;
common_flat_screw_tap();
module common_flat_screw_tap(l = 10, l2 = 0) {
    // l2 is amount of the screw that are bigger for sliding through the hole
    tap_z = 1.9;
    union() {
        cylinder(d = C_M3_DIAMETER_THREAD, h= l);
        cylinder(d = C_M3_DIAMETER, h= l2);
        translate([0,0,0.5]) cylinder(d1 = 6.5, d2= C_M3_DIAMETER_THREAD, h= tap_z);
        translate([0,0,-0.1]) cylinder(d = 6.5, h= 0.3+0.5);
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

//indicator_dots(2);

module indicator_dots(valueIn) {
    for (a =[0:1:valueIn-1]) {
        translate([a*3,0,0]) cube([2,2,1]);
    }
}
//receiver();
module receiver() {
    //based on futaba R203GF because it is the largest i have
    x = 26;
    y = 40;
    z1 = 10;
    z2 = 13;
    sp = 2.54;
    
    color("grey")cube([x,y,z1]);
    color("grey")cube([18,12,z2]);
    color("grey")cube([18,12,z2]);
    translate([2,1.5, 5])servocables();
    translate([2+sp,1.5, 5])servocables();
    translate([2+sp*2,1.5, 5])servocables();
    translate([2+sp*3,1.5, 5])servocables();
    translate([2+sp*4,1.5, 5])servocables();
}
module servocables() {
    sp = 2.54;
    
    color("black")translate([sp/2,sp/2,0]) cylinder(d=sp, h=20);
    color("red")translate([sp/2,sp/2+sp,0]) cylinder(d=sp, h=20);
    color("white")translate([sp/2,sp/2+sp+sp,0]) cylinder(d=sp, h=20);
    
}
ESC_big();
module ESC_big() {
    x = 32.5;
    x2 = 37;
    y = 45;
    z1 = 10;
    z2 = 17;
    z3 = 23.5;
    
    
    color("lightblue")cube([x,y,z1]);
    
    color("green")translate([2, 8, z1]) cube([x2,33,2]);
    
    color("lightblue")translate([0, 6, 0]) cube([x,y-6,z2]);
    color("lightblue")translate([3, 10, 0]) cube([x-6,y-10-4,z3]);
    color("lightblue")cube([18,12,z2]);
    color("lightblue")cube([18,12,z2]);
    
}