## examples.g ##

LoadPackage( "RingsForHomalg" );

input := InputTextUser();

Print( "@@@@@@@@ Examples for Homalg @@@@@@@@\n\n" );

Print( Concatenation( "\nSelect Computer Algebra System:\n",
        " 1) Internal GAP\n",
        " 2) External GAP\n",
        " 3) Sage\n",
        " 4) MAGMA\n",
        " 5) Maple\n",
        " 6) Singular (default)\n",
        ":" ) );

CAS := Filtered( ReadLine( input ), c->c <> '\n' );
i := Int( CAS );

if CAS = "" or i = fail then
    CAS := 6;
else
    CAS := i;
fi;

List_of_CAS := [ "", "ExternalGAP", "Sage", "MAGMA", "Maple", "Singular" ];

HOMALG_RINGS.RingOfIntegersDefaultCAS := List_of_CAS[ CAS ];
HOMALG_RINGS.FieldOfRationalsDefaultCAS := List_of_CAS[ CAS ];

Print( "Select Mode:\n 1) Read example from file (default)\n 2) Create your own ring\n:" );
mode := Int( Filtered( ReadLine( input ), c->c <> '\n' ) );
if mode = fail or not mode in [ 1, 2 ] then
    mode := 1;
fi;

if mode = 1 then
    
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
    
elif mode = 2 then
    
    Print( "\nSelect base ring:\n(-) Type \"Q\" for the field of rationals (default)\n(-) Type \"0\" for the Ring of Integers Z\n(-) Type \"n\" (Integer > 0) for Z / < n >\n:" );
    f := Filtered( ReadLine( input ), c->c <> '\n' );
    i := Int( f );
    
    if f = "" or i = fail then
        R := HomalgFieldOfRationalsInDefaultCAS( );
    else
        R := HomalgRingOfIntegersInDefaultCAS( AbsInt( i ) );
    fi;
    
    Print( "\nR = " );
    Display( R );
    
    Print( "\nSelect polynomial extension:\n(-) Hit Enter for no polynomial extension (default)\n(-) Otherwise, type in the names of your variables, seperated by commas - i.e. \"x,y,z\"\n:"  );
    variables := Filtered( ReadLine( input ), c->c <> '\n' );
    
    if variables <> "" then
        S :=  R * variables;
        Print( "\nS = " );
	Display( S );
        
        Print( "\nIt is possible to work over the Weyl Algebra:\n(-) Hit Enter for the commutative case (default)\n(-) Otherwise, type in the names of your differential variables, seperated by commas - i.e. \"Dx,Dy,Dz\" (this has to be the same number as before)\n:" );
        diff_variables := Filtered( ReadLine( input ), c->c <> '\n' );
        
        if diff_variables <> "" then
            T := RingOfDerivations( S, diff_variables );
            Print( "\nT = " );
	    Display( T );
        fi;
    fi;
    Print( "\nRing creation finished!\n" );
fi;
