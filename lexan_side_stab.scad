// file for viewing parts when edit

use <lexan_main-chassie.scad>
use <lexan_nose.scad>

%translate([-115, -67, -93])  rotate([0,-90,-90]) import("ref/Cradle.stl", convexity=10);

color("green") side_spring_plate_p();


color("lightblue")main_chassie_p();

battery_plate_p();


translate([0,0,5]) side_stab_p();

module side_stab_p() {
    
    
    $fs=0.1;
    
    s_x1 = 36;
    s_x2 = 50;
    s_z = 7;
    
    
    difference() {
        union() {
            translate([s_x1,-8,-s_z/2]) cube([5,10,s_z]);
            translate([s_x1,0,-s_z/2]) cube([s_x2-s_x1,5,s_z]);
            hull() {
                translate([s_x2,  60 , -s_z/2]) cube([3,6,s_z]);
                translate([s_x2,  0 , -s_z/2]) cube([2,10,s_z]);
            }
        }
        translate([s_x1-1,-4,0])rotate([0,90,0]) cylinder(d=3, h=10);
        translate([s_x2-1,62,0])rotate([0,90,0]) cylinder(d=3, h=10);
    }
}

module side_stab2_p() {
    
    
    $fs=0.1;
    
    s_x1 = 53;
    s_x2 = 53;
    s_z = 7;
    
    
    difference() {
        union() {
            translate([s_x1,-8,-s_z/2]) cube([2,10,s_z]);
            translate([s_x1,0,-s_z/2]) cube([s_x2-s_x1,5,s_z]);
            hull() {
                translate([s_x2,  61 , -s_z/2]) cube([2,6,s_z]);
                translate([s_x2,  0 , -s_z/2]) cube([2,10,s_z]);
            }
        }
        translate([s_x1-1,-4,0])rotate([0,90,0]) cylinder(d=3, h=10);
        translate([s_x2-1,63,0])rotate([0,90,0]) cylinder(d=3, h=10);
    }
}