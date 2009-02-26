Read( "ReducedBasisOfModule.g" );

InsertObjectInMultiFunctor( Functor_TensorProduct, 2, W, "TensorW" );

II_E := GrothendieckSpectralSequence( Functor_TensorW, LeftDualizingFunctor( Qxyz ), W );

filt := FiltrationBySpectralSequence( II_E );

ByASmallerPresentation( filt );

m := IsomorphismOfFiltration( filt );
