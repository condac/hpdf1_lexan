// Wing adapter with body post
include <tunable_constants.scad>;


$fs = 0.1;
yd = 17;
c_yd = 25; //  cube extra diameter
m4_d = 4.2;
m3_d = 3.1;
s_dist = 14.5;
post_dist = 24;
lip_dist = 28;
hh = 8;
mount_dist = 54;

xx = 24;

m_x1 = 14.8;
m_x2 = 7.9;
m_y = 32;
m_z1 = 2.5;
m_z2 = 2.5;

bredd = 160;
tjock = 3;

curv = 10;

frontwingflex_p();


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
                    translate([-bredd/2,55,hh-tjock]) cube([bredd, 20, tjock]); // fetplattan
                    translate([-xx/2,55-curv,hh-tjock]) cube([xx+curv, 30, tjock]); //curvplatta
                    translate([-xx/2-curv,55-curv,hh-tjock]) cube([xx, 30, tjock]); //curvplatta
                    
                }
                //translate([-50/2,mount_dist-m_y/2,0]) cube([50, m_y, 100]);
            }
            //translate([-m_x1/2,mount_dist-m_y/2,0]) cube([m_x1, m_y, m_z1]);
            //translate([-m_x2/2,mount_dist-m_y/2,m_z1]) cube([m_x2, m_y, m_z2]);
        }
        // screw holes
        translate([0,0,0])      cylinder(d = m4_d, h=hh);
        translate([0,s_dist,0]) cylinder(d = m4_d, h=hh);
        translate([0,post_dist,0]) cylinder(d = m3_d, h=hh);
        translate([0,mount_dist,0])  cylinder(d = m3_d, h=hh+m_z1+m_z2);
        
        translate([0,post_dist,4]) cylinder(d = 6.5, h=hh);
        
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