#############################################################################
##
##  IO.gi                     HomalgToCAS package            Mohamed Barakat
##
##  Copyright 2007-2009 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff to launch and terminate external CASystems.
##
#############################################################################

####################################
#
# install global functions:
#
####################################

##
InstallGlobalFunction( TerminateCAS,
  function( arg )
    local nargs, container, weak_pointers, l, pids, i, R, streams, s;
    
    nargs := Length( arg );
    
    if nargs = 0 and IsBound( HOMALG_MATRICES.ContainerForWeakPointersOnHomalgExternalRings ) then
        
        container := HOMALG_MATRICES.ContainerForWeakPointersOnHomalgExternalRings;
        
        weak_pointers := container!.weak_pointers;
        
        l := container!.counter;
        
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
        
        for i in [ 1 .. l ] do
            if not streams[i].pid in pids then
                TerminateCAS( streams[i] );
                Unbind( streams[i] );
            fi;
        od;
        
        ## don't replace the following by DuplicateFreeList since
        ## it runs into a "no method found"-error when comparing subobjects:
        pids := [ ];
        l := [ ];
        
        for s in streams do
            if not s.pid in pids then
                Add( l, s );
                Add( pids, s.pid );
            fi;
        od;
        
        container!.streams := l;
        
    elif nargs > 0 then
        
        if IsRecord( arg[1] ) and IsBound( arg[1].lines ) then
            
            s := arg[1];
            
            if IsBound( s.TerminateCAS ) and IsFunction( s.TerminateCAS ) then
                s.TerminateCAS( s );
                
                if IsBound( arg[1].pid ) then
                    Print( "terminated the external CAS ", s.name, " with pid ", s.pid, "\n" );
                else
                    Print( "terminated the external CAS ", s.name, "\n" );
                fi;
                
            else
                Print( "the stream does not contain a TerminateCAS process\n" );
            fi;
            
        else
            
            TerminateCAS( homalgStream( arg[1] ) );
            
        fi;
        
    fi;
    
end );

##
InstallGlobalFunction( LaunchCAS,
  function( arg )
    local nargs, HOMALG_IO_CAS, executables, e, s;
    
    nargs := Length( arg );
    
    HOMALG_IO_CAS := arg[1];
    
    if IsString( HOMALG_IO_CAS ) then
        HOMALG_IO_CAS := ValueGlobal( HOMALG_IO_CAS );
    else
        Error( "for security reasons LaunchCAS only accepts a string (as a first argument) which points to a HOMALG_IO_CAS record\n" );
    fi;
    
    if IsBound( HOMALG_IO_CAS.LaunchCAS ) then
        
        s := CallFuncList( HOMALG_IO_CAS.LaunchCAS, arg );
        
        if s = fail then
            Error( "the alternative launcher returned fail\n" );
        fi;
        
    else
        
        if LoadPackage( "IO_ForHomalg" ) <> true then
            Error( "the package IO_ForHomalg failed to load\n" );
        fi;
        
        s := CallFuncList( LaunchCAS_IO_ForHomalg, Concatenation( [ HOMALG_IO_CAS ], arg{[ 2 .. nargs ]} ) );
        
    fi;
    
    for e in NamesOfComponents( HOMALG_IO_CAS ) do
        if not IsBound( s.( e ) ) then
            s.( e ) := HOMALG_IO_CAS.( e );
        fi;
    od;
    
    if not IsBound( s.variable_name ) then
        s.variable_name := HOMALG_IO.variable_name;
    fi;
    
    if IsBound( HOMALG_IO.color_display ) and HOMALG_IO.color_display = true
       and IsBound( s.display_color ) then
        s.color_display := s.display_color;
    fi;
    
    if IsBound( HOMALG_IO.DeletePeriod ) and
       ( IsPosInt( HOMALG_IO.DeletePeriod ) or IsBool( HOMALG_IO.DeletePeriod ) ) then
        s.DeletePeriod := HOMALG_IO.DeletePeriod;
    fi;
    
    s.StatisticsObject :=
      NewStatisticsObject(
              rec(
                  LookupTable := "HOMALG_IO.Pictograms",
                  summary := rec(
                       HomalgExternalCallCounter := 0,
                       HomalgExternalVariableCounter := 0,
                       HomalgExternalCommandCounter := 0,
                       HomalgExternalOutputCounter := 0,
                       HomalgBackStreamMaximumLength := 0,
                       HomalgExternalWarningsCounter := 0
                       )
                  ),
              TheTypeStatisticsObjectForStreams
              );
    
    s.homalgExternalObjectsPointingToVariables :=
      ContainerForWeakPointers( TheTypeContainerForWeakPointersOnHomalgExternalObjects );
    
    s.SendBlockingToCAS( s, "\n" );
    
    if ( not ( IsBound( HOMALG_IO.show_banners ) and HOMALG_IO.show_banners = false )
         and not ( IsBound( s.show_banner ) and s.show_banner = false ) ) then
        Print( "================================================================\n" );
        if IsBound( s.color_display ) then
            Print( s.color_display );
        fi;
        if IsBound( s.banner ) and IsString( s.banner ) then
            Print( s.banner );
        elif IsBound( s.banner ) and IsFunction( s.banner ) then
            s.banner( s );
        else
            Print( s.lines );
        fi;
        Print( "\033[0m\n================================================================\n" );
    fi;
    
    return s;
    
end );

##
InstallGlobalFunction( InitializeMacros,
  function( macros, stream )
    local component;
    
    if not IsRecord( macros ) then
        Error( "the second argument must be a record\n" );
    fi;
    
    for component in NamesOfComponents( macros ) do
        if component[1] <> '_' then
            homalgSendBlocking( macros.(component), "need_command", stream, HOMALG_IO.Pictograms.define );
        fi;
    od;
    
end );

##
InstallGlobalFunction( UpdateMacrosOfCAS,
  function( macros, CASmacros )
    local component;
    
    if IsBound( macros._Identifier ) then
        if IsBound( CASmacros._included_packages ) then
            if IsBound( CASmacros._included_packages.(macros._Identifier) ) and
               CASmacros._included_packages.(macros._Identifier) = true then
                
                ## get out
                return;
                
            fi;
        else
            CASmacros._included_packages := rec( );
        fi;
    fi;
    
    CASmacros._included_packages.(macros._Identifier) := true;
    
    for component in NamesOfComponents( macros ) do
        if component[1] <> '_' then
            CASmacros.(component) := macros.(component);
        fi;
    od;
    
end );

##
InstallGlobalFunction( UpdateMacrosOfLaunchedCAS,
  function( macros, stream )
    local send;
    
    if IsBound( macros._Identifier ) then
        if IsBound( stream.activated_packages ) then
            if IsBound( stream.activated_packages.(macros._Identifier) ) and
               stream.activated_packages.(macros._Identifier) = true then
                
                ## get out
                return;
                
            fi;
        else
            stream.activated_packages := rec( );
        fi;
    fi;
    
    stream.activated_packages.(macros._Identifier) := true;
    
    ## save the original stream communicator
    send := stream!.SendBlockingToCAS;
    
    ## this is a way to avoid branching in time critical homalgSendBlocking
    stream!.SendBlockingToCAS :=
      function( arg )
        
        ## set back the original stream communicator
        stream!.SendBlockingToCAS := send;	## GAP is wonderful
        
        InitializeMacros( macros, stream );
        
        CallFuncList( send, arg );
        
    end;
    
end );

##
InstallGlobalFunction( UpdateMacrosOfLaunchedCASs,
  function( macros )
    local name, streams, stream;
    
    if IsBound( macros._CAS_name ) then
        
        name := macros._CAS_name;
        
        streams := HOMALG_MATRICES.ContainerForWeakPointersOnHomalgExternalRings!.streams;
    
        for stream in streams do
            if IsBound( stream.name ) and stream.name = name then
                UpdateMacrosOfLaunchedCAS( macros, stream );
            fi;
        od;
    fi;
    
end );
