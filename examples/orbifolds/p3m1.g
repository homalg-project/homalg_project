# p3m1

# http://en.wikipedia.org/wiki/Wallpaper_group#Group_p3m1

M := [ [1,2,4], [1,3,4], [2,4,5], [3,4,7], [4,5,6], [4,6,7] ];

S3 := Group( (1,2,3), (1,2) );

Isotropy := rec( 1 := S3, 5 := S3, 7 := S3,
                 2 := Group( (1,2) ), 3 := Group( (1,3) ), 6 := Group( (2,3) ) );

mult := [];

dim := 3;

#matrix sizes
# [ <A homalg internal 6 by 87 matrix>,
#   <A homalg internal 87 by 794 matrix>,
#   <A homalg internal 794 by 8157 matrix>,
#   <A homalg internal 8157 by 88332 matrix> ]
#factors
# [ 14.5, 9.12644, 10.2733, 10.829 ]

#cohomology over Z:
#--------->>>>  Z^(1 x 1)
#--------->>>>  0
#--------->>>>  Z/< 2 >

#cohomology over GF(5):
#------>>>>  GF(5)^(1 x 1)
#------>>>>  0
#------>>>>  0

# 1: 6 x 87 matrix with rank 5 and kernel dimension 1. Time: 0.000 sec.
# 2: 87 x 794 matrix with rank 81 and kernel dimension 6. Time: 0.000 sec.
# 3: 794 x 8157 matrix with rank 711 and kernel dimension 83. Time: 0.236 sec.
# 4: 8157 x 88332 matrix with rank 7444 and kernel dimension 713. Time: 27.446 sec.
# 5: 88332 x 967759 matrix with rank 80886 and kernel dimension 7446. Time: 2786.274 sec.
# Cohomology dimension at degree 0:  GF(2)^(1 x 1)
# Cohomology dimension at degree 1:  GF(2)^(1 x 1)
# Cohomology dimension at degree 2:  GF(2)^(1 x 2)
# Cohomology dimension at degree 3:  GF(2)^(1 x 2)
# Cohomology dimension at degree 4:  GF(2)^(1 x 2)

#cohomology over GF(3):
# 1: 6 x 87 matrix with rank 5 and kernel dimension 1. Time: 0.000 sec.
# 2: 87 x 794 matrix with rank 82 and kernel dimension 5. Time: 0.032 sec.
# 3: 794 x 8157 matrix with rank 712 and kernel dimension 82. Time: 24.981 sec.
# 4: 8157 x 88332 matrix with rank 7442 and kernel dimension 715. Time: 5485.735 sec.
# Cohomology dimension at degree 0:  GF(3)^(1 x 1)
# Cohomology dimension at degree 1:  GF(3)^(1 x 0)
# Cohomology dimension at degree 2:  GF(3)^(1 x 0)
# Cohomology dimension at degree 3:  GF(3)^(1 x 3)

