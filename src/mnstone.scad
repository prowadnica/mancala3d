$stoneHeight=4;
$stoneDiameter=12;

module stoneSphere() {
resize([$stoneDiameter, $stoneDiameter, $stoneHeight*0.75*2])
sphere(d=$stoneDiameter);
}

difference() {
translate([0, 0, $stoneHeight*0.25])
stoneSphere();
translate([0, 0, -$stoneHeight*0.75])
cylinder(d=$stoneDiameter, h=$stoneHeight*0.75);
}