#@exec LoadPackage( "ExamplesForHomalg", false );
#@exec LoadPackage( "IO_ForHomalg", false );

gap> LoadPackage( "ExamplesForHomalg", false );
true
gap> LoadPackage( "IO_ForHomalg", false );
true
gap> HOMALG_IO.show_banners := false;;

#@if IsBound( TryLaunchCAS_IO_ForHomalg( HOMALG_IO_Maple ).stdout )
gap> HOMALG_RINGS.RingOfIntegersDefaultCAS := "Maple";;
gap> HOMALG_RINGS.FieldOfRationalsDefaultCAS := "Maple";;
gap> ReadPackage( "ExamplesForHomalg", "examples/Purity.g" );
true
gap> ReadPackage( "ExamplesForHomalg", "examples/A3_Purity.g" );
true
gap> ReadPackage( "ExamplesForHomalg", "examples/Eliminate.g" );
true
gap> ReadPackage( "ExamplesForHomalg", "examples/Auslander-Buchsbaum.g" );
true
gap> ReadPackage( "ExamplesForHomalg", "examples/HilbertPolynomial.g" );
true
gap> ReadPackage( "ExamplesForHomalg", "examples/Gcd_UsingCayleyDeterminant.g" );
true
gap> ReadPackage( "ExamplesForHomalg", "examples/SimplerEquivalentMatrix.g" );
true
gap> ReadPackage( "ExamplesForHomalg", "examples/FoSys_HoEq_Janet.g" );
true
gap> ReadPackage( "ExamplesForHomalg", "examples/FoSys_HoEq_JanetOre.g" );
true
gap> ReadPackage( "ExamplesForHomalg", "examples/DerShift.g" );
true
gap> HOMALG_RINGS.RingOfIntegersDefaultCAS := "Singular";;
gap> HOMALG_RINGS.FieldOfRationalsDefaultCAS := "Singular";;
#@fi
