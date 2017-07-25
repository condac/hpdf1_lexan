// file for viewing parts when edit
include <tunable_constants.scad>;

use <lexan_main-chassie.scad>
use <lexan_nose.scad>
use <lexan_side_stab.scad>
use <caster_hub.scad>
use <wingadapter.scad>
use <common_parts.scad>

link_length = 51;
link_h = 3;
link_d = 5;

mount_d= 6;
mount_h = 3;
mount_hole = 3.3;

translate([0, -10, 36])steering_link_p();

module steering_link_p() {
    difference() {
        union() {
            hull() {
                translate([0, 0, 0])cylinder(d=link_d, h=link_h);
                translate([0, link_length, 0])  cylinder(d=link_d, h=link_h);
            }

            
            translate([0, 0, 0]) cylinder(d=mount_d, h=mount_h);
            translate([0, link_length, 0]) cylinder(d=mount_d, h=mount_h);
        }
        allScrews();
    }
}

%allScrews();
module allScrews() {

            translate([0, 0, 0]) cylinder(d=C_M3_DIAMETER, h=mount_h);
            translate([0, link_length, 0]) cylinder(d=C_M3_DIAMETER, h=mount_h);
}


module torus(dd=1, wall=1, hh=1) {
        difference() {
            cylinder(d=dd, h=hh);
            cylinder(d=dd-wall*2, h=hh);
        }
    
}

 %visualHelp();
module visualHelp() {


%translate([92.5, 80, 35.5])  rotate([0,0,180]) import("ref/RearDamperMountCarbon.stl", convexity=10);

color("green") side_spring_plate_p();

//nose_plate_p();
color("lightblue")main_chassie_p();

battery_plate_p();






}