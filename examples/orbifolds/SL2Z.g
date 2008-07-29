#The PSL2Z Orbifold, \infinity is one vertex with \Z-iso, therefore a S^1 on 1

#M := [ [1,8], [1,9], [8,9], [1,2,3], [1,2,4], [1,3,4], [2,3,5], [2,4,5], [3,4,7], [3,5,6], [3,6,7], [4,5,6], [4,6,7] ];

C2 := Group( [[-1,0],[0,-1]] );
J := Group( [[0,-1],[1,0]] ); #at i
U := Group( [[1,-1],[1,0]] ); #at \rho

#iso := rec( 1 := C2, 2 := C2, 3:= C2, 4 := C2, 5 := U, 6 := C2, 7 := J, 8 := C2, 9 := C2 );

#mu := [
#[ [6], [6,7], [3,6,7], [4,6,7], x -> x * [[-1,0],[0,-1]] ],
#[ [6], [6,7], [4,6,7], [3,6,7], x -> x * [[-1,0],[0,-1]] ]
#];

#smaller version:

#M := [ [1,2,3], [1,2,4], [1,3,5], [1,4,5], [2,3,5], [2,4,5], [1,6], [1,7], [6,7] ];

#iso := rec( 1 := C2, 2 := C2, 3 := J, 4 := U, 5 := C2, 6 := C2, 7 := C2 );

#minimal noncompacted version:

M := [ [1,2], [1,3], [2,3], [3,4], [3,5] ];

iso := rec( 1 := C2, 2 := C2, 3 := C2, 4 := J, 5 := U );

mu := [];

dim := 2;


# 1: 9 x 97 matrix with rank 8 and kernel dimension 1. Time: 0.000 sec.
# 2: 97 x 601 matrix with rank 87 and kernel dimension 10. Time: 0.004 sec.
# 3: 601 x 3409 matrix with rank 511 and kernel dimension 90. Time: 0.616 sec.
# 4: 3409 x 20153 matrix with rank 2895 and kernel dimension 514. Time: 4.692 sec.
# 5: 20153 x 123729 matrix with rank 17255 and kernel dimension 2898. Time: 198.629 sec.
# Cohomology dimension at degree 0:  GF(2)^(1 x 1)
# Cohomology dimension at degree 1:  GF(2)^(1 x 2)
# Cohomology dimension at degree 2:  GF(2)^(1 x 3)
# Cohomology dimension at degree 3:  GF(2)^(1 x 3)
# Cohomology dimension at degree 4:  GF(2)^(1 x 3)
