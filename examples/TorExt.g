Read( "ReducedBasisOfModule.g" );

SetAssertionLevel( 4 );

#W := Hom( Qxyz, W );

V := Hom( Qxyz, W );

ApplyFunctor( Functor_TensorProduct, 2, V, "TensorV" );

II_E := GrothendieckSpectralSequence( Functor_TensorV, LeftDualizingFunctor( Qxyz ), W );

filt := FiltrationOfObjectInCollapsedSheetOfFirstSpectralSequence( II_E );

m := IsomorphismOfFiltration( filt );
