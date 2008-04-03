#############################################################################
##
##  MAGMA.gi                  RingsForHomalg package         Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for the external computer algebra system MAGMA.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( HOMALG_IO_MAGMA,
        rec(
            cas := "magma",		## normalized name on which the user should have no control
            name := "MAGMA",
            executable := "magma",
            options := [ ],
            BUFSIZE := 1024,
            READY := "!$%&/(",
            CUT_BEGIN := 1,		## these are the most
            CUT_END := 2,		## delicate values!
            eoc_verbose := ";",
            eoc_quiet := ";",
            define := ":=",
            prompt := "magma> ",
            output_prompt := "\033[1;31;47m<magma\033[0m ",
            display_color := "\033[0;30;47m",
           )
);

HOMALG_IO_MAGMA.READY_LENGTH := Length( HOMALG_IO_MAGMA.READY );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( RingForHomalgInMAGMA,
  function( arg )
    local stream, ar, ext_obj;
    
    stream := LaunchCAS( HOMALG_IO_MAGMA );
    
    if Length( arg ) > 1 and IsFilter( arg[Length(arg)] ) then
        ar := Concatenation( arg, [ stream ] );
    else
        ar := Concatenation( arg, [ IsHomalgRingInMAGMA, stream ] );
    fi;
    
    ext_obj := CallFuncList( HomalgSendBlocking, ar );
    
    return CreateHomalgRing( ext_obj, IsHomalgExternalObjectWithIOStream, IsHomalgRingInMAGMA );
    
end );

##
InstallGlobalFunction( HomalgRingOfIntegersInMAGMA,
  function( arg )
    local nargs, m, c, R;
    
    nargs := Length( arg );
    
    if nargs = 0 or arg[1] = 0 then
        m := "";
        c := 0;
    elif IsInt( arg[1] ) then
        m := AbsInt( arg[1] );
        c := m;
    else
        Error( "the first argument must be an integer\n" );
    fi;
    
    R := RingForHomalgInMAGMA( [ "IntegerRing(", m, ")" ], IsIntegersForHomalgInMAGMA );
    
    SetCharacteristic( R, c );
    
    return R;
    
end );

##
InstallGlobalFunction( HomalgFieldOfRationalsInMAGMA,
  function( arg )
    local R;
    
    R := RingForHomalgInMAGMA( [ "Rationals()" ], IsPIRForHomalgInMAGMA );
    
    SetCharacteristic( R, 0 );
    
    return R;
    
end );

##
InstallMethod( PolynomialRing,
        "for homalg rings",
        [ IsHomalgExternalRingRep and IsHomalgRingInMAGMA, IsList ],
        
  function( R, indets )
    local var, properties, ext_obj;
    
    if IsString( indets ) and indets <> "" then
        var := SplitString( indets, "," ); 
    elif indets <> [ ] and ForAll( indets, i -> IsString( i ) and i <> "" ) then
        var := indets;
    else
        Error( "either a non-empty list of indeterminates or a comma separated string of them must be provided as the second argument\n" );
    fi;
    
    properties := [ IsPolynomialRingForHomalgInMAGMA ];
    
    if Length( var ) = 1 then
        Add( properties, IsPIRForHomalgInMAGMA );
    fi;
    
    ext_obj := HomalgSendBlocking( [ "PolynomialRing(", R, ")" ], [ ], [ "<", indets, ">" ], properties, "break_lists" );
    
    return CreateHomalgRing( ext_obj, IsHomalgExternalObjectWithIOStream );
    
end );

##
InstallMethod( \*,
        "for homalg rings",
        [ IsHomalgExternalRingRep and IsHomalgRingInMAGMA, IsString ],
        
  function( R, indets )
    
    return PolynomialRing( R, SplitString( indets, "," ) );
    
end );

##
InstallMethod( HomalgMatrixInMAGMA,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep, IsHomalgExternalRingRep and IsHomalgExternalObjectWithIOStream ],
        
  function( M, R )
    local ext_obj;
    
    ext_obj := HomalgSendBlocking( [ "Matrix(", R, ",", String( Eval( M ) ), ")" ] );
    
    return HomalgMatrix( ext_obj, R );
    
end );

##
InstallMethod( HomalgMatrixInMAGMA,
        "for homalg matrices",
        [ IsString, IsHomalgExternalRingRep and IsHomalgExternalObjectWithIOStream ],
        
  function( M, R )
    local ext_obj;
    
    ext_obj := HomalgSendBlocking( [ "Matrix(", R, ",", M, ")" ] );
    
    return HomalgMatrix( ext_obj, R );
    
end );

