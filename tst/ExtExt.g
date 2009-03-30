Read( "homalg.g" );

W := ByASmallerPresentation( M );

Y := Hom( R, W );

InsertObjectInMultiFunctor( Functor_Hom, 2, Y, "TensorY" );

II_E := GrothendieckSpectralSequence( Functor_TensorY, LeftDualizingFunctor( R ), W );

filt := FiltrationBySpectralSequence( II_E );

ByASmallerPresentation( filt );

m := IsomorphismOfFiltration( filt );
