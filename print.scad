// This will batch generate all stl files for the make all command. Rotate to print direction

use <lexan_main-chassie.scad>
use <lexan_nose.scad>
use <lexan_side_stab.scad>
use <lexan_steering_hub.scad>
use <bodyposts.scad>
use <wingadapter.scad>
param1=0;   // must be initalised
len=param1; // param1 passed via -D on cmd-line
echo(len,param1);




module side_spring_plate() { // `make` me"
    side_spring_plate_p();
}


module nose_plate() { // `make` me"
    nose_plate_p();
}

module main_chassie() { // `make` me"
    main_chassie_p();
}


module battery_plate() { // `make` me"
    battery_plate_p();
}


module receiver_plate() { // `make` me"
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