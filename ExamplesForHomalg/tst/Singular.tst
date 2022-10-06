#@exec LoadPackage( "ExamplesForHomalg", false );
#@exec LoadPackage( "IO_ForHomalg", false );

gap> LoadPackage( "ExamplesForHomalg", false );
true
gap> LoadPackage( "IO_ForHomalg", false );
true
gap> HOMALG_IO.show_banners := false;;

#@if IsBound( TryLaunchCAS_IO_ForHomalg( HOMALG_IO_Singular ).stdout )
gap> ReadPackage( "ExamplesForHomalg", "examples/Purity.g" );
true
gap> ReadPackage( "ExamplesForHomalg", "examples/TorExt.g" );
true
gap> ReadPackage( "ExamplesForHomalg", "examples/ExtExt.g" );
true
gap> ReadPackage( "ExamplesForHomalg", "examples/A3_Purity.g" );
true
gap> ReadPackage( "ExamplesForHomalg", "examples/Triangle.g" );
true
gap> ReadPackage( "ExamplesForHomalg", "examples/Complexes.g" );
true
gap> ReadPackage( "ExamplesForHomalg", "examples/EdW.g" );
true
gap> ReadPackage( "ExamplesForHomalg", "examples/Auslander-Buchsbaum.g" );
true
gap> ReadPackage( "ExamplesForHomalg", "examples/Eliminate.g" );
true
gap> ReadPackage( "ExamplesForHomalg", "examples/BurchProjectiveDimension.g" );
true
gap> ReadPackage( "ExamplesForHomalg", "examples/CheckParametrization.g" );
true
gap> ReadPackage( "ExamplesForHomalg", "examples/Eliminate.g" );
true
gap> ReadPackage( "ExamplesForHomalg", "examples/IdealvsSubobjectProperties.g" );
true
gap> ReadPackage( "ExamplesForHomalg", "examples/CohenMacaulayModule.g" );
true
gap> ReadPackage( "ExamplesForHomalg", "examples/CohenMacaulayRing.g" );
true
gap> ReadPackage( "ExamplesForHomalg", "examples/NonCohenMacaulayModuleNonEquidimensional.g" );
true
gap> ReadPackage( "ExamplesForHomalg", "examples/NonCohenMacaulayRingNonEquidimensional.g" );
true
gap> ReadPackage( "ExamplesForHomalg", "examples/ProjectiveOfNonconstantRank_Rank0.g" );
<A principal torsion-free (left) ideal given by a cyclic generator>
<A non-zero principal torsion-free rank 0 (left) ideal given by a cyclic gener\
ator>
<A non-zero principal projective rank 0 (left) ideal given by a cyclic generat\
or>
<A non-zero cyclic projective rank 0 left module presented by 1 relation for a\
 cyclic generator>
<A free left module of rank 1 on a free generator>
<A zero left module>
true
gap> ReadPackage( "ExamplesForHomalg", "examples/ReflexiveNonProjectiveIdeal.g" );
<A reflexive non-projective (left) ideal given by 2 generators>
true
gap> ReadPackage( "ExamplesForHomalg", "examples/ShortenResolution.g" );
true
gap> ReadPackage( "ExamplesForHomalg", "examples/WhySpectral.g" );
true
gap> ReadPackage( "ExamplesForHomalg", "examples/HilbertPolynomial.g" );
true
gap> ReadPackage( "ExamplesForHomalg", "examples/Gcd_UsingCayleyDeterminant.g" );
true
gap> ReadPackage( "ExamplesForHomalg", "examples/SimplerEquivalentMatrix.g" );
true
gap> ReadPackage( "ExamplesForHomalg", "examples/FoSys_HoEq_Singular.g" );
true
gap> ReadPackage( "ExamplesForHomalg", "examples/Hom(Hom(-,Z128),Z16)_On_Seq.g" );
true
#@fi
