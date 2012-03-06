LoadPackage( "ToricVarieties" );

H5 := Fan( [[-1,5],[0,1],[1,0],[0,-1]],[[1,2],[2,3],[3,4],[4,1]] );

H5 := ToricVariety( H5 );

P1 := Polytope( [[0],[1]] );

P1 := ToricVariety( P1 );

P1P1 := P1*P1;

ClassGroup( H5 );

PicardGroup( H5 );

ClassGroup( P1P1 );

PicardGroup( P1P1 );

IsSmooth( H5 );

IsSmooth( P1P1 );