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

# a new subrepresentation of the representation IshomalgExternalObjectWithIOStreamRep:
DeclareRepresentation( "IsHomalgExternalRingObjectInSageRep",
        IshomalgExternalObjectWithIOStreamRep,
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
        elif IshomalgExternalObjectWithIOStreamRep( arg[nargs] ) or IsHomalgExternalRingRep( arg[nargs] ) then
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
    
    return CreateHomalgRing( ext_obj, TheTypeHomalgExternalRingInSage, HomalgExternalRingElement );
    
end );

InstallGlobalFunction( HomalgRingOfIntegersInSage,
  function( arg )
    local nargs, stream, c, properties, R, command;
    
    nargs := Length( arg );
    
    if nargs > 0 then
        if IsRecord( arg[nargs] ) and IsBound( arg[nargs].lines ) and IsBound( arg[nargs].pid ) then
            stream := arg[nargs];
        elif IshomalgExternalObjectWithIOStreamRep( arg[nargs] ) or IsHomalgExternalRingRep( arg[nargs] ) then
            stream := homalgStream( arg[nargs] );
        fi;
    fi;
    
    if nargs = 0 or arg[1] = 0 or ( nargs = 1 and IsBound( stream ) ) then
        c := 0;
    elif IsInt( arg[1] ) then
        c := AbsInt( arg[1] );
    else
        Error( "the first argument must be an integer\n" );
    fi;
    
    if not ( IsZero( c ) or IsPrime( c ) ) then
        Error( "there is no support for Z/nZ, n nonprime, in Sage!\n" );
    fi;
    
    properties := [ IsPrincipalIdealRing ];
      
    if IsPrime( c ) then
        command := "GF(";
        Add( properties, IsFieldForHomalg );
    else
        command := "IntegerModRing(";
    fi;
    
    if IsBound( stream ) then
        R := RingForHomalgInSage( [ command, c, ")" ], properties, stream );
    else
        R := RingForHomalgInSage( [ command, c, ")" ], properties );
    fi;
    
    SetIsResidueClassRingOfTheIntegers( R, true );
    
    SetRingProperties( R, c );
    
    return R;
    
end );

##
InstallGlobalFunction( HomalgFieldOfRationalsInSage,
  function( arg )
    local ar, R;
    
    ar := Concatenation( [ "QQ" ], [ IsPrincipalIdealRing, IsFieldForHomalg ], arg );
    
    R := CallFuncList( RingForHomalgInSage, ar );
    
    SetIsFieldForHomalg( R, true );
    
    SetRingProperties( R, 0 );
    
    return R;
    
end );
##
InstallMethod( PolynomialRing,
        "for homalg rings",
        [ IsHomalgExternalRingInSageRep, IsList ],
        
  function( R, indets )
    local var, c, properties, r, var_of_coeff_ring, ext_obj, S, v;
    
    if IsString( indets ) and indets <> "" then
        var := SplitString( indets, "," ); 
    elif indets <> [ ] and ForAll( indets, i -> IsString( i ) and i <> "" ) then
        var := indets;
    else
        Error( "either a non-empty list of indeterminates or a comma separated string of them must be provided as the second argument\n" );
    fi;
    
    c := Characteristic( R );
    
    properties := [ IsCommutative ];
    
    if Length( var ) = 1 and HasIsFieldForHomalg( R ) and IsFieldForHomalg( R ) then
        Add( properties, IsPrincipalIdealRing );
    fi;
    
    r := R;
    
    if HasIndeterminatesOfPolynomialRing( R ) then
        r := CoefficientsRing( R );
        var_of_coeff_ring := IndeterminatesOfPolynomialRing( R );
        if not ForAll( var_of_coeff_ring, HasName ) then
            Error( "the indeterminates of coefficients ring must all have a name (use SetName)\n" );
        fi;
        var_of_coeff_ring := List( var_of_coeff_ring, Name );
        if Intersection2( var_of_coeff_ring, var ) <> [ ] then
            Error( "the following indeterminates are already elements of the coefficients ring: ", Intersection2( var_of_coeff_ring, var ), "\n" );
        fi;
        var := Concatenation( var_of_coeff_ring, var );
    fi;
    
    ext_obj := homalgSendBlocking( [ "PolynomialRing(", R, ")" ], [ ], [ ".<", var, ">" ], TheTypeHomalgExternalRingObjectInSage, properties, "break_lists", HOMALG_IO.Pictograms.CreateHomalgRing );
    
    S := CreateHomalgRing( ext_obj, TheTypeHomalgExternalRingInSage, HomalgExternalRingElement );
    
    var := List( var, a -> HomalgExternalRingElement( a, S ) );
    
    for v in var do
        SetName( v, homalgPointer( v ) );
    od;
    
    SetCoefficientsRing( S, r );
    SetCharacteristic( S, c );
    SetIndeterminatesOfPolynomialRing( S, var );
    
    return S;
    
end );

##
InstallMethod( SetEntryOfHomalgMatrix,
        "for external matrices in Sage",
        [ IsHomalgExternalMatrixRep and IsMutableMatrix, IsInt, IsInt, IsString, IsHomalgExternalRingInSageRep ],
        
  function( M, r, c, s, R )
    
    homalgSendBlocking( [ M, "[", r-1, c-1, "]=", s ], "need_command", HOMALG_IO.Pictograms.SetEntryOfHomalgMatrix );
    
end );

##
InstallMethod( AddToEntryOfHomalgMatrix,
        "for external matrices in Sage",
        [ IsHomalgExternalMatrixRep and IsMutableMatrix, IsInt, IsInt, IsHomalgExternalRingElementRep, IsHomalgExternalRingInSageRep ],
        
  function( M, r, c, a, R )
    
    homalgSendBlocking( [ M, "[", r-1, c-1, "]=", a, "+", M, "[", r-1, c-1, "]" ], "need_command", HOMALG_IO.Pictograms.AddToEntryOfHomalgMatrix );
    
end );

##
InstallMethod( CreateHomalgMatrixFromString,
        "for a listlist of an external matrix in Sage",
        [ IsString, IsHomalgExternalRingInSageRep ],
        
  function( S, R )
    local ext_obj;
    
    ext_obj := homalgSendBlocking( [ "matrix(", R, ",", S, ")" ], HOMALG_IO.Pictograms.HomalgMatrix );
    
    return HomalgMatrix( ext_obj, R );
    
end );

##
InstallMethod( CreateHomalgMatrixFromString,
        "for a list of an external matrix in Sage",
        [ IsString, IsInt, IsInt, IsHomalgExternalRingInSageRep ],
 function( S, r, c, R )
    local ext_obj;
    
    ext_obj := homalgSendBlocking( [ "matrix(", R, r, c, ",", S, ")" ], HOMALG_IO.Pictograms.HomalgMatrix );
    
    return HomalgMatrix( ext_obj, r, c, R );
    
end );

##
InstallMethod( CreateHomalgSparseMatrixFromString,
        "for a sparse list of an external matrix in Sage",
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
        "for external matrices in Sage",
        [ IsHomalgExternalMatrixRep, IsInt, IsInt, IsHomalgExternalRingInSageRep ],

  function( M, r, c, R )
    
    return homalgSendBlocking( [ M, "[", r-1, c-1, "]" ], "need_output", HOMALG_IO.Pictograms.GetEntryOfHomalgMatrix );
    
end );

##
InstallMethod( GetEntryOfHomalgMatrix,
        "for external matrices in Sage",
        [ IsHomalgExternalMatrixRep, IsInt, IsInt, IsHomalgExternalRingInSageRep ],
        
  function( M, r, c, R )
    local Mrc;
    
    Mrc := GetEntryOfHomalgMatrixAsString( M, r, c, R );
    
    return HomalgExternalRingElement( Mrc, R );
    
end );

##
InstallMethod( GetListOfHomalgMatrixAsString,
        "for external matrices in Sage",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInSageRep ],
        
  function( M, R )
    
    return homalgSendBlocking( [ M, ".list()" ], "need_output", HOMALG_IO.Pictograms.GetListOfHomalgMatrixAsString );
    
end );

##
InstallMethod( GetListListOfHomalgMatrixAsString,
        "for external matrices in Sage",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInSageRep ],
        
  function( M, R )
    
    return homalgSendBlocking( [ "[", M, "[x].list() for x in range(", NrRows( M ), ")]" ], "need_output", HOMALG_IO.Pictograms.GetListListOfHomalgMatrixAsString );
    
end );

##
InstallMethod( GetSparseListOfHomalgMatrixAsString,
        "for external matrices in Sage",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInSageRep ],
        
  function( M , R )
    
    return homalgSendBlocking( [ "[ [r+1,c+1,", M, "[r,c]] for r in range(", NrRows(M), ") for c in range(", NrColumns(M), ") if not ", M, "[r,c]==", Zero( R ), " ]" ], "need_output", HOMALG_IO.Pictograms.GetSparseListOfHomalgMatrixAsString );
    
end );

##
InstallMethod( SaveDataOfHomalgMatrixToFile,
        "for external matrices in Sage",
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
                
        homalgSendBlocking( command, "need_command", HOMALG_IO.Pictograms.SaveDataOfHomalgMatrixToFile );
                
    fi;
    
    return true;
    
end );

##
InstallMethod( LoadDataOfHomalgMatrixFromFile,
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
        
        homalgSendBlocking( command, "need_command", HOMALG_IO.Pictograms.LoadDataOfHomalgMatrixFromFile );
        
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

