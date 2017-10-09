// file for viewing parts when edit

// M4 stång längd 170mm


use <lexan_main-chassie.scad>
use <lexan_nose.scad>
use <lexan_side_stab.scad>
use <caster_hub.scad>
use <wingadapter.scad>
use <hpdf1_rear_cradle_universal.scad>
include <tunable_constants.scad>;

use <MCAD/involute_gears.scad>


target_width = 188;

threaded_rod = target_width-21;
axle_rod_length = target_width-26-26-4.5-9-2-1; // Length of the carbonfiberrod or other axle material. 
echo("Carbon axle lenght to cut:",axle_rod_length);
echo("M4 threaded rod lenght to cut:",threaded_rod);
axle_d = C_8MM_TIGHT;

axle_bearing_h = 4;

// Diffplate
plate_d1 = 28.3; // outer diameter
plate_d2 = 15; // inner diameter
plate_h = 1.5; // thickness

plate_wall = 1.2*2; // thickness of the wall that hold the washer plate in place, make it a multiple of your nozzle size for best result
ball_d = 3.175;
ball_extra_hole = 0.5; // extra diameter for printed gear holes
ball_printed_d = ball_d + ball_extra_hole;
//rubber sealing
seal_d1 = 25;
seal_d2 = 16;
seal_h = 2;

// wheel hex mount
wheel_hex = 16.2;

//drive clearence
drive_clear = 0.2; // the distance between the gear and the outer rim that hold the plate in place
cone_end= 1;

gear_id = 9.4;
gear_adapter_d = 8.8;

%rearCradle();

// rear axle
ra_z = 24;
ra_y = -53;

// cradle offsets
mm_x = 22; // Cradle inner offset from car center UPDATE FROM CRADLE DRAwING IF IT HAS CHANGED
cradle_wall = 7; // Cradle thickness on motormount + space for washer UPDATE FROM CRADLE DRAwING IF IT HAS CHANGED

gear_center = mm_x+14.5; // mm_x + 13

// Printed gear parametsers
gear_pitch = 180;

// Splines for glue to flow through
splines = axle_d + 0.5;


//rear_axle_assembly();
translate([190/2, -80,0]) cube([5,10,50]) ;
rear_axle_assembly();

module rear_axle_assembly() {
    translate([0,ra_y,ra_z]) rotate([0,90,0]) union() {
        %translate([0,0,target_width/2-26-4.5])rotate([0,180,0]) carbon_axle();
        translate([0,0,gear_center-0.5]) cylinder(d=40, h=1); // visual gear    
        translate([0,0,gear_center]) color("cyan") balls();
        translate([0,0,gear_center]) color("green") diff_plates();
        translate([0,0,gear_center]) color("black") sealings();
        translate([0,0,gear_center]) indrive_p();
        translate([0,0,gear_center]) outdrive_p();
        translate([0,0,target_width/2-26]) wheel();
        rotate([0,180,0]) translate([0,0,target_width/2-26]) wheel();
        rotate([0,180,0]) translate([0,0,target_width/2-26]) left_wheelmount_visual();
        
        // mounting screws etc
        //right
        translate([0,0,target_width/2-26+1 ])rotate([0,0,0]) cylinder(d=12, h=1); //washer
        translate([0,0,target_width/2-26+1+1 ])rotate([0,0,0]) cylinder(d=9, h=axle_bearing_h); //bearing
        translate([0,0,target_width/2-26+1+1+axle_bearing_h ])rotate([0,0,0]) cylinder(d=7, h=5, $fn=6); // locknut
        translate([0,0,target_width/2-26+1+1+axle_bearing_h+5 ])rotate([0,0,20]) cylinder(d=7, h=5, $fn=6); // locknut
        //left
        rotate([0,180,0]) translate([0,0,target_width/2-26+1 ])rotate([0,0,0]) cylinder(d=12, h=1); //washer
        rotate([0,180,0]) translate([0,0,target_width/2-26+1+1 ])rotate([0,0,0]) cylinder(d=7, h=5, $fn=6); // locknut
        rotate([0,180,0])translate([0,0,target_width/2-26+1+1++5 ])rotate([0,0,20]) cylinder(d=7, h=5, $fn=6); // locknut
        
    }
}

module carbon_axle() {
    
    cylinder(d=8, h=axle_rod_length);
    translate([0,0,-22]) cylinder(d=4, h=threaded_rod);
}

module balls() {
    
    for (a =[0:260/8:360]) {
        rotate([0,0,a]) translate([23/2,0,0]) sphere(d=ball_d);
    }
    
}
module diff_plates() {
    translate([0,0,-ball_d/2-plate_h]) diff_plate();
    translate([0,0,+ball_d/2]) diff_plate();
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
    translate([0,0,-ball_d/2-plate_h-seal_h]) seal();
    translate([0,0,+ball_d/2+plate_h]) seal();
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
indrive_p();
module indrive_p() {
    _startpoint = -gear_center+mm_x+cradle_wall+0;
    hh = abs(_startpoint)-drive_clear-ball_d/2;
    
    difference() {
        union() {
            translate([0,0,_startpoint]) cylinder(d1=plate_d1+plate_wall-2,  d2=plate_d1+plate_wall, h= 2);
            translate([0,0,_startpoint+2]) cylinder(d=plate_d1+plate_wall, h= hh-2-cone_end);
            translate([0,0,_startpoint+2+hh-2-cone_end]) cylinder(d1=plate_d1+plate_wall, d2= plate_d1+0.8, h= cone_end);
            //translate([0,0,_startpoint+2+hh-2]) cylinder(d=gear_id, h=ball_d);
        }
        
        //seal cut
        translate([0,0,-ball_d/2-plate_h-seal_h]) seal_cut();
        
        //diffplate cut
        translate([0,0,-ball_d/2-plate_h-seal_h/4]) diff_plate_cut();
        
        // axle cut
        translate([0,0,_startpoint]) cylinder(d=axle_d, h=hh+20);
        
        // drive clear
        //translate([0,0,_startpoint+hh-drive_clear]) cylinder(d=50, h=drive_clear);
        
        //splines
        translate([0,0,_startpoint]) cylinder(d=splines, h=hh, $fn=4);
        translate([0,0,_startpoint]) rotate([0,0,45]) cylinder(d=splines, h=hh, $fn=4);
        translate([0,0,_startpoint+hh/2]) rotate([0,0,45]) cylinder(d=splines, h=0.3);
    }
    // seal inner fix
    translate([0,0,-ball_d/2-plate_h-seal_h-0.3]) seal_fix();
    
    
    
}

outdrive_p();
module outdrive_p() {
    _startpoint = -gear_center+mm_x+cradle_wall+0.5;

    hh = target_width/2 -26 - gear_center-1.5 -drive_clear;
    
    difference() {
        union() {
            translate([0,0,ball_d/2+drive_clear]) cylinder(d2=plate_d1+plate_wall, d1= plate_d1+0.8, h= cone_end);
            translate([0,0,ball_d/2+drive_clear+cone_end]) cylinder(d=plate_d1+plate_wall, h= plate_h+seal_h+2-cone_end);
            translate([0,0,ball_d/2+drive_clear+plate_h+seal_h+2]) cylinder(d1=plate_d1+plate_wall, d2= wheel_hex-2 , h= 12);
            translate([0,0,ball_d/2+drive_clear+plate_h+seal_h+2+5]) cylinder(d=wheel_hex, h=hh - (plate_h+seal_h+2+5) , $fn=6);
        }
        
        //seal cut
        translate([0,0,+ball_d/2+plate_h+seal_h]) rotate([180,0,0]) seal_cut();
        
        //diffplate cut
        translate([0,0,+ball_d/2+plate_h+seal_h/4]) rotate([180,0,0]) diff_plate_cut();
        
        // axle cut
        translate([0,0,_startpoint]) cylinder(d=C_8MM_LOOSE, h=100);
        
        // inner bearing
        translate([0,0,ball_d/2]) cylinder(d=C_12MM_BEARING_D, h=C_12MM_BEARING_H+drive_clear+(C_12MM_BEARING_H-ball_d)+1.5 );
        translate([0,0,ball_d/2]) cylinder(d=C_12MM_BEARING_D+0.5, h=(C_12MM_BEARING_H-ball_d)+1.5 );
        // outer bearing
        translate([0,0,ball_d/2+hh-0.5 - C_12MM_BEARING_H*2]) cylinder(d=C_12MM_BEARING_D, h=C_12MM_BEARING_H*2+1+3);
        
        // drive clear
        //translate([0,0,ball_d/2]) cylinder(d=50, h=drive_clear);
        
    }
    // seal inner fix
    translate([0,0,+ball_d/2+plate_h+seal_h]) seal_fix();
    
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

module left_wheelmount_p() {
    hh = 22;
    wall = 2; //wall between nut and wheelrim
    nut_h = 9.5/2;
    wheel_hex_h = 14;
    
    shim = 2;
    
    difference() {
        union() {
            translate([0,0,-wheel_hex_h]) rotate([0,0,0])cylinder(d=wheel_hex, h=wheel_hex_h-1, $fn=6);
            translate([0,0,-1]) rotate([0,0,0])cylinder(d1=wheel_hex, d2=wheel_hex-2, h=1, $fn=6);
            translate([0,0,-hh]) rotate([0,0,0])cylinder(d=wheel_hex, h=hh-wheel_hex_h );
            translate([0,0,-hh-shim]) rotate([0,0,0])cylinder(d2=wheel_hex, d1=10, h=shim );
        }
        translate([0,0,-nut_h-wall-1])cylinder(d=C_M4_NUT, h=nut_h+1, $fn=6);
        translate([0,0,-hh-wall-nut_h]) cylinder(d=C_8MM_FIT, h=hh);
        
        // M4 cut
        translate([0,0,-hh]) cylinder(d=C_M4_DIAMETER, h=hh+2);
    }
}

module left_wheelmount_visual() {
    
    color("red") difference() {
        translate([0,0,0]) left_wheelmount_p();
        translate([-100,0.1,-100]) cube(200);
        
    }
    
    
}

module gear_adapter_p() {
    //gear_id = 9.8;
    //gear_adapter_d = 8.1;
    
    difference() {
        cylinder(d=gear_id, h=4);
        cylinder(d=gear_adapter_d, h=4);
    }
}
translate([0,0,-20])spur_gear_p();

module spur_gear_p() {
    thickness = 2.5;
    difference() {
       translate([0,0,0]) gear (
            number_of_teeth=40, 
            circular_pitch=gear_pitch, 
            pressure_angle = 20,
            gear_thickness = 6,        
            rim_thickness = 6);
        //translate([0,0,-14]) import("ref/Spur_Gear.stl", convexity=10);
        cylinder(d=C_12MM_BEARING_D, h=50);
        translate([0,0,thickness]) cylinder(d=33, h=50);
        
        for (a =[0:360/8:360]) {
            rotate([0,0,a]) translate([23/2,0,0]) cylinder(d=ball_printed_d, h=50);
        }
        
    }

}

translate([0,0,-40])pinion_gear_p(tt =14);

module pinion_gear_p(tt = 18) {
    thickness = 2.8;
    motor_shaft = 3.17+0.4;
    nut_h = 2.6;
    
    difference() {
        union() {
            translate([0,0,0]) gear (
            number_of_teeth=tt, 
            circular_pitch=gear_pitch, 
            pressure_angle = 20,
            gear_thickness = 6,
            rim_thickness = 6,
            hub_thickness = 6);
            translate([0,0,6])cylinder(d=15, h=13-6);
            cylinder(d=10, h=13+5);
            
            translate([0,0,7])cylinder(d=16, h=5);
        }
       
        //translate([0,0,-14]) import("ref/Spur_Gear.stl", convexity=10);
        // grubsrkuv
        translate([0,0,6+3]) rotate([90,0,0]) cylinder(d=C_M3_DIAMETER_THREAD, h=50);
        
        hull() {
            translate([0, -motor_shaft/2-0.8, 6+3-1.5]) rotate([90,0,0]) rotate([0,0,90]) cylinder(d=C_M3_NUT, h=nut_h, $fn=6);
            translate([0, -motor_shaft/2-0.8, 6+3+10]) rotate([90,0,0]) rotate([0,0,90]) cylinder(d=C_M3_NUT, h=nut_h, $fn=6);
        }
        
        
        translate([0,0,-1]) cylinder(d=motor_shaft, h=50);
        
        
        
    }

}
//%translate([-115, -67, -93])  rotate([0,-90,-90]) import("ref/Cradle.stl", convexity=10);