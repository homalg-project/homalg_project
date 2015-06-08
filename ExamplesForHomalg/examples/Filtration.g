Read( "ReducedBasisOfModule.g" );

V := Hom( Qxyz, W );

InsertObjectInMultiFunctor( Functor_Hom_for_fp_modules, 2, V, "HomV" );

II_E := GrothendieckSpectralSequence( Functor_HomV_for_fp_modules, LeftDualizingFunctor( Qxyz ), W );

filt := FiltrationBySpectralSequence( II_E );

L := UnderlyingObject( filt );

ByASmallerPresentation( filt );

m := IsomorphismOfFiltration( filt );
