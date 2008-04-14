Read("start.g");

R := CreateHomalgRing( GF(2) );
	RP := HomalgTable( R );

M:=CreateHomologyMatrix(ot,ss);;

for i in [1..(k-1)] do
  M[i] := Z(2)*M[i];
od;

Read("finish.g");
