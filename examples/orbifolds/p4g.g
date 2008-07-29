#p4g (p4gm)

# http://en.wikipedia.org/wiki/Wallpaper_group#Group_p4g

M := [ [1,2,3], [1,2,4], [1,3,4], [2,3,6], [2,4,7], [2,5,6], [2,5,7], [3,4,7], [3,6,7] ];

C4 := Group( (1,2,3,4) );
C2 := Group( (1,2)(3,4) );
V4 := Group( (1,2)(3,4), (1,4)(2,3) );

iso := rec( 1 := C4, 5 := V4, 6 := C2, 7 := C2 );

mu := [
[ [2], [1,2], [1,2,3], [1,2,4], x -> (1,2,3,4) * x ],
[ [2], [1,2], [1,2,4], [1,2,3], x -> (1,4,3,2) * x ],
];

dim := 3;

# 1: 9 x 72 matrix with rank 8 and kernel dimension 1. Time: 0.000 sec.
# 2: 72 x 251 matrix with rank 61 and kernel dimension 11. Time: 0.004 sec.
# 3: 251 x 858 matrix with rank 185 and kernel dimension 66. Time: 0.032 sec.
# 4: 858 x 3232 matrix with rank 667 and kernel dimension 191. Time: 0.244 sec.
# 5: 3232 x 12390 matrix with rank 2558 and kernel dimension 674. Time: 3.960 sec.
# 6: 12390 x 46985 matrix with rank 9824 and kernel dimension 2566. Time: 63.864 sec.
# 7: 46985 x 175061 matrix with rank 37152 and kernel dimension 9833. Time: 950.632 sec.
# Cohomology dimension at degree 0:  GF(2)^(1 x 1)
# Cohomology dimension at degree 1:  GF(2)^(1 x 3)
# Cohomology dimension at degree 2:  GF(2)^(1 x 5)
# Cohomology dimension at degree 3:  GF(2)^(1 x 6)
# Cohomology dimension at degree 4:  GF(2)^(1 x 7)
# Cohomology dimension at degree 5:  GF(2)^(1 x 8)
# Cohomology dimension at degree 6:  GF(2)^(1 x 9)

#------>>>>  Z/4Z^(1 x 1)
#------>>>>  Z/4Z/< 2 > ^ 2 + Z/4Z^(1 x 1)
#------>>>>  Z/4Z/< 2 > ^ 4 + Z/4Z^(1 x 1)
#------>>>>  Z/4Z/< 2 > ^ 5 + Z/4Z^(1 x 1)
#------>>>>  Z/4Z/< 2 > ^ 6 + Z/4Z^(1 x 1)

#----------------------------------------------------------------------------------------------

#matrix sizes:
# [ 9, 106, 763, 6444, 60208 ]
#factors:
# [ 11.7778, 7.19811, 8.44561, 9.34327 ]

#cohomology over Z:
#------------------->>>>  Z^(1 x 1)
#------------------->>>>  0
#------------------->>>>  Z/< 2 > + Z/< 2 > + Z/< 4 >

#cohomology over Z/2Z:
# 1: 9 x 106 matrix with rank 8 and kernel dimension 1. Time: 0.000 sec.
# 2: 106 x 763 matrix with rank 95 and kernel dimension 11. Time: 0.004 sec.
# 3: 763 x 6444 matrix with rank 663 and kernel dimension 100. Time: 0.220 sec.
# 4: 6444 x 60208 matrix with rank 5775 and kernel dimension 669. Time: 17.505 sec.
# 5: 60208 x 593368 matrix with rank 54426 and kernel dimension 5782. Time: 1475.572 sec.
# Cohomology dimension at degree 0:  GF(2)^(1 x 1)
# Cohomology dimension at degree 1:  GF(2)^(1 x 3)
# Cohomology dimension at degree 2:  GF(2)^(1 x 5)
# Cohomology dimension at degree 3:  GF(2)^(1 x 6)
# Cohomology dimension at degree 4:  GF(2)^(1 x 7)

#cohomology over Z/4Z:
#------------------->>>>  Z/4Z^(1 x 1)
#------------------->>>>  Z/4Z/< ZmodnZObj(2,4) >^(1 x 2) + Z/4Z^(1 x 1)
#------------------->>>>  Z/4Z/< ZmodnZObj(2,4) >^(1 x 4) + Z/4Z^(1 x 1)
#------------------->>>>  Z/4Z/< ZmodnZObj(2,4) >^(1 x 5) + Z/4Z^(1 x 1)
