// file for viewing parts when edit
include <tunable_constants.scad>;

use <lexan_main-chassie.scad>
use <lexan_nose.scad>
use <lexan_side_stab.scad>
use <caster_hub.scad>
use <wingadapter.scad>
use <common_parts.scad>

$fs = 0.5;
$fa = 5.1;

adapter_d1 = 21; // diameter of the servo adapter
adapter_d2 = 9; // diameter of the servo adapters small hole

adapter_hole_x = 14.2/2; // the distance from center of the mounting screw hole in the servo adapter
adapter_hole_y = 0;


link_y = 17.6; // distance from rotating center of servo to steering link mounting
link_dist = 9; // distance between the 2 holes for the steering linkage


hole_d2 = 6;

link_h = 5; // height of material where the link is


arm_h = 3.5; // Height of the material where the mounting is


arm_w = 3; // width of the material designed to break, as servo saving feature

translate([0, 0, 0]) servo_arm_p();

module servo_arm_p() {
    difference() {
        union() {

            cylinder(d=adapter_d1, h=arm_h);

            hull() {
                translate([adapter_hole_x, 0, 0]) cylinder(d=hole_d2, h=arm_h);
                translate([-adapter_hole_x, 0, 0])  cylinder(d=hole_d2, h=arm_h);
            }
            hull() {
                translate([adapter_hole_x, 0, 0]) cylinder(d=arm_w, h=arm_h);
                translate([link_dist/2, link_y, 0])  cylinder(d=arm_w, h=arm_h);
            }
            hull() {
                translate([-adapter_hole_x, 0, 0]) cylinder(d=arm_w, h=arm_h);
                translate([-link_dist/2, link_y, 0])  cylinder(d=arm_w, h=arm_h);
            }
            
            hull() {
                translate([link_dist/2, link_y, 0]) cylinder(d=hole_d2, h=link_h);
                translate([-link_dist/2, link_y, 0])  cylinder(d=hole_d2, h=link_h);
            }

           
        }
        allScrews();

        hull() {
            translate([0, 0, 0]) cylinder(d=adapter_d2, h=arm_h);
            translate([0, -100, 0]) cylinder(d=adapter_d2, h=arm_h);
        }
        hull() {
            translate([0, 0, 0]) cylinder(d=adapter_d2+1, h=1);
            translate([0, -100, 0]) cylinder(d=adapter_d2+1, h=1);
        }
        hull() {
            translate([0, 0, 0]) cylinder(d=adapter_d2+1.5, h=0.3);
            translate([0, -100, 0]) cylinder(d=adapter_d2+1.5, h=0.3);
        }

    }
}

%allScrews();
module allScrews() {


    translate([adapter_hole_x, 0, 0]) common_button_screw_tap(l =10, l2=0);
    translate([-adapter_hole_x, 0, 0]) common_button_screw_tap(l =10, l2=0);
    translate([0, adapter_hole_x, 0]) common_button_screw_tap(l =10, l2=0);
    translate([0, -adapter_hole_x, 0]) common_button_screw_tap(l =10, l2=0);
    translate([link_dist/2, link_y, 0]) common_button_screw_tap(l =10, l2=0);
    translate([-link_dist/2, link_y, 0]) common_button_screw_tap(l =10, l2=0);
}


module torus(dd=1, wall=1, hh=1) {
        difference() {
            cylinder(d=dd, h=hh);
            cylinder(d=dd-wall*2, h=hh);
        }
    
}

 %visualHelp();
module visualHelp() {

    nose_plate_p();

    color("red")nose_p();


}