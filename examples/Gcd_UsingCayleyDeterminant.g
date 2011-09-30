LoadPackage( "RingsForHomalg" );
R := HomalgRingOfIntegersInDefaultCAS( ) * "x";
f := "x^2+1" / R;
h := "x^2+x+1" / R;
g := "x^2-x+1" / R;
LoadPackage( "Modules" );
gcd := Gcd_UsingCayleyDeterminant( f * h, f * g );
(f * h) / gcd;
