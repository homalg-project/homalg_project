#############################################################################
##
##  IO.gi                     IO_ForHomalg package            Thomas Bächler
##                                                           Mohamed Barakat
##                                                           Max Neunhoeffer
##                                                            Daniel Robertz
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff to use the GAP4 I/O package of Max Neunhoeffer.
##
#############################################################################

####################################
#
# install global functions:
#
####################################

##
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
    
    return pid;
    
end );

##
InstallGlobalFunction( SendToCAS,
  function( s, command )
    # Note that it is the responsibility of the caller of this
    # function to call IO_WaitPID on the resulting pid eventually,
    # if the result is an integer rather than fail!
    local cmd,pid;
    
    if command[ Length( command ) ] <> '\n' then
        Add( command, '\n' );
    fi;
    
    if Length( command ) < 65536 then
        IO_Write( s.stdin,command );
        IO_Write( s.stdin, "\"", s.READY, "\"", s.eoc_verbose, "\n" );
        IO_Flush( s.stdin );
        pid := fail;
    else
        cmd := Concatenation( command, "\"", s.READY, "\"", s.eoc_verbose, "\n" );
        pid := SendForkingToCAS( s.stdin, cmd );
    fi;
    
    s.lines := "";
    s.errors := "";
    s.casready := false;
    
    return pid;
end );

##
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
        
        if nr = fail then continue; fi;  # probably an interupted system call...

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

##
InstallGlobalFunction( SendBlockingToCAS,
  function( s, command )
    local l, nr, pid;
    
    pid := SendToCAS( s, command );
    repeat
        l := [ IO_GetFD( s.stdout ), IO_GetFD( s.stderr ) ];
        nr := IO_select( l, [], [], fail, fail );   # wait for input ready!
    until CheckOutputOfCAS( s ) = true;
    if pid <> fail then IO_WaitPid(pid,true); fi;
    
end );

##
InstallGlobalFunction( LaunchCAS_IO_ForHomalg,
  function( arg )
    local nargs, HOMALG_IO_CAS, executables, e, s;
    
    nargs := Length( arg );
    
    HOMALG_IO_CAS := arg[1];
    
    executables := [ ];
    
    if nargs > 1 and IsStringRep( arg[2] ) then
        Add( executables, arg[2] );
    fi;
    
    if IsBound( HOMALG_IO_CAS.executable ) then
        if IsStringRep( HOMALG_IO_CAS.executable ) then
            Add( executables, HOMALG_IO_CAS.executable );
        elif ForAll( HOMALG_IO_CAS.executable, IsStringRep ) then
            Append( executables, HOMALG_IO_CAS.executable );
        fi;
    fi;
    
    if executables = [ ] then
        Error( "either the name of the ", HOMALG_IO_CAS.name,  " executable must exist as a component of the CAS specific record (normally called HOMALG_IO_", HOMALG_IO_CAS.name, " and which probably have been provided as the first argument), or the name must be provided as a second argument:\n", HOMALG_IO_CAS, "\n" );
    fi;
    
    for e in executables do
        
        s := Filename( DirectoriesSystemPrograms( ), e );
        
        if s <> fail then
            s := IO_Popen3( s, HOMALG_IO_CAS.options );
        fi;
        
        if s <> fail then
            break;
        fi;
        
    od;
    
    if s = fail then
        Error( "found no ",  HOMALG_IO_CAS.name, " executable in PATH while searching the following list:\n", executables, "\n" );
    fi;
    
    s.stdout!.rbufsize := false;   # switch off buffering
    s.stderr!.rbufsize := false;   # switch off buffering
    
    s.SendBlockingToCAS := SendBlockingToCAS;
    s.SendBlockingToCAS_original := SendBlockingToCAS;
    
    s.TerminateCAS :=
      function( s )
        
        if s.stdin <> fail then
            IO_Close( s.stdin );
            s.stdin := fail;
        fi;
        
        if s.stdout <> fail then
            IO_Close( s.stdout );
            s.stdout := fail;
        fi;
        
        if s.stderr <> fail then
            IO_Close( s.stderr );
            s.stderr := fail;
        fi;
        
    end;
    
    return s;
    
end );

