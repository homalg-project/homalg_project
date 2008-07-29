# pm (p1m1)

# http://en.wikipedia.org/wiki/Wallpaper_group#Group_pm

M := [ [1,2,5], [1,3,4], [1,4,5], [2,3,6], [2,5,6], [3,4,6], [4,5,8], [4,6,7], [4,7,8], [5,6,9], [5,8,9], [6,7,9] ];
G := Group( (1,2) );
iso := rec( 1 := G, 2 := G, 3 := G, 7 := G, 8 := G , 9 := G );
mu := [];

dim := 3;

#matrix sizes:
# [ 12, 114, 504, 2289, 11262, 56247 ]
#factors:
# [ 9.5, 4.42105, 4.54167, 4.92005, 4.99441 ]

#cohomology over GF(2):
# 1: 12 x 114 matrix with rank 11 and kernel dimension 1. Time: 0.000 sec.
# 2: 114 x 504 matrix with rank 100 and kernel dimension 14. Time: 0.004 sec.
# 3: 504 x 2289 matrix with rank 400 and kernel dimension 104. Time: 0.096 sec.
# 4: 2289 x 11262 matrix with rank 1885 and kernel dimension 404. Time: 1.709 sec.
# 5: 11262 x 56247 matrix with rank 9373 and kernel dimension 1889. Time: 45.922 sec.
# 6: 56247 x 281244 matrix with rank 46870 and kernel dimension 9377. Time: 1260.011 sec.
# Cohomology dimension at degree 0:  GF(2)^(1 x 1)
# Cohomology dimension at degree 1:  GF(2)^(1 x 3)
# Cohomology dimension at degree 2:  GF(2)^(1 x 4)
# Cohomology dimension at degree 3:  GF(2)^(1 x 4)
# Cohomology dimension at degree 4:  GF(2)^(1 x 4)
# Cohomology dimension at degree 5:  GF(2)^(1 x 4)

#cohomology over Z/4Z:
#---------------------------------------->>>>  Z/4Z^(1 x 1)
#---------------------------------------->>>>  Z/4Z/< ZmodnZObj(2,4) >^(1 x 2) + Z/4Z^(1 x 1)
#---------------------------------------->>>>  Z/4Z/< ZmodnZObj(2,4) >^(1 x 4)
#---------------------------------------->>>>  Z/4Z/< ZmodnZObj(2,4) >^(1 x 4)

# H_* ( D_infinity ) = Z, [ Z/2Z^(1 x 2), 0 ]

#-------------------------------------->>>>  Z^(1 x 1)
#-------------------------------------->>>>  Z^(1 x 1)
#-------------------------------------->>>>  Z/< 2 > + Z/< 2 >
#
