Read( "ReducedBasisOfModule.g" );

## compute a free resolution of W
P := Resolution( W );
## apply the inner functor G := Hom(-,R) to the resolution
GP := Hom( P );
## tensor with P again
FGP := GP * P;
## the bicomplex associated to FGP
BC := HomalgBicomplex( FGP );
## the second spectral sequence together with
## the collapsed first spectral sequence
II_E := SecondSpectralSequenceWithFiltrationOfTotalDefects( BC );

filt := FiltrationBySpectralSequence( II_E );

ByASmallerPresentation( filt );

m := IsomorphismOfFiltration( filt );
