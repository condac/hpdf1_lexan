// Not even started...
// This is a modified part from the freecad project
//steeringhubs_p();
module steeringhubs_p() {
    steering_hub();
    //translate() mirror([1,0,0]) steering_hub();
    
}
steering_hub();
module steering_hub() {
    $fs=0.1;
    difference() {
        union() {
            translate([-90, 271.5, -20.5]) import("ref/testhub.stl", convexity=10);
            translate([0, -5.2, 0]) rotate([90,0,0]) cylinder(d=4, h=5);
            
        }
        translate([0, -4, 0]) rotate([90,0,0]) cylinder(d=2.75, h=10);
    }
}