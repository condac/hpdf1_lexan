# Work in progress

Still very much work in progress. Car is only tested on track a few times. But it is good enough to keep up with brand named cars if you are a good driver. 

# HPD F1 Lexan version
Custom version of the HPD F1 to use lexan body. 

## About
This is my custom version of the HPD F1 by Kent Asplund. It still uses the rear parts and wings from his project. Join discussion on Google+ https://plus.google.com/communities/117625327650679845498 

## Material
This version is focused to be printed in Nylon 910 Alloy. The material is soft and I will try to make it as rigid as possible with the material properties that the nylon has. The 910 Alloy is stiff for a nylon material but still very hard to break. 

There should be no problem printing it with PLA or other material, but it might break more easy. 

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
