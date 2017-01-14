// This will batch generate all stl files for the make all command. Rotate to print direction

use <lexan_main-chassie.scad>
use <lexan_nose.scad>
use <lexan_side_stab.scad>

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

module lower_arms() {
    lower_arm();
    translate([-80,-100,0]) rotate([0,0,180]) lower_arm();
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
//side_stab_x2();