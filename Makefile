# match "module foobar() { // `make` me"
#TARGETS=$(shell sed '/^module [a-z0-9_-]*().*make..\?me.*$$/!d;s/module //;s/().*/.stl/' print.scad)

all: stl main_chassie nose_plate side_spring_plate battery_plate receiver_plate nose upper_arms lower_arms lower_arm_plate upper_arm_plate side_stab_x2


%:
	openscad -m make -o stl/$@.stl -D "$@();" print.scad

stl:
	mkdir stl
