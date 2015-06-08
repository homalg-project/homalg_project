LoadPackage( "GradedModules" );

Q:=GradedRing( HomalgFieldOfRationalsInDefaultCAS() );

S:=Q*"x0..2";
A:=2*S;
B:=1*S/GradedLeftSubmodule("x0",S)+1*S/GradedLeftSubmodule("x1",S)+1*S/GradedLeftSubmodule("x2",S);
M:=HomalgMatrix([1,0,-1,0,1,-1],2,3,S);
M:=GradedMap(M,A,B);
OmegaP2:=Kernel(M);

S:=Q*"x0..3";
A:=3*S;
B:=1*S/GradedLeftSubmodule("x0",S)+1*S/GradedLeftSubmodule("x1",S)+1*S/GradedLeftSubmodule("x2",S)+1*S/GradedLeftSubmodule("x3",S);
M:=HomalgMatrix([1,0,0,-1,0,1,0,-1,0,0,1,-1],3,4,S);
M:=GradedMap(M,A,B);
OmegaP3:=Kernel(M);
