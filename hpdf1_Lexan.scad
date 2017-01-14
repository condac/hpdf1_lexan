// file for viewing parts when edit

use <lexan_main-chassie.scad>
use <lexan_nose.scad>
use <lexan_side_stab.scad>

color("green") side_spring_plate_p();

nose_plate_p();
color("lightblue")main_chassie_p();

battery_plate_p();

color("yellow")receiver_plate_p();


color("red")nose_p();

translate([0,0,4]) side_stab_p();
translate([0,0,4]) mirror([1,0,0]) side_stab_p();

translate([0,240,0]) union() {
    upper_arm();
    mirror([1,0,0]) upper_arm(); 


    lower_arm();
    mirror([1,0,0]) lower_arm();

    color("yellow") arm_plate();
    color("green") translate([0,-115,30]) upper_arm_plate_p();
}

//body post

//translate([70/2,240-2-180,0]) cylinder (d=5, h=50);
//translate([-70/2,240-2-180,0]) cylinder (d=5, h=50);