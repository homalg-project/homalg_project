M:=[[1,2,4],[1,2,7],[1,3,6],[1,3,8],[1,4,6],[1,7,8],
[2,3,5],[2,3,9],[2,4,5],[2,7,9],
[3,5,6],[3,8,9],
[4,5,7],[4,6,9],[4,7,9],
[5,6,8],[5,7,8],
[6,8,9]];
G:=Group(());
Isotropy:=rec();
mult:=[];

ot:=OrbifoldTriangulation(M,Isotropy,mult);
ss:=SimplicialSet(ot,7);

#no problem: [ 0 ], [ 0 ], [ 2 ], [ 1 ], [ 1 ], [ 1 ] <Klein Bottle>
#       Z
#       Z
# Z/2Z
