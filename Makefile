# match "module foobar() { // `make` me"
#TARGETS=$(shell sed '/^module [a-z0-9_-]*().*make..\?me.*$$/!d;s/module //;s/().*/.stl/' print.scad)

all: stl main_chassie nose_plate side_spring_plate battery_plate receiver_plate nose upper_arms lower_arms lower_arm_plate upper_arm_plate side_stab_x2 side_stab2_x2 steering_hubs body_posts wing_adapter arm_pin cradle_bottomPlate cradle_leftBulkhead cradle_rightBulkhead cradle_wingPlate cradle_bottomPlate_wide frontwing frontwingflex
	rm stl/all.stl


%:
	openscad -m make -o stl/$@.stl -D "$@();" print.scad

stl:
	mkdir stl
