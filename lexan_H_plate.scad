// This will batch generate all stl files for the make all command. Rotate to print direction

use <lexan_main-chassie.scad>
use <lexan_nose.scad>
use <lexan_side_stab.scad>

$fs=0.5;
//%translate([-115, -67, -93])  rotate([0,-90,-90]) import("ref/Cradle.stl", convexity=10);

color("green") side_spring_plate_p();


color("lightblue")main_chassie_p();

battery_plate_p();


translate([0,0,5]) side_stab_p();
h_plate_p();
module h_plate_p() {
    difference() {
        union() {
            translate([-30/2, -2,0]) cube([30,2,10]);
            translate([-10/2, -20,0]) cube([10,20,1]);
        }
        translate([-20/2, 0,5]) rotate([90,0,0]) cylinder(d=3, h=10);
        translate([20/2, 0,5]) rotate([90,0,0]) cylinder(d=3, h=10);
    }
}