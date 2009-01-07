Read( "ReducedBasisOfModule.g" );

## compute a free resolution of W as a right module
P := Resolution( W );
## apply the inner functor G := Hom(-,R) to the resolution
GP := Hom( P );
## compute the Cartan-Eilenberg resolution of the resulting cocomplex
CE := Resolution( GP );
## the bicocomplex associated to the Cartan-Eilenberg resolution
#bc := HomalgBicomplex( CE );
## the total complex of bc
#tot := TotalComplex( bc );
## apply the outer functor F := Hom(-,R) to the Cartan-Eilenberg resolution
FCE := Hom( CE );
## the bicomplex associated to FCE
BC := HomalgBicomplex( FCE );
## the total complex of BC
Tot := TotalComplex( BC );
## the associated spectral sequence
I_E := HomalgSpectralSequence( BC );
## the transposed bicomplex associated to FCE
tBC := TransposedBicomplex( BC );
## the associated spectral sequence
II_E := HomalgSpectralSequence( 2, tBC );
