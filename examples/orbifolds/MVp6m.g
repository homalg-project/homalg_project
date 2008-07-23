# S1 with C2-Isotropy and V4, D6 and D12-points.

#  1 2 3
#    6 5
#      7

M:=[ [1,2], [1,6], [2,3], [3,5], [5,7], [6,7] ];

C2n := Group( (1,4)(2,3)(5,6) ); #north
C2e := Group( (2,6)(3,5) );      #east
C2sw := Group( (1,3)(4,6) );     #southwest

D12 := Group( (1,4)(2,3)(5,6), (1,3)(4,6) ); #north and southwest
D6 := Group( (2,6)(3,5), (1,3)(4,6) );       #east and southwest
V4 := Group( (1,4)(2,3)(5,6), (2,6)(3,5) ); #north and east

Isotropy := rec( 1 := D12, 2 := C2n, 3 := V4, 5 := C2e, 6 := C2sw, 7 := D6 );

mult := [];

dim := 3;

