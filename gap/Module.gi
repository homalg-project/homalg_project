#############################################################################
##
##  Module.gi           homalg package                       Mohamed Barakat
##
##  Copyright 2007 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for modules.
##
#############################################################################

##
InstallMethod( Presentation,
        "constructor",
        [IsList, IsSemiringWithOneAndZero],
        
  function( arg )
    local gen, rel, M, is_zero_module;;
    
    is_zero_module := false;
    
    if Length(arg[1]) = 0 then ## no relations means the zero module ... hmm ...
        gen := rec( 1 := []);
        is_zero_module := true;
    elif IsList(arg[1][1]) then ## to be replaced with something to distinguish lists of rings elements from elements that are theirself lists
        gen := rec( 1 := List([1..Length(arg[1][1])],a->["StdBasisVector",a]));
    else ## only one generator
        gen := rec( 1 := [["StdBasisVector",1]]);
    fi;
    
    rel := rec( 1 := arg[1] );
    
    M := rec(generators:=gen,relations:=rel);
    
    Objectify( LeftModuleFinitelyPresentedType, M);
    
    SetDefaultRelations(M,1);
    SetGeneratorsRelationsCounter(M,1);
    
    SetLeftActingDomain(M,arg[2]);
    SetGeneratorsOfLeftOperatorAdditiveGroup(M,M!.generators.(M!.DefaultRelations));
    
    if is_zero_module = true then
        SetIsZeroModule(M,true);
    fi;
    
    return M;
    
end );
  
##
InstallMethod( Presentation,
        "constructor",
        [IsList, IsList, IsSemiringWithOneAndZero],
        
  function( arg )
    local gen, rel, M;
    
    gen := rec(1:=arg[1],default:=1);
    
    if arg[2] = [] and arg[1] <> [] then
        rel := rec(1:="unknown relations");
    else
        rel := rec(1:=arg[2]);
    fi;
    
    M := rec(generators:=gen,relations:=rel);
    
    Objectify( LeftModuleFinitelyPresentedType, M);
    
    SetDefaultRelations(M,1);
    SetGeneratorsRelationsCounter(M,1);
    
    SetLeftActingDomain(M,arg[3]);
    SetGeneratorsOfLeftOperatorAdditiveGroup(M,M!.generators.(M!.DefaultRelations));
    
    return M;
    
end );

##
InstallMethod( GeneratorsOfModule,
        "for homalg modules",
	[IsFinitelyPresentedModuleRep],
        
  function( M )
  
    return M!.generators.(M!.DefaultRelations);
    
end );

##
InstallMethod( RelationsOfModule,
        "for homalg modules",
        [IsFinitelyPresentedModuleRep],
        
  function( M )
  
    return M!.relations.(M!.DefaultRelations);
    
end );

##
InstallMethod( NrGenerators,
        "for homalg modules",
        [IsFinitelyPresentedModuleRep],
  function( M )
  
    return Length(GeneratorsOfModule(M));
    
end );

##
InstallMethod( NrRelations,
        "for homalg modules",
        [IsFinitelyPresentedModuleRep],
        
  function( M )
  
    return Length(RelationsOfModule(M));
    
end );

##
InstallMethod( ViewObj,
        "for a homalg module",
        [IsLeftModule and IsFinitelyPresentedModuleRep],
        
  function( M )
    local num_gen, num_rel, gen_string, rel_string;
    
    Print("<");
    if HasIsZeroModule(M) and IsZeroModule(M) then
        Print("The zero module");
    else
        num_gen := NrGenerators(M);
        if num_gen = 1 then
            gen_string := " generator and ";
        else
            gen_string := " generators and ";
        fi;
        if RelationsOfModule(M) = "unknown relations" then
            num_rel := "unknown";
            rel_string := " relations";
        else
            num_rel := NrRelations(M);
            if num_rel = 0 then
                rel_string := " no relations";
            elif num_rel = 1 then
                rel_string := " relation";
            else
                rel_string := " relations";
            fi;
        fi;
        Print("A module on ",num_gen,gen_string,num_rel,rel_string);
    fi;
    Print(">");
    
end );

##
InstallMethod( RankOfGauss,
        "for a set of relations",
	[IsObject],
        
  function( M )
    
    return M.rank;
    
end );

##
InstallMethod( BasisOfModule,
        "for a set of relations",
	[IsObject, IsSemiringWithOneAndZero],
        
  function( _M, R )
    local RP, ring_rel, M, B, rank;
    
    RP := HomalgTable(R);
  
    if HasBasisOfModule(RP) then
        return RP!.BasisOfModule(_M);
    fi;
    
    if HasRingRelations(RP) then
        ring_rel := RingRelations(RP);
    fi;
    
    #=====# begin of the core procedure #=====#
    
    M := _M;
    
    B := RP!.TriangularBasis(M);
    
    rank := RankOfGauss(B);
    
    B := CertainRows(RP)(B,[1..rank]);
    
    return B;
    
end );

