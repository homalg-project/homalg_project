#@exec LoadPackage( "ExamplesForHomalg", false );
#@exec LoadPackage( "IO_ForHomalg", false );

gap> LoadPackage( "ExamplesForHomalg", false );
true
gap> LoadPackage( "IO_ForHomalg", false );
true
gap> HOMALG_IO.show_banners := false;;

#@if IsBound( TryLaunchCAS_IO_ForHomalg( HOMALG_IO_MAGMA ).stdout )
gap> HOMALG_RINGS.RingOfIntegersDefaultCAS := "MAGMA";;
gap> HOMALG_RINGS.FieldOfRationalsDefaultCAS := "MAGMA";;
gap> ReadPackage( "ExamplesForHomalg" , "examples/Purity.g" );
true
gap> ReadPackage( "ExamplesForHomalg" , "examples/TorExt.g" );
true
gap> ReadPackage( "ExamplesForHomalg" , "examples/ExtExt.g" );
true
gap> ReadPackage( "ExamplesForHomalg" , "examples/Triangle.g" );
true
gap> ReadPackage( "ExamplesForHomalg" , "examples/Complexes.g" );
true
gap> ReadPackage( "ExamplesForHomalg" , "examples/EdW.g" );
true
gap> ReadPackage( "ExamplesForHomalg" , "examples/Auslander-Buchsbaum.g" );
true
gap> ReadPackage( "ExamplesForHomalg" , "examples/Gcd_UsingCayleyDeterminant.g" );
true
gap> ReadPackage( "ExamplesForHomalg" , "examples/SimplerEquivalentMatrix.g" );
true
gap> HOMALG_RINGS.RingOfIntegersDefaultCAS := "Singular";;
gap> HOMALG_RINGS.FieldOfRationalsDefaultCAS := "Singular";;
#@fi
