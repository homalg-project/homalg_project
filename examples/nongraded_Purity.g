Read( "MainExample.g" );

filt := PurityFiltration( N );

II_E := SpectralSequence( filt );

m := IsomorphismOfFiltration( filt );

Display( StringTime( homalgTime( Qxyzt ) ) );
