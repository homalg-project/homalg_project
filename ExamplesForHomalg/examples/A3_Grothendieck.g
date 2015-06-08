Read( "Coupling.g" );

II_E := GrothendieckSpectralSequence( RightDualizingFunctor( A3 ), LeftDualizingFunctor( A3 ), N );

filt := FiltrationBySpectralSequence( II_E );

m := IsomorphismOfFiltration( filt );

