use <common_parts.scad>
include <tunable_constants.scad>;


//$fs=0.1;
// Not even started...
// This is a modified part from the freecad project
steeringhubs_p();
module steeringhubs_p() {
    steering_hub();
    
    //translate() mirror([1,0,0]) steering_hub();
    
}
//steering_hub();
%steering_hub_freecad();
module steering_hub_freecad() {
    $fs=0.1;
    difference() {
        union() {
            translate([-90, 271.5, -20.5]) import("ref/testhub.stl", convexity=10);
            translate([0, -5.2, 0]) rotate([90,0,0]) cylinder(d=4, h=5);
            
        }
        translate([0, -4, 0]) rotate([90,0,0]) cylinder(d=2.75, h=10);
    }
}

module steering_hub() {
    xx = 10;
    yy = 22;
    zz = 10;
    
    kingpin_offset = 3.5;
    
    hole_material = 8;
    hole1_x = -2.5;
    hole1_y = 15.3;
    hole2_x = -7;
    hole2_y = 16.5;
    
    difference() { 
        union() {
            translate([-xx/2, -yy/2, -zz/2]) cube([xx, yy, zz]);
            
            hull() {
                translate([hole1_x,hole1_y,-zz/2]) cylinder(d=hole_material, h = zz/2);
                translate([hole2_x,hole2_y,-zz/2]) cylinder(d=hole_material, h = zz/2);
                
                translate([-xx/2, yy/2, -zz/2]) cube([xx, 1, zz/2]);
            }
            
            // spacer popout
            translate([-xx/2,0,0]) rotate([0,90,0]) cylinder(d=C_M4_DIAMETER_THREAD+3, h= xx+1);
        }
        
        //M4 threading hole
        translate([-xx,0,0]) rotate([0,90,0]) cylinder(d=C_M4_DIAMETER_THREAD, h= xx*2);
        //M4 tap
        translate([-xx/2-0.1,0,0]) rotate([0,90,0]) cylinder(d1=10, d2=C_M4_DIAMETER_THREAD, h= 2.9);
        translate([-xx/2-0.1,0,0]) rotate([0,90,0]) cylinder(d=7.8, h= 2.1);
        // Kingpin
        translate([0,-kingpin_offset,-zz]) cylinder(d=C_KINGPIN_SNUG, h= zz*2);
        
        //Kingpin Locking screw
        translate([0, -4, 0]) rotate([90,0,0]) cylinder(d=2.75, h=10);
        
        // 45 deg angle
        translate([-xx/2, yy/2, 0]) rotate([45,0,0]) cube(20);
        
        // screw holes
        translate([hole1_x,hole1_y,-zz/2]) cylinder(d=C_M3_DIAMETER_THREAD, h = zz/2);
        translate([hole2_x,hole2_y,-zz/2]) cylinder(d=C_M3_DIAMETER_THREAD, h = zz/2);
        
    }
}