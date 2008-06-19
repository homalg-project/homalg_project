# D4 = V4

M := [ [1] ];
G := Group( (1,2), (3,4) );
Isotropy := rec( 1 := G );
mult := [];
dim := 8;

# matrix dimensions:
# <A homalg internal 1 by 3 matrix>
# <A homalg internal 3 by 9 matrix>
# <A homalg internal 9 by 27 matrix>
# <A homalg internal 27 by 81 matrix>
# <A homalg internal 81 by 243 matrix>
# <A homalg internal 243 by 729 matrix>
# <A homalg internal 729 by 2187 matrix>
# <A homalg internal 2187 by 6561 matrix>
# factor = 4 - 1 = 3

#cohomology over Z:
#-------------------------->>>>  Z^(1 x 1)
#-------------------------->>>>  0
#-------------------------->>>>  Z/< 2 > + Z/< 2 >
#-------------------------->>>>  Z/< 2 >
#-------------------------->>>>  Z/< 2 > + Z/< 2 > + Z/< 2 >
#-------------------------->>>>  Z/< 2 > + Z/< 2 >
#-------------------------->>>>  Z/< 2 > + Z/< 2 > + Z/< 2 > + Z/< 2 >
#-------------------------->>>>  Z/< 2 > + Z/< 2 > + Z/< 2 >
