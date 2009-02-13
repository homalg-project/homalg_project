#############################################################################
##
##  Macaulay2.gi              RingsForHomalg package          Daniel Robertz
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for the external computer algebra system Macaulay2.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( HOMALG_IO_Macaulay2,
        rec(
            cas := "macaulay2",		## normalized name on which the user should have no control
            name := "Macaulay2",
            executable := "M2",
            options := [ "--no-prompts", "--no-readline", "--print-width", "80" ],
            BUFSIZE := 1024,
            READY := "!$%&/(",
            SEARCH_READY_TWICE := true,	## a Macaulay2 specific
            variable_name := "o",	## a Macaulay2 specific ;-): o2 = 5 -> o1 = 5 : a = 7 -> o2 = 7 : o2 -> o3 = 5
            CUT_POS_BEGIN := -1,	## these values are
            CUT_POS_END := -1,		## not important for Macaulay2
            eoc_verbose := "",
            eoc_quiet := ";",
            setring := _Macaulay2_SetRing,	## a Macaulay2 specific
            setinvol := _Macaulay2_SetInvolution,## a Macaulay2 specific
            define := "=",
            prompt := "\033[01mM2>\033[0m ",
            output_prompt := "\033[1;30;43m<M2\033[0m "
           )
);
            
HOMALG_IO_Macaulay2.READY_LENGTH := Length( HOMALG_IO_Macaulay2.READY );

####################################
#
# representations:
#
####################################

# a new subrepresentation of the representation IshomalgExternalObjectWithIOStreamRep:
DeclareRepresentation( "IsHomalgExternalRingObjectInMacaulay2Rep",
        IshomalgExternalObjectWithIOStreamRep,
        [  ] );

# a new subrepresentation of the representation IsHomalgExternalRingRep:
DeclareRepresentation( "IsHomalgExternalRingInMacaulay2Rep",
        IsHomalgExternalRingRep,
        [  ] );

####################################
#
# families and types:
#
####################################

# a new type:
BindGlobal( "TheTypeHomalgExternalRingObjectInMacaulay2",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingObjectInMacaulay2Rep ) );

# a new type:
BindGlobal( "TheTypeHomalgExternalRingInMacaulay2",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingInMacaulay2Rep ) );

####################################
#
# global functions:
#
####################################

##
InstallGlobalFunction( _Macaulay2_SetRing,
  function( R )
    local stream;
    
    stream := homalgStream( R );
    
    ## since _Macaulay2_SetRing might be called from homalgSendBlocking,
    ## we first set the new active ring to avoid infinite loops:
    stream.active_ring := R;
    
    homalgSendBlocking( [ "use ", R ], "need_command", HOMALG_IO.Pictograms.initialize );
    
end );

##
InstallGlobalFunction( _Macaulay2_SetInvolution,
  function( R )
    local RP;
    
    RP := homalgTable( R );
    
    if IsBound( RP!.SetInvolution ) then
        RP!.SetInvolution( R );
    fi;
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( RingForHomalgInMacaulay2,
  function( arg )
    local nargs, stream, o, ar, ext_obj, R;
    
    nargs := Length( arg );
    
    if nargs > 1 then
        if IsRecord( arg[nargs] ) and IsBound( arg[nargs].lines ) and IsBound( arg[nargs].pid ) then
            stream := arg[nargs];
        elif IshomalgExternalObjectWithIOStreamRep( arg[nargs] ) or IsHomalgExternalRingRep( arg[nargs] ) then
            stream := homalgStream( arg[nargs] );
        fi;
    fi;
    
    if not IsBound( stream ) then
        stream := LaunchCAS( HOMALG_IO_Macaulay2 );
        o := 0;
    else
        o := 1;
    fi;
    
    #InitializeMacaulay2Tools( stream );
    
    ar := [ arg[1], TheTypeHomalgExternalRingObjectInMacaulay2, stream, HOMALG_IO.Pictograms.CreateHomalgRing ];
    
    if nargs > 1 then
        ar := Concatenation( ar, arg{[ 2 .. nargs - o ]} );
    fi;
    
    ext_obj := CallFuncList( homalgSendBlocking, ar );
    
    R := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInMacaulay2 );
    
    _Macaulay2_SetRing( R );
    
    return R;
    
end );

##
InstallGlobalFunction( HomalgRingOfIntegersInMacaulay2,
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
        m := 0;
        c := 0;
    elif IsInt( arg[1] ) then
        m := AbsInt( arg[1] );
        c := m;
    else
        Error( "the first argument must be an integer\n" );
    fi;
    
    if not ( IsZero( c ) or IsPrime( c ) ) then
        Error( "the ring Z/nZ, n nonprime, is not yet fully supported in Macaulay2!\n" );
    fi;
    
    if IsBound( stream ) then
        R := RingForHomalgInMacaulay2( [ "ZZ / ", m ], IsPrincipalIdealRing, stream );
    else
        R := RingForHomalgInMacaulay2( [ "ZZ / ", m ], IsPrincipalIdealRing );
    fi;
    
    SetIsResidueClassRingOfTheIntegers( R, true );
    
    SetRingProperties( R, c );
    
    return R;
    
end );

##
InstallGlobalFunction( HomalgFieldOfRationalsInMacaulay2,
  function( arg )
    local ar, R;
    
    ar := Concatenation( [ "QQ" ], [ IsPrincipalIdealRing ], arg );
    
    R := CallFuncList( RingForHomalgInMacaulay2, ar );
    
    SetIsFieldForHomalg( R, true );
    
    SetRingProperties( R, 0 );
    
    return R;
    
end );

##
InstallMethod( PolynomialRing,
        "for homalg rings in Macaulay2",
        [ IsHomalgExternalRingInMacaulay2Rep, IsList ],
        
  function( R, indets )
    local ar, r, var, properties, ext_obj, S, RP;
    
    ar := _PrepareInputForPolynomialRing( R, indets );
    
    r := ar[1];
    var := ar[2];
    properties := ar[3];
    
    ## create the new ring
    ext_obj := homalgSendBlocking( [ R, "[", var, "]" ], "break_lists", TheTypeHomalgExternalRingObjectInMacaulay2, properties,  HOMALG_IO.Pictograms.CreateHomalgRing );
    
    S := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInMacaulay2 );
    
    var := List( var, a -> HomalgExternalRingElement( a, S ) );
    
    Perform( var, function( v ) SetName( v, homalgPointer( v ) ); end );
    
    SetIsFreePolynomialRing( S, true );
    
    if HasIndeterminatesOfPolynomialRing( R ) and IndeterminatesOfPolynomialRing( R ) <> [ ] then
        SetBaseRing( S, R );
    fi;
    
    SetRingProperties( S, r, var );
    
    SetSyzygiesAlgorithmReturnsMinimalSyzygies( S, true );
    
    _Macaulay2_SetRing( R );
    
    return S;
    
end );

##
InstallMethod( CreateHomalgMatrixFromString,
        "for homalg matrices in Macaulay2",
        [ IsString, IsInt, IsInt, IsHomalgExternalRingInMacaulay2Rep ],
        
  function( s, r, c, R )
    local ext_obj;
    
    ext_obj := homalgSendBlocking( [ "map(", R, "^", r, R, "^", c, ",", s, ")" ], HOMALG_IO.Pictograms.HomalgMatrix );
    
    return HomalgMatrix( ext_obj, r, c, R );
    
end );

##
InstallMethod( GetEntryOfHomalgMatrixAsString,
        "for external matrices in Macaulay2",
        [ IsHomalgExternalMatrixRep, IsInt, IsInt, IsHomalgExternalRingInMacaulay2Rep ],
        
  function( M, r, c, R )
    
    return homalgSendBlocking( [ "(entries ", M, "^{", r - 1, "}_{", c - 1, "})#0#0" ], "need_output", HOMALG_IO.Pictograms.GetEntryOfHomalgMatrix );
    
end );

##
InstallMethod( GetEntryOfHomalgMatrix,
        "for external matrices in Macaulay2",
        [ IsHomalgExternalMatrixRep, IsInt, IsInt, IsHomalgExternalRingInMacaulay2Rep ],
        
  function( M, r, c, R )
    
    return homalgSendBlocking( [ "(entries ", M, "^{", r - 1, "}_{", c - 1, "})#0#0" ], "return_ring_element", HOMALG_IO.Pictograms.GetEntryOfHomalgMatrix );
    
end );

