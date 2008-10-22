# S1 with C2-iso and two V4-points

#    1 V4
#   2 3
#    4 V4

M := [ [1,2], [1,3], [2,4], [3,4] ];
C2 := Group( (1,2) );
C2b := Group( (3,4) );
V4 := Group( (1,2), (3,4) );
iso := rec( 1 := V4, 2 := C2, 3 := C2, 4 := V4 );
mu := [];
dim := 4;


