LoadPackage( "ToricVarieties" );

C2 := HomalgCone([[2,-1],[0,1]]);
C3 := HomalgCone([[3,-1],[0,1]]);
C4 := HomalgCone([[4,-1],[0,1]]);

C2 := ToricVariety( C2 );
C3 := ToricVariety( C3 );
C4 := ToricVariety( C4 );

CoordinateRing( C2, ["x"] );
CoordinateRing( C3, ["x"] );
CoordinateRing( C4, ["x"] );

ClassGroup( C2 );
ClassGroup( C3 );
ClassGroup( C4 );

IsSmooth( C2 );
IsSmooth( C3 );
IsSmooth( C4 );

PicardGroup( C2 );
PicardGroup( C3 );
PicardGroup( C4 );
