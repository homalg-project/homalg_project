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
                IsHomalgExternalObjectRep ) );

####################################
#
# methods for operations:
#
####################################

InstallMethod( \=,
        "for homalg matrices",
        [ IsHomalgExternalObjectRep, IsHomalgExternalObjectRep ],
        
  function( o1, o2 )
    
    if not HasIsHomalgExternalObjectWithIOStream( o1 )
       and not HasIsHomalgExternalObjectWithIOStream( o2 ) then
        return HomalgPointer( o1 ) = HomalgPointer( o2 ); ## we are comparing strings in GAP
    fi;
    
    TryNextMethod( );
    
end );
##
InstallMethod( HomalgPointer,
        "for homalg matrices",
        [ IsHomalgExternalObjectWithIOStream ],
        
  function( o )
    
    if IsBound(o!.pointer) then
        return o!.pointer;
    fi;
    
    return fail;
    
end );

##
InstallMethod( HomalgExternalCASystem,
        "for homalg matrices",
        [ IsHomalgExternalObjectWithIOStream ],
        
  function( o )
    
    if IsBound(o!.cas) then
        return o!.cas;
    fi;
    
    return fail;
    
end );

##
InstallMethod( HomalgExternalCASystemVersion,
        "for homalg matrices",
        [ IsHomalgExternalObjectWithIOStream ],
        
  function( o )
    
    if IsBound(o!.cas_version) then
        return o!.cas_version;
    fi;
    
    return fail;
    
end );

##
InstallMethod( HomalgStream,
        "for homalg matrices",
        [ IsHomalgExternalObjectWithIOStream ],
        
  function( o )
    
    if IsBound(o!.stream) then
        return o!.stream;
    fi;
    
    return fail;
    
end );

##
InstallMethod( HomalgExternalCASystemPID,
        "for homalg matrices",
        [ IsHomalgExternalObjectWithIOStream ],
        
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
                                 if IsHomalgExternalObjectRep( L[a] )
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
    local L, nargs, properties, ar, option, R, ext_obj, e, RP, cas, cas_version, stream, homalg_variable,
          SendBlocking, define, l, eol_verbose, eol_quiet, eol, enter;
    
    if not IsList( arg[1] ) then
        Error( "the first argument must be a list\n" );
    elif IsString( arg[1] ) then
        L := [ arg[1] ];
    else
        L := arg[1];
    fi;
    
    nargs := Length( arg );
    
    properties := [];
    
    for ar in arg{[ 2 .. nargs ]} do
        if not IsBound( option ) and IsString( ar ) then
            option := ar;
        elif not IsBound( R ) and IsHomalgExternalRingRep( ar ) then
            R := ar;
            ext_obj := R;
        elif not IsBound( ext_obj )
          and HasIsHomalgExternalObjectWithIOStream( ar ) and IsHomalgExternalObjectWithIOStream( ar ) then
            ext_obj := ar;
        elif IsOperation( ar ) then
            Add( properties, ar );
        else
            Error( "this argument should be in { IsString, IsHomalgExternalRingRep, IsHomalgExternalObjectWithIOStream } bur recieved: ", ar,"\n" );
        fi;
    od;
    
    if not IsBound( ext_obj ) then
        e := Filtered( L, a -> IsHomalgExternalMatrixRep( a ) ); ## after adding things here the Error message below has to be updated
        if e <> [ ] then
            ext_obj := e[1];
            R := HomalgRing( ext_obj ); ## we assume that ext_obj is either a matrix or an external ring element
        else
            Error( "since the last argument is not an external ring or an external object the list provided the first argument must contain at least one external matrix\n" );
        fi;
    fi;
    
    if IsBound( R ) then
        RP := HomalgTable( R );
        
        if IsBound(RP!.HomalgSendBlocking) then
            return RP!.HomalgSendBlocking( arg );
        fi;
    fi;
    
    cas := HomalgExternalCASystem( ext_obj );
    cas_version := HomalgExternalCASystemVersion( ext_obj );
    stream := HomalgStream( ext_obj );
    
    if not IsBound( option ) then
        if not IsBound( stream.ExternalVariableCounter ) then
            stream.ExternalVariableCounter := 1;
        fi;
        homalg_variable := Concatenation( "homalg_variable_", String( stream.ExternalVariableCounter ) );
        MakeImmutable( homalg_variable );
        stream.ExternalVariableCounter := stream.ExternalVariableCounter + 1;
    fi;
    
    L := HomalgCreateStringForExternalCASystem( L );
    
    if Length( cas ) > 3 and LowercaseString( cas{[1..4]} ) = "sage" then
        SendBlocking := SendSageBlocking;
        define := "=";
        eol_verbose := "";
        eol_quiet := ";";
    elif Length( cas ) > 7 and LowercaseString( cas{[1..8]} ) = "singular" then
        SendBlocking := SendSingularBlocking;
        define := "=";
        eol_verbose := ";";
        eol_quiet := ";";
    elif Length( cas ) > 4 and LowercaseString( cas{[1..5]} ) = "maple" then
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
    
    if Length( L ) > 0 and L{[l..l]} = "\n" then
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
        L := HomalgExternalObject( homalg_variable, cas, stream );
        
        if properties <> [ ] and IsHomalgExternalObjectWithIOStream( L ) then
            for ar in properties do
                Setter( ar )( L, true );
            od;
        fi;
        
        return L;
    else
        return stream.lines;
    fi;
    
end );

##
InstallGlobalFunction( StringToIntList,
  function( arg )
    local l, lint;
    
    l := SplitString( arg[1], ",", "[ ]\n" );
    lint := List( l, Int ); 
    
    if fail in lint then
        Error( "the first argument is not a string containg a list of integers: ", arg[1], "\n");
    fi;
    
    return lint;
    
end );

##
InstallGlobalFunction( StringToElementStringList,
  function( arg )
    
    return SplitString( arg[1], ",", "[ ]\n" );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

InstallGlobalFunction( HomalgExternalObject,
  function( arg )
    local nargs, properties, ar, stream, obj;
    
    nargs := Length( arg );
    
    properties := [ ];
    
    for ar in arg{[ 3 .. nargs ]} do
        if not IsBound( stream ) and IsRecord( ar ) and IsBound( ar.lines ) and IsBound( ar.pid ) then
            stream := ar;
        elif IsOperation( ar ) then
            Add( properties, ar );
        else
            Error( "this argument should be in { IsRecord, IsOperation } bur recieved: ", ar,"\n" );
        fi;
    od;
    
    if IsBound( stream ) then
        obj := rec( pointer := arg[1], cas := arg[2], stream := stream );
        
        ## Objectify:
        ObjectifyWithAttributes(
                obj, HomalgExternalObjectType,
                IsHomalgExternalObjectWithIOStream, true );
    else
        obj := rec( pointer := arg[1], cas := arg[2] );
        
        ## Objectify:
        Objectify( HomalgExternalObjectType, obj );
    fi;
    
    if properties <> [ ] then
        for ar in properties do
            Setter( ar )( obj, true );
        od;
    fi;
    
    return obj;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( ViewObj,
        "for homalg matrices",
        [ IsHomalgExternalObjectRep ],
        
  function( o )
    
    Print( "<A homalg external object for the CAS " );
    Print( HomalgExternalCASystem( o ), ">" ); 
    
end );

InstallMethod( ViewObj,
        "for homalg matrices",
        [ IsHomalgExternalObjectRep and IsHomalgExternalObjectWithIOStream ],
        
  function( o )
    
    Print( "<A homalg object defined externally in the CAS " );
    Print( HomalgExternalCASystem( o ), " running with pid ", HomalgExternalCASystemPID( o ), ">" ); 
    
end );

