use <lexan_nose.scad>;
use <lexan_side_stab.scad>
use <hpdf1_rear_cradle_universal.scad>
use <common_parts.scad>
include <tunable_constants.scad>;


// main-chassie
%translate([0,0,0]) nose_p();
//%translate([28, -65, 0])  rotate([0,0,180]) import("ref/main-chassis.stl", convexity=10);
//%translate([-115, -67, -93])  rotate([0,-90,-90]) import("ref/Cradle.stl", convexity=10);
%translate([28, -64, 0])  rotate([0,0,180]) import("ref/rear-damper-mount.stl", convexity=10);
%rearCradle();
//translate([28+28+28+15, -20, -91])  rotate([-90,0,0]) rotate([0,0,180]) %import("body.stl", convexity=10);

translate([0,0,4]) %side_stab_p();
translate([0,0,4]) mirror([1,0,0]) %side_stab_p();

long = false;
long_extra = 0; // set to 0 if short 42 if long battery
long_extra2 = 0; // set to 0 if short 18 if long battery
//long = false;

//batteri
batteri_x = 48;
batteri_y = 96.5+long_extra;
batteri_z = 26;
b_offset_z = 0.5; // höjden batteriet ligger på, det som blir basens tjocklek i botten

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
p_x = 100/2; // bredden på plattan delat med 2
p_b_x = 90/2; // bredden på plattan bak
p_y = 100;
p_z = 2;
p_offset_z = 0;
p_bak_offset = 7;

// Fjädrar

s_x = 94/2;
s_z = 23;
s_wall = 5; // väggtjocklek
s_wall_x = 9; // väggbredd
s_plate_z = 3; // plattans tjocklek
s_plate_y = 11; // hur långt bak plattan sticker ut
s_plate_h_y = 6.1; // hur långt bak hålet ska va

// skruvar
//$fs= 0.4; sätts i print.scad
m3_d = C_M3_DIAMETER; // hål som en skruv inte ska fästa i
m3_d_s = C_M3_DIAMETER_THREAD; // hål som skruven ska skapa gängor i

// front mount
fm_y = 8;
fm_z = 30;
fm_screw_dist_z = 20;
fm_screw_dist_x = 44;

    nose_main_mount_y = 124.5;
    nose_main_mount_space = 8;

// lilla badkaret
lb_wall = 2; // väggen mellan lilla och batteriet
lb_x = batteri_x;
lb_y = b_y-lb_wall-bakre_wall-fm_y-batteri_y;
lb_z = batteri_z;

// sidofästen
sf_y = 62;//62;
sf_x = 100;
translate([-0, -28, 0]) rotate([-90,0,0]) translate([-125, -150, 0])   import("ref/body.stl", convexity=10);

translate([0,10,1]) rotate([0,0,90]) translate([0,-batteri_y/2,1]) %batteri();
translate([-batteri_x/2,6,1]) %batteri();

main_chassie_p();

//color("red")battery_plate_p();
legacy_body_battery_plate_p();
receiver_plate_p();
nose_plate_p();
color("blue")side_spring_plate_p();

//kaross bredd 116mm
translate([-116/2, 0, 0]) %cube([116, 1, 1]);
translate([-97/2, 0, 28]) %cube([97, 1, 16]);



// pinnar som batteriplattan och andra plattor fäster i
pp1_x = 40;
pp1_y = 6;
pp1_z = 23;
pp2_x = 30;
pp2_y = 62;
pp2_z = 28.5;
pp3_x = 16;
pp3_y = 240-83;
pp3_z = 36.5-4-2;
pp4_x = 30;
pp4_y = 6;
pp4_z = 6;

// karossfästen
bp_z =1.5;
body_post_x = 71;
body_post_y = 52-pp1_y;
body_post_z = 50-pp2_z;
body_post_z_legacy = 45-pp2_z;

module main_chassie_p() {
    difference() {
        union() {
            translate([0, 0, p_offset_z]) plattan();
            translate([0, 0, p_offset_z]) mirror([1,0,0])plattan();
            translate([-b_x/2, 0, 0]) cube([b_x, batteri_y+bakre_wall+2, b_z]);
            translate([-batteri_y/2-1, bakre_wall+1, 0]) cube([batteri_y+2, batteri_x+4, b_z]);
            //plattan för nosfästet
            translate([-40/2, 100, 0]) roundedcube(40,24,4,2);
            // fjädrar
            //translate([s_x, p_bak_offset, b_z]) sido_fjadrar();
            //translate([-s_x, p_bak_offset, b_z]) mirror([1,0,0])sido_fjadrar();
            
            // framfästet
            //translate([0,b_y,0]) front_mount();
            //translate([0,b_y,0]) mirror([1,0,0]) front_mount();
            
            // sidofästen
            translate([sf_x/2 -23.5 , sf_y, 0]) mirror([0,0,0]) sido_fasten();
            translate([-sf_x/2+23.5, sf_y, 0]) mirror([1,0,0]) sido_fasten();
            
            // refflor under batteriet
            for (a =[0:4:batteri_y]) {
                translate([-batteri_y/2 + a,10,0.5]) cube([2,batteri_x, 1.5]);
            }
            
            
            // sidodämparen
            translate([0, 0, 14])sido_dampare();
            
            // nya plate posts
            plate_posts(pp1_x, pp1_y, pp1_z, m3_d_s+0.4*13);
            plate_posts(pp2_x, pp2_y, pp2_z, m3_d_s+0.4*13);
            %plate_posts(pp3_x, pp3_y, pp3_z, m3_d_s+0.4*13);
            //plate_posts(pp4_x, pp4_y, pp4_z, 8);
            
            // Förstärkning sidofjäder post
            hull() {
                translate([pp1_x, bakre_wall+1, pp1_z-1]) cube([1,3,1]);
                translate([batteri_y/2,bakre_wall+1,b_z]) cube([1,3,1]);
                translate([batteri_x/2,bakre_wall+1,b_z]) cube([1,3,1]);
            }
            hull() {
                translate([-pp1_x, bakre_wall+1, pp1_z-1]) cube([1,3,1]);
                translate([-batteri_y/2-1,bakre_wall+1,b_z]) cube([1,3,1]);
                translate([-batteri_x/2-1,bakre_wall+1,b_z]) cube([1,3,1]);
            }
            
            // Radio tub
            radio_tub();
            
        }
        translate([batteri_y/2, bakre_wall+4, b_offset_z]) rotate([0,0,90]) batteri();
        translate([-batteri_x/2, bakre_wall, b_offset_z]) rotate([0,0,0]) batteri();
        
        
        // för att kunna ta ut batteriet på sidan
        translate([batteri_y/2-2, bakre_wall+4, b_offset_z+3]) rotate([0,0,90]) batteri();
        translate([batteri_y/2+2, bakre_wall+4, b_offset_z+3]) rotate([0,0,90]) batteri();
        
        //translate([-batteri_x/2, bakre_wall+batteri_y+lb_wall, b_offset_z]) lilla_bad();
        
        //utsågning för skruvar i framfäste
        translate([15,nose_main_mount_y-nose_main_mount_space,0])  common_flat_screw_tap();
        translate([-15,nose_main_mount_y-nose_main_mount_space,0]) common_flat_screw_tap();
        
        
        bak_screw_cut();
        
        radio_tub_cut();
        
        translate([-10,0,0]) bak_screw_cut();
        translate([10,0,0]) bak_screw_cut();
        
        // sido_Stab tar i pelare bak
        translate([-55, 0, 0]) cube([20, 6, 13]);
        translate([55-20, 0, 0]) cube([20, 6, 13]);
        
    }
    // refflor under batteriet
            for (a =[0:4:batteri_y]) {
                translate([-batteri_y/2 + a,10,0.5]) cube([2,batteri_x, 1.5]);
            }
}

module radio_tub() {
    xx = batteri_y;
    yy = 35;
    wall = 0.4*3;
    translate([0,batteri_x+bakre_wall+10,0]) difference() {
        translate([-xx/2, 0, 0]) cube([xx,yy,b_z]);
        translate([-xx/2+wall, wall, 2]) cube([xx-wall*2,yy-wall*2,b_z]);
        
    }
    
}
module radio_tub_cut() {
    xx = batteri_y;
    yy = 34;
    wall = 0.4*3;
    
    translate([0,batteri_x+bakre_wall+11,0]) translate([-xx/2+wall, wall, 2]) cube([xx-wall*2,yy-wall*2,b_z]);
     
    
}
module side_spring_plate_p() {
    difference() {
        union() {
            hull() {
                translate([s_x, 1, s_z]) cylinder(r=4, h=s_plate_z);
                translate([pp1_x, bakre_wall, s_z]) cylinder(r=4, h=s_plate_z);
            }
            hull() {
                translate([-s_x, 1, s_z]) cylinder(r=4, h=s_plate_z);
                translate([-pp1_x, bakre_wall, s_z]) cylinder(r=4, h=s_plate_z);
            }
            hull() {
                //translate([s_x-18.5, 3, s_z]) cylinder(r=4, h=s_plate_z);
                //translate([s_x-18.5, bakre_wall, s_z]) cylinder(r=4, h=s_plate_z);
            }
            hull() {
                translate([-pp1_x, bakre_wall+1, s_z]) cylinder(r=1, h=s_plate_z);
                translate([pp1_x, bakre_wall+1, s_z]) cylinder(r=1, h=s_plate_z);
            }
            translate([-pp1_x, bakre_wall, s_z]) cylinder(r=4, h=s_plate_z+2.5);
            translate([pp1_x, bakre_wall, s_z]) cylinder(r=4, h=s_plate_z+2.5);
        }
        // Fästhålen
        translate([-pp1_x, bakre_wall, s_z]) cylinder(d=m3_d, h=s_plate_z+2.5);
        translate([pp1_x, bakre_wall, s_z]) cylinder(d=m3_d, h=s_plate_z+2.5);
        //sidodämparhålet
        translate([s_x-18.5, 3, s_z]) cylinder(d=m3_d_s, h=s_plate_z);
        //sidofjädrar hål
        translate([s_x, 1, s_z]) cylinder(d=m3_d_s, h=s_plate_z);
        translate([-s_x, 1, s_z]) cylinder(d=m3_d_s, h=s_plate_z);
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
    
    
    
}

module batteri() {
    batteri = [batteri_x, batteri_y, batteri_z];
    cube(batteri);
    //cube([batteri_x, batteri_y, batteri_z]);
}
module battery_plate_p() {
    translate([0,0,pp2_z]) difference() {
        union() {
            translate([0,pp1_y,0]) crossplate_bat(pp1_x, pp2_x, pp2_y-pp1_y, 3, 4, body_post_z);
            translate([-10/2,36-8/2,0]) roundedcube(10,10,9,2);
            
        }
        translate([0,36,0])  cylinder(d=m3_d_s, h=9);
    }
}
module legacy_body_battery_plate_p() {
    translate([0,0,pp2_z]) difference() {
        union() {
            translate([0,pp1_y,0]) crossplate_bat(pp1_x, pp2_x, pp2_y-pp1_y, 3, 4, body_post_z_legacy);
            translate([-10/2,36-8/2,0]) roundedcube(10,10,9,2);
            
        }
        translate([0,36,0])  cylinder(d=m3_d_s, h=9);
    }
}

module body_posts_p() {

    // unused
    
    
    translate([0,0,0]) difference() {
        union() {
            hull() {
                translate([pp2_x,pp2_y,body_post_z-15]) cylinder(r=4, h=bp_z);
                translate([-pp2_x,pp2_y,body_post_z-15]) cylinder(r=4, h=bp_z);
                
                translate([-body_post_x/2,body_post_y,body_post_z-15]) cylinder(r=4, h=bp_z);
                translate([ body_post_x/2,body_post_y,body_post_z-15]) cylinder(r=4, h=bp_z);
            }
            translate([-body_post_x/2,body_post_y,body_post_z-15]) cylinder(r=4, h=15);
            translate([ body_post_x/2,body_post_y,body_post_z-15]) cylinder(r=4, h=15);
        }
    }
}
module receiver_plate_p() {
    translate([0,0,pp3_z]) difference() {
        union() {
            translate([0,pp2_y,0]) crossplate_res(pp2_x, pp3_x, pp3_y-pp2_y+1, 2.5, 4);
            
        }
        
    }
}
module nose_plate_p() {
    nose_main_mount_y = 124.5;
    nose_main_mount_space = 8;
    
    translate([0,0,4]) difference() {
        union() {
            translate([0,nose_main_mount_y-nose_main_mount_space,0]) crossplate(15, 15, nose_main_mount_space*2, 4, 3);
            translate([-15,nose_main_mount_y-nose_main_mount_space,0]) cylinder(d=6, h=4);
            translate([15,nose_main_mount_y-nose_main_mount_space,0]) cylinder(d=6, h=4);
            translate([-15,nose_main_mount_y+nose_main_mount_space,0]) cylinder(d=6, h=4);
            translate([15,nose_main_mount_y+nose_main_mount_space,0]) cylinder(d=6, h=4);
        }
        translate([-15,nose_main_mount_y-nose_main_mount_space,0]) cylinder(d=m3_d_s, h=4);
        translate([15,nose_main_mount_y-nose_main_mount_space,0]) cylinder(d=m3_d_s, h=4);
        translate([-15,nose_main_mount_y+nose_main_mount_space,0]) cylinder(d=m3_d_s, h=4);
        translate([15,nose_main_mount_y+nose_main_mount_space,0]) cylinder(d=m3_d_s, h=4);
        
    }
}
module plate_posts(xdim, ydim, zdim, ddim) {
    difference() {
        union() {
            translate([xdim,ydim,0]) cylinder(d=ddim, h=zdim);
            translate([-xdim,ydim,0]) cylinder(d=ddim, h=zdim);
        }
        translate([xdim,ydim,0]) cylinder(d=m3_d_s, h=zdim);
        translate([-xdim,ydim,0]) cylinder(d=m3_d_s, h=zdim);
        
    }
}

module crossplate(xdim1, xdim2, ,ydim ,zdim, rdim){
    difference() {
        union() {
            hull() {
                translate([xdim1,0,0]) cylinder(r=rdim, h=zdim);
                translate([-xdim1,0,0]) cylinder(r=rdim, h=zdim);
            }
            hull() {
                translate([xdim2,ydim,0]) cylinder(r=rdim, h=zdim);
                translate([-xdim2,ydim,0]) cylinder(r=rdim, h=zdim);
            }
            hull() {
                translate([xdim1,0,0]) cylinder(r=rdim, h=zdim);
                translate([xdim2,ydim,0]) cylinder(r=rdim, h=zdim);
            }
            hull() {
                translate([-xdim1,0,0]) cylinder(r=rdim, h=zdim);
                translate([-xdim2,ydim,0]) cylinder(r=rdim, h=zdim);
            }
            hull() {
                translate([-xdim1,0,0]) cylinder(r=rdim, h=zdim);
                translate([xdim2,ydim,0]) cylinder(r=rdim, h=zdim);
            }
            hull() {
                translate([xdim1,0,0]) cylinder(r=rdim, h=zdim);
                translate([-xdim2,ydim,0]) cylinder(r=rdim, h=zdim);
            }
        }
        translate([xdim2,ydim,0]) cylinder(d=m3_d, h=zdim);
        translate([-xdim2,ydim,0]) cylinder(d=m3_d, h=zdim);
        translate([xdim1,0,0]) cylinder(d=m3_d, h=zdim);
        translate([-xdim1,0,0]) cylinder(d=m3_d, h=zdim);
    }    
}
module crossplate_bat(xdim1, xdim2, ,ydim ,zdim, rdim, post_z){
    difference() {
        union() {
            hull() {
                translate([xdim1-2,10,0]) cylinder(r=rdim, h=zdim);
                translate([-xdim1+2,10,0]) cylinder(r=rdim, h=zdim);
            }
            hull() {
                translate([xdim2,ydim,0]) cylinder(r=rdim, h=zdim);
                translate([-xdim2,ydim,0]) cylinder(r=rdim, h=zdim);
            }
            hull() {
                translate([xdim1,0,0]) cylinder(r=rdim, h=zdim);
                translate([xdim2,ydim,0]) cylinder(r=rdim, h=zdim);
            }
            hull() {
                translate([-xdim1,0,0]) cylinder(r=rdim, h=zdim);
                translate([-xdim2,ydim,0]) cylinder(r=rdim, h=zdim);
            }
            hull() {
                translate([-xdim1,0,0]) cylinder(r=rdim, h=zdim);
                translate([xdim2,ydim,0]) cylinder(r=rdim, h=zdim);
            }
            hull() {
                translate([xdim1,0,0]) cylinder(r=rdim, h=zdim);
                translate([-xdim2,ydim,0]) cylinder(r=rdim, h=zdim);
            }
            
            hull() {
                translate([-body_post_x/2,body_post_y,0]) cylinder(r=4, h=post_z);
                translate([-10,ydim-2,0]) cylinder(r=2, h=bp_z);
            }
            hull() {
                translate([-body_post_x/2,body_post_y,0]) cylinder(r=4, h=post_z);
                translate([-35,5,0]) cylinder(r=2, h=bp_z);
            }
            hull() {
                translate([body_post_x/2,body_post_y,0]) cylinder(r=4, h=post_z);
                translate([10,ydim-2,0]) cylinder(r=2, h=bp_z);
            }
            hull() {
                translate([body_post_x/2,body_post_y,0]) cylinder(r=4, h=post_z);
                translate([35,5,0]) cylinder(r=2, h=bp_z);
            }
        }
        translate([xdim2,ydim,0]) cylinder(d=m3_d, h=zdim);
        translate([-xdim2,ydim,0]) cylinder(d=m3_d, h=zdim);
        translate([xdim1,0,0]) cylinder(d=m3_d, h=zdim);
        translate([-xdim1,0,0]) cylinder(d=m3_d, h=zdim);
        // batteripluggar
        translate([96/2-5,4+7,0]) cylinder(d=8, h=20);
        translate([-96/2+5,4+7,0]) cylinder(d=8, h=20);
        translate([96/2-5,4+7+30,0]) cylinder(d=8, h=5);
        translate([-96/2+5,4+7+30,0]) cylinder(d=8, h=5);
        // hål i karossfästet
        translate([body_post_x/2,body_post_y,0]) cylinder(r=3, h=post_z);
        translate([-body_post_x/2,body_post_y,0]) cylinder(r=3, h=post_z);
    }    
}
module crossplate_res(xdim1, xdim2, ,ydim ,zdim, rdim){
    difference() {
        union() {
            hull() {
                //translate([xdim1,0,0]) cylinder(r=rdim, h=zdim);
                //translate([-xdim1,0,0]) cylinder(r=rdim, h=zdim);
            }
            hull() {
                translate([xdim2,ydim,0]) cylinder(r=rdim, h=zdim);
                translate([-xdim2,ydim,0]) cylinder(r=rdim, h=zdim);
            }
            hull() {
                translate([xdim1,0,0]) cylinder(r=rdim, h=zdim);
                translate([xdim2,ydim,0]) cylinder(r=rdim, h=zdim);
            }
            hull() {
                translate([-xdim1,0,0]) cylinder(r=rdim, h=zdim);
                translate([-xdim2,ydim,0]) cylinder(r=rdim, h=zdim);
            }
            hull() {
                translate([-xdim1,0,0]) cylinder(r=rdim, h=zdim);
                translate([xdim2,ydim,0]) cylinder(r=rdim, h=zdim);
            }
            hull() {
                translate([xdim1,0,0]) cylinder(r=rdim, h=zdim);
                translate([-xdim2,ydim,0]) cylinder(r=rdim, h=zdim);
            }
        }
        translate([xdim2,ydim,0]) cylinder(d=m3_d, h=zdim);
        translate([-xdim2,ydim,0]) cylinder(d=m3_d, h=zdim);
        translate([xdim1,0,0]) cylinder(d=m3_d, h=zdim);
        translate([-xdim1,0,0]) cylinder(d=m3_d, h=zdim);
    }    
}
module roundedcube(xdim ,ydim ,zdim,rdim){
    hull(){
        
        translate([rdim,rdim,0]) cylinder(r=rdim, h=zdim);
        translate([xdim-rdim,rdim,0])cylinder(r=rdim, h=zdim);

        translate([rdim,ydim-rdim,0]) cylinder(r=rdim, h=zdim);
        translate([xdim-rdim,ydim-rdim,0]) cylinder(r=rdim, h=zdim);
    }
}  
module sido_fasten() {
    skruv_z = 5;
    bredd = 23.5;
    
    difference() {
        hull() {
            translate([0, -2, 0]) cube([bredd, 4, 1]);
            translate([0, -6, skruv_z-1]) cube([bredd, 12, 1]);
            translate([0, -6, 8]) cube([bredd, 12, 1]);
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
    tap_z = 1.1;
    cylinder(d = m3_d_s, h= l);
    translate([0,0,l-tap_z+0.1]) cylinder(d1 = m3_d_s, d2= 6, h= tap_z);
}

module flat_screw(l = 10) {
    tap_z = 1.1;
    cylinder(d = m3_d, h= l);
    translate([0,0,l-tap_z+0.1]) cylinder(d1 = m3_d, d2= 6, h= tap_z);
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
    
    translate([fm_screw_dist_x/2, -10+0.01, 5]) rotate([-90]) flat_screw(l = 10);
    translate([fm_screw_dist_x/2, -10+0.01, 5+fm_screw_dist_z]) rotate([-90]) flat_screw(l = 10);
    
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
    translate([0,bakre_wall+0.01,5]) rotate([90,0,0]) cylinder(d=C_M3_NUT, h=3, $fn=6);
}