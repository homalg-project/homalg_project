# SPDX-License-Identifier: GPL-2.0-or-later
# Modules: A homalg based package for the Abelian category of finitely presented modules over computable rings
#
# Implementations
#

##  Implementation stuff for a set of relations.

##  <#GAPDoc Label="Relations:intro">
##  A finite presentation of a module is given by a finite set of generators and a finite set of relations
##  among these generators. In &homalg; a set of relations of a left/right module is given by a matrix <A>rel</A>,
##  the rows/columns of which are interpreted as relations among <M>n</M> generators, <M>n</M> being the number
##  of columns/rows of the matrix <A>rel</A>.
##  <P/>
##  The data structure of a module in &homalg; is designed to contain not only one but several sets of relations
##  (together with corresponding sets of generators (&see; Chapter <Ref Chap="Generators"/>)).
##  The different sets of relations are linked with so-called transition matrices (&see; Chapter <Ref Chap="Modules"/>).
##  <P/>
##  The relations of a &homalg; module are evaluated in a lazy way. This avoids unnecessary computations.
##  <#/GAPDoc>

####################################
#
# representations:
#
####################################

##  <#GAPDoc Label="IsRelationsOfFinitelyPresentedModuleRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="rel" Name="IsRelationsOfFinitelyPresentedModuleRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; representation of a finite set of relations of a finitely presented &homalg; module. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgRelations"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsRelationsOfFinitelyPresentedModuleRep",
        IsHomalgRelations,
        [ ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfHomalgRelations",
        NewFamily( "TheFamilyOfHomalgRelations" ) );

# two new types:
BindGlobal( "TheTypeHomalgRelationsOfLeftModule",
        NewType(  TheFamilyOfHomalgRelations,
                IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule ) );

BindGlobal( "TheTypeHomalgRelationsOfRightModule",
        NewType(  TheFamilyOfHomalgRelations,
                IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule ) );

####################################
#
# immediate methods for properties:
#
####################################

## a non trivial set of relations for a single generator over a domain => IsTorsion
InstallImmediateMethod( IsTorsion,
        IsHomalgRelations and HasEvaluatedMatrixOfRelations, 0,
        
  function( rel )
    local torsion, R;
    
    if HasNrGenerators( rel ) and NrGenerators( rel ) = 1 and
       HasIsZero( MatrixOfRelations( rel ) ) then
        
        R := HomalgRing( rel );
        
        if HasIsIntegralDomain( R ) and IsIntegralDomain( R ) then
            
            torsion := not IsZero( MatrixOfRelations( rel ) );
            
            ## this is the true reason for this immediate method
            if HasParent( rel ) then
                SetIsTorsion( Parent( rel ), torsion );
            fi;
            
            return torsion;
            
        fi;
    fi;
    
    TryNextMethod( );
    
end );

## strictly less relations than generators => not IsTorsion
InstallImmediateMethod( IsTorsion,
        IsHomalgRelations and HasEvaluatedMatrixOfRelations, 0,
        
  function( rel )
    
    if HasNrGenerators( rel ) and HasNrRelations( rel ) and
       NrGenerators( rel ) > NrRelations( rel ) then
        
        ## this is the true reason for this immediate method
        if HasParent( rel ) then
            SetIsTorsion( Parent( rel ), false );
        fi;
        
        return false;
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# immediate methods for attributes:
#
####################################

##
InstallImmediateMethod( NrRelationsForRelations,
        IsHomalgRelationsOfRightModule and HasEvaluatedMatrixOfRelations, 0,
        
  rel -> NumberColumns( MatrixOfRelations( rel ) ) );

##
InstallImmediateMethod( NrRelationsForRelations,
        IsHomalgRelationsOfLeftModule and HasEvaluatedMatrixOfRelations, 0,
        
  rel -> NumberRows( MatrixOfRelations( rel ) ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( EvaluatedMatrixOfRelations,
        "for sets of relations of homalg modules",
        [ IsHomalgRelations and HasEvalMatrixOfRelations ],
        
  function( rel )
    local func_arg;
    
    func_arg := EvalMatrixOfRelations( rel );
    
    ResetFilterObj( rel, HasEvalMatrixOfRelations );
    
    ## delete the component which was left over by GAP
    Unbind( rel!.EvalMatrixOfRelations );
    
    return CallFuncList( func_arg[1], func_arg[2] );
    
end );

##
InstallMethod( MatrixOfRelations,
        "for sets of relations of homalg modules",
        [ IsHomalgRelations ],
        
  function( rel )
    
    return EvaluatedMatrixOfRelations( rel );
    
end );

##
InstallMethod( \=,
        "for homalg relations",
        [ IsHomalgRelationsOfRightModule, IsHomalgRelationsOfRightModule ],
        
  function( rel1, rel2 )
    
    return MatrixOfRelations( rel1 ) = MatrixOfRelations( rel2 );
    
end );

##
InstallMethod( \=,
        "for homalg relations",
        [ IsHomalgRelationsOfLeftModule, IsHomalgRelationsOfLeftModule ],
        
  function( rel1, rel2 )
    
    return MatrixOfRelations( rel1 ) = MatrixOfRelations( rel2 );
    
end );

##
InstallMethod( HomalgRing,
        "for sets of relations of homalg modules",
        [ IsHomalgRelations ],
        
  function( rel )
    
    return HomalgRing( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( HomalgRing,
        "for sets of relations of homalg modules",
        [ IsHomalgRelations and HasEvalMatrixOfRelations ],
        
  function( rel )
    
    return HomalgRing( EvalMatrixOfRelations( rel )[2][1] );
    
end );

##
InstallMethod( HasNrGenerators,
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfRightModule ],
        
  function( rel )
    
    return HasNumberRows( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( HasNrGenerators,
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfRightModule and HasEvalMatrixOfRelations ],
        
  function( rel )
    local func_arg, ar;
    
    func_arg := EvalMatrixOfRelations( rel );
    
    if IsIdenticalObj( func_arg[1], SyzygiesGeneratorsOfColumns ) then
        ar := func_arg[2];
        if IsList( ar ) and Length( ar ) = 2 then
            return HasNumberColumns( ar[1] );
        fi;
    elif IsIdenticalObj( func_arg[1], \^ ) then
        ar := func_arg[2];
        if IsList( ar ) and Length( ar ) = 2 then
            return HasNumberRows( ar[2] );
        fi;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( HasNrGenerators,
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfLeftModule ],
        
  function( rel )
    
    return HasNumberColumns( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( HasNrGenerators,
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfLeftModule and HasEvalMatrixOfRelations ],
        
  function( rel )
    local func_arg, ar;
    
    func_arg := EvalMatrixOfRelations( rel );
    
    if IsIdenticalObj( func_arg[1], SyzygiesGeneratorsOfRows ) then
        ar := func_arg[2];
        if IsList( ar ) and Length( ar ) = 2 then
            return HasNumberRows( ar[1] );
        fi;
    elif IsIdenticalObj( func_arg[1], \^ ) then
        ar := func_arg[2];
        if IsList( ar ) and Length( ar ) = 2 then
            return HasNumberColumns( ar[2] );
        fi;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( NrGeneratorsForRelations, ### defines: NrGenerators (NumberOfGenerators)
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfRightModule ],
        
  function( rel )
    
    return NumberRows( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( NrGeneratorsForRelations,
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfRightModule and HasEvalMatrixOfRelations ],
        
  function( rel )
    local func_arg, ar;
    
    func_arg := EvalMatrixOfRelations( rel );
    
    if IsIdenticalObj( func_arg[1], SyzygiesGeneratorsOfColumns ) then
        ar := func_arg[2];
        if IsList( ar ) and Length( ar ) = 2 then
            return NumberColumns( ar[1] );
        fi;
    elif IsIdenticalObj( func_arg[1], \^ ) then
        ar := func_arg[2];
        if IsList( ar ) and Length( ar ) = 2 then
            return NumberRows( ar[2] );
        fi;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( NrGeneratorsForRelations, ### defines: NrGenerators (NumberOfGenerators)
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfLeftModule ],
        
  function( rel )
    
    return NumberColumns( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( NrGeneratorsForRelations,
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfLeftModule and HasEvalMatrixOfRelations ],
        
  function( rel )
    local func_arg, ar;
    
    func_arg := EvalMatrixOfRelations( rel );
    
    if IsIdenticalObj( func_arg[1], SyzygiesGeneratorsOfRows ) then
        ar := func_arg[2];
        if IsList( ar ) and Length( ar ) = 2 then
            return NumberRows( ar[1] );
        fi;
    elif IsIdenticalObj( func_arg[1], \^ ) then
        ar := func_arg[2];
        if IsList( ar ) and Length( ar ) = 2 then
            return NumberColumns( ar[2] );
        fi;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( NrGenerators,
        "for sets of relations of homalg modules",
        [ IsHomalgRelations ],
        
  NrGeneratorsForRelations );

##
InstallMethod( HasNrRelations,
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfRightModule ],
        
  function( rel )
    
    if HasEvaluatedMatrixOfRelations( rel ) then
        return HasNumberColumns( MatrixOfRelations( rel ) );
    fi;
    
    return false;
    
end );

##
InstallMethod( HasNrRelations,
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfLeftModule ],
        
  function( rel )
    
    if HasEvaluatedMatrixOfRelations( rel ) then
        return HasNumberRows( MatrixOfRelations( rel ) );
    fi;
    
    return false;
    
end );

##
InstallMethod( NrRelationsForRelations, ### defines: NrRelations (NumberOfColumns)
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfRightModule ],
        
  function( rel )
    
    return NumberColumns( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( NrRelationsForRelations, ### defines: NrRelations (NumberOfRows)
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfLeftModule ],
        
  function( rel )
    
    return NumberRows( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( NrRelations,
        "for sets of relations of homalg modules",
        [ IsHomalgRelations ],
        
  NrRelationsForRelations );

##
InstallMethod( CertainRelations, ### defines: CertainRelations
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfRightModule, IsList ],
        
  function( rel, plist )
    local sub_rel;
    
    sub_rel := CertainColumns( MatrixOfRelations( rel ), plist );
    
    return HomalgRelationsForRightModule( sub_rel );
    
end );

##
InstallMethod( CertainRelations, ### defines: CertainRelations
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfLeftModule, IsList ],
        
  function( rel, plist )
    local sub_rel;
    
    sub_rel := CertainRows( MatrixOfRelations( rel ), plist );
    
    return HomalgRelationsForLeftModule( sub_rel );
    
end );

##
InstallMethod( UnionOfRelations, ### defines: UnionOfRelations (SumRelations)
        "for sets of relations of homalg modules",
        [ IsHomalgMatrix, IsHomalgRelationsOfRightModule ],
        
  function( mat1, rel2 )
    local rel;
    
    rel := UnionOfColumns( mat1, MatrixOfRelations( rel2 ) );
    
    rel := HomalgRelationsForRightModule( rel );
    
    return rel;
    
end );

##
InstallMethod( UnionOfRelations,
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfRightModule, IsHomalgMatrix ],
        
  function( rel1, mat2 )
    
    return UnionOfRelations( mat2, rel1 );
    
end );

##
InstallMethod( UnionOfRelations,
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfRightModule, IsHomalgRelationsOfRightModule ],
        
  function( rel1, rel2 )
    
    return UnionOfRelations( MatrixOfRelations( rel1 ), rel2 );
    
end );

##
InstallMethod( UnionOfRelations, ### defines: UnionOfRelations (SumRelations)
        "for sets of relations of homalg modules",
        [ IsHomalgMatrix, IsHomalgRelationsOfLeftModule ],
        
  function( mat1, rel2 )
    local rel;
    
    rel := UnionOfRows( mat1, MatrixOfRelations( rel2 ) );
    
    rel := HomalgRelationsForLeftModule( rel );
    
    return rel;
    
end );

##
InstallMethod( UnionOfRelations,
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfLeftModule, IsHomalgMatrix ],
        
  function( rel1, mat2 )
    
    return UnionOfRelations( mat2, rel1 );
    
end );

##
InstallMethod( UnionOfRelations,
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfLeftModule, IsHomalgRelationsOfLeftModule ],
        
  function( rel1, rel2 )
    
    return UnionOfRelations( MatrixOfRelations( rel1 ), rel2 );
    
end );

##
InstallMethod( BasisOfModule,
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfRightModule ],
        
  function( rel )
    local mat, bas, inj, M, rk;
    
    if not IsBound( rel!.BasisOfModule ) then
        mat := MatrixOfRelations( rel );
        
        bas := BasisOfColumns( mat );
        
        inj := HasIsRightRegular( bas ) and IsRightRegular( bas );
        
        if bas = mat then
            SetCanBeUsedToDecideZeroEffectively( rel, true );
            rel!.EvaluatedMatrixOfRelations := bas; ## when computing over finite fields in Maple taking a basis normalizes the entries
            if inj then
                SetIsInjectivePresentation( rel, true );
            fi;
            return rel;
        else
            rel!.BasisOfModule := bas;
            SetCanBeUsedToDecideZeroEffectively( rel, false );
        fi;
    else
        bas := rel!.BasisOfModule;
        inj := HasIsRightRegular( bas ) and IsRightRegular( bas );
    fi;
    
    bas := HomalgRelationsForRightModule( bas );
    
    if inj then
        SetIsInjectivePresentation( bas, true );
    fi;
    
    SetCanBeUsedToDecideZeroEffectively( bas, true );
    
    return bas;
end );

##
InstallMethod( BasisOfModule,
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfLeftModule ],
        
  function( rel )
    local mat, bas, inj, M, rk;
    
    if not IsBound( rel!.BasisOfModule ) then
        mat := MatrixOfRelations( rel );
        
        bas := BasisOfRows( mat );
        
        inj := HasIsLeftRegular( bas ) and IsLeftRegular( bas );
        
        if bas = mat then
            SetCanBeUsedToDecideZeroEffectively( rel, true );
            rel!.EvaluatedMatrixOfRelations := bas; ## when computing over finite fields in Maple taking a basis normalizes the entries
            if inj then
                SetIsInjectivePresentation( rel, true );
            fi;
            return rel;
        else
            rel!.BasisOfModule := bas;
            SetCanBeUsedToDecideZeroEffectively( rel, false );
        fi;
    else
        bas := rel!.BasisOfModule;
        inj := HasIsLeftRegular( bas ) and IsLeftRegular( bas );
    fi;
    
    bas := HomalgRelationsForLeftModule( bas );
    
    if inj then
        SetIsInjectivePresentation( bas, true );
    fi;
    
    SetCanBeUsedToDecideZeroEffectively( bas, true );
    
    return bas;
end );

##
InstallMethod( BasisOfModule,
        "for sets of relations of homalg modules",
        [ IsHomalgRelations and CanBeUsedToDecideZeroEffectively ],
        
  function( rel )
    
    return rel;
    
end );

##  <#GAPDoc Label="DecideZero:matrix_rel">
##  <ManSection>
##    <Oper Arg="mat, rel" Name="DecideZero" Label="for matrices and relations"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##    <Listing Type="Code"><![CDATA[
InstallMethod( DecideZero,
        "for sets of relations of homalg modules",
        [ IsHomalgMatrix, IsHomalgRelations ],
        
  function( mat, relations )
    local rel, red;
    
    rel := MatrixOfRelations( BasisOfModule( relations ) );
    
    if IsHomalgRelationsOfLeftModule( relations ) then
        red := DecideZeroRows( mat, rel );
    else
        red := DecideZeroColumns( mat, rel );
    fi;
    
    return DecideZero( red );
    
end );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##

##
InstallMethod( DecideZero,
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfRightModule, IsHomalgRelationsOfRightModule ],
        
  function( rel_, rel )
    
    return HomalgRelationsForRightModule( DecideZero( MatrixOfRelations( rel_ ), rel ) );
    
end );

##
InstallMethod( DecideZero,
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfLeftModule, IsHomalgRelationsOfLeftModule ],
        
  function( rel_, rel )
    
    return HomalgRelationsForLeftModule( DecideZero( MatrixOfRelations( rel_ ), rel ) );
    
end );

##
InstallMethod( BasisCoeff,
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfRightModule ],
        
  function( rel )
    local bas;
    
    if not IsBound( rel!.BasisOfModule ) then
        rel!.BasisOfModule := BasisOfColumnsCoeff( MatrixOfRelations( rel ) );
        SetCanBeUsedToDecideZeroEffectively( rel, false );
    fi;
    
    bas := HomalgRelationsForRightModule( rel!.BasisOfModule, HomalgRing( rel ) );
    
    SetCanBeUsedToDecideZeroEffectively( bas, true );
    
    return bas;
    
end );

##
InstallMethod( BasisCoeff,
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfLeftModule ],
        
  function( rel )
    local bas;
    
    if not IsBound( rel!.BasisOfModule ) then
        rel!.BasisOfModule := BasisOfRowsCoeff( MatrixOfRelations( rel ) );
        SetCanBeUsedToDecideZeroEffectively( rel, false );
    fi;
    
    bas := HomalgRelationsForLeftModule( rel!.BasisOfModule, HomalgRing( rel ) );
    
    SetCanBeUsedToDecideZeroEffectively( bas, true );
    
    return bas;
    
end );

##
InstallMethod( RightDivide,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix, IsHomalgRelationsOfLeftModule ],
        
  function( B, A, L )
    local BL;
    
    BL := BasisOfModule( L );
    
    return RightDivide( B, A, MatrixOfRelations( BL ) );
    
end );

##
InstallMethod( LeftDivide,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix, IsHomalgRelationsOfRightModule ],
        
  function( A, B, L )
    local BL;
    
    BL := BasisOfModule( L );
    
    return LeftDivide( A, B, MatrixOfRelations( BL ) );
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfRightModule ],
        
  function( rel )
    
    return HomalgRelationsForRightModule( SyzygiesOfColumns( MatrixOfRelations( rel ) ) );
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for sets of relations of homalg modules",
        [ IsHomalgMatrix, IsHomalgRelationsOfRightModule ],
        
  function( mat, rel )
    
    return HomalgRelationsForRightModule( SyzygiesOfColumns( mat, MatrixOfRelations( rel ) ) );
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfLeftModule ],
        
  function( rel )
    
    return HomalgRelationsForLeftModule( SyzygiesOfRows( MatrixOfRelations( rel ) ) );
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for sets of relations of homalg modules",
        [ IsHomalgMatrix, IsHomalgRelationsOfLeftModule ],
        
  function( mat, rel )
    
    return HomalgRelationsForLeftModule( SyzygiesOfRows( mat, MatrixOfRelations( rel ) ) );
    
end );

##
InstallMethod( ReducedSyzygiesGenerators,
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfRightModule ],
        
  function( rel )
    
    return HomalgRelationsForRightModule( ReducedSyzygiesOfColumns( MatrixOfRelations( rel ) ) );
    
end );

##
InstallMethod( ReducedSyzygiesGenerators,
        "for sets of relations of homalg modules",
        [ IsHomalgMatrix, IsHomalgRelationsOfRightModule ],
        
  function( mat, rel )
    
    return HomalgRelationsForRightModule( ReducedSyzygiesOfColumns( mat, MatrixOfRelations( rel ) ) );
    
end );

##
InstallMethod( ReducedSyzygiesGenerators,
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfLeftModule ],
        
  function( rel )
    
    return HomalgRelationsForLeftModule( ReducedSyzygiesOfRows( MatrixOfRelations( rel ) ) );
    
end );

##
InstallMethod( ReducedSyzygiesGenerators,
        "for sets of relations of homalg modules",
        [ IsHomalgMatrix, IsHomalgRelationsOfLeftModule ],
        
  function( mat, rel )
    
    return HomalgRelationsForLeftModule( ReducedSyzygiesOfRows( mat, MatrixOfRelations( rel ) ) );
    
end );

##
InstallMethod( NonZeroGenerators, ### defines: NonZeroGenerators
        "for sets of relations of homalg modules",
        [ IsHomalgRelations ],
        
  function( M )
    local R, RP, id, gen;
    
    if IsBound( M!.NonZeroGenerators ) then
        return M!.NonZeroGenerators;
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    #=====# begin of the core procedure #=====#
    
    id := HomalgIdentityMatrix( NrGenerators( M ), R );
    
    gen := DecideZero( id, BasisOfModule( M ) );
    
    if IsHomalgRelationsOfLeftModule( M ) then
        M!.NonZeroGenerators := NonZeroRows( gen );
    else
        M!.NonZeroGenerators := NonZeroColumns( gen );
    fi;
    
    return M!.NonZeroGenerators;
    
end );

##
InstallMethod( GetRidOfObsoleteRelations, ### defines: GetRidOfObsoleteRelations (BetterBasis)
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfRightModule ],
        
  function( M )
    
    return HomalgRelationsForRightModule( GetRidOfObsoleteColumns( MatrixOfRelations( M ) ) );
    
end );

##
InstallMethod( GetRidOfObsoleteRelations, ### defines: GetRidOfObsoleteRelations (BetterBasis)
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfLeftModule ],
        
  function( M )
    
    return HomalgRelationsForLeftModule( GetRidOfObsoleteRows( MatrixOfRelations( M ) ) );
    
end );

##
InstallMethod( GetIndependentUnitPositions,
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfRightModule, IsHomogeneousList ],
        
  function( rel, pos_list )
    
    return GetRowIndependentUnitPositions( MatrixOfRelations( rel ), pos_list );
    
end );

##
InstallMethod( GetIndependentUnitPositions,
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfRightModule ],
        
  function( rel )
    
    return GetRowIndependentUnitPositions( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( GetIndependentUnitPositions,
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfLeftModule, IsHomogeneousList ],
        
  function( rel, pos_list )
    
    return GetColumnIndependentUnitPositions( MatrixOfRelations( rel ), pos_list );
    
end );

##
InstallMethod( GetIndependentUnitPositions,
        "for sets of relations of homalg modules",
        [ IsHomalgRelationsOfLeftModule ],
        
  function( rel )
    
    return GetColumnIndependentUnitPositions( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( \^,
        "for sets of relations of homalg modules",
        [ IsHomalgRelations, IsHomalgMatrix ],
        
  function( rel, mat )
    local relations;
    
    relations := MatrixOfRelations( rel );
    
    if IsHomalgRelationsOfLeftModule( rel ) then
        return relations * mat;
    else
        return mat * relations;
    fi;
    
end );

##
InstallMethod( \*,
        "for sets of relations of homalg modules",
        [ IsHomalgRelations, IsHomalgMatrix ],
        
  function( rel, mat )
    
    if IsHomalgRelationsOfLeftModule( rel ) then
        return HomalgRelationsForLeftModule( \^, [ rel, mat ] );
    else
        return HomalgRelationsForRightModule( \^, [ rel, mat ] );
    fi;
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( INSTALL_TODO_LIST_ENTRIES_FOR_MATRICES_OF_RELATIONS,
        
  function( mat, rels )
    local entry;
    
    if IsHomalgRelationsOfLeftModule( rels ) then
        
        entry := ToDoListEntry( [ [ mat, "IsLeftRegular", true ] ],
                         [ [ "left regular matrices define injective left presentations",
                             [ rels, "IsInjectivePresentation", true ] ],
                           ]
                         );
        
    else
        
        entry := ToDoListEntry( [ [ mat, "IsRightRegular", true ] ],
                         [ [ "right regular matrices define injective right presentations",
                             [ rels, "IsInjectivePresentation", true ] ],
                           ]
                         );
        
    fi;
    
    AddToToDoList( entry );
    
end );

##
InstallGlobalFunction( INSTALL_TODO_LIST_ENTRIES_FOR_RELATIONS_OF_MODULES,
        
  function( rels, M )
    local entry;
    
    ## this will be obsolete for the modules over CAP
    entry := ToDoListEntry( [ [ rels, "IsTorsion" ] ],
                     [ [ "if the relations HasIsTorsion propagate this property to the module",
                         [ M, "IsTorsion", [ IsTorsion, rels ] ] ],
                       ]
                     );
    
    AddToToDoList( entry );
    
    entry := ToDoListEntry( [ [ rels, "IsInjectivePresentation", true ] ],
                     [ [ "the rank of the presented module can be computed as NrGenerators - NrRelations",
                         [ M, "RankOfObject", [ r -> NrGenerators( r ) - NrRelations( r ), rels ] ] ], ## the Euler characteristic
                       ]
                     );
    
    AddToToDoList( entry );
    
    entry := ToDoListEntry( [ [ rels, "NrRelationsForRelations" ] ],
                     [ [ "f.p. modules with no relations are free",
                         function() if NrRelations( rels ) = 0 then SetIsFree( M, true ); SetRankOfObject( M, NrGenerators( rels ) ); fi; end ],
                       [ "compute the rank of modules over integral domains presented by diagonal matrices",
                         function()
                           local R, diag;
                           diag := MatrixOfRelations( rels );
                           R := HomalgRing( M );
                           if HasIsIntegralDomain( R ) and IsIntegralDomain( R ) and
                              HasIsDiagonalMatrix( diag ) and IsDiagonalMatrix( diag ) then
                               diag := DiagonalEntries( diag );
                               SetRankOfObject( M, NrGenerators( rels ) - Length( Filtered( diag, a -> not IsZero( a ) ) ) );
                           fi;
                         end ],
                       ]
                     );
    
    AddToToDoList( entry );
    
end );

##
InstallGlobalFunction( _HomalgRelationsForLeftModule,
  function( arg )
    local l, relations, mat, M;
    
    l := Length( arg );
    
    relations := rec( );
    
    if IsHomalgMatrix( arg[1] ) then
        mat := arg[1];
        ResetFilterObj( mat, IsMutable );
    elif IsFunction( arg[1] ) then
        
        if not ( l > 1 and IsList( arg[2] ) ) then
            Error( "if the first argument is a function then the second argument must be the list of arguments\n" );
        fi;
        
        if IsHomalgModule( arg[l] ) then
            
            M := arg[l];
            
            ## Objectify:
            ObjectifyWithAttributes(
                    relations, TheTypeHomalgRelationsOfLeftModule,
                    EvalMatrixOfRelations, arg{[ 1 .. 2 ]} );
            SetParent( relations, M );
            INSTALL_TODO_LIST_ENTRIES_FOR_RELATIONS_OF_MODULES( relations, M );
        else
            ## Objectify:
            ObjectifyWithAttributes(
                    relations, TheTypeHomalgRelationsOfLeftModule,
                    EvalMatrixOfRelations, arg{[ 1 .. 2 ]} );
        fi;
        
        return relations;
    else
        mat := CallFuncList( HomalgMatrix, arg );
    fi;
    
    if l > 1 and IsHomalgModule( arg[l] ) then
        
        M := arg[l];
        
        ObjectifyWithAttributes(
                relations, TheTypeHomalgRelationsOfLeftModule,
                EvaluatedMatrixOfRelations, mat );
        SetParent( relations, M );
        INSTALL_TODO_LIST_ENTRIES_FOR_RELATIONS_OF_MODULES( relations, M );
    else
        ## Objectify:
        ObjectifyWithAttributes(
                relations, TheTypeHomalgRelationsOfLeftModule,
                EvaluatedMatrixOfRelations, mat );
    fi;
    
    INSTALL_TODO_LIST_ENTRIES_FOR_MATRICES_OF_RELATIONS( mat, relations );
    
    return relations;
    
end );

##
InstallMethod( HomalgRelationsForLeftModule,
        "for two objects",
        [ IsObject, IsObject ],
        
  _HomalgRelationsForLeftModule );

##
InstallMethod( HomalgRelationsForLeftModule,
        "for an object",
        [ IsObject ],
        
  _HomalgRelationsForLeftModule );

##
InstallGlobalFunction( _HomalgRelationsForRightModule,
  function( arg )
    local l, relations, mat, M;
    
    l := Length( arg );
    
    relations := rec( );
    
    if IsHomalgMatrix( arg[1] ) then
        mat := arg[1];
        ResetFilterObj( mat, IsMutable );
    elif IsFunction( arg[1] ) then
        
        if not ( l > 1 and IsList( arg[2] ) ) then
            Error( "if the first argument is a function then the second argument must be the list of arguments\n" );
        fi;
        
        if IsHomalgModule( arg[l] ) then
            
            M := arg[l];
            
            ## Objectify:
            ObjectifyWithAttributes(
                    relations, TheTypeHomalgRelationsOfRightModule,
                    EvalMatrixOfRelations, arg{[ 1 .. 2 ]} );
            SetParent( relations, M );
            INSTALL_TODO_LIST_ENTRIES_FOR_RELATIONS_OF_MODULES( relations, M );
        else
            ## Objectify:
            ObjectifyWithAttributes(
                    relations, TheTypeHomalgRelationsOfRightModule,
                    EvalMatrixOfRelations, arg{[ 1 .. 2 ]} );
        fi;
        
        return relations;
    else
        mat := CallFuncList( HomalgMatrix, arg );
    fi;
    
    if l > 1 and IsHomalgModule( arg[l] ) then
        
        M := arg[l];
        
        ObjectifyWithAttributes(
                relations, TheTypeHomalgRelationsOfRightModule,
                EvaluatedMatrixOfRelations, mat );
        SetParent( relations, M );
        INSTALL_TODO_LIST_ENTRIES_FOR_RELATIONS_OF_MODULES( relations, M );
    else
        ## Objectify:
        ObjectifyWithAttributes(
                relations, TheTypeHomalgRelationsOfRightModule,
                EvaluatedMatrixOfRelations, mat );
    fi;
    
    INSTALL_TODO_LIST_ENTRIES_FOR_MATRICES_OF_RELATIONS( mat, relations );
    
    return relations;
    
end );

##
InstallMethod( HomalgRelationsForRightModule,
        "for two objects",
        [ IsObject, IsObject ],
        
  _HomalgRelationsForRightModule );

##
InstallMethod( HomalgRelationsForRightModule,
        "for an object",
        [ IsObject ],
        
  _HomalgRelationsForRightModule );

##
InstallMethod( ShallowCopy,
        "for homalg relations",
        [ IsHomalgRelations ],
        
  function( rel )
    local rel_new, c;
    
    if HasEvaluatedMatrixOfRelations( rel ) then
        if IsHomalgRelationsOfLeftModule( rel ) then
            rel_new := HomalgRelationsForLeftModule( EvaluatedMatrixOfRelations( rel ) );
        else
            rel_new := HomalgRelationsForRightModule( EvaluatedMatrixOfRelations( rel ) );
        fi;
    elif HasEvalMatrixOfRelations( rel ) then
        if IsHomalgRelationsOfLeftModule( rel ) then
            rel_new := CallFuncList( HomalgRelationsForLeftModule, EvalMatrixOfRelations( rel ) );
        else
            rel_new := CallFuncList( HomalgRelationsForRightModule, EvalMatrixOfRelations( rel ) );
        fi;
    fi;
    
    for c in [ "BasisOfModule", "MaximumNumberOfResolutionSteps" ] do
        if IsBound( rel!.( c ) ) then
            rel_new!.( c ) := rel!.( c );
        fi;
    od;
    
    return rel_new;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( ViewObj,
        "for homalg relations",
        [ IsHomalgRelations ], 1001,
        
  function( o )
    local m, n;
    
    if HasNrRelations( o ) then
        m := NrRelations( o );
    else
        m := "unknown number";
    fi;
    n := NrGenerators( o );
    
    if IsString( m ) then
        Print( "<An unevaluated set of relations " );
    elif m = 0 then
        Print( "<An empty set of relations " );
    elif m = 1 then
        Print( "<A set containing a single relation " );
    else
        Print( "<A set of ", m, " relations " );
    fi;
    
    if n = 0 then
        Print( "for an empty set of generators " );
    elif n = 1 then
        Print( "for a single generator " );
    else
        Print( "for ", n, " generators " );
    fi;
    
    Print( "of a homalg " );
    
    if IsHomalgRelationsOfLeftModule( o ) then
        Print( "left " );
    else
        Print( "right " );
    fi;
    
    Print( "module>" );
    
end );

InstallMethod( Display,
        "for homalg relations",
        [ IsHomalgRelations ], 1001,
        
  function( o )
    local m, n;
    
    m := NrRelations( o );
    n := NrGenerators( o );
    
    if m = 0 then
        Print( "an empty set of relations " );
        if n = 0 then
            Print( "on an empty set of generators\n" );
        elif n = 1 then
            Print( "on a single generator\n" );
        else
            Print( "on ", n, " generators\n" );
        fi;
    else
        if n > 0 then
            Display( MatrixOfRelations( o ) );
            
            Print( "\n" );
        fi;
        
        if m = 1 then
            Print( "a single relation " );
        else
            Print( m, " relations " );
        fi;
        
        if n = 0 then
            Print( "for an empty set of generators\n" );
        else
            if n = 1 then
                Print( "for a single generator " );
            else
                Print( "for ", n, " generators " );
            fi;
            
            Print( "given by " );
            
            if m = 1 then
                Print( "(" );
            fi;
            
            Print( "the " );
            
            if IsHomalgRelationsOfLeftModule( o ) then
                Print( "row" );
            else
                Print( "column" );
            fi;
            
            if m = 1 then
                Print( " of)" );
            else
                Print( "s of" );
            fi;
            
            Print( " the above matrix\n" );
        fi;
    fi;
    
end );
