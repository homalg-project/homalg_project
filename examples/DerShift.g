LoadPackage( "RingsForHomalg" );

R := RingForHomalgInMapleUsingJanetOre( "[[t,D,delta],[],[weyl(D,t),shift(delta,t)]]" );

A := HomalgMatrix( "[ \
1+delta^2, D*delta-delta^2, delta, \
t*D*delta+delta^3-2*t*delta+2*D*delta-2*delta, -delta^3+2*delta^2, delta^2 \
]", 2, 3, R );

LoadPackage( "Modules" );

M := LeftPresentation( A );

F := TorsionFreeFactor( M );

epsilon := NatTrIdToHomHom_R( F );

Assert( 0, IsIsomorphism( epsilon ) );

AsEpimorphicImage(epsilon^-1);

ByASmallerPresentation( F );

nu := TorsionFreeFactorEpi( M );

chi := nu^-1;

T := TorsionObject( M );

iota := TorsionObjectEmb( M );

mu := NaturalGeneralizedEmbedding( F );

Assert( 0, IsGeneralizedIsomorphism( mu ) );

mu := RemoveMorphismAid( mu );

Assert( 0, IsMonomorphism( mu ) );

alpha := CoproductMorphism( iota, mu );

Assert( 0, IsIsomorphism( alpha ) );

#AsEpimorphicImage( alpha );
