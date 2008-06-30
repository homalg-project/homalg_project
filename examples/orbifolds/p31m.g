# p31m
# http://en.wikipedia.org/wiki/Wallpaper_group#Group_p31m

M := [ [1,2,3], [1,2,4], [1,3,4], [2,3,5], [2,4,5], [3,4,6], [3,5,6], [4,5,7], [4,6,7] ];

S3 := Group( (1,2,3), (1,2) );

C3 := Group( (1,2,3) );

C2 := Group( (1,2) );

Isotropy := rec( 1 := C3, 5 := S3,
                 6 := C2, 7 := C2 );

mult := [
[ [2], [1,2], [1,2,3], [1,2,4], x -> (1,2,3) ],
[ [2], [1,2], [1,2,4], [1,2,3], x -> (1,3,2) ]
];

dim := 2;

# matrix sizes:
# [ 9, 153, 2432, 50651, 1133693 ]
# factors:
# [ 17, 15.8954, 20.8269, 22.3824 ]

#cohomology over Z:
#------->>>>  Z^(1 x 1)
#------->>>>  0
#------->>>>  Z/< 6 >

#homology over Z:
#------->>>>  Z^(1 x 1)
#------->>>>  Z/< 6 >
#------->>>>  Z/< 2 >

# 1: 9 x 153 matrix with rank 8 and kernel dimension 1. Time: 0.000 sec.
# 2: 153 x 2432 matrix with rank 144 and kernel dimension 9. Time: 0.052 sec.
# 3: 2432 x 50651 matrix with rank 2286 and kernel dimension 146. Time: 2.612 sec.
# 4: 50651 x 1133693 matrix with rank 48363 and kernel dimension 2288. Time: 1139.408 sec.
# Cohomology dimension at degree 0:  GF(2)^(1 x 1)
# Cohomology dimension at degree 1:  GF(2)^(1 x 1)
# Cohomology dimension at degree 2:  GF(2)^(1 x 2)
# Cohomology dimension at degree 3:  GF(2)^(1 x 2)

#cohomology over Z/4Z:

#cohomology over Z/8Z:

#cohomology over GF(3):

#cohomology over Z/9Z:

#cohomology over Z/27Z:
