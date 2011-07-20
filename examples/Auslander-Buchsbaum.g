LoadPackage( "RingsForHomalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";

var := Indeterminates( R );

LoadPackage( "Modules" );

M0 := 1 * R;

I1 := LeftSubmodule( var{[1]}, R );
M1 := FactorObject( I1 );

I2 := LeftSubmodule( var{[1 .. 2]}, R );
M2 := FactorObject( I2 );

I3 := LeftSubmodule( var{[1 .. 3]}, R );
M3 := FactorObject( I3 );

m := I3;

## Grade is the official name for Depth in homalg

Assert( 0, Grade( m, M0 ) + ProjectiveDimension( M0 ) = Grade( m, R ) );
Assert( 0, Grade( m, M1 ) + ProjectiveDimension( M1 ) = Grade( m, R ) );
Assert( 0, Grade( m, M2 ) + ProjectiveDimension( M2 ) = Grade( m, R ) );
Assert( 0, Grade( m, M3 ) + ProjectiveDimension( M3 ) = Grade( m, R ) );
