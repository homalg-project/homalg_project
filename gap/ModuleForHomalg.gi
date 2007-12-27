#############################################################################
##
##  ModuleForHomalg.gi          homalg package               Mohamed Barakat
##
##  Copyright 2007 Lehrstuhl B für Mathematik, RWTH Aachen
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

# a new type:
BindGlobal( "LeftModuleFinitelyPresentedType",
        NewType( ModulesFamily ,
                IsLeftModule and IsFinitelyPresentedModuleRep ));

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
        
        InstallTrueMethod( property[3],
                property[1] );
        
        InstallImmediateMethod( property[1],
                IsModuleForHomalg, 0, ## FIXME: find a way to put Tester(property[3]) here
                
          function( M )
            if Tester(property[3])( M ) and not property[3]( M ) then
                return false;
            else
                TryNextMethod();
            fi;
            
        end );
        
    elif Length(property) = 5 then
        
        InstallTrueMethod( property[5],
                property[1] and property[3] );
        
        InstallImmediateMethod( property[1],
                IsModuleForHomalg, 0, ## FIXME: find a way to put Tester(property[3]) and Tester(property[5]) here
                
          function( M )
            if Tester(property[3])( M ) and Tester(property[5])( M )
               and property[3]( M ) and not property[5]( M ) then
                return false;
            else
                TryNextMethod();
            fi;
            
        end );
        
        InstallImmediateMethod( property[3],
                IsModuleForHomalg, 0, ## FIXME: find a way to put Tester(property[1]) and Tester(property[5]) here
                
          function( M )
            if Tester(property[1])( M ) and Tester(property[5])( M )
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

####################################
#
# methods for operations:
#
####################################

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
InstallOtherMethod( RankOfGauss,
        "for sets of relations",
	[ IsObject ],
        
  function( M )
    
    return M.rank;
    
end );

##
InstallOtherMethod( BasisOfModule,
        "for a homalg module",
	[ IsLeftModule and IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return BasisOfModule(RelationsOfModule(M),LeftActingDomain(M));
    
end );
          
##
InstallOtherMethod( BasisOfModule,
        "for sets of relations",
	[ IsObject, IsRingForHomalg ],
        
  function( _M, R )
    local RP, ring_rel, M, B, rank;
    
    RP := R!.HomalgTable;
  
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
        [ IsObject, IsList ],
        
  function(M, plist)
    
    return M.normal{plist};
    
end );

####################################
#
# constructor functions and methods:
#
####################################

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
            LeftActingDomain, CreateRingForHomalg(arg[2],CreateHomalgTable(arg[2])),
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
            LeftActingDomain, CreateRingForHomalg(arg[3],CreateHomalgTable(arg[3])),
            GeneratorsOfLeftOperatorAdditiveGroup, M!.SetsOfGenerators!.1,
            NumberOfDefaultSetOfRelations, 1 );
    
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

