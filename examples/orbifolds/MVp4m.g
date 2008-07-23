# S1 with C2-Isotropy, one V4-point, two D8-points

#    1
#   2 3
#  4 5 6

M := [ [1,2], [1,3], [2,4], [3,6], [4,5], [5,6] ];

c1 := (2,8)(3,7)(4,6);
c2 := (1,5)(2,4)(6,8);
cd := (1,3)(4,8)(5,7);
C1 := Group( c1 );
C2 := Group( c2 );
CD := Group( cd );
V4 := Group( c1, c2 );
D8 := Group( c1, cd );

Isotropy := rec( 1 := V4, 2 := C1, 3 := C2, 4 := D8, 5 := CD, 6 := D8 );
mult := [];
dim := 3;

