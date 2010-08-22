## Examples.g ##

LoadPackage( "RingsForHomalg" );

LoadPackage( "Modules" );

old_RingOfIntegers := HOMALG_RINGS.RingOfIntegersDefaultCAS;
HOMALG_RINGS.RingOfIntegersDefaultCAS := "Maple";
old_FieldOfRationals := HOMALG_RINGS.FieldOfRationalsDefaultCAS;
HOMALG_RINGS.FieldOfRationalsDefaultCAS := "Singular";

input := InputTextUser();

Print( "@@@@@@@@ Examples for Homalg @@@@@@@@\n\n" );

Print( Concatenation( "\nSelect Computer Algebra System:\n",
        " 1) Internal GAP\n",
        " 2) External GAP\n",
        " 3) Sage\n",
        " 4) MAGMA\n",
        " 5) Maple	(default for Z-algebras)\n",
        " 6) Singular	(default for Q-algebras)\n",
        ":" ) );

CAS := Filtered( ReadLine( input ), c->c <> '\n' );
i := Int( CAS );

if CAS = "" or i = fail then
    CAS := "default";
else
    CAS := i;
fi;

List_of_CAS := [ "", "ExternalGAP", "Sage", "MAGMA", "Maple", "Singular" ];

if CAS <> "default" then
    HOMALG_RINGS.RingOfIntegersDefaultCAS := List_of_CAS[ CAS ];
    HOMALG_RINGS.FieldOfRationalsDefaultCAS := List_of_CAS[ CAS ];
fi;

if not IsBound( HOMALG_EXAMPLES.OwnRingOrReadFile ) or
   not HOMALG_EXAMPLES.OwnRingOrReadFile in [ 1, 2 ] then
    HOMALG_EXAMPLES.OwnRingOrReadFile := 1;
fi;

Print( "\nSelect Mode:\n " );

if HOMALG_EXAMPLES.OwnRingOrReadFile = 1 then
    Print( "1) Create your own ring (default)\n 2) Read example from file\n:" );
else
    Print( "1) Create your own ring\n 2) Read example from file (default)\n:" );
fi;

mode := Int( Filtered( ReadLine( input ), c->c <> '\n' ) );
if mode = fail or not mode in [ 1, 2 ] then
    mode := HOMALG_EXAMPLES.OwnRingOrReadFile;
fi;

if mode = 2 then
    
    Print( "\nSelect example file (default=\"ReducedBasisOfModule\")\n:" );
    file := Filtered( ReadLine( input ), c->c<>'\n' );
    if file = "" then
        file := "ReducedBasisOfModule.g";
    fi;
    if file{[Length( file ) - 1, Length( file )]} <> ".g" then
        Append( file, ".g" );
    fi;
    
    if IsBound( PackageInfo( "ExamplesForHomalg" )[1] ) and IsBound( PackageInfo( "ExamplesForHomalg" )[1].InstallationPath ) then
        directory := PackageInfo( "ExamplesForHomalg" )[1].InstallationPath;
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
    
    Read( Concatenation( directory, "examples", separator, file ) );
    
elif mode = 1 then
    
    Print( "\nSelect base ring:\n(-) Type Q for the field of rationals (default)\n(-) Type 0 for the Ring of Integers Z\n(-) Type n (Integer > 0) for Z / < n >\n:" );
    f := Filtered( ReadLine( input ), c->c <> '\n' );
    i := Int( f );
    
    Print( "\n" );
    
    if f = "" or i = fail then
        if CAS <> "default" then
            if List_of_CAS[ CAS ] = "" then
                Print( "\033[01mgap> R := HomalgFieldOfRationals( );\033[0m" );
            else
                Print( "\033[01mgap> R := HomalgFieldOfRationalsIn", List_of_CAS[ CAS ], "( );\033[0m" );
            fi;
        else
            Print( "\033[01mgap> R := HomalgFieldOfRationalsInDefaultCAS( );\033[0m    # (Default = Singular)" );
        fi;
        Print( "\n" );
	R := HomalgFieldOfRationalsInDefaultCAS( );
    else
        if i <> 0 then
            str := Concatenation( " ", String( AbsInt( i ) ), " " );
        else
            str := " ";
        fi;
        if CAS <> "default" then
            if List_of_CAS[ CAS ] = "" then
                Print( "\033[01mgap> R := HomalgRingOfIntegers(", str, ");\033[0m" );
            else
                Print( "\033[01mgap> R := HomalgRingOfIntegersIn", List_of_CAS[ CAS ], "(", str, ");\033[0m" );
            fi;
        else
            Print( "\033[01mgap> R := HomalgRingOfIntegersInDefaultCAS(", str, ");\033[0m    # (Default = Maple)" );
        fi;
	Print( "\n" );
        R := HomalgRingOfIntegersInDefaultCAS( AbsInt( i ) );
    fi;
    
    HOMALG_RINGS.RingOfIntegersDefaultCAS := old_RingOfIntegers;
    HOMALG_RINGS.FieldOfRationalsDefaultCAS := old_FieldOfRationals;
    
    Print( "\033[01mgap> Display( R );\033[m\n" );
    Display( R );
    
    HOMALG_RINGS.NamesOfDefinedRings := "R";
    
    Print( "\nSelect polynomial extension:\n(-) Hit Enter for no polynomial extension (default)\n(-) Otherwise, type in the names of your variables, seperated by commas - e.g. x,y,z\n:"  );
    variables := Filtered( ReadLine( input ), c->c <> '\n' );
    
    if variables <> "" then
        Print( "\n\033[01mgap> S := R * \"", variables, "\";\033[m     #alternatively: 'gap> S := PolynomialRing( R, \"", variables, "\" );'\n" );
        S :=  R * variables;
        Print( "\033[01mgap> Display( S );\033[m\n" );
        Display( S );
        
        Append( HOMALG_RINGS.NamesOfDefinedRings, ", S" );
        
        Print( "\nIt is possible to work over the Weyl Algebra:\n(-) Hit Enter for the commutative case (default)\n(-) Otherwise, type in the names of your differential variables, seperated by commas - e.g. Dx,Dy,Dz (same number as before!)\n:" );
        diff_variables := Filtered( ReadLine( input ), c->c <> '\n' );
        
        if diff_variables <> "" then
            Print( "\n\033[01mgap> T := RingOfDerivations( S, \"", diff_variables, "\" );\033[m\n" );
            T := RingOfDerivations( S, diff_variables );
            Print( "\033[01mgap> Display( T );\033[m\n" );
            Display( T );
            
            Append( HOMALG_RINGS.NamesOfDefinedRings, ", T" );
        fi;
    fi;
    
    if Length( HOMALG_RINGS.NamesOfDefinedRings ) = 1 then
        Print( "\nThe ring \033[01m", HOMALG_RINGS.NamesOfDefinedRings, "\033[m has been created. Use Display( ", HOMALG_RINGS.NamesOfDefinedRings, " ) to view.\n" );
    else
        Print( "\nThe rings \033[01m", HOMALG_RINGS.NamesOfDefinedRings, "\033[m have been created. Use Display( . ) to view each.\n" );
    fi;
    
fi;
