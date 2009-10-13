#############################################################################
##
##  Sage.gi                   RingsForHomalg package          Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for the external computer algebra system Sage.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( HOMALG_IO_Sage,
        rec(
            cas := "sage",		## normalized name on which the user should have no control
            name := "Sage",
            executable := "sage",
            options := [ ],
            BUFSIZE := 1024,
            READY := "!$%&/(",
            CUT_POS_BEGIN := 7,		## these are the most
            CUT_POS_END := 10,		## delicate values!
            eoc_verbose := "",
            eoc_quiet := ";",
            remove_enter := true,       ## a Sage specific
	    check_output := true,	## a Sage specific
            only_warning := "WARNING:",	## a Sage specific
            define := "=",
            delete := function( var, stream ) homalgSendBlocking( [ "del ", var ], "need_command", stream, HOMALG_IO.Pictograms.delete ); end,
            multiple_delete := _Sage_multiple_delete,
            prompt := "\033[01msage:\033[0m ",
            output_prompt := "\033[1;34;43m<sage\033[0m ",
            display_color := "\033[0;34;43m",
           )
);
            
HOMALG_IO_Sage.READY_LENGTH := Length( HOMALG_IO_Sage.READY );

####################################
#
# representations:
#
####################################

# a new subrepresentation of the representation IshomalgExternalObjectRep:
DeclareRepresentation( "IsHomalgExternalRingObjectInSageRep",
        IshomalgExternalObjectRep,
        [  ] );

# a new subrepresentation of the representation IsHomalgExternalRingRep:
DeclareRepresentation( "IsHomalgExternalRingInSageRep",
        IsHomalgExternalRingRep,
        [  ] );

####################################
#
# families and types:
#
####################################

# a new type:
BindGlobal( "TheTypeHomalgExternalRingObjectInSage",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingObjectInSageRep ) );

# a new type:
BindGlobal( "TheTypeHomalgExternalRingInSage",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingInSageRep ) );

####################################
#
# global functions:
#
####################################

##
InstallGlobalFunction( _Sage_multiple_delete,
  function( var_list, stream )
    local str;
    
    str := [ "del ", var_list ];
    
    homalgSendBlocking( str, "need_command", "break_lists", stream, HOMALG_IO.Pictograms.multiple_delete );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( RingForHomalgInSage,
  function( arg )
    local nargs, stream, o, ar, ext_obj;
    
    nargs := Length( arg );
    
    if nargs > 1 then
        if IsRecord( arg[nargs] ) and IsBound( arg[nargs].lines ) and IsBound( arg[nargs].pid ) then
            stream := arg[nargs];
        elif IshomalgExternalObjectRep( arg[nargs] ) or IsHomalgExternalRingRep( arg[nargs] ) then
            stream := homalgStream( arg[nargs] );
        fi;
    fi;
    
    if not IsBound( stream ) then
        stream := LaunchCAS( HOMALG_IO_Sage );
        o := 0;
    else
        o := 1;
    fi;
    
    ar := [ arg[1], TheTypeHomalgExternalRingObjectInSage, stream, HOMALG_IO.Pictograms.CreateHomalgRing ];
    
    if nargs > 1 then
        ar := Concatenation( ar, arg{[ 2 .. nargs - o ]} );
    fi;
    
    ext_obj := CallFuncList( homalgSendBlocking, ar );
    
    return CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInSage );
    
end );

InstallGlobalFunction( HomalgRingOfIntegersInSage,
  function( arg )
    local nargs, l, c, R;
    
    nargs := Length( arg );
    
    if nargs > 0 and IsInt( arg[1] ) and arg[1] <> 0 then
	l := 2;
        ## characteristic:
        c := AbsInt( arg[1] );
        R := [ "GF(", c, ")" ];
    else
        if nargs > 0 and arg[1] = 0 then
            l := 2;
        else
            l := 1;
        fi;
        ## characteristic:
        c := 0;
        R := [ "IntegerModRing(", c, ")" ];
    fi;
    
    if not ( IsZero( c ) or IsPrime( c ) ) then
        Error( "the ring Z/", c, "Z (", c, " non-prime) is not yet supported for Sage!\nYou can use the generic residue class ring constructor '/' provided by homalg after defining the ambient ring (over the integers)\nfor help type: ?homalg: constructor for residue class rings\n" );
    fi;
    
    R := Concatenation( [ R, IsPrincipalIdealRing ], arg{[ l .. nargs ]} );
    
    R := CallFuncList( RingForHomalgInSage, R );
    
    SetIsResidueClassRingOfTheIntegers( R, true );
    
    SetRingProperties( R, c );
    
    return R;
    
end );

##
InstallGlobalFunction( HomalgFieldOfRationalsInSage,
  function( arg )
    local R;
    
    R := "QQ";
    
    R := Concatenation( [ R ], [ IsPrincipalIdealRing, IsFieldForHomalg ], arg );
    
    R := CallFuncList( RingForHomalgInSage, R );
    
    SetIsFieldForHomalg( R, true );
    
    SetRingProperties( R, 0 );
    
    return R;
    
end );
##
InstallMethod( PolynomialRing,
        "for homalg rings",
        [ IsHomalgExternalRingInSageRep, IsList ],
        
  function( R, indets )
    local ar, r, var, properties, ext_obj, S;
    
    ar := _PrepareInputForPolynomialRing( R, indets );
    
    r := ar[1];
    var := ar[2];
    properties := ar[3];
    
    ## create the new ring
    ext_obj := homalgSendBlocking( [ "PolynomialRing(", R, ")" ], [ ], [ ".<", var, ">" ], TheTypeHomalgExternalRingObjectInSage, properties, "break_lists", HOMALG_IO.Pictograms.CreateHomalgRing );
    
    S := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInSage );
    
    var := List( var, a -> HomalgExternalRingElement( a, S ) );
    
    Perform( var, function( v ) SetName( v, homalgPointer( v ) ); end );
    
    SetIsFreePolynomialRing( S, true );
    
    if HasIndeterminatesOfPolynomialRing( R ) and IndeterminatesOfPolynomialRing( R ) <> [ ] then
        SetBaseRing( S, R );
    fi;
    
    SetRingProperties( S, r, var );
    
    return S;
    
end );

##
InstallMethod( SetEntryOfHomalgMatrix,
        "for homalg external matrices in Sage",
        [ IsHomalgExternalMatrixRep and IsMutableMatrix, IsInt, IsInt, IsString, IsHomalgExternalRingInSageRep ],
        
  function( M, r, c, s, R )
    
    homalgSendBlocking( [ M, "[", r-1, c-1, "]=", s ], "need_command", HOMALG_IO.Pictograms.SetEntryOfHomalgMatrix );
    
end );

##
InstallMethod( AddToEntryOfHomalgMatrix,
        "for homalg external matrices in Sage",
        [ IsHomalgExternalMatrixRep and IsMutableMatrix, IsInt, IsInt, IsHomalgExternalRingElementRep, IsHomalgExternalRingInSageRep ],
        
  function( M, r, c, a, R )
    
    homalgSendBlocking( [ M, "[", r-1, c-1, "]=", a, "+", M, "[", r-1, c-1, "]" ], "need_command", HOMALG_IO.Pictograms.AddToEntryOfHomalgMatrix );
    
end );

##
InstallMethod( CreateHomalgMatrixFromString,
        "constructor for homalg external matrices in Sage",
        [ IsString, IsHomalgExternalRingInSageRep ],
        
  function( S, R )
    local ext_obj;
    
    ext_obj := homalgSendBlocking( [ "matrix(", R, ",", S, ")" ], HOMALG_IO.Pictograms.HomalgMatrix );
    
    return HomalgMatrix( ext_obj, R );
    
end );

##
InstallMethod( CreateHomalgMatrixFromString,
        "constructor for homalg external matrices in Sage",
        [ IsString, IsInt, IsInt, IsHomalgExternalRingInSageRep ],
 function( S, r, c, R )
    local ext_obj;
    
    ext_obj := homalgSendBlocking( [ "matrix(", R, r, c, ",", S, ")" ], HOMALG_IO.Pictograms.HomalgMatrix );
    
    return HomalgMatrix( ext_obj, r, c, R );
    
end );

##
InstallMethod( CreateHomalgMatrixFromSparseString,
        "constructor for homalg external matrices in Sage",
        [ IsString, IsInt, IsInt, IsHomalgExternalRingInSageRep ],

  function( S, r, c, R )
    local M, s;
    
    M := HomalgInitialMatrix( r, c, R );
    
    s := homalgSendBlocking( S, R, HOMALG_IO.Pictograms.sparse );
    
    homalgSendBlocking( [ "FillMatrix(", M, ",",  s, ")" ], "need_command", HOMALG_IO.Pictograms.HomalgMatrix );
    
    return M;
    
end );

##
InstallMethod( GetEntryOfHomalgMatrixAsString,
        "for homalg external matrices in Sage",
        [ IsHomalgExternalMatrixRep, IsInt, IsInt, IsHomalgExternalRingInSageRep ],

  function( M, r, c, R )
    
    return homalgSendBlocking( [ M, "[", r-1, c-1, "]" ], "need_output", HOMALG_IO.Pictograms.GetEntryOfHomalgMatrix );
    
end );

##
InstallMethod( GetEntryOfHomalgMatrix,
        "for homalg external matrices in Sage",
        [ IsHomalgExternalMatrixRep, IsInt, IsInt, IsHomalgExternalRingInSageRep ],
        
  function( M, r, c, R )
    local Mrc;
    
    Mrc := GetEntryOfHomalgMatrixAsString( M, r, c, R );
    
    return HomalgExternalRingElement( Mrc, R );
    
end );

##
InstallMethod( GetListOfHomalgMatrixAsString,
        "for homalg external matrices in Sage",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInSageRep ],
        
  function( M, R )
    
    return homalgSendBlocking( [ M, ".list()" ], "need_output", HOMALG_IO.Pictograms.GetListOfHomalgMatrixAsString );
    
end );

##
InstallMethod( GetListListOfHomalgMatrixAsString,
        "for homalg external matrices in Sage",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInSageRep ],
        
  function( M, R )
    
    return homalgSendBlocking( [ "[", M, "[x].list() for x in range(", NrRows( M ), ")]" ], "need_output", HOMALG_IO.Pictograms.GetListListOfHomalgMatrixAsString );
    
end );

##
InstallMethod( GetSparseListOfHomalgMatrixAsString,
        "for homalg external matrices in Sage",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInSageRep ],
        
  function( M , R )
    
    return homalgSendBlocking( [ "[ [r+1,c+1,", M, "[r,c]] for r in range(", NrRows(M), ") for c in range(", NrColumns(M), ") if not ", M, "[r,c]==", Zero( R ), " ]" ], "need_output", HOMALG_IO.Pictograms.GetSparseListOfHomalgMatrixAsString );
    
end );

##
InstallMethod( SaveHomalgMatrixToFile,
        "for homalg external matrices in Sage",
        [ IsString, IsHomalgMatrix, IsHomalgExternalRingInSageRep ],
        
  function( filename, M, R )
    local mode, command;
    
    if not IsBound( M!.SaveAs ) then
        mode := "ListList";
    else
        mode := M!.SaveAs; #not yet supported
    fi;
    
    if mode = "ListList" then
        command := [ "_fs = open('", filename, "','w'); ",
                     "_fs.write(str( [", M, "[x].list() for x in range(", NrRows( M ), ")] )); ",
                     "_fs.close()" ];
                
        homalgSendBlocking( command, "need_command", HOMALG_IO.Pictograms.SaveHomalgMatrixToFile );
                
    fi;
    
    return true;
    
end );

##
InstallMethod( LoadHomalgMatrixFromFile,
        "for external rings in Sage",
        [ IsString, IsHomalgExternalRingInSageRep ],
        
  function( filename, R )
    local mode, command, M;
    
    if not IsBound( R!.LoadAs ) then
        mode := "ListList";
    else
        mode := R!.LoadAs; #not yet supported
    fi;
    
    M := HomalgVoidMatrix( R );
    
    if mode = "ListList" then
        
        command := [ "_fs = open('", filename, "','r'); ",
                     "_str = _fs.read(); ",
                     "_fs.close(); ",
                     M, "= matrix(", R, ",eval(_str))" ];
        
        homalgSendBlocking( command, "need_command", HOMALG_IO.Pictograms.LoadHomalgMatrixFromFile );
        
    fi;
    
    return M;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( DisplayRing,
        "for homalg rings in Sage",
        [ IsHomalgExternalRingInSageRep ], 1,
        
  function( o )
    
    homalgDisplay( o );
    
end );

