Read( "ReducedBasisOfModule.g" );

## compute a free resolution of W
P := Resolution( W );
## apply the inner functor G := Hom(-,R) to the resolution
GP := Hom( P );
## tensor with P again
FGP := GP * P;
## the bicomplex associated to FGP
BC := HomalgBicomplex( FGP );
## the total complex of BC
Tot := TotalComplex( BC );
## the associated spectral sequence
I_E := HomalgSpectralSequence( BC );
## the transposed bicomplex associated to FGP
tBC := TransposedBicomplex( BC );
## the associated spectral sequence
II_E := HomalgSpectralSequence( 2, tBC );
