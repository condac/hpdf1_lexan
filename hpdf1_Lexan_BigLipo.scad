// file for viewing parts when edit

use <biglipo_main-chassie.scad>
use <biglipo_nose.scad>
use <lexan_side_stab.scad>
use <caster_hub.scad>
use <wingadapter.scad>
use <frontwing.scad>
use <rear_axle.scad>
use <hpdf1_rear_cradle_universal.scad>
use <custom_spring.scad>


 side_spring_plate_p();

//nose_plate_p();
color("lightblue")biglipo_main_chassie_p();

biglipo_battery_plate_p();

//color("yellow")receiver_plate_p();

rear_axle_assembly();

long_extra = 6;
//color("red")nose_p();

//translate([-3,0,7]) side_stab2_p();
//translate([3,0,7]) mirror([1,0,0]) side_stab2_p();
//color("green")bigLipo();

module bigLipo() {
     //139*47*25mm
    x = 47+1;
    y = 139 +1;
    z = 26;  // ett halvsullet blir upp till 30, ett normalt använt 28, 26mm nyskick;
    translate([-x/2,6.5,2]) cube([x, y, z]);
}

translate([0,240+long_extra-1,0]) union() {
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
translate([0, -10, 36])rear_spring_p();
//190mm limit
translate([190/2, -80,0]) cube([5,10,50]) ;
translate([-190/2-5, -80,0]) cube([5,10,50]) ;