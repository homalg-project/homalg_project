#############################################################################
##
##  IO.gd                       homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff to use the legendary GAP4 I/O package of Max Neunhoeffer
##
#############################################################################

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "HomalgExternalObjectFamily",
        NewFamily( "HomalgExternalObjectFamily" ) );

# a new type:
BindGlobal( "HomalgExternalObjectType",
        NewType( HomalgExternalObjectFamily,
                IsHomalgExternalObjectIORep ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( HomalgPointer,
        "for homalg matrices",
        [ IsHomalgExternalObjectIORep ],
        
  function( o )
    
    if IsBound(o!.pointer) then
        return o!.pointer;
    fi;
    
    return fail;
    
end );

##
InstallMethod( HomalgExternalCASystem,
        "for homalg matrices",
        [ IsHomalgExternalObjectIORep ],
        
  function( o )
    
    if IsBound(o!.cas) then
        return o!.cas;
    fi;
    
    return fail;
    
end );

##
InstallMethod( HomalgExternalCASystemVersion,
        "for homalg matrices",
        [ IsHomalgExternalObjectIORep ],
        
  function( o )
    
    if IsBound(o!.cas_version) then
        return o!.cas_version;
    fi;
    
    return fail;
    
end );

##
InstallMethod( HomalgStream,
        "for homalg matrices",
        [ IsHomalgExternalObjectIORep ],
        
  function( o )
    
    if IsBound(o!.stream) then
        return o!.stream;
    fi;
    
    return fail;
    
end );

##
InstallMethod( HomalgExternalCASystemPID,
        "for homalg matrices",
        [ IsHomalgExternalObjectIORep ],
        
  function( o )
    
    return HomalgStream( o ).pid;
    
end );

##
InstallGlobalFunction( HomalgCreateStringForExternalCASystem,
  function( L )
    local l, s;
    
    if not IsList( L ) then
        Error( "the first argument must be a list\n" );
    fi;
    
    l := Length( L );
    
    s := List( [ 1 .. l ], function( a )
                             local t;
                             if IsString( L[a] ) then
                                 return L[a];
                             else
                                 if IsHomalgExternalObjectIORep( L[a] )
                                    or IsHomalgExternalMatrixRep( L[a] ) then
                                     t := HomalgPointer( L[a] );
                                 else
                                     t := String( L[a] );
                                 fi;
                                 if a < l and not IsString( L[a+1] ) then
                                     t := Concatenation( t, "," );
                                 fi;
                                 return t;
                             fi;
                           end );
    
    return Flat( s );
                           
end );
##
InstallGlobalFunction( HomalgSendBlocking,
  function( arg )
    local L, nargs, option, R, ext_obj, e, RP, cas, cas_version, stream, homalg_variable,
          SendBlocking, define, l, eol_verbose, eol_quiet, eol, enter;
    
    if not IsList( arg[1] ) then
        Error( "the first argument must be a list\n" );
    else
        L := arg[1];
    fi;
    
    nargs := Length( arg );
    
    if nargs = 2 then
        if IsString( arg[2] ) then
            option := arg[2];
        elif IsHomalgExternalRingRep( arg[2] ) then
            R := arg[2];
            ext_obj := R;
        else
            Error( "if two arguments are provided, then the second argument must be a string or an IsHomalgExternalRingRep" );
        fi;
    elif nargs = 3 then
        if IsString( arg[2] ) and IsHomalgExternalRingRep( arg[3] ) then
            option := arg[2];
            R := arg[3];
            ext_obj := R;
        else
            Error( "if three arguments are provided, then the second argument must be a string and the third an IsHomalgExternalRingRep" );
        fi;
    fi;
    
    if not IsBound( ext_obj ) then
        e := Filtered( L, a -> IsHomalgExternalMatrixRep( a ) );
        if e <> [ ] then
            ext_obj := e[1];
            R := HomalgRing( ext_obj ); ## we assume that ext_obj is either a matrix or an external ring element
        else
            Error( "since the last argument is not an external ring the first argument must be a list containing at least one external object\n" );
        fi;
    fi;
    
    RP := HomalgTable( R );
    
    if IsBound(RP!.HomalgSendBlocking) then
        return RP!.HomalgSendBlocking( arg );
    fi;
    
    cas := HomalgExternalCASystem( ext_obj );
    cas_version := HomalgExternalCASystemVersion( ext_obj );
    stream := HomalgStream( ext_obj );
    
    if not IsBound( option ) then
        if not IsBound( RP!.ExternalVariableCounter ) then
            RP!.ExternalVariableCounter := 1;
        fi;
        homalg_variable := Concatenation( "homalg_variable_", String( RP!.ExternalVariableCounter ) );
        MakeImmutable( homalg_variable );
        RP!.ExternalVariableCounter := RP!.ExternalVariableCounter + 1;
    fi;
    
    L := HomalgCreateStringForExternalCASystem( L );
    
    if LowercaseString( cas{[1..4]} ) = "sage" then
        SendBlocking := SendSageBlocking;
        define := "=";
        eol_verbose := "";
        eol_quiet := ";";
    elif LowercaseString( cas{[1..8]} ) = "singular" then
        SendBlocking := SendSingularBlocking;
        define := "=";
        eol_verbose := ";";
        eol_quiet := ";";
    elif LowercaseString( cas{[1..5]} ) = "maple" then
        if cas_version = "10" then
            SendBlocking := SendMaple10Blocking;
        elif cas_version = "9.5" then
            SendBlocking := SendMaple95Blocking;
        elif cas_version = "9" then
            SendBlocking := SendMaple9Blocking;
        else
            SendBlocking := SendMaple10Blocking;
        fi;
        define := ":=";
        eol_verbose := ";";
        eol_quiet := ":";
    else
        Error( "the computer algebra system ", cas, " is not yet supported as an external computing engine for homalg\n" );
    fi;
    
    l := Length( L );
    
    if L{[l-1..l]} = "\n" then
        enter := "";
        eol := "";
    else
        enter := "\n";
        if L{[l-Length( eol_verbose )+1..l]} = eol_verbose
           or L{[l-Length( eol_quiet )+1..l]} = eol_quiet then
            eol := "";
        elif not IsBound( option ) then
            eol := eol_quiet;
        else
            eol := eol_verbose;
        fi;
    fi;
    
    if not IsBound( option ) then
        L := Concatenation( homalg_variable, define, L, eol, enter );
    else
        L := Concatenation( L, eol, enter );
    fi;
    
    SendBlocking( stream, L );
    
    if not IsBound( option ) then
        return HomalgExternalObject( homalg_variable, cas, stream );
    else
        return stream.lines;
    fi;
    
end );

####################################
#
# constructor functions and methods:
#
####################################

InstallGlobalFunction( HomalgExternalObject,
  function( arg )
    local obj;
    
    obj := rec( pointer := arg[1], cas := arg[2], stream := arg[3] );
    
    ## Objectify:
    Objectify( HomalgExternalObjectType, obj );
    
    return obj;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( ViewObj,
        "for homalg matrices",
        [ IsHomalgExternalObjectIORep ],
        
  function( o )
    
    Print( "<A homalg object defined externally in the CAS " );
    Print( HomalgExternalCASystem( o ), " running with pid ", HomalgExternalCASystemPID( o ), ">" ); 
    
end );

