ReadPackage( "ExamplesForHomalg", "examples/ReducedBasisOfModule.g" );

II_E := GrothendieckSpectralSequence( RightDualizingFunctor( Qxyz ), LeftDualizingFunctor( Qxyz ), W );

filt := FiltrationBySpectralSequence( II_E );

m := IsomorphismOfFiltration( filt );

