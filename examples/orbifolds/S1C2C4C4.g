# S1 with C2-iso and two C4-points

#    1 C4
#   2 3
#    4 C4

#tricky:
# C4 1     2 C4
#       3
#   C2 4 5

M := [ [1,3], [2,3], [3,4], [3,5], [4,5] ];
C2 := Group( (1,3)(2,4) );
C4 := Group( (1,2,3,4) );
iso := rec( 1 := C4, 2 := C4, 3 := C2, 4 := C2, 5 := C2 );
mu := [];
dim := 4;


