LoadPackage( "RingsForHomalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "a,b,c,d,e,f,g,h";

indets := Indeterminates( R );

LoadPackage( "Modules" );

I := LeftSubmodule( "abc,bcd,cde,adf,cgh,b3f,a3g", R );

m := AMaximalIdealContaining( I );

Assert( 0, m = LeftSubmodule( indets, R ) );

J := RightSubmodule( EntriesOfHomalgMatrix( MatrixOfSubobjectGenerators( I ) ) );

n := AMaximalIdealContaining( J );

Assert( 0, n = RightSubmodule( indets, R ) );
