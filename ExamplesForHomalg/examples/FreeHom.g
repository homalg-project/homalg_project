LoadPackage( "RingsForHomalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y";

M := HomalgMatrix( "[x^3,y^3,x+y,x-y, y,x,x,y]", 2, 4, R );

LoadPackage( "Modules" );

M := LeftPresentation( M );

H := Hom( M, R );

# NrRelations( H );
