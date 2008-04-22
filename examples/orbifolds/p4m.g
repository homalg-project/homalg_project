M:=[[1,2,4],[1,4,5],[2,3,4],[3,4,6],[4,5,7],[4,6,7]];
c1:=(2,8)(3,7)(4,6);
c2:=(1,5)(2,4)(6,8);
cd:=(1,3)(4,8)(5,7);
C1:=Group(c1);
C2:=Group(c2);
CD:=Group(cd);
V4:=Group(c1,c2);
D8:=Group(c1,cd);
Isotropy:=rec(1:=D8,2:=C1,3:=V4,5:=CD,6:=C2,7:=D8);
mult:=[];

ot:=OrbifoldTriangulation(M,Isotropy,mult);
ss:=SimplicialSet(ot,3);

#[ 0 ], [ 1 ] :(