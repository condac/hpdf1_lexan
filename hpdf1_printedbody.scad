// file for viewing parts when edit

use <lexan_main-chassie.scad>
use <lexan_nose.scad>
use <lexan_side_stab.scad>
use <caster_hub.scad>
use <wingadapter.scad>
use <frontwing.scad>
use <rear_axle.scad>
use <hpdf1_rear_cradle_universal.scad>
include <tunable_constants.scad>;

 //translate([-0, -28, 0]) rotate([-90,0,0]) translate([-125, -150, 0])   import("ref/body.stl", convexity=10);

translate([0, 115+10+10, 0]) rotate([-90,0,0]) translate([125, 80, 0]) rotate([0,0,180]) import("ref/FrontBody.stl", convexity=10);
color("green") side_spring_plate_p();

nose_plate_p();
color("lightblue")main_chassie_p();

battery_plate_p();

color("yellow")receiver_plate_p();

rear_axle_assembly();

color("red")nose_p();

translate([-3,0,4]) side_stab2_p();
translate([3,0,4]) mirror([1,0,0]) side_stab2_p();

translate([0,240,0]) union() {
    upper_arm();
    mirror([1,0,0]) upper_arm(); 


    lower_arm();
    mirror([1,0,0]) lower_arm();
    translate([-63, -25, 25]) caster_visual();

    color("yellow") arm_plate();
    color("green") translate([0,-115,30]) upper_arm_plate_p();
    
    //%translate([0, -25.5, 10+4]) rotate([0,180,0]) wingadapter_p();
    translate([0, -25.5, 4+1+9.2]) rotate([0,180,0]) frontwing_p();
    translate([0, -25.5, 0]) rotate([0,0,0]) skid_guard_p();
}


//body post

//translate([70/2,240-2-180,0]) cylinder (d=5, h=50);
//translate([-70/2,240-2-180,0]) cylinder (d=5, h=50);
rearCradle();
//translate([-115, -67, -93])  rotate([0,-90,-90]) import("ref/Cradle.stl", convexity=10);

//190mm limit

 