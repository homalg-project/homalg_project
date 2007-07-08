#############################################################################
##
##  module.gi           homalg package                       Mohamed Barakat
##
##  Copyright 2007 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for modules.
##
#############################################################################


# A central place for configuration variables:

InstallValue( HOMALG, rec( ) );

# Possible options:
#  .grpsizebound
#  .orbsizebound
#  .stabsizebound
#  .permgens
#  .matgens
#  .onlystab
#  .schreier
#  .lookingfor
#  .report
#  .stabchainrandom
#  .permbase
#  .stab
#  .storenumbers    indicates whether positions are stored in the hash
#  .hashlen         for the call version with 3 or 4 arguments with options
#  .hashfunc        only together with next option, hashs cannot grow!
#  .eqfunc
#  .looking
#  .lookfunc
#  .log             either false or a list of length 2 orbitlength
#  .logind          index into log
#  .logpos          write position in log

# Outputs:
#  .gens
#  .op
#  .orbit
#  .pos
#  .tab
#  .ht
#  .stab
#  .stabchain
#  .stabsize
#  .stabcomplete
#  .schreiergen
#  .schreierpos
#  .found
#  .stabwords
#  .log
#  .logind
#  .logpos
#  .orbind

InstallGlobalFunction( Module, 
  function( arg )
    local comp,filts,gens,hashlen,lmp,o,op,opt,x;

    # First parse the arguments:
    if Length(arg) = 3 then
        gens := arg[1]; x := arg[2]; op := arg[3];
        hashlen := 10000; opt := rec();
    elif Length(arg) = 4 and IsInt(arg[4]) then
        gens := arg[1]; x := arg[2]; op := arg[3]; hashlen := arg[4];
        opt := rec();
    elif Length(arg) = 4 then
        gens := arg[1]; x := arg[2]; op := arg[3]; opt := arg[4];
        if IsBound(opt.hashlen) then
            hashlen := opt.hashlen;
        else
            hashlen := 10000;
        fi;
    elif Length(arg) = 5 then
        gens := arg[1]; x := arg[2]; op := arg[3]; hashlen := arg[4];
        opt := arg[5];
    else
        Print("Usage: Orb( gens, point, action [,options] )\n");
        return;
    fi;

    Objectify( NewType(CollectionsFamily(FamilyObj(x)),filts), o );
    return o;
  end );

InstallMethod( ViewObj, "for an orbit", [IsOrbit and IsList and IsFinite],
  function( o )
    Print("<");
    if IsClosed(o) then Print("closed "); else Print("open "); fi;
    if IsPermOnIntOrbitRep(o) then Print("Int-"); fi;
    Print("orbit, ", Length(o!.orbit), " points");
    if o!.schreier then Print(" with Schreier tree"); fi;
    if o!.permgens <> false or o!.matgens <> false then
        Print(" and stabilizer");
        if o!.onlystab then Print(" going for stabilizer"); fi;
    fi;
    if o!.looking then Print(" looking for sth."); fi;
    if o!.log <> false then Print(" with log"); fi;
    Print(">");
  end );

