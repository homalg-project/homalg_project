LoadPackage("io");

SINGULAR_BUFSIZE := 1024;
SINGULAR_READY := "!$%&/(";

TermSingular := function(s)
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

SendSingular := function(s,command)
  local cmd;
  if command[Length(command)] <> '\n' then
      Add(command,'\n');
  fi;
  if Length(command) < 1024 then
      IO_Write(s.stdin,command);
      IO_Write(s.stdin,"\"",SINGULAR_READY,"\";\n");
      IO_Flush(s.stdin);
  else
      cmd := Concatenation(command,"\"",SINGULAR_READY,"\";\n");
      SendForking(s.stdin,cmd);
  fi;
  s.lines := "";
  s.errors := "";
  s.singready := false;
end;

CheckSingularOutput := function(s)
  local bytes,gotsomething,l,le,nr,pos;
  gotsomething := false;
  while true do  # will be exited with break or return
      l := [IO_GetFD(s.stdout),IO_GetFD(s.stderr)];
      nr := IO_select(l,[],[],0,0);
      #Print("select: nr=",nr,"\n");
      if nr = 0 then 
          if not(gotsomething) then return fail; fi;  # nothing new whatsoever
          return s.singready;
      fi;
      #Print("select: l=",l,"\n");
      if l[1] <> fail then   # something on stdout
          pos := Length(s.lines);
          bytes := IO_read(l[1],s.lines,pos,SINGULAR_BUFSIZE);
          if bytes > 0 then
              #Print("stdout bytes:",bytes,"\n");
              gotsomething := true;
              le := Length(SINGULAR_READY);
              pos := PositionSublist(s.lines,SINGULAR_READY,pos-le+1);
                  # ........NEWNEWNEWNEWNEW
                  #        ^
                  #        pos
              if pos <> fail then 
                  s.singready := true;
                  s.lines := Concatenation(s.lines{[1..pos-1]},
                                     s.lines{[pos+le+1..Length(s.lines)]});
              fi;
          else
              Error("Singular process seems to have died!");
          fi;
      fi;
      if l[2] <> fail then   # something on stderr
          bytes := IO_read(l[2],s.errors,Length(s.errors),SINGULAR_BUFSIZE);
          if bytes > 0 then
              #Print("stderr bytes:",bytes,"\n");
              gotsomething := true;
          else
              Error("Singular process seems to have died!");
          fi;
      fi;
  od;
  # never reached
end;

SendSingularBlocking := function(s,command)
  local l,nr;
  SendSingular(s,command);
  repeat
      l := [IO_GetFD(s.stdout),IO_GetFD(s.stderr)];
      nr := IO_select(l,[],[],fail,fail);   # wait for input ready!
  until CheckSingularOutput(s) = true;
end;

LaunchSingular := function(arg)
  local s;
  s := IO_Popen3(Filename(DirectoriesSystemPrograms(),"Singular"),
                 ["-t","--echo=0"]);
  if s = fail then
      Error("No Singular executable available");
  fi;
  s.stdout!.rbufsize := false;   # switch off buffering
  s.stderr!.rbufsize := false;   # switch off buffering
  SendSingularBlocking(s,"\n");
  if Length(arg) > 0 and arg[1] = true then
      Print(s.lines);
  fi;
  return s;
end;

