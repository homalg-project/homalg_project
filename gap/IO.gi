#############################################################################
##
##  IO.gi                     HomalgRings package            Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff to use the legendary GAP4 I/O package of Max Neunhoeffer.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

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
                             local R, CAS, stream, t;
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
                                         R := HomalgRing( L[a] );
                                         CAS := HomalgExternalCASystem( R );
                                         stream := HomalgStream( R );
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
          R, ext_obj, e, RP, CAS, cas_version, stream, homalg_variable,
          l, eol, enter, max;
    
    if IsBound( HOMALG_RINGS.HomalgSendBlockingInput ) then
        Add( HOMALG_RINGS.HomalgSendBlockingInput, arg );
    fi;
    
    Info( InfoHomalgRings, 10, arg );
    
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
        elif not IsBound( ext_obj )
          and HasIsHomalgExternalObjectWithIOStream( ar ) and IsHomalgExternalObjectWithIOStream( ar ) then
            ext_obj := ar;
        elif IsOperation( ar ) then
            Add( properties, ar );
        else
            Error( "this argument should be in { IsString, IsHomalgExternalRingRep, IsHomalgExternalObjectWithIOStream } bur recieved: ", ar,"\n" );
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
                    ext_obj := R;
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
        
        if Length( CAS ) > 2 and LowercaseString( CAS{[1..3]} ) = "gap" then
            stream.cas := "gap"; ## normalized name on which the user should have no control
            stream.SendBlocking := SendGAPBlocking;
            stream.define := ":=";
            stream.eol_verbose := ";";
            stream.eol_quiet := ";;";
            stream.prompt := "gap> ";
            stream.output_prompt := "\033[1;37;44m<gap\033[0m ";
            if IsBound( HOMALG_RINGS.color_display ) and HOMALG_RINGS.color_display = true
               and IsBound( HOMALG_RINGS.gap_display ) then
                stream.display_color := HOMALG_RINGS.gap_display;
            fi;
        elif Length( CAS ) > 3 and LowercaseString( CAS{[1..4]} ) = "sage" then
            stream.cas := "sage"; ## normalized name on which the user should have no control
            stream.SendBlocking := SendSageBlocking;
            stream.define := "=";
            stream.eol_verbose := "";
            stream.eol_quiet := ";";
            stream.prompt := "sage: ";
            stream.output_prompt := "\033[1;34;43m<sage\033[0m ";
            if IsBound( HOMALG_RINGS.color_display ) and HOMALG_RINGS.color_display = true
               and IsBound( HOMALG_RINGS.sage_display ) then
                stream.display_color := HOMALG_RINGS.sage_display;
            fi;
        elif Length( CAS ) > 7 and LowercaseString( CAS{[1..8]} ) = "singular" then
            stream.cas := "singular"; ## normalized name on which the user should have no control
            stream.SendBlocking := SendSingularBlocking;
            stream.define := "=";
            stream.eol_verbose := ";";
            stream.eol_quiet := ";";
            stream.prompt := "singular> ";
            stream.output_prompt := "\033[1;30;43m<singular\033[0m ";
            if IsBound( HOMALG_RINGS.color_display ) and HOMALG_RINGS.color_display = true
               and IsBound( HOMALG_RINGS.singular_display ) then
                stream.display_color := HOMALG_RINGS.singular_display;
            fi;
        elif ( Length( CAS ) > 7 and LowercaseString( CAS{[1..8]} ) = "macaulay" ) or
          ( Length( CAS ) > 1 and LowercaseString( CAS{[1..2]} ) = "m2" ) then
            stream.cas := "macaulay2"; ## normalized name on which the user should have no control
            stream.SendBlocking := SendMacaulay2Blocking;
            stream.define := "=";
            stream.eol_verbose := "";
            stream.eol_quiet := ";";
            stream.prompt := "M2> ";
            stream.output_prompt := "\033[1;30;43m<M2\033[0m ";
            if IsBound( HOMALG_RINGS.color_display ) and HOMALG_RINGS.color_display = true
               and IsBound( HOMALG_RINGS.M2_display ) then
                stream.display_color := HOMALG_RINGS.M2_display;
            fi;
        elif Length( CAS ) > 4 and LowercaseString( CAS{[1..5]} ) = "maple" then
            stream.cas := "maple"; ## normalized name on which the user should have no control
            if cas_version = "10" then
                stream.SendBlocking := SendMaple10Blocking;
            elif cas_version = "9.5" then
                stream.SendBlocking := SendMaple95Blocking;
            elif cas_version = "9" then
                stream.SendBlocking := SendMaple9Blocking;
            else
                stream.SendBlocking := SendMaple10Blocking;
            fi;
            stream.define := ":=";
            stream.eol_verbose := ";";
            stream.eol_quiet := ":";
            stream.prompt := "maple> ";
            stream.output_prompt := "\033[1;34;47m<maple\033[0m ";
            if IsBound( HOMALG_RINGS.color_display ) and HOMALG_RINGS.color_display = true
               and IsBound( HOMALG_RINGS.maple_display ) then
                stream.display_color := HOMALG_RINGS.maple_display;
            fi;
        else
            Error( "the computer algebra system ", CAS, " is not yet supported as an external computing engine for homalg\n" );
        fi;
        
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
    
    L := HomalgCreateStringForExternalCASystem( L );
    
    l := Length( L );
    
    if l > 0 and L{[l..l]} = "\n" then
        enter := "";
        eol := "";
    else
        enter := "\n";
        if l > 0 and
           ( ( Length( stream.eol_verbose ) > 0 and L{[l-Length( stream.eol_verbose )+1..l]} = stream.eol_verbose )
             or L{[l-Length( stream.eol_quiet )+1..l]} = stream.eol_quiet ) then
            eol := "";
        elif not IsBound( option ) then
            eol := stream.eol_quiet; ## as little back-traffic over the stream as possible
        else
            if need_command then
                eol := stream.eol_quiet; ## as little back-traffic over the stream as possible
            else
                eol := stream.eol_verbose;
            fi;
        fi;
    fi;
    
    if not IsBound( option ) then
        L := Concatenation( homalg_variable, " ", stream.define, " ", L, eol, enter );
    else
        L := Concatenation( L, eol, enter );
        
        if need_command then
            stream.HomalgExternalCommandCounter := stream.HomalgExternalCommandCounter + 1;
        else
            stream.HomalgExternalOutputCounter := stream.HomalgExternalOutputCounter + 1;
        fi;
    fi;
    
    if IsBound( HOMALG_RINGS.HomalgSendBlocking ) then
        Add( HOMALG_RINGS.HomalgSendBlocking, L );
    fi;
    
    Info( InfoHomalgRings, 7, stream.prompt, L{[ 1 .. Length( L ) -1 ]} );
    
    stream.HomalgExternalCallCounter := stream.HomalgExternalCallCounter + 1;
    
    stream.SendBlocking( stream, L );
    
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
            return stream.lines{[ 1 .. Length( stream.lines ) - 36 ]};
        else
            return Concatenation( stream.lines, "\n" );
        fi;
    elif stream.cas = "maple" then
        ## unless meant for display, normalize the white spaces caused by Maple
        L := NormalizedWhitespace( stream.lines );
    else
        L := stream.lines;
    fi;
    
    if need_output then
        Info( InfoHomalgRings, 5, stream.output_prompt, "\"", L, "\"" );
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
    
    Print( "<A homalg object defined externally in the CAS " );
    Print( HomalgExternalCASystem( o ), " running with pid ", HomalgExternalCASystemPID( o ), ">" ); 
    
end );

