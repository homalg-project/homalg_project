#temporary
DeclareOperation( "UCT_Homology",
        [ IsHomalgComplex, IsHomalgModule ] );

InstallMethod( UCT_Homology,
        [ IsHomalgComplex and IsGradedObject, IsHomalgModule ],
  function( H, G )
    local uct;
    
    uct := Tor( 1, Shift( H, -1 ), G ) + H * G;
    
    return ByASmallerPresentation( uct );
    
  end
);

DeclareOperation( "UCT_Cohomology",
        [ IsHomalgComplex, IsHomalgModule ] );

InstallMethod( UCT_Cohomology,
        [ IsHomalgComplex and IsGradedObject, IsHomalgModule ],
  function( H, G )
    local uct;
    
    uct := Hom( H, G ) + Ext( 1, Shift( H, -1 ), G );
    
    return ByASmallerPresentation( uct );
    
  end
);

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
if mode = fail or not mode in [ 1, 2 ] then
    mode := 1;
fi;

Print( "\nSelect Method:\n 1) Full syzygy computation (default)\n 2) matrix creation and rank computation only\n:" );
method := Int( Filtered( ReadLine( input ), c->c <> '\n' ) );

if method = fail or not method in [ 1, 2 ] then
    method := 1;
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

if CAS = fail or not CAS in [ 1 .. 5 ] then
    CAS := 1;
fi;

LoadPackage( "homalg" );

if CAS = 1 then
    R := HomalgRingOfIntegers( n );
else
    LoadPackage( "RingsForHomalg" );
    if CAS = 2 then
        R := HomalgRingOfIntegersInExternalGAP( n );
    elif CAS = 3 then
        R := HomalgRingOfIntegersInSage( n );
    elif CAS = 4 then
        R := HomalgRingOfIntegersInMAGMA( n );
    elif CAS = 5 then
        R := HomalgRingOfIntegersInMaple( n );
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

Print( "Creating the simplicial set ...\n" );

ot := OrbifoldTriangulation( M, Isotropy, mult );
ss := SimplicialSet( ot, d );

if mode = 2 then #homology: ker( M[i] ) / im( M[i+1] )
    Print( "Creating the homology matrices ...\n" );
    M := CreateHomologyMatrix( ot, ss, R );
    if method = 1 then
        Print( "Creating homology matrices and starting homology computation ...\n" );
        H := Homology( ot, ss, R );
    elif method = 2 then
        Print( "Starting rank computation ...\n" );
        L := [];
        for i in [ 1 .. Length( M ) ] do
            M[i] := Eval( M[i] );
            L[i] :=[ nrows(  M[i] ), ncols( M[i] ) ];
            Print( "# ", i, ": ", L[i][1], " x ", L[i][2], " matrix " );
	    t := Runtimes().user_time;
	    L[i][3] := Rank( M[i] );
	    d := Runtimes().user_time - t;
	    L[i][4] := L[i][2] - L[i][3];
            Print( "with rank ", L[i][3], " and kernel dimension ", L[i][4], ". Time: ", TimeToString( d ), "\n" );
        od;
        H := [ L[1][4] ]; #first image dimension
        for i in [ 2 .. Length( L ) ] do
            H[i] := L[i][4] - L[i-1][3]; #dim ker - dim im
        od;
        for i in [ 1 .. Length( H ) ] do
            Print( "# Homology dimension at degree ", i - 1, ":  ", R!.ring, "^(1 x ", H[i], ")\n" );
        od;
    fi;
elif mode = 1 then #cohomology:  ker( M[i+1] ) / im( M[i] )
    Print( "Creating the cohomology matrices ...\n" );
    M := CreateCohomologyMatrix( ot, ss, R );
    if method = 1 then
        Print( "Creating cohomology matrix and starting cohomology computation ...\n" );
        H := Cohomology( ot, ss, R );
    elif method = 2 then
        Print( "Starting rank computation ...\n" );
        L := [];
        for i in [ 1 .. Length( M ) ] do
            M[i] := Eval( M[i] );
            L[i] :=[ nrows(  M[i] ), ncols( M[i] ) ];
            Print( "# ", i, ": ", L[i][1], " x ", L[i][2], " matrix " );
            t := Runtimes().user_time;
            L[i][3] := Rank( M[i] );
            d := Runtimes().user_time - t;
            L[i][4] := L[i][1] - L[i][3];
            Print( "with rank ", L[i][3], " and kernel dimension ", L[i][4], ". Time: ", TimeToString( d ), "\n" );
        od;
        H := [ L[1][4] ]; #first kernel dimension
        for i in [ 2 .. Length( L ) ] do
            H[i] := L[i][4] - L[i-1][3]; #dim ker - dim im
        od;
        for i in [ 1 .. Length( H ) ] do
            Print( "# Cohomology dimension at degree ", i - 1, ":  ", R!.ring, "^(1 x ", H[i], ")\n" );
        od;
    fi;
fi;
