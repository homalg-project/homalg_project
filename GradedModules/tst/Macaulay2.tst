#@exec LoadPackage( "RingsForHomalg", false );
#@exec LoadPackage( "IO_ForHomalg", false );

gap> LoadPackage( "RingsForHomalg", false );
true
gap> LoadPackage( "IO_ForHomalg", false );
true
gap> HOMALG_IO.show_banners := false;;

#@if IsBound( TryLaunchCAS_IO_ForHomalg( HOMALG_IO_Macaulay2 ).stdout )
gap> HOMALG_RINGS.RingOfIntegersDefaultCAS := "Macaulay2";;
gap> HOMALG_RINGS.FieldOfRationalsDefaultCAS := "Macaulay2";;
gap> ReadPackage( "GradedModules", "examples/HilbertPolynomial.g" );
true
gap> ReadPackage( "GradedModules", "examples/Purity.g" );
true
gap> ReadPackage( "GradedModules", "examples/FilteredByPurity.g" );
true
gap> ReadPackage( "GradedModules", "examples/Triangle.g" );
true
gap> ReadPackage( "GradedModules", "examples/Complexes.g" );
true
gap> ReadPackage( "GradedModules", "examples/GlobalSections.g" );
true
gap> ReadPackage( "GradedModules", "examples/P1.g" );
total:   7  6  5  4  3  2  1  1  2  3  4  ?
---------|--|--|--|--|--|--|--|--|--|--|--|
    1:   7  6  5  4  3  2  1  .  .  .  .  0
    0:   *  .  .  .  .  .  .  .  1  2  3  4
---------|--|--|--|--|--|--|--|--S--|--|--|
twist:  -6 -5 -4 -3 -2 -1  0  1  2  3  4  5
-------------------------------------------
Euler:  -7 -6 -5 -4 -3 -2 -1  0  1  2  3  4
true
gap> ReadPackage( "GradedModules", "examples/Schenck-3.2.g" );
 total:  1 2 1
--------------
     0:  1 1 .
     1:  . . .
     2:  . 1 1
--------------
degree:  0 1 2

 total:  1 3 2
--------------
     0:  1 . .
     1:  . 3 2
--------------
degree:  0 1 2
true
gap> ReadPackage( "GradedModules", "examples/Schenck-8.3.g" );
 total:  1 5 6 2
----------------
     0:  1 . . .
     1:  . 4 4 1
     2:  . . . .
     3:  . 1 2 1
----------------
degree:  0 1 2 3
true
gap> ReadPackage( "GradedModules", "examples/Schenck-8.3.3.g" );
 total:  1 5 6 2
----------------
     0:  1 . . .
     1:  . . . .
     2:  . 5 6 2
----------------
degree:  0 1 2 3
true
gap> ReadPackage( "GradedModules", "examples/NonCohenMacaulayMonomialIdeal.g" );
true
gap> ReadPackage( "GradedModules", "examples/VectorBundleOnP1_Example5.1.g" );
true
gap> HOMALG_RINGS.RingOfIntegersDefaultCAS := "Singular";;
gap> HOMALG_RINGS.FieldOfRationalsDefaultCAS := "Singular";;
#@fi
