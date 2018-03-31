# Work in progress

Still very much work in progress. Car is only tested on track a few times. But it is good enough to keep up with brand named cars if you are a good driver. 

# HPD F1 Lexan version
Custom version of the HPD F1 to use lexan body. 

## About
This is my custom version of the HPD F1 by Kent Asplund. It still uses the rear parts and wings from his project. Join discussion on Google+ https://plus.google.com/communities/117625327650679845498 

## Material
This version is focused to be printed in Nylon 910 Alloy. The material is soft and I will try to make it as rigid as possible with the material properties that the nylon has. The 910 Alloy is stiff for a nylon material but still very hard to break. 

There should be no problem printing it with PLA or other material, but it might break more easy. 

## Non-printed parts
* Low-profile servo
* ESC + Motor
* Shorty LiPo-Pack
* 5pcs MR128-2RS Bearing
* 4pcs MR105-2RS Bearing
* 10pcs 3.175mm (1/8") Diff Balls
* 2pcs M14x28x1.5mm washer
* 170mm M4 threaded rod
* Carbon fiber rod OD 8mm ID 6mm 120mm (Note: All carbon fiber rods must be able to slide into each other)
* Carbon fiber rod OD 6mm ID 4mm 120mm
* Carbon fiber rod OD 10mm ID 8mm 120mm ( for future upgrade, still in development ) 
* 3pcs M3 Locknuts
* ~4pcs Mx6 button screws
* ~18pcs M3x10 button screws
* ~4pcs M3x12 button screws
* ~15pcs M3x16 button screws
* ~8pcs M3x10 Flat screws

## Bulding instructions

### Rear axle
The rear axle parts in this is for carbon fiber rods. 
M4 threaded rod 167mm
Carbon fiber rod OD 8mm ID 6mm 120mm
Carbon fiber rod OD 6mm ID 4mm 120mm

Alternative any other rods with same dimention or a 8mm rod with 4mm inner diameter. 

Cut carbon fiber rods to 120mm (longer is better than shorter, a longer axle can be compensated with washers, a shorter is useless)
You need 2 rods one 8mm outer diameter and one 6mm outer diameter both with 1mm thickness so you can slide the 6mm rod into the 8mm rod and then the M4 rod inside. And then glue them all together with the M4 sticking out 22mm on the right side (diff side). 

Place one regular M4 nut on the diff side with a washer between the nut and rods. The washer must be smaller than 8mm OD so bearings can slide over it. If you don't have washers that fit just ignore them. Don't tighthen the nut because this will break the glue inside. The nut is just there to take stress off the glue in case you crash or the glue fails. 

On the other side where we just want a wheel to fit place a <8mm washer if you have it and then 2 M4 Lock nuts placed with the nylon locking side towards each other. Do not tighten the nuts towards the rod to hard. Tighten the nuts against each other. These nuts will transfer all the torque from the axle to the wheel so tighten it hard against each other will make it stay in place. It will want to get loose on braking if your wheel nut is loose. Acceleration will make it self tightening so there is very little chance of it coming loose during driving. 

Last glue the indrive in place. Best way to place the indrive right is to screw on a extra m4 nut on the diff side and assemble everything with gears diffplates and diff balls and you will see where the indrive want to be placed. The extra M4 nut creates a perfect space inside, and when you remove it after gluing the indrive in place you will have a gap between the wheel and axle where it can rotate free. 

## Make stl

### In Linux (or OSX)
* checkout project
* Make sure you have OpenSCAD installed
* Type "make all" in prompt

### Manual in OpenSCAD (Windows users)
* open print.scad
* type the module name you want to print in the code and compile (F6)

## Working with the files
Having parts in different files and working with multiple OpenSCAD programs open for all files is working very good (for me atleast). When you save a file and change window to another file that have the other file as a previev or included part it will automaticly update it. And having git to save changes you want and don't want saving a lot when testing is not harmfull for your files even if you screw up because you can use git to revert to the last time you did a commit. 

print.scad is used to print parts in the right rotation for printing. 

hpdf1_lexan.scad is a preview to see all parts in the right places
