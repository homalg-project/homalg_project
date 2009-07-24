## http://www.math.uiuc.edu/Macaulay2/doc/Macaulay2-1.1/share/doc/Macaulay2/Macaulay2Doc/html/___Tutorial_co_sp__Canonical_sp__Embeddings_spof_sp__Plane_sp__Curves_spand_sp__Gonality.html

LoadPackage( "Sheaves" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "a,b,c";

R0 := R * 1;

O := n -> R0 ^ n;

ipoint1 := HomalgMatrix( "[ a, b ]", 1, 2, R );

ipoint2 := HomalgMatrix( "[ a, c ]", 1, 2, R );

ipoint3 := HomalgMatrix( "[ b, c ]", 1, 2, R );

ipoint1 := Subobject( ipoint1, R0^0 );

ipoint2 := Subobject( ipoint2, R0^0 );

ipoint3 := Subobject( ipoint3, R0^0 );

icurves1 := Iterated( [ ipoint1^2, ipoint2^2, ipoint3^2 ], Intersect );

Icurves1 := MatrixOfGenerators( icurves1 );

rand := R * HomalgMatrix( RandomMat( NrColumns( Icurves1 ), 1 ), HOMALG.ZZ );

can0 := FullSubmodule( R0 );

can0 := SubmoduleGeneratedByHomogeneousPart( 3, can0 );

can1 := Iterated( [ ipoint1, ipoint2, ipoint3 ], Intersect );

can1 := SubmoduleGeneratedByHomogeneousPart( 3, can1 );

can2 := ipoint1 ^ 2;

can2 := SubmoduleGeneratedByHomogeneousPart( 3, can2 );

line := HomalgMatrix( "[ a - b ]", 1, 1, R );

line := Subobject( line, ( R * 1 )^0 );

can3 := Intersect( line + ipoint1^2, ipoint3 );

can3 := SubmoduleGeneratedByHomogeneousPart( 3, can3 );

