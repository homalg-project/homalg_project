# Line with C2-Isotropy and a V4-point in between

M := [ [1,2], [2,3] ];
C2 := Group( (1,2) );
V4 := Group( (1,2), (3,4) );
Isotropy := rec( 1 := V4, 2 := C2, 3 := V4 );
mult := [];
dim := 5;

# 1: 2 x 10 matrix with rank 1 and kernel dimension 1. Time: 0.000 sec.
# 2: 10 x 34 matrix with rank 6 and kernel dimension 4. Time: 0.000 sec.
# 3: 34 x 106 matrix with rank 23 and kernel dimension 11. Time: 0.000 sec.
# 4: 106 x 322 matrix with rank 76 and kernel dimension 30. Time: 0.004 sec.
# 5: 322 x 970 matrix with rank 237 and kernel dimension 85. Time: 0.036 sec.
# 6: 970 x 2914 matrix with rank 722 and kernel dimension 248. Time: 0.288 sec.
# 7: 2914 x 8746 matrix with rank 2179 and kernel dimension 735. Time: 2.880 sec.
# Cohomology dimension at degree 0:  GF(2)^(1 x 1)
# Cohomology dimension at degree 1:  GF(2)^(1 x 3)
# Cohomology dimension at degree 2:  GF(2)^(1 x 5)
# Cohomology dimension at degree 3:  GF(2)^(1 x 7)
# Cohomology dimension at degree 4:  GF(2)^(1 x 9)
# Cohomology dimension at degree 5:  GF(2)^(1 x 11)
# Cohomology dimension at degree 6:  GF(2)^(1 x 13)
