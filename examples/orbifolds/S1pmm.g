# pmm (p2mm)

# http://en.wikipedia.org/wiki/Wallpaper_group#Group_pmm

M := [ [1,2], [1,4], [2,3], [3,6], [4,7], [6,9], [7,8], [8,9] ];
G1 := Group( (1,2) );
G2 := Group( (3,4) );
V := Group( (1,2), (3,4) );
Isotropy := rec( 1 := V, 2 := G1, 3 := V, 4 := G2, 6 := G2, 7 := V, 8 := G1, 9 := V );
mult := [];

dim := 3;

#matrix sizes pmm:
# [ 8, 92, 512, 3022, 19904 ]
#factors:
# [ 11.5, 5.56522, 5.90234, 6.58637 ]


# 1: 8 x 72 matrix with rank 7 and kernel dimension 1. Time: 0.000 sec.
# 2: 72 x 456 matrix with rank 60 and kernel dimension 12. Time: 0.004 sec.
# 3: 456 x 2952 matrix with rank 388 and kernel dimension 68. Time: 0.076 sec.
# 4: 2952 x 19848 matrix with rank 2552 and kernel dimension 400. Time: 3.132 sec.
# 5: 19848 x 136392 matrix with rank 17280 and kernel dimension 2568. Time: 144.325 sec.
# 6: 136392 x 947016 matrix with rank 119092 and kernel dimension 17300. Time: 6253.631 sec.
# Cohomology dimension at degree 0:  GF(2)^(1 x 1)
# Cohomology dimension at degree 1:  GF(2)^(1 x 5)
# Cohomology dimension at degree 2:  GF(2)^(1 x 8)
# Cohomology dimension at degree 3:  GF(2)^(1 x 12)
# Cohomology dimension at degree 4:  GF(2)^(1 x 16)
# Cohomology dimension at degree 5:  GF(2)^(1 x 20)
