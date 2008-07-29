# Line with C2-iso and a V4-point in between

M := [ [1,2], [2,3] ];
C21 := Group( (1,2) );
C22 := Group( (3,4) );
V4 := Group( (1,2), (3,4) );
iso := rec( 1 := C21, 2 := V4, 3 := C22 );
mu := [];
dim := 5;

#
