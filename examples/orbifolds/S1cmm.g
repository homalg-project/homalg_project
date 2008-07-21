# cmm (c2mm)

# http://en.wikipedia.org/wiki/Wallpaper_group#Group_cmm

M := [ [1,2], [1,4], [2,3], [3,4] ];
G1 := Group( (1,2) );
G2 := Group( (3,4) );
V := Group( (1,2), (3,4) );
Isotropy := rec( 1 := V, 2 := G1, 3 := V, 4 := G2 );
mult := [];

dim := 3;

