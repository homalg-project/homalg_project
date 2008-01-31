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
    
    if Length( property ) = 3 then
        
        ## a => b:
        InstallTrueMethod( property[3],
                property[1] );
        
        ## not b => not a:
        InstallImmediateMethod( property[1],
                IsModuleForHomalg and Tester( property[3] ), 0, ## NOTE: don't drop the Tester here!
                
          function( M )
            if Tester( property[3] )( M ) and not property[3]( M ) then  ## FIXME: find a way to get rid of Tester here
                return false;
            fi;
            
            TryNextMethod( );
            
        end );
        
    elif Length( property ) = 5 then
        
        ## a and b => c:
        InstallTrueMethod( property[5],
                property[1] and property[3] );
        
        ## b and not c => not a:
        InstallImmediateMethod( property[1],
                IsModuleForHomalg and Tester( property[3] ) and Tester( property[5] ), 0, ## NOTE: don't drop the Testers here!
                
          function( M )
            if Tester( property[3] )( M ) and Tester( property[5] )( M )  ## FIXME: find a way to get rid of the Testers here
               and property[3]( M ) and not property[5]( M ) then
                return false;
            fi;
            
            TryNextMethod( );
            
        end );
        
        ## a and not c => not b:
        InstallImmediateMethod( property[3],
                IsModuleForHomalg and Tester( property[1] ) and Tester( property[5] ), 0, ## NOTE: don't drop the Testers here!
                
          function( M )
            if Tester( property[1] )( M ) and Tester( property[5] )( M ) ## FIXME: find a way to get rid of the Testers here
               and property[1]( M ) and not property[5]( M ) then
                return false;
            fi;
            
            TryNextMethod( );
            
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
    
    l := SetsOfRelations( M )!.ListOfPositionsOfKnownSetsOfRelations;
    
    b := false;
    
    for i in [ 1.. Length( l ) ] do;
        
        rel := SetsOfRelations( M )!.(i);
        
        if not IsString( rel ) then
	    mat := MatrixOfRelations( rel );
     
            if HasNrRows( mat ) and HasNrColumns( mat )
              and NrColumns( mat ) > NrRows( mat ) then
                b := true;
                break;
            fi;
        fi;
        
    od;
    
    if b then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( HomalgRing,
        "for homalg modules",
	[ IsFinitelyPresentedModuleRep and IsLeftModule ],
        
  function( M )
    
    return LeftActingDomain( M );
    
end );

##
InstallMethod( HomalgRing,
        "for homalg modules",
	[ IsFinitelyPresentedModuleRep and IsRightModule ],
        
  function( M )
    
    return RightActingDomain( M );
    
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
InstallMethod( GeneratorsOfModule,
        "for homalg modules",
	[ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    if IsBound(SetsOfGenerators(M)!.(PositionOfTheDefaultSetOfGenerators( M ))) then
        return SetsOfGenerators(M)!.(PositionOfTheDefaultSetOfGenerators( M ));
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
InstallMethod( MatrixOfGenerators,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
  function( M )
    
    return MatrixOfGenerators( GeneratorsOfModule( M ) );
    
end );

##
InstallMethod( MatrixOfRelations,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return MatrixOfRelations( RelationsOfModule( M ) );
    
end );

##
InstallMethod( NrGenerators,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
  function( M )
    
    return NrGenerators( GeneratorsOfModule( M ) );
    
end );

##
InstallMethod( NrRelations,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return NrRelations( RelationsOfModule( M ) );
    
end );

##
InstallMethod( AddANewPresentation,
        "for homalg modules",
	[ IsFinitelyPresentedModuleRep, IsGeneratorsForHomalg ],
        
  function( M, gen )
    local gens, rels, l;
    
    gens := SetsOfGenerators( M );
    rels := SetsOfRelations( M );
    
    l := PositionOfLastStoredSet( rels );
    
    ## define the (l+1)st set of generators
    gens!.(l+1) := gen;
    
    ## adjust the list of positions:
    gens!.ListOfPositionsOfKnownSetsOfGenerators[l+1] := l+1;
    
    ## define the (l+1)st set of relations
    rels!.(l+1) := rels!.(l);
    
    ## adjust the list of positions:
    rels!.ListOfPositionsOfKnownSetsOfRelations[l+1] := l+1;
    
        ## adjust the default position:
    M!.PositionOfTheDefaultSetOfRelations := l+1;
    
end );

##
InstallMethod( AddANewPresentation,
        "for homalg modules",
	[ IsFinitelyPresentedModuleRep, IsRelationsForHomalg ],
        
  function( M, rel )
    local gens, rels, l;
    
    gens := SetsOfGenerators( M );
    rels := SetsOfRelations( M );
    
    l := PositionOfLastStoredSet( rels );
    
    ## define the (l+1)st set of generators
    gens!.(l+1) := gens!.(l);
    
    ## adjust the list of positions:
    gens!.ListOfPositionsOfKnownSetsOfGenerators[l+1] := l+1;
    
    ## define the (l+1)st set of relations
    rels!.(l+1) := rel;
    
    ## adjust the list of positions:
    rels!.ListOfPositionsOfKnownSetsOfRelations[l+1] := l+1;
    
        ## adjust the default position:
    M!.PositionOfTheDefaultSetOfRelations := l+1;
    
end );

##
InstallMethod( BasisOfModule,
        "for homalg modules",
	[ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local rel;
    
    rel := RelationsOfModule( M );
    
    if not ( HasCanBeUsedToEffectivelyDecideZero( rel ) and CanBeUsedToEffectivelyDecideZero( rel ) ) then
        
        rel := BasisOfModule( rel );
        
        AddANewPresentation( M, rel );
        
    fi;
    
    return rel;
    
end );

##
InstallMethod( DecideZero,
        "for homalg modules",
	[ IsMatrixForHomalg, IsFinitelyPresentedModuleRep ],
        
  function( mat, M )
    local rel;
    
    rel := RelationsOfModule( M );
    
    return DecideZero( mat, rel ) ;
    
end );

##
InstallMethod( BasisCoeff,
        "for homalg modules",
	[ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local rel;
    
    rel := RelationsOfModule( M );
    
    if not ( HasCanBeUsedToEffectivelyDecideZero( rel ) and CanBeUsedToEffectivelyDecideZero( rel ) ) then
        
        rel := BasisCoeff( RelationsOfModule( M ) ) ;
        
        AddANewPresentation( M, rel );
        
    fi;
    
    return rel;
    
end );

##
InstallMethod( EffectivelyDecideZero,
        "for homalg modules",
	[ IsMatrixForHomalg, IsFinitelyPresentedModuleRep ],
        
  function( mat, M )
    local rel;
    
    rel := RelationsOfModule( M );
    
    return EffectivelyDecideZero( mat, rel ) ;
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for homalg modules",
	[ IsFinitelyPresentedModuleRep, IsFinitelyPresentedModuleRep ],
        
  function( M1, M2 )
    
    return SyzygiesGenerators( RelationsOfModule( M1 ), RelationsOfModule( M2 ) ) ;
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for homalg modules",
	[ IsFinitelyPresentedModuleRep, IsList and IsEmpty ],
        
  function( M1, M2 )
    
    return SyzygiesGenerators( RelationsOfModule( M1 ), [ ] ) ;
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallMethod( Presentation,
        "constructor",
        [ IsLeftRelationsForHomalgRep ],
        
  function( rel )
    local R, is_zero_module, gens, rels, M;
    
    R := HomalgRing( rel );
    
    is_zero_module := false;
    
    if NrGenerators( rel ) = 0 then ## since one doesn't specify generators here giving no relations defines the zero module
        gens := CreateSetsOfGeneratorsForLeftModule( [], R );
        is_zero_module := true;
    else
        gens := CreateSetsOfGeneratorsForLeftModule( MatrixForHomalg( "IdentityMatrix", NrGenerators( rel ), R ), R );
    fi;
    
    rels := CreateSetsOfRelationsForLeftModule( rel );
    
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
    
#    SetParent( gens, M );
#    SetParent( rels, M );
    
    return M;
    
end );
  
##
InstallMethod( Presentation,
        "constructor",
        [ IsRightRelationsForHomalgRep ],
        
  function( rel )
    local R, is_zero_module, gens, rels, M;
    
    R := HomalgRing( rel );
    
    is_zero_module := false;
    
    if NrGenerators( rel ) = 0 then ## since one doesn't specify generators here giving no relations defines the zero module
        gens := CreateSetsOfGeneratorsForRightModule( [], R );
        is_zero_module := true;
    else
        gens := CreateSetsOfGeneratorsForRightModule( MatrixForHomalg( "IdentityMatrix", NrGenerators( rel ), R ), R );
    fi;
    
    rels := CreateSetsOfRelationsForRightModule( rel );
    
    M := rec( SetsOfGenerators := gens,
              SetsOfRelations := rels,
              PositionOfTheDefaultSetOfRelations := 1 );
    
    ## Objectify:
    ObjectifyWithAttributes(
            M, RightModuleFinitelyPresentedType,
            RightActingDomain, R,
            GeneratorsOfRightOperatorAdditiveGroup, M!.SetsOfGenerators!.1 );
    
    if is_zero_module = true then
        SetIsZeroModule( M, true );
    fi;
    
#    SetParent( gens, M );
#    SetParent( rels, M );
    
    return M;
    
end );
  
##
InstallMethod( LeftPresentation,
        "constructor",
        [ IsList, IsSemiringWithOneAndZero ],
        
  function( rel, ring )
    local R, gens, rels, M, is_zero_module;
    
    R := RingForHomalg( ring, CreateHomalgTable( ring ) );
    
    is_zero_module := false;
    
    if Length( rel ) = 0 then ## since one doesn't specify generators here giving no relations defines the zero module
        gens := CreateSetsOfGeneratorsForLeftModule( [], R );
        is_zero_module := true;
    elif IsList( rel[1] ) then ## FIXME: to be replaced with something to distinguish lists of rings elements from elements that are theirself lists
        gens := CreateSetsOfGeneratorsForLeftModule( MatrixForHomalg( "IdentityMatrix", Length( rel[1] ), R ), R );  ## FIXME: Length( rel[1] )
    else ## only one generator
        gens := CreateSetsOfGeneratorsForLeftModule( MatrixForHomalg( "IdentityMatrix", 1, R ), R );
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
    
#    SetParent( gens, M );
#    SetParent( rels, M );
    
    return M;
    
end );
  
##
InstallMethod( LeftPresentation,
        "constructor",
        [ IsList, IsList, IsSemiringWithOneAndZero ],
        
  function( gen, rel, ring )
    local R, gens, rels, M;
    
    R := RingForHomalg( ring, CreateHomalgTable( ring ) );
    
    gens := CreateSetsOfGeneratorsForLeftModule( gen, R );
    
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
    
#    SetParent( gens, M );
#    SetParent( rels, M );
    
    return M;
    
end );

##
InstallMethod( RightPresentation,
        "constructor",
        [ IsList, IsSemiringWithOneAndZero ],
        
  function( rel, ring )
    local R, gens, rels, M, is_zero_module;
    
    R := RingForHomalg( ring, CreateHomalgTable( ring ) );
    
    is_zero_module := false;
    
    if Length( rel ) = 0 then ## since one doesn't specify generators here giving no relations defines the zero module
        gens := CreateSetsOfGeneratorsForRightModule( [], R );
        is_zero_module := true;
    elif IsList( rel[1] ) then ## FIXME: to be replaced with something to distinguish lists of rings elements from elements that are theirself lists
        gens := CreateSetsOfGeneratorsForRightModule( MatrixForHomalg( "IdentityMatrix", Length( rel ), R ), R ); ## FIXME: Length( rel )
    else ## only one generator
        gens := CreateSetsOfGeneratorsForRightModule( MatrixForHomalg( "IdentityMatrix", 1, R ), R );
    fi;
    
    rels := CreateSetsOfRelationsForRightModule( rel, R );
    
    M := rec( SetsOfGenerators := gens,
              SetsOfRelations := rels,
              PositionOfTheDefaultSetOfRelations := 1 );
    
    ## Objectify:
    ObjectifyWithAttributes(
            M, RightModuleFinitelyPresentedType,
            RightActingDomain, R,
            GeneratorsOfRightOperatorAdditiveGroup, M!.SetsOfGenerators!.1 );
    
    if is_zero_module = true then
        SetIsZeroModule( M, true );
    fi;
    
#    SetParent( gens, M );
#    SetParent( rels, M );
    
    return M;
    
end );
  
##
InstallMethod( RightPresentation,
        "constructor",
        [ IsList, IsList, IsSemiringWithOneAndZero ],
        
  function( gen, rel, ring )
    local R, gens, rels, M;
    
    R := RingForHomalg( ring, CreateHomalgTable( ring ) );
    
    gens := CreateSetsOfGeneratorsForRightModule( gen, R );
    
    if rel = [] and gen <> [] then
        rels := CreateSetsOfRelationsForRightModule( "unknown relations", R );
    else
        rels := CreateSetsOfRelationsForRightModule( rel, R );
    fi;
    
    M := rec( SetsOfGenerators := gens,
              SetsOfRelations := rels,
              PositionOfTheDefaultSetOfRelations := 1 );
    
    ## Objectify:
    ObjectifyWithAttributes(
            M, RightModuleFinitelyPresentedType,
            RightActingDomain, R,
            GeneratorsOfRightOperatorAdditiveGroup, M!.SetsOfGenerators!.1 );
    
#    SetParent( gens, M );
#    SetParent( rels, M );
    
    return M;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( ViewObj,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep and IsLeftModule ],
        
  function( M )
    local num_gen, num_rel, gen_string, rel_string;
    
    Print( "<" );
    if HasIsZeroModule( M ) and IsZeroModule( M ) then
        Print( "The zero left module" ); ## FIXME: the zero module should be universal
    else
        num_gen := NrGenerators( M );
        if num_gen = 1 then
            gen_string := " generator and ";
        else
            gen_string := " generators and ";
        fi;
        if RelationsOfModule( M ) = "unknown relations" then
            num_rel := "unknown";
            rel_string := " relations";
        else
            num_rel := NrRelations( M );
            if num_rel = 0 then
	        num_rel := "";
                rel_string := "no relations";
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

InstallMethod( ViewObj,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep and IsRightModule ],
        
  function( M )
    local num_gen, num_rel, gen_string, rel_string;
    
    Print( "<" );
    if HasIsZeroModule( M ) and IsZeroModule( M ) then
        Print( "The zero right module" ); ## FIXME: the zero module should be universal
    else
        num_gen := NrGenerators( M );
        if num_gen = 1 then
            gen_string := " generator and ";
        else
            gen_string := " generators and ";
        fi;
        if RelationsOfModule( M ) = "unknown relations" then
            num_rel := "unknown";
            rel_string := " relations";
        else
            num_rel := NrRelations( M );
            if num_rel = 0 then
	        num_rel := "";
                rel_string := " no relations";
            elif num_rel = 1 then
                rel_string := " relation";
            else
                rel_string := " relations";
            fi;
        fi;
        Print( "A right module on ", num_gen, gen_string, num_rel, rel_string );
    fi;
    Print( ">" );
    
end );

##
InstallMethod( PrintObj,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep and IsLeftModule ],
        
  function( M )
    
    Print( "LeftPresentation( " );
    if HasIsZeroModule( M ) and IsZeroModule( M ) then
        Print( "[], ", LeftActingDomain( M ) ); ## no generators, empty relations, ring
    else
        Print( GeneratorsOfModule( M ), ", " );
        if RelationsOfModule( M ) = "unknown relations" then
            Print( "[], " ) ; ## empty relations
        else
            Print( RelationsOfModule( M ), ", " );
        fi;
        Print( LeftActingDomain( M ), " " );
    fi;
    Print( ")" );
    
end );

##
InstallMethod( PrintObj,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep and IsRightModule ],
        
  function( M )
    
    Print( "RightPresentation( " );
    if HasIsZeroModule( M ) and IsZeroModule( M ) then
        Print( "[], ", RightActingDomain( M ) ); ## no generators, empty relations, ring
    else
        Print( GeneratorsOfModule( M ), ", " );
        if RelationsOfModule( M ) = "unknown relations" then
            Print( "[], " ) ; ## empty relations
        else
            Print( RelationsOfModule( M ), ", " );
        fi;
        Print( RightActingDomain( M ), " " );
    fi;
    Print( ")" );
    
end );

