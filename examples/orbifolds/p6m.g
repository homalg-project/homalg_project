# p6m (p6mm)

# http://en.wikipedia.org/wiki/Wallpaper_group#Group_p6m

M:=[ [1,2,4], [1,4,6], [2,3,4], [3,4,5], [4,5,7], [4,6,7] ];

C2n := Group( (1,4)(2,3)(5,6) ); #north
C2e := Group( (2,6)(3,5) );      #east
C2sw := Group( (1,3)(4,6) );     #southwest

D12 := Group( (1,4)(2,3)(5,6), (1,3)(4,6) ); #north and southwest
D6 := Group( (2,6)(3,5), (1,3)(4,6) );       #east and southwest
V4 := Group( (1,4)(2,3)(5,6), (2,6)(3,5) ); #north and east

iso := rec( 1 := D12, 2 := C2n, 3 := V4, 5 := C2e, 6 := C2sw, 7 := D6 );

mu := [];

dim := 3;

#matrix sizes
# [ 6, 103, 1466, 27853, 594252 ]
#factor
# [ 17.1667, 14.233, 18.9993, 21.3353 ]

#----------------------------------------------->>>>  Z^(1 x 1)
#----------------------------------------------->>>>  0
#----------------------------------------------->>>>  Z/< 2 > + Z/< 2 >


########## p = 0 ##########
#cohomology over Z:
#---------------------------
#at cohomology degree: 0
#Z^(1 x 1)
#---------------------------
#at cohomology degree: 1
#0
#---------------------------
#at cohomology degree: 2
#Z/< 2 > + Z/< 2 >
#-------------------------

#homology over Z:
#-------------------------
#at homology degree: 0
#Z^(1 x 1)
#-------------------------
#at homology degree: 1
#Z/< 2 > + Z/< 2 >
#-------------------------
#at homology degree: 2
#Z/< 2 > + Z/< 2 >
#-------------------------



########## p = 2 ##########
#cohomology over GF(2):
# 1: 6 x 103 matrix with rank 5 and kernel dimension 1. Time: 0.000 sec.
# 2: 103 x 1466 matrix with rank 96 and kernel dimension 7. Time: 0.004 sec.
# 3: 1466 x 27853 matrix with rank 1366 and kernel dimension 100. Time: 3.224 sec.
# 4: 27853 x 594252 matrix with rank 26481 and kernel dimension 1372. Time: 494.547 sec.
# Cohomology dimension at degree 0:  GF(2)^(1 x 1)
# Cohomology dimension at degree 1:  GF(2)^(1 x 2)
# Cohomology dimension at degree 2:  GF(2)^(1 x 4)
# Cohomology dimension at degree 3:  GF(2)^(1 x 6)

########## p = 3 ##########
#cohomology over GF(3):

