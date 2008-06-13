# p3

# http://en.wikipedia.org/wiki/Wallpaper_group#Group_p3

M:=[[1,2,4],[1,2,6],[1,4,6],[2,3,4],[2,3,6],[3,4,5],[3,5,6],[4,5,7],[4,6,7],[5,6,7]];
C3:=Group((1,2,3));
Isotropy:=rec(1:=C3,3:=C3,7:=C3);
mult:=[
[[2],[1,2],[1,2,4],[1,2,6],(x->x*(1,2,3))],
[[2],[1,2],[1,2,6],[1,2,4],(x->x*(1,3,2))],
[[5],[5,7],[4,5,7],[5,6,7],(x->x*(1,2,3))],
[[5],[5,7],[5,6,7],[4,5,7],(x->x*(1,3,2))],
];

dim := 4;

#matrix sizes:
# [ <A homalg internal 10 by 119 matrix>,
#   <A homalg internal 119 by 916 matrix>,
#   <A homalg internal 916 by 8428 matrix>,
#   <A homalg internal 8428 by 83152 matrix> ]
#factors:
# [ 11.9, 7.69748, 9.20087, 9.86616 ]

#cohomology over GF(2) (unneccessary):
#------>>>>  GF(2)^(1 x 1)
#------>>>>  0
#------>>>>  GF(2)^(1 x 1)
#------>>>>  0

#cohomology over Z:
#------>>>>  Z^(1 x 1)
#------>>>>  0
#------>>>>  Z/< 3 > + Z/< 3 > + Z^(1 x 1)
#------>>>>  0 ? (wild guess)
#------>>>>  Z/< 3 > + Z/< 3 > + Z/< 3 > ? (wild guess)

#cohomology over GF(3):
#------>>>>  GF(3)^(1 x 1)
#------>>>>  GF(3)^(1 x 2)
#------>>>>  GF(3)^(1 x 3)
#------>>>>  GF(3)^(1 x 3)

#cohomology over GF(3^2): 
#------>>>>  Z/9Z^(1 x 1)
#------>>>>  Z/9Z/< ZmodnZObj(3,9) > + Z/9Z/< ZmodnZObj(3,9) >
#------>>>>  Z/9Z/< ZmodnZObj(3,9) > + Z/9Z/< ZmodnZObj(3,9) > + Z/9Z^(1 x 1)
#------>>>>  Z/9Z/< ZmodnZObj(3,9) > + Z/9Z/< ZmodnZObj(3,9) > + Z/9Z/< ZmodnZObj(3,9) >
# see GF(3) for the rest
