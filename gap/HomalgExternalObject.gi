#############################################################################
##
##  HomalgExternalObject.gi     homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for homalg's external objects.
##
#############################################################################

####################################
#
# representations:
#
####################################

# a new representation for the category IsHomalgExternalObject:
DeclareRepresentation( "IsHomalgExternalObjectRep",
        IsHomalgExternalObject,
        [ "object", "cas" ] );

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

##
InstallMethod( \=,
        "for homalg matrices",
        [ IsHomalgExternalObjectRep, IsHomalgExternalObjectRep ],
        
  function( o1, o2 )
    local components;
    
    components := [ "pointer", "cas" ]; ## don't add more!!!
    
    if IsSubset( NamesOfComponents( o1 ), components )
       and IsSubset( NamesOfComponents( o2 ), components ) then
        return HomalgPointer( o1 ) = HomalgPointer( o2 ); ## we merely are comparing strings in GAP
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( HomalgPointer,
        "for homalg matrices",
        [ IsHomalgExternalObjectRep ],
        
  function( o )
    
    if IsBound(o!.pointer) then
        return o!.pointer;
    fi;
    
    return fail;
    
end );

##
InstallMethod( HomalgExternalCASystem,
        "for homalg matrices",
        [ IsHomalgExternalObjectRep ],
        
  function( o )
    
    if IsBound(o!.cas) then
        return o!.cas;
    fi;
    
    return fail;
    
end );

##
InstallMethod( HomalgExternalCASystemVersion,
        "for homalg matrices",
        [ IsHomalgExternalObjectRep ],
        
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
        "for homalg external objects",
        [ IsHomalgExternalObjectRep ],
        
  function( o )
    
    Print( "<A homalg external object for the CAS " );
    Print( HomalgExternalCASystem( o ), ">" ); 
    
end );

InstallMethod( Display,
        "for homalg matrices",
        [ IsHomalgExternalObjectRep ],
        
  function( o )
    
    Print( HomalgPointer( o ), "\n" );
    
end );
