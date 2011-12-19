LoadPackage("PolymakeForHomalg");
L:=[[1,2,3],[2,3,4],[4,4,4],[1,-1,2]];
I:=POLYMAKE_CREATE_CONE_BY_RAYS(L);
POLYMAKE_FAN_BY_CONES([[[1,0],[0,1]],[[0,1],[-1,0]]]);
