#! @Chunk PolytopeOfToricDivisor

LoadPackage( "ToricVarieties" );

#! @Example
P1 := ProjectiveSpace( 1 );
#! <A projective toric variety of dimension 1>
divisor := DivisorOfGivenClass( P1, [ -1 ] );
#! <A divisor of a toric variety with coordinates ( -1, 0 )>
polytope := PolytopeOfDivisor( divisor );
#! <A polytope in |R^1>
#! @EndExample
