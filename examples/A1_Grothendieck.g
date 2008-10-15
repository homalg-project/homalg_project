Read( "Viktor.g" );

II_E := GrothendieckSpectralSequence( RightDualizingFunctor( A1 ), LeftDualizingFunctor( A1 ), V );

ByASmallerPresentation( II_E );

filt := FiltrationBySpectralSequence( II_E );

m := IsomorphismOfFiltration( filt );

