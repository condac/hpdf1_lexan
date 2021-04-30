use <lexan_main-chassie.scad>;
use <caster_hub.scad>;
use <common_parts.scad>
include <tunable_constants.scad>;
//basefornewnose
//%translate([28, -60, 0])  rotate([0,0,180]) import("basefornewnose.stl", convexity=10);

// main-chassie
//translate([-62,240-25,23]) %caster_p();
%main_chassie_p();
%nose_plate_p();
//%translate([28, -65, 0])  rotate([0,0,180]) import("main.stl", convexity=10);
//translate([28+28+28+15, -20, -91])  rotate([-90,0,0]) rotate([0,0,180]) %import("body.stl", convexity=10);

long = true;
long_extra = 6; // set to 0 if short 42 if long battery
long_extra2 = 0; // set to 0 if short 18 if long battery
//long = false;

chassie_offset = 240+long_extra;
//batteri
batteri_x = 48;
batteri_y = 96.5+long_extra;
batteri_z = 28;
b_offset_z = 2; // höjden batteriet ligger på, det som blir basens tjocklek i botten

if (long) {
    echo("long");
    batteri_y = 96.5+long_extra;
} else {
    echo("short");
    batteri_y = 96.5; // 138mm för lång ack
}

// bas
b_x = 53;
b_y = 135+long_extra2;
b_z = 14;

bakre_wall = 6;


// bärarmanas koordinater
la1_x = 13; 
la1_y = 42;
la2_x = 15;
la2_y = 63;

ua1_x = 12;
ua1_y = 32;
ua2_x = 16;
ua2_y = 83;

arm_pin_x = 50;
lower_arm_thickness = 3.5;

//plattan
p_x = 132/2; // bredden på plattan delat med 2
p_b_x = 100/2; // bredden på plattan bak
p_y = 92;
p_z = 2;
p_offset_z = b_z-p_z;
p_bak_offset = 7;

// Fjädrar

s_x = 80/2;
s_z = 12;
s_wall = 5; // väggtjocklek
s_wall_x = 9; // väggbredd
s_plate_z = 3; // plattans tjocklek
s_plate_y = 11; // hur långt bak plattan sticker ut
s_plate_h_y = 6.1; // hur långt bak hålet ska va

// skruvar
//$fs= 0.4;
m3_d = C_M3_DIAMETER;//3; // hål som en skruv inte ska fästa i
m3_d_s = C_M3_DIAMETER_THREAD; // 2.8; // hål som skruven ska skapa gängor i

// front mount
fm_y = 8;
fm_z = 30;
fm_screw_dist_z = 20;
fm_screw_dist_x = 44;

// lilla badkaret
lb_wall = 2; // väggen mellan lilla och batteriet
lb_x = batteri_x;
lb_y = b_y-lb_wall-bakre_wall-fm_y-batteri_y;
lb_z = batteri_z;

// sidofästen
sf_y = 44;

//####################################################

nose_p();
translate([0,chassie_offset,0]) lower_arm();

translate([0,chassie_offset,0]) arm_plate();

translate([0,chassie_offset,0]) upper_arm();

translate([0,chassie_offset-115,30]) upper_arm_plate_p();

// ###################################################
color("yellow") %mirror([1,0,0]) translate([0,chassie_offset,0]) upper_arm();
color("yellow") %mirror([1,0,0]) translate([0,chassie_offset,0]) lower_arm();
color("yellow") %mirror([1,0,0]) translate([0,chassie_offset,0]) arm_pin_p();


// visual aids
color("yellow") % translate([-15,chassie_offset-10-25, 56.5]) cube([30, 10, 1]);
color("yellow") % translate([-15,chassie_offset-10-75, 42]) cube([30, 10, 1]);

// servoräddaren/arm
translate([0,chassie_offset-42-5-13.5,34]) %cylinder(r=23, h = 3);
translate([0,chassie_offset-42-5-13.5,34-3]) %cylinder(r=5, h = 3);
//main_chassie();

n_y = 115;
n_x1 = 28; // x fram
n_x2 = 39; // x bak
n_z = 4;

// vingfästen
wf_y = 11;
wf_dist = 14.5;

module nose_p() {
    
    translate([0,chassie_offset-n_y,0]) difference() {
        union() {
            //%translate([-n_x1/2,0,0]) cube([n_x1, n_y, n_z]);
            hull() {
                translate([n_x1/2-2,n_y-2,0 ]) cylinder(d=4, h=n_z);
                translate([-n_x1/2+2,n_y-2,0 ]) cylinder(d=4, h=n_z);
                translate([n_x2/2-2,2,0 ]) cylinder(d=4, h=n_z);
                translate([-n_x2/2+2,2,0 ]) cylinder(d=4, h=n_z);
            }
            //translate([0,8,0]) front_mount(); // fästet mot main_chassie
            //translate([0,8,0]) mirror([1,0,0]) front_mount(); // fästet mot main_chassie
            //translate([-n_x2/2,0,0])  cube([n_x2, 8, 14]); // mount mitten block
            
            // Servomount
            translate([0,n_y-105+6+27,0]) servo_mount();
            
            // bärarmar mount
            lower_arm_mount();
            mirror([1,0,0]) lower_arm_mount();
            upper_arm_mount();
            mirror([1,0,0]) upper_arm_mount();
            
        }
        
        // skruvar fäste main chassie
        translate([ 15, 8, 0]) rotate([0,0,0]) common_flat_screw_tap(l = 13, l2=n_z);
        translate([-15, 8, 0]) rotate([0,0,0]) common_flat_screw_tap(l = 13, l2=n_z);
        
        //utsågning för skruvar i framfäste
        translate([ 15, 8, 0]) cylinder(d=m3_d, h= 5);
        translate([-15, 8, 0]) cylinder(d=m3_d, h= 5);
        
        // Utsågning för bararmar fram 
        translate([0,n_y,0]) lower_arm_mount_cut(dd=m3_d_s);
        translate([0,n_y,0]) mirror([1,0,0])  lower_arm_mount_cut(dd=m3_d_s);
        translate([0,n_y,0]) upper_arm_mount_cut(dd=m3_d_s);
        translate([0,n_y,0]) mirror([1,0,0])  upper_arm_mount_cut(dd=m3_d_s);
        //translate([0,n_y,0]) translate([-15, -53, 10.5]) cylinder(d=7, h=3.5+0.5);
        //translate([0,n_y,0]) mirror([1,0,0]) translate([-15, -53, 10.5]) cylinder(d=7, h=3.5+0.5);
        
        // servo badkkar
        translate([0,6+27,0]) translate([-24/2+1, n_y-105-42/2, 1]) roundedcube(22, 42, 18, 0.5);
        // servokabel
        translate([0,6+27+8,0]) translate([-12/2,n_y-105 -42/2, 1]) cube([12, 42, 10]);
        // servokabel bak
        translate([0,6+27-8,0]) translate([-12/2,n_y-105 -42/2, 1]) cube([12, 42, 10]);
        // servot är ivägen för lower arm plate
        translate([la1_x,n_y-la1_y,n_z+11-3.5-1 ]) cylinder(d=11, h=n_z+11-3.5-1);
        translate([-la1_x,n_y-la1_y,n_z+11-3.5-1 ]) cylinder(d=11, h=n_z+11-3.5-1);
        translate([la2_x,n_y-la2_y,n_z+11-3.5-1 ]) cylinder(d=11, h=lower_arm_thickness+1.5);
        translate([-la2_x,n_y-la2_y,n_z+11-3.5-1 ]) cylinder(d=11, h=lower_arm_thickness+1.5);
        
        // vingfästen
        translate([0,n_y-wf_y,-1]) cylinder(d=4.2, h= n_z*2);
        translate([0,n_y-wf_y-wf_dist,-1]) cylinder(d=4.2, h= n_z*2);
        
        translate([0,n_y-wf_y,-1]) cylinder(d1=11, d2=4.2,  h=3.5);
        translate([0,n_y-wf_y-wf_dist,-1]) cylinder(d1=11, d2=4.2, h= 3.5);
        
        //hål för att kunna skruva bodypost i vingfästet
        translate([0,n_y-1.5,0]) cylinder(d=6.5, h=n_z);
        
    }
}

module arm_plate() {
    difference() {
        union() {
            translate([-20/2,-45-5,15]) cube([20, 45, 3]);
            translate([-la1_x, -la1_y, 14]) cylinder(d=10, h=4);
            mirror([1,0,0]) translate([-la1_x, -la1_y, 14]) cylinder(d=10, h=4);
        }
        translate([-la1_x, -la1_y, 13]) cylinder(d=m3_d, h=5);
        mirror([1,0,0]) translate([-la1_x, -la1_y, 13]) cylinder(d=m3_d, h=5);
        // vingfästen
        translate([0,-wf_y,-1])  cylinder(d=3.8, h= 50);
        translate([0,-wf_y-wf_dist,-1]) cylinder(d=3.8, h= 50);
        //karosspinnen
        translate([0,-wf_y+9,-1]) cylinder(d=10, h= 50);
        
        // servosrkuvar
        translate([5, -42-5,15])  cylinder(d=m3_d, h=3);
        translate([-5, -42-5,15])  cylinder(d=m3_d, h=s_z);
        
        // upperarmmountspost
        translate([-ua1_x, -ua1_y, 14]) cylinder(d=10, h=4);
        mirror([1,0,0]) translate([-ua1_x, -ua1_y, 14]) cylinder(d=10, h=4);
    }
}

module upper_arm_plate_p() {
    
    difference() {
        hull() {
            translate([-ua1_x,n_y-ua1_y,0 ]) cylinder(d=8, h=2.5);
            translate([ua1_x,n_y-ua1_y,0 ]) cylinder(d=8, h=2.5);
        }
        translate([-ua1_x,n_y-ua1_y,-1 ]) cylinder(d=m3_d, h=2.5+2);
        translate([ua1_x,n_y-ua1_y,-1 ]) cylinder(d=m3_d, h=2.5+2);
        
    }
    
}



module arm_pin_p() {
    difference() {
        translate([-arm_pin_x, -25, 14]) cylinder(d=m3_d_s+0.8*4, h=36.5-14-4);
        translate([-arm_pin_x, -25, 14]) cylinder(d=m3_d_s, h=36.5-14-4);
    }
}

module lower_arm() {
    z_w = lower_arm_thickness;
    z_z = 14;
    caster_compensated_y = -23 - S_CASTER*0.2;
    
    difference() {
        union() {
            hull() {
                translate([-la1_x, -la1_y, z_z-z_w]) cylinder(d=10, h=z_w);
                translate([-62, caster_compensated_y, z_z-z_w]) cylinder(d=10, h=z_w);
            }
            hull() {
                translate([-la2_x, -la2_y, z_z-z_w]) cylinder(d=8, h=z_w);
                translate([-arm_pin_x, -25, z_z-z_w]) cylinder(d=10, h=z_w);
            }
            
        }
        lower_arm_mount_cut(dd=m3_d);
        //translate([-62, -25, z_z-z_w]) cylinder(d=3.3, h=z_w);
        translate([-63, -23, 0]) caster_rod();
        translate([-arm_pin_x, -25, z_z-z_w]) cylinder(d=m3_d, h=z_w); // hole for arm pin
        
        translate([8,-10,3])translate([-arm_pin_x, -25, z_z-z_w]) rotate([0,0,-49]) indicator_dots(S_CASTER);
        translate([-7,-7,3])translate([-ua1_x, -ua1_y, z_z-z_w]) rotate([0,0,162])  indicator_dots(S_CAMBER);
    }
}
module lower_arm_mount() {
    translate([-la1_x,n_y-la1_y,0 ]) cylinder(d=8, h=n_z+11-3.5-1);
    translate([-la2_x,n_y-la2_y,0 ]) cylinder(d=10, h=n_z+11-3.5-1);
}
module lower_arm_mount_cut(dd=3) {
    z_w = lower_arm_thickness;
    z_z = 14;
    translate([-la1_x, -la1_y, z_z-z_w]) cylinder(d=dd, h=z_w);
    translate([-la2_x, -la2_y, z_z-z_w]) cylinder(d=dd, h=z_w);
    //translate([-62, -25, z_z-z_w]) cylinder(d=dd, h=z_w);
    translate([-la1_x, -la1_y, 0])  common_flat_screw_tap(l=11.1);
    translate([-la2_x, -la2_y, 0]) common_flat_screw_tap(l=11.1);
    
    
}

module upper_arm() {
    z_w = 4;
    z_z = 36.5;
    caster_compensated_y = -23 - S_CASTER*0.65;
    
    difference() {
        union() {
            difference() {
                union() {
                    hull() {
                        translate([-ua1_x, -ua1_y, z_z-z_w]) cylinder(d=10, h=z_w);
                        translate([-62, caster_compensated_y, z_z-z_w]) cylinder(d=10, h=z_w);
                    }
                    hull() {
                        translate([-ua2_x, -ua2_y, z_z-z_w]) cylinder(d=8, h=z_w);
                        translate([-arm_pin_x, -25, z_z-z_w]) cylinder(d=10, h=z_w);
                    }
                }
                // styvnings grejer
                %hull() {
                    translate([-ua1_x, -ua1_y, z_z-z_w/2]) cylinder(d=6, h=z_w);
                    translate([-62, caster_compensated_y, z_z-z_w/2]) cylinder(d=6, h=z_w);
                }
                translate([5,-10,3.5])translate([-arm_pin_x, -25, z_z-z_w]) rotate([0,0,-59]) indicator_dots(S_CASTER);
                translate([-7,4,3.5])translate([-ua1_x, -ua1_y, z_z-z_w]) rotate([0,0,172]) indicator_dots(S_CAMBER);
            }
            translate([-ua1_x, -ua1_y, z_z-z_w]) cylinder(d=10, h=z_w);
            translate([-62, caster_compensated_y, z_z-z_w]) cylinder(d=10, h=z_w);
            hull() {
                translate([-ua1_x, -ua1_y, z_z-z_w]) cylinder(d=2, h=z_w);
                translate([-62, caster_compensated_y, z_z-z_w]) cylinder(d=2, h=z_w);
            }
            
            
            
        }
        upper_arm_mount_cut(dd=m3_d);
        //translate([-62, -25, z_z-z_w]) cylinder(d=3.3, h=z_w);
        translate([-arm_pin_x, -25, z_z-z_w]) cylinder(d=m3_d, h=z_w);
        
        translate([-63, -23, 0]) caster_rod();
    }
}
module upper_arm_mount() {
    translate([-ua1_x,n_y-ua1_y,0 ]) cylinder(d=8, h=36.5-4-2);
    translate([-ua2_x,n_y-ua2_y,0 ]) cylinder(d=10, h=36.5-4-2);
}

module upper_arm_mount_cut(dd=3) {
    z_w = 4.5;
    z_z = 36.5;
    translate([-ua1_x, -ua1_y, 0]) cylinder(d=dd, h=z_w+15+z_z);
    translate([-ua2_x, -ua2_y, 0]) cylinder(d=dd, h=z_w+15+z_z);
    //translate([-62, -25, z_z-z_w])  cylinder(d=dd, h=z_w);
    translate([-ua1_x, -ua1_y, 0]) common_flat_screw_tap(l=11.1);
    translate([-ua2_x, -ua2_y, 0]) common_flat_screw_tap(l=11.1);
    
}


module servo_mount() {
    s_x = 26;
    s_y = 56;
    s_z = 18;
    difference() {
        union() {
            translate([-s_x/2, -s_y/2, 0]) roundedcube(s_x, s_y, s_z, 3);
        }
        
        translate([-22/2, -42/2, 0]) roundedcube(22, 42, s_z, 0.5);
        
        translate([5, 50/2,0])  cylinder(d=m3_d_s, h=s_z);
        translate([-5, -50/2,0])  cylinder(d=m3_d_s, h=s_z);
        translate([-5, 50/2,0])  cylinder(d=m3_d_s, h=s_z);
        translate([5, -50/2,0])  cylinder(d=m3_d_s, h=s_z);
        
        //utsågning för lower arm plate
        translate([-30.5/2,20,15]) cube([30.5, 40, 3]);
        
        
        
    }
}





module flat_screw_tap(l = 10) {
    tap_z = 1.2;
    cylinder(d = m3_d_s, h= l);
    translate([0,0,l-tap_z]) cylinder(d1 = m3_d_s, d2= 6, h= tap_z);
}

module flat_screw(l = 10) {
    tap_z = 1.2;
    cylinder(d = m3_d, h= l);
    translate([0,0,l-tap_z]) cylinder(d1 = m3_d, d2= 6, h= tap_z);
}

module screw_tap(l = 10) {
    cylinder(d = m3_d_s, h= l);
}

module screw(l = 10) {
    cylinder(d = m3_d_s, h= l);
}


