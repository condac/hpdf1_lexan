//
use <lexan_nose.scad>
$fs=0.1;

caster = 4;
camber = 2;

kingpin_d = 3.5;

space = 19; // mellanrummet inuti hubben

m3_d = 3; // hål som en skruv inte ska fästa i
m3_d_s = 2.8; // hål som skruven ska skapa gängor i

color("red")%nose_p();
translate([0,240,0]) % union() {
    upper_arm();
    mirror([1,0,0]) upper_arm(); 


    lower_arm();
    mirror([1,0,0]) lower_arm();

    color("yellow") arm_plate();
    color("green") translate([0,-115,30]) upper_arm_plate_p();
}

translate([-62,240-25,23]) caster_p();
caster_p();

 rotate([0,0,180]) translate([-90, 275, -20])  %import("ref/testhub.stl", convexity=10);
 rotate([0,0,180+45]) translate([-90, 275, -20])  %import("ref/testhub.stl", convexity=10);
 rotate([0,0,180-30]) translate([-90, 275, -20])  %import("ref/testhub.stl", convexity=10);
module caster_p() {
    difference() {
        union() {
            hull() {
                translate([0,-1,space/2]) cylinder(d=10, h=3);
                translate([0,-15/2,space/2]) cube([10,15,3]);
            }
            hull() {
                translate([0,1,-space/2-3]) cylinder(d=10, h=3);
                translate([0,-15/2,-space/2-3]) cube([10,15,3]);
            }
            
            hull() {
                translate([10+2.5, 0, space/2-3]) cylinder(d=8, h=3);
                translate([10+2.5+5, -12, space/2-3]) cylinder(d=8, h=3);
            }
            hull() {
                translate([10,15/2-10,-space/2]) cube([1,10,space]);
            
                translate([10+2.5,0,-space/2]) cylinder(d=8, h=space);
            }
        }
        rotate([0,camber,0]) rotate([caster,0,0]) translate([0,0,-50]) cylinder(d=kingpin_d, h = 100);
        %rotate([0,camber,0]) rotate([caster,0,0]) translate([0,0,-50]) cylinder(d=kingpin_d, h = 100);
        
        translate([10+2.5,0,-space/2-10]) cylinder(d=m3_d_s, h=space+50);
        
        translate([-25, 10, -25]) rotate([0,0,-10]) cube([50,50,50,]);
    }
}
module caster_rod() {

    rotate([0,camber,0]) rotate([caster,0,0]) translate([0,0,-50]) cylinder(d=kingpin_d, h = 100);
    //%rotate([0,camber,0]) rotate([caster,0,0]) translate([0,0,-50]) cylinder(d=kingpin_d, h = 100);
        

}
caster_rod();

module caster_visual() {
    
     rotate([0,0,180]) translate([-90, 275, -20])  %import("ref/testhub.stl", convexity=10);
 rotate([0,0,180+45]) translate([-90, 275, -20])  %import("ref/testhub.stl", convexity=10);
 rotate([0,0,180-30]) translate([-90, 275, -20])  %import("ref/testhub.stl", convexity=10);
}