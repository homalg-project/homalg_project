# S1 with C2-iso and a V4-point

#  1
# 2 3

M := [ [1,2], [1,3], [2,3] ];
C2 := Group( (1,2) );
V4 := Group( (1,2), (3,4) );
iso := rec( 1 := V4, 2 := C2, 3 := C2 );
mu := [];
dim := 4;

# 1: 3 x 15 matrix with rank 2 and kernel dimension 1. Time: 0.000 sec.
# 2: 15 x 51 matrix with rank 10 and kernel dimension 5. Time: 0.000 sec.
# 3: 51 x 175 matrix with rank 37 and kernel dimension 14. Time: 0.000 sec.
# 4: 175 x 611 matrix with rank 133 and kernel dimension 42. Time: 0.008 sec.
# 5: 611 x 2127 matrix with rank 472 and kernel dimension 139. Time: 0.152 sec.
# 6: 2127 x 7315 matrix with rank 1648 and kernel dimension 479. Time: 1.704 sec.
# 7: 7315 x 24815 matrix with rank 5659 and kernel dimension 1656. Time: 22.466 sec.
# 8: 24815 x 83139 matrix with rank 19147 and kernel dimension 5668. Time: 250.579 sec.
# 9: 83139 x 275599 matrix with rank 63982 and kernel dimension 19157. Time: 2728.791 sec.
# Cohomology dimension at degree 0:  GF(2)^(1 x 1)
# Cohomology dimension at degree 1:  GF(2)^(1 x 3)
# Cohomology dimension at degree 2:  GF(2)^(1 x 4)
# Cohomology dimension at degree 3:  GF(2)^(1 x 5)
# Cohomology dimension at degree 4:  GF(2)^(1 x 6)
# Cohomology dimension at degree 5:  GF(2)^(1 x 7)
# Cohomology dimension at degree 6:  GF(2)^(1 x 8)
# Cohomology dimension at degree 7:  GF(2)^(1 x 9)
# Cohomology dimension at degree 8:  GF(2)^(1 x 10)

#---->>>>  Z/4Z^(1 x 1)
#---->>>>  Z/4Z/< 2 > ^ 2 + Z/4Z^(1 x 1)
#---->>>>  Z/4Z/< 2 > ^ 4
#---->>>>  Z/4Z/< 2 > ^ 5
#---->>>>  Z/4Z/< 2 > ^ 6
#---->>>>  Z/4Z/< 2 > ^ 7
#---->>>>  Z/4Z/< 2 > ^ 8

#-------------------------------------------------------------------------------------------------

# 1: 3 x 23 matrix with rank 2 and kernel dimension 1. Time: 0.000 sec.
# 2: 23 x 131 matrix with rank 18 and kernel dimension 5. Time: 0.000 sec.
# 3: 131 x 791 matrix with rank 109 and kernel dimension 22. Time: 0.004 sec.
# 4: 791 x 5123 matrix with rank 677 and kernel dimension 114. Time: 0.268 sec.
# 5: 5123 x 34583 matrix with rank 4440 and kernel dimension 683. Time: 13.261 sec.
# 6: 34583 x 238211 matrix with rank 30136 and kernel dimension 4447. Time: 474.842 sec.
# 7: 238211 x 1655831 matrix with rank 208067 and kernel dimension 30144. Time: 23681.316 sec.
# Cohomology dimension at degree 0:  GF(2)^(1 x 1)
# Cohomology dimension at degree 1:  GF(2)^(1 x 3)
# Cohomology dimension at degree 2:  GF(2)^(1 x 4)
# Cohomology dimension at degree 3:  GF(2)^(1 x 5)
# Cohomology dimension at degree 4:  GF(2)^(1 x 6)
# Cohomology dimension at degree 5:  GF(2)^(1 x 7)
# Cohomology dimension at degree 6:  GF(2)^(1 x 8)

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

