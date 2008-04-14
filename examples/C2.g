M:=[[1]];
G:=Group((1,2));
Isotropy:=rec(1:=G);
mult:=[];

ot:=OrbifoldTriangulation(M,Isotropy,mult);
ss:=SimplicialSet(ot,10);