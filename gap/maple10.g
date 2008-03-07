LoadPackage("io");

MAPLE_BUFSIZE := 1024;
MAPLE_READY := "!$%&/(";
MAPLE_READY_LENGTH := Length( MAPLE_READY );

TermMaple10 := function(s)
  IO_Close(s.stdin);
  IO_Close(s.stdout);
  IO_Close(s.stderr);
  s.stdin := fail;
  s.stdout := fail;
  s.stderr := fail;
end;

SendForking := function ( f, st )
  local  pid, len;
  IO_Flush(f);
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
end;

SendMaple10 := function(s,command)
  local cmd;
  if command[Length(command)] <> '\n' then
      Add(command,'\n');
  fi;
  if Length(command) < 1024 then
      IO_Write(s.stdin,command);
      IO_Write(s.stdin,"\"",MAPLE_READY,"\";\n");
      IO_Flush(s.stdin);
  else
      cmd := Concatenation(command,"\"",MAPLE_READY,"\";\n");
      SendForking(s.stdin,cmd);
  fi;
  s.lines := "";
  s.errors := "";
  s.mapleready := false;
end;

CheckMaple10Output := function(s)
  local bytes,gotsomething,l,le,nr,pos;
  gotsomething := false;
  while true do  # will be exited with break or return
      l := [IO_GetFD(s.stdout),IO_GetFD(s.stderr)];
      nr := IO_select(l,[],[],0,0);
      #Print("select: nr=",nr,"\n");
      if nr = 0 then 
          if not(gotsomething) then return fail; fi;  # nothing new whatsoever
          return s.mapleready;
      fi;
      #Print("select: l=",l,"\n");
      if l[1] <> fail then   # something on stdout
          pos := Length(s.lines);
          bytes := IO_read(l[1],s.lines,pos,MAPLE_BUFSIZE);
          if bytes > 0 then
              #Print("stdout bytes:",bytes,"\n");
              gotsomething := true;
              pos := PositionSublist(s.lines,MAPLE_READY,pos-MAPLE_READY_LENGTH+1);
                  # ........NEWNEWNEWNEWNEW
                  #        ^
                  #        pos
              if pos <> fail then 
                  s.mapleready := true;
                  s.lines := s.lines{[1..Length(s.lines)-MAPLE_READY_LENGTH-4]};
              fi;
          else
              Error("Maple10 process seems to have died!");
          fi;
      fi;
      if l[2] <> fail then   # something on stderr
          bytes := IO_read(l[2],s.errors,Length(s.errors),MAPLE_BUFSIZE);
          if bytes > 0 then
              #Print("stderr bytes:",bytes,"\n");
              gotsomething := true;
          else
              Error("Maple10 process seems to have died!");
          fi;
      fi;
  od;
  # never reached
end;

SendMaple10Blocking := function(s,command)
  local l,nr;
  SendMaple10(s,command);
  repeat
      l := [IO_GetFD(s.stdout),IO_GetFD(s.stderr)];
      nr := IO_select(l,[],[],fail,fail);   # wait for input ready!
  until CheckMaple10Output(s) = true;
end;

LaunchMaple10 := function(arg)
  local s;
  s := IO_Popen3(Filename(DirectoriesSystemPrograms(),"maple10"),
                 [ "-q" ]);
  if s = fail then
      Error("No maple10 executable available");
  fi;
  s.stdout!.rbufsize := false;   # switch off buffering
  s.stderr!.rbufsize := false;   # switch off buffering
  SendMaple10Blocking(s,"\n");
  if Length(arg) > 0 and arg[1] = true then
      Print(s.lines);
  fi;
  return s;
end;

