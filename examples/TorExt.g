Read( "ReducedBasisOfModule.g" );

## compute a free resolution of W
P := Resolution( W );
## apply the inner functor G := Hom(-,R) to the resolution
GP := Hom( P );
## tensor with P again
FGP := GP * P;
## the bicomplex associated to FGP
BC := HomalgBicomplex( FGP );

p_degrees := ObjectDegreesOfBicomplex( BC )[1];

## the second spectral sequence together with
## the collapsed first spectral sequence
II_E := SecondSpectralSequenceWithFiltration( BC, p_degrees );

filt := FiltrationBySpectralSequence( II_E );

ByASmallerPresentation( filt );

m := IsomorphismOfFiltration( filt );
