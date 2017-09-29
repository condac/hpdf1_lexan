use <lexan_main-chassie.scad>;
use <caster_hub.scad>;
use <common_parts.scad>
include <tunable_constants.scad>;
use <lexan_nose_legacy.scad>

//basefornewnose
//%translate([28, -60, 0])  rotate([0,0,180]) import("basefornewnose.stl", convexity=10);

// main-chassie
//translate([-62,240-25,23]) %caster_p();
%translate([28, -65, 0])  rotate([0,0,180]) import("ref/main.stl", convexity=10);

 %translate([-0, -28, 0]) rotate([-90,0,0]) translate([-125, -150, 0])   import("ref/body.stl", convexity=10);

%translate([0, 115+10+10, 0]) rotate([-90,0,0]) translate([125, 80, 0]) rotate([0,0,180]) import("ref/FrontBody.stl", convexity=10);
//%main_chassie_p();



//front_body_p();
 cuts();
module front_body_p() {
    difference() {
        translate([0, 115+10+10, 0]) rotate([-90,0,0]) translate([125, 80, 0]) rotate([0,0,180]) import("ref/FrontBody.stl", convexity=10);
        
        cuts();
    }
}
    
module cuts() {
    
    legacy_nose_p();
    armcuts();
    mirror([1,0,0]) armcuts();
}
module armcuts() {
    hull() {
        translate([0,240,0]) lower_arm();
        translate([0,240,-50]) lower_arm();
    }
    translate([0,240,0]) upper_arm();
    translate([0,240,-4]) upper_arm();
    translate([0,240,-4-4]) upper_arm();
    hull() {
        translate([0,240,-4-4]) upper_arm();
        translate([0,240,-4-4-50]) upper_arm();
    }
    translate([0,240,-4-4]) upper_arm();
}