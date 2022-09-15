#@exec LoadPackage( "RingsForHomalg", false );
#@exec LoadPackage( "IO_ForHomalg", false );

gap> LoadPackage( "RingsForHomalg", false );
true
gap> LoadPackage( "IO_ForHomalg", false );
true
gap> HOMALG_IO.show_banners := false;;

#@if IsBound( TryLaunchCAS_IO_ForHomalg( HOMALG_IO_Singular ).stdout )
gap> ReadPackage( "GradedModules", "examples/HilbertPolynomial.g" );
true
gap> ReadPackage( "GradedModules", "examples/Purity.g" );
true
gap> ReadPackage( "GradedModules", "examples/FilteredByPurity.g" );
0,  0,  x,   -y,  0,      1,  0, 0,  0,   
x*y,y*z,-z*t,0,   0,      0,  0, 0,  0,   
x^2,x*z,0,   -z*t,0,      0,  1, 0,  0,   
0,  0,  0,   0,   0,      z*t,-y,0,  0,   
0,  0,  0,   0,   y*t,    x,  0, -1, 0,   
0,  0,  0,   0,   x^2-t^2,y,  0, 0,  0,   
0,  0,  0,   0,   z*t^2,  0,  x, 0,  -t^3,
0,  0,  0,   0,   0,      0,  0, z,  0,   
0,  0,  0,   0,   0,      0,  0, y-t,0,   
0,  0,  0,   0,   0,      0,  0, 0,  z,   
0,  0,  0,   0,   0,      0,  0, 0,  y,   
0,  0,  0,   0,   0,      0,  0, 0,  x    

Cokernel of the map

R^(1x12) --> R^(1x9), ( for R := Q[x,y,z,t] )

currently represented by the above matrix

(graded, degrees of generators: [ 0, 0, 0, 0, 0, 1, 2, 2, 0 ])
true
gap> ReadPackage( "GradedModules", "examples/Triangle.g" );
true
gap> ReadPackage( "GradedModules", "examples/Complexes.g" );
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
gap> ReadPackage( "GradedModules", "examples/VectorBundleOnP1_Example5.2.g" );
true
#@fi
