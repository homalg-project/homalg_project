LoadPackage( "RingsForHomalg" );

LoadPackage( "homalg" );

R := RingForHomalgInMapleUsingJanetOre( "[[t,D,delta],[],[weyl(D,t),shift(delta,t)]]" );

A := HomalgMatrix( "[ \
1+delta^2, D*delta-delta^2, delta, \
t*D*delta+delta^3-2*t*delta+2*D*delta-2*delta, -delta^3+2*delta^2, delta^2 \
]", 2, 3, R );

M := LeftPresentation( A );

F := TorsionFreeFactor( M );

epsilon := NatTrIdToHomHom_R( F );

AsEpimorphicImage(epsilon^-1);

ByASmallerPresentation( F );

nu := TorsionFreeFactorEpi( M );

chi := nu^-1;

T := TorsionSubmodule( M );

iota := TorsionSubmoduleEmb( M );

alpha := CoproductMorphism( NaturalGeneralizedEmbedding( T ), NaturalGeneralizedEmbedding( F ) );

Assert( 0, IsIsomorphism( alpha ) );

#AsEpimorphicImage( alpha );

