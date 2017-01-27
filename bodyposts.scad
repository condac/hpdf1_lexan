




body_post2_p();

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

module body_post2_p() {
    dd = 5.75;
    hh = 4.4;
    l = 37;

    hole = 2;

    $fn=64;

    rotate([0,90,0]) difference() {
        union() {
            cylinder(d=dd, h = l);
            cylinder(d=7, h = 10);
            translate([-5,-7/2,0]) cube([5,7,10]);
        }
        
        translate([hh/2,-10,0]) cube([20,20,l]);
        translate([-hh/2-20,-10,10]) cube([20,20,l]);
        
        dist = 4;
        for (a =[dist:dist:l]) {
            translate([-100, 0, 10+a]) rotate([0,90,0]) cylinder(d=hole, h=400);
        }
        cylinder(d=2.85, h = 10);
    }
    

}