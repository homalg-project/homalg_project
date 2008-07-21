# D8

M := [ [1] ];
D8 := Group( (2,8)(3,7)(4,6), (1,3)(4,8)(5,7) );
Isotropy := rec( 1 := D8 );
mult := [];
dim := 3;

#H_n (D_2m) =
#Z,    n = 0
#Z/2,  n = 1 mod 4
#Z/2m, n = 3 mod 4
#0     otherwise

#Z  Z/2  0  Z/2m  0  Z/2 ...

#H^n (D_2m) =
#Z,    n = 0
#Z/2,  n = 2 mod 4,
#Z/2m, n = 0 mod 4, n<>0
#0     otherwise

#Z  0  Z/2  0  Z/2m  0  Z/2 ...

#--->>>>  Z/8Z^(1 x 1)
#--->>>>  Z/8Z/< ZmodnZObj(2,8) > + Z/8Z/< ZmodnZObj(2,8) >
#--->>>>  Z/8Z/< ZmodnZObj(2,8) > + Z/8Z/< ZmodnZObj(2,8) > + Z/8Z/< ZmodnZObj(2,8) >
#--->>>>  Z/8Z/< ZmodnZObj(2,8) > + Z/8Z/< ZmodnZObj(2,8) > + Z/8Z/< ZmodnZObj(2,8) > + Z/8Z/< ZmodnZObj(4,8) >
#--->>>>  Z/8Z/< ZmodnZObj(2,8) > + Z/8Z/< ZmodnZObj(2,8) > + Z/8Z/< ZmodnZObj(2,8) > + Z/8Z/< ZmodnZObj(2,8) > + Z/8Z/< ZmodnZObj(4,8

