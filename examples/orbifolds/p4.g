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
dim := 3;

#matrix sizes:
# [ <A homalg internal 10 by 121 matrix>,
#   <A homalg internal 121 by 970 matrix>,
#   <A homalg internal 970 by 9390 matrix>,
#   <A homalg internal 9390 by 97462 matrix> ]
#factors:
# [ 12.1, 8.01653, 9.68041, 10.3793 ]
    

#cohomology over GF(2):
#------->>>>  GF(2)^(1 x 1)
#------->>>>  GF(2)^(1 x 2)
#------->>>>  GF(2)^(1 x 3)

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
