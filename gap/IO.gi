#############################################################################
##
##  IO.gi                     IO_ForHomalg package           Max Neunhoeffer
##                                                           Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff to use the GAP4 I/O package.
##
#############################################################################

####################################
#
# constructor functions:
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
        
        if IsRecord( arg[1] ) and IsBound( arg[1].lines ) and IsBound( arg[1].pid ) then
            s := arg[1];
        else
            s := homalgStream( arg[1] );
        fi;
        
        IO_Close( s.stdin );
        IO_Close( s.stdout );
        IO_Close( s.stderr );
        s.stdin := fail;
        s.stdout := fail;
        s.stderr := fail;
        
        Print( "terminated the external CAS ", s.name, " with pid ", s.pid, "\n" );
        
    fi;
    
end );

InstallGlobalFunction( SendForkingToCAS,
  function ( f, st )
    local  pid, len;
    
    IO_Flush( f );
    pid := IO_fork(  );
    
    if pid = -1  then
        return fail;
    fi;
    
    if pid = 0  then
        len := IO_Write( f, st );
        IO_Flush( f );
        IO_exit( 0 );
    fi;
    
    return true;
    
end );

InstallGlobalFunction( SendToCAS,
  function( s, command )
    local cmd;
    
    if command[ Length( command ) ] <> '\n' then
        Add( command, '\n' );
    fi;
    
    if Length( command ) < 1024 then
        IO_Write( s.stdin,command );
        IO_Write( s.stdin, "\"", s.READY, "\"", s.eoc_verbose, "\n" );
        IO_Flush( s.stdin );
    else
        cmd := Concatenation( command, "\"", s.READY, "\"", s.eoc_verbose, "\n" );
        SendForkingToCAS( s.stdin, cmd );
    fi;
    
    s.lines := "";
    s.errors := "";
    s.casready := false;
    
end );

InstallGlobalFunction( CheckOutputOfCAS,
  function( s )
    local READY, READY_LENGTH, CUT_POS_BEGIN, CUT_POS_END, SEARCH_READY_TWICE,
          handle_output, original_lines, gotsomething, l, nr, pos, bytes, len,
          pos1, pos2, pos3, pos4, CAS, PID, COLOR;
    
    READY := s.READY;
    READY_LENGTH := s.READY_LENGTH;
    CUT_POS_BEGIN := s.CUT_POS_BEGIN;
    CUT_POS_END := s.CUT_POS_END;
    
    if IsBound( s.SEARCH_READY_TWICE ) and s.SEARCH_READY_TWICE = true then
        SEARCH_READY_TWICE := true;
    else
        SEARCH_READY_TWICE := false;
    fi;
    
    if IsBound( s.handle_output ) and s.handle_output = true then
        handle_output := true;
    else
        handle_output := false;
    fi;
    
    if IsBound( s.original_lines ) and s.original_lines = true then
        original_lines := true;
    else
        original_lines := false;
    fi;
    
    gotsomething := false;
    
    while true do	# will be exited with break or return
        l := [ IO_GetFD( s.stdout ), IO_GetFD( s.stderr ) ];
        nr := IO_select( l, [], [], 0, 0 );
        #Print( "select: nr=", nr, "\n" );
        
        if nr = 0 then
            if original_lines then
                s.LINES := ShallowCopy( s.lines );	## for debugging purposes
            fi;
            if handle_output then	## a Singular specific
                len := Length( s.lines );
                while len > 0 and s.lines[len] = '\n' do
                    Remove( s.lines );
                    len := len - 1;
                od;
            fi;
            
            if not ( gotsomething ) then
                return fail;
            fi;  # nothing new whatsoever
            
            return s.casready;
        fi;
        #Print( "select: l=", l, "\n" );
        
        if l[1] <> fail then	# something on stdout
            pos := Length( s.lines );
            bytes := IO_read( l[1], s.lines, pos, s.BUFSIZE );
            if bytes > 0 then
                #Print( "stdout bytes:", bytes, "\n" );
                gotsomething := true;
                pos := PositionSublist( s.lines, READY, pos - READY_LENGTH + 1 );
                        # ........NEWNEWNEWNEWNEW
                        #        ^
                        #        pos
                if pos <> fail then
                    s.casready := true;
                    if handle_output then	## a Singular specific
                        if original_lines then
                            s.lines_original := ShallowCopy( s.lines );	## for debugging purposes
                        fi;
                        s.pos := pos;
                        len := Length( s.lines );
                        if s.lines[1] = '\n' then
                            s.lines := Concatenation( s.lines{ [ 2 .. pos - 1 ] },
                                               s.lines{ [ pos + READY_LENGTH + 1 .. len ] } );
                        elif s.lines[len] = '\n' then
                            s.lines := Concatenation( s.lines{ [ 1 .. pos - 1 ] },
                                               s.lines{ [ pos + READY_LENGTH + 1 .. len - 1 ] } );
                        else
                            s.lines := Concatenation( s.lines{ [ 1 .. pos - 1 ] },
                                               s.lines{ [ pos + READY_LENGTH + 1 .. len ] } );
                        fi;
                    elif SEARCH_READY_TWICE then	## a Macaulay2 specific
                        pos2 := PositionSublist( s.lines, READY );
                        pos3 := PositionSublist( s.lines, READY, pos2 + 1 );
                        if pos3 = fail then
                            gotsomething := false;
                        else
                            ## Print("s.lines", s.lines);	## die Feuerwehr
                            pos1 := PositionSublist( s.lines, "\n\n" );
                            if pos1 = fail then
                                pos1 := 1;
                            fi;
                            pos3 := PositionSublist( s.lines, "\no", pos1 );
                            if pos3 <> fail then
                                pos4 := PositionSublist( s.lines, "=", pos3 + 1 );
                                if pos4 <> fail then
                                    s.lines := Concatenation( s.lines{ [ 1 .. pos3 ] },
                                                       s.lines{ [ pos4 + 2 .. Length( s.lines ) ] } );
                                    pos2 := pos2 - ( pos4 + 2 - pos3 );
                                else
                                    s.lines := Concatenation( s.lines{ [ 1 .. pos3 ] },
                                                       s.lines{ [ pos3 + 2 .. Length( s.lines ) ] } );
                                    pos2 := pos2 - 2;
                                fi;
                                s.lines := s.lines{ [ pos1 + 2 .. pos2 - 2 ] };
                                pos3 := PositionSublist( s.lines, "\n\no" );
                                if pos3 <> fail then
                                    s.lines := s.lines{ [ 1 .. pos3 - 1 ] };
                                fi;
                            else
                                s.lines := s.lines{ [ pos1 + 4 .. pos2 - 2 ] };
                            fi;
                        fi;
                    else
                        s.lines := s.lines{ [ CUT_POS_BEGIN .. Length( s.lines ) - READY_LENGTH - CUT_POS_END ] };
                    fi;
                fi;
            else
                if IsBound( s.name ) then
                    CAS := Concatenation( s.name, " " );
                else
                    CAS := "";
                fi;
                if IsBound( s.pid ) then
                    PID := Concatenation( "(which should be running with PID ", String( s.pid ), ") " );
                else
                    PID := "";
                fi;
                if IsBound( HOMALG_IO.color_display ) and HOMALG_IO.color_display = true then
                    COLOR := "\033[5;31;43m";
                else
                    COLOR := "";
                fi;
                Error( COLOR, "the external CAS ", CAS, PID, "seems to have died!", "\033[0m\n" );
            fi;
        fi;
        
        if l[2] <> fail then   # something on stderr
            bytes := IO_read( l[2], s.errors, Length( s.errors ), s.BUFSIZE );
            if bytes > 0 then
                #Print( "stderr bytes:", bytes, "\n" );
                gotsomething := true;
            else
                if IsBound( s.name ) then
                    CAS := Concatenation( s.name, " " );
                else
                    CAS := "";
                fi;
                if IsBound( s.pid ) then
                    PID := Concatenation( "(which should be running with PID ", String( s.pid ), ") " );
                else
                    PID := "";
                fi;
                if IsBound( HOMALG_IO.color_display ) and HOMALG_IO.color_display = true then
                    COLOR := "\033[5;31;43m";
                else
                    COLOR := "";
                fi;
                Error( COLOR, "the external CAS ", CAS, PID, "seems to have died!", "\033[0m\n" );
            fi;
        fi;
    od;
    # never reached
    
end );

InstallGlobalFunction( SendBlockingToCAS,
  function( s, command )
    local l, nr;
    
    SendToCAS( s, command );
    repeat
        l := [ IO_GetFD( s.stdout ), IO_GetFD( s.stderr ) ];
        nr := IO_select( l, [], [], fail, fail );   # wait for input ready!
    until CheckOutputOfCAS( s ) = true;
    
end );

InstallGlobalFunction( LaunchCAS,
  function( arg )
    local nargs, HOMALG_IO_CAS, executables, e, s;
    
    nargs := Length( arg );
    
    HOMALG_IO_CAS := arg[1];
    
    executables := [ ];
    
    if nargs > 1 and IsStringRep( arg[2] ) then
        Add( executables, arg[2] );
    fi;
    
    if IsBound( HOMALG_IO_CAS.executable ) then
        Add( executables, HOMALG_IO_CAS.executable );
    fi;
    
    e := 1;
    while true do
        if IsBound( HOMALG_IO_CAS.( Concatenation( "executable_alt", String( e ) ) ) ) then
            Add( executables, HOMALG_IO_CAS.( Concatenation( "executable_alt", String( e ) ) ) );
            e := e + 1;
        else
            break;
        fi;
    od;
    
    if executables = [ ] then
        Error( "either the name of the ", HOMALG_IO_CAS.name,  " executable must exist as a component of the CAS specific record (normally called HOMALG_IO_", HOMALG_IO_CAS.name, " and which probably have been provided as the first argument), or the name must be provided as a second argument:\n", HOMALG_IO_CAS, "\n" );
    fi;
    
    for e in executables do
        
        s := IO_Popen3( Filename( DirectoriesSystemPrograms( ), e ),
                     HOMALG_IO_CAS.options );
        
        if s <> fail then
            break;
        fi;
        
    od;
    
    if s = fail then
        Error( "found no ",  HOMALG_IO_CAS.executable, " executable in PATH while searching the following list:\n", executables, "\n" );
    fi;
    
    s.stdout!.rbufsize := false;   # switch off buffering
    s.stderr!.rbufsize := false;   # switch off buffering
    
    for e in NamesOfComponents( HOMALG_IO_CAS ) do
        s.( e ) := HOMALG_IO_CAS.( e );
    od;
    
    if IsBound( HOMALG_IO.color_display ) and HOMALG_IO.color_display = true
       and IsBound( s.display_color ) then
        s.color_display := s.display_color;
    fi;
    
    s.HomalgExternalCallCounter := 0;
    s.HomalgExternalVariableCounter := 0;
    s.HomalgExternalCommandCounter := 0;
    s.HomalgExternalOutputCounter := 0;
    s.HomalgBackStreamMaximumLength := 0;
    s.HomalgExternalWarningsCounter := 0;
    
    s.homalgExternalObjectsPointingToVariables :=
      ContainerForWeakPointers( TheTypeContainerForWeakPointersOnHomalgExternalObjects );
    
    SendBlockingToCAS( s, "\n" );
    
    if ( not ( IsBound( HOMALG_IO.show_banners ) and HOMALG_IO.show_banners = false )
         and not ( IsBound( s.show_banner ) and s.show_banner = false ) ) then
        Print( "----------------------------------------------------------------\n" );
        if IsBound( s.color_display ) then
            Print( s.color_display );
        fi;
        if s.cas = "maple" then
            #Print( s.lines{ [ 1 .. Length( s.lines ) - 36 ] } );	## this line is commented since we must start Maple using the -q option, which unfortunately also suppresses the Maple banner
	    Print( "\
    |\\^/|     Launching Maple\n\
._|\\|   |/|_. Copyright (c) Maplesoft, a division of Waterloo Maple Inc.\n\
 \\  MAPLE  /  All rights reserved. Maple is a trademark of\n\
 <____ ____>  Waterloo Maple Inc.\n\
      |       " );
        elif s.cas = "macaulay2" then
            Remove( s.errors, Length( s.errors ) );
            Print( s.errors );
        else
            Print( s.lines );
        fi;
        Print( "\033[0m\n----------------------------------------------------------------\n\n" );
    fi;
    
    return s;
    
end );

