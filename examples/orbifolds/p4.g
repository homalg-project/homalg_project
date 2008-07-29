# p4

# http://en.wikipedia.org/wiki/Wallpaper_group#Group_p4

M := [ [1,2,4], [1,2,6], [1,4,6], [2,3,4], [2,3,5], [2,5,6], [3,4,5], [4,5,7], [4,6,7], [5,6,7]];
C4 := Group( (1,2,3,4) );
C2 := Group( (1,3)(2,4) );
iso := rec( 1 := C4, 3 := C2, 7 := C4 );
mu:=[
[ [2], [1,2], [1,2,4], [1,2,5], x -> x*(1,2,3,4) ],
[ [2], [1,2], [1,2,5], [1,2,4], x -> x*(1,4,3,2) ],
[ [5], [5,7], [4,5,7], [5,6,7], x -> x*(1,2,3,4) ],
[ [5], [5,7], [5,6,7], [4,5,7], x -> x*(1,4,3,2) ]
];
dim := 3;



# 1: 10 x 85 matrix with rank 9 and kernel dimension 1. Time: 0.000 sec.
# 2: 85 x 322 matrix with rank 74 and kernel dimension 11. Time: 0.004 sec.
# 3: 322 x 1226 matrix with rank 245 and kernel dimension 77. Time: 0.024 sec.
# 4: 1226 x 4998 matrix with rank 978 and kernel dimension 248. Time: 0.524 sec.
# 5: 4998 x 20124 matrix with rank 4017 and kernel dimension 981. Time: 9.073 sec.
# 6: 20124 x 78722 matrix with rank 16104 and kernel dimension 4020. Time: 155.502 sec.
# 7: 78722 x 299594 matrix with rank 62615 and kernel dimension 16107. Time: 2465.850 sec.
# Cohomology dimension at degree 0:  GF(2)^(1 x 1)
# Cohomology dimension at degree 1:  GF(2)^(1 x 2)
# Cohomology dimension at degree 2:  GF(2)^(1 x 3)
# Cohomology dimension at degree 3:  GF(2)^(1 x 3)
# Cohomology dimension at degree 4:  GF(2)^(1 x 3)
# Cohomology dimension at degree 5:  GF(2)^(1 x 3)
# Cohomology dimension at degree 6:  GF(2)^(1 x 3)

#----------------------------------------------->>>>  Z/4Z^(1 x 1)
#----------------------------------------------->>>>  Z/4Z/< ZmodnZObj(2,4) > + Z/4Z^(1 x 1)
#----------------------------------------------->>>>  Z/4Z/< ZmodnZObj(2,4) > + Z/4Z^(1 x 2)
#----------------------------------------------->>>>  Z/4Z/< ZmodnZObj(2,4) > + Z/4Z^(1 x 2)
#----------------------------------------------->>>>  Z/4Z/< ZmodnZObj(2,4) > + Z/4Z^(1 x 2)

#---------------------------------------------------------------------------------------------

#matrix sizes:
# [ <A homalg internal 10 by 121 matrix>,
#   <A homalg internal 121 by 970 matrix>,
#   <A homalg internal 970 by 9390 matrix>,
#   <A homalg internal 9390 by 97462 matrix> ]
#factors:
# [ 12.1, 8.01653, 9.68041, 10.3793 ]
    

#cohomology over GF(2):
# 1: 10 x 121 matrix with rank 9 and kernel dimension 1. Time: 0.000 sec.
# 2: 121 x 970 matrix with rank 110 and kernel dimension 11. Time: 0.004 sec.
# 3: 970 x 9390 matrix with rank 857 and kernel dimension 113. Time: 0.344 sec.
# 4: 9390 x 97462 matrix with rank 8530 and kernel dimension 860. Time: 31.850 sec.
# 5: 97462 x 1033536 matrix with rank 88929 and kernel dimension 8533. Time: 3866.933 sec.
# Cohomology dimension at degree 0:  GF(2)^(1 x 1)
# Cohomology dimension at degree 1:  GF(2)^(1 x 2)
# Cohomology dimension at degree 2:  GF(2)^(1 x 3)
# Cohomology dimension at degree 3:  GF(2)^(1 x 3)
# Cohomology dimension at degree 4:  GF(2)^(1 x 3)

#cohomology over GF(3): (just for the topology)
#------->>>>  GF(3)^(1 x 1)
#------->>>>  0
#------->>>>  GF(3)^(1 x 1)

#cohomology over Z/4Z:
#------->>>>  Z/4Z^(1 x 1)
#------->>>>  Z/4Z/< ZmodnZObj(2,4) > + Z/4Z^(1 x 1)
#------->>>>  Z/4Z/< ZmodnZObj(2,4) > + Z/4Z^(1 x 2) (this is Z + Z/4Z)
#------->>>>  Z/4Z/< ZmodnZObj(2,4) > + Z/4Z^(1 x 2)

#cohomology over Z/8Z:
#------->>>>  Z/8Z^(1 x 1)
#------->>>>  Z/8Z/< ZmodnZObj(4,8) > + Z/8Z/< ZmodnZObj(2,8) >
#------->>>>  Z/8Z/< ZmodnZObj(4,8) > + Z/8Z/< ZmodnZObj(2,8) > + Z/8Z^(1 x 1)

#cohomology over Z (wild guess, but Z/4Z is probably high enough and Z/8Z most likely):
#               Z
#               0
# Z/4Z + Z/2Z + Z
#               0?
