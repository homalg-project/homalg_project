# pmm (p2mm)

# http://en.wikipedia.org/wiki/Wallpaper_group#Group_pmm

M := [ [1,2], [1,4], [2,3], [3,6], [4,7], [6,9] ];
G1 := Group( (1,2) );
G2 := Group( (3,4) );
V := Group( (1,2), (3,4) );
iso := rec( 1 := V, 2 := G1, 3 := V, 4 := G2, 6 := G2, 7 := V, 9 := V );
mu := [];

dim := 3;

#matrix sizes pmm:
# [ 8, 92, 512, 3022, 19904 ]
#factors:
# [ 11.5, 5.56522, 5.90234, 6.58637 ]

