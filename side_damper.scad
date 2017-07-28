//
include <tunable_constants.scad>;
use <common_parts.scad>





damp_travel = 10; // travel lenght
damp_length = 46; // length from mounting screws
damp_wall = 2*2; // thickness of wall this is times 2 because a cylinder with 3 sides have half the radius;

tube_d = 5;
tube_gap = 0.4;

mount_h = 3;
fudge = 1/cos(180/3);


side_damp_in_p();
translate([0,0,-tube_gap/4-damp_wall/4]) side_damp_out_p();
%  all_screws();

module side_damp_in_p() {
    

    difference() {
        union() {
            translate([0,0,(tube_d/2)/fudge]) rotate([0,90,0]) rotate([0,0,120/2]) cylinder(d=tube_d, h=damp_length - damp_travel, $fn=3);
            
            cylinder(d=7, h=3);
        }
        
         all_screws();
    }
    
}

module side_damp_out_p() {
     translate([0,0,tube_gap/4+damp_wall/4]) difference() {
        union() {
            translate([damp_length-(damp_length-damp_travel),0,(tube_d/2)/fudge]) rotate([0,90,0]) rotate([0,0,120/2]) cylinder(d=tube_d+tube_gap+damp_wall, h=damp_length - damp_travel, $fn=3);
            
            translate([damp_length, 0, -tube_gap/4-damp_wall/4]) cylinder(d=7, h=mount_h);
        }
        translate([damp_length, 0, -tube_gap/4-damp_wall/4+mount_h]) cylinder(d=6, h=20);
        translate([0,0,(tube_d/2)/fudge]) rotate([0,90,0]) rotate([0,0,120/2]) cylinder(d=tube_d+tube_gap, h=damp_length-4, $fn=3);
        
        all_screws();
    }
}
module all_screws() {
    translate([0, 0, mount_h]) rotate([180,0,0]) common_button_screw_tap(l = 8);
    
    translate([damp_length, 0, mount_h-tube_gap/4-damp_wall/4]) rotate([180,0,0]) common_button_screw_tap(l = 8);
}