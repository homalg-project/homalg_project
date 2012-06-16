A:=HomalgFieldOfRationalsInDefaultCAS();
S:=A*"x0..2";
A:=2*S;
B:=1*S/LeftSubmodule("x0",S)+1*S/LeftSubmodule("x1",S)+1*S/LeftSubmodule("x2",S);
M:=HomalgMatrix([1,0,-1,0,1,-1],2,3,S);
M:=HomalgMap(M,A,B);
OmegaP2:=Kernel(M);
A:=HomalgFieldOfRationalsInDefaultCAS();
S:=A*"x0..3";
A:=3*S;
B:=1*S/LeftSubmodule("x0",S)+1*S/LeftSubmodule("x1",S)+1*S/LeftSubmodule("x2",S)+1*S/LeftSubmodule("x3",S);
M:=HomalgMatrix([1,0,0,-1,0,1,0,-1,0,0,1,-1],3,4,S);
M:=HomalgMap(M,A,B);
OmegaP2:=Kernel(M);

