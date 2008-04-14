Read( "start.g" );

R := RingForHomalgInMAGMA( "IntegerRing(2)", IsGF2ForHomalgInMAGMA );
RP := HomalgTable( R );

M := CreateExternalHomologyMatrix(ot,ss,R);;

Read( "finish.g" );
