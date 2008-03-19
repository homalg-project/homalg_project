MAGMA_BUFSIZE := 1024;
MAGMA_READY := "!$%&/(";
MAGMA_READY_LENGTH := Length( MAGMA_READY );

TermMagma := function(s)
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

SendMagma := function(s,command)
  local cmd;
  if command[Length(command)] <> '\n' then
      Add(command,'\n');
  fi;
  if Length(command) < 1024 then
      IO_Write(s.stdin,command);
      IO_Write(s.stdin,"\"",MAGMA_READY,"\";\n");
      IO_Flush(s.stdin);
  else
      cmd := Concatenation(command,"\"",MAGMA_READY,"\";\n");
      SendForking(s.stdin,cmd);
  fi;
  s.lines := "";
  s.errors := "";
  s.magmaready := false;
end;

CheckMagmaOutput := function(s)
  local bytes,gotsomething,l,le,nr,pos;
  gotsomething := false;
  while true do  # will be exited with break or return
      l := [IO_GetFD(s.stdout),IO_GetFD(s.stderr)];
      nr := IO_select(l,[],[],0,0);
      #Print("select: nr=",nr,"\n");
      if nr = 0 then 
          if not(gotsomething) then return fail; fi;  # nothing new whatsoever
          return s.magmaready;
      fi;
      #Print("select: l=",l,"\n");
      if l[1] <> fail then   # something on stdout
          pos := Length(s.lines);
          bytes := IO_read(l[1],s.lines,pos,MAGMA_BUFSIZE);
          if bytes > 0 then
              #Print("stdout bytes:",bytes,"\n");
              gotsomething := true;
              pos := PositionSublist(s.lines,MAGMA_READY,pos-MAGMA_READY_LENGTH+1);
                  # ........NEWNEWNEWNEWNEW
                  #        ^
                  #        pos
              if pos <> fail then 
                  s.magmaready := true;
                  s.lines := s.lines{[1..Length(s.lines)-MAGMA_READY_LENGTH-2]};
              fi;
          else
              Error("MAGMA process seems to have died!");
          fi;
      fi;
      if l[2] <> fail then   # something on stderr
          bytes := IO_read(l[2],s.errors,Length(s.errors),MAGMA_BUFSIZE);
          if bytes > 0 then
              #Print("stderr bytes:",bytes,"\n");
              gotsomething := true;
          else
              Error("MAGMA process seems to have died!");
          fi;
      fi;
  od;
  # never reached
end;

SendMagmaBlocking := function(s,command)
  local l,nr;
  SendMagma(s,command);
  repeat
      l := [IO_GetFD(s.stdout),IO_GetFD(s.stderr)];
      nr := IO_select(l,[],[],fail,fail);   # wait for input ready!
  until CheckMagmaOutput(s) = true;
end;

LaunchMagma := function(arg)
  local s;
  s := IO_Popen3(Filename(DirectoriesSystemPrograms(),"magma"),
                 [ ]);
  if s = fail then
      Error("No magma executable available");
  fi;
  s.stdout!.rbufsize := false;   # switch off buffering
  s.stderr!.rbufsize := false;   # switch off buffering
  SendMagmaBlocking(s,"\n");
  if Length(arg) > 0 and arg[1] = true then
      Print(s.lines);
  fi;
  return s;
end;

