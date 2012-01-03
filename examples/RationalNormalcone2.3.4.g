LoadPackage( "ToricVarietiesForHomalg" );

C2 := HomalgCone([[1,0],[1,2]]);
C3 := HomalgCone([[1,0],[1,3]]);
C4 := HomalgCone([[1,0],[1,4]]);

C2 := ToricVariety( C2 );
C3 := ToricVariety( C3 );
C4 := ToricVariety( C4 );

ClassGroup( C2 );
ClassGroup( C3 );
ClassGroup( C4 );

IsSmooth( C2 );
IsSmooth( C3 );
IsSmooth( C4 );