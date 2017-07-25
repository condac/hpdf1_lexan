// file for viewing parts when edit
include <tunable_constants.scad>;

use <lexan_main-chassie.scad>
use <lexan_nose.scad>
use <lexan_side_stab.scad>
use <caster_hub.scad>
use <wingadapter.scad>
use <common_parts.scad>


$fs=0.1;

spacer(dd=8.4, wall=1, hh=0.5);


module torus(dd=1, wall=1, hh=1) {
        difference() {
            cylinder(d=dd, h=hh);
            cylinder(d=dd-wall*2, h=hh);
        }
    
}
module spacer(dd=1, wall=1, hh=1) {
        difference() {
            cylinder(d=dd+wall*2, h=hh);
            cylinder(d=dd, h=hh);
        }
    
}
