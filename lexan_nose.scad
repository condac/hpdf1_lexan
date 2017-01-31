use <lexan_main-chassie.scad>;
use <caster_hub.scad>;
//basefornewnose
//%translate([28, -60, 0])  rotate([0,0,180]) import("basefornewnose.stl", convexity=10);

// main-chassie
//translate([-62,240-25,23]) %caster_p();
%main_chassie_p();
%nose_plate_p();
//%translate([28, -65, 0])  rotate([0,0,180]) import("main.stl", convexity=10);
//translate([28+28+28+15, -20, -91])  rotate([-90,0,0]) rotate([0,0,180]) %import("body.stl", convexity=10);

long = true;
long_extra = 0; // set to 0 if short 42 if long battery
long_extra2 = 0; // set to 0 if short 18 if long battery
//long = false;

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
$fs= 0.4;
m3_d = 3; // hål som en skruv inte ska fästa i
m3_d_s = 2.8; // hål som skruven ska skapa gängor i

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
translate([0,240,0]) lower_arm();

translate([0,240,0]) arm_plate();

translate([0,240,0]) upper_arm();

// ###################################################
color("yellow") %mirror([1,0,0]) translate([0,240,0]) upper_arm();
color("yellow") %mirror([1,0,0]) translate([0,240,0]) lower_arm();


// visual aids
color("yellow") % translate([-15,240-10-25, 42]) cube([30, 10, 1]);
color("yellow") % translate([-15,240-10-75, 42]) cube([30, 10, 1]);

// servoräddaren/arm
translate([0,240-42-5-13.5,34]) %cylinder(r=23, h = 3);
translate([0,240-42-5-13.5,34-3]) %cylinder(r=5, h = 3);
//main_chassie();

n_y = 115;
n_x1 = 28; // x fram
n_x2 = 37; // x bak
n_z = 4;

// vingfästen
wf_y = 11;
wf_dist = 14.5;

module nose_p() {
    
    translate([0,240-n_y,0]) difference() {
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
        //utsågning för skruvar i framfäste
        translate([ 15, 8, 9.99]) rotate([180,0,0]) flat_screw_tap();
        translate([-15, 8, 9.99]) rotate([180,0,0]) flat_screw_tap();
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
        // servot är ivägen för lower arm plate
        translate([la1_x,n_y-la1_y,n_z+11-3.5-1 ]) cylinder(d=11, h=n_z+11-3.5-1);
        translate([-la1_x,n_y-la1_y,n_z+11-3.5-1 ]) cylinder(d=11, h=n_z+11-3.5-1);
        
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
            translate([-ua1_x,n_y-ua1_y,0 ]) cylinder(d=8, h=2);
            translate([ua1_x,n_y-ua1_y,0 ]) cylinder(d=8, h=2);
        }
        translate([-ua1_x,n_y-ua1_y,0 ]) cylinder(d=m3_d, h=2);
        translate([ua1_x,n_y-ua1_y,0 ]) cylinder(d=m3_d, h=2);
        
    }
    
}

la1_x = 13;
la1_y = 42;
la2_x = 15;
la2_y = 63;

ua1_x = 12;
ua1_y = 32;
ua2_x = 16;
ua2_y = 83;


module arm_pin_p() {
    difference() {
        translate([-52, -25, 14]) cylinder(d=m3_d_s+0.8*4, h=36.5-14-4);
        translate([-52, -25, 14]) cylinder(d=m3_d_s, h=36.5-14-4);
    }
}
module lower_arm() {
    z_w = 3.5;
    z_z = 14;
    
    difference() {
        union() {
            hull() {
                translate([-la1_x, -la1_y, z_z-z_w]) cylinder(d=10, h=z_w);
                translate([-62, -25, z_z-z_w]) cylinder(d=10, h=z_w);
            }
            hull() {
                translate([-la2_x, -la2_y, z_z-z_w]) cylinder(d=6, h=z_w);
                translate([-52, -25, z_z-z_w]) cylinder(d=10, h=z_w);
            }
        }
        lower_arm_mount_cut(dd=m3_d);
        //translate([-62, -25, z_z-z_w]) cylinder(d=3.3, h=z_w);
        translate([-63, -23, 0]) caster_rod();
        translate([-52, -25, z_z-z_w]) cylinder(d=m3_d, h=z_w);
        %arm_pin_p();
    }
}
module lower_arm_mount() {
    translate([-la1_x,n_y-la1_y,0 ]) cylinder(d=8, h=n_z+11-3.5-1);
    translate([-la2_x,n_y-la2_y,0 ]) cylinder(d=10, h=n_z+11-3.5-1);
}
module lower_arm_mount_cut(dd=3) {
    z_w = 3.5;
    z_z = 14;
    translate([-la1_x, -la1_y, z_z-z_w]) cylinder(d=dd, h=z_w);
    translate([-la2_x, -la2_y, z_z-z_w]) cylinder(d=dd, h=z_w);
    //translate([-62, -25, z_z-z_w]) cylinder(d=dd, h=z_w);
    translate([-la1_x, -la1_y, 11]) rotate([180,0,0]) flat_screw_tap(l=11.1);
    translate([-la2_x, -la2_y, 11]) rotate([180,0,0]) flat_screw_tap(l=11.1);
    
    
}

module upper_arm() {
    z_w = 4;
    z_z = 36.5;
    
    difference() {
        union() {
            difference() {
                union() {
                    hull() {
                        translate([-ua1_x, -ua1_y, z_z-z_w]) cylinder(d=10, h=z_w);
                        translate([-62, -25, z_z-z_w]) cylinder(d=10, h=z_w);
                    }
                    hull() {
                        translate([-ua2_x, -ua2_y, z_z-z_w]) cylinder(d=8, h=z_w);
                        translate([-52, -25, z_z-z_w]) cylinder(d=10, h=z_w);
                    }
                }
                // styvnings grejer
                hull() {
                    translate([-ua1_x, -ua1_y, z_z-z_w/2]) cylinder(d=6, h=z_w);
                    translate([-62, -25, z_z-z_w/2]) cylinder(d=6, h=z_w);
                }
            }
            translate([-ua1_x, -ua1_y, z_z-z_w]) cylinder(d=10, h=z_w);
            translate([-62, -25, z_z-z_w]) cylinder(d=10, h=z_w);
            hull() {
                translate([-ua1_x, -ua1_y, z_z-z_w]) cylinder(d=2, h=z_w);
                translate([-62, -25, z_z-z_w]) cylinder(d=2, h=z_w);
            }
            
        }
        upper_arm_mount_cut(dd=m3_d);
        //translate([-62, -25, z_z-z_w]) cylinder(d=3.3, h=z_w);
        translate([-52, -25, z_z-z_w]) cylinder(d=m3_d, h=z_w);
        
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
    translate([-ua1_x, -ua1_y, 11]) rotate([180,0,0]) flat_screw_tap(l=11.1);
    translate([-ua2_x, -ua2_y, 11]) rotate([180,0,0]) flat_screw_tap(l=11.1);
    
}


module servo_mount() {
    s_x = 24;
    s_y = 56;
    s_z = 18;
    difference() {
        union() {
            translate([-s_x/2, -s_y/2, 0]) roundedcube(s_x, s_y, s_z, 3);
        }
        
        translate([-s_x/2+1, -42/2, 0]) roundedcube(22, 42, s_z, 0.5);
        
        translate([5, 50/2,0])  cylinder(d=m3_d_s, h=s_z);
        translate([-5, -50/2,0])  cylinder(d=m3_d_s, h=s_z);
        translate([-5, 50/2,0])  cylinder(d=m3_d_s, h=s_z);
        translate([5, -50/2,0])  cylinder(d=m3_d_s, h=s_z);
        
        //utsågning för lower arm plate
        translate([-30.5/2,20,15]) cube([30.5, 40, 3]);
        
        
        
    }
}

module main_chassie() {
    difference() {
        union() {
            translate([0, 0, p_offset_z]) plattan();
            translate([0, 0, p_offset_z]) mirror([1,0,0])plattan();
            translate([-b_x/2, 0, 0]) cube([b_x, b_y, b_z]);
            
            // fjädrar
            translate([s_x, p_bak_offset, b_z]) sido_fjadrar();
            translate([-s_x, p_bak_offset, b_z]) mirror([1,0,0])sido_fjadrar();
            
            // framfästet
            translate([0,b_y,0]) front_mount();
            translate([0,b_y,0]) mirror([1,0,0]) front_mount();
            
            // sidofästen
            translate([b_x/2, sf_y, 0]) mirror([0,0,0]) sido_fasten();
            translate([-b_x/2, sf_y, 0]) mirror([1,0,0]) sido_fasten();
            
            // fäste för plattan med dämparen
            translate([28, 32, p_offset_z+p_z]) hoger_faste();
            translate([-28, 32, p_offset_z+p_z]) vanster_faste();
            
            // sidodämparen
            translate([0, 0, p_offset_z+p_z])sido_dampare();
        }
        translate([-batteri_x/2, bakre_wall, b_offset_z]) batteri();
        translate([-batteri_x/2, bakre_wall+batteri_y+lb_wall, b_offset_z]) lilla_bad();
        
        //utsågning för skruvar i framfäste
        translate([0,b_y,0]) front_mount_cut();
        translate([0,b_y,0]) mirror([1,0,0]) front_mount_cut();
        
        bak_screw_cut();
        
        
    }
}

module plattan() {
    
    hull() {
        translate([p_x-4, p_y-4+long_extra2, 0]) cylinder(r=4, h=p_z);
        translate([p_x-4, p_y-34+long_extra2, 0]) cylinder(r=4, h=p_z);
        translate([0, p_bak_offset+long_extra2, 0]) cube([p_b_x, p_y-p_bak_offset, p_z]);
        translate([0, p_bak_offset+long_extra2, 0]) cube([1,p_y-p_bak_offset+11,p_z]);
        
        
    }
    translate([0, p_bak_offset, 0]) cube([p_b_x-4, p_y-p_bak_offset, p_z]);
    
    hull() {
        translate([b_x/2-1,p_bak_offset,-2]) cube([1, b_y-p_bak_offset, 2]);
        translate([b_x/2+1,p_bak_offset,0]) cube([1, b_y-p_bak_offset, 2]);
        translate([b_x/2-3,p_bak_offset,0]) cube([1, b_y-p_bak_offset, 2]);
    }
    
}

module batteri() {
    batteri = [batteri_x, batteri_y, batteri_z];
    cube(batteri);
    //cube([batteri_x, batteri_y, batteri_z]);
}

module sido_fasten() {
    skruv_z = 5;
    bredd = 9.5;
    
    difference() {
        hull() {
            translate([0, -2, 0]) cube([bredd, 4, 1]);
            translate([0, -6, skruv_z-1]) cube([bredd, 12, 1]);
            translate([0, -6, p_offset_z]) cube([bredd, 12, 1]);
        }
        translate([0,0,skruv_z]) rotate([0,90,0]) flat_screw_tap(l=bredd);
    }
    
}

module sido_fjadrar() {
    extra_x = s_x - batteri_x/2;
    difference() {
        union() {
            translate([-s_wall_x/2, 0, 0]) cube([s_wall_x, s_wall, s_z]);
            translate([-s_wall_x/2, -s_plate_y, s_z-s_plate_z]) cube([s_wall_x, s_plate_y, s_plate_z]);
        }
        translate([0, -s_plate_h_y, s_z-s_plate_z]) flat_screw_tap(l=s_plate_z);
    }
    translate([-extra_x, 0, 0]) cube([extra_x, s_wall, 5]);
}

module sido_dampare() {
    difference() {
        translate([17,0,0]) cube([9,6,11]);
        translate([17+9/2, 3, 3+0.01]) flat_screw_tap(l=8);
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

module lilla_bad() {
    
    cube([lb_x, lb_y, lb_z]);
}

module front_mount() {
   // hull() {
        translate([fm_screw_dist_x/2, 0, 5+fm_screw_dist_z]) rotate([90]) cylinder(d=10, h=fm_y);
        
    //}
    translate([fm_screw_dist_x/2, -fm_y,  5+fm_screw_dist_z]) cube([5, fm_y, 5]);
    translate([fm_screw_dist_x/2-4.5-5, -fm_y,  b_z]) cube([5, fm_y, 5]);
    translate([fm_screw_dist_x/2-4.5, -fm_y,  0]) cube([5+4, fm_y, 5+fm_screw_dist_z]);
}

module front_mount_cut() {
    
    translate([fm_screw_dist_x/2, -10+0.01, 5])                 rotate([-90]) flat_screw(l = 10);
    translate([fm_screw_dist_x/2, -10+0.01, 5+fm_screw_dist_z]) rotate([-90]) flat_screw(l = 10);
    
    translate([fm_screw_dist_x/2, 0+0.01, 5])                 rotate([-90]) cylinder(d=5, h=22);
    translate([fm_screw_dist_x/2, 0+0.01, 5+fm_screw_dist_z]) rotate([-90]) cylinder(d=5, h=22);
    
    translate([fm_screw_dist_x/2-5-4.5, 0, b_z+5]) rotate([90]) cylinder(d=10, h=fm_y);
    
    translate([b_x/2, -fm_y,  0]) cube([5, fm_y, b_z+fm_screw_dist_z]);
    
    //muttrar
    
    translate([fm_screw_dist_x/2, -fm_y-3, 5]) rotate([0,90,0]) rotate([-90,0,0])  cylinder(d=7, h=6, $fn=6);
    translate([fm_screw_dist_x/2, -fm_y-3, 5+fm_screw_dist_z]) rotate([0,90,0]) rotate([-90,0,0])  cylinder(d=7, h=6, $fn=6);
    
}

module hoger_faste() {
    hh = 16;
    difference() {
        hull() {
            translate([0,-2,0]) cylinder(d=10, h=hh);
            translate([0,4,0]) cylinder(d=10, h=hh);
        }
        flat_screw_tap(l = hh);
    }
}

module vanster_faste() {
    hh = 16;
    difference() {
        hull() {
            translate([0,-2,0]) cylinder(d=10, h=hh);
            translate([0,14,0]) cylinder(d=10, h=hh);
        }
        flat_screw_tap(l = hh);
        translate([0,13,0]) flat_screw_tap(l = hh);
    }
}

module bak_screw_cut() {
    translate([0,10-0.01,5]) rotate([90,0,0]) flat_screw_tap(l = 10);
    translate([0,bakre_wall+0.01,5]) rotate([90,0,0]) cylinder(d=7, h=3, $fn=6);
}

module roundedcube(xdim ,ydim ,zdim,rdim){
    hull(){
        fn=30;
        translate([rdim,rdim,0]) cylinder(r=rdim, h=zdim, $fn=fn);
        translate([xdim-rdim,rdim,0])cylinder(r=rdim, h=zdim, $fn=fn);

        translate([rdim,ydim-rdim,0]) cylinder(r=rdim, h=zdim, $fn=fn);
        translate([xdim-rdim,ydim-rdim,0]) cylinder(r=rdim, h=zdim, $fn=fn);
    }
}