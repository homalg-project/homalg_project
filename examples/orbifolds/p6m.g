M:=[ [1,2,4], [1,4,6], [2,3,4], [3,4,5], [4,5,7], [4,6,7] ];

C2n := Group( (1,4)(2,3)(5,6) ); #north
C2e := Group( (2,6)(3,5) );      #east
C2sw := Group( (1,3)(4,6) );     #southwest

D12 := Group( (1,4)(2,3)(5,6), (1,3)(4,6) ); #north and southwest
D6 := Group( (2,6)(3,5), (1,3)(4,6) );       #east and southwest
D4 := Group( (1,4)(2,3)(5,6), (2,6)(3,5) ); #north and east

Isotropy := rec( 1 := D12, 2 := C2n, 3 := D4, 5 := C2e, 6 := C2sw, 7 := D6 );

mult := [];

dim := 3;

#matrix sizes
# [ 6, 103, 1466, 27853, 594252 ]
#factor
# [ 17.1667, 14.233, 18.9993, 21.3353 ]

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


#cohomology over Z/4Z:

 

########## p = 3 ##########
#cohomology over GF(3):


#cohomology over Z/9Z:



########## p = 5 ##########
#cohomology over GF(5):

