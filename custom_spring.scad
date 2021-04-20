// file for viewing parts when edit
include <tunable_constants.scad>;

use <lexan_main-chassie.scad>
use <lexan_nose.scad>
use <lexan_side_stab.scad>
use <caster_hub.scad>
use <wingadapter.scad>
use <common_parts.scad>
use <hpdf1_rear_cradle_universal.scad>
use <ref/spring.scad>


spring_length = 50;
spring_h = 5;
spring_wall = 0.8;
spring_ring_d= 20;

mount_d= 7;
mount_h = 3;
mount_hole = C_M3_DIAMETER;

translate([0, -10, 36])rear_spring_p();

module old_spring_p() {
    difference() {
        union() {
            hull() {
                translate([0, 0, 0]) rotate([0,0,0]) cylinder(d=mount_d, h=mount_h);
                translate([0, 6, 0]) rotate([0,0,0]) cylinder(d=mount_d, h=mount_h);
            }
            hull() {
                translate([0, spring_length, 0]) rotate([0,0,0]) cylinder(d=mount_d, h=mount_h);
                translate([0, spring_length-6, 0]) rotate([0,0,0]) cylinder(d=mount_d, h=mount_h);
            }
            
            translate([0, spring_length/2+spring_ring_d/2-spring_wall/2, 0]) torus(dd=spring_ring_d, wall=spring_wall, hh=spring_h);
            translate([0, spring_length/2-spring_ring_d/2+spring_wall/2, 0]) torus(dd=spring_ring_d, wall=spring_wall, hh=spring_h);
        }
        allScrews();
    }
}

%allScrews();
module allScrews() {

    translate([0, 0, 0]) rotate([0,0,0]) cylinder(d=C_M3_DIAMETER, h=spring_h);
    translate([0, spring_length, 0]) rotate([0,0,0]) cylinder(d=C_M3_DIAMETER, h=spring_h);
}


module torus(dd=1, wall=1, hh=1) {
        difference() {
            cylinder(d=dd, h=hh);
            cylinder(d=dd-wall*2, h=hh);
        }
    
}

 %visualHelp();
module visualHelp() {


//%translate([92.5, 80, 35.5])  rotate([0,0,180]) import("ref/RearDamperMountCarbon.stl", convexity=10);
rearCradle();
color("green") side_spring_plate_p();

//nose_plate_p();
color("lightblue")main_chassie_p();

battery_plate_p();

}

module rear_spring_p(spring_h=6) {
    difference() {
        union() {
            hull() {
                translate([0, 0, 0]) rotate([0,0,0]) cylinder(d=mount_d, h=mount_h);
                translate([0, 6, 0]) rotate([0,0,0]) cylinder(d=mount_d, h=mount_h);
            }
            hull() {
                translate([0, spring_length, 0]) rotate([0,0,0]) cylinder(d=mount_d, h=mount_h);
                translate([0, spring_length-6, 0]) rotate([0,0,0]) cylinder(d=mount_d, h=mount_h);
            }
            
            translate([0,spring_length/2-1,spring_h/2]) spring_square(fid=4, th=0.4*6, folds=6, lx=spring_ring_d, lz=spring_h, drill=0); // Här är fjädern!
            
            
        }
        allScrews();
    }
    
    
}