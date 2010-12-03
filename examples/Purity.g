Read( "ReducedBasisOfModule.g" );

filt := PurityFiltration( W );

II_E := SpectralSequence( filt );

m := IsomorphismOfFiltration( filt );

Display( TimeToString( homalgTime( Qxyzt ) ) );
