# p4m (p4mm)

# http://en.wikipedia.org/wiki/Wallpaper_group#Group_p4m

M := [ [1,2,4], [1,4,5], [2,3,4], [3,4,6], [4,5,7], [4,6,7] ];
c1 := (2,8)(3,7)(4,6);
c2 := (1,5)(2,4)(6,8);
cd := (1,3)(4,8)(5,7);
C1 := Group( c1 );
C2 := Group( c2 );
CD := Group( cd );
V4 := Group( c1, c2 );
D8 := Group( c1, cd );
Isotropy := rec( 1 := D8, 2 := C1, 3 := V4, 5 := CD, 6 := C2, 7 := D8 );
mult := [];

dim := 3;

#matrix sizes:
# [ 6, 95, 1066, 14357, 207788, 3072567 ]
#factors:
# [ 15.8333, 11.2211, 13.4681, 14.4729, 14.7870 ]

#cohomology over Z:
#------------------>>>>  Z^(1 x 1)
#------------------>>>>  0
#------------------>>>>  Z/< 2 > + Z/< 2 > + Z/< 2 >

# 1: 6 x 95 matrix with rank 5 and kernel dimension 1. Time: 0.000 sec.
# 2: 95 x 1066 matrix with rank 87 and kernel dimension 8. Time: 0.004 sec.
# 3: 1066 x 14357 matrix with rank 973 and kernel dimension 93. Time: 0.580 sec.
# 4: 14357 x 207788 matrix with rank 13375 and kernel dimension 982. Time: 114.411 sec.
# 5: 207788 x 3072567 matrix with rank 194401 and kernel dimension 13387. Time: 17064.879 sec.
# Cohomology dimension at degree 0:  GF(2)^(1 x 1)
# Cohomology dimension at degree 1:  GF(2)^(1 x 3)
# Cohomology dimension at degree 2:  GF(2)^(1 x 6)
# Cohomology dimension at degree 3:  GF(2)^(1 x 9)
# Cohomology dimension at degree 4:  GF(2)^(1 x 12)

#cohomology over Z/4Z:
#--------->>>>  Z/4Z^(1 x 1)
#--------->>>>  Z/4Z/< ZmodnZObj(2,4) >^(3)
#--------->>>>  Z/4Z/< ZmodnZObj(2,4) >^(5) + Z/4Z^(1 x 1)
#--------->>>>  Z/4Z/< ZmodnZObj(2,4) >^(7) + Z/4Z^(1 x 2)
