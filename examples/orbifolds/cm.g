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
# 1: 12 x 118 matrix with rank 11 and kernel dimension 1. Time: 0.000 sec.
# 2: 118 x 568 matrix with rank 105 and kernel dimension 13. Time: 0.004 sec.
# 3: 568 x 2965 matrix with rank 461 and kernel dimension 107. Time: 0.124 sec.
# 4: 2965 x 17278 matrix with rank 2502 and kernel dimension 463. Time: 2.961 sec.
# 5: 17278 x 105211 matrix with rank 14774 and kernel dimension 2504. Time: 113.227 sec.
# 6: 105211 x 659548 matrix with rank 90435 and kernel dimension 14776. Time: 4042.348 sec.
# 7: 659548 x 4236040 matrix with rank 569111 and kernel dimension 90437. Time: 182594.984 sec. (Mem: 2600MB ~ 2.5g)
# Cohomology dimension at degree 0:  GF(2)^(1 x 1)
# Cohomology dimension at degree 1:  GF(2)^(1 x 2)
# Cohomology dimension at degree 2:  GF(2)^(1 x 2)
# Cohomology dimension at degree 3:  GF(2)^(1 x 2)
# Cohomology dimension at degree 4:  GF(2)^(1 x 2)
# Cohomology dimension at degree 5:  GF(2)^(1 x 2)
# Cohomology dimension at degree 6:  GF(2)^(1 x 2)

#cohomology over Z/4Z:
#---->>>>  Z/4Z^(1 x 1)
#---->>>>  Z/4Z/< ZmodnZObj(2,4) > + Z/4Z^(1 x 1)
#---->>>>  Z/4Z/< ZmodnZObj(2,4) > + Z/4Z/< ZmodnZObj(2,4) >
#---->>>>  Z/4Z/< ZmodnZObj(2,4) > + Z/4Z/< ZmodnZObj(2,4) >
#---->>>>  Z/4Z/< ZmodnZObj(2,4) > + Z/4Z/< ZmodnZObj(2,4) >

#cohomology over Z: Z, Z, [ Z/2Z ]
#  homology over Z: Z, Z + Z/2Z, [ Z/2Z ]
