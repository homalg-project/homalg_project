M:=[[1,2,4],[1,4,7],[2,3,6],[2,4,5],[2,5,6],[3,6,7],[4,5,8],[4,7,8],[5,6,9],[5,8,9],[6,7,8],[6,8,9]];
G1:=Group((1,2));
G2:=Group((3,4));
C:=Group((1,2)(3,4));
V:=Group((1,2),(3,4));
Isotropy := rec();
Isotropy:=rec(1:=V,2:=G1,3:=V,7:=G2,9:=C);
mult:=[
[[6],[6,9],[5,6,9],[6,8,9],(x->(1,2)(3,4))],
[[6],[6,9],[6,8,9],[5,6,9],(x->(1,2)(3,4))]
];
dim := 3;

#cohomology over Z:
#---------->>>>  Z^(1 x 1)
#---------->>>>  0
#---------->>>>  Z/< 2 > + Z/< 2 > + Z/< 2 >

#cohomology over Z, guessed based on Z/nZ calculations and the fact that the orbifold is concatinable:
#---------->>>>  Z^(1 x 1)
#---------->>>>  0
#---------->>>>  Z/< 2 > ^ 3
#---------->>>>  Z/< 2 > ^ 2
#---------->>>>  Z/< 2 > ^ 5
#---------->>>>  ??

#cohomology over GF(2):
#---------->>>>  GF(2)^(1 x 1)
#---------->>>>  GF(2)^(1 x 3)
#---------->>>>  GF(2)^(1 x 5)
#---------->>>>  GF(2)^(1 x 7)
# calculating...


#cohomology over Z/4Z:
#---------->>>>  Z/4Z^(1 x 1)
#---------->>>>  Z/4Z/< ZmodnZObj(2,4) > + Z/4Z/< ZmodnZObj(2,4) > + Z/4Z/< ZmodnZObj(2,4) >
#---------->>>>  Z/4Z/< ZmodnZObj(2,4) > ^ (1 x 5) (changed for better readability)
#---------->>>>  Z/4Z/< ZmodnZObj(2,4) > ^ (1 x 7) (same here)
