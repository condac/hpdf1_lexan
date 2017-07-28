// Wing adapter with body post
include <tunable_constants.scad>;
use <common_parts.scad>

//$fs = 0.1;
yd = 17;
c_yd = 25; //  cube extra diameter

m3_d = 3.1;
s_dist = 14.5;
post_dist = 24;
lip_dist = 28;
hh = 9;
mount_dist = 54;

xx = 24;

m_x1 = 14.8;
m_x2 = 7.9;
m_y = 32;
m_z1 = 2.5;
m_z2 = 2.5;

platta_y = 20;
bredd = 160;
tjock = 3;

curv = 10;

frontwing_p();
//skid_guard_p();
%all_screws();
wingelement_p();

translate([10, 39+4, 145+3])  rotate([-90,0,0]) rotate([0,0,45]) %import("ref/Front-wing.stl", convexity=10);

module frontwing_p() {
    difference() {
        union() {
            difference() {
                union() {
                    hull() {
                        translate([0,0,0]) cylinder(d = yd, h=hh);
                        translate([0,s_dist,0]) cylinder(d = yd+5, h=hh);
                        translate([0,post_dist,0]) cylinder(d = yd, h=hh);
                        translate([-c_yd/2,0,hh-3]) cube([c_yd,20,3]);
                    }
                    hull() {
                        translate([0,s_dist,0]) cylinder(d = yd+5, h=hh);
                        translate([-xx/2,lip_dist,0]) cube([xx, 1, hh]);
                        translate([-xx/2,55+20-1,hh-tjock]) cube([xx, 1, tjock]);
                    }
                    //translate([-xx/2,lip_dist,0]) cube([xx, 6, hh+2.5]);
                    translate([-bredd/2,55,hh-tjock]) cube([bredd, platta_y, tjock]); // fetplattan
                    translate([-xx/2,55-curv,hh-tjock]) cube([xx+curv, 30, tjock]); //curvplatta
                    translate([-xx/2-curv,55-curv,hh-tjock]) cube([xx, 30, tjock]); //curvplatta
                    
                }
                //translate([-50/2,mount_dist-m_y/2,0]) cube([50, m_y, 100]);
            }
            //translate([-m_x1/2,mount_dist-m_y/2,0]) cube([m_x1, m_y, m_z1]);
            //translate([-m_x2/2,mount_dist-m_y/2,m_z1]) cube([m_x2, m_y, m_z2]);
        }
        // screw holes
        translate([0,0,0])      cylinder(d = C_M4_DIAMETER, h=hh);
        translate([0,s_dist,0]) cylinder(d = C_M4_DIAMETER, h=hh);
        translate([0,post_dist,0]) cylinder(d = C_M3_DIAMETER, h=hh);
        translate([0,mount_dist,0])  cylinder(d = C_M3_DIAMETER_THREAD, h=hh+m_z1+m_z2);
        
        translate([0,post_dist,4]) cylinder(d = 6.5, h=hh);
        //skruvar för fäste av vingelement
        
         all_screws();
        
        //muttrar
        translate([0,mount_dist,0])  cylinder(d=6.5, h=2.5, $fn=6);
        
        translate([0,0,0]) rotate([0,0,360/12]) cylinder(d=C_M4_NUT, h=4, $fn=6);
        translate([0,s_dist,0]) rotate([0,0,360/12]) cylinder(d=C_M4_NUT, h=4, $fn=6);
        
        // curv
        translate([xx/2+curv, 55-curv,hh-tjock ]) cylinder(r=curv, h=tjock);
        translate([-xx/2-curv, 55-curv,hh-tjock ]) cylinder(r=curv, h=tjock);
    }
}

module frontwingflex_p() {
    difference() {
        frontwing_p();
        hull() {
            translate([0,55,0]) cylinder(d=13, h=10);
            translate([0,35,0]) cylinder(d=13, h=10);
        }
    }
}

module skid_guard_p() {
    thin_mount = 1;
    lip = 4;
    angle = 25;
    lip_dist = 28;
    lip_gap = 3;
    difference() {
        union() {
            difference() {
                union() {
                    hull() {
                        translate([0,0,0]) cylinder(d = yd, h=thin_mount+lip);
                        translate([0,s_dist,0]) cylinder(d = yd+5, h=thin_mount+lip);
                        translate([0,post_dist,0]) cylinder(d = yd, h=thin_mount+lip);
                        
                    }
                    hull() {
                        translate([0,s_dist,0]) cylinder(d = yd+5, h=thin_mount+lip);
                        translate([-xx/2,lip_dist,0]) cube([xx, 1, thin_mount+lip]);
                        translate([-xx/2,55+20-1,0]) cube([xx, 1, thin_mount+lip]);
                    }
                   
                    
                }
                
            }

        }
        
        translate([-25,lip_dist+lip_gap,0]) rotate([angle,0,0]) translate([0,0,-50]) cube([50,100,50]);
        translate([-25,-100+lip_dist,-50+lip]) cube([50,100,50]);
        
        // screw holes
        translate([0,0,0])      cylinder(d = C_M4_DIAMETER, h=hh);
        translate([0,s_dist,0]) cylinder(d = C_M4_DIAMETER, h=hh);
        translate([0,post_dist,0]) cylinder(d = C_M3_DIAMETER, h=hh);
        translate([0,mount_dist,0])  cylinder(d = m3_d, h=hh+m_z1+m_z2);
        
        translate([0,post_dist,4]) cylinder(d = 6.5, h=hh);
        
        //muttrar
        translate([0,mount_dist,0])  cylinder(d=6.5, h=2.5, $fn=6);
        
        translate([0,0,0]) rotate([0,0,360/12]) cylinder(d=C_M4_NUT, h=4, $fn=6);
        translate([0,s_dist,0]) rotate([0,0,360/12]) cylinder(d=C_M4_NUT, h=4, $fn=6);
        

    }
}

module all_screws() {
    translate([-bredd/2+15 ,55+platta_y/2,hh-6]) common_button_screw_tap(l = 6);
    translate([-bredd/2+50 ,55+platta_y/2,hh-6]) common_button_screw_tap(l = 6);
    translate([bredd/2-15 ,55+platta_y/2,hh-6]) common_button_screw_tap(l = 6);
    translate([bredd/2-50 ,55+platta_y/2,hh-6]) common_button_screw_tap(l = 6);
}

module imported_wing() {
    difference() {
        translate([10, 39+4, 145+3])  rotate([-90,0,0]) rotate([0,0,45]) import("ref/Front-wing.stl", convexity=10);
        translate([-150+35,30,-25]) cube([150, 50, 50]);
    }
}

module wingelement_p() {
    difference() {
        union() {
            imported_wing();
            hull() {
                translate([35, 55,hh-6]) cube([1, 20, 6-tjock]);
                translate([bredd/2-50 ,55+platta_y/2,hh-6]) cylinder(d = 7, h=6-tjock);
                
            }
            translate([bredd/2-15 ,55+platta_y/2,hh-6]) cylinder(d = 6, h=6-tjock);
        }
        all_screws();
        translate([-bredd/2,55,hh-tjock]) cube([bredd, platta_y, tjock]); // sågning för fetplattan
    }
}