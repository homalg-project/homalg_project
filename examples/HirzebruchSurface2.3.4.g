LoadPackage( "ToricVarietiesForHomalg" );

H2 := HomalgFan( [[0,1],[1,0],[0,-1],[-1,2]],[[1,2],[2,3],[3,4],[4,1]] );
H3 := HomalgFan( [[0,1],[1,0],[0,-1],[-1,3]],[[1,2],[2,3],[3,4],[4,1]] );
H4 := HomalgFan( [[0,1],[1,0],[0,-1],[-1,4]],[[1,2],[2,3],[3,4],[4,1]] );

H2 := ToricVariety( H2 );
H3 := ToricVariety( H3 );
H4 := ToricVariety( H4 );

ClassGroup( H2 );
ClassGroup( H3 );
ClassGroup( H4 );
