Read( "homalg.g" );

SetAssertionLevel( 4 );

M := Hom( R, ByASmallerPresentation( M ) );

N := ByASmallerPresentation( Hom( R, M ) );

ApplyFunctor( Functor_TensorProduct, 2, N, "TensorN" );

II_E := GrothendieckSpectralSequence( Functor_TensorN, RightDualizingFunctor( R ), M );

filt := FiltrationOfObjectInStableSecondSheetOfI_E( II_E );

m := IsomorphismOfFiltration( filt );
