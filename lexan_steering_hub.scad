// Not even started...
// This is a modified part from the freecad project
steeringhubs_p();
module steeringhubs_p() {
    translate([-80, 265, -20])  rotate([0,0,0]) import("ref/testhub.stl", convexity=10);
    mirror([1,0,0]) translate([-75, 265, -20])  rotate([0,0,0]) import("ref/testhub.stl", convexity=10);
    
}