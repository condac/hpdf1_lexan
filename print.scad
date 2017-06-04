// This will batch generate all stl files for the make all command. Rotate to print direction

use <lexan_main-chassie.scad>
use <lexan_nose.scad>
use <lexan_side_stab.scad>
use <lexan_steering_hub.scad>
use <bodyposts.scad>
use <wingadapter.scad>
use <hpdf1_rear_cradle_universal.scad>
use <frontwing.scad>
use <rear_axle.scad>

param1=0;   // must be initalised
len=param1; // param1 passed via -D on cmd-line
echo(len,param1);

$fs = 0.5;
$fa = 5.1;


module side_spring_plate() { 
    side_spring_plate_p();
}


module nose_plate() { 
    nose_plate_p();
}

module main_chassie() { 
    main_chassie_p();
}


module battery_plate() { 
    battery_plate_p();
}


module receiver_plate() {
    receiver_plate_p();
}

module all() {
    cube(1);
}

module nose() {
    nose_p();
}


module upper_arms() {
    upper_arm();
    translate([-105,-88,0]) rotate([0,0,70]) mirror([1,0,0]) upper_arm(); //  
}
//lower_arms();
module lower_arms() {
    lower_arm();
    translate([-40,8,0]) rotate([0,0,130]) translate([-50,50,0])   mirror([1,0,0]) lower_arm();
}

module lower_arm_plate() {
    
    rotate([180,0,0]) arm_plate();
}

module upper_arm_plate() {
    upper_arm_plate_p();
}

module side_stab_x2() {
    side_stab_p();
    translate([8,-8,0])side_stab_p();
}
module side_stab2_x2() {
    rotate([0,90,0]) side_stab2_p();
     translate([8,-8,0])rotate([0,90,0])side_stab2_p();
}
//steering_hubs();
module steering_hubs() {
    steeringhubs_p();
    translate([14,00,0]) mirror([1,0,0]) steeringhubs_p();
}
//side_stab_x2();
//body_posts();
module body_posts() {
    translate([0,0,0]) body_post_p();
    translate([0,7,0]) body_post_p();
    translate([0,15,0]) body_post2_p();
}
//wind_adapter();
module wing_adapter() {
    wingadapter_p();
    
}
//arm_pin();
module arm_pin() {
    arm_pin_p();
    translate([0,8,0]) arm_pin_p();
}


// rear cradle

module cradle_bottomPlate() {
    bottomPlate();
    
}
module cradle_bottomPlate_wide() {
    bottomPlate(wide=50);
    
}
//cradle_leftBulkhead();
module cradle_leftBulkhead() {
    rotate([0,90,0]) leftBulkhead();
    
}
//cradle_rightBulkhead();
module cradle_rightBulkhead() {
    rotate([0,-90,0])rightBulkhead();
    
}

module cradle_wingPlate() {
    rotate([90,0,0])wingPlate();
    
}
//frontwing();
module frontwing() {
    rotate([180,0,0])frontwing_p();
    
}
module frontwingflex() {
    rotate([180,0,0])frontwingflex_p();
    
}
//translate([20,1,0]) indrive();
module indrive() {
    
    indrive_p();
}
//outdrive();
module outdrive() {
    
    rotate([180,0,0]) outdrive_p();
}
//left_wheelmount();
module left_wheelmount() {
    
    rotate([180,0,0]) left_wheelmount_p();
}

