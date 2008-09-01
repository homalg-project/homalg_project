Read( "ReducedBasisOfModule.g" );

II_E := GrothendieckSpectralSequence( RightDualizingFunctor( Qxyz ), LeftDualizingFunctor( Qxyz ), W );

filt := FiltrationOfObjectInCollapsedSheetOfFirstSpectralSequence( II_E );

L := UnderlyingModule( filt );

