#############################################################################
##
##  GAPHomalg.gi              RingsForHomalg package         Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for the external computer algebra system GAP.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( HOMALG_IO_GAP,
        rec(
            cas := "gap",		## normalized name on which the user should have no control
            name := "GAP",
            executable := "gapL",
            options := [ "-q -T -o 15g" ],
            BUFSIZE := 1024,
            READY := "!$%&/(",
            CUT_POS_BEGIN := 1,		## these are the most
            CUT_POS_END := 4,		## delicate values!
            eoc_verbose := ";",
            eoc_quiet := ";;",
            define := ":=",
            delete := function( var, stream ) homalgSendBlocking( [ "Unbind( ", var, " )" ], "need_command", stream, HOMALG_IO.Pictograms.delete ); end,
            multiple_delete := _ExternalGAP_multiple_delete,
            garbage_collector := function( stream ) homalgSendBlocking( [ "GASMAN( \"collect\" )" ], "need_command", stream, HOMALG_IO.Pictograms.garbage_collector ); end,
            prompt := "\033[01mgap>\033[0m ",
            output_prompt := "\033[1;37;44m<gap\033[0m ",
            display_color := "\033[0;35m",           
           )
);

HOMALG_IO_GAP.READY_LENGTH := Length( HOMALG_IO_GAP.READY );

####################################
#
# representations:
#
####################################

# a new subrepresentation of the representation IshomalgExternalObjectWithIOStreamRep:
DeclareRepresentation( "IsHomalgExternalRingObjectInGAPRep",
        IshomalgExternalObjectWithIOStreamRep,
        [  ] );

# a new subrepresentation of the representation IsHomalgExternalRingRep:
DeclareRepresentation( "IsHomalgExternalRingInGAPRep",
        IsHomalgExternalRingRep,
        [  ] );

####################################
#
# families and types:
#
####################################

# a new type:
BindGlobal( "TheTypeHomalgExternalRingObjectInGAP",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingObjectInGAPRep ) );

# a new type:
BindGlobal( "TheTypeHomalgExternalRingInGAP",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingInGAPRep ) );

####################################
#
# global functions:
#
####################################

##
InstallGlobalFunction( _ExternalGAP_multiple_delete,
  function( var_list, stream )
    local str;
    
    str := [ "for _del in ", String( var_list ), " do UnbindGlobal( _del ); od" ];
    
    homalgSendBlocking( str, "need_command", stream, HOMALG_IO.Pictograms.multiple_delete );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( RingForHomalgInExternalGAP,
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
        stream := LaunchCAS( HOMALG_IO_GAP );
        o := 0;
    else
        o := 1;
    fi;
    
    homalgSendBlocking( "LoadPackage(\"RingsForHomalg\")", "need_command", stream, HOMALG_IO.Pictograms.initialize );
    
    ar := [ arg[1], TheTypeHomalgExternalRingObjectInGAP, stream, HOMALG_IO.Pictograms.CreateHomalgRing ];
    
    if nargs > 1 then
        ar := Concatenation( ar, arg{[ 2 .. nargs - o ]} );
    fi;
    
    ext_obj := CallFuncList( homalgSendBlocking, ar );
    
    return CreateHomalgRing( ext_obj, TheTypeHomalgExternalRingInGAP );
    
end );

##
InstallGlobalFunction( HomalgRingOfIntegersInExternalGAP,
  function( arg )
    local nargs, stream, m, c, R;
    
    nargs := Length( arg );
    
    if nargs > 0 then
        if IsRecord( arg[nargs] ) and IsBound( arg[nargs].lines ) and IsBound( arg[nargs].pid ) then
            stream := arg[nargs];
        elif IshomalgExternalObjectWithIOStreamRep( arg[nargs] ) or IsHomalgExternalRingRep( arg[nargs] ) then
            stream := homalgStream( arg[nargs] );
        fi;
    fi;
    
    if nargs = 0 or arg[1] = 0 or ( nargs = 1 and IsBound( stream ) ) then
        m := "";
        c := 0;
    elif IsInt( arg[1] ) then
        m := AbsInt( arg[1] );
        c := m;
    else
        Error( "the first argument must be an integer\n" );
    fi;
    
    if IsBound( stream ) then
        R := RingForHomalgInExternalGAP( [ "HomalgRingOfIntegers( ", m, " )" ], IsPrincipalIdealRing, stream );
    else
        R := RingForHomalgInExternalGAP( [ "HomalgRingOfIntegers( ", m, " )" ], IsPrincipalIdealRing );
    fi;
    
    SetCharacteristic( R, c );
    
    if IsPrime( c ) then
        SetIsFieldForHomalg( R, true );
    else
        SetIsFieldForHomalg( R, false );
        SetIsIntegersForHomalg( R, true );
    fi;
    
    return R;
    
end );

##
InstallGlobalFunction( HomalgFieldOfRationalsInExternalGAP,
  function( arg )
    local ar, R;
    
    ar := Concatenation( [ "HomalgFieldOfRationals( )" ], [ IsPrincipalIdealRing ], arg );
    
    R := CallFuncList( RingForHomalgInExternalGAP, ar );
    
    SetCharacteristic( R, 0 );
    
    SetIsFieldForHomalg( R, true );
    
    return R;
    
end );

##
InstallMethod( SetEntryOfHomalgMatrix,
        "for external matrices in GAP",
        [ IsHomalgExternalMatrixRep, IsInt, IsInt, IsString, IsHomalgExternalRingInGAPRep ],
        
  function( M, r, c, s, R )
    
    homalgSendBlocking( [ "SetEntryOfHomalgMatrix( ", M, r, c, s, R, " ) " ], "need_command", HOMALG_IO.Pictograms.SetEntryOfHomalgMatrix );
    
end );

##
InstallMethod( CreateHomalgMatrix,
        "for a listlist of an external matrix in GAP",
        [ IsString, IsHomalgExternalRingInGAPRep ],
        
  function( S, R )
    local ext_obj;
    
    ## external GAP sees S as a listlist (and not as a string)
    ext_obj := homalgSendBlocking( [ "HomalgMatrix( ", S, ", ", R, " )" ], HOMALG_IO.Pictograms.HomalgMatrix );
    
    return HomalgMatrix( ext_obj, R );
    
end );

##
InstallMethod( CreateHomalgMatrix,
        "for a list of an external matrix in GAP",
        [ IsString, IsInt, IsInt, IsHomalgExternalRingInGAPRep ],
  function( S, r, c, R )
    local ext_obj;
    
    ext_obj := homalgSendBlocking( [ "CreateHomalgMatrix( \"", S, "\", ", r, c , R, " )" ], HOMALG_IO.Pictograms.HomalgMatrix );
    
    return HomalgMatrix( ext_obj, r, c, R );
    
end );

##
InstallMethod( CreateHomalgSparseMatrix,
        "for a sparse list of an external matrix in GAP",
        [ IsString, IsInt, IsInt, IsHomalgExternalRingInGAPRep ],
  function( S, r, c, R )
    local ext_obj, s;
    
    s := homalgSendBlocking( [ "\"", S, "\"" ], R, HOMALG_IO.Pictograms.sparse );
    
    ext_obj := homalgSendBlocking( [ "CreateHomalgSparseMatrix( ", s, r, c , R, " )" ], HOMALG_IO.Pictograms.HomalgMatrix );
    
    return HomalgMatrix( ext_obj, R );
    
end );

##
InstallMethod( GetEntryOfHomalgMatrixAsString,
        "for external matrices in GAP",
        [ IsHomalgExternalMatrixRep, IsInt, IsInt, IsHomalgExternalRingInGAPRep ],
        
  function( M, r, c, R )
    
    return homalgSendBlocking( [ "GetEntryOfHomalgMatrix( ", M, r, c, R, " )" ], "need_output", HOMALG_IO.Pictograms.GetEntryOfHomalgMatrix );
    
end );

##
InstallMethod( GetEntryOfHomalgMatrix,
        "for external matrices in GAP",
        [ IsHomalgExternalMatrixRep, IsInt, IsInt, IsHomalgExternalRingInGAPRep ],
        
  function( M, r, c, R )
    local Mrc;
    
    Mrc := GetEntryOfHomalgMatrixAsString( M, r, c, R );
    
    return HomalgExternalRingElement( Mrc, "GAP", R );
    
end );

##
InstallMethod( GetListOfHomalgMatrixAsString,
        "for external matrices in GAP",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInGAPRep ],
        
  function( M, R )
    local s, l;
    
    s := homalgSendBlocking( [ "GetListOfHomalgMatrixAsString( ", M, " )" ], "need_output", HOMALG_IO.Pictograms.GetListOfHomalgMatrixAsString );
    
    l := Length( s );
    
    if l < 3 then
        return s;
    fi;
    
    return s{[ 2 .. l-1 ]};
    
end );

##
InstallMethod( GetListListOfHomalgMatrixAsString,
        "for external matrices in GAP",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInGAPRep ],
        
  function( M, R )
    local s, l;
    
    s := homalgSendBlocking( [ "GetListListOfHomalgMatrixAsString( ", M, " )" ], "need_output", HOMALG_IO.Pictograms.GetListListOfHomalgMatrixAsString );
    
    l := Length( s );
    
    if l < 3 then
        return s;
    fi;
    
    return s{[ 2 .. l-1 ]};
    
end );

##
InstallMethod( GetSparseListOfHomalgMatrixAsString,
        "for external matrices in Maple",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInGAPRep ],
        
  function( M, R )
    local s, l;
    
    s := homalgSendBlocking( [ "GetSparseListOfHomalgMatrixAsString( ", M, " )" ], "need_output", HOMALG_IO.Pictograms.GetSparseListOfHomalgMatrixAsString );
    
    l := Length( s );
    
    if l < 3 then
        return s;
    fi;
    
    return s{[ 2 .. l-1 ]};
    
end );

##
InstallMethod( SaveDataOfHomalgMatrixToFile,
        "for external matrices in GAP",
        [ IsString, IsHomalgMatrix, IsHomalgExternalRingInGAPRep ],
        
  function( filename, M, R )
    local mode, command;
    
    if not IsBound( M!.SaveAs ) then
        mode := "ListList";
    else
        mode := M!.SaveAs; #not yet supported
    fi;
    
    if mode = "ListList" then
        command := [ "SaveDataOfHomalgMatrixToFile( \"", filename, "\", ", M, " )" ];
                
        homalgSendBlocking( command, "need_command", HOMALG_IO.Pictograms.SaveDataOfHomalgMatrixToFile );
                
    fi;
    
    return true;
    
end );

##
InstallMethod( LoadDataOfHomalgMatrixFromFile,
        "for external rings in GAP",
        [ IsString, IsHomalgExternalRingInGAPRep ],
        
  function( filename, R )
    local mode, command, M;
    
    if not IsBound( R!.LoadAs ) then
        mode := "ListList";
    else
        mode := R!.LoadAs; #not yet supported
    fi;
    
    M := HomalgVoidMatrix( R );
    
    if mode = "ListList" then
        
        command := [ M, " := LoadDataOfHomalgMatrixFromFile( \"", filename, "\", ", R, " )" ];
        
        homalgSendBlocking( command, "need_command", HOMALG_IO.Pictograms.LoadDataOfHomalgMatrixFromFile );
        
    fi;
    
    return M;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( Display,
        "for homalg external matrices in GAP",
        [ IsHomalgExternalMatrixRep ], 1,
        
  function( o )
    
    if IsHomalgExternalRingInGAPRep( HomalgRing( o ) ) then
        
        Print( homalgSendBlocking( [ "Display( ", o, " )" ], "need_display", HOMALG_IO.Pictograms.Display ) );
        
    else
        
        TryNextMethod( );
        
    fi;
    
end );
