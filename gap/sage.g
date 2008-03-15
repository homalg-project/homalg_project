SAGE_BUFSIZE := 1024;
SAGE_READY := "!$%&/(";
SAGE_READY_LENGTH := Length( SAGE_READY );

TermSage := function(s)
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

SendSage := function(s,command)
  local cmd;
  if command[Length(command)] <> '\n' then
      Add(command,'\n');
  fi;
  if Length(command) < 1024 then
      IO_Write(s.stdin,command);
      IO_Write(s.stdin,"\"",SAGE_READY,"\"\n");
      IO_Flush(s.stdin);
  else
      cmd := Concatenation(command,"\"",SAGE_READY,"\"\n");
      SendForking(s.stdin,cmd);
  fi;
  s.lines := "";
  s.errors := "";
  s.sageready := false;
end;

CheckSageOutput := function(s)
  local bytes,gotsomething,l,le,nr,pos;
  gotsomething := false;
  while true do  # will be exited with break or return
      l := [IO_GetFD(s.stdout),IO_GetFD(s.stderr)];
      nr := IO_select(l,[],[],0,0);
      #Print("select: nr=",nr,"\n");
      if nr = 0 then 
          if not(gotsomething) then return fail; fi;  # nothing new whatsoever
          return s.sageready;
      fi;
      #Print("select: l=",l,"\n");
      if l[1] <> fail then   # something on stdout
          pos := Length(s.lines);
          bytes := IO_read(l[1],s.lines,pos,SAGE_BUFSIZE);
          if bytes > 0 then
              #Print("stdout bytes:",bytes,"\n");
              gotsomething := true;
              pos := PositionSublist(s.lines,SAGE_READY,pos-SAGE_READY_LENGTH+1);
                  # ........NEWNEWNEWNEWNEW
                  #        ^
                  #        pos
              if pos <> fail then 
                  s.sageready := true;
                  s.lines := s.lines{[7..Length(s.lines)-SAGE_READY_LENGTH-10]};
              fi;
          else
              Error("Sage process seems to have died!");
          fi;
      fi;
      if l[2] <> fail then   # something on stderr
          bytes := IO_read(l[2],s.errors,Length(s.errors),SAGE_BUFSIZE);
          if bytes > 0 then
              #Print("stderr bytes:",bytes,"\n");
              gotsomething := true;
          else
              Error("Sage process seems to have died!");
          fi;
      fi;
  od;
  # never reached
end;

SendSageBlocking := function(s,command)
  local l,nr;
  SendSage(s,command);
  repeat
      l := [IO_GetFD(s.stdout),IO_GetFD(s.stderr)];
      nr := IO_select(l,[],[],fail,fail);   # wait for input ready!
  until CheckSageOutput(s) = true;
end;

LaunchSage := function(arg)
  local s;
  s := IO_Popen3(Filename(DirectoriesSystemPrograms(),"sage"),
                 []);
  if s = fail then
      Error("No sage executable available");
  fi;
  s.stdout!.rbufsize := false;   # switch off buffering
  s.stderr!.rbufsize := false;   # switch off buffering
  SendSageBlocking(s,"\n");
  if Length(arg) > 0 and arg[1] = true then
      Print(s.lines);
  fi;
  return s;
end;

