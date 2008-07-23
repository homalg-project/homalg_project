# p4

# http://en.wikipedia.org/wiki/Wallpaper_group#Group_p4

M := [ [1,2,4], [1,2,6], [1,4,6], [2,3,4], [2,3,6], [3,4,5], [3,5,6], [4,5,7], [4,6,7], [5,6,7]]; #compare to p6, these look alike
C4 := Group( (1,2,3,4) );
C2 := Group( (1,3)(2,4) );
Isotropy := rec( 1 := C4, 3 := C2, 7 := C4 );
mult:=[
[ [2], [1,2], [1,2,4], [1,2,5], x -> x*(1,2,3,4) ],
[ [2], [1,2], [1,2,5], [1,2,4], x -> x*(1,4,3,2) ],
[ [5], [5,7], [4,5,7], [5,6,7], x -> x*(1,2,3,4) ],
[ [5], [5,7], [5,6,7], [4,5,7], x -> x*(1,4,3,2) ]
];
dim := 2;

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
