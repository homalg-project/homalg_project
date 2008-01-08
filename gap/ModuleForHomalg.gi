#############################################################################
##
##  ModuleForHomalg.gi          homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for homalg modules.
##
#############################################################################

####################################
#
# representations:
#
####################################

# a new representation for the category IsModuleForHomalg:
DeclareRepresentation( "IsFinitelyPresentedModuleRep",
        IsModuleForHomalg,
        [ ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "ModulesFamily",
        NewFamily( "ModulesFamily" ));

# two new types:
BindGlobal( "LeftModuleFinitelyPresentedType",
        NewType( ModulesFamily ,
                IsLeftModule and IsFinitelyPresentedModuleRep ));

BindGlobal( "RightModuleFinitelyPresentedType",
        NewType( ModulesFamily ,
                IsRightModule and IsFinitelyPresentedModuleRep ));

####################################
#
# global variables:
#
####################################

InstallValue( SimpleLogicalImplicationsForHomalgModules,
        [ ## IsTorsionFreeLeftModule:
          
          [ IsZeroModule,
            "implies", IsFreeModule ], ## FIXME: the name should be changed to IsFreeLeftModule
          
          [ IsFreeModule, ## FIXME: the name should be changed to IsFreeLeftModule
            "implies", IsStablyFreeLeftModule ],
          
          [ IsStablyFreeLeftModule,
            "implies", IsProjectiveLeftModule ],
          
          [ IsProjectiveLeftModule,
            "implies", IsReflexiveLeftModule ],
          
          [ IsReflexiveLeftModule,
            "implies", IsTorsionFreeLeftModule ],
          
          ## IsTorsionLeftModule:
          
          [ IsZeroModule,
            "implies", IsHolonomicLeftModule ],
          
          [ IsHolonomicLeftModule,
            "implies", IsTorsionLeftModule ],
          
          [ IsHolonomicLeftModule,
            "implies", IsArtinianLeftModule ],
          
          ## IsCyclicLeftModule:
          
          [ IsZeroModule,
            "implies", IsCyclicLeftModule ],
          
          ## IsZeroModule:
          
          [ IsTorsionLeftModule, "and", IsTorsionFreeLeftModule,
            "imply", IsZeroModule ]
          
          ] );

####################################
#
# logical implications methods:
#
####################################

#LogicalImplicationsForHomalg( SimpleLogicalImplicationsForHomalgModules );

## FIXME: find a way to activate the above line and to delete the following
for property in SimpleLogicalImplicationsForHomalgModules do;
    
    if Length(property) = 3 then
        
        ## a => b:
        InstallTrueMethod( property[3],
                property[1] );
        
        ## not b => not a:
        InstallImmediateMethod( property[1],
                IsModuleForHomalg and Tester(property[3]), 0, ## NOTE: don't drop the Tester here!
                
          function( M )
            if Tester(property[3])( M ) and not property[3]( M ) then  ## FIXME: find a way to get rid of Tester here
                return false;
            else
                TryNextMethod();
            fi;
            
        end );
        
    elif Length(property) = 5 then
        
        ## a and b => c:
        InstallTrueMethod( property[5],
                property[1] and property[3] );
        
        ## b and not c => not a:
        InstallImmediateMethod( property[1],
                IsModuleForHomalg and Tester(property[3]) and Tester(property[5]), 0, ## NOTE: don't drop the Testers here!
                
          function( M )
            if Tester(property[3])( M ) and Tester(property[5])( M )  ## FIXME: find a way to get rid of the Testers here
               and property[3]( M ) and not property[5]( M ) then
                return false;
            else
                TryNextMethod();
            fi;
            
        end );
        
        ## a and not c => not b:
        InstallImmediateMethod( property[3],
                IsModuleForHomalg and Tester(property[1]) and Tester(property[5]), 0, ## NOTE: don't drop the Testers here!
                
          function( M )
            if Tester(property[1])( M ) and Tester(property[5])( M ) ## FIXME: find a way to get rid of the Testers here
               and property[1]( M ) and not property[5]( M ) then
                return false;
            else
                TryNextMethod();
            fi;
            
        end );
        
    fi;
    
od;

####################################
#
# immediate methods for properties:
#
####################################

# strictly less relations than generators => not IsTorsionLeftModule
InstallImmediateMethod( IsTorsionLeftModule,
        IsFinitelyPresentedModuleRep, 0,
        
  function( M )
    local l, b, i, rel, mat;
    
    l := SetsOfRelations(M)!.ListOfNumbersOfKnownSetsOfRelations;
    
    b := false;
    
    for i in [1..Length(l)] do;
        
        rel := SetsOfRelations(M)!.(i);
        
        if not IsString(rel) then
	    mat := rel!.relations;
     
            if HasNrRows(mat) and HasNrColumns(mat)
              and NrColumns(mat) > NrRows(mat) then
                b := true;
                break;
            fi;
        fi;
        
    od;
    
    if b then
        return false;
    else
        TryNextMethod();
    fi;
    
end );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( PositionOfTheDefaultSetOfRelations,
        "for homalg modules",
	[ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    if IsBound(M!.PositionOfTheDefaultSetOfRelations) then
        return M!.PositionOfTheDefaultSetOfRelations;
    else
        return fail;
    fi;
    
end );

##
InstallMethod( SetsOfGenerators,
        "for homalg modules",
	[ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    if IsBound(M!.SetsOfGenerators) then
        return M!.SetsOfGenerators;
    else
        return fail;
    fi;
    
end );

##
InstallMethod( SetsOfRelations,
        "for homalg modules",
	[ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    if IsBound(M!.SetsOfRelations) then
        return M!.SetsOfRelations;
    else
        return fail;
    fi;
    
end );

##
InstallMethod( GeneratorsOfModule,
        "for homalg modules",
	[ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    if IsBound(SetsOfGenerators(M)!.(NumberOfTheDefaultSetOfGenerators( M ))) then
        return SetsOfGenerators(M)!.(NumberOfTheDefaultSetOfGenerators( M ));
    else
        return fail;
    fi;
    
end );

##
InstallMethod( RelationsOfModule,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    if IsBound(SetsOfRelations(M)!.(PositionOfTheDefaultSetOfRelations( M ))) then;
        return SetsOfRelations(M)!.(PositionOfTheDefaultSetOfRelations( M ));
    else
        return fail;
    fi;
    
end );

##
InstallMethod( NrGenerators,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
  function( M )
    
    return NrRows( GeneratorsOfModule( M ) );
    
end );

##
InstallMethod( NrRelations,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return NrRows( RelationsOfModule(M)!.relations );
    
end );

##
InstallMethod( BasisOfModule,
        "for a homalg module",
	[ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local rel, B, rels, l;
    
    rel := RelationsOfModule ( M );
    
    if not ( HasCanBeUsedToEffictivelyDecideZero( rel ) and CanBeUsedToEffictivelyDecideZero( rel ) ) then
        
        B := BasisOfModule( rel );
        
        if IsLeftModule( M ) then
            rel := RelationsOfLeftModule( B, LeftActingDomain( M ) );
        else
            rel := RelationsOfRightModule( B, RightActingDomain( M ) );
        fi;
        
        SetCanBeUsedToEffictivelyDecideZero( rel, true );
        
        rels := SetsOfRelations( M );
        
        l := NumberOfLastStoredSet( rels );
        
        rels!.ListOfNumbersOfKnownSetsOfRelations[l+1] := l+1;
        
        rels!.(l+1) := rel;
        
        M!.PositionOfTheDefaultSetOfRelations := l+1;
    fi;
    
    return rel!.relations;
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallMethod( LeftPresentation,
        "constructor",
        [ IsList, IsSemiringWithOneAndZero ],
        
  function( rel, ring )
    local R, gens, rels, M, is_zero_module;
    
    R := CreateRingForHomalg( ring, CreateHomalgTable( ring ) );
    
    is_zero_module := false;
    
    if Length( rel ) = 0 then ## since one doesn't specify generators here giving no relations defines the zero module
        gens := rec( 1 := MatrixForHomalg( [] ) );
        is_zero_module := true;
    elif IsList( rel[1] ) then ## FIXME: to be replaced with something to distinguish lists of rings elements from elements that are theirself lists
        gens := rec( 1 := MatrixForHomalg( "IdentityMatrix", Length( rel[1] ) ) );
    else ## only one generator
        gens := rec( 1 := MatrixForHomalg( "IdentityMatrix", 1 ) );
    fi;
    
    rels := CreateSetsOfRelationsForLeftModule( rel, R );
    
    M := rec( SetsOfGenerators := gens,
              SetsOfRelations := rels,
              PositionOfTheDefaultSetOfRelations := 1 );
    
    ## Objectify:
    ObjectifyWithAttributes(
            M, LeftModuleFinitelyPresentedType,
            LeftActingDomain, R,
            GeneratorsOfLeftOperatorAdditiveGroup, M!.SetsOfGenerators!.1 );
    
    if is_zero_module = true then
        SetIsZeroModule( M, true );
    fi;
    
#    SetParent(gens, M);
#    SetParent(rels, M);
    
    return M;
    
end );
  
##
InstallMethod( LeftPresentation,
        "constructor",
        [ IsList, IsList, IsSemiringWithOneAndZero ],
        
  function( gen, rel, ring )
    local R, gens, rels, M;
    
    R := CreateRingForHomalg( ring, CreateHomalgTable( ring ) );
    
    gens := rec( 1 := MatrixForHomalg( gen ) );
    
    if rel = [] and gen <> [] then
        rels := CreateSetsOfRelationsForLeftModule( "unknown relations", R );
    else
        rels := CreateSetsOfRelationsForLeftModule( rel, R );
    fi;
    
    M := rec( SetsOfGenerators := gens,
              SetsOfRelations := rels,
              PositionOfTheDefaultSetOfRelations := 1 );
    
    ## Objectify:
    ObjectifyWithAttributes(
            M, LeftModuleFinitelyPresentedType,
            LeftActingDomain, R,
            GeneratorsOfLeftOperatorAdditiveGroup, M!.SetsOfGenerators!.1 );
    
#    SetParent(gens, M);
#    SetParent(rels, M);
    
    return M;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( ViewObj,
        "for homalg modules",
        [ IsLeftModule and IsFinitelyPresentedModuleRep ],
        
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
        Print( "A left module on ", num_gen, gen_string, num_rel, rel_string );
    fi;
    Print( ">" );
    
end );

##
InstallMethod( PrintObj,
        "for homalg modules",
        [ IsLeftModule and IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    Print( "LeftPresentation( " );
    if HasIsZeroModule(M) and IsZeroModule(M) then
        Print( "[], ", LeftActingDomain(M) ); ## no generators, empty relations, ring
    else
        Print( GeneratorsOfModule(M), ", " );
        if RelationsOfModule(M) = "unknown relations" then
            Print( "[], " ) ; ## empty relations
        else
            Print( RelationsOfModule(M), ", " );
        fi;
        Print( LeftActingDomain(M), " " );
    fi;
    Print(")");
    
end );

