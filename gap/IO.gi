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
    local nargs, container, weak_pointers, l, pids, i, streams, s;
    
    nargs := Length( arg );
    
    if nargs = 0 and IsBound( HOMALG.ContainerForWeakPointersOnHomalgExternalRings ) then
        
        container := HOMALG.ContainerForWeakPointersOnHomalgExternalRings;
        
        weak_pointers := container!.weak_pointers;
        
        l := container!.counter;
        
        pids := [ ];
        
        for i in [ 1 .. l ] do
            if IsBoundElmWPObj( weak_pointers, i ) then
                Add( pids, homalgExternalCASystemPID( weak_pointers[i] ) );
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
    
    if IsBound( arg[1].LaunchCAS ) then
        
        s := CallFuncList( arg[1].LaunchCAS, arg );
        
        if s = fail then
            Error( "the alternative launcher returned fail\n" );
        fi;
        
    else
        
        if LoadPackage( "IO_ForHomalg" ) <> true then
            Error( "the package IO_ForHomalg failed to load\n" );
        fi;
        
        s := CallFuncList( LaunchCAS_IO_ForHomalg, arg );
        
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
    
    s.HomalgExternalCallCounter := 0;
    s.HomalgExternalVariableCounter := 0;
    s.HomalgExternalCommandCounter := 0;
    s.HomalgExternalOutputCounter := 0;
    s.HomalgBackStreamMaximumLength := 0;
    s.HomalgExternalWarningsCounter := 0;
    
    s.homalgExternalObjectsPointingToVariables :=
      ContainerForWeakPointers( TheTypeContainerForWeakPointersOnHomalgExternalObjects );
    
    s.SendBlockingToCAS( s, "\n" );
    
    if ( not ( IsBound( HOMALG_IO.show_banners ) and HOMALG_IO.show_banners = false )
         and not ( IsBound( s.show_banner ) and s.show_banner = false ) ) then
        Print( "----------------------------------------------------------------\n" );
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
        Print( "\033[0m\n----------------------------------------------------------------\n\n" );
    fi;
    
    return s;
    
end );

