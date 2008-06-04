M:=[[1,2,4],[1,4,9],[2,3,5],[2,4,5],[3,5,6],[3,6,7],[4,5,7],[4,6,7],[4,6,9],[5,6,8],[5,7,8],[6,8,9]];
G:=Group((1,2));
Isotropy:=rec(1:=G,2:=G,3:=G,7:=G,8:=G,9:=G);
mult:=[];
dim := 4;

#4 works, [0],[0],[2],? 5 should work! (compare to pm)

#cohomology over GF(2):
# GF(2)^(1 x 1)
# GF(2)^(1 x 2)
# GF(2)^(1 x 2)
# GF(2)^(1 x 2)
# GF(2)^(1 x 2)
# (calculating - probably 1x2 too?)
