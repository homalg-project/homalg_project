Read( "ReducedBasisOfModule.g" );

## compute a free resolution of W
P := Resolution( W );
## instead of applying the inner functor G := Hom(-,R) to the resolution P
## and then tensoring with with P, one can directly compute Hom(P,P);
FGP := Hom( P, P );
## the bicomplex associated to FGP
BC := HomalgBicomplex( FGP );

p_degrees := ObjectDegreesOfBicomplex( BC )[1];

## the second spectral sequence together with
## the collapsed first spectral sequence
II_E := SecondSpectralSequenceWithFiltration( BC, p_degrees );

filt := FiltrationBySpectralSequence( II_E );

ByASmallerPresentation( filt );

m := IsomorphismOfFiltration( filt );

Display( TimeToString( homalgTime( Qxyz ) ) );
