# S1 with C2-iso and two V4-points

#    1
#   2 3
#    4

M := [ [1,2], [1,3], [2,4], [3,4] ];
C2 := Group( (1,2) );
V4 := Group( (1,2), (3,4) );
iso := rec( 1 := V4, 2 := C2, 3 := C2, 4 := V4 );
mu := [];
dim := 3;

# 1: 4 x 36 matrix with rank 3 and kernel dimension 1. Time: 0.000 sec.
# 2: 36 x 228 matrix with rank 29 and kernel dimension 7. Time: 0.000 sec.
# 3: 228 x 1476 matrix with rank 193 and kernel dimension 35. Time: 0.016 sec.
# 4: 1476 x 9924 matrix with rank 1275 and kernel dimension 201. Time: 0.752 sec.
# 5: 9924 x 68196 matrix with rank 8639 and kernel dimension 1285. Time: 33.938 sec.
# 6: 68196 x 473508 matrix with rank 59545 and kernel dimension 8651. Time: 1648.507 sec.
# 7: 473508 x 3302916 matrix with rank 413949 and kernel dimension 59559. Time: 77500.892 sec.
# Cohomology dimension at degree 0:  GF(2)^(1 x 1)
# Cohomology dimension at degree 1:  GF(2)^(1 x 4)
# Cohomology dimension at degree 2:  GF(2)^(1 x 6)
# Cohomology dimension at degree 3:  GF(2)^(1 x 8)
# Cohomology dimension at degree 4:  GF(2)^(1 x 10)
# Cohomology dimension at degree 5:  GF(2)^(1 x 12)
# Cohomology dimension at degree 6:  GF(2)^(1 x 14)
