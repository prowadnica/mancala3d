$fa=0.1;$fs=0.1;

$fieldWidth=36;
$fieldDepth=9;
$boardHeight=1;
$fieldDistance=12;
$hingeDiameter=4;
$hingeWall=2;
$hingeLength=4;

h=$fieldDistance*3+$fieldWidth*2;
w=$fieldDistance*9+$fieldWidth*8;
d=$boardHeight+$fieldDepth;

difference() {
cylinder(d=$hingeDiameter, h=h);
cylinder(d=$hingeDiameter-1, h=h);
}