LoadPackage( "RingsForHomalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "d";

LoadPackage( "Modules" );

M := LeftPresentation( HomalgMatrix( "[ d^3+d^2-d-1 ]", 1, 1, R ) );

m := HomalgMap( HomalgMatrix( "[ 1, d, d^2 ]", 3, 1, R ), "free", M );

AsEpimorphicImage( m );

