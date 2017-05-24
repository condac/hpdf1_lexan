// file for viewing parts when edit
include <tunable_constants.scad>;

use <lexan_main-chassie.scad>
use <lexan_nose.scad>
use <lexan_side_stab.scad>
use <caster_hub.scad>
use <wingadapter.scad>
use <common_parts.scad>


$fs=0.1;


br_x = 25;
bl_x = -40;
bf_y = -12;
br_y = -42;
//bottomplate front right screw coordinates
bfr_x = br_x;
bfr_y = bf_y;
//bottomplate front left screw coordinates
bfl_x = bl_x;
bfl_y = bf_y;
//bottomplate rear right screw coordinates
brr_x = br_x;
brr_y = br_y;
//bottomplate rear left screw coordinates
brl_x = bl_x;
brl_y = br_y;

//bottomplate constants
bp_h = 3;



// rear axle
ra_z = 24;
ra_y = -53;
ra_b_d = 15.5; // Bearing diameter for rear axle
ra_bt_d = ra_b_d-2; // Bearing diameter for rear axle slot so it dont fall through

// Motor mount
mm_x = 22;
mm_w = 5;
mm_max = -20; // screw mount place at maximum distance from axle
mm_min = -30; // screw mount place at minimum distance from axle
mm_screw_dist = 25;
mm_screw_d = 3.3;
mm_motor_d = 36;
mm_motor_z = mm_motor_d/2 +0.7;

// Left bulkhead
lb_x = -42;


// Sidemounts
//sm_x = 36; // change this to 36 for original narrow HPDF1. 50 for wider lexan version
sm_y = -4;
sm_z = 5;

// pivot ball
pivot_d = 6;
pivot_z = 5;
pivot_y = 8.5;

// rear damper mount
rdm_xr = 25.5;
rdm_xl = -40;
rdm_z  = 35.2;
rdm_y  = -9;


// rear wingplate screws
rwp_xr = 24.5;
rwp_xl = -40.5;
rwp_y  = -67;
rwp_z1 = 15;
rwp_z2 = rwp_z1+18;


rearCradle();

module rearCradle() {
    color("red") bottomPlate(wide= 50);
    leftBulkhead();
    rightBulkhead();
    pivotClamp();
    wingPlate();
}

module bottomPlate(wide= 36) {
    
    
    
    difference() {
        union() {
            hull() {
                translate([bfr_x, bfr_y, 0]) cylinder(d=8, h=bp_h);
                translate([bfr_x+6, bfr_y, 0]) cylinder(d=6, h=bp_h);
            }
            hull() {
                translate([bfr_x, brr_y, 0]) cylinder(d=8, h=bp_h);
                translate([bfr_x+6, brr_y, 0]) cylinder(d=6, h=bp_h);
            }
            hull() {
                translate([bfr_x+6, bfr_y, 0]) cylinder(d=6, h=bp_h);
                translate([bfr_x+6, brr_y, 0]) cylinder(d=6, h=bp_h);
            }
            
            hull() {
                translate([brr_x, brr_y, 0]) cylinder(d=8, h=bp_h);
                translate([brl_x, brl_y, 0]) cylinder(d=8, h=bp_h);
            }
            hull() {
                translate([bfl_x, bfl_y, 0]) cylinder(d=8, h=bp_h);
                translate([brl_x, brl_y, 0]) cylinder(d=8, h=bp_h);
            }
            hull() {
                translate([bfl_x, bfl_y-2, 0]) cylinder(d=8, h=bp_h);
                translate([bfl_x+8, bfl_y+3, 0]) cylinder(d=8, h=bp_h);
            }
            //Sidemount right
            hull() {
                translate([bfr_x+6, brr_y, 0]) cylinder(d=6, h=bp_h);
                translate([wide-3, sm_y, 0]) cylinder(d=6, h=bp_h);
                
            }
            
            //translate([bfr_x, bfr_y, 0]) cylinder(d=5, h=bp_h);
            //translate([bfl_x, bfl_y, 0]) cylinder(d=5, h=bp_h);
            //translate([brr_x, brr_y, 0]) cylinder(d=5, h=bp_h);
            //translate([brl_x, brl_y, 0]) cylinder(d=5, h=bp_h);
            
            
            
            //Sidemounts
            sidemount(sm_x = wide);
            mirror([1,0,0]) sidemount(sm_x = wide);
            
            //Pivot area
            translate([-wide,-1-10,0 ]) cube([wide*2, 10, bp_h]);
            translate([-10,-1-10,0 ]) cube([20, 10, pivot_z]);
        }
        //Pivot area
        translate([0, 0, pivot_z]) rotate([90,0,0]) cylinder(d=pivot_d, h=pivot_y);
        translate([0, -pivot_y, pivot_z]) rotate([90,0,0]) cylinder(d=pivot_d+2, h=pivot_y);
        // All screws
        allScrews();
    }
}
module sidemount(sm_x = 36) {
    mount_l = 20; // Lenght of the total screw length
    mount_d = 6;
    difference() {
        union() {
            hull() {
                translate([sm_x-mount_l,sm_y,sm_z]) rotate([0,90,0]) cylinder(d=mount_d, h=mount_l);
                translate([sm_x-mount_l,sm_y-mount_d/2,0]) cube([mount_l,mount_d,bp_h]);
            }
            translate([sm_x-8,sm_y,sm_z]) rotate([0,90,0]) cylinder(d=mount_d+2, h=8);
        }
        translate([sm_x-mount_l,sm_y,sm_z]) rotate([0,90,0]) cylinder(d=3, h=mount_l);
    }
}
module leftBulkhead() {
    
    difference() {
        union() {
            // Rear axle material
            hull() {
                translate([lb_x,ra_y,ra_z]) rotate([0,90,0]) cylinder(d=25, h=mm_w);
            }
            
            // Rear axle to lower mount material
            hull() {
                translate([lb_x,ra_y,ra_z]) rotate([0,90,0]) cylinder(d=25, h=mm_w);
                translate([lb_x,brl_y,bp_h+3+0.1]) rotate([0,90,0]) cylinder(d=6, h=mm_w);
            }
            // lower mount to lower mount material
            hull() {
                translate([lb_x,bfl_y,bp_h+3+0.1]) rotate([0,90,0]) cylinder(d=6, h=mm_w);
                translate([lb_x,brl_y,bp_h+3+0.1]) rotate([0,90,0]) cylinder(d=6, h=mm_w);
            }
            
            // damper to rear axle material
            hull() {
                translate([lb_x,bfl_y,rdm_z-6]) rotate([0,90,0]) cylinder(d=6, h=mm_w);
                translate([lb_x,ra_y,rdm_z-6]) rotate([0,90,0]) cylinder(d=6, h=mm_w);
            }
            
            // screw material
            translate([brl_x, brl_y, bp_h+0.1]) cylinder(d=6, h=10); // lower 
            translate([bfl_x, bfl_y, bp_h+0.1]) cylinder(d=6, h=10); // lower
            translate([rdm_xl, rdm_y, rdm_z]) rotate([180,0,0]) cylinder(d=9, h=9); // damper
                
            
            // rear damper mount + lower bulk mount front
            hull() {
                translate([lb_x, rdm_y-3, rdm_z-1]) cube([mm_w, 6, 1]);
                translate([lb_x, bfr_y-6, bp_h+0.1]) cube([mm_w, 6, 1]);
            }
            
            // rear wing mount
            translate([rwp_xl, rwp_y+3, rwp_z1]) rotate([-90,0,0]) cylinder(d=6, h=8);
            translate([rwp_xl, rwp_y+3, rwp_z2]) rotate([-90,0,0]) cylinder(d=6, h=8);
            
        }
        // All screws
        allScrews();
        
        //bearing cut
        translate([lb_x-1,ra_y,ra_z]) rotate([0,90,0]) cylinder(d=ra_b_d, h=mm_w);
        translate([lb_x+1,ra_y,ra_z]) rotate([0,90,0]) cylinder(d=ra_bt_d, h=mm_w);
        
        
        // rear wing mount
        hull() {
            translate([rwp_xl, rwp_y, rwp_z1]) rotate([-90,0,0]) cylinder(d=8, h=3);
            translate([rwp_xl, rwp_y, rwp_z2]) rotate([-90,0,0]) cylinder(d=8, h=3);
        }
        
        // flaten print side
        translate([lb_x+5, -100, 0])  cube([20, 200,100]);
    }
    
}

module rightBulkhead() {
    
    difference() {
        union() {
            // Rear axle material
            hull() {
                translate([mm_x,ra_y,ra_z]) rotate([0,90,0]) cylinder(d=25, h=mm_w);
            }
            //Motormount material
            hull() {
                translate([mm_x,mm_max,mm_motor_z-mm_screw_dist/2]) rotate([0,90,0]) cylinder(d=12, h=mm_w);
                translate([mm_x,mm_min,mm_motor_z-mm_screw_dist/2]) rotate([0,90,0]) cylinder(d=12, h=mm_w);
            }
            //Motormount material
            hull() {
                translate([mm_x,mm_max,mm_motor_z+mm_screw_dist/2]) rotate([0,90,0]) cylinder(d=12, h=mm_w);
                translate([mm_x,mm_min,mm_motor_z+mm_screw_dist/2]) rotate([0,90,0]) cylinder(d=12, h=mm_w);
            }
            
            //connecting material
            hull() {
                translate([mm_x,mm_min,mm_motor_z-mm_screw_dist/2]) rotate([0,90,0]) cylinder(d=12, h=mm_w);
                translate([mm_x,ra_y,ra_z]) rotate([0,90,0]) cylinder(d=25, h=mm_w);
            }
            //connecting material
            hull() {
                translate([mm_x,mm_min,mm_motor_z+mm_screw_dist/2]) rotate([0,90,0]) cylinder(d=12, h=mm_w);
                translate([mm_x,ra_y,ra_z]) rotate([0,90,0]) cylinder(d=25, h=mm_w);
            }
            // screw material
            translate([brr_x, brr_y, bp_h+0.1]) cylinder(d=6, h=10); // lower 
            translate([bfr_x, bfr_y, bp_h+0.1]) cylinder(d=6, h=10); // lower
            translate([rdm_xr, rdm_y, rdm_z]) rotate([180,0,0]) cylinder(d=9, h=9); // damper
                
            
            
            
            // rear damper mount + lower bulk mount front
            hull() {
                translate([mm_x, rdm_y-6, rdm_z-1]) cube([mm_w, 3+6, 1]);
                translate([mm_x, bfr_y-16, bp_h]) cube([mm_w, 16+2, 1]);
            }
            
            // rear wing mount
            translate([rwp_xr, rwp_y+3, rwp_z1]) rotate([-90,0,0]) cylinder(d=6, h=8);
            translate([rwp_xr, rwp_y+3, rwp_z2]) rotate([-90,0,0]) cylinder(d=6, h=8);
            
        }
        // All screws
        allScrews();
        
        //bearing cut
        translate([mm_x+1,ra_y,ra_z]) rotate([0,90,0]) cylinder(d=ra_b_d, h=mm_w);
        translate([mm_x-1,ra_y,ra_z]) rotate([0,90,0]) cylinder(d=ra_bt_d, h=mm_w);
        
        // motormount cut
        hull() {
            translate([mm_x-1,mm_max,mm_motor_z-mm_screw_dist/2]) rotate([0,90,0]) cylinder(d=mm_screw_d, h=mm_w+2);
            translate([mm_x-1,mm_min,mm_motor_z-mm_screw_dist/2]) rotate([0,90,0]) cylinder(d=mm_screw_d, h=mm_w+2);
        }
        // motormount cut
        hull() {
            translate([mm_x-1,mm_max,mm_motor_z+mm_screw_dist/2]) rotate([0,90,0]) cylinder(d=mm_screw_d, h=mm_w+2);
            translate([mm_x-1,mm_min,mm_motor_z+mm_screw_dist/2]) rotate([0,90,0]) cylinder(d=mm_screw_d, h=mm_w+2);
        }
        // motor hole cut
        hull() {
            translate([mm_x-1,mm_max,mm_motor_z]) rotate([0,90,0]) cylinder(d=13, h=mm_w+2);
            translate([mm_x-1,mm_min,mm_motor_z]) rotate([0,90,0]) cylinder(d=13, h=mm_w+2);
        }
        // rear wing mount
        hull() {
            translate([rwp_xr, rwp_y, rwp_z1]) rotate([-90,0,0]) cylinder(d=8, h=3);
            translate([rwp_xr, rwp_y, rwp_z2]) rotate([-90,0,0]) cylinder(d=8, h=3);
        }
        
        // cut mountinghole fit
        translate([bfr_x, bfr_y, 0]) cylinder(d=8+1, h=bp_h);
        
        // flaten print side
        translate([mm_x-20, -100, 0])  cube([20, 200,100]);
    }
    
}

module rearDamperMount() {
    // Use HPD version
    
}

module pivotClamp() {
    
}

module wingPlate() {
    zz=3;
    
    wing_dist = 29;
    // made from Kristians wingplate as reference
    
    difference() {
        union() {
            hull() { // right up to down
                translate([rwp_xr, rwp_y, rwp_z1]) rotate([-90,0,0]) cylinder(d=6, h=zz);
                translate([rwp_xr, rwp_y, rwp_z2]) rotate([-90,0,0]) cylinder(d=6, h=zz);
            }
            hull() { // left up to down
                translate([rwp_xl, rwp_y, rwp_z1]) rotate([-90,0,0]) cylinder(d=6, h=zz);
                translate([rwp_xl, rwp_y, rwp_z2]) rotate([-90,0,0]) cylinder(d=6, h=zz);
            }
            
            hull() { // Lower right to left
                translate([rwp_xr, rwp_y, rwp_z1]) rotate([-90,0,0]) cylinder(d=6, h=zz);
                translate([rwp_xl, rwp_y, rwp_z1]) rotate([-90,0,0]) cylinder(d=6, h=zz);
            }
            hull() { // Upper right to left
                translate([rwp_xr, rwp_y, rwp_z2]) rotate([-90,0,0]) cylinder(d=6, h=zz);
                translate([rwp_xl, rwp_y, rwp_z2]) rotate([-90,0,0]) cylinder(d=6, h=zz);
            }
            
            hull() { // wingmount right up to down
                translate([wing_dist/2, rwp_y, rwp_z1]) rotate([-90,0,0]) cylinder(d=8, h=zz);
                translate([wing_dist/2, rwp_y, rwp_z2]) rotate([-90,0,0]) cylinder(d=8, h=zz);
            }
            hull() { // wingmount left up to down
                translate([-wing_dist/2, rwp_y, rwp_z1]) rotate([-90,0,0]) cylinder(d=8, h=zz);
                translate([-wing_dist/2, rwp_y, rwp_z2]) rotate([-90,0,0]) cylinder(d=8, h=zz);
            }
    
        }
        for (a =[0:4:18]) {
            translate([-wing_dist/2, rwp_y, rwp_z1+a+1]) rotate([-90,0,0]) cylinder(d=C_M3_DIAMETER_THREAD, h=zz);
            translate([wing_dist/2, rwp_y, rwp_z1+a+1]) rotate([-90,0,0]) cylinder(d=C_M3_DIAMETER_THREAD, h=zz);
        }
        allScrews();
    }
}

%allScrews();
module allScrews() {
    //Pivot screws
    translate([6, -4.5, 0])common_flat_screw_tap(l = 10);
    translate([-6, -4.5, 0])common_flat_screw_tap(l = 10); 
    
    
    //Bulkhead screws
    translate([bfr_x, bfr_y, 0]) common_flat_screw_tap(l = 13, l2=bp_h);
    translate([bfl_x, bfl_y, 0]) common_flat_screw_tap(l = 13, l2=bp_h);
    translate([brr_x, brr_y, 0]) common_flat_screw_tap(l = 13, l2=bp_h);
    translate([brl_x, brl_y, 0]) common_flat_screw_tap(l = 13, l2=bp_h);
    
    // rear damper mount
    translate([rdm_xr, rdm_y, rdm_z]) rotate([180,0,0]) common_flat_screw_tap(l = 13);
    translate([rdm_xl, rdm_y, rdm_z]) rotate([180,0,0]) common_flat_screw_tap(l = 13);
    
    // rear wing mount
    translate([rwp_xr, rwp_y, rwp_z1]) rotate([-90,0,0]) common_button_screw_tap(l = 10, l2=3);
    translate([rwp_xr, rwp_y, rwp_z2]) rotate([-90,0,0]) common_button_screw_tap(l = 10, l2=3);
    translate([rwp_xl, rwp_y, rwp_z1]) rotate([-90,0,0]) common_button_screw_tap(l = 10, l2=3);
    translate([rwp_xl, rwp_y, rwp_z2]) rotate([-90,0,0]) common_button_screw_tap(l = 10, l2=3);
}


                              %visualHelp();
module visualHelp() {

%translate([28, -64, 0])  rotate([0,0,180]) import("ref/rear-damper-mount.stl", convexity=10);

color("green") side_spring_plate_p();

//nose_plate_p();
color("lightblue")main_chassie_p();

battery_plate_p();

//color("yellow")receiver_plate_p();


//color("red")nose_p();

translate([1,0,5.2]) side_stab_p();
translate([-1,0,5.2]) mirror([1,0,0]) side_stab_p();

translate([0,240,0]) union() {
    //upper_arm();
    //mirror([1,0,0]) upper_arm(); 


    //lower_arm();
    //mirror([1,0,0]) lower_arm();
    //translate([-63, -25, 25]) caster_visual();

    //color("yellow") arm_plate();
    //color("green") translate([0,-115,30]) upper_arm_plate_p();
    
    //translate([0, -25.5, 10+4]) rotate([0,180,0]) wingadapter_p();
}


//body post

//translate([70/2,240-2-180,0]) cylinder (d=5, h=50);
//translate([-70/2,240-2-180,0]) cylinder (d=5, h=50);

//%translate([-115, -67, -93])  rotate([0,-90,-90]) import("ref/Cradle.stl", convexity=10);

//translate([0,-33,3]) rotate([0,0,180])import("ref/kristian/Rearpod/bottomPlate.stl", convexity=10);
%translate([0, -33+1.5, 3+2.5]) rotate([0,0,180])import("ref/kristian/Rearpod/wingPlate.stl", convexity=10);
/*translate([0,-33,3]) rotate([0,0,180]) union() {
    import("ref/kristian/Rearpod/bottomPlate.stl", convexity=10);
    import("ref/kristian/Rearpod/leftBulkhead.stl", convexity=10);
    import("ref/kristian/Rearpod/pivotClamp.stl", convexity=10);
    import("ref/kristian/Rearpod/rearDamperMount.stl", convexity=10);
    import("ref/kristian/Rearpod/rightBulkhead.stl", convexity=10);
    import("ref/kristian/Rearpod/wingPlate.stl", convexity=10);
}
*/
}