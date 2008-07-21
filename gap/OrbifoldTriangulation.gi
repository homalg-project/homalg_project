#############################################################################
##
##  OrbifoldTriangulation.gi         SCO package              Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  The OrbifoldTriangulation data type and constructor.
##
#############################################################################

##
DeclareRepresentation( "IsOrbifoldTriangulationRep",
        IsOrbifoldTriangulation, [ "vertices", "max_simplices", "isotropy", "mu", "mu_data", "info" ] );

##
BindGlobal( "TheFamilyOfOrbifoldTriangulations",
        NewFamily( "TheFamilyOfOrbifoldTriangulations" ) );

##
BindGlobal( "TheTypeOrbifoldTriangulation",
        NewType( TheFamilyOfOrbifoldTriangulations, IsOrbifoldTriangulationRep ) );

##The constructor for OrbifoldTriangulations. Needs the list of maximum simplices M, the Isotropy at certain vertices as a record, and the function Mu as a list of lists of length 4. If only one argument is given, Isotropy and Mu are supposed to be trivial. In case of two arguments, Mu is supposed to be trivial. If the last argument is a string this is stored in the info component.

InstallGlobalFunction( OrbifoldTriangulation,
  function( arg )
    local nargs, info, vertices, triangulation, mu, ind;
    nargs := Length( arg );    
    info := "";
    if IsString( arg[nargs] ) then
        info := arg[nargs];
	nargs := nargs - 1;
    fi;
    vertices := Union( arg[1] );
    mu := function( x )
        return x->x;
    end;
    if nargs = 1 then
        triangulation := rec( vertices := vertices, max_simplices := arg[1], isotropy := rec( ), mu := mu, mu_data := [ ], info := info );
    elif nargs = 2 then
        triangulation := rec( vertices := vertices, max_simplices := arg[1], isotropy := arg[2], mu := mu, mu_data := [ ], info := info );
    elif nargs = 3 then
        mu := function( x )
            for ind in arg[3] do
                if ind{ [ 1 .. 4 ] } = x then
                    return ind[5];
                fi;
            od;
            return x->x;
        end;
        triangulation := rec( vertices := vertices, max_simplices := arg[1], isotropy := arg[2], mu := mu, mu_data := arg[3], info := info );
    fi;
    return Objectify( TheTypeOrbifoldTriangulation, triangulation );
  end
);
  
##
InstallMethod( PrintObj,
        [ IsOrbifoldTriangulation ],
  function( ot )
    local str, forbidden, i, delete;
    str := Concatenation( "OrbifoldTriangulation( ", String( ot!.max_simplices ), ", ", String( ot!.isotropy ), ", ", String( ot!.mu_data ) );
    if ot!.info <> "" then
        str := Concatenation( str, ", \"", ot!.info, "\" )" );
    else
        str := Concatenation( str, " )" );
    fi;
    forbidden := [ "  ", " \n" ];
    delete := [];
    for i in [ 1 .. Length( str ) - 1 ] do
        if str[i] = '\n' then
            str[i] := ' ';
        fi;
	if str{[i,i+1]} in forbidden then
            Add( delete, i+1 );
        fi;
    od;
    str := str{ Difference( [ 1 .. Length( str ) ], delete ) };
    Print( str, "\n" );
  end
);
  
##
InstallMethod( ViewObj,
        [ IsOrbifoldTriangulation ],
  function( ot )
    local info, dim, i, simpl, vert, list, len, str;
    info := "";
    if ot!.info <> "" then
        info := Concatenation( "\"", ot!.info, "\" " );
    fi;
    dim := 0;
    for i in ot!.max_simplices do
        if Length( i ) > dim then
            dim := Length( i );
        fi;
    od;
    dim := dim - 1;
    if Length( ot!.max_simplices ) = 1 then
        simpl := "1 simplex";
    else
        simpl := Concatenation( String( Length( ot!.max_simplices ) ), " simplices" );
    fi;
    if Length( ot!.vertices ) = 1 then
        vert := "1 vertex";
    else
        vert := Concatenation( String( Length( ot!.vertices ) ), " vertices" );
    fi;
    list := RecNames( ot!.isotropy );
    len := Length( list );
    if len = 0 then
        str := "without Isotropy";
    elif len = 1 then
        str := "with Isotropy on 1 vertex";
    else
        str := Concatenation( "with Isotropy on ", String( len ), " vertices" );
    fi;
    if ot!.mu_data <> [] then
        str := Concatenation( str, " and nontrivial mu-maps" );
    fi;
    Print( "OrbifoldTriangulation ", info, "of dimension ", dim, ".\n", simpl, " on ", vert, " ", str );
  end
);
  
##
InstallMethod( Display,
        [ IsOrbifoldTriangulation ],
  function( ot )
    local dist, d, isotropy, i;
    if ot!.info <> "" then
        Print( "\nThe \"", ot!.info, "\" Orbifold:\n" );
    fi;
    dist := 10;
    Print( "\n Vertices:" );
    if Length( RecNames( ot!.isotropy )  ) > 0 then
        Print( ListWithIdenticalEntries( dist, ' ' ), "Isotropy:\n" );
        Print( ListWithIdenticalEntries( dist + 40, '-' ), "\n" );
    else
        Print( "\n", ListWithIdenticalEntries( 11, '-' ), "\n" );
    fi;
    isotropy := ot!.isotropy;
    for i in ot!.vertices do
        if String( i ) in RecNames( ot!.isotropy ) then
            d := dist - Length( String( i ) ) + 9;
            Print( " ", i, ListWithIdenticalEntries( d, ' ' ), isotropy.(i), "\n" );
        else
            Print( " ", i, "\n" );
        fi;
    od;
    Print( "\n", " Simplices = ", ot!.max_simplices, "\n" );
    if ot!.mu_data <> [ ] then
        Print( "\n", " Mu =" );
	ViewObj( ot!.mu_data );
    fi;
    Print( "\n" );
  end
);
  
