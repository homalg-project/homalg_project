LoadPackage( "SCO" );

if not IsBound(input) then
    input := InputTextUser();
fi;

Print( "@@@@@@@@ SCO @@@@@@@@\n" );

if LoadPackage( "RingsForHomalg" ) = true then
    
    Print( "\nSelect base ring:\n 1) Integers (default)\n 2) Rationals\n 3) Z/nZ\n:" );
    base := Int( Filtered( ReadLine( input ), c->c <> '\n' ) );
    if base = fail or not base in [ 1, 2, 3 ] then
        base := 1;
    fi;
    
    if base = 1 then
        n := 0;
    fi;
    
    if base = 3 then
        Print( "\nPlease type in the value of 'n' (default = 2)\n:" );
        n := Int( Filtered( ReadLine( input ), c -> c <> '\n' ) );
        if n = fail or n <= 0 then
            n := 2;
        fi;
        if not IsPrime( n ) then
            base := 4;
        fi;
    fi;
    
    Names_of_CAS := [ "GAP", "External GAP", "MAGMA", "Maple", "Sage", "Singular" ];
    List_of_CAS := [ "", "ExternalGAP", "MAGMA", "Maple", "Sage", "Singular" ];
    
    if base = 1 then #Z
        sublist := [ 1, 2, 3, 4, 5 ];
    else
        
        if base = 2 then #Q
            sublist := [ 3, 4, 5, 6 ];
        elif base = 3 then #Z/pZ
            sublist := [ 3, 4, 5, 6 ];
        elif base = 4 then  #Z/nZ
            sublist := [ 4 ];
        fi;
        
        if LoadPackage( "GaussForHomalg" ) = true then
            sublist := Concatenation( [ 1, 2 ], sublist );
        else
            Print( "\nYou do not have the GaussForHomalg package installed. Try it for extended GAP functionality.\n" );
        fi;
        
    fi;
    
    Print( "\nSelect Computer Algebra System:\n" );
    for i in [ 1 .. Length( sublist ) ] do
        str := Names_of_CAS[sublist[i]];
        Print( " ", i, ") ", str );
        if i = 1 then
            Print( " (default)" );
        fi;
        Print( "\n" );
    od;
    Print( ":" );
    
    CAS := Int( Filtered( ReadLine( input ), c -> c <> '\n' ) );
    
    if CAS = fail or not CAS in [ 1 .. Length( sublist ) ] then
        CAS := 1;
    fi;
    
    CAS := sublist[ CAS ];
    
    if CAS in [ 1, 2 ] then
        if base = 1 then
            Print( "\nAll computations will be done with GAP dense matrices.\n" );
        fi;
        if base in [ 2, 3 ] then
            Print( "\nYou have the choice to work with sparse or dense matrices:\n" );
            Print( " 1) sparse (default)\n 2) dense\n:" );
            matrix := Int( Filtered( ReadLine( input ), c -> c <> '\n' ) );
            if matrix = 2 then
                HOMALG.PreferDenseMatrices := true;
            fi;
        fi;
        if base = 4 then
            Print( "\nAll computations will be done with Gauss sparse matrices.\n" );
        fi;
    fi;
    
    if base = 2 then
        HOMALG_RINGS.FieldOfRationalsDefaultCAS := List_of_CAS[ CAS ];
        R := HomalgFieldOfRationalsInDefaultCAS( );
    else
        HOMALG_RINGS.RingOfIntegersDefaultCAS := List_of_CAS[ CAS ];
        R := HomalgRingOfIntegersInDefaultCAS( n );
    fi;
    
else
    
    Print( "\nYou do not have the RingsForHomalg package installed, therefore you can only work with GAP.\n" );
    
    if LoadPackage( "GaussForHomalg" ) = true then
        
        Print( "\nSelect base ring:\n 1) Integers (default)\n 2) Rationals\n 3) Z/nZ\n:" );
        base := Int( Filtered( ReadLine( input ), c->c <> '\n' ) );
        if base = fail or not base in [ 1, 2, 3 ] then
            base := 1;
        fi;
        
        if base = 3 then
            Print( "\nPlease type in the value of 'n' (default = 2)\n:" );
            n := Int( Filtered( ReadLine( input ), c -> c <> '\n' ) );
            if n = fail or not n in Integers then
                n := 2;
            elif not IsPrime( n ) then
                base := 4;
            fi;
        fi;
        
        if base = 1 then
            Print( "\nAll computations will be done with GAP dense matrices.\n" );
            R := HomalgRingOfIntegers( );
        fi;
        if base in [ 2, 3 ] then
            Print( "\nYou have the choice to work with sparse or dense matrices:\n" );
            Print( " 1) sparse (default)\n 2) dense\n:" );
            matrix := Int( Filtered( ReadLine( input ), c -> c <> '\n' ) );
            if matrix = 2 then
                HOMALG.PreferDenseMatrices := true;
            fi;
        fi;
        
        if base = 2 then
            R := HomalgFieldOfRationals( );
        elif base = 3 then
            R := HomalgRingOfIntegers( n );
        fi;
        
        if base = 4 then
            Print( "\nAll computations will be done with Gauss sparse matrices.\n" );
            R := HomalgRingOfIntegers( n );
        fi;
        
    else
        
        Print( "\nYou do not have the GaussForHomalg package installed, therefore you can only work over the Integers.\n" );
        
        R := HomalgRingOfIntegers( );
        
    fi;
    
fi;

HOMALG.PreferDenseMatrices := false;

if IsIntegralDomain( R ) then
    
    Print( "\nSelect Method:\n 1) Full syzygy computation (default)\n 2) matrix creation and rank computation only\n:" );
    method := Int( Filtered( ReadLine( input ), c->c <> '\n' ) );
    
    if method = fail or not method in [ 1, 2 ] then
        method := 1;
    fi;
    
else
    method := 1;
fi;

Print( "\nSelect orbifold (default=\"C2\")\n:" );
orbifold := Filtered( ReadLine( input ), c->c<>'\n' );
if orbifold = "" then
    orbifold := "C2.g";
fi;
if orbifold{[Length( orbifold ) - 1, Length( orbifold )]} <> ".g" then
    Append( orbifold, ".g" );
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

info := "";

Read( Concatenation( directory, "examples", separator, "orbifolds", separator, orbifold ) );

if info = "" then
    info := orbifold{ [ 1 .. Length( orbifold ) - 2 ] };
fi;

Print( "\nSelect mode:\n 1) Cohomology (default)\n 2) Homology\n:" );
mode := Int( Filtered( ReadLine( input ), c->c <> '\n' ) );
if mode = fail or not mode in [ 1, 2 ] then
    mode := 1;
fi;

Print( Concatenation( "\nSelect dimension (default = ", String( dim ), ")\n:" ) );

d := Int( Filtered( ReadLine( input ), c -> c<>'\n' ) );

if d <= 0 or d = fail then
    d := dim;
fi;

ot := OrbifoldTriangulation( M, iso, mu, info );
ss := SimplicialSet( ot );

if mode = 2 then #homology: ker( M[i] ) / im( M[i+1] )
    Print( "Creating the boundary matrices ...\n" );
    M := CreateBoundaryMatrices( ss, d, R );
    if method = 1 then
        Print( "Starting homology computation ...\n" );
        H := Homology( M, R );
    elif method = 2 then
        Print( "Starting rank computation ...\n" );
        L := [];
        for i in [ 1 .. Length( M ) ] do
            L[i] :=[ NrRows(  M[i] ), NrColumns( M[i] ) ];
            Print( "# ", i, ": ", L[i][1], " x ", L[i][2], " matrix " );
	    t := Runtimes().user_time;
	    L[i][3] := RowRankOfMatrix( M[i] );
	    d := Runtimes().user_time - t;
	    L[i][4] := L[i][2] - L[i][3];
            Print( "with rank ", L[i][3], " and kernel dimension ", L[i][4], ". Time: ", TimeToString( d ), "\n" );
        od;
        H := [ L[1][4] ]; #first image dimension
        for i in [ 2 .. Length( L ) ] do
            H[i] := L[i][4] - L[i-1][3]; #dim ker - dim im
        od;
        for i in [ 1 .. Length( H ) ] do
            Print( "# Homology dimension at degree ", i - 1, ":  ", RingName( R ), "^(1 x ", H[i], ")\n" );
        od;
    fi;
elif mode = 1 then #cohomology:  ker( M[i+1] ) / im( M[i] )
    Print( "Creating the coboundary matrices ...\n" );
    M := CreateCoboundaryMatrices( ss, d, R );
    if method = 1 then
        Print( "Starting cohomology computation ...\n" );
        H := Cohomology( M, R );
    elif method = 2 then
        Print( "Starting rank computation ...\n" );
        L := [];
        for i in [ 1 .. Length( M ) ] do
            L[i] :=[ NrRows(  M[i] ), NrColumns( M[i] ) ];
            Print( "# ", i, ": ", L[i][1], " x ", L[i][2], " matrix " );
            t := Runtimes().user_time;
            L[i][3] := RowRankOfMatrix( M[i] );
            d := Runtimes().user_time - t;
            L[i][4] := L[i][1] - L[i][3];
            Print( "with rank ", L[i][3], " and kernel dimension ", L[i][4], ". Time: ", TimeToString( d ), "\n" );
        od;
        H := [ L[1][4] ]; #first kernel dimension
        for i in [ 2 .. Length( L ) ] do
            H[i] := L[i][4] - L[i-1][3]; #dim ker - dim im
        od;
        for i in [ 1 .. Length( H ) ] do
            Print( "# Cohomology dimension at degree ", i - 1, ":  ", RingName( R ), "^(1 x ", H[i], ")\n" );
        od;
    fi;
fi;
