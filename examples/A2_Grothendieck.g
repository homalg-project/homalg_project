Read( "Markus_Lokalisierung.g" );

II_E := GrothendieckSpectralSequence( RightDualizingFunctor( A2 ), LeftDualizingFunctor( A2 ), M );

ii_E := GrothendieckSpectralSequence( RightDualizingFunctor( A2 ), LeftDualizingFunctor( A2 ), N );

ByASmallerPresentation( II_E );

ByASmallerPresentation( ii_E );

filt := FiltrationBySpectralSequence( II_E );

filtN := FiltrationBySpectralSequence( ii_E );

m := IsomorphismOfFiltration( filt );

n := IsomorphismOfFiltration( filtN );
