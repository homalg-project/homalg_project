#############################################################################
##
##  homalgSendBlocking.gi     HomalgToCAS package            Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff to manage the communication.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

##
InstallGlobalFunction( homalgFlush,
  function( arg )
    local nargs, verbose, stream, container, weak_pointers, l, pids, R, p, i,
          var, active_ring_creation_number, ring_creation_numbers, deleted,
          streams;
    
    ## the internal garbage collector:
    GASMAN( "collect" );
    
    nargs := Length( arg );
    
    verbose := true;
    
    if nargs > 0 and IsStringRep( arg[nargs] ) then
        nargs := nargs - 1;
        verbose := false;
    fi;
    
    ## nargs is the number of arguments _without_ an optional last "quiet" string; see above
    if nargs = 0 and IsBound( HOMALG_MATRICES.ContainerForWeakPointersOnHomalgExternalRings ) then
        
        container := HOMALG_MATRICES.ContainerForWeakPointersOnHomalgExternalRings;
        
        weak_pointers := container!.weak_pointers;
        
        l := container!.counter;
        
        pids := [ ];
        
        for i in [ 1 .. l ] do
            R := ElmWPObj( weak_pointers, i );
            if R <> fail then
                p := homalgExternalCASystemPID( R );
                ## do not rely on the (not p in pids) criterion
                ## for streams with an active ring
                if not p in pids or IsBound( homalgStream( R )!.active_ring ) then
                    Add( pids, p );
                    ## it is now important to pass the ring R and not merely its stream
                    ## to homalgFlush as R might not the currently active ring;
                    ## this is important for computer algebra systems like Singular,
                    ## which have the "feature" that a variable is stored in the ring
                    ## which was active when the variable was assigned...
                    if verbose then
                        homalgFlush( R );
                    else
                        homalgFlush( R, "quiet" );
                    fi;
                fi;
            fi;
        od;
        
        deleted := Filtered( [ 1 .. l ], i -> not IsBoundElmWPObj( weak_pointers, i ) );
        
        container!.deleted := deleted;
        
        if IsBound( HOMALG_IO.InformAboutCASystemsWithoutActiveRings )
           and HOMALG_IO.InformAboutCASystemsWithoutActiveRings = true then
            
            pids := [ ];
            
            for i in [ 1 .. l ] do
                R := ElmWPObj( weak_pointers, i );
                if R <> fail then
                    Add( pids, homalgExternalCASystemPID( R ) );
                fi;
            od;
            
            pids := DuplicateFreeList( pids );
            
            streams := container!.streams;
            
            l := Length( streams );
            
            deleted := [ ];
            
            for i in [ 1 .. l ] do
                if not streams[i].pid in pids then
                    Add( deleted, streams[i].pid );
                fi;
            od;
            
            if deleted <> [ ] and verbose then
                Print( "the external CASs with pids ", deleted, " have no active rings: they can be terminated by launching TerminateCAS()\n" );
            fi;
            
        fi;
        
    elif nargs > 0 then
        
        if IsHomalgExternalRingRep( arg[1] ) then
            R := arg[1];
            stream := homalgStream( R );
        elif IsRecord( arg[1] ) and IsBound( arg[1].lines ) and IsBound( arg[1].pid ) then
            stream := arg[1];
        else
            Error( "the first argument is neither an external ring nor a stream\n" );
        fi;
        
        container := stream.homalgExternalObjectsPointingToVariables;
        
        weak_pointers := container!.weak_pointers;
        
        l := container!.counter;
        
        ## exclude already deleted external objects:
        var := Difference( [ 1 .. l ], container!.deleted );
        
        if IsBound( stream.active_ring ) then
            
            if not IsBound( R ) then
                R := stream.active_ring;
            fi;
            
            ## R is either already the active ring
            ## or the one we will make active below
            active_ring_creation_number := R!.creation_number;
            
            ring_creation_numbers := container!.ring_creation_numbers;
            
            ## this is important for computer algebra systems like Singular,
            ## which have the "feature" that a variable is stored in the ring
            ## which was active when the variable was assigned...
            ## mapping all existing variables to the active ring
            ## -- besides being a bad idea anyway -- would result in various disasters:
            ## non-zero entries of a matrix over a ring S (e.g. polynomial ring)
            ## often become zero when the matrix is mapped to another ring (e.g. exterior ring),
            ## and of course remain zero when the matrix is mapped back to the original ring S.
            
            var := Filtered( var, i -> not IsBoundElmWPObj( weak_pointers, i ) and IsBound( ring_creation_numbers[i] ) and ring_creation_numbers[i] = active_ring_creation_number );
            
            ## set the argument to be the active ring
            if var <> [ ] and IsHomalgExternalRingRep( R ) and
               not IsIdenticalObj( R, stream.active_ring ) then
                homalgSendBlocking( "\"we've just reset the ring for garbage collection\"", "need_command", R, HOMALG_IO.Pictograms.initialize );
            fi;
            
            ## free the entries corresponding to external objects about to be deleted
            Perform( var, function( i ) Unbind( ring_creation_numbers[i] ); end );
            
        else
            
            var := Filtered( var, i -> not IsBoundElmWPObj( weak_pointers, i ) );
            
        fi;
        
        l := Length( var );
        
        deleted := Union2( container!.deleted, var );
        
        if IsBound( stream.multiple_delete ) and ( l > 1 or ( not IsBound( stream.delete ) and l > 0 ) ) then
            
            stream.multiple_delete( List( var, v -> Concatenation( stream.variable_name, String( v ) ) ), stream );
            
            container!.deleted := deleted;
            
        elif IsBound( stream.delete ) and l > 0 then
            
            Perform( var, function( p ) stream.delete( Concatenation( stream.variable_name, String( p ) ), stream ); end );
            
            container!.deleted := deleted;
            
        fi;
        
        if IsBound( stream.garbage_collector ) then
            
            ## the external garbage collector:
            stream.garbage_collector( stream );
            
            if verbose then
                Print( "completed garbage collection in the external CAS ", stream.name, " with pid ", stream.pid, "\n" );
            fi;
            
        fi;
        
    fi;
    
end );

##
InstallGlobalFunction( TerminateAllCAS,
  function( )
    local stream;
    
    for stream in HOMALG_MATRICES.ContainerForWeakPointersOnHomalgExternalRings!.streams do
        
        stream!.TerminateCAS( stream );
        
    od;
    
end );

##
InstallGlobalFunction( _SetElmWPObj_ForHomalg,	## is not based on homalgFlush for performance reasons
  function( stream, ext_obj )
    local container, weak_pointers, l, DeletePeriod, var,
          active_ring_creation_number, ring_creation_numbers, deleted;
    
    container := stream.homalgExternalObjectsPointingToVariables;
    
    weak_pointers := container!.weak_pointers;
    
    l := container!.counter;
    
    if IsBound( stream.DeletePeriod ) then
        if IsBool( stream.DeletePeriod ) then
            DeletePeriod := stream.DeletePeriod;
        else
            DeletePeriod := l mod stream.DeletePeriod = 0;
        fi;
    else
        DeletePeriod := true;
    fi;
    
    if DeletePeriod then
        ## exclude already deleted external objects:
        var := Difference( [ 1 .. l ], container!.deleted );
    fi;
    
    if IsBound( stream.active_ring ) then
        
        active_ring_creation_number := stream.active_ring!.creation_number;
        
        ring_creation_numbers := container!.ring_creation_numbers;
        
        ## set the active ring for the new external object
        ring_creation_numbers[l + 1] := active_ring_creation_number;
        
        if DeletePeriod then
            
            ## this is important for computer algebra systems like Singular,
            ## which have the "feature" that a variable is stored in the ring
            ## which was active when the variable was assigned...
            ## mapping all existing variables to the active ring
            ## -- besides being a bad idea anyway -- would result in various disasters:
            ## non-zero entries of a matrix over a ring S (e.g. polynomial ring)
            ## often become zero when the matrix is mapped to another ring (e.g. exterior ring),
            ## and of course remain zero when the matrix is mapped back to the original ring S.
            
            var := Filtered( var, i -> not IsBoundElmWPObj( weak_pointers, i ) and IsBound( ring_creation_numbers[i] ) and ring_creation_numbers[i] = active_ring_creation_number );
            
            ## free the entries corresponding to external objects about to be deleted
            Perform( var, function( i ) Unbind( ring_creation_numbers[i] ); end );
            
        fi;
        
    else
        
        if DeletePeriod then
            
            var := Filtered( var, i -> not IsBoundElmWPObj( weak_pointers, i ) );
            
        fi;
        
    fi;
    
    l := l + 1;
    
    container!.counter := l;
    
    ## sanity check
    if not Concatenation( stream.variable_name, String( l ) ) = homalgPointer( ext_obj ) then
        Error( "\033[01m\033[5;31;47mexpecting an external object with pointer = ",
               Concatenation( stream.variable_name, String( l ) ),
               " but recieved one with pointer = ", homalgPointer( ext_obj ), "\033[0m" );
    fi;
    
    SetElmWPObj( weak_pointers, l, ext_obj );
    
    if DeletePeriod then
        
        l := Length( var );
        
        deleted := Union2( container!.deleted, var );
        
        if IsBound( stream.multiple_delete ) and ( l > 1 or ( not IsBound( stream.delete ) and l > 0 ) ) then
            
            stream.multiple_delete( List( var, v -> Concatenation( stream.variable_name, String( v ) ) ), stream );
            
            container!.deleted := deleted;
            
        elif IsBound( stream.delete ) and l > 0 then
            
            Perform( var, function( p ) stream.delete( Concatenation( stream.variable_name, String( p ) ), stream ); end );
            
            container!.deleted := deleted;
            
        fi;
        
        ## never ever call the internal or the external garbage collector in this procedure
        
    fi;
    
end );

##
InstallGlobalFunction( homalgCreateStringForExternalCASystem,
  function( arg )
    local nargs, L, l, stream, break_lists, assignments_pending, used_pointers, s;
    
    nargs := Length( arg );
    
    ## Do not waste time with syntax checks;
    ## this is not a procedure for end users.
    #if nargs = 0 or not IsList( arg[1] ) then
    #    Error( "the first argument must be a list\n" );
    #fi;
    
    L := arg[1];
    
    l := Length( L );
    
    break_lists := false;
    
    if nargs > 1 and IsRecord( arg[2] ) then
        stream := arg[2];
        if IsBound( stream.break_lists ) and stream.break_lists = true then
            break_lists := true;
        fi;
    fi;
    
    if nargs > 2 and arg[3] = "break_lists" then
        break_lists := true;
    fi;
    
    assignments_pending := [ ];
    used_pointers := [ ];
    
    s := List( [ 1 .. l ], function( a )
                             local CAS, stream, statistics_summary, counter, t;
                             if IsStringRep( L[a] ) then
                                 return L[a];
                             else
                                 if IsHomalgExternalMatrixRep( L[a] ) then
                                     if not ( HasIsVoidMatrix( L[a] ) and IsVoidMatrix( L[a] ) )
                                        or HasEval( L[a] ) then
                                         t := homalgPointer( L[a] ); ## now we enforce evaluation!!!
                                         Add( used_pointers, t );
                                     else
                                         CAS := homalgExternalCASystem( L[a] );
                                         stream := homalgStream( L[a] );
                                         statistics_summary := stream.StatisticsObject!.summary;
                                         IncreaseExistingCounterInObject( statistics_summary, "HomalgExternalVariableCounter" );
                                         ## never interchange the previous line with the next one
                                         
                                         counter := statistics_summary!.HomalgExternalVariableCounter;
                                         t := Concatenation( stream.variable_name, String( counter ) );
                                         MakeImmutable( t );
                                         
                                         ## now that we have just increased the variable counter and
                                         ## created the new variable we need to *immediately* create
                                         ## the enveloping external object and insert it in
                                         ## the weak pointer list using _SetElmWPObj_ForHomalg,
                                         ## before we start executing commands in the external CAS,
                                         ## that might cause an error; the weak pointer list
                                         ## which expects the l-th external object (i.e., the one
                                         ## with pointer = homalg_variable_l) at the l-th position
                                         ## would otherwise run out of sync)
                                         
                                         SetEval( L[a], homalgExternalObject( t, CAS, stream ) );
                                         ## CAUTION: homalgPointer( L[a] ) now exists but still points to nothing!!!
                                         
                                         ## the following line relies on the feature, that homalgExternalObjects
                                         ## are now assigned homalg_variables strictly sequentially!!!
                                         _SetElmWPObj_ForHomalg( stream, Eval( L[a] ) );
                                         
                                         ## do not Add counter directly to container!.assignments_pending
                                         ## as possibly remaining Eval's will invoke homalgSendBlocking
                                         ## which will move container!.assignments_pending to
                                         ## container!.assignments_failed; rather collect them in the variable
                                         ## assignments_pending and pass them back to homalgSendBlocking
                                         Add( assignments_pending, counter );
                                         ResetFilterObj( L[a], IsVoidMatrix );
                                     fi;
                                 elif IsHomalgExternalRingElementRep( L[a] ) or
                                    IsHomalgExternalRingRep( L[a] ) or
                                    IshomalgExternalObjectRep( L[a] ) then
                                     t := homalgPointer( L[a] );
                                 elif break_lists and IsList( L[a] ) and not IsStringRep( L[a] ) then
                                     if ForAll( L[a], IsStringRep ) then
                                         t := JoinStringsWithSeparator( L[a] );
                                     elif ForAll( L[a], e -> IsHomalgExternalMatrixRep( e ) or IsHomalgExternalRingElementRep( e ) ) then
                                         t := JoinStringsWithSeparator( List( L[a], homalgPointer ) );
                                     else
                                         t := String( List( L[a], i -> i ) ); ## get rid of the range representation of lists
                                         t := t{ [ 2 .. Length( t ) - 1 ] };
                                     fi;
                                 else
                                     t := String( L[a] );
                                 fi;
                                 if a < l and not IsStringRep( L[a+1] ) then
                                     t := Concatenation( t, "," );
                                 fi;
                                 return t;
                             fi;
                           end );
    
    return [ Flat( s ), assignments_pending, used_pointers ];
    
end );

##
InstallGlobalFunction( homalgSendBlocking,
  function( arg )
    local L, nargs, properties, need_command, need_display, need_output, ar,
          pictogram, option, break_lists, R, ext_obj, stream, type, prefix,
          suffix, e, RP, CAS, PID, container, counter, homalg_variable,
          assignments_pending, used_pointers, l, eoc, enter,
          statistics, statistics_summary, fs, io_info_level, picto, max,
          display_color, esc;
    
    if IsBound( HOMALG_IO.homalgSendBlockingInput ) then
        Add( HOMALG_IO.homalgSendBlockingInput, arg );
    fi;
    
    Info( InfoHomalgToCAS, 10, "homalgSendBlocking <-- ", arg );
    
    if not IsList( arg[1] ) then
        Error( "the first argument must be a list\n" );
    elif IsStringRep( arg[1] ) then
        L := [ arg[1] ];
    else
        L := arg[1];
    fi;
    
    nargs := Length( arg );
    
    properties := [ ];
    
    need_command := false;
    need_display := false;
    need_output := false;
    
    for ar in arg{[ 2 .. nargs ]} do ## the order of the following might be important for the performance!!!
        if IsList( ar ) and ar <> [ ] and ForAll( ar, IsFilter ) then	## this must come before prefix and suffix
            Append( properties, ar );
        elif not IsBound( prefix ) and IsList( ar ) and not IsStringRep( ar ) then
            prefix := ar;
        elif not IsBound( suffix ) and IsList( ar ) and not IsStringRep( ar ) then
            suffix := ar;
        elif not IsBound( R ) and IsHomalgExternalRingRep( ar ) then
            R := ar;
            ext_obj := R;
            stream := homalgStream( ext_obj );
        elif not IsBound( ext_obj ) and IshomalgExternalObjectRep( ar ) then
            ext_obj := ar;
            stream := homalgStream( ext_obj );
        elif not IsBound( R ) and IsHomalgExternalMatrixRep( ar ) then
            R := HomalgRing( ar );
            ext_obj := R;
            stream := homalgStream( ext_obj );
        elif not IsBound( ext_obj ) and IsHomalgExternalRingElementRep( ar ) then
            R := HomalgRing( ar );
            ext_obj := R;
            stream := homalgStream( ext_obj );
        elif IsRecord( ar ) and IsBound( ar.lines ) and IsBound( ar.pid ) then
            if not IsBound( stream ) or not IsBound( ext_obj ) then
                stream := ar;
                if IsBound( stream.name ) then
                    ext_obj := homalgExternalObject( "", stream.name, stream );
                fi;
            fi;
        elif not IsBound( pictogram ) and IsStringRep( ar ) and Length( ar ) <= 5 then
            pictogram := ar;
        elif not IsBound( option ) and IsStringRep( ar ) and Length( ar ) > 5 and ar <> "break_lists" then ## the first occurrence of an option decides
            if PositionSublist( LowercaseString( ar ), "command" ) <> fail then
                need_command := true;
            elif PositionSublist( LowercaseString( ar ), "display" ) <> fail then
                need_display := true;
            elif PositionSublist( LowercaseString( ar ), "output" ) <> fail then
                need_output := true;
            else
                Error( "option must be one of { \"need_command\", \"need_display\", \"need_output\" }, but received: ", ar, "\n" );
            fi;
            option := ar;
        elif not IsBound( type ) and IsType( ar ) then
            type := ar;
        elif IsFilter( ar ) then
            Add( properties, ar );
        elif not IsBound( break_lists ) and ar = "break_lists" then
            break_lists := ar;
        else
            Error( "this argument should be in { IsList, IsStringRep, IsFilter, IsRecord, IshomalgExternalObjectRep, IsHomalgExternalRingElementRep, IsHomalgExternalRingRep, IsHomalgExternalMatrixRep } but recieved: ", ar,"\n" );
        fi;
    od;
    
    if not IsBound( ext_obj ) then ## R is also not yet defined
        
        e := Filtered( L, a ->
                     IsHomalgExternalMatrixRep( a ) or
                     IsHomalgExternalRingElementRep( a ) or
                     IsHomalgExternalRingRep( a ) or
                     IshomalgExternalObjectRep( a )
                     );
        
        if e <> [ ] then
            ext_obj := e[1];
            for ar in e do
                if IsHomalgExternalMatrixRep( ar ) then
                    R := HomalgRing( ar );
                    break;
                elif IsHomalgExternalRingRep( ar ) then
                    R := ar;
                    break;
                elif IsHomalgExternalRingElementRep( ar ) then
                    R := HomalgRing( ar );
                    break;
                fi;
            od;
        else
            Error( "either the list provided by the first argument must contain at least one external matrix or an external ring or one of the remaining arguments must be an external ring or an external object\n" );
        fi;
        
        stream := homalgStream( ext_obj );
        
    fi;
    
    if IsBound( R ) then
        
        if IsBound( stream.active_ring )
           and not IsIdenticalObj( R, stream.active_ring )
           and IsBound( stream.setring )
           and IsFunction( stream.setring ) then
            stream.setring( R );
            if IsBound( stream.setinvol )
               and IsFunction( stream.setinvol ) then
                stream.setinvol( R );
            fi;
        fi;
        
        RP := homalgTable( R );
        
        if IsBound(RP!.homalgSendBlocking) then
            return RP!.homalgSendBlocking( arg );
        fi;
    fi;
    
    CAS := homalgExternalCASystem( ext_obj );
    PID := homalgExternalCASystemPID( ext_obj );
    
    if not IsBound( break_lists ) then
        break_lists := "do_not_break_lists";
    fi;
    
    container := stream.homalgExternalObjectsPointingToVariables;
    
    ## if a homalgSendBlocking instance finds assignments still pending then
    ## for sure something went wrong with the previous homalgSendBlocking instance
    if container!.assignments_pending <> [ ] then
        ## for some odd reason assigning to a variable, e.g.,
        ## assignments_pending := container!.assignments_pending
        ## and reassigning
        ## container!.assignments_pending := assignments_pending
        ## at the end does not work properly
        Append( container!.deleted, container!.assignments_pending );
        Append( container!.assignments_failed, container!.assignments_pending );
        container!.assignments_pending := [ ];
    fi;
    
    if IsBound( prefix ) and prefix <> [ ] then
        prefix := Concatenation( homalgCreateStringForExternalCASystem( prefix, stream, break_lists )[1], " " );
    fi;
    
    if IsBound( suffix ) then
        suffix := homalgCreateStringForExternalCASystem( suffix, stream, break_lists )[1];
    fi;
    
    ## this line may trigger an evaluation which will trigger homalgSendblocking again
    L := homalgCreateStringForExternalCASystem( L, stream, break_lists );
    ## never separate the previous line from the following one!
    
    assignments_pending := L[2];
    Append( container!.assignments_pending, L[2] );
    ## for some odd reason assigning to a variable, e.g.,
    ## assignments_pending := container!.assignments_pending
    ## and reassigning
    ## container!.assignments_pending := assignments_pending
    ## at the end does not work properly
    
    used_pointers := [ ];
    Append( used_pointers, L[3] );
    
    L := L[1];
    
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
    
    statistics := stream.StatisticsObject;
    statistics_summary := statistics!.summary;
    
    if not IsBound( option ) then
        
        IncreaseExistingCounterInObject( statistics_summary, "HomalgExternalVariableCounter" );
        ## never interchange the previous line with the next one
        
        counter := statistics_summary.HomalgExternalVariableCounter;
        
        homalg_variable := Concatenation( stream.variable_name, String( counter ) );
        MakeImmutable( homalg_variable );
        
        ## now that we have just increased the variable counter and
        ## created the new variable we need to *immediately* create
        ## the enveloping external object and insert it in
        ## the weak pointer list using _SetElmWPObj_ForHomalg,
        ## before we start executing commands in the external CAS,
        ## that might cause an error; the weak pointer list
        ## which expects the l-th external object (i.e., the one
        ## with pointer = homalg_variable_l) at the l-th position
        ## would otherwise run out of sync)
        if not IsBound( type ) then
            ext_obj := homalgExternalObject( homalg_variable, CAS, stream );
        else
            ext_obj := homalgExternalObject( homalg_variable, CAS, stream, type );
        fi;
        
        ## the following line relies on the feature, that homalgExternalObjects
        ## are now assigned homalg_variables strictly sequentially!!!
        _SetElmWPObj_ForHomalg( stream, ext_obj );
        ## never separate the previous line from the following one!
        Add( assignments_pending, counter );
        Add( container!.assignments_pending, counter );
        
        if properties <> [ ] and IshomalgExternalObjectRep( ext_obj ) then
            for ar in properties do
                Setter( ar )( ext_obj, true );
            od;
        fi;
        
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
            IncreaseExistingCounterInObject( statistics_summary, "HomalgExternalCommandCounter" );
        else
            IncreaseExistingCounterInObject( statistics_summary, "HomalgExternalOutputCounter" );
        fi;
    fi;
    
    ConvertToStringRep( L );
    
    if ( IsBound( HOMALG_IO.save_CAS_commands_to_file ) and HOMALG_IO.save_CAS_commands_to_file = true )
       or IsBound( stream.CAS_commands_file ) then
        if not IsBound( stream.CAS_commands_file ) then
            stream.CAS_commands_file := Concatenation( "commands_file_of_", CAS, "_with_PID_", String( PID ) );
            fs := IO_File( stream.CAS_commands_file, "w" );
            if fs = fail then
                Error( "unable to open the file ", stream.CAS_commands_file, " for writing\n" );
            fi;
            if IO_Close( fs ) = fail then
                Error( "unable to close the file ", stream.CAS_commands_file, "\n" );
            fi;
        fi;
        
        fs := IO_File( stream.CAS_commands_file, "a" );
        
        if IO_WriteFlush( fs, L ) = fail then
            Error( "unable to write in the file ", stream.CAS_commands_file, "\n" );
        fi;
        
        if IO_Close( fs ) = fail then
            Error( "unable to close the file ", stream.CAS_commands_file, "\n" );
        fi;
    fi;
    
    ##  <#GAPDoc Label="homalgSendBlocking:view_communication">
    ##    <Description>
    ##      This is the part of the global function <C>homalgSendBlocking</C>
    ##      that controls the visibility of the communication.
    ##      <Listing Type="Code"><![CDATA[
    io_info_level := InfoLevel( InfoHomalgToCAS );
    
    if not IsBound( pictogram ) then
        pictogram := HOMALG_IO.Pictograms.unknown;
        picto := pictogram;
    elif io_info_level >= 3 then
        picto := pictogram;
        ## add colors to the pictograms
        if pictogram = HOMALG_IO.Pictograms.ReducedEchelonForm and
           IsBound( HOMALG_MATRICES.color_BOE ) then
            pictogram := Concatenation( HOMALG_MATRICES.color_BOE, pictogram, "\033[0m" );
        elif pictogram = HOMALG_IO.Pictograms.BasisOfModule and
          IsBound( HOMALG_MATRICES.color_BOB ) then
            pictogram := Concatenation( HOMALG_MATRICES.color_BOB, pictogram, "\033[0m" );
        elif pictogram = HOMALG_IO.Pictograms.DecideZero and
          IsBound( HOMALG_MATRICES.color_BOD ) then
            pictogram := Concatenation( HOMALG_MATRICES.color_BOD, pictogram, "\033[0m" );
        elif pictogram = HOMALG_IO.Pictograms.SyzygiesGenerators and
          IsBound( HOMALG_MATRICES.color_BOH ) then
            pictogram := Concatenation( HOMALG_MATRICES.color_BOH, pictogram, "\033[0m" );
        elif pictogram = HOMALG_IO.Pictograms.BasisCoeff and
          IsBound( HOMALG_MATRICES.color_BOC ) then
            pictogram := Concatenation( HOMALG_MATRICES.color_BOC, pictogram, "\033[0m" );
        elif pictogram = HOMALG_IO.Pictograms.DecideZeroEffectively and
          IsBound( HOMALG_MATRICES.color_BOP ) then
            pictogram := Concatenation( HOMALG_MATRICES.color_BOP, pictogram, "\033[0m" );
        elif need_output or need_display then
            pictogram := Concatenation( HOMALG_IO.Pictograms.color_need_output,
                                 pictogram, "\033[0m" );
        else
            pictogram := Concatenation( HOMALG_IO.Pictograms.color_need_command,
                                 pictogram, "\033[0m" );
        fi;
    else
        picto := pictogram;
    fi;
    
    if io_info_level >= 3 then
        if ( io_info_level >= 7 and not need_display ) or io_info_level >= 8 then
            ## print the pictogram, the prompt of the external system,
            ## and the sent command
            Info( InfoHomalgToCAS, 7, pictogram, " ", stream.prompt,
                  L{[ 1 .. Length( L ) - 1 ]} );
        elif io_info_level >= 4 then
            ## print the pictogram and the prompt of the external system
            Info( InfoHomalgToCAS, 4, pictogram, " ", stream.prompt, "..." );
        else
            ## print the pictogram only
            Info( InfoHomalgToCAS, 3, pictogram );
        fi;
    fi;
    ##  ]]></Listing>
    ##    </Description>
    ##  <#/GAPDoc>
    
    IncreaseExistingCounterInObject( statistics_summary, "HomalgExternalCallCounter" );
    IncreaseCounterInObject( statistics, picto );
    ## always keep the above two lines together
    
    if IsBound( stream!.log_processes ) and stream!.log_processes = true then
        l := Length( stream.variable_name );
        stream.description_of_last_process :=
          [ assignments_pending,
            List( used_pointers, a -> Int( a{[ l + 1 .. Length( a ) ]} ) ),
            need_output = false,
            pictogram
            ];
    fi;
    
    stream.SendBlockingToCAS( stream, L );
    
    if stream.errors <> "" then
        if IsBound( stream.only_warning ) and PositionSublist( stream.errors, stream.only_warning ) <> fail then
            stream.warnings := stream.errors;
            IncreaseExistingCounterInObject( statistics_summary, "HomalgExternalWarningsCounter" );
        else
            Error( "the external CAS ", CAS, " (running with PID ", PID, ") returned the following error:\n", "\033[01m", stream.errors ,"\033[0m\n" );
        fi;
    elif IsBound( stream.error_stdout ) and PositionSublist( stream.lines, stream.error_stdout ) <> fail then
        Error( "the external CAS ", CAS, " (running with PID ", PID, ") returned the following error:\n", "\033[01m", stream.lines ,"\033[0m\n" );
    fi;
    
    ## we can now assume that every variable got assigned
    container!.assignments_pending := [ ];
    
    max := Maximum( statistics_summary.HomalgBackStreamMaximumLength, Length( stream.lines ) );
    
    if max > statistics_summary.HomalgBackStreamMaximumLength then
        statistics_summary.HomalgBackStreamMaximumLength := max;
        if HOMALG_IO.SaveHomalgMaximumBackStream = true then
            stream.HomalgMaximumBackStream := stream.lines;
        fi;
    fi;
    
    if not IsBound( option ) then
        
        return ext_obj;
        
    elif need_display then
        
        if IsBound( stream.color_display ) then
            display_color := stream.color_display;
            esc := "\033[0m";
        else
            display_color := "";
            ## esc must be empty, otherwise GAPDoc's TestManualExamples will complain
            esc := "";
        fi;
        
        if IsBound( stream.trim_display ) and
           IsFunction( stream.trim_display ) then
            L := stream.trim_display( stream.lines );
        else
            L := stream.lines;
        fi;
        
        return Concatenation( display_color, L, esc, "\n" );
        
    elif IsBound( stream.normalized_white_space ) and
      IsFunction( stream.normalized_white_space ) then
        
        ## unless meant for display, normalize the white spaces caused by Maple
        L := stream.normalized_white_space( stream.lines );
        
    else
        
        L := stream.lines;
        
    fi;
    
    if need_output then
        if IsBound( stream.remove_enter ) and stream.remove_enter = true then
            RemoveCharacters( L, "\n" );
        fi;
        RemoveCharacters( L, "\\ " );
        Info( InfoHomalgToCAS, 5, "/------------------" );
        Info( InfoHomalgToCAS, 5, stream.output_prompt, "\"", L, "\"" );
        Info( InfoHomalgToCAS, 5, "\\==================" );
        if IsBound( stream.check_output ) and stream.check_output = true
           and '\n' in L and not ',' in L then
            Error( "\033[01m", "the output received from the external CAS ", CAS, " (running with PID ", PID, ") contains an ENTER = '\\n' but no COMMA = ',' ... this is most probably a mistake!!!", "\033[0m\n" );
        fi;
    fi;
    
    if not need_command then
        return L;
    fi;
    
end );

##
InstallGlobalFunction( homalgDisplay,
  function( arg )
    local L, ar;
    
    if IsList( arg[1] ) then
        L := arg[1];
    else
        L := [ arg[1] ];
    fi;
    
    ar := Concatenation( [ L ], arg{[ 2 .. Length( arg ) ]}, [ "need_display", HOMALG_IO.Pictograms.Display ] );
    
    Print( CallFuncList( homalgSendBlocking, ar ) );
    
end );

##
InstallGlobalFunction( StringToInt,
  function( s )
    
    if s = "" then
        Error( "received an empty string while expecting a string containing an integer\n" );
    else
        return Int( s );
    fi;
    
end );

##
InstallGlobalFunction( StringToIntList,
  function( arg )
    local l, lint;
    
    if arg[1] = "[]" then
        return [ ];
    fi;
    
    l := SplitString( arg[1], ",", "[ ]\n" );
    lint := List( l, Int );
    
    if fail in lint then
        Error( "the first argument is not a string containg a list of integers: ", arg[1], "\n");
    fi;
    
    return lint;
    
end );

##
InstallGlobalFunction( StringToDoubleIntList,
  function( s )
    local l, lint;
    
    if s = "[]" then
        return [ ];
    fi;
    
    l := SplitString( s, "", ",[ ]\n" );
    lint := List( l, Int );
    
    if fail in lint then
        Error( "the first argument is not a string containg a list of list of two integers: ", s, "\n");
    fi;
    
    l := Length( lint );
    
    if IsOddInt( l ) then
        Error( "expected an even number of integers: ", s, "\n");
    fi;
    
    return List( [ 1 .. l/2 ], a -> [ lint[2*a-1], lint[2*a] ] ) ;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( ViewObj,
        "for homalg external objects with an IO stream",
        [ IshomalgExternalObjectRep ],
        
  function( o )
    
    Print( "<A homalg external object residing in the CAS " );
    
    if IsBound( homalgStream( o ).color_display ) then
        Print( "\033[1m" );
    fi;
    
    Print( homalgExternalCASystem( o ), "\033[0m running with pid ", homalgExternalCASystemPID( o ), ">" );
    
end );

