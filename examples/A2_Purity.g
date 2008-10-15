Read( "Markus_Lokalisierung.g" );

filt := PurityFiltration( M );

II_E := AssociatedSecondSpectralSequence( filt );

m := IsomorphismOfFiltration( filt );

filtN := PurityFiltration( N );

n := IsomorphismOfFiltration( filtN );
