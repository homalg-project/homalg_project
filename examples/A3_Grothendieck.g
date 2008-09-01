Read( "Coupling.g" );

II_E := GrothendieckSpectralSequence( RightDualizingFunctor( A3 ), LeftDualizingFunctor( A3 ), N );

filt := FiltrationOfObjectInCollapsedSheetOfFirstSpectralSequence( II_E );

L := UnderlyingModule( filt );

