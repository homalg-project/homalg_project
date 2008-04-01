#############################################################################
##
##  IO.gi                     RingsForHomalg package         Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff to use the fantastic GAP4 I/O package of Max Neunhöffer.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

##
InstallGlobalFunction( HomalgCreateStringForExternalCASystem,
  function( L )
    local l, s;
    
    if not IsList( L ) then
        Error( "the first argument must be a list\n" );
    fi;
    
    l := Length( L );
    
    s := List( [ 1 .. l ], function( a )
                             local CAS, stream, t;
                             if IsString( L[a] ) then
                                 return L[a];
                             else
                                 if IsHomalgExternalObjectRep( L[a] )
                                    or IsHomalgExternalRingRep( L[a] ) then
                                     t := HomalgPointer( L[a] );
                                 elif IsHomalgExternalMatrixRep( L[a] ) then
                                     if not IsVoidMatrix( L[a] ) or HasEval( L[a] ) then
                                         t := HomalgPointer( L[a] ); ## now we enforce evaluation!!!
                                     else
                                         CAS := HomalgExternalCASystem( L[a] );
                                         stream := HomalgStream( L[a] );
                                         stream.HomalgExternalVariableCounter := stream.HomalgExternalVariableCounter + 1;
                                         t := Concatenation( "homalg_variable_", String( stream.HomalgExternalVariableCounter ) );
                                         MakeImmutable( t );
                                         SetEval( L[a], HomalgExternalObject( t, CAS, stream ) ); ## CAUTION: HomalgPointer( L[a] ) now exists but still points to nothing!!!
                                         ResetFilterObj( L[a], IsVoidMatrix );
                                     fi;
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
    local L, nargs, properties, ar, option, need_command, need_display, need_output,
          R, ext_obj, prefix, suffix, e, RP, CAS, cas_version, stream, homalg_variable,
          l, eoc, enter, max;
    
    if IsBound( HOMALG_RINGS.HomalgSendBlockingInput ) then
        Add( HOMALG_RINGS.HomalgSendBlockingInput, arg );
    fi;
    
    Info( InfoRingsForHomalg, 10, arg );
    
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
        if not IsBound( option ) and IsString( ar ) then ## the first occurrence of an option decides
            if PositionSublist( LowercaseString( ar ), "command" ) <> fail then
                need_command := true;
                need_display := false;
                need_output := false;
            elif PositionSublist( LowercaseString( ar ), "display" ) <> fail then
                need_display := true;
                need_command := false;
                need_output := false;
            elif PositionSublist( LowercaseString( ar ), "output" ) <> fail then
                need_output := true;
                need_command := false;
                need_display := false;
            else
                Error( "option must be one of {\"need_command\", \"need_display\", \"need_output\" }, but received: ", ar, "\n" );
            fi;
            option := ar;
        elif not IsBound( R ) and IsHomalgExternalRingRep( ar ) then
            R := ar;
            ext_obj := R;
        elif not IsBound( ext_obj ) and IsHomalgExternalObject( ar )
          and HasIsHomalgExternalObjectWithIOStream( ar ) and IsHomalgExternalObjectWithIOStream( ar ) then
            ext_obj := ar;
        elif IsFilter( ar ) then
            Add( properties, ar );
        elif not IsBound( prefix ) and ( ( IsList( ar ) and not IsString( ar ) ) or ar = [] ) then
            prefix := ar;
        elif not IsBound( suffix ) and IsList( ar ) and not IsString( ar ) then
            suffix := ar;
        else
            Error( "this argument should be in { IsString, IsFilter, IsHomalgExternalRingRep, IsHomalgExternalObjectWithIOStream } bur recieved: ", ar,"\n" );
        fi;
    od;
    
    if not IsBound( ext_obj ) then ## R is also not yet defined
        e := Filtered( L, a -> IsHomalgExternalMatrixRep( a ) or IsHomalgExternalRingRep( a ) or 
                     ( IsHomalgExternalObjectRep( a )
                       and HasIsHomalgExternalObjectWithIOStream( a )
                       and IsHomalgExternalObjectWithIOStream( a ) ) );
        if e <> [ ] then
            ext_obj := e[1];
            for ar in e do
                if IsHomalgExternalMatrixRep( ar ) then
                    R := HomalgRing( ar );
                    break;
                elif IsHomalgExternalRingRep( ar ) then
                    R := ar;
                    break;
                fi;
            od;
        else
            Error( "either the list provided by the first argument must contain at least one external matrix or an external ring or one of the remaining arguments must be an external ring or an external object with IO stream\n" );
        fi;
    fi;
    
    if IsBound( R ) then
        RP := HomalgTable( R );
        
        if IsBound(RP!.HomalgSendBlocking) then
            return RP!.HomalgSendBlocking( arg );
        fi;
    fi;
    
    CAS := HomalgExternalCASystem( ext_obj );
    cas_version := HomalgExternalCASystemVersion( ext_obj );
    stream := HomalgStream( ext_obj );
    
    if not IsBound( stream.HomalgExternalVariableCounter ) then
        
        stream.HomalgExternalVariableCounter := 0;
        stream.HomalgExternalCommandCounter := 0;
        stream.HomalgExternalOutputCounter := 0;
        stream.HomalgExternalCallCounter := 0;
        stream.HomalgBackStreamMaximumLength := 0;
        
    fi;
    
    if not IsBound( option ) then
        stream.HomalgExternalVariableCounter := stream.HomalgExternalVariableCounter + 1;
        homalg_variable := Concatenation( "homalg_variable_", String( stream.HomalgExternalVariableCounter ) );
        MakeImmutable( homalg_variable );
    fi;
    
    if IsBound( prefix ) and prefix <> [ ] then
        prefix := Concatenation( HomalgCreateStringForExternalCASystem( prefix ), " " );
    fi;
    
    if IsBound( suffix ) then
        suffix := HomalgCreateStringForExternalCASystem( suffix );
    fi;
    
    L := HomalgCreateStringForExternalCASystem( L );
    
    l := Length( L );
    
    if l > 0 and L{[l..l]} = "\n" then
        enter := "";
        eoc := "";
    else
        enter := "\n";
        if l > 0 and
           ( ( Length( stream.eoc_verbose ) > 0
               and l-Length( stream.eoc_verbose )+1 > 0
               and L{[l-Length( stream.eoc_verbose )+1..l]} = stream.eoc_verbose )
             or
             ( l-Length( stream.eoc_quiet )+1 > 0
               and L{[l-Length( stream.eoc_quiet )+1..l]} = stream.eoc_quiet ) ) then
            eoc := "";
        elif not IsBound( option ) then
            eoc := stream.eoc_quiet; ## as little back-traffic over the stream as possible
        else
            if need_command then
                eoc := stream.eoc_quiet; ## as little back-traffic over the stream as possible
            else
                eoc := stream.eoc_verbose;
            fi;
        fi;
    fi;
    
    if not IsBound( option ) then
        
        if IsBound( prefix ) then
            if IsBound( suffix ) then
                L := Concatenation( prefix, homalg_variable, suffix, " ", stream.define, " ", L, eoc, enter );
            else
                L := Concatenation( prefix, homalg_variable, " ", stream.define, " ", L, eoc, enter );
            fi;
        else
            L := Concatenation( homalg_variable, " ", stream.define, " ", L, eoc, enter );
        fi;
        
    else
        
        if IsBound( prefix ) then
            L := Concatenation( prefix, " ", L, eoc, enter );
        else
            L := Concatenation( L, eoc, enter );
        fi;
        
        if need_command then
            stream.HomalgExternalCommandCounter := stream.HomalgExternalCommandCounter + 1;
        else
            stream.HomalgExternalOutputCounter := stream.HomalgExternalOutputCounter + 1;
        fi;
    fi;
    
    if IsBound( HOMALG_RINGS.HomalgSendBlocking ) then
        Add( HOMALG_RINGS.HomalgSendBlocking, L );
    fi;
    
    Info( InfoRingsForHomalg, 7, stream.prompt, L{[ 1 .. Length( L ) -1 ]} );
    
    stream.HomalgExternalCallCounter := stream.HomalgExternalCallCounter + 1;
    
    SendBlockingToCAS( stream, L );
    
    max := Maximum( stream.HomalgBackStreamMaximumLength, Length( stream.lines ) );
    
    if max > stream.HomalgBackStreamMaximumLength then
        stream.HomalgBackStreamMaximumLength := max;
        if HOMALG_RINGS.SaveHomalgMaximumBackStream = true then
            stream.HomalgMaximumBackStream := stream.lines;
        fi;
    fi;
    
    if not IsBound( option ) then
        L := HomalgExternalObject( homalg_variable, CAS, stream );
        
        if properties <> [ ] and IsHomalgExternalObjectWithIOStream( L ) then
            for ar in properties do
                Setter( ar )( L, true );
            od;
        fi;
        
        return L;
    elif need_display then
        if stream.cas = "maple" then
            return Concatenation( stream.lines{ [ 1 .. Length( stream.lines ) - 36 ] }, "\033[0m" );
        else
            return Concatenation( stream.lines, "\033[0m\n" );
        fi;
    elif stream.cas = "maple" then
        ## unless meant for display, normalize the white spaces caused by Maple
        L := NormalizedWhitespace( stream.lines );
    else
        L := stream.lines;
    fi;
    
    if need_output then
        Info( InfoRingsForHomalg, 5, stream.output_prompt, "\"", L, "\"" );
    fi;
    
    return L;
    
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

####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( ViewObj,
        "for homalg external objects with an IO stream",
        [ IsHomalgExternalObjectRep and IsHomalgExternalObjectWithIOStream ],
        
  function( o )
    
    Print( "<A homalg external object residing in the CAS " );
    Print( HomalgExternalCASystem( o ), " running with pid ", HomalgExternalCASystemPID( o ), ">" ); 
    
end );

InstallMethod( ViewObj,
        "for homalg external objects with an IO stream",
        [ IsHomalgExternalRingRep and IsHomalgExternalObjectWithIOStream ],
        
  function( o )
    
    Print( "<A homalg external ring residing in the CAS " );
    Print( HomalgExternalCASystem( o ), " running with pid ", HomalgExternalCASystemPID( o ), ">" ); 
    
end );

