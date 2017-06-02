// file for viewing parts when edit

use <lexan_main-chassie.scad>
use <lexan_nose.scad>
use <lexan_side_stab.scad>
use <caster_hub.scad>
use <wingadapter.scad>
use <hpdf1_rear_cradle_universal.scad>
include <tunable_constants.scad>;



axle_rod_length = 135; // Length of the carbonfiberrod or other axle material. 
axle_d = 8.15;

// Diffplate
plate_d1 = 28.5; // outer diameter
plate_d2 = 15; // inner diameter
plate_h = 1.5; // thickness

plate_wall = 1.2*2; // thickness of the wall that hold the washer plate in place, make it a multiple of your nozzle size for best result

//rubber sealing
seal_d1 = 25;
seal_d2 = 16.5;
seal_h = 2;

// wheel hex mount
wheel_hex = 16.2;

//drive clearence
drive_clear = 0.5; // the distance between the gear and the outer rim that hold the plate in place


%rearCradle();

// rear axle
ra_z = 24;
ra_y = -53;

// cradle offsets
mm_x = 22; // UPDATE FROM CRADLE DRAVING IF IT HAS CHANGED
cradle_wall = 6; // UPDATE FROM CRADLE DRAVING IF IT HAS CHANGED

gear_center = mm_x+13; // mm_x + 13

//rear_axle_assembly();
translate([190/2, -80,0]) cube([5,10,50]) ;
rear_axle_assembly();

module rear_axle_assembly() {
    translate([0,ra_y,ra_z]) rotate([0,90,0]) union() {
        translate([0,0,-axle_rod_length/2])carbon_axle();
        translate([0,0,gear_center-0.5]) cylinder(d=40, h=1); // visual gear    
        translate([0,0,gear_center]) color("cyan") balls();
        translate([0,0,gear_center]) color("green") diff_plates();
        translate([0,0,gear_center]) color("black") sealings();
        translate([0,0,gear_center]) indrive_p();
        translate([0,0,gear_center]) outdrive_p();
        translate([0,0,axle_rod_length/2]) wheel();
        rotate([0,180,0]) translate([0,0,axle_rod_length/2]) wheel();
    }
}

module carbon_axle() {
    
    cylinder(d=8, h=axle_rod_length);
    translate([0,0,-20]) cylinder(d=4, h=axle_rod_length+40);
}

module balls() {
    
    for (a =[0:260/8:360]) {
        rotate([0,0,a]) translate([23/2,0,0]) sphere(d=3.1);
    }
    
}
module diff_plates() {
    translate([0,0,-1.5-plate_h]) diff_plate();
    translate([0,0,+1.5]) diff_plate();
}
module diff_plate() {
    
    difference() {
        cylinder(d= plate_d1, h=plate_h);
        translate([0,0,-0.5]) cylinder(d= plate_d2, h=plate_h+1);
    }
}
module diff_plate_cut() {
    
    difference() {
        cylinder(d= plate_d1, h=20);
        translate([0,0,-0.5]) cylinder(d= plate_d2, h=20+1);
    }
}

module sealings() {
    translate([0,0,-1.5-plate_h-seal_h]) seal();
    translate([0,0,+1.5+plate_h]) seal();
}
module seal() {
    
    difference() {
        cylinder(d= seal_d1, h=seal_h);
        translate([0,0,-0.5]) cylinder(d= seal_d2, h=seal_h+1);
    }
}

module seal_cut() {
    
    difference() {
        cylinder(d= seal_d1, h=20);
        translate([0,0,-0.5]) cylinder(d= seal_d2, h=20+1);
    }
}
//indrive_p();
module indrive_p() {
    _startpoint = -gear_center+mm_x+cradle_wall+0.5;
    hh = abs(_startpoint)-1.5;
    
    difference() {
        union() {
            translate([0,0,_startpoint+2]) cylinder(d=plate_d1+plate_wall, h= hh-2);
            translate([0,0,_startpoint]) cylinder(d1=plate_d1+plate_wall-2,  d2=plate_d1+plate_wall, h= 2);
        }
        
        //seal cut
        translate([0,0,-1.5-plate_h-seal_h]) seal_cut();
        
        //diffplate cut
        translate([0,0,-1.5-plate_h-seal_h/3]) diff_plate_cut();
        
        // axle cut
        translate([0,0,_startpoint]) cylinder(d=axle_d, h=hh);
        
        // drive clear
        translate([0,0,_startpoint+hh-drive_clear]) cylinder(d=50, h=drive_clear);
    }
    // seal inner fix
    translate([0,0,-1.5-plate_h-seal_h]) seal_fix();
    
    
    
}

outdrive_p();
module outdrive_p() {
    _startpoint = -gear_center+mm_x+cradle_wall+0.5;

    hh = axle_rod_length/2 - gear_center-1.5 ;
    
    difference() {
        union() {
            translate([0,0,1.5]) cylinder(d=plate_d1+plate_wall, h= plate_h+seal_h+2);
            translate([0,0,1.5+plate_h+seal_h+2]) cylinder(d1=plate_d1+plate_wall, d2= wheel_hex-2 , h= 12);
            translate([0,0,1.5+plate_h+seal_h+2+5]) cylinder(d=wheel_hex, h=hh - (plate_h+seal_h+2+5) , $fn=6);
        }
        
        //seal cut
        translate([0,0,+1.5+plate_h+seal_h]) rotate([180,0,0]) seal_cut();
        
        //diffplate cut
        translate([0,0,+1.5+plate_h+seal_h/3]) rotate([180,0,0]) diff_plate_cut();
        
        // axle cut
        translate([0,0,_startpoint]) cylinder(d=axle_d+0.5, h=100);
        
        // inner bearing
        translate([0,0,1]) cylinder(d=C_12MM_BEARING_D, h=C_12MM_BEARING_H+drive_clear);
        // outer bearing
        translate([0,0,1.5+hh - C_12MM_BEARING_H]) cylinder(d=C_12MM_BEARING_D, h=C_12MM_BEARING_H);
        
        // drive clear
        translate([0,0,1.5]) cylinder(d=50, h=drive_clear);
        
    }
    // seal inner fix
    translate([0,0,+1.5+plate_h+seal_h]) seal_fix();
    
}

module seal_fix() {
    hh = 0.3;
    ww = 0.8;
    for (a =[0:360/8:360]) {
        rotate([0,0,a]) translate([seal_d2/2,-ww/2,-hh/2]) cube([seal_d1/2-seal_d2/2,ww,hh*2]);
    }
}

module wheel() {
    
    dd= 62;
    hh = 38;
    _offset = 12;
    
    difference() {
        translate([0,0,-_offset]) cylinder(d=dd, h=hh);
        translate([-100,0,-100]) cube(200);
        translate([0,0,1])cylinder(d=12, h=50);
        translate([0,0,0]) rotate([-180,0,0])cylinder(d=wheel_hex+0.5, h=50, $fn=6);
    }
    
}


%translate([-115, -67, -93])  rotate([0,-90,-90]) import("ref/Cradle.stl", convexity=10);