ReadPackage( "MatricesForHomalg", "examples/Univariate.g" );

LoadPackage( "Modules" );

M := LeftPresentation( mat );

filt := PurityFiltration( M );

II_E := SpectralSequence( filt );

m := IsomorphismOfFiltration( filt );

Assert( 0, IsIdenticalObj( Range( m ), M ) );
Assert( 0, IsIsomorphism( m^-1 ) );
