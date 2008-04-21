LoadPackage( "SCO" );
HOMALG_IO.color_display := true;
SetInfoLevel( InfoLIMAT, 2 );
SetInfoLevel( InfoCOLEM, 2 );
SetInfoLevel( InfoHomalgOperations, 3 );

input := InputTextUser();

Print( "@@@@@@@@ SCO @@@@@@@@\n\n" );

Print( "Select Orbifold (default=\"C2\")\n:" );
orbifold := Filtered( ReadLine( input ), c->c<>'\n' );
if orbifold = "" then
    orbifold := "C2.g";
fi;
if orbifold{[Length( orbifold ) - 1, Length( orbifold )]} <> ".g" then
    Append( orbifold, ".g" );
fi;

Print( "\nSelect Mode:\n 1) Cohomology (default)\n 2) Homology\n:" );
mode := Int( Filtered( ReadLine( input ), c->c <> '\n' ) );
if mode = fail or mode <> 2 then
    mode := 1;
fi;

Print( Concatenation( "\nSelect Computer Algebra System:\n",
        " 1) Internal GAP (default)\n",
        " 2) External GAP\n",
        " 3) Sage\n",
        " 4) MAGMA\n",
        " 5) Maple\n",
	":" ) );

CAS := Int( Filtered( ReadLine( input ), c->c <> '\n' ) );

if CAS = fail or not CAS in [1..5] then
    CAS := 1;
fi;

if CAS = 1 then
    R := HomalgRingOfIntegers();
elif CAS = 2 then
    R := HomalgRingOfIntegersInExternalGAP();
elif CAS = 3 then
    R := HomalgRingOfIntegersInSage();
elif CAS = 4 then
    R := HomalgRingOfIntegersInMAGMA();
elif CAS = 5 then
    R := HomalgRingOfIntegersInMaple();
fi;

Read( Concatenation( "../examples/", orbifold ) );

ker := [];
im := [];

if mode = 2 then #homology: ker( M[i] ) / im( M[i+1] )
    Print( "generating homology matrices...\n" );
    M := CreateHomologyMatrix( ot, ss, R );
    Print( "computing kernels...\n" );
    ker := List( [1..Length( M ) - 1], i->HomalgGeneratorsForLeftModule( SyzygiesBasisOfRows( M[i] ) ) );
    Print( "computing images...\n" );
    im := List( [2..Length( M )], i->HomalgGeneratorsForLeftModule( M[i] ) );
    Print( "finished!\n\n         ***starting HOMOLOGY calculation***" );
else #cohomology:  ker( M[i+1] ) / im( M[i] )
    Print( "generating cohomology matrices...\n" );
    M := CreateCohomologyMatrix( ot, ss, R );
    Print( "computing kernels...\n" );
    ker := List( [2..Length( M )], i->HomalgGeneratorsForLeftModule( SyzygiesBasisOfRows( M[i] ) ) );
    Print( "computing images...\n" );
    im := List( [1..Length( M ) - 1], i->HomalgGeneratorsForLeftModule( M[i] ) );
    Print( "finished!\n\n         ***starting COHOMOLOGY calculation***" );
fi;

Q := [];

for i in [1..Length( M ) - 1] do
    Print( Concatenation( "-------- #", String(i), ": --------\n" ) );
    Print( "computing the quotient...\n" );
    Q[i] := ker[i] / im[i];
    Print( "computing BetterGenerators...\n" );
    BetterGenerators( Q[i] );
    ElementaryDivisorsOfLeftModule( Q[i] );;
    Print( "----------------------------->>>>  " );
    Display( Q[i] );
od;
