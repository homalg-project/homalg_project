LoadPackage( "ToricVarieties" );

C4 := Cone( [ [1,0,0,0],[0,1,0,0], [0,0,1,0], [0,0,0,1 ] ] );

C4B := StarSubdivisionOfIthMaximalCone( C4, 1 );

C4B := ToricVariety( C4B );

ClassGroup( C4B );

IsSmooth( C4B );

PicardGroup( C4B );
