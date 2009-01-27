#############################################################################
##
##  HomalgRelations.gi          homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for a set of relations.
##
#############################################################################

##  <#GAPDoc Label="Relations:intro">
##  A finite presentation of a module is given by a finite set of generators and a finite set of relations
##  among these generators. In &homalg; a set of relations of a left/right module is given by a matrix <A>rel</A>,
##  the rows/columns of which are interpreted as relations among <M>n</M> generators, <M>n</M> being the number
##  of columns/rows of the matrix <A>rel</A>.
##  <P/>
##  The data structure of a module in &homalg; is designed to contain not only one but several sets of relations
##  (together with corresponding sets of generators). The different sets of relations are linked with so-called
##  transition matrices (&see; Chapter <Ref Chap="Modules"/>).
##  <#/GAPDoc>

####################################
#
# representations:
#
####################################

# a new representation for the GAP-category IsHomalgRelations:

##  <#GAPDoc Label="IsRelationsOfFinitelyPresentedModuleRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="rel" Name="IsRelationsOfFinitelyPresentedModuleRep"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; representation of a finite set of relations of a finitely presented &homalg; module. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgRelations"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsRelationsOfFinitelyPresentedModuleRep",
        IsHomalgRelations,
        [ "relations" ] );

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

##
InstallImmediateMethod( IsInjectivePresentation,
        IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule, 0,
        
  function( rel )
    local mat;
    
    mat := MatrixOfRelations( rel );
    
    if HasIsLeftRegularMatrix( mat ) and IsLeftRegularMatrix( mat ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsInjectivePresentation,
        IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule, 0,
        
  function( rel )
    local mat;
    
    mat := MatrixOfRelations( rel );
    
    if HasIsRightRegularMatrix( mat ) and IsRightRegularMatrix( mat ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( DegreesOfGenerators,
        "for sets of relations of homalg modules",
        [ IsRelationsOfFinitelyPresentedModuleRep ],
        
  function( rel )
    
    if IsBound(rel!.DegreesOfGenerators) then
        return rel!.DegreesOfGenerators;
    fi;
    
    return fail;
    
end );

##
InstallMethod( MatrixOfRelations,
        "for sets of relations of homalg modules",
        [ IsRelationsOfFinitelyPresentedModuleRep ],
        
  function( rel )
    
    return rel!.relations;
    
end );

##
InstallMethod( \=,
        "for homalg comparable matrices",
        [ IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule, IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule ],
        
  function( rel1, rel2 )
    
    return MatrixOfRelations( rel1 ) = MatrixOfRelations( rel2 );
    
end );

##
InstallMethod( \=,
        "for homalg comparable matrices",
        [ IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule, IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule ],
        
  function( rel1, rel2 )
    
    return MatrixOfRelations( rel1 ) = MatrixOfRelations( rel2 );
    
end );

##
InstallMethod( HomalgRing,
        "for sets of relations of homalg modules",
        [ IsRelationsOfFinitelyPresentedModuleRep ],
        
  function( rel )
    
    return HomalgRing( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( HasNrGenerators,
        "for sets of relations of homalg modules",
        [ IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule ],
        
  function( rel )
    
    return HasNrColumns( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( HasNrGenerators,
        "for sets of relations of homalg modules",
        [ IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule ],
        
  function( rel )
    
    return HasNrRows( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( NrGenerators,			### defines: NrGenerators (NumberOfGenerators)
        "for sets of relations of homalg modules",
        [ IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule ],
        
  function( rel )
    
    return NrColumns( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( NrGenerators,			### defines: NrGenerators (NumberOfGenerators)
        "for sets of relations of homalg modules",
        [ IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule ],
        
  function( rel )
    
    return NrRows( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( HasNrRelations,
        "for sets of relations of homalg modules",
        [ IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule ],
        
  function( rel )
    
    return HasNrRows( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( HasNrRelations,
        "for sets of relations of homalg modules",
        [ IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule ],
        
  function( rel )
    
    return HasNrColumns( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( NrRelations,			### defines: NrRelations (NumberOfRows)
        "for sets of relations of homalg modules",
        [ IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule ],
        
  function( rel )
    
    return NrRows( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( NrRelations,			### defines: NrRelations (NumberOfRows)
        "for sets of relations of homalg modules",
        [ IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule ],
        
  function( rel )
    
    return NrColumns( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( CertainRelations,		### defines: CertainRelations
        "for sets of relations of homalg modules",
        [ IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule,
          IsList ],
        
  function( rel, plist )
    local sub_rel;
    
    sub_rel := CertainRows( MatrixOfRelations( rel ), plist );
    
    ## take care of gradings
    if IsList( DegreesOfGenerators( rel ) ) then
        sub_rel!.DegreesOfGenerators := DegreesOfGenerators( rel );
    fi;
    
    return HomalgRelationsForLeftModule( sub_rel );
    
end );

##
InstallMethod( CertainRelations,		### defines: CertainRelations
        "for sets of relations of homalg modules",
        [ IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule,
          IsList ],
        
  function( rel, plist )
    local sub_rel;
    
    sub_rel := CertainColumns( MatrixOfRelations( rel ), plist );
    
    ## take care of gradings
    if IsList( DegreesOfGenerators( rel ) ) then
        sub_rel!.DegreesOfGenerators := DegreesOfGenerators( rel );
    fi;
    
    return HomalgRelationsForRightModule( sub_rel );
    
end );

##
InstallMethod( UnionOfRelations,		### defines: UnionOfRelations (SumRelations)
        "for sets of relations of homalg modules",
        [ IsHomalgMatrix,
          IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule ],
        
  function( mat1, rel2 )
    local rel;
    
    rel := UnionOfRows( mat1, MatrixOfRelations( rel2 ) );
    
    rel := HomalgRelationsForLeftModule( rel );
    
    ## take care of gradings
    if IsList( DegreesOfGenerators( rel2 ) ) then
        rel!.DegreesOfGenerators := DegreesOfGenerators( rel2 );
    fi;
    
    return rel;
    
end );

##
InstallMethod( UnionOfRelations,
        "for sets of relations of homalg modules",
        [ IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule,
          IsHomalgMatrix ],
        
  function( rel1, mat2 )
    
    return UnionOfRelations( mat2, rel1 );
    
end );

##
InstallMethod( UnionOfRelations,
        "for sets of relations of homalg modules",
        [ IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule,
          IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule ],
        
  function( rel1, rel2 )
    
    return UnionOfRelations( MatrixOfRelations( rel1 ), rel2 );
    
end );

##
InstallMethod( UnionOfRelations,		### defines: UnionOfRelations (SumRelations)
        "for sets of relations of homalg modules",
        [ IsHomalgMatrix,
          IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule ],
        
  function( mat1, rel2 )
    local rel;
    
    rel := UnionOfColumns( mat1, MatrixOfRelations( rel2 ) );
    
    rel := HomalgRelationsForRightModule( rel );
    
    ## take care of gradings
    if IsList( DegreesOfGenerators( rel2 ) ) then
        rel!.DegreesOfGenerators := DegreesOfGenerators( rel2 );
    fi;
    
    return rel;
    
end );

##
InstallMethod( UnionOfRelations,
        "for sets of relations of homalg modules",
        [ IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule,
          IsHomalgMatrix ],
        
  function( rel1, mat2 )
    
    return UnionOfRelations( mat2, rel1 );
    
end );

##
InstallMethod( UnionOfRelations,
        "for sets of relations of homalg modules",
        [ IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule,
          IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule ],
        
  function( rel1, rel2 )
    
    return UnionOfRelations( MatrixOfRelations( rel1 ), rel2 );
    
end );

##
InstallMethod( BasisOfModule,
        "for sets of relations of homalg modules",
        [ IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule ],
        
  function( rel )
    local mat, bas;
    
    if not IsBound( rel!.BasisOfModule ) then
        mat := MatrixOfRelations( rel );
        
        bas := BasisOfRows( mat );
        
        if bas = mat then
            SetCanBeUsedToDecideZeroEffectively( rel, true );
            rel!.relations := bas;	## when computing over finite fields in Maple taking a basis normalizes the entries
            if HasIsLeftRegularMatrix( bas ) and IsLeftRegularMatrix( bas ) then
                SetIsInjectivePresentation( rel, true );
            fi;
            return rel;
        else
            rel!.BasisOfModule := bas;
            SetCanBeUsedToDecideZeroEffectively( rel, false );
        fi;
    else
        bas := rel!.BasisOfModule;
    fi;
    
    bas := HomalgRelationsForLeftModule( bas );
    
    SetCanBeUsedToDecideZeroEffectively( bas, true );
    
    return bas;
end );

##
InstallMethod( BasisOfModule,
        "for sets of relations of homalg modules",
        [ IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule ],
        
  function( rel )
    local mat, bas;
    
    if not IsBound( rel!.BasisOfModule ) then
        mat := MatrixOfRelations( rel );
        
        bas := BasisOfColumns( mat );
        
        if bas = mat then
            SetCanBeUsedToDecideZeroEffectively( rel, true );
            rel!.relations := bas;	## when computing over finite fields in Maple taking a basis normalizes the entries
            if HasIsRightRegularMatrix( bas ) and IsRightRegularMatrix( bas ) then
                SetIsInjectivePresentation( rel, true );
            fi;
            return rel;
        else
            rel!.BasisOfModule := bas;
            SetCanBeUsedToDecideZeroEffectively( rel, false );
        fi;
    else
        bas := rel!.BasisOfModule;
    fi;
    
    bas := HomalgRelationsForRightModule( bas );
    
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

##
InstallMethod( DecideZero,
        "for sets of relations of homalg modules",
        [ IsHomalgMatrix,
          IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule ],
        
  function( mat, rel )
    
    return DecideZeroRows( mat, MatrixOfRelations( BasisOfModule( rel ) ) );
    
end );

##
InstallMethod( DecideZero,
        "for sets of relations of homalg modules",
        [ IsHomalgMatrix,
          IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule ],
        
  function( mat, rel )
    
    return DecideZeroColumns( mat, MatrixOfRelations( BasisOfModule( rel ) ) );
    
end );

##
InstallMethod( DecideZero,
        "for sets of relations of homalg modules",
        [ IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule,
          IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule ],
        
  function( rel_, rel )
    
    return HomalgRelationsForLeftModule( DecideZero( MatrixOfRelations( rel_ ), rel ) );
    
end );

##
InstallMethod( DecideZero,
        "for sets of relations of homalg modules",
        [ IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule,
          IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule ],
        
  function( rel_, rel )
    
    return HomalgRelationsForRightModule( DecideZero( MatrixOfRelations( rel_ ), rel ) );
    
end );

##
InstallMethod( BasisCoeff,
        "for sets of relations of homalg modules",
        [ IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule ],
        
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
InstallMethod( BasisCoeff,
        "for sets of relations of homalg modules",
        [ IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule ],
        
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
InstallMethod( DecideZeroEffectively,
        "modulo a set of relations of a homalg module",
        [ IsHomalgMatrix,
          IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule ],
        
  function( mat, rel )
    
    return DecideZeroRowsEffectively( mat, MatrixOfRelations( BasisOfModule( rel ) ) );
    
end );

##
InstallMethod( DecideZeroEffectively,
        "modulo a set of relations of a homalg module",
        [ IsHomalgMatrix,
          IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule ],
        
  function( mat, rel )
    
    return DecideZeroColumnsEffectively( mat, MatrixOfRelations( BasisOfModule( rel ) ) );
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for sets of relations of homalg modules",
        [ IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule ],
        
  function( rel )
    
    return HomalgRelationsForLeftModule( SyzygiesOfRows( MatrixOfRelations( rel ) ) );
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for sets of relations of homalg modules",
        [ IsHomalgMatrix,
          IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule ],
        
  function( mat, rel )
    
    return HomalgRelationsForLeftModule( SyzygiesOfRows( mat, MatrixOfRelations( rel ) ) );
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for sets of relations of homalg modules",
        [ IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule ],
        
  function( rel )
    
    return HomalgRelationsForRightModule( SyzygiesOfColumns( MatrixOfRelations( rel ) ) );
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for sets of relations of homalg modules",
        [ IsHomalgMatrix,
          IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule ],
        
  function( mat, rel )
    
    return HomalgRelationsForRightModule( SyzygiesOfColumns( mat, MatrixOfRelations( rel ) ) );
    
end );

##
InstallMethod( ReducedSyzygiesGenerators,
        "for sets of relations of homalg modules",
        [ IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule ],
        
  function( rel )
    local syz;
    
    syz := SyzygiesGenerators( rel );
    
    return ReducedBasisOfModule( syz );	## better than ReducedBasisOfModule( syz, "COMPUTE_BASIS" );
    
end );

##
InstallMethod( ReducedSyzygiesGenerators,
        "for sets of relations of homalg modules",
        [ IsHomalgMatrix,
          IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule ],
        
  function( mat, rel )
    local syz;
    
    syz := SyzygiesGenerators( mat, rel );
    
    return ReducedBasisOfModule( syz );	## better than ReducedBasisOfModule( syz, "COMPUTE_BASIS" );
    
end );

##
InstallMethod( ReducedSyzygiesGenerators,
        "for sets of relations of homalg modules",
        [ IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule ],
        
  function( rel )
    local syz;
    
    syz := SyzygiesGenerators( rel );
    
    return ReducedBasisOfModule( syz );	## better than ReducedBasisOfModule( syz, "COMPUTE_BASIS" );
    
end );

##
InstallMethod( ReducedSyzygiesGenerators,
        "for sets of relations of homalg modules",
        [ IsHomalgMatrix,
          IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule ],
        
  function( mat, rel )
    local syz;
    
    syz := SyzygiesGenerators( mat, rel );
    
    return ReducedBasisOfModule( syz );	## better than ReducedBasisOfModule( syz, "COMPUTE_BASIS" );
    
end );

##
InstallMethod( NonZeroGenerators,		### defines: NonZeroGenerators
        "for sets of relations of homalg modules",
        [ IsRelationsOfFinitelyPresentedModuleRep ],
        
  function( M )
    local R, RP, id, gen;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    #=====# begin of the core procedure #=====#
    
    id := HomalgIdentityMatrix( NrGenerators( M ), R );
    
    if IsHomalgRelationsOfLeftModule( M ) then
        gen := HomalgGeneratorsForLeftModule( id, BasisOfModule( M ) );
        gen := MatrixOfGenerators( DecideZero( gen ) );
        return NonZeroRows( gen );
    else
        gen := HomalgGeneratorsForRightModule( id, BasisOfModule( M ) );
        gen := MatrixOfGenerators( DecideZero( gen ) );
        return NonZeroColumns( gen );
    fi;
    
end );

##
InstallMethod( GetRidOfObsoleteRelations,	### defines: GetRidOfObsoleteRelations (BetterBasis)
        "for sets of relations of homalg modules",
        [ IsRelationsOfFinitelyPresentedModuleRep ],
        
  function( _M )
    local R, RP, M;
    
    R := HomalgRing( _M );
    
    RP := homalgTable( R );
    
    #=====# begin of the core procedure #=====#
    
    if IsHomalgRelationsOfLeftModule( _M ) then
        if IsBound(RP!.SimplifyBasisOfRows) then
            M := RP!.SimplifyBasisOfRows( _M );
        else
            M := MatrixOfRelations( _M );
        fi;
        
        return HomalgRelationsForLeftModule( CertainRows( M, NonZeroRows( M ) ) );
    else
        if IsBound(RP!.SimplifyBasisOfColumns) then
            M := RP!.SimplifyBasisOfColumns( _M );
        else
            M := MatrixOfRelations( _M );
        fi;
        
        return HomalgRelationsForRightModule( CertainColumns( M, NonZeroColumns( M ) ) );
    fi;
    
end );

##
InstallMethod( GetIndependentUnitPositions,
        "for sets of relations of homalg modules",
        [ IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule,
          IsHomogeneousList ],
        
  function( rel, pos_list )
    
    return GetColumnIndependentUnitPositions( MatrixOfRelations( rel ), pos_list );
    
end );

##
InstallMethod( GetIndependentUnitPositions,
        "for sets of relations of homalg modules",
        [ IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule ],
        
  function( rel )
    
    return GetColumnIndependentUnitPositions( MatrixOfRelations( rel ) );
    
end );

##
InstallMethod( GetIndependentUnitPositions,
        "for sets of relations of homalg modules",
        [ IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule,
          IsHomogeneousList ],
        
  function( rel, pos_list )
    
    return GetRowIndependentUnitPositions( MatrixOfRelations( rel ), pos_list );
    
end );

##
InstallMethod( GetIndependentUnitPositions,
        "for sets of relations of homalg modules",
        [ IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule ],
        
  function( rel )
    
    return GetRowIndependentUnitPositions( MatrixOfRelations( rel ) );
    
end );

InstallMethod( \*,
        "for sets of relations of homalg modules",
        [ IsRelationsOfFinitelyPresentedModuleRep, IsHomalgMatrix ],
        
  function( rel, mat )
    local relations;
    
    relations := MatrixOfRelations( rel );
    
    if IsHomalgRelationsOfLeftModule( rel ) then
        return HomalgRelationsForLeftModule( relations * mat );
    else
        return HomalgRelationsForRightModule( mat * relations );
    fi;
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( HomalgRelationsForLeftModule,
  function( arg )
    local relations;
    
    if IsHomalgMatrix( arg[1] ) then
        ResetFilterObj( arg[1], IsMutableMatrix );
        relations := rec( relations := arg[1] );
    else
        relations := rec( relations := CallFuncList( HomalgMatrix, arg ) );
    fi;
    
    ## Objectify:
    Objectify( TheTypeHomalgRelationsOfLeftModule, relations );
    
    return relations;
    
end );

##
InstallGlobalFunction( HomalgRelationsForRightModule,
  function( arg )
    local relations;
    
    if IsHomalgMatrix( arg[1] ) then
        ResetFilterObj( arg[1], IsMutableMatrix );
        relations := rec( relations := arg[1] );
    else
        relations := rec( relations := CallFuncList( HomalgMatrix, arg ) );
    fi;
    
    ## Objectify:
    Objectify( TheTypeHomalgRelationsOfRightModule, relations );
    
    return relations;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( ViewObj,
        "for homalg relations",
        [ IsRelationsOfFinitelyPresentedModuleRep ],
        
  function( o )
    local m, n;
    
    if HasNrRelations( o ) then
        m := NrRelations( o );
    else
        m := "unknown number";
    fi;
    n := NrGenerators( o );
    
    if IsString( m ) then
        Print( "<A set of relations " );
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
        [ IsRelationsOfFinitelyPresentedModuleRep ],
        
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
            
            Print( " the matrix \n\n" );
            
            Display( MatrixOfRelations( o ) );
        fi;
    fi;
    
end );
