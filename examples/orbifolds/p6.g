# p6

# http://en.wikipedia.org/wiki/Wallpaper_group#Group_p6

M := [ [1,2,4], [1,2,6], [1,4,6], [2,3,4], [2,3,6], [3,4,5], [3,5,6], [4,5,7], [4,6,7], [5,6,7] ];
C6 := Group( (1,2,3,4,5,6) );
C3 := Group( (1,3,5)(2,4,6) );
C2 := Group( (1,4)(2,5)(3,6) );
Isotropy := rec( 1 := C6, 3 := C2, 7 := C3 );
mult:=[
[ [2], [1,2], [1,2,4], [1,2,6], x -> x * (1,2,3,4,5,6) ],
[ [2], [1,2], [1,2,6], [1,2,4], x -> x * (1,6,5,4,3,2) ],
[ [5], [5,7], [4,5,7], [5,6,7], x -> x * (1,3,5)(2,4,6) ],
[ [5], [5,7], [5,6,7], [4,5,7], x -> x * (1,5,3)(2,6,4) ],
];

dim := 3;

#matrix sizes:
# [ 10, 130, 1303, 17679, 272467 ]
#factor:
# [ 13, 10.0231, 13.5679, 15.4119 ]

########## p = 0 ##########
# Z
# 0
# Z + Z/6Z
# 
#

########## p = 2 ##########
#cohomology over GF(2):
# 1: 10 x 130 matrix with rank 9 and kernel dimension 1. Time: 0.000 sec.
# 2: 130 x 1303 matrix with rank 120 and kernel dimension 10. Time: 0.004 sec.
# 3: 1303 x 17679 matrix with rank 1181 and kernel dimension 122. Time: 0.772 se
# 4: 17679 x 272467 matrix with rank 16496 and kernel dimension 1183. Time: 165.758 sec.
# 5: 272467 x 4425105 matrix with rank 255969 and kernel dimension 16498. Time: 50295.215 sec. (14 h, 7 GB)
# Cohomology dimension at degree 0:  GF(2)^(1 x 1)
# Cohomology dimension at degree 1:  GF(2)^(1 x 1)
# Cohomology dimension at degree 2:  GF(2)^(1 x 2)
# Cohomology dimension at degree 3:  GF(2)^(1 x 2)
# Cohomology dimension at degree 4:  GF(2)^(1 x 2)


#cohomology over Z/4Z:
#------------------------------------->>>>  Z/4Z^(1 x 1)
#------------------------------------->>>>  Z/4Z/< ZmodnZObj(2,4) > 
#------------------------------------->>>>  Z/4Z/< ZmodnZObj(2,4) > + Z/4Z^(1 x 1)
 

########## p = 3 ##########
#cohomology over GF(3):
#----------------------------------------------->>>>  GF(3)^(1 x 1)
#----------------------------------------------->>>>  GF(3)^(1 x 1)
#----------------------------------------------->>>>  GF(3)^(1 x 2)

#cohomology over Z/9Z:
#------------------------------------->>>>  Z/9Z^(1 x 1)
#------------------------------------->>>>  Z/9Z/< ZmodnZObj(3,9) > 
#------------------------------------->>>>  Z/9Z/< ZmodnZObj(3,9) > + Z/9Z^(1 x 1)


########## p = 5 ##########
#cohomology over GF(5):
#----------------------------------------------->>>>  GF(5)^(1 x 1)
#----------------------------------------------->>>>  0
#----------------------------------------------->>>>  GF(5)^(1 x 1)
