LoadPackage( "SCO" );

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

Print( "\nSelect Z/nZ (default: n=0)\n:" );
n := Int( Filtered( ReadLine( input ), c -> c<>'\n' ) );

if n = fail then
    n := 0;
fi;

if CAS = fail or not CAS in [1..5] then
    CAS := 1;
fi;

LoadPackage( "homalg" );

if CAS = 1 then
    R := HomalgRingOfIntegers(n);
else
    LoadPackage( "RingsForHomalg" );
    if CAS = 2 then
        R := HomalgRingOfIntegersInExternalGAP(n);
    elif CAS = 3 then
        R := HomalgRingOfIntegersInSage(n);
    elif CAS = 4 then
        R := HomalgRingOfIntegersInMAGMA(n);
    elif CAS = 5 then
        R := HomalgRingOfIntegersInMaple(n);
    fi;
fi;

if IsBound( PackageInfo( "SCO" )[1] ) and IsBound( PackageInfo( "SCO" )[1].InstallationPath ) then
    directory := PackageInfo( "SCO" )[1].InstallationPath;
else
    directory := "./";
fi;

if IsBound( GAPInfo.UserHome ) then
    separator := GAPInfo.UserHome{[1]};
else
    separator := "/";
fi;

if Length( directory ) > 0 and directory{[Length( directory )]} <> separator then
    directory := Concatenation( directory, separator );
fi;

Read( Concatenation( directory, "examples", separator, "orbifolds", separator, orbifold ) );

Print( Concatenation( "\nSelect dimension (default = ", String( dim ), ")\n:" ) );

d := Int( Filtered( ReadLine( input ), c -> c<>'\n' ) );

if d <= 0 or d = fail then
    d := dim;
fi;

ot := OrbifoldTriangulation( M, Isotropy, mult );
ss := SimplicialSet( ot, d );

if mode = 2 then #homology: ker( M[i] ) / im( M[i+1] )
    M := CreateHomologyMatrix( ot, ss, R );
    H := Homology( ot, ss, R );
else #cohomology:  ker( M[i+1] ) / im( M[i] )
    M := CreateCohomologyMatrix( ot, ss, R );
    H := Cohomology( ot, ss, R );
fi;

