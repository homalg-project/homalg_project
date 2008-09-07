Read( "homalg.g" );

V := Hom( R, M );

ApplyFunctor( Functor_Hom, 2, V, "HomV" );

II_E := GrothendieckSpectralSequence( Functor_HomV, LeftDualizingFunctor( R ), M );

filt := FiltrationBySpectralSequence( II_E );

L := UnderlyingModule( filt );

ByASmallerPresentation( filt );

m := IsomorphismOfFiltration( filt );
