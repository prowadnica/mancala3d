$fieldWidth=36;
$fieldDepth=9;
$boardHeight=1;
$fieldDistance=12;
$hingeDiameter=4;
$hingeWall=2;
$hingeLength=4;

module board() {
h=$fieldDistance*3+$fieldWidth*2;
w=$fieldDistance*9+$fieldWidth*8;
d=$boardHeight+$fieldDepth;

translate([-w/2, -h/2, 0]) {
difference() {
union() {
translate([$fieldDistance/2, $fieldDistance/2, 0])
cube([w-$fieldDistance, h-$fieldDistance, d]);
translate([$fieldDistance/2, 0, 0])
cube([w-$fieldDistance, $fieldDistance, d]);
translate([0, $fieldDistance/2, 0])
cube([$fieldDistance, h-$fieldDistance, d]);
translate([$fieldDistance/2, h-$fieldDistance, 0])
cube([w-$fieldDistance, $fieldDistance, d]);
translate([w-$fieldDistance, $fieldDistance/2, 0])
cube([$fieldDistance, h-$fieldDistance, d]);

translate([$fieldDistance/2, $fieldDistance/2, 0]) cylinder(d=$fieldDistance, h=d);

translate([0, h-$fieldDistance, 0])
translate([$fieldDistance/2, $fieldDistance/2, 0]) cylinder(d=$fieldDistance, h=d);

translate([w-$fieldDistance, 0, 0])
translate([$fieldDistance/2, $fieldDistance/2, 0]) cylinder(d=$fieldDistance, h=d);

translate([w-$fieldDistance, h-$fieldDistance, 0])
translate([$fieldDistance/2, $fieldDistance/2, 0]) cylinder(d=$fieldDistance, h=d);

}
for(x=[0:7]) {
cx = $fieldDistance + ($fieldWidth+$fieldDistance)*x+$fieldWidth/2;
for(y=[0:1]) {
cy = (x==0 || x==7)?(h/2):($fieldDistance+($fieldWidth+$fieldDistance)*y+$fieldWidth/2);
if(y==0 || (x>0 && x<7))
translate([cx, cy, $boardHeight+$fieldDepth]) {
sx=$fieldWidth/($fieldDepth*2);
sy=(x==0 || x==7)?(($fieldWidth*2+$fieldDistance)/($fieldDepth*2)):sx;
sz=1;
scale([sx, sy, sz])
sphere(d=$fieldDepth*2);
}
}
}



}
}

echo(w,h);
}

module hinge(hinge_h=$hingeLength) {
h=$fieldDistance*3+$fieldWidth*2;
w=$fieldDistance*9+$fieldWidth*8;
d=$boardHeight+$fieldDepth;

hinge_w=$hingeDiameter+$hingeWall*2;
hinge_d = d+$hingeDiameter/2+$hingeWall;

difference() {
translate([0, -hinge_h/2, 0])
union() {
cube([hinge_w, hinge_h, hinge_d-$hingeWall-$hingeDiameter/2]);
translate([hinge_w/2, 0, hinge_d-$hingeWall-$hingeDiameter/2])
resize([hinge_w, hinge_h, $hingeWall*2+$hingeDiameter])
rotate([-90, 0, 0])
cylinder(d=$hingeWall*2+$hingeDiameter, h=hinge_h, $fn=64);
}
translate([$hingeWall+$hingeDiameter/2, 0, d])
rotate([-90, 0, 0])
cylinder(d=$hingeDiameter, h=hinge_h, center=true, $fn=64);
}
}

module hinge_cutout(hinge_h=$hingeLength, margin=0) {
h=$fieldDistance*3+$fieldWidth*2;
w=$fieldDistance*9+$fieldWidth*8;
d=$boardHeight+$fieldDepth;

hinge_w=$hingeDiameter+$hingeWall*2;
hinge_d = d+$hingeDiameter/2+$hingeWall;

translate([0, -hinge_h/2, 0])
cube([margin+hinge_w, hinge_h, hinge_d]);
}

module hinge_roof(hinge_h=$hingeLength) {
h=$fieldDistance*3+$fieldWidth*2;
w=$fieldDistance*9+$fieldWidth*8;
d=$boardHeight+$fieldDepth;

hinge_w=$hingeDiameter+$hingeWall*2;
hinge_d = d+$hingeDiameter/2+$hingeWall;

translate([0, -hinge_h, 0])
rotate([0, 0, 180]) hinge();
translate([0, hinge_h, 0])
rotate([0, 0, 180]) hinge();
}

module part1() {
h=$fieldDistance*3+$fieldWidth*2;
w=$fieldDistance*9+$fieldWidth*8;
d=$boardHeight+$fieldDepth;
hinge_w=$hingeDiameter+$hingeWall*2;
difference() {
board();
translate([0, -h/2, 0])
cube([w/2, h, d]);
translate([-hinge_w/2, -h/2, 0])
cube([hinge_w, h, d]);
translate([-hinge_w/2, -h/2+$fieldDistance/2, 0])
hinge_cutout($hingeLength);
translate([-hinge_w/2, h/2-$fieldDistance/2, 0])
hinge_cutout($hingeLength);
}
translate([-hinge_w/2, -h/2+$fieldDistance/2, 0])
hinge();
translate([-hinge_w/2, h/2-$fieldDistance/2, 0])
hinge();
}

module part2() {
h=$fieldDistance*3+$fieldWidth*2;
w=$fieldDistance*9+$fieldWidth*8;
d=$boardHeight+$fieldDepth;
hinge_w=$hingeDiameter+$hingeWall*2;
difference() {
union() {
difference() {
board();
translate([-w/2, -h/2, 0])
cube([w/2, h, d]);
translate([hinge_w/2, 0, 0])
rotate([0, 0, 180])
hinge_cutout(h);
}
translate([hinge_w/2, 0, 0])
rotate([0, 0, 180])
hinge(h);
}
translate([hinge_w/2, -h/2+$fieldDistance/2, 0])
rotate([0, 0, 180])
hinge_cutout($hingeLength+0.5, 0.25);
translate([hinge_w/2, h/2-$fieldDistance/2, 0])
rotate([0, 0, 180])
hinge_cutout($hingeLength+0.5, 0.25);
}
}

h=$fieldDistance*3+$fieldWidth*2;
w=$fieldDistance*9+$fieldWidth*8;
d=$boardHeight+$fieldDepth;
hinge_w=$hingeDiameter+$hingeWall*2;

/*
difference() {
part1();
translate([-w/2, -h/2, 0])
cube([w/2-hinge_w, h, d]);
translate([hinge_w, -h/2, 0])
cube([w/2-hinge_w, h, d]);
}
translate([-w/2, h+5, 0])
difference() {
part2();
translate([-w/2, -h/2, 0])
cube([w/2-hinge_w, h, d]);
translate([hinge_w, -h/2, 0])
cube([w/2-hinge_w, h, d]);
}
*/

part1();
//part2();