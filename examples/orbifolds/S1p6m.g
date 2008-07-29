# p6m (p6mm)

# http://en.wikipedia.org/wiki/Wallpaper_group#Group_p6m

M:=[ [1,2], [1,6], [2,3], [3,5], [5,7], [6,7] ];

C2n := Group( (1,4)(2,3)(5,6) ); #north
C2e := Group( (2,6)(3,5) );      #east
C2sw := Group( (1,3)(4,6) );     #southwest

D12 := Group( (1,4)(2,3)(5,6), (1,3)(4,6) ); #north and southwest
D6 := Group( (2,6)(3,5), (1,3)(4,6) );       #east and southwest
D4 := Group( (1,4)(2,3)(5,6), (2,6)(3,5) ); #north and east

iso := rec( 1 := D12, 2 := C2n, 3 := D4, 5 := C2e, 6 := C2sw, 7 := D6 );

mu := [];

dim := 3;

# 1: 6 x 94 matrix with rank 5 and kernel dimension 1. Time: 0.000 sec.
# 2: 94 x 1446 matrix with rank 86 and kernel dimension 8. Time: 0.004 sec.
# 3: 1446 x 27838 matrix with rank 1356 and kernel dimension 90. Time: 0.980 sec.
# 4: 27838 x 594246 matrix with rank 26476 and kernel dimension 1362. Time: 401.141 sec.
# Cohomology dimension at degree 0:  GF(2)^(1 x 1)
# Cohomology dimension at degree 1:  GF(2)^(1 x 3)
# Cohomology dimension at degree 2:  GF(2)^(1 x 4)
# Cohomology dimension at degree 3:  GF(2)^(1 x 6)
