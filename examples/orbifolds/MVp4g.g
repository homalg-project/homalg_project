# S1 with C2-Isotropy and a V4-point

#  1
# 2 3

M := [ [1,2], [1,3], [2,3] ];
C2 := Group( (1,2) );
V4 := Group( (1,2), (3,4) );
Isotropy := rec( 1 := V4, 2 := C2, 3 := C2 );
mult := [];
dim := 4;

# 1: 3 x 23 matrix with rank 2 and kernel dimension 1. Time: 0.000 sec.
# 2: 23 x 131 matrix with rank 18 and kernel dimension 5. Time: 0.000 sec.
# 3: 131 x 791 matrix with rank 109 and kernel dimension 22. Time: 0.008 sec.
# 4: 791 x 5123 matrix with rank 677 and kernel dimension 114. Time: 0.248 sec.
# 5: 5123 x 34583 matrix with rank 4440 and kernel dimension 683. Time: 10.929 sec.
# 6: 34583 x 238211 matrix with rank 30136 and kernel dimension 4447. Time: 483.906 sec.
# Cohomology dimension at degree 0:  GF(2)^(1 x 1)
# Cohomology dimension at degree 1:  GF(2)^(1 x 3)
# Cohomology dimension at degree 2:  GF(2)^(1 x 4)
# Cohomology dimension at degree 3:  GF(2)^(1 x 5)
# Cohomology dimension at degree 4:  GF(2)^(1 x 6)
# Cohomology dimension at degree 5:  GF(2)^(1 x 7)

#Z
#Z
#  2
#  2
#  3
#  3
#  4
#  4
#  5
#  5

