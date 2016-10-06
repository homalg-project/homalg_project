#! @Chapter Nef and Mori Cone 

#! @Section Nef and Mori Cone: Examples

#! @Subsection Projective Space

LoadPackage( "SheafCohomologyOnToricVarieties" );

#! @Example

P2 := ProjectiveSpace( 2 );
#! <A projective toric variety of dimension 2>
P2xP2 := P2*P2;
#! <A projective toric variety of dimension 4 which is a product of 2 toric varieties>
NefCone( P2 );
#! [ [ 1 ] ]
NefCone( P2xP2 );
#! [ [ 0, 1 ], [ 1, 0 ] ]
MoriCone( P2 );
#! [ [ 1 ] ]
MoriCone( P2xP2 );
#! [ [ 0, 1 ], [ 1, 0 ] ]

#! @EndExample
