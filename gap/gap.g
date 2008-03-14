LoadPackage("io");

GAP_BUFSIZE := 1024;
GAP_READY := "!$%&/(";
GAP_READY_LENGTH := Length( GAP_READY );

TermGAP := function(s)
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

SendGAP := function(s,command)
  local cmd;
  if command[Length(command)] <> '\n' then
      Add(command,'\n');
  fi;
  if Length(command) < 1024 then
      IO_Write(s.stdin,command);
      IO_Write(s.stdin,"\"",GAP_READY,"\";\n");
      IO_Flush(s.stdin);
  else
      cmd := Concatenation(command,"\"",GAP_READY,"\";\n");
      SendForking(s.stdin,cmd);
  fi;
  s.lines := "";
  s.errors := "";
  s.gapready := false;
end;

CheckGAPOutput := function(s)
  local bytes,gotsomething,l,le,nr,pos;
  gotsomething := false;
  while true do  # will be exited with break or return
      l := [IO_GetFD(s.stdout),IO_GetFD(s.stderr)];
      nr := IO_select(l,[],[],0,0);
      #Print("select: nr=",nr,"\n");
      if nr = 0 then 
          if not(gotsomething) then return fail; fi;  # nothing new whatsoever
          return s.gapready;
      fi;
      #Print("select: l=",l,"\n");
      if l[1] <> fail then   # something on stdout
          pos := Length(s.lines);
          bytes := IO_read(l[1],s.lines,pos,GAP_BUFSIZE);
          if bytes > 0 then
              #Print("stdout bytes:",bytes,"\n");
              gotsomething := true;
              le := Length(GAP_READY);
              pos := PositionSublist(s.lines,GAP_READY,pos-le+1);
                  # ........NEWNEWNEWNEWNEW
                  #        ^
                  #        pos
              if pos <> fail then 
                  s.gapready := true;
                  s.lines := s.lines{[1..Length(s.lines)-GAP_READY_LENGTH-4]};
              fi;
          else
              Error("GAP process seems to have died!");
          fi;
      fi;
      if l[2] <> fail then   # something on stderr
          bytes := IO_read(l[2],s.errors,Length(s.errors),GAP_BUFSIZE);
          if bytes > 0 then
              #Print("stderr bytes:",bytes,"\n");
              gotsomething := true;
          else
              Error("GAP process seems to have died!");
          fi;
      fi;
  od;
  # never reached
end;

SendGAPBlocking := function(s,command)
  local l,nr;
  SendGAP(s,command);
  repeat
      l := [IO_GetFD(s.stdout),IO_GetFD(s.stderr)];
      nr := IO_select(l,[],[],fail,fail);   # wait for input ready!
  until CheckGAPOutput(s) = true;
end;

LaunchGAP := function(arg)
  local s;
  s := IO_Popen3(Filename(DirectoriesSystemPrograms(),"gapR"),
                 [ "-b -q" ]);
  if s = fail then
      Error("No gapR executable available");
  fi;
  s.stdout!.rbufsize := false;   # switch off buffering
  s.stderr!.rbufsize := false;   # switch off buffering
  SendGAPBlocking(s,"\n");
  if Length(arg) > 0 and arg[1] = true then
      Print(s.lines);
  fi;
  return s;
end;

