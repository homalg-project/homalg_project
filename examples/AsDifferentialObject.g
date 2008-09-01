Read( "ReducedBasisOfModule.g" );

## compute a free resolution of W
P := Resolution( W );
## apply the inner functor G := Hom(-,R) to the resolution
GP := Hom( P );
## compute the Cartan-Eilenberg resolution of the resulting cocomplex
CE := Resolution( GP );
## the bicocomplex associated to the Cartan-Eilenberg resolution
bc := HomalgBicomplex( CE );
## the total complex of bc
#tot := TotalComplex( bc );
## apply the outer functor F := Hom(-,R) to the Cartan-Eilenberg resolution
FCE := Hom( CE );
## the bicomplex associated to FCE
BC := HomalgBicomplex( FCE );
## the total complex of BC
Tot := TotalComplex( BC );
## the associated zeroth spectral sheet without differential
I_E0 := HomalgBigradedObject( BC );
## the associated zeroth spectral sheet with differential (works with side effect)
AsDifferentialObject( I_E0 );
## the first spectral sheet (= first derived sheet) without differential
I_E1 := DefectOfExactness( I_E0 );
## the associated first spectral sheet with differential (works with side effect)
AsDifferentialObject( I_E1 );
## the second spectral sheet without differential
I_E2 := DefectOfExactness( I_E1 );
## the associated second spectral sheet with differential (works with side effect)
AsDifferentialObject( I_E2 );
## the third spectral sheet without differential
I_E3 := DefectOfExactness( I_E2 );
## the transposed bicomplex associated to FCE
tBC := TransposedBicomplex( BC );
## the associated zeroth spectral sheet without differential
II_E0 := HomalgBigradedObject( tBC );
## the associated zeroth spectral sheet with differential (works with side effect)
AsDifferentialObject( II_E0 );
## the first spectral sheet (= first derived sheet) without differential
II_E1 := DefectOfExactness( II_E0 );
## the associated first spectral sheet with differential (works with side effect)
AsDifferentialObject( II_E1 );
## the second spectral sheet without differential
II_E2 := DefectOfExactness( II_E1 );
## the associated second spectral sheet with differential (works with side effect)
AsDifferentialObject( II_E2 );
## the third spectral sheet without differential
II_E3 := DefectOfExactness( II_E2 );
