#cmm (c2mm)

#http://en.wikipedia.org/wiki/Wallpaper_group#Group_cmm

M := [ [1,2,4], [1,4,7], [2,3,6], [2,4,5], [2,5,6], [3,6,7], [4,5,8], [4,7,8], [5,6,9], [5,8,9], [6,7,8], [6,8,9] ];

G1 := Group( (1,2) );
G2 := Group( (3,4) );
C := Group( (1,2)(3,4) );
V4 := Group( (1,2),(3,4) );

Isotropy := rec( 1 := V4, 2 := G1, 3 := V4, 7 := G2, 9 := C );

mult:=[
[ [6], [6,9], [5,6,9], [6,8,9], x -> (1,2)(3,4) ],
[ [6], [6,9], [6,8,9], [5,6,9], x -> (1,2)(3,4) ]
];

dim := 2;

#matrix sizes: 
# [ 124, 709, 4517, 30692, 211056, 1458659 ]
#factors:
# [ 5.71774, 6.37094, 6.79478, 6.87658, 6.91124 ]

#cohomology over Z:
#---------->>>>  Z^(1 x 1)
#---------->>>>  0
#---------->>>>  Z/< 2 > + Z/< 2 > + Z/< 2 >

#cohomology over Z, guessed based on Z/nZ calculations and the fact that the orbifold is concatinable:
#---------->>>>  Z^(1 x 1)
#---------->>>>  0
#---------->>>>  Z/< 2 > ^ 3
#---------->>>>  Z/< 2 > ^ 2
#---------->>>>  Z/< 2 > ^ 5
#---------->>>>  Z/< 2 > ^ 4
#---------->>>>  Z/< 2 > ^ 7
# V4 leads to growing non-periodic cohomologies

#cohomology over GF(2):
# 1: 12 x 124 matrix with rank 11 and kernel dimension 1.
# 2: 124 x 709 matrix with rank 110 and kernel dimension 14.
# 3: 709 x 4517 matrix with rank 594 and kernel dimension 115.
# 4: 4517 x 30692 matrix with rank 3916 and kernel dimension 601.
# 5: 30692 x 211056 matrix with rank 26767 and kernel dimension 3925.
# 6: 211056 x 1458659 matrix with rank 184278 and kernel dimension 26778.
# Cohomology dimension at degree 0:  GF(2)^(1 x 1)
# Cohomology dimension at degree 1:  GF(2)^(1 x 3)
# Cohomology dimension at degree 2:  GF(2)^(1 x 5)
# Cohomology dimension at degree 3:  GF(2)^(1 x 7)
# Cohomology dimension at degree 4:  GF(2)^(1 x 9)
# Cohomology dimension at degree 5:  GF(2)^(1 x 11)
    

#cohomology over Z/4Z:
#---------->>>>  Z/4Z^(1 x 1)
#---------->>>>  Z/4Z/< ZmodnZObj(2,4) > ^ (1 x 3) (changed for better readability)
#---------->>>>  Z/4Z/< ZmodnZObj(2,4) > ^ (1 x 5) (same here)
#---------->>>>  Z/4Z/< ZmodnZObj(2,4) > ^ (1 x 7) (same here)
