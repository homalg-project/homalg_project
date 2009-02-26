Read( "ReducedBasisOfModule.g" );

V := Hom( Qxyz, W );

InsertObjectInMultiFunctor( Functor_Hom, 2, V, "HomV" );

II_E := GrothendieckSpectralSequence( Functor_HomV, LeftDualizingFunctor( Qxyz ), W );

filt := FiltrationBySpectralSequence( II_E );

L := UnderlyingModule( filt );

ByASmallerPresentation( filt );

m := IsomorphismOfFiltration( filt );
