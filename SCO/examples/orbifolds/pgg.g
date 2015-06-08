# pgg (p2gg)

# http://en.wikipedia.org/wiki/Wallpaper_group#Group_pgg

M := [ [1,2,5], [1,2,6], [1,5,6], [2,3,6], [2,3,10], [2,5,10], [3,4,8], [3,4,9], [3,6,7], [3,7,8], [3,9,10], [4,8,9], [5,6,8], [5,8,10], [6,7,9], [6,8,9], [7,8,10], [7,9,10] ];
G := Group( (1,2) );
iso := rec( 1 := G, 4 := G );
mu := [];

dim := 3;

#matrix sizes:
# [ 18, 143, 550, 2876, 19274, 134474 ]
#factors:
# [ 7.94444, 3.84615, 5.22909, 6.70167, 6.97696 ]

#cohomology over GF(2):
# 1: 18 x 143 matrix with rank 17 and kernel dimension 1. Time: 0.000 sec.
# 2: 143 x 550 matrix with rank 123 and kernel dimension 20. Time: 0.008 sec.
# 3: 550 x 2876 matrix with rank 424 and kernel dimension 126. Time: 0.120 sec.
# 4: 2876 x 19274 matrix with rank 2450 and kernel dimension 426. Time: 3.108 sec.
# 5: 19274 x 134474 matrix with rank 16822 and kernel dimension 2452. Time: 139.552 sec.
# 6: 134474 x 941194 matrix with rank 117650 and kernel dimension 16824. Time: 7376.597 sec.
# Cohomology dimension at degree 0:  GF(2)^(1 x 1)
# Cohomology dimension at degree 1:  GF(2)^(1 x 3)
# Cohomology dimension at degree 2:  GF(2)^(1 x 3)
# Cohomology dimension at degree 3:  GF(2)^(1 x 2)
# Cohomology dimension at degree 4:  GF(2)^(1 x 2)
# Cohomology dimension at degree 5:  GF(2)^(1 x 2)

#cohomology over Z/4Z:
#------------------------>>>>  Z/4Z^(1 x 1)
#------------------------>>>>  Z/4Z/< ZmodnZObj(2,4) >^(1 x 3)
#------------------------>>>>  Z/4Z/< ZmodnZObj(2,4) >^(1 x 3)
#------------------------>>>>  Z/4Z/< ZmodnZObj(2,4) >^(1 x 2)

#Z
#0
#  3
#  0
#  2
