# p2 (p211)

# http://en.wikipedia.org/wiki/Wallpaper_group#Group_p2

M := [ [1,5,8], [1,8,9], [1,5,9], [2,6,9], [2,9,10], [2,6,10], [3,7,10], [3,8,10], [3,7,8], [4,6,7], [4,5,7], [4,5,6], [5,7,8], [8,9,10], [5,6,9], [6,7,10]];
G := Group( (1,2) );
Isotropy := rec( 1 := G,2 := G,3 := G,4 := G );
mult:=[
 [[5], [1,5], [1,5,8], [1,5,9], x -> (1,2) ],
 [[5], [1,5], [1,5,9], [1,5,8], x -> (1,2) ],
 [[6], [2,6], [2,6,9], [2,6,10], x -> (1,2) ],
 [[6], [2,6], [2,6,10], [2,6,9], x -> (1,2) ],
 [[7], [3,7], [3,7,10], [3,7,8], x -> (1,2) ],
 [[7], [3,7], [3,7,8], [3,7,10], x -> (1,2) ],
 [[6], [4,6], [4,6,7], [4,5,6], x -> (1,2) ],
 [[6], [4,6], [4,5,6], [4,6,7], x -> (1,2) ]
];

dim := 4;

#matrix sizes:
#[ <A homalg internal 16 by 126 matrix>,
#  <A homalg internal 126 by 420 matrix>,
#  <A homalg internal 420 by 1590 matrix>,
#  <A homalg internal 1590 by 7536 matrix>,
#  <A homalg internal 7536 by 37506 matrix>,
#  <A homalg internal 37506 by 187500 matrix> ]

#factors:
# [ 7.875,3.33333,3.78571,4.73962,4.97691,4.9992 ]

#up to 4 works,cohomology: [0], [1], [2,2,2,0], [1], [2,2,2,2], [1],...

# 1: 16 x 126 matrix with rank 15 and kernel dimension 1. Time: 0.000 sec.
# 2: 126 x 420 matrix with rank 108 and kernel dimension 18. Time: 0.004 sec.
# 3: 420 x 1590 matrix with rank 308 and kernel dimension 112. Time: 0.088 sec.
# 4: 1590 x 7536 matrix with rank 1278 and kernel dimension 312. Time: 0.828 sec.
# 5: 7536 x 37506 matrix with rank 6254 and kernel dimension 1282. Time: 18.589 sec.
# 6: 37506 x 187500 matrix with rank 31248 and kernel dimension 6258. Time: 537.134 sec.
# 7: 187500 x 937500 matrix with rank 156248 and kernel dimension 31252.
# Cohomology dimension at degree 0:  GF(2)^(1 x 1)
# Cohomology dimension at degree 1:  GF(2)^(1 x 3)
# Cohomology dimension at degree 2:  GF(2)^(1 x 4)
# Cohomology dimension at degree 3:  GF(2)^(1 x 4)
# Cohomology dimension at degree 4:  GF(2)^(1 x 4)
# Cohomology dimension at degree 5:  GF(2)^(1 x 4)
# Cohomology dimension at degree 6:  GF(2)^(1 x 4)
      
#cohomology over Z/4Z:
#----->>>  Z/4Z^(1 x 1)
#----->>>  Z/4Z/< ZmodnZObj(2,4) >^(1 x 3)
#----->>>  Z/4Z/< ZmodnZObj(2,4) >^(1 x 3) + Z/4Z^(1 x 1)
#----->>>  Z/4Z/< ZmodnZObj(2,4) >^(1 x 4)
#----->>>  Z/4Z/< ZmodnZObj(2,4) >^(1 x 4)

#homology over Z/4Z:
#----->>>  Z/4Z^(1 x 1)
#----->>>  Z/4Z/< ZmodnZObj(2,4) >^(1 x 3)
#----->>>  Z/4Z/< ZmodnZObj(2,4) >^(1 x 3) + Z/4Z^(1 x 1)
#----->>>  Z/4Z/< ZmodnZObj(2,4) >^(1 x 4)

#cohomology over Z:
#----------------------------------------------->>>>  Z^(1 x 1)
#----------------------------------------------->>>>  0
#----------------------------------------------->>>>  Z/< 2 > + Z/< 2 > + Z/< 2 > + Z^(1 x 1)
#----------------------------------------------->>>>  0
#----------------------------------------------->>>>  Z/< 2 > + Z/< 2 > + Z/< 2 > + Z/< 2 >
