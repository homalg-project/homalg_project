LoadPackage( "ToricVarieties" );

P3 := Polytope( [ [0,0,0], [1,0,0], [0,1,0], [0,0,1] ] );
P4 := Polytope( [ [0,0,0,0], [1,0,0,0], [0,1,0,0], [0,0,1,0], [0,0,0,1] ] );

P3 := ToricVariety( P3 );
P4 := ToricVariety( P4 );

IsSmooth( P3 );
IsSmooth( P4 );

IsProjective( P3 );
IsProjective( P4 );

ClassGroup( P3 );
ClassGroup( P4 );

PicardGroup( P3 );
PicardGroup( P4 );