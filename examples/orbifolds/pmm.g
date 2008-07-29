# pmm (p2mm)

# http://en.wikipedia.org/wiki/Wallpaper_group#Group_pmm

M := [ [1,2,5], [1,4,5], [2,3,5], [3,5,6], [4,5,7], [5,6,9], [5,7,8], [5,8,9] ];
G1 := Group( (1,2) );
G2 := Group( (3,4) );
V := Group( (1,2), (3,4) );
iso := rec( 1 := V, 2 := G1, 3 := V, 4 := G2, 6 := G2, 7 := V, 8 := G1, 9 := V );
mu := [];

dim := 3;

# 1: 8 x 68 matrix with rank 7 and kernel dimension 1. Time: 0.000 sec.
# 2: 68 x 240 matrix with rank 57 and kernel dimension 11. Time: 0.000 sec.
# 3: 240 x 742 matrix with rank 175 and kernel dimension 65. Time: 0.040 sec.
# 4: 742 x 2464 matrix with rank 555 and kernel dimension 187. Time: 0.156 sec.
# 5: 2464 x 8492 matrix with rank 1893 and kernel dimension 571. Time: 1.900 sec.
# 6: 8492 x 29216 matrix with rank 6579 and kernel dimension 1913. Time: 23.461 sec.
# 7: 29216 x 99201 matrix with rank 22613 and kernel dimension 6603. Time: 282.986 sec.
# 8: 99201 x 332488 matrix with rank 76560 and kernel dimension 22641. Time: 3207.540 sec.
# Cohomology dimension at degree 0:  GF(2)^(1 x 1)
# Cohomology dimension at degree 1:  GF(2)^(1 x 4)
# Cohomology dimension at degree 2:  GF(2)^(1 x 8)
# Cohomology dimension at degree 3:  GF(2)^(1 x 12)
# Cohomology dimension at degree 4:  GF(2)^(1 x 16)
# Cohomology dimension at degree 5:  GF(2)^(1 x 20)
# Cohomology dimension at degree 6:  GF(2)^(1 x 24)
# Cohomology dimension at degree 7:  GF(2)^(1 x 28)

#------------------------------------------------------------------------------------------------

#matrix sizes:
# [ 8, 92, 512, 3022, 19904 ]
#factors:
# [ 11.5, 5.56522, 5.90234, 6.58637 ]

#cohomology over Z:
#----------------------------------------------->>>>  Z^(1 x 1)
#----------------------------------------------->>>>  0
#----------------------------------------------->>>>  Z/< 2 > + Z/< 2 > + Z/< 2 > + Z/< 2 >

#cohomology over GF(2):
# 1: 8 x 92 matrix with rank 7 and kernel dimension 1. Time: 0.000 sec.
# 2: 92 x 512 matrix with rank 81 and kernel dimension 11. Time: 0.004 sec.
# 3: 512 x 3022 matrix with rank 423 and kernel dimension 89. Time: 0.120 sec.
# 4: 3022 x 19904 matrix with rank 2587 and kernel dimension 435. Time: 3.909 sec.
# 5: 19904 x 136420 matrix with rank 17301 and kernel dimension 2603. Time: 181.059 sec.
# 6: 136420 x 947024 matrix with rank 119099 and kernel dimension 17321. Time: 6916.352 sec.
# Cohomology dimension at degree 0:  GF(2)^(1 x 1)
# Cohomology dimension at degree 1:  GF(2)^(1 x 4)
# Cohomology dimension at degree 2:  GF(2)^(1 x 8)
# Cohomology dimension at degree 3:  GF(2)^(1 x 12)
# Cohomology dimension at degree 4:  GF(2)^(1 x 16)
# Cohomology dimension at degree 5:  GF(2)^(1 x 20)

#cohomology over Z/4Z:
#----------------------------------------------->>>>  Z/4Z^(1 x 1)
#----------------------------------------------->>>>  Z/4Z/< ZmodnZObj(2,4) >^(1 x 4)
#----------------------------------------------->>>>  Z/4Z/< ZmodnZObj(2,4) >^(1 x 8)
#----------------------------------------------->>>>  Z/4Z/< ZmodnZObj(2,4) >^(1 x 12)

#Z
#0
#  4
#  4
#  8
#  8
#
