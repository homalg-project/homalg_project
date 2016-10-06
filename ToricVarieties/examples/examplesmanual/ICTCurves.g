#! @Chapter Irreducible, complete, torus-invariant curves and proper 1-cycles in a toric variety

#! @Section Irreducible, complete, torus-invariant curves and proper 1-cycles in a toric variety: Examples

#! @Subsection Projective Space

LoadPackage( "SheafCohomologyOnToricVarieties" );

#! @Example

P2 := ProjectiveSpace( 2 );
#! <A projective toric variety of dimension 2>
ICTCurves( P2 );
#! [ <An irreducible, complete, torus-invariant curve in a toric variety given as V( [ x_1 ] )>,
#!   <An irreducible, complete, torus-invariant curve in a toric variety given as V( [ x_2 ] )>,
#!   <An irreducible, complete, torus-invariant curve in a toric variety given as V( [ x_3 ] )> ]
C1 := ICTCurves( P2 )[ 1 ];
#! <An irreducible, complete, torus-invariant curve in a toric variety given as V( [ x_1 ] )>
IntersectionForm( P2 );
#! [ [ 1 ] ]
IntersectionProduct( C1, DivisorOfGivenClass( P2, [ 1 ] ) );
#! 1
IntersectionProduct( DivisorOfGivenClass( P2, [ 5 ] ), C1 );
#! 5

#! @EndExample
