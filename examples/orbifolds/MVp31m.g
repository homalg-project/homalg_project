# S1 with C2-Isotropy and a D6-point

#  1
# 2 3

M := [ [1,2], [1,3], [2,3] ];
C2 := Group( (1,2) );
D6 := Group( (1,2), (1,2,3) );
Isotropy := rec( 1 := D6, 2 := C2, 3 := C2 );
mult := [];
dim := 4;

# 1: 3 x 31 matrix with rank 2 and kernel dimension 1. Time: 0.000 sec.
# 2: 31 x 275 matrix with rank 27 and kernel dimension 4. Time: 0.000 sec.
# 3: 275 x 2767 matrix with rank 246 and kernel dimension 29. Time: 0.044 sec.
# 4: 2767 x 29603 matrix with rank 2519 and kernel dimension 248. Time: 7.113 sec.
# 5: 29603 x 323071 matrix with rank 27082 and kernel dimension 2521. Time: 317.592 sec.
# Cohomology dimension at degree 0:  GF(2)^(1 x 1)
# Cohomology dimension at degree 1:  GF(2)^(1 x 2)
# Cohomology dimension at degree 2:  GF(2)^(1 x 2)
# Cohomology dimension at degree 3:  GF(2)^(1 x 2)
# Cohomology dimension at degree 4:  GF(2)^(1 x 2)
