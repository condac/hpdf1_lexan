//
include <tunable_constants.scad>;
use <hpdf1_rear_cradle_universal.scad>
use <common_parts.scad>

//rearCradle();
translate([0,-64-4,11]) diffuser_mount();

winghole_dist = 29;
diffuserhole_from_wingplate = 5;

module diffuser_mount() {
    
    
    difference() {
        union() {
            
            hull() {
                
                translate([0,-diffuserhole_from_wingplate,0]) cylinder(d=8, h=3);
                translate([winghole_dist/2,-1,0]) cube([1,1,3]);
                translate([-winghole_dist/2,-1,0]) cube([1,1,3]);
            }
            hull() {
                
                translate([-winghole_dist/2,0,5]) rotate([90,0,0])cylinder(d=8, h=2);
                //translate([winghole_dist/2,-2,0]) cube([1,2,2]);
                translate([-15,-2,0]) cube([10,2,2]);
            }
            hull() {
                
                translate([winghole_dist/2,0,5]) rotate([90,0,0])cylinder(d=8, h=2);
                //translate([winghole_dist/2,-2,0]) cube([1,2,2]);
                translate([5,-2,0]) cube([10,2,2]);
            }
        }
        all_screws();
        %all_screws();
    }
}

module all_screws() {
    translate([-winghole_dist/2,-3,5]) rotate([-90,0,0]) common_button_screw_tap(l = 12, l2=3);
    translate([winghole_dist/2,-3,5]) rotate([-90,0,0]) common_button_screw_tap(l = 12, l2=3);
    translate([0,-diffuserhole_from_wingplate,0]) common_button_screw_tap(l = 12, l2=3);;
}