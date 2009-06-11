Read( "homalg.g" );

W := M;

II_E := GrothendieckSpectralSequence( RightDualizingFunctor( R ), LeftDualizingFunctor( R ), W );

filt := FiltrationBySpectralSequence( II_E );

m := IsomorphismOfFiltration( filt );

