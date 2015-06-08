LoadPackage( "ToricVarieties" );

F:=Fan([[[1,1],[1,0]],[[1,-1],[1,0]]]);

M:=[[1,0],[0,1]];

C:=Cone([[1,1],[1,-1]]);

T1:=ToricVariety(F);

T2:=ToricVariety(C);

M:=ToricMorphism(T1,M,T2);
