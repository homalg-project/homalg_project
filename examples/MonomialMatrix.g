LoadPackage( "GradedRingForHomalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
n := MonomialMatrix( 2, R );
S := GradedRing( R );;
m := MonomialMatrix( 2, S );
