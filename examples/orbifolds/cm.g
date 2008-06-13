# cm (c1m1)

# http://en.wikipedia.org/wiki/Wallpaper_group#Group_cm


M := [ [1,2,4], [1,4,9], [2,3,5], [2,4,5], [3,5,6], [3,6,7], [4,5,7], [4,6,7], [4,6,9], [5,6,8], [5,7,8], [6,8,9] ];

G := Group( (1,2) );

Isotropy := rec( 1 := G, 2 := G, 3 := G, 7 := G, 8 := G, 9 := G );

mult := [];

dim := 3;

# matrices = [ <A homalg internal 12 by 118 matrix>, <A homalg internal 118 by 568 matrix>, <A homalg internal 568 by 2965 matrix>, <A homalg internal 2965 by 17278 matrix> ]

# factors = [ 9.8, 4.8, 5.2, 5.8 ]

#cohomology over Z:
#---------->>>>  Z^(1 x 1)
#---------->>>>  Z^(1 x 1)
#---------->>>>  Z/< 2 >
#---------->>>>  Z/< 2 >

#cohomology over GF(2):
# GF(2)^(1 x 1)
# GF(2)^(1 x 2)
# GF(2)^(1 x 2)
# GF(2)^(1 x 2)
# GF(2)^(1 x 2)
# GF(2)^(1 x 2)

#cohomology over Z/4Z:
#---->>>>  Z/4Z^(1 x 1)
#---->>>>  Z/4Z/< ZmodnZObj(2,4) > + Z/4Z^(1 x 1)
#---->>>>  Z/4Z/< ZmodnZObj(2,4) > + Z/4Z/< ZmodnZObj(2,4) >
#---->>>>  Z/4Z/< ZmodnZObj(2,4) > + Z/4Z/< ZmodnZObj(2,4) >
#---->>>>  Z/4Z/< ZmodnZObj(2,4) > + Z/4Z/< ZmodnZObj(2,4) >

#cohomology over Z: Z, Z, [ Z/2Z ]
#  homology over Z: Z, Z + Z/2Z, [ Z/2Z ]
