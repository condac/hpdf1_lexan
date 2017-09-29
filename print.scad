// This will batch generate all stl files for the make all command. Rotate to print direction

use <lexan_main-chassie.scad>
use <lexan_nose.scad>
use <lexan_nose_legacy.scad>
use <lexan_side_stab.scad>
use <lexan_steering_hub.scad>
use <bodyposts.scad>
use <wingadapter.scad>
use <hpdf1_rear_cradle_universal.scad>
use <frontwing.scad>
use <rear_axle.scad>
use <custom_spring.scad>
use <custom_steering_link.scad>
use <side_damper.scad>
use <front_body.scad>


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

module legacy_body_battery_plate() { 
    legacy_body_battery_plate_p();
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
     translate([10,-8,0])rotate([0,90,0])side_stab2_p();
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
//skid_guard();
module skid_guard() {
    rotate([180,0,0])skid_guard_p();
    
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

//plastic_rear_spring();
module plastic_rear_spring() {
    
    rotate([0,0,0]) rear_spring_p();
}

module plastic_rear_spring_3() {
    
    rotate([0,0,0]) rear_spring_p(spring_h=3);
}
module plastic_rear_spring_4() {
    
    rotate([0,0,0]) rear_spring_p(spring_h=4);
}
module plastic_rear_spring_5() {
    
    rotate([0,0,0]) rear_spring_p(spring_h=5);
}
module plastic_rear_spring_6() {
    
    rotate([0,0,0]) rear_spring_p(spring_h=6);
}
module plastic_rear_spring_7() {
    
    rotate([0,0,0]) rear_spring_p(spring_h=7);
}
module plastic_rear_spring_8() {
    
    rotate([0,0,0]) rear_spring_p(spring_h=8);
}
module plastic_rear_spring_9() {
    
    rotate([0,0,0]) rear_spring_p(spring_h=9);
}
module plastic_rear_spring_10() {
    
    rotate([0,0,0]) rear_spring_p(spring_h=10);
}

//steering_link();
module steering_link() {
     steering_link_p();
     translate([8,,0]) steering_link_p();
}
//gear_adapter();
module gear_adapter() {
    
    gear_adapter_p();
}
//wingelement();
module wingelement() {
    rotate([90,0,0]) wingelement_p();
    translate([0,-20,0])  rotate([0,0,180]) mirror([1,0,0]) rotate([90,0,0]) wingelement_p();
}

module spur_gear() {
    
    spur_gear_p();
}
module pinion_gear_18t() {
    
    pinion_gear_p(tt=18);
}
module pinion_gear_17t() {
    
    pinion_gear_p(tt=17);
}
module pinion_gear_16t() {
    
    pinion_gear_p(tt=16);
}
module pinion_gear_15t() {
    
    pinion_gear_p(tt=15);
}
//side_damper();
module side_damper() {
    side_damp_in_p();
    translate([0,10,0])  side_damp_out_p();
}
module legacy_nose_body_mount_plate() {
    
    legacy_nose_body_mount_plate_p();
}
module legacy_body_mount_plate() {
    
    legacy_body_mount_plate_p();
}

module legacy_nose() {
    
    legacy_nose_p();
}

module front_body_broken() {
    front_body_p();
}

module front_mount() {
    front_mount_p();
}