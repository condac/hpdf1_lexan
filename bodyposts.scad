






module body_post_p() {
dd = 5.75;
hh = 4.4;
l = 50;

hole = 2;

$fn=64;

rotate([0,90,0]) difference() {
    cylinder(d=dd, h = l);
    
    translate([hh/2,-10,0]) cube([20,20,l]);
    translate([-hh/2-20,-10,0]) cube([20,20,l]);
    
    dist = 4;
    for (a =[dist:dist:l]) {
        translate([-100, 0, a]) rotate([0,90,]) cylinder(d=hole, h=400);
    }
    
}

}