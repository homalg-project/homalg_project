#############################################################################
##
##  homalgExternalObject.gi     homalg package               Mohamed Barakat
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

# a new representation for the GAP-category IshomalgExternalObject:
DeclareRepresentation( "IshomalgExternalObjectRep",
        IshomalgExternalObject,
        [ "pointer", "cas" ] );

# a new subrepresentation of the representation IshomalgExternalObjectRep:
DeclareRepresentation( "IshomalgExternalObjectWithIOStreamRep",
        IshomalgExternalObjectRep,
        [ "pointer", "cas" ] );

# a new subrepresentation of the representation IsContainerForWeakPointersRep:
DeclareRepresentation( "IsContainerForWeakPointersOnHomalgExternalObjectsRep",
        IsContainerForWeakPointersRep,
        [ "weak_pointers", "counter", "deleted" ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfHomalgExternalObjects",
        NewFamily( "TheFamilyOfHomalgExternalObjects" ) );

# a new type:
BindGlobal( "TheTypeHomalgExternalObject",
        NewType( TheFamilyOfHomalgExternalObjects,
                IshomalgExternalObjectRep ) );

# a new type:
BindGlobal( "TheTypeHomalgExternalObjectWithIOStream",
        NewType( TheFamilyOfHomalgExternalObjects,
                IshomalgExternalObjectWithIOStreamRep ) );

# a new family:
BindGlobal( "TheFamilyOfContainersForWeakPointersOnHomalgExternalObjects",
        NewFamily( "TheFamilyOfContainersForWeakPointersOnHomalgExternalObjects" ) );

# a new type:
BindGlobal( "TheTypeContainerForWeakPointersOnHomalgExternalObjects",
        NewType( TheFamilyOfContainersForWeakPointersOnHomalgExternalObjects,
                IsContainerForWeakPointersOnHomalgExternalObjectsRep ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( homalgPointer,
        "for homalg external objects",
        [ IshomalgExternalObjectRep ],
        
  function( o )
    
    if IsBound(o!.pointer) then
        return o!.pointer;
    fi;
    
    return fail;
    
end );

##
InstallMethod( homalgPointer,
        "for homalg external objects",
        [ IsString ],
        
  function( o )
    
    Error( "expected an external object but got a string\n" );
    
end );

##
InstallMethod( homalgPointer,
        "for homalg external objects",
        [ IsBool ],
        
  function( o )
    
    Error( "expected an external object but got ", o, "\n" );
    
end );

##
InstallMethod( homalgExternalCASystem,
        "for homalg external objects",
        [ IshomalgExternalObjectRep ],
        
  function( o )
    
    if IsBound(o!.cas) then
        return o!.cas;
    fi;
    
    return fail;
    
end );

##
InstallMethod( homalgExternalCASystemVersion,
        "for homalg external objects",
        [ IshomalgExternalObjectRep ],
        
  function( o )
    
    if IsBound(o!.cas_version) then
        return o!.cas_version;
    fi;
    
    return fail;
    
end );

##
InstallMethod( homalgStream,
        "for homalg external objects",
        [ IshomalgExternalObjectWithIOStreamRep ],
        
  function( o )
    
    if IsBound(o!.stream) then
        return o!.stream;
    fi;
    
    return fail;
    
end );

##
InstallMethod( homalgExternalCASystemPID,
        "for homalg external objects",
        [ IshomalgExternalObjectWithIOStreamRep ],
        
  function( o )
    
    if IsRecord( homalgStream( o ) ) and IsBound( homalgStream( o ).pid ) then
        return homalgStream( o ).pid;
    fi;
    
    return fail;
    
end );

##
InstallMethod( homalgLastWarning,
        "for homalg external objects",
        [ IshomalgExternalObjectWithIOStreamRep ],
        
  function( o )
    local stream;
    
    stream := homalgStream( o );
    
    if IsBound(stream.warnings) then
        Print( stream.warnings );
    else
        Print( "" );
    fi;
    
end );

##
InstallMethod( homalgNrOfWarnings,
        "for homalg external objects",
        [ IshomalgExternalObjectWithIOStreamRep ],
        
  function( o )
    local stream;
    
    stream := homalgStream( o );
    
    if IsBound(stream.HomalgExternalWarningsCounter) then
        return stream.HomalgExternalWarningsCounter;
    fi;
    
    return 0;
    
end );

##
InstallMethod( \=,
        "for homalg external objects",
        [ IshomalgExternalObjectRep, IshomalgExternalObjectRep ],
        
  function( o1, o2 )
    local components;
    
    components := [ "pointer", "cas" ]; ## don't add more!!!
    
    if IsSubset( NamesOfComponents( o1 ), components )
       and IsSubset( NamesOfComponents( o2 ), components ) then
        return homalgExternalCASystem( o1 ) = homalgExternalCASystem( o2 )
               and homalgPointer( o1 ) = homalgPointer( o2 ); ## we merely are comparing strings in GAP
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

InstallGlobalFunction( homalgExternalObject,
  function( arg )
    local nargs, properties, ar, stream, obj, type;
    
    nargs := Length( arg );
    
    properties := [ ];
    
    for ar in arg{[ 3 .. nargs ]} do
        if not IsBound( stream ) and IsRecord( ar ) and IsBound( ar.lines ) and IsBound( ar.pid ) then
            stream := ar;
        elif not IsBound( type ) and IsType( ar ) then
            type := ar;
        elif IsFilter( ar ) then
            Add( properties, ar );
        else
            Error( "this argument should be in { IsRecord, IsType, IsFilter } bur recieved: ", ar, "\n" );
        fi;
    od;
    
    if IsBound( stream ) then
        obj := rec( pointer := arg[1], cas := arg[2], stream := stream );
        
        if not IsBound( type ) then
            type := TheTypeHomalgExternalObjectWithIOStream;
        fi;
    else
        obj := rec( pointer := arg[1], cas := arg[2] );
        
        if not IsBound( type ) then
            type := TheTypeHomalgExternalObject;
        fi;
    fi;
    
    ## Objectify:
    Objectify( type, obj );
    
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
        [ IshomalgExternalObjectRep ],
        
  function( o )
    
    Print( "<A homalg external object residing in the CAS " );
    Print( homalgExternalCASystem( o ), ">" );
    
end );

InstallMethod( Display,
        "for homalg external objects",
        [ IshomalgExternalObjectRep ],
        
  function( o )
    
    Print( homalgPointer( o ), "\n" );
    
end );

InstallMethod( ViewObj,
        "for containers of weak pointers on homalg external objects",
        [ IsContainerForWeakPointersOnHomalgExternalObjectsRep ],
        
  function( o )
    local del;
    
    del := Length( o!.deleted );
    
    Print( "<A container of weak pointers on homalg external objects: active = ", o!.counter - del, ", deleted = ", del, ">" );
    
end );

InstallMethod( Display,
        "for containers of weak pointers on homalg external objects",
        [ IsContainerForWeakPointersOnHomalgExternalObjectsRep ],
        
  function( o )
    local weak_pointers;
    
    weak_pointers := o!.weak_pointers;
    
    Print( List( [ 1 .. LengthWPObj( weak_pointers ) ], function( i ) if IsBoundElmWPObj( weak_pointers, i ) then return i; else return 0; fi; end ), "\n" );
    
end );

