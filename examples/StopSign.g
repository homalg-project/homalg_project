LoadPackage( "ToricVarieties" );

P := HomalgPolytope( [ [1,2], [2,1], [2,-1], [1,-2], [-1,-2], [-2,-1], [-2,1], [-1,2] ] );

T := ToricVariety( P );

