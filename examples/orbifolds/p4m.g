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
# [ 6, 95, 1066, 14357, 207788 ]
#factors:
# [ 15.8333, 11.2211, 13.4681, 14.4729 ]

#cohomology over Z:
#------------------>>>>  Z^(1 x 1)
#------------------>>>>  0
#------------------>>>>  Z/< 2 > + Z/< 2 > + Z/< 2 >
