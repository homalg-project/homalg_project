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

#cohomology over GF(2):
#---->>>>  GF(2)^(1 x 1)
#---->>>>  GF(2)^(1 x 1)
#---->>>>  GF(2)^(1 x 2)

#cohomology over Z/4Z:

#cohomology over Z/8Z:

#cohomology over GF(3):

#cohomology over Z/9Z:

#cohomology over Z/27Z:
