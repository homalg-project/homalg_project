#############################################################################
##
##  IO.gi                     RingsForHomalg package          Max Neunhöffer
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff to use the GAP4 I/O package.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

####################################
#
# constructor functions:
#
####################################

##
InstallGlobalFunction( TermCAS,
  function( s )
    
    IO_Close( s.stdin );
    IO_Close( s.stdout );
    IO_Close( s.stderr );
    s.stdin := fail;
    s.stdout := fail;
    s.stderr := fail;
    
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
    local bytes, gotsomething, l, nr, pos, CAS, PID;
    
    gotsomething := false;
    
    while true do	# will be exited with break or return
        l := [ IO_GetFD( s.stdout ), IO_GetFD( s.stderr ) ];
        nr := IO_select( l, [], [], 0, 0 );
        #Print( "select: nr=", nr, "\n" );
        
        if nr = 0 then 
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
              pos := PositionSublist( s.lines, s.READY, pos - s.READY_LENGTH + 1 );
                    # ........NEWNEWNEWNEWNEW
                    #        ^
                    #        pos
              if pos <> fail then 
                  s.casready := true;
                  s.lines := s.lines{ [ s.CUT_BEGIN .. Length( s.lines ) - s.READY_LENGTH - s.CUT_END ] };
              fi;
          else
              if IsBound( s.name ) then
                  CAS := Concatenation( s.name, " " );
              else
                  CAS := "";
              fi;
              if IsBound( s.pid ) then
                  PID := Concatenation( "(which should be running with PID ", s.pid, ") " );
              else
                  PID := "";
              fi;
              Error( "\033[5;31;43m", "the external CAS ", CAS, PID, "seems to have died!", "\033[0m\n" );
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
                  PID := Concatenation( "(which should be running with PID ", s.pid, ") " );
              else
                  PID := "";
              fi;
              Error( "\033[5;31;43m", "the external CAS ", CAS, PID, "seems to have died!", "\033[0m\n" );
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
    
    if nargs > 1 and IsString( arg[2] ) then
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
    
    if IsBound( HOMALG_RINGS.color_display ) and HOMALG_RINGS.color_display = true
       and IsBound( s.display_color ) then
        s.color_display := s.display_color;
    fi;
        
    SendBlockingToCAS( s, "\n" );
    
    return s;
    
end );

