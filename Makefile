# make -j for multi threaded
# match "module foobar() { // `make` me"
#TARGETS=$(shell sed '/^module [a-z0-9_-]*().*make..\?me.*$$/!d;s/module //;s/().*/.stl/' print.scad)

all: stl main_chassie nose_plate side_spring_plate battery_plate receiver_plate nose upper_arms lower_arms lower_arm_plate upper_arm_plate side_stab_x2 side_stab2_x2 steering_hubs body_posts wing_adapter arm_pin cradle_bottomPlate cradle_leftBulkhead cradle_rightBulkhead cradle_wingPlate cradle_bottomPlate_wide frontwing frontwingflex indrive outdrive left_wheelmount skid_guard steering_link gear_adapter wingelement spur_gear side_damper pinion_gear_18t pinion_gear_17t pinion_gear_16t pinion_gear_15t legacy_nose_body_mount_plate legacy_body_mount_plate legacy_nose front_body_broken legacy_body_battery_plate front_mount
	
springs: plastic_rear_spring_3 plastic_rear_spring_4 plastic_rear_spring_5  plastic_rear_spring_6 plastic_rear_spring_7 plastic_rear_spring_8 plastic_rear_spring_9  plastic_rear_spring_10

%:
	openscad -m make -o stl/$@.stl -D "$@();" print.scad

stl:
	mkdir stl
