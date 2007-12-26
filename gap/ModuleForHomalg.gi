#############################################################################
##
##  ModuleForHomalg.gi       homalg package                  Mohamed Barakat
##
##  Copyright 2007 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for modules.
##
#############################################################################

###############
# declarations:
###############

# a new representation for the category IsModuleForHomalg:
DeclareRepresentation( "IsFinitelyPresentedModuleRep",
        IsModuleForHomalg,
        [ ] );

# a new family:
BindGlobal( "ModulesFamily",
        NewFamily( "ModulesFamily" ));

# a new type:
BindGlobal( "LeftModuleFinitelyPresentedType",
        NewType( ModulesFamily ,
                IsLeftModule and IsFinitelyPresentedModuleRep ));

#######################
# logical implications:
#######################

## IsTorsionFreeLeftModule:

InstallTrueMethod( IsTorsionFreeLeftModule,
        IsReflexiveLeftModule );

InstallTrueMethod( IsReflexiveLeftModule,
        IsProjectiveLeftModule );

InstallTrueMethod( IsProjectiveLeftModule,
        IsStablyFreeLeftModule );

InstallTrueMethod( IsStablyFreeLeftModule,
        IsFreeModule );

InstallTrueMethod( IsFreeModule,
        IsZeroModule );

## IsTorsionLeftModule:

InstallTrueMethod( IsTorsionLeftModule,
        IsHolonomicLeftModule );

InstallTrueMethod( IsHolonomicLeftModule,
        IsZeroModule );

## IsCyclicLeftModule:

InstallTrueMethod( IsCyclicLeftModule,
        IsZeroModule );


#############################################
# immediate methods for logical implications:
#############################################

## IsTorsionLeftModule:

## IsTorsionFreeLeftModule and not IsZeroModule => not IsTorsionLeftModule
InstallImmediateMethod( IsTorsionLeftModule,
        IsFinitelyPresentedModuleRep and HasIsTorsionFreeLeftModule and HasIsZeroModule, 0,
        
 function( M )
    if IsTorsionFreeLeftModule( M ) and not IsZeroModule( M ) then
        return false;
    else
        TryNextMethod();
    fi;
    
end );

## not IsTorsionLeftModule => not IsHolonomicLeftModule
InstallImmediateMethod( IsHolonomicLeftModule,
        IsFinitelyPresentedModuleRep and HasIsTorsionLeftModule, 0,
        
 function( M )
    if not IsTorsionLeftModule( M ) then
        return false;
    else
        TryNextMethod();
    fi;
    
end );

## not IsHolonomicLeftModule => not IsZeroModule
InstallImmediateMethod( IsZeroModule,
        IsFinitelyPresentedModuleRep and HasIsHolonomicLeftModule, 0,
        
 function( M )
    if not IsHolonomicLeftModule( M ) then
        return false;
    else
        TryNextMethod();
    fi;
    
end );

## IsTorsionFreeLeftModule:

## IsTorsionLeftModule and not IsZeroModule => not IsTorsionFreeLeftModule
InstallImmediateMethod( IsTorsionFreeLeftModule,
        IsFinitelyPresentedModuleRep and HasIsTorsionLeftModule and HasIsZeroModule, 0,
        
 function( M )
    if IsTorsionLeftModule( M ) and not IsZeroModule( M ) then
        return false;
    else
        TryNextMethod();
    fi;
    
end );

## not IsTorsionFreeLeftModule => not IsReflexiveLeftModule
InstallImmediateMethod( IsReflexiveLeftModule,
        IsFinitelyPresentedModuleRep and HasIsTorsionFreeLeftModule, 0,
        
 function( M )
    if not IsTorsionFreeLeftModule( M ) then
        return false;
    else
        TryNextMethod();
    fi;
    
end );

## not IsReflexiveLeftModule => not IsProjectiveLeftModule
InstallImmediateMethod( IsProjectiveLeftModule,
        IsFinitelyPresentedModuleRep and HasIsReflexiveLeftModule, 0,
        
 function( M )
    if not IsReflexiveLeftModule( M ) then
        return false;
    else
        TryNextMethod();
    fi;
    
end );

## not IsProjectiveLeftModule => not IsStablyFreeLeftModule
InstallImmediateMethod( IsStablyFreeLeftModule,
        IsFinitelyPresentedModuleRep and HasIsProjectiveLeftModule, 0,
        
 function( M )
    if not IsProjectiveLeftModule( M ) then
        return false;
    else
        TryNextMethod();
    fi;
    
end );

## not IsStablyFreeLeftModule => not IsFreeModule
InstallImmediateMethod( IsFreeModule,
        IsFinitelyPresentedModuleRep and HasIsStablyFreeLeftModule, 0,
        
 function( M )
    if not IsStablyFreeLeftModule( M ) then
        return false;
    else
        TryNextMethod();
    fi;
    
end );

## not IsFreeModule => not IsZeroModule
InstallImmediateMethod( IsZeroModule,
        IsFinitelyPresentedModuleRep and HasIsFreeModule, 0,
        
 function( M )
    if not IsFreeModule( M ) then
        return false;
    else
        TryNextMethod();
    fi;
    
end );

######################
# constructor methods:
######################

InstallMethod( Presentation,
        "constructor",
        [ IsList, IsSemiringWithOneAndZero ],
        
  function( arg )
    local gen, rel, M, is_zero_module;
    
    is_zero_module := false;
    
    if Length(arg[1]) = 0 then ## since one doesn't specify generators here giving no relations defines the zero module
        gen := rec( 1 := MatrixForHomalg( []) );
        is_zero_module := true;
    elif IsList(arg[1][1]) then ## FIXME: to be replaced with something to distinguish lists of rings elements from elements that are theirself lists
        gen := rec( 1 := MatrixForHomalg( "IdentityMatrix", Length(arg[1][1]) ) );
    else ## only one generator
        gen := rec( 1 := MatrixForHomalg( "IdentityMatrix", 1 ) );
    fi;
    
    rel := CreateSetsOfRelations( arg[1] );
    
    M := rec( SetsOfGenerators := gen, SetsOfRelations := rel );
    
    ## Objectify:
    ObjectifyWithAttributes(
            M, LeftModuleFinitelyPresentedType,
            LeftActingDomain, arg[2],
            GeneratorsOfLeftOperatorAdditiveGroup, M!.SetsOfGenerators!.1,
            NumberOfDefaultSetOfRelations, 1 );
    
    if is_zero_module = true then
        SetIsZeroModule( M, true );
    fi;
    
    return M;
    
end );
  
##
InstallMethod( Presentation,
        "constructor",
        [ IsList, IsList, IsSemiringWithOneAndZero ],
        
  function( arg )
    local gen, rel, M;
    
    gen := rec( 1 := MatrixForHomalg( arg[1] ) );
    
    if arg[2] = [] and arg[1] <> [] then
        rel := CreateSetsOfRelations( "unknown relations" );
    else
        rel := CreateSetsOfRelations( arg[2] );
    fi;
    
    M := rec( SetsOfGenerators := gen, SetsOfRelations := rel );
    
    ## Objectify:
    ObjectifyWithAttributes(
            M, LeftModuleFinitelyPresentedType,
            LeftActingDomain, arg[3],
            GeneratorsOfLeftOperatorAdditiveGroup, M!.SetsOfGenerators!.1,
            NumberOfDefaultSetOfRelations, 1 );
    
    return M;
    
end );

####################
# immediate methods:
####################

# strictly less relations than generators => not IsTorsionLeftModule
InstallImmediateMethod( IsTorsionLeftModule,
        IsFinitelyPresentedModuleRep, 0,
        
  function( M )
    local l, b, i, rel;
    
    l := M!.SetsOfRelations!.ListOfNumbersOfKnownSetsOfRelations;
    
    b := false;
    
    for i in [1..Length(l)] do;
        rel := M!.SetsOfRelations!.(i);
        if not IsString(rel) and HasNrRows(rel) and HasNrColumns(rel)
           and NrColumns(rel) > NrRows(rel) then
            b := true;
            break;
        fi;
    od;
    
    if b then
        SetIsZeroModule( M, false );
        return false;
    else
        TryNextMethod();
    fi;
    
end );

################
# basic methods:
################

##
InstallMethod( GeneratorsOfModule,
        "for homalg modules",
	[ IsFinitelyPresentedModuleRep ],
        
  function( M )
  
    return M!.SetsOfGenerators!.(NumberOfDefaultSetOfGenerators(M));
    
end );

##
InstallMethod( RelationsOfModule,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
  
    return M!.SetsOfRelations!.(NumberOfDefaultSetOfRelations(M));
    
end );

##
InstallMethod( NrGenerators,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
  function( M )
  
    return NrRows(GeneratorsOfModule(M));
    
end );

##
InstallMethod( NrRelations,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
  
    return NrRows(RelationsOfModule(M));
    
end );

##
InstallOtherMethod( BasisOfModule,
        "for sets of relations",
	[ IsObject, IsSemiringWithOneAndZero ],
        
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

##
InstallOtherMethod( CertainRows,
        "for homalg matrices",
        [IsObject, IsList],
        
  function(M, plist)
    
    return M.normal{plist};
    
end );

###################################
# View, Print, and Display methods:
###################################

InstallMethod( ViewObj,
        "for homalg modules",
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
        Print( "A module on ", num_gen, gen_string, num_rel, rel_string );
    fi;
    Print( ">" );
    
end );

##
InstallMethod( PrintObj,
        "for homalg modules",
        [IsLeftModule and IsFinitelyPresentedModuleRep],
        
  function( M )
    
    Print( "Presentation( " );
    if HasIsZeroModule(M) and IsZeroModule(M) then
        Print( "[], ", LeftActingDomain(M) ); ## no generators, empty relations, ring
    else
        Print( GeneratorsOfModule(M), ", " );
        if RelationsOfModule(M) = "unknown relations" then
            Print( "[], " ) ; ## empty relations
        else
            Print( RelationsOfModule(M), ", " );
        fi;
        Print( LeftActingDomain(M) );
    fi;
    Print(" )");
    
end );

