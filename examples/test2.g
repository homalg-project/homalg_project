LoadPackage( "homalg" );
LoadPackage( "RingsForHomalg" );
LoadPackage( "Modules" );
LoadPackage( "GradedModules" );

S := HomalgFieldOfRationalsInDefaultCAS( ) * "x0,x1,x2";

mat := HomalgMatrix( "[ x0, x1, x2 ]", 3, 1, S );

M := LeftPresentation( mat );

R := GradedRing( S );

GM := GradedModule( M, [0], R );
GM1 := LeftPresentationWithDegrees( mat, [0], R );
GM2 := LeftPresentationWithDegrees( mat, 0, R );
GM3 := LeftPresentationWithDegrees( mat, R );
GM4 := RightPresentationWithDegrees( mat, [0,0,0], R );
GM5 := RightPresentationWithDegrees( mat, 0, R );
GM6 := RightPresentationWithDegrees( mat, R );
GM7 := FreeLeftModuleWithDegrees( R, [0] );
GM8 := FreeLeftModuleWithDegrees( 3, R, 0 );
GM9 := FreeLeftModuleWithDegrees( 3, R );
GM10 := FreeRightModuleWithDegrees( R, [0,0,0] );
GM11 := FreeRightModuleWithDegrees( 3, R, 0 );
GM12 := FreeRightModuleWithDegrees( 3, R );

mor := HomalgMatrix( "[ 2 ]", 1, 1, R );

Mor := GradedMap(mor, GM, GM);

Res := Resolution( M );
GRes := Resolution( GM );
