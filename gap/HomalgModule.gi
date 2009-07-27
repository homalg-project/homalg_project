#############################################################################
##
##  HomalgModule.gi             homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for homalg modules.
##
#############################################################################

##  <#GAPDoc Label="Modules:intro">
##  A &homalg; module is a data structure for a finitely presented module. A presentation is given by
##  a set of generators and a set of relations among these generators. The data structure for modules in &homalg;
##  has two novel features:
##  <List>
##    <Item> The data structure allows several presentations linked with so-called transition matrices.
##       One of the presentations is marked as the default presentation, which is usually the last added one.
##       A new presentation can always be added provided it is linked to the default presentation by a transition matrix.
##       If needed, the user can reset the default presentation by choosing one of the other presentations saved
##       in the data structure of the &homalg; module. Effectively, a module is then given by <Q>all</Q> its presentations
##       (as <Q>coordinates</Q>) together with isomorphisms between them (as <Q>coordinate changes</Q>).
##       Being able to <Q>change coordinates</Q> makes the realization of a module in &homalg; <E>intrinsic</E>
##       (or <Q>coordinate free</Q>). </Item>
##    <Item> To present a left/right module it suffices to take a matrix <A>M</A> and interpret its rows/columns
##       as relations among <M>n</M> <E>abstract</E> generators, where <M>n</M> is the number of columns/rows
##       of <A>M</A>. Only that these abstract generators are useless when it comes to specific modules like
##       modules of homomorphisms, where one expects the generators to be maps between modules. For this
##       reason a presentation of a module in &homalg; is not merely a matrix of relations, but together with
##       a set of generators. </Item>
##  </List>
##  <#/GAPDoc>

####################################
#
# representations:
#
####################################

# new representations for the GAP-category IsHomalgModule

##  <#GAPDoc Label="IsFinitelyPresentedModuleOrSubmoduleRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="M" Name="IsFinitelyPresentedModuleOrSubmoduleRep"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; representation of finitley presented &homalg; modules. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgModule"/>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsFinitelyPresentedModuleOrSubmoduleRep",
        IsHomalgModule,
        [ ] );

##  <#GAPDoc Label="IsFinitelyPresentedModuleRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="M" Name="IsFinitelyPresentedModuleRep"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; representation of finitley presented &homalg; modules. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgModule"/>,
##       which is a subrepresentation of the &GAP; representations
##      <C>IsFinitelyPresentedModuleOrSubmoduleRep</C>,
##      <C>IsFinitelyPresentedObjectRep</C>, and <C>IsHomalgRingOrFinitelyPresentedModuleRep</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsFinitelyPresentedModuleRep",
        IsFinitelyPresentedModuleOrSubmoduleRep and
        IsFinitelyPresentedObjectRep and
        IsHomalgRingOrFinitelyPresentedModuleRep,
        [ "SetsOfGenerators", "SetsOfRelations",
          "TransitionMatrices",
          "PositionOfTheDefaultSetOfRelations" ] );

##  <#GAPDoc Label="IsFinitelyPresentedSubmoduleRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="M" Name="IsFinitelyPresentedSubmoduleRep"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; representation of finitley generated &homalg; submodules. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgModule"/>,
##      <C>IsFinitelyPresentedModuleOrSubmoduleRep</C>,
##      <C>IsFinitelyPresentedSubobjectRep</C>, and <C>IsHomalgRingOrFinitelyPresentedModuleRep</C>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsFinitelyPresentedSubmoduleRep",
        IsFinitelyPresentedModuleOrSubmoduleRep and
        IsFinitelyPresentedSubobjectRep and
        IsHomalgRingOrFinitelyPresentedModuleRep,
        [ "map_having_subobject_as_its_image" ] );

####################################
#
# families and types:
#
####################################

# two new family:
BindGlobal( "TheFamilyOfHomalgModules",
        NewFamily( "TheFamilyOfHomalgModules" ) );

BindGlobal( "TheFamilyOfHomalgSubmodules",
        NewFamily( "TheFamilyOfHomalgSubmodules" ) );

# four new types:
BindGlobal( "TheTypeHomalgLeftFinitelyPresentedModule",
        NewType( TheFamilyOfHomalgModules,
                IsFinitelyPresentedModuleRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeHomalgRightFinitelyPresentedModule",
        NewType( TheFamilyOfHomalgModules,
                IsFinitelyPresentedModuleRep and IsHomalgRightObjectOrMorphismOfRightObjects ) );

BindGlobal( "TheTypeHomalgLeftFinitelyGeneratedSubmodule",
        NewType( TheFamilyOfHomalgSubmodules,
                IsFinitelyPresentedSubmoduleRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeHomalgRightFinitelyGeneratedSubmodule",
        NewType( TheFamilyOfHomalgSubmodules,
                IsFinitelyPresentedSubmoduleRep and IsHomalgRightObjectOrMorphismOfRightObjects ) );

####################################
#
# methods for operations:
#
####################################

##  <#GAPDoc Label="HomalgRing:module">
##  <ManSection>
##    <Oper Arg="M" Name="HomalgRing" Label="for modules"/>
##    <Returns>a &homalg; ring</Returns>
##    <Description>
##      The &homalg; ring of the &homalg; module <A>M</A>.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );
##  <A homalg internal ring>
##  gap> M := ZZ * 4;
##  <A free right module of rank 4 on free generators>
##  gap> R := HomalgRing( M );
##  <A homalg internal ring>
##  gap> IsIdenticalObj( R, ZZ );
##  true
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( HomalgRing,
        "for homalg modules",
        [ IsHomalgModule and IsHomalgLeftObjectOrMorphismOfLeftObjects ],
        
  function( M )
    
    return LeftActingDomain( M );
    
end );

##
InstallMethod( HomalgRing,
        "for homalg modules",
        [ IsHomalgModule and IsHomalgRightObjectOrMorphismOfRightObjects ],
        
  function( M )
    
    return RightActingDomain( M );
    
end );

##
InstallOtherMethod( Zero,
        "for homalg modules",
        [ IsHomalgModule and IsHomalgLeftObjectOrMorphismOfLeftObjects ], 10001,	## FIXME: is it O.K. to use such a high ranking
        
  function( M )
    
    return HomalgRing( M )!.ZeroLeftModule;
    
end );

##
InstallOtherMethod( Zero,
        "for homalg modules",
        [ IsHomalgModule and IsHomalgRightObjectOrMorphismOfRightObjects ], 10001,	## FIXME: is it O.K. to use such a high ranking
        
  function( M )
    
    return HomalgRing( M )!.ZeroRightModule;
    
end );

##
InstallOtherMethod( One,
        "for homalg modules",
        [ IsHomalgModule and IsHomalgLeftObjectOrMorphismOfLeftObjects ],
        
  function( M )
    
    return HomalgRing( M )!.AsLeftModule;
    
end );

##
InstallOtherMethod( One,
        "for homalg modules",
        [ IsHomalgModule and IsHomalgRightObjectOrMorphismOfRightObjects ],
        
  function( M )
    
    return HomalgRing( M )!.AsRightModule;
    
end );

##
InstallMethod( SetsOfGenerators,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep ],
        
  function( M )
    
    return SetsOfGenerators( UnderlyingObject( M ) );
    
end );

##
InstallMethod( SetsOfGenerators,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    if IsBound(M!.SetsOfGenerators) then
        return M!.SetsOfGenerators;
    fi;
    
    return fail;
    
end );

##
InstallMethod( SetsOfRelations,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep ],
        
  function( M )
    
    return SetsOfRelations( UnderlyingObject( M ) );
    
end );

##
InstallMethod( SetsOfRelations,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    if IsBound(M!.SetsOfRelations) then
        return M!.SetsOfRelations;
    fi;
    
    return fail;
    
end );

##
InstallMethod( PositionOfTheDefaultSetOfRelations,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep ],
        
  function( M )
    
    return PositionOfTheDefaultSetOfRelations( UnderlyingObject( M ) );
    
end );

##
InstallMethod( PositionOfTheDefaultSetOfRelations,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    if IsBound(M!.PositionOfTheDefaultSetOfRelations) then
        return M!.PositionOfTheDefaultSetOfRelations;
    fi;
    
    return fail;
    
end );

##
InstallMethod( SetPositionOfTheDefaultSetOfRelations,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep, IsPosInt ],
        
  function( M, pos )
    
    M!.PositionOfTheDefaultSetOfRelations := pos;
    
end );

##
InstallMethod( GeneratorsOfModule,		### defines: GeneratorsOfModule (GeneratorsOfPresentation)
        "for homalg modules",
        [ IsHomalgModule, IsPosInt ],
        
  function( M, pos )
    
    if IsBound(SetsOfGenerators(M)!.(pos)) then
        return SetsOfGenerators(M)!.(pos);
    fi;
    
    return fail;
    
end );

##
InstallMethod( GeneratorsOfModule,		### defines: GeneratorsOfModule (GeneratorsOfPresentation)
        "for homalg modules",
        [ IsHomalgModule ],
        
  function( M )
    
    return GeneratorsOfModule( M, PositionOfTheDefaultSetOfGenerators( M ) );
    
end );

##
InstallMethod( RelationsOfModule,		### defines: RelationsOfModule (NormalizeInput)
        "for homalg modules",
        [ IsHomalgModule, IsPosInt ],
        
  function( M, pos )
    
    if IsBound(SetsOfRelations(M)!.(pos)) then;
        return SetsOfRelations(M)!.(pos);
    fi;
    
    return fail;
    
end );

##
InstallMethod( RelationsOfModule,		### defines: RelationsOfModule (NormalizeInput)
        "for homalg modules",
        [ IsHomalgModule ],
        
  function( M )
    
    return RelationsOfModule( M, PositionOfTheDefaultSetOfRelations( M ) );
    
end );

##
InstallMethod( DegreesOfGenerators,
        "for homalg modules",
        [ IsHomalgModule, IsPosInt ],
        
  function( M, pos )
    
    return DegreesOfGenerators( GeneratorsOfModule( M, pos ) );
    
end );

##
InstallMethod( DegreesOfGenerators,
        "for homalg modules",
        [ IsHomalgModule ],
        
  function( M )
    
    return DegreesOfGenerators( GeneratorsOfModule( M ) );
    
end );

##
InstallMethod( DegreesOfGenerators,
        "for homalg modules",
        [ IsHomalgModule and IsZero ],
        
  function( M )
    
    if NrGenerators( M ) > 0 then
        TryNextMethod( );
    fi;
    
    return [ ];
    
end );

##
InstallMethod( RelationsOfHullModule,		### defines: RelationsOfHullModule
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local gen;
    
    gen := GeneratorsOfModule( M );
    
    if gen <> fail then;
        return RelationsOfHullModule( gen );
    fi;
    
    return fail;
    
end );

##
InstallMethod( RelationsOfHullModule,		### defines: RelationsOfHullModule
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep, IsPosInt ],
        
  function( M, pos )
    local gen;
    
    gen := GeneratorsOfModule( M, pos );
    
    if gen <> fail then;
        return RelationsOfHullModule( gen );
    fi;
    
    return fail;
    
end );

##
InstallMethod( MatrixOfSubobjectGenerators,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep ],
  function( M )
    
    if HasEmbeddingInSuperObject( M ) then
        return MatrixOfMap( EmbeddingInSuperObject( M ) );
    fi;
    
    return M!.map_having_subobject_as_its_image;
    
end );

##
InstallMethod( MatrixOfGenerators,
        "for homalg modules",
        [ IsHomalgModule ],
  function( M )
    
    return MatrixOfGenerators( GeneratorsOfModule( M ) );
    
end );

##
InstallMethod( MatrixOfGenerators,
        "for homalg modules",
        [ IsHomalgModule, IsPosInt ],
  function( M, pos )
    local gen;
    
    gen := GeneratorsOfModule( M, pos );
    
    if IsHomalgGenerators( gen ) then
        return MatrixOfGenerators( gen );
    fi;
    
    return fail;
    
end );

##
InstallMethod( MatrixOfRelations,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return MatrixOfRelations( RelationsOfModule( M ) );
    
end );

##
InstallMethod( MatrixOfRelations,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep, IsPosInt ],
        
  function( M, pos )
    local rel;
    
    rel := RelationsOfModule( M, pos );
    
    if IsHomalgRelations( rel ) then
        return MatrixOfRelations( rel );
    fi;
    
    return fail;
    
end );

##
InstallMethod( HasNrGenerators,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep ],
  function( M )
    local gen_mat;
    
    gen_mat := MatrixOfSubobjectGenerators( M );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        return HasNrRows( gen_mat );
    else
        return HasNrColumns( gen_mat );
    fi;
    
end );

##
InstallMethod( HasNrGenerators,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
  function( M )
    
    return HasNrGenerators( GeneratorsOfModule( M ) );
    
end );

##
InstallMethod( NrGenerators,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep ],
  function( M )
    local gen_mat;
    
    gen_mat := MatrixOfSubobjectGenerators( M );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        return NrRows( gen_mat );
    else
        return NrColumns( gen_mat );
    fi;
    
end );

##
InstallMethod( NrGenerators,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
  function( M )
    
    return NrGenerators( GeneratorsOfModule( M ) );
    
end );

##
InstallMethod( HasNrGenerators,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep, IsPosInt ],
  function( M, pos )
    local gen;
    
    gen := GeneratorsOfModule( M, pos );
    
    if IsHomalgGenerators( gen ) then
        return HasNrGenerators( gen );
    fi;
    
    return fail;
    
end );

##
InstallMethod( NrGenerators,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep, IsPosInt ],
  function( M, pos )
    local gen;
    
    gen := GeneratorsOfModule( M, pos );
    
    if IsHomalgGenerators( gen ) then
        return NrGenerators( gen );
    fi;
    
    return fail;
    
end );

##
InstallMethod( HasNrRelations,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep ],
        
  HasEmbeddingInSuperObject );

##
InstallMethod( HasNrRelations,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local rel;
    
    rel := RelationsOfModule( M );
    
    if IsHomalgRelations( rel ) then
        return HasNrRelations( rel );
    fi;
    
    return fail;
    
end );

##
InstallMethod( NrRelations,
        "for homalg modules",
        [ IsHomalgModule ],
        
  function( M )
    local rel;
    
    rel := RelationsOfModule( M );
    
    if IsHomalgRelations( rel ) then
        return NrRelations( rel );
    fi;
    
    return fail;
    
end );

##
InstallMethod( HasNrRelations,
        "for homalg modules",
        [ IsHomalgModule, IsPosInt ],
        
  function( M, pos )
    local rel;
    
    rel := RelationsOfModule( M, pos );
    
    if IsHomalgRelations( rel ) then
        return HasNrRelations( rel );
    fi;
    
    return fail;
    
end );

##
InstallMethod( NrRelations,
        "for homalg modules",
        [ IsHomalgModule, IsPosInt ],
        
  function( M, pos )
    local rel;
    
    rel := RelationsOfModule( M, pos );
    
    if IsHomalgRelations( rel ) then
        return NrRelations( rel );
    fi;
    
    return fail;
    
end );

##
InstallMethod( TransitionMatrix,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep, IsPosInt, IsPosInt ],
        
  function( M, pos1, pos2 )
    local pres_a, pres_b, sets_of_generators, tr, sign, i, j;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        pres_a := pos2;
        pres_b := pos1;
    else
        pres_a := pos1;
        pres_b := pos2;
    fi;
    
    sets_of_generators := M!.SetsOfGenerators;
    
    if not IsBound( sets_of_generators!.( pres_a ) ) then
        
        Error( "the module given as the first argument has no ", pres_a, ". set of generators\n" );
        
    elif not IsBound( sets_of_generators!.( pres_b ) ) then
        
        Error( "the module given as the first argument has no ", pres_b, ". set of generators\n" );
        
    elif pres_a = pres_b then
        
        return HomalgIdentityMatrix( NrGenerators( sets_of_generators!.( pres_a ) ), HomalgRing( M ) );
        
    else
        
        ## starting with the identity is no waste of performance since the subpackage LIMAT is active:
        tr := HomalgIdentityMatrix(  NrGenerators( sets_of_generators!.( pres_a ) ), HomalgRing( M ) );
        
        sign := SignInt( pres_b - pres_a );
        
        i := pres_a;
        
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
            
            while AbsInt( pres_b - i ) > 0 do
                for j in pres_b - sign * [ 0 .. AbsInt( pres_b - i ) - 1 ]  do
                    if IsBound( M!.TransitionMatrices.( String( [ j, i ] ) ) ) then
                        tr := M!.TransitionMatrices.( String( [ j, i ] ) ) * tr;
                        i := j;
                        break;
                    fi;
                od;
            od;
            
        else
            
            while AbsInt( pres_b - i ) > 0 do
                for j in pres_b - sign * [ 0 .. AbsInt( pres_b - i ) - 1 ]  do
                    if IsBound( M!.TransitionMatrices.( String( [ i, j ] ) ) ) then
                        tr := tr * M!.TransitionMatrices.( String( [ i, j ] ) );
                        i := j;
                        break;
                    fi;
                od;
            od;
            
        fi;
        
        return tr;
        
    fi;
    
end );

##
InstallMethod( LockModuleOnCertainPresentation,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep, IsInt ],
        
  function( M, p )
    
    ## first save the current setting
    M!.LockModuleOnCertainPresentation := PositionOfTheDefaultSetOfRelations( M );
    
    SetPositionOfTheDefaultSetOfRelations( M, p );
    
end );

##
InstallMethod( LockModuleOnCertainPresentation,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    LockModuleOnCertainPresentation( M, PositionOfTheDefaultSetOfRelations( M ) );
    
end );

##
InstallMethod( UnlockModule,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    ## first restore the saved settings
    if IsBound( M!.LockModuleOnCertainPresentation ) then
        SetPositionOfTheDefaultSetOfRelations( M, M!.LockModuleOnCertainPresentation );
        Unbind( M!.LockModuleOnCertainPresentation );
    fi;
    
end );

##
InstallMethod( IsLockedModule,
        "for homalg modules",
        [ IsHomalgModule ],
        
  function( M )
    
    return IsBound( M!.LockModuleOnCertainPresentation );
    
end );

##
InstallMethod( AddANewPresentation,
        "for homalg modules",
        [ IsHomalgModule, IsGeneratorsOfFinitelyGeneratedModuleRep ],
        
  function( M, gen )
    local rels, gens, d, l, id, tr, itr;
    
    if not ( IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) and IsHomalgGeneratorsOfLeftModule( gen ) )
       and not ( IsHomalgRightObjectOrMorphismOfRightObjects( M ) and IsHomalgGeneratorsOfRightModule( gen ) ) then
        Error( "the module and the new set of generators must either be both left or both right\n" );
    fi;
    
    rels := SetsOfRelations( M );
    gens := SetsOfGenerators( M );
    
    d := PositionOfTheDefaultSetOfRelations( M );
    
    l := PositionOfLastStoredSetOfRelations( rels );
    
    ## define the (l+1)st set of generators:
    gens!.(l+1) := gen;
    
    ## adjust the list of positions:
    gens!.ListOfPositionsOfKnownSetsOfGenerators[l+1] := l+1;	## the list is allowed to contain holes (sparse list)
    
    ## define the (l+1)st set of relations:
    if IsBound( rels!.(d) ) then
        rels!.(l+1) := rels!.(d);
        ## add the list of degrees of generators to the new set of relations
        if IsList( DegreesOfGenerators( gen ) ) then
            rels!.(l+1)!.DegreesOfGenerators := DegreesOfGenerators( gen );
        fi;
    fi;
    
    ## adjust the list of positions:
    rels!.ListOfPositionsOfKnownSetsOfRelations[l+1] := l+1;	## the list is allowed to contain holes (sparse list)
    
    id := HomalgIdentityMatrix( NrGenerators( M ), HomalgRing( M ) );
    
    ## no need to distinguish between left and right modules here:
    M!.TransitionMatrices.( String( [ d, l+1 ] ) ) := id;
    M!.TransitionMatrices.( String( [ l+1, d ] ) ) := id;
    
    if d <> l then
        
        ## starting with the identity is no waste of performance since the subpackage LIMAT is active:
        tr := id; itr := id;
        
        if IsHomalgGeneratorsOfLeftModule( gen ) then
            
            tr := tr * TransitionMatrix( M, d, l );
            itr :=  TransitionMatrix( M, l, d ) * itr;
            
            M!.TransitionMatrices.( String( [ l+1, l ] ) ) := tr;
            M!.TransitionMatrices.( String( [ l, l+1 ] ) ) := itr;
            
        else
            
            tr := TransitionMatrix( M, l, d ) * tr;
            itr :=  itr * TransitionMatrix( M, d, l );
            
            M!.TransitionMatrices.( String( [ l, l+1 ] ) ) := tr;
            M!.TransitionMatrices.( String( [ l+1, l ] ) ) := itr;
            
        fi;
        
    fi;
    
    ## adjust the default position:
    if IsLockedModule( M ) then
        M!.LockModuleOnCertainPresentation := l+1;
    else
        SetPositionOfTheDefaultSetOfRelations( M, l+1 );
    fi;
    
    if NrGenerators( gen ) = 0 then
        SetIsZero( M, true );
    fi;
    
    return M;
    
end );

##
InstallMethod( AddANewPresentation,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep, IsRelationsOfFinitelyPresentedModuleRep ],
        
  function( M, rel )
    local rels, rev_lpos, d, gens, l, id, tr, itr;
    
    if not ( IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) and IsHomalgRelationsOfLeftModule( rel ) )
       and not ( IsHomalgRightObjectOrMorphismOfRightObjects( M ) and IsHomalgRelationsOfRightModule( rel ) ) then
        Error( "the module and the new set of relations must either be both left or both right\n" );
    fi;
    
    rels := SetsOfRelations( M );
    
    ## we reverse since we want to check the recent sets of relations first
    rev_lpos := Reversed( rels!.ListOfPositionsOfKnownSetsOfRelations );
    
    ## don't add an old set of relations, but let it be the default set of relations instead:
    for d in rev_lpos do
        if IsIdenticalObj( rel, rels!.(d) ) then
            
            if IsLockedModule( M ) then
                M!.LockModuleOnCertainPresentation := d;
            else
                SetPositionOfTheDefaultSetOfRelations( M, d );
            fi;
            
            return M;
        fi;
    od;
    
    for d in rev_lpos do
        if MatrixOfRelations( rel ) = MatrixOfRelations( rels!.(d) ) then
            
            if IsLockedModule( M ) then
                M!.LockModuleOnCertainPresentation := d;
            else
                SetPositionOfTheDefaultSetOfRelations( M, d );
            fi;
            
            return M;
        fi;
    od;
    
    gens := SetsOfGenerators( M );
    
    d := PositionOfTheDefaultSetOfRelations( M );
    
    l := PositionOfLastStoredSetOfRelations( rels );
    
    ## define the (l+1)st set of generators:
    gens!.(l+1) := gens!.(d);
    
    ## adjust the list of positions:
    gens!.ListOfPositionsOfKnownSetsOfGenerators[l+1] := l+1;	## the list is allowed to contain holes (sparse list)
    
    ## define the (l+1)st set of relations:
    rels!.(l+1) := rel;
    
    ## add the list of degrees of generators to the new set of relations
    if IsList( DegreesOfGenerators( gens!.(l+1) ) ) then
        rels!.(l+1)!.DegreesOfGenerators := DegreesOfGenerators( gens!.(l+1) );
    fi;
    
    ## adjust the list of positions:
    rels!.ListOfPositionsOfKnownSetsOfRelations[l+1] := l+1;	## the list is allowed to contain holes (sparse list)
    
    id := HomalgIdentityMatrix( NrGenerators( M ), HomalgRing( M ) );
    
    ## no need to distinguish between left and right modules here:
    M!.TransitionMatrices.( String( [ d, l+1 ] ) ) := id;
    M!.TransitionMatrices.( String( [ l+1, d ] ) ) := id;
    
    if d <> l then
        
        ## starting with the identity is no waste of performance since the subpackage LIMAT is active:
        tr := id; itr := id;
        
        if IsHomalgRelationsOfLeftModule( rel ) then
            
            tr := tr * TransitionMatrix( M, d, l );
            itr :=  TransitionMatrix( M, l, d ) * itr;
            
            M!.TransitionMatrices.( String( [ l+1, l ] ) ) := tr;
            M!.TransitionMatrices.( String( [ l, l+1 ] ) ) := itr;
            
        else
            
            tr := TransitionMatrix( M, l, d ) * tr;
            itr :=  itr * TransitionMatrix( M, d, l );
            
            M!.TransitionMatrices.( String( [ l, l+1 ] ) ) := tr;
            M!.TransitionMatrices.( String( [ l+1, l ] ) ) := itr;
            
        fi;
        
    fi;
    
    ## adjust the default position:
    if IsLockedModule( M ) then
        M!.LockModuleOnCertainPresentation := l+1;
    else
        SetPositionOfTheDefaultSetOfRelations( M, l+1 );
    fi;
    
    if HasNrRelations( rel ) = true and NrRelations( rel ) = 0 then
        SetIsFree( M, true );
    fi;
    
    return M;
    
end );

##
InstallMethod( AddANewPresentation,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep, IsRelationsOfFinitelyPresentedModuleRep, IsHomalgMatrix, IsHomalgMatrix ],
        
  function( M, rel, T, TI )
    local rels, gens, d, l, gen, tr, itr;
    
    if not ( IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) and IsHomalgRelationsOfLeftModule( rel ) )
       and not ( IsHomalgRightObjectOrMorphismOfRightObjects( M ) and IsHomalgRelationsOfRightModule( rel ) ) then
        Error( "the module and the new set of relations must either be both left or both right\n" );
    fi;
    
    rels := SetsOfRelations( M );
    gens := SetsOfGenerators( M );
    
    d := PositionOfTheDefaultSetOfRelations( M );
    
    l := PositionOfLastStoredSetOfRelations( rels );
    
    gen := TI * GeneratorsOfModule( M );
    
    ## define the (l+1)st set of generators:
    gens!.(l+1) := gen;
    
    ## adjust the list of positions:
    gens!.ListOfPositionsOfKnownSetsOfGenerators[l+1] := l+1;	## the list is allowed to contain holes (sparse list)
    
    ## define the (l+1)st set of relations:
    rels!.(l+1) := rel;
    
    ## add the list of degrees of generators to the new set of relations
    if IsList( DegreesOfGenerators( gens!.(l+1) ) ) then
        rels!.(l+1)!.DegreesOfGenerators := DegreesOfGenerators( gens!.(l+1) );
    fi;
    
    ## adjust the list of positions:
    rels!.ListOfPositionsOfKnownSetsOfRelations[l+1] := l+1;	## the list is allowed to contain holes (sparse list)
    
    if IsHomalgRelationsOfLeftModule( rel ) then
        M!.TransitionMatrices.( String( [ d, l+1 ] ) ) := T;
        M!.TransitionMatrices.( String( [ l+1, d ] ) ) := TI;
    else
        M!.TransitionMatrices.( String( [ l+1, d ] ) ) := T;
        M!.TransitionMatrices.( String( [ d, l+1 ] ) ) := TI;
    fi;
    
    if d <> l then
        
        tr := TI; itr := T;
        
        if IsHomalgRelationsOfLeftModule( rel ) then
            
            tr := tr * TransitionMatrix( M, d, l );
            itr :=  TransitionMatrix( M, l, d ) * itr;
            
            M!.TransitionMatrices.( String( [ l+1, l ] ) ) := tr;
            M!.TransitionMatrices.( String( [ l, l+1 ] ) ) := itr;
            
        else
            
            tr := TransitionMatrix( M, l, d ) * tr;
            itr :=  itr * TransitionMatrix( M, d, l );
            
            M!.TransitionMatrices.( String( [ l, l+1 ] ) ) := tr;
            M!.TransitionMatrices.( String( [ l+1, l ] ) ) := itr;
            
        fi;
        
    fi;
    
    ## adjust the default position:
    if IsLockedModule( M ) then
        M!.LockModuleOnCertainPresentation := l+1;
    else
        SetPositionOfTheDefaultSetOfRelations( M, l+1 );
    fi;
    
    if NrGenerators( gen ) = 0 then
        SetIsZero( M, true );
    fi;
    
    if HasNrRelations( rel ) = true and NrRelations( rel ) = 0 then
        SetIsFree( M, true );
    fi;
    
    return M;

end );

##
InstallMethod( BasisOfModule,			### CAUTION: has the side effect of possibly affecting the module M
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local rel, bas, mat, R, diag, rk;
    
    rel := RelationsOfModule( M );
    
    if not ( HasCanBeUsedToDecideZeroEffectively( rel ) and CanBeUsedToDecideZeroEffectively( rel ) ) then
        bas := BasisOfModule( rel );		## CAUTION: might have a side effect on rel
        
        AddANewPresentation( M, bas );		## this might set CanBeUsedToDecideZeroEffectively( rel ) to true
    else
        bas := rel;
    fi;
    
    if not HasRankOfModule( M ) then
       mat := MatrixOfRelations( rel );
       R := HomalgRing( M );
       if HasIsIntegralDomain( R ) and IsIntegralDomain( R ) and
          HasIsDiagonalMatrix( mat ) and IsDiagonalMatrix( mat ) then
           diag := DiagonalEntries( mat );
           rk := Length( Filtered( diag, IsZero ) ) + NrGenerators( M ) - Length( diag );
           SetRankOfModule( M, rk );
       elif HasIsInjectivePresentation( bas ) and IsInjectivePresentation( bas ) then
           rk := NrGenerators( M ) - NrRelations( M );	## the euler characteristic
           SetRankOfModule( M, rk );
       fi;
    fi;
    
    return RelationsOfModule( M );
    
end );

##
InstallMethod( DecideZero,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local gen, red;
    
    gen := GeneratorsOfModule( M );
    
    if HasIsReduced( gen ) and IsReduced( gen ) then
        return gen;
    fi;
    
    red := DecideZero( gen );
    
    if IsIdenticalObj( gen, red ) then
        return gen;
    fi;
    
    AddANewPresentation( M, red );
    
    return red;
    
end );

##
InstallMethod( DecideZero,
        "for homalg modules",
        [ IsHomalgMatrix, IsFinitelyPresentedModuleRep ],
        
  function( mat, M )
    local rel;
    
    rel := RelationsOfModule( M );
    
    return DecideZero( mat, rel );
    
end );

##
InstallMethod( UnionOfRelations,
        "for homalg modules",
        [ IsHomalgMatrix, IsFinitelyPresentedModuleRep ],
        
  function( mat, M )
    
    return UnionOfRelations( mat, RelationsOfModule( M ) );
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return SyzygiesGenerators( RelationsOfModule( M ) );
    
end );

##
InstallMethod( SyzygiesGenerators,
        "for homalg modules",
        [ IsHomalgMatrix, IsFinitelyPresentedModuleRep ],
        
  function( mat, M )
    
    return SyzygiesGenerators( mat, RelationsOfModule( M ) );
    
end );

##
InstallMethod( ReducedSyzygiesGenerators,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return ReducedSyzygiesGenerators( RelationsOfModule( M ) );
    
end );

##
InstallMethod( ReducedSyzygiesGenerators,
        "for homalg modules",
        [ IsHomalgMatrix, IsFinitelyPresentedModuleRep ],
        
  function( mat, M )
    
    return ReducedSyzygiesGenerators( mat, RelationsOfModule( M ) );
    
end );

##
InstallMethod( NonZeroGenerators,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    
    return NonZeroGenerators( BasisOfModule( RelationsOfModule( M ) ) ); ## don't delete RelationsOfModule, since we don't want to add too much new relations to the module in an early stage!
    
end );

##
InstallMethod( GetRidOfObsoleteGenerators,	### defines: GetRidOfObsoleteGenerators (BetterPresentation)
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local bl, rel, diagonal, upper, lower, id, T, TI;
    
    bl := NonZeroGenerators( M );
    
    if Length( bl ) <> NrGenerators( M ) then
        
        rel := MatrixOfRelations( M );
        
        if HasIsDiagonalMatrix( rel ) then
            if IsDiagonalMatrix( rel ) then
                diagonal := true;
            else
                diagonal := false;
            fi;
        else
            diagonal := fail;
        fi;
        
        if HasIsUpperTriangularMatrix( rel ) then
            if IsUpperTriangularMatrix( rel ) then
                upper := true;
            else
                upper := false;
            fi;
        else
            upper := fail;
        fi;
        
        if HasIsLowerTriangularMatrix( rel ) then
            if IsLowerTriangularMatrix( rel ) then
                lower := true;
            else
                lower := false;
            fi;
        else
            lower := fail;
        fi;
        
        id := HomalgIdentityMatrix( NrGenerators( M ), HomalgRing( M ) );
        
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
            rel := CertainColumns( rel, bl );
            rel := CertainRows( rel, NonZeroRows( rel ) );
            if diagonal <> fail and diagonal then
                SetIsDiagonalMatrix( rel, true );
            fi;
            rel := HomalgRelationsForLeftModule( rel );
            T := CertainColumns( id, bl );
            TI := CertainRows( id, bl );
        else
            rel := CertainRows( rel, bl );
            rel := CertainColumns( rel, NonZeroColumns( rel ) );
            if diagonal <> fail and diagonal then
                SetIsDiagonalMatrix( rel, true );
            fi;
            rel := HomalgRelationsForRightModule( rel );
            T := CertainRows( id, bl );
            TI := CertainColumns( id, bl );
        fi;
        
        AddANewPresentation( M, rel, T, TI );
        
        if HasNrGenerators( M ) and NrGenerators( M ) = 1 then
            SetIsCyclic( M, true );
        fi;
    fi;
    
    return M;
    
end );

#=======================================================================
# Compute a smaller presentation allowing the transformation of the generators
# (i.e. allowing column/row operations for left/right relation matrices)
#_______________________________________________________________________
InstallMethod( OnLessGenerators,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ],
        
  function( M )
    local R, rel_old, rel, V, VI;
    
    R := HomalgRing( M );
    
    rel_old := MatrixOfRelations( M );
    
    V := HomalgVoidMatrix( R );
    VI := HomalgVoidMatrix( R );
    
    rel := SimplerEquivalentMatrix( rel_old, V, VI, "", "" );
    
    if rel_old = rel then
        return GetRidOfObsoleteGenerators( M );
    fi;
    
    rel := HomalgRelationsForLeftModule( rel );
    
    AddANewPresentation( M, rel, V, VI );
    
    return GetRidOfObsoleteGenerators( M );
    
end );

##
InstallMethod( OnLessGenerators,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep and IsHomalgRightObjectOrMorphismOfRightObjects ],
        
  function( M )
    local R, rel_old, rel, U, UI;
    
    R := HomalgRing( M );
    
    rel_old := MatrixOfRelations( M );
    
    U := HomalgVoidMatrix( R );
    UI := HomalgVoidMatrix( R );
    
    rel := SimplerEquivalentMatrix( rel_old, U, UI, "", "", "" );
    
    if rel_old = rel then
        return GetRidOfObsoleteGenerators( M );
    fi;
    
    rel := HomalgRelationsForRightModule( rel );
    
    AddANewPresentation( M, rel, U, UI );
    
    return GetRidOfObsoleteGenerators( M );
    
end );

##  <#GAPDoc Label="ByASmallerPresentation:module">
##  <ManSection>
##    <Meth Arg="M" Name="ByASmallerPresentation" Label="for modules"/>
##    <Returns>a &homalg; module</Returns>
##    <Description>
##      Use different strategies to reduce the presentation of the given &homalg; module <A>M</A>.
##      This method performs side effects on its argument <A>M</A> and returns it.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> M := HomalgMatrix( "[ \
##  > 2, 3, 4, \
##  > 5, 6, 7  \
##  > ]", 2, 3, ZZ );
##  <A homalg internal 2 by 3 matrix>
##  gap> M := LeftPresentation( M );
##  <A non-zero left module presented by 2 relations for 3 generators>
##  gap> Display( M );
##  [ [  2,  3,  4 ],
##    [  5,  6,  7 ] ]
##  
##  Cokernel of the map
##  
##  Z^(1x2) --> Z^(1x3),
##  
##  currently represented by the above matrix
##  gap> ByASmallerPresentation( M );
##  <A non-zero left module presented by 1 relation for 2 generators>
##  gap> Display( last );
##  Z/< 3 > + Z^(1 x 1)
##  gap> SetsOfGenerators( M );
##  <A set containing 3 sets of generators of a homalg module>
##  gap> SetsOfRelations( M );
##  <A set containing 3 sets of relations of a homalg module>
##  gap> M;
##  <A rank 1 left module presented by 1 relation for 2 generators>
##  gap> SetPositionOfTheDefaultSetOfRelations( M, 1 );
##  gap> M;
##  <A rank 1 left module presented by 2 relations for 3 generators>
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( ByASmallerPresentation,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local g, r, p, rel;
    
    while true do
        g := NrGenerators( M );
        r := NrRelations( M );
        p := PositionOfTheDefaultSetOfGenerators( M );
        OnLessGenerators( M );
        if NrGenerators( M ) = g then	## try to compute a basis first
            rel := RelationsOfModule( M, p );
            if not ( HasCanBeUsedToDecideZeroEffectively( rel ) and
                     CanBeUsedToDecideZeroEffectively( rel ) ) then
                SetPositionOfTheDefaultSetOfGenerators( M, p );	## just in case
                BasisOfModule( M );
                OnLessGenerators( M );
            fi;
        fi;
        if NrGenerators( M ) = g then	## there is nothing we can do more!
            break;
        fi;
    od;
    
    if not ( IsBound( HOMALG.ByASmallerPresentationDoesNotDecideZero ) and
             HOMALG.ByASmallerPresentationDoesNotDecideZero = true ) then
        DecideZero( M );
    fi;
    
    return M;
    
end );

##
InstallMethod( ByASmallerPresentation,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep ],
        
  function( M )
    local emb;
    
    emb := EmbeddingInSuperObject( M );
    
    ByASmallerPresentation( Source( emb ) );
    
    DecideZero( emb );
    
    return M;
    
end );

##
InstallMethod( ElementaryDivisors,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local rel, b, R, RP, e;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound( RP!.ElementaryDivisors ) and HasRankOfModule( M ) then
        e := RP!.ElementaryDivisors( MatrixOfRelations( M ) );
        if IsString( e ) then
            e := StringToElementStringList( e );
            e := List( e, a -> HomalgRingElement( a, R ) );
        fi;
        
        ## since the computer algebra systems have different
        ## conventions for elementary divisors, we fix our own here:
        e := Filtered( e, x -> not IsOne( x ) and not IsZero( x ) );
        
        Append( e, ListWithIdenticalEntries( RankOfModule( M ), Zero( R ) ) );
        
        return e;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( ElementaryDivisors,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep and IsZero ],
        
  function( M )
    
    return [ ];
    
end );

##
InstallMethod( ElementaryDivisors,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep and IsFree ],
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    return ListWithIdenticalEntries( NrGenerators( M ), Zero( R ) );
    
end );

##
InstallMethod( SetUpperBoundForProjectiveDimension,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep, IsInfinity ],
        
  function( M, ub_pd )
    
    ## do nothing
    
end );

##
InstallMethod( SetUpperBoundForProjectiveDimension,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep, IsInt ],
        
  function( M, ub_pd )
    local left, R, ub, min;
    
    if not HasProjectiveDimension( M ) then	## otherwise don't do anything
        if ub_pd < 0 then
            ## decrease the upper bound by |up_bd| *relative* to the left/right global dimension of the ring:
            left := IsHomalgLeftObjectOrMorphismOfLeftObjects( M );
            R := HomalgRing( M );
            if left and HasLeftGlobalDimension( R ) and IsInt( LeftGlobalDimension( R ) ) then
                ub := LeftGlobalDimension( R ) + ub_pd;			## recall, ub_pd < 0
                if ub < 0 then
                    SetProjectiveDimension( M, 0 );
                else
                    SetUpperBoundForProjectiveDimension( M, ub );	## ub >= 0
                fi;
            elif not left and HasRightGlobalDimension( R ) and IsInt( RightGlobalDimension( R ) ) then
                ub := RightGlobalDimension( R ) + ub_pd;		## recall, ub_pd < 0
                if ub < 0 then
                    SetProjectiveDimension( M, 0 );
                else
                    SetUpperBoundForProjectiveDimension( M, ub );	## ub >= 0
                fi;
            fi;
        else
            ## set the upper bound to up_bd:
            if IsBound( M!.UpperBoundForProjectiveDimension ) then
                min := Minimum( M!.UpperBoundForProjectiveDimension, ub_pd );
            else
                min := ub_pd;
            fi;
            
            M!.UpperBoundForProjectiveDimension := min;
            
            if min = 0 then
                SetProjectiveDimension( M, 0 );
            elif min = 1 and HasIsProjective( M ) and not IsProjective( M ) then
                SetProjectiveDimension( M, 1 );
            fi;
        fi;
    fi;
    
end );

##  <#GAPDoc Label="UnderlyingObject:submodule">
##  <ManSection>
##    <Oper Arg="M" Name="SuperObject" Label="for submodules"/>
##    <Returns>a &homalg; module</Returns>
##    <Description>
##      In case <A>M</A> was defined as a submodule of some module <M>L</M> the module underlying the submodule <M>M</M> is returned.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( UnderlyingObject,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep ],
        
  function( M )
    
    return Source( EmbeddingInSuperObject( M ) );
    
end );

##  <#GAPDoc Label="SuperObject">
##  <ManSection>
##    <Oper Arg="M" Name="SuperObject"/>
##    <Returns>a &homalg; module</Returns>
##    <Description>
##      In case <A>M</A> was defined as a submodule of some module <M>L</M> the super module <M>L</M> is returned.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( SuperObject,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep ],
        
  function( M )
    
    return Range( EmbeddingInSuperObject( M ) );
    
end );

##
InstallOtherMethod( \*,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep, IsFinitelyPresentedSubmoduleRep ],
        
  function( J, K )
    local super, left, R, genJ, genK;
    
    super := SuperObject( J );
    
    if not IsIdenticalObj( super, SuperObject( K ) ) then
        Error( "the super objects must coincide\n" );
    fi;
    
    left := IsHomalgLeftObjectOrMorphismOfLeftObjects( J );
    
    R := HomalgRing( J );
    
    if ( ( left and not IsIdenticalObj( super, 1 * R ) ) or
         ( not left and not IsIdenticalObj( super, R * 1 ) ) ) and
       ( ( left and not IsIdenticalObj( super, ( 1 * R )^0 ) ) or
         ( not left and not IsIdenticalObj( super, ( R * 1 )^0 ) ) ) then
        
        Error( "can only multiply ideals in a common ring\n" );
        
    fi;
    
    genJ := MatrixOfSubobjectGenerators( J );
    genK := MatrixOfSubobjectGenerators( K );
    
    return Subobject( KroneckerMat( genJ, genK ), super );
    
end );

##
InstallOtherMethod( POW,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep, IsInt ],
        
  function( J, pow )
    local R;
    
    R := HomalgRing( J );
    
    if pow < 0 then
        
        Error( "negative powers are not defined\n" );
        
    elif pow = 0 then
        
        return Subobject( HomalgIdentityMatrix( 1, R ), SuperObject( J ) );
        
    elif pow = 1 then
        
        return J;
        
    else
        
        return Iterated( ListWithIdenticalEntries( pow, J ), \* );
        
    fi;
    
end );

##
InstallMethod( IsSubset,
        "for homalg submodules",
        [ IsHomalgModule, IsFinitelyPresentedSubmoduleRep ],
        
  function( K, J )	## GAP-standard: is J a subset of K
    local M, genJ, genK, rel, div;
    
    M := SuperObject( J );
    
    if not IsFinitelyPresentedSubmoduleRep( K ) then
        return IsIdenticalObj( M, K );
    fi;
    
    if not IsIdenticalObj( M, SuperObject( K ) ) then
        Error( "the super objects must coincide\n" );
    fi;
    
    genJ := MatrixOfSubobjectGenerators( J );
    genK := MatrixOfSubobjectGenerators( K );
    
    rel := RelationsOfModule( M );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( J ) then;
        div := RightDivide( genJ, genK, rel );
    else
        div := LeftDivide( genK, genJ, rel );
    fi;
    
    return not IsBool( div );
    
end );

##
InstallMethod( \=,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep, IsFinitelyPresentedSubmoduleRep ],
        
  function( J, K )
    
    return IsSubset( J, K ) and IsSubset( K, J );
    
end );

##
InstallMethod( \=,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep, IsHomalgRing ],
        
  function( J, R )
    
    if not IsIdenticalObj( HomalgRing( J ), R ) then
        Error( "the given ring and the ring of the submodule are not identical\n" );
    fi;
    
    return IsSubset( J, FullSubmodule( SuperObject( J ) ) );
    
end );

##
InstallMethod( \=,
        "for homalg submodules",
        [ IsHomalgRing, IsFinitelyPresentedSubmoduleRep ],
        
  function( R, J )
    
    return J = R;
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallMethod( AsLeftModule,
        "for homalg rings",
        [ IsHomalgRing ],
        
  function( R )
    
    return R!.AsLeftModule;
    
end );

##
InstallMethod( AsRightModule,
        "for homalg rings",
        [ IsHomalgRing ],
        
  function( R )
    
    return R!.AsRightModule;
    
end );

##
InstallMethod( Presentation,
        "constructor",
        [ IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule ],
        
  function( rel )
    local R, is_zero_module, gens, rels, M;
    
    R := HomalgRing( rel );
    
    if NrGenerators( rel ) = 0 then ## since one doesn't specify generators here giving no relations defines the zero module
        gens := CreateSetsOfGeneratorsForLeftModule( [ ], R );
        is_zero_module := true;
    else
        gens := CreateSetsOfGeneratorsForLeftModule(
                        HomalgIdentityMatrix( NrGenerators( rel ), R ), rel );
    fi;
    
    rels := CreateSetsOfRelationsForLeftModule( rel );
    
    M := rec( SetsOfGenerators := gens,
              SetsOfRelations := rels,
              TransitionMatrices := rec( ),
              PositionOfTheDefaultSetOfRelations := 1 );
    
    ## Objectify:
    if IsBound( is_zero_module ) then
        ObjectifyWithAttributes(
                M, TheTypeHomalgLeftFinitelyPresentedModule,
                LeftActingDomain, R,
                GeneratorsOfLeftOperatorAdditiveGroup, M!.SetsOfGenerators!.1,
                IsZero, true );
    else
        ObjectifyWithAttributes(
                M, TheTypeHomalgLeftFinitelyPresentedModule,
                LeftActingDomain, R,
                GeneratorsOfLeftOperatorAdditiveGroup, M!.SetsOfGenerators!.1 );
        
        if HasLeftGlobalDimension( R ) then
            SetUpperBoundForProjectiveDimension( M, LeftGlobalDimension( R ) );
        fi;
    fi;
    
#    SetParent( gens, M );
#    SetParent( rels, M );
    
    return M;
    
end );
  
##
InstallMethod( Presentation,
        "constructor",
        [ IsGeneratorsOfFinitelyGeneratedModuleRep and IsHomalgGeneratorsOfLeftModule, IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfLeftModule ],
        
  function( gen, rel )
    local R, is_zero_module, gens, rels, M;
    
    if NrGenerators( gen ) <> NrGenerators( rel ) then
        Error( "the first argument is a set of ", NrGenerators( gen ), " generator(s) while the second argument is a set of relations for ", NrGenerators( rel ), " generators\n" );
    fi;
    
    R := HomalgRing( rel );
    
    gens := CreateSetsOfGeneratorsForLeftModule( gen );
    
    if NrGenerators( rel ) = 0 then
        is_zero_module := true;
    fi;
    
    rels := CreateSetsOfRelationsForLeftModule( rel );
    
    M := rec( SetsOfGenerators := gens,
              SetsOfRelations := rels,
              TransitionMatrices := rec( ),
              PositionOfTheDefaultSetOfRelations := 1 );
    
    ## Objectify:
    if IsBound( is_zero_module ) then
        ObjectifyWithAttributes(
                M, TheTypeHomalgLeftFinitelyPresentedModule,
                LeftActingDomain, R,
                GeneratorsOfLeftOperatorAdditiveGroup, M!.SetsOfGenerators!.1,
                IsZero, true );
    else
        ObjectifyWithAttributes(
                M, TheTypeHomalgLeftFinitelyPresentedModule,
                LeftActingDomain, R,
                GeneratorsOfLeftOperatorAdditiveGroup, M!.SetsOfGenerators!.1 );
        
        if HasLeftGlobalDimension( R ) then
            SetUpperBoundForProjectiveDimension( M, LeftGlobalDimension( R ) );
        fi;
    fi;
    
#    SetParent( gens, M );
#    SetParent( rels, M );
    
    return M;
    
end );
  
##
InstallMethod( Presentation,
        "constructor",
        [ IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule ],
        
  function( rel )
    local R, is_zero_module, gens, rels, M;
    
    R := HomalgRing( rel );
    
    if NrGenerators( rel ) = 0 then ## since one doesn't specify generators here giving no relations defines the zero module
        gens := CreateSetsOfGeneratorsForRightModule( [ ], R );
        is_zero_module := true;
    else
        gens := CreateSetsOfGeneratorsForRightModule(
                        HomalgIdentityMatrix( NrGenerators( rel ), R ), rel );
    fi;
    
    rels := CreateSetsOfRelationsForRightModule( rel );
    
    M := rec( SetsOfGenerators := gens,
              SetsOfRelations := rels,
              TransitionMatrices := rec( ),
              PositionOfTheDefaultSetOfRelations := 1 );
    
    ## Objectify:
    if IsBound( is_zero_module ) then
        ObjectifyWithAttributes(
                M, TheTypeHomalgRightFinitelyPresentedModule,
                RightActingDomain, R,
                GeneratorsOfRightOperatorAdditiveGroup, M!.SetsOfGenerators!.1,
                IsZero, true );
    else
        ObjectifyWithAttributes(
                M, TheTypeHomalgRightFinitelyPresentedModule,
                RightActingDomain, R,
                GeneratorsOfRightOperatorAdditiveGroup, M!.SetsOfGenerators!.1 );
        
        if HasRightGlobalDimension( R ) then
            SetUpperBoundForProjectiveDimension( M, RightGlobalDimension( R ) );
        fi;
    fi;
    
#    SetParent( gens, M );
#    SetParent( rels, M );
    
    return M;
    
end );
  
##
InstallMethod( Presentation,
        "constructor",
        [ IsGeneratorsOfFinitelyGeneratedModuleRep and IsHomalgGeneratorsOfRightModule, IsRelationsOfFinitelyPresentedModuleRep and IsHomalgRelationsOfRightModule ],
        
  function( gen, rel )
    local R, is_zero_module, gens, rels, M;
    
    if NrGenerators( gen ) <> NrGenerators( rel ) then
        Error( "the first argument is a set of ", NrGenerators( gen ), " generator(s) while the second argument is a set of relations for ", NrGenerators( rel ), " generators\n" );
    fi;
    
    R := HomalgRing( rel );
    
    gens := CreateSetsOfGeneratorsForRightModule( gen );
    
    if NrGenerators( rel ) = 0 then
        is_zero_module := true;
    fi;
    
    rels := CreateSetsOfRelationsForRightModule( rel );
    
    M := rec( SetsOfGenerators := gens,
              SetsOfRelations := rels,
              TransitionMatrices := rec( ),
              PositionOfTheDefaultSetOfRelations := 1 );
    
    ## Objectify:
    if IsBound( is_zero_module ) then
        ObjectifyWithAttributes(
                M, TheTypeHomalgRightFinitelyPresentedModule,
                RightActingDomain, R,
                GeneratorsOfRightOperatorAdditiveGroup, M!.SetsOfGenerators!.1,
                IsZero, true );
    else
        ObjectifyWithAttributes(
                M, TheTypeHomalgRightFinitelyPresentedModule,
                RightActingDomain, R,
                GeneratorsOfRightOperatorAdditiveGroup, M!.SetsOfGenerators!.1 );
        
        if HasRightGlobalDimension( R ) then
            SetUpperBoundForProjectiveDimension( M, RightGlobalDimension( R ) );
        fi;
    fi;
    
#    SetParent( gens, M );
#    SetParent( rels, M );
    
    return M;
    
end );
  
##
InstallMethod( LeftPresentation,
        "constructor",
        [ IsList, IsHomalgRing ],
        
  function( rel, R )
    local gens, rels, M, is_zero_module;
    
    if Length( rel ) = 0 then	## since one doesn't specify generators here giving no relations defines the zero module
        gens := CreateSetsOfGeneratorsForLeftModule( [ ], R );
        is_zero_module := true;
    elif IsList( rel[1] ) and ForAll( rel[1], IsRingElement ) then
        gens := CreateSetsOfGeneratorsForLeftModule(
                        HomalgIdentityMatrix( Length( rel[1] ), R ), rel );
    else ## only one generator
        gens := CreateSetsOfGeneratorsForLeftModule(
                        HomalgIdentityMatrix( 1, R ), rel );
    fi;
    
    rels := CreateSetsOfRelationsForLeftModule( rel, R );
    
    M := rec( SetsOfGenerators := gens,
              SetsOfRelations := rels,
              TransitionMatrices := rec( ),
              PositionOfTheDefaultSetOfRelations := 1 );
    
    ## Objectify:
    if IsBound( is_zero_module ) then
        ObjectifyWithAttributes(
                M, TheTypeHomalgLeftFinitelyPresentedModule,
                LeftActingDomain, R,
                GeneratorsOfLeftOperatorAdditiveGroup, M!.SetsOfGenerators!.1,
                IsZero, true );
    else
        ObjectifyWithAttributes(
                M, TheTypeHomalgLeftFinitelyPresentedModule,
                LeftActingDomain, R,
                GeneratorsOfLeftOperatorAdditiveGroup, M!.SetsOfGenerators!.1 );
        
        if HasLeftGlobalDimension( R ) then
            SetUpperBoundForProjectiveDimension( M, LeftGlobalDimension( R ) );
        fi;
    fi;
    
#    SetParent( gens, M );
#    SetParent( rels, M );
    
    return M;
    
end );
  
##
InstallMethod( LeftPresentation,
        "constructor",
        [ IsList, IsList, IsHomalgRing ],
        
  function( gen, rel, R )
    local gens, rels, M;
    
    gens := CreateSetsOfGeneratorsForLeftModule( gen, R );
    
    if rel = [ ] and gen <> [ ] then
        rels := CreateSetsOfRelationsForLeftModule( "unknown relations", R );
    else
        rels := CreateSetsOfRelationsForLeftModule( rel, R );
    fi;
    
    M := rec( SetsOfGenerators := gens,
              SetsOfRelations := rels,
              TransitionMatrices := rec( ),
              PositionOfTheDefaultSetOfRelations := 1 );
    
    ## Objectify:
    ObjectifyWithAttributes(
            M, TheTypeHomalgLeftFinitelyPresentedModule,
            LeftActingDomain, R,
            GeneratorsOfLeftOperatorAdditiveGroup, M!.SetsOfGenerators!.1 );
    
    
    if HasLeftGlobalDimension( R ) then
        SetUpperBoundForProjectiveDimension( M, LeftGlobalDimension( R ) );
    fi;
    
#    SetParent( gens, M );
#    SetParent( rels, M );
    
    return M;
    
end );

##  <#GAPDoc Label="LeftPresentation">
##  <ManSection>
##    <Oper Arg="mat" Name="LeftPresentation" Label="constructor for left modules"/>
##    <Returns>a &homalg; module</Returns>
##    <Description>
##      This constructor returns the finitely presented left module with relations given by the
##      rows of the &homalg; matrix <A>mat</A>.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> M := HomalgMatrix( "[ \
##  > 2, 3, 4, \
##  > 5, 6, 7  \
##  > ]", 2, 3, ZZ );
##  <A homalg internal 2 by 3 matrix>
##  gap> M := LeftPresentation( M );
##  <A non-zero left module presented by 2 relations for 3 generators>
##  gap> Display( M );
##  [ [  2,  3,  4 ],
##    [  5,  6,  7 ] ]
##  
##  Cokernel of the map
##  
##  Z^(1x2) --> Z^(1x3),
##  
##  currently represented by the above matrix
##  gap> ByASmallerPresentation( M );
##  <A non-zero left module presented by 1 relation for 2 generators>
##  gap> Display( last );
##  Z/< 3 > + Z^(1 x 1)
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( LeftPresentation,
        "constructor",
        [ IsHomalgMatrix ],
        
  function( mat )
    
    return Presentation( HomalgRelationsForLeftModule( mat ) );
    
end );

##
InstallMethod( RightPresentation,
        "constructor",
        [ IsList, IsHomalgRing ],
        
  function( rel, R )
    local gens, rels, M, is_zero_module;
    
    if Length( rel ) = 0 then	## since one doesn't specify generators here giving no relations defines the zero module
        gens := CreateSetsOfGeneratorsForRightModule( [ ], R );
        is_zero_module := true;
    elif IsList( rel[1] ) and ForAll( rel[1], IsRingElement ) then
        gens := CreateSetsOfGeneratorsForRightModule(
                        HomalgIdentityMatrix( Length( rel ), R ), rel );
    else ## only one generator
        gens := CreateSetsOfGeneratorsForRightModule(
                        HomalgIdentityMatrix( 1, R ), rel );
    fi;
    
    rels := CreateSetsOfRelationsForRightModule( rel, R );
    
    M := rec( SetsOfGenerators := gens,
              SetsOfRelations := rels,
              TransitionMatrices := rec( ),
              PositionOfTheDefaultSetOfRelations := 1 );
    
    ## Objectify:
    if IsBound( is_zero_module ) then
        ObjectifyWithAttributes(
                M, TheTypeHomalgRightFinitelyPresentedModule,
                RightActingDomain, R,
                GeneratorsOfRightOperatorAdditiveGroup, M!.SetsOfGenerators!.1,
                IsZero, true );
    else
        ObjectifyWithAttributes(
                M, TheTypeHomalgRightFinitelyPresentedModule,
                RightActingDomain, R,
                GeneratorsOfRightOperatorAdditiveGroup, M!.SetsOfGenerators!.1 );
        
        if HasRightGlobalDimension( R ) then
            SetUpperBoundForProjectiveDimension( M, RightGlobalDimension( R ) );
        fi;
    fi;
    
#    SetParent( gens, M );
#    SetParent( rels, M );
    
    return M;
    
end );
  
##
InstallMethod( RightPresentation,
        "constructor",
        [ IsList, IsList, IsHomalgRing ],
        
  function( gen, rel, R )
    local gens, rels, M;
    
    gens := CreateSetsOfGeneratorsForRightModule( gen, R );
    
    if rel = [ ] and gen <> [ ] then
        rels := CreateSetsOfRelationsForRightModule( "unknown relations", R );
    else
        rels := CreateSetsOfRelationsForRightModule( rel, R );
    fi;
    
    M := rec( SetsOfGenerators := gens,
              SetsOfRelations := rels,
              TransitionMatrices := rec( ),
              PositionOfTheDefaultSetOfRelations := 1 );
    
    ## Objectify:
    ObjectifyWithAttributes(
            M, TheTypeHomalgRightFinitelyPresentedModule,
            RightActingDomain, R,
            GeneratorsOfRightOperatorAdditiveGroup, M!.SetsOfGenerators!.1 );
    
        
    if HasRightGlobalDimension( R ) then
        SetUpperBoundForProjectiveDimension( M, RightGlobalDimension( R ) );
    fi;
    
#    SetParent( gens, M );
#    SetParent( rels, M );
    
    return M;
    
end );

##  <#GAPDoc Label="RightPresentation">
##  <ManSection>
##    <Oper Arg="mat" Name="RightPresentation" Label="constructor for right modules"/>
##    <Returns>a &homalg; module</Returns>
##    <Description>
##      This constructor returns the finitely presented right module with relations given by the
##      columns of the &homalg; matrix <A>mat</A>.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> M := HomalgMatrix( "[ \
##  > 2, 3, 4, \
##  > 5, 6, 7  \
##  > ]", 2, 3, ZZ );
##  <A homalg internal 2 by 3 matrix>
##  gap> M := RightPresentation( M );
##  <A right module on 2 generators satisfying 3 relations>
##  gap> ByASmallerPresentation( M );
##  <A cyclic right module on a cyclic generator satisfying 1 relation>
##  gap> Display( last );
##  Z/< 3 >
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( RightPresentation,
        "constructor",
        [ IsHomalgMatrix ],
        
  function( mat )
    
    return Presentation( HomalgRelationsForRightModule( mat ) );
    
end );

##  <#GAPDoc Label="HomalgFreeLeftModule">
##  <ManSection>
##    <Oper Arg="r, R" Name="HomalgFreeLeftModule" Label="constructor for free left modules"/>
##    <Returns>a &homalg; module</Returns>
##    <Description>
##      This constructor returns a free left module of rank <A>r</A> over the &homalg; ring <A>R</A>.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> F := HomalgFreeLeftModule( 1, ZZ );
##  <A free left module of rank 1 on a free generator>
##  gap> 1 * ZZ;
##  <The free left module of rank 1 on a free generator>
##  gap> F := HomalgFreeLeftModule( 2, ZZ );
##  <A free left module of rank 2 on free generators>
##  gap> 2 * ZZ;
##  <A free left module of rank 2 on free generators>
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( HomalgFreeLeftModule,
        "constructor",
        [ IsInt, IsHomalgRing ],
        
  function( rank, R )
    
    return LeftPresentation( HomalgZeroMatrix( 0, rank, R ) );
    
end );

##  <#GAPDoc Label="HomalgFreeRightModule">
##  <ManSection>
##    <Oper Arg="r, R" Name="HomalgFreeRightModule" Label="constructor for free right modules"/>
##    <Returns>a &homalg; module</Returns>
##    <Description>
##      This constructor returns a free right module of rank <A>r</A> over the &homalg; ring <A>R</A>.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> F := HomalgFreeRightModule( 1, ZZ );
##  <A free right module of rank 1 on a free generator>
##  gap> ZZ * 1;
##  <The free right module of rank 1 on a free generator>
##  gap> F := HomalgFreeRightModule( 2, ZZ );
##  <A free right module of rank 2 on free generators>
##  gap> ZZ * 2;
##  <A free right module of rank 2 on free generators>
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( HomalgFreeRightModule,
        "constructor",
        [ IsInt, IsHomalgRing ],
        
  function( rank, R )
    
    return RightPresentation( HomalgZeroMatrix( rank, 0, R ) );
    
end );

##  <#GAPDoc Label="HomalgZeroLeftModule">
##  <ManSection>
##    <Oper Arg="r, R" Name="HomalgZeroLeftModule" Label="constructor for zero left modules"/>
##    <Returns>a &homalg; module</Returns>
##    <Description>
##      This constructor returns a zero left module of rank <A>r</A> over the &homalg; ring <A>R</A>.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> F := HomalgZeroLeftModule( ZZ );
##  <A zero left module>
##  gap> 0 * ZZ;
##  <The zero left module>
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( HomalgZeroLeftModule,
        "constructor",
        [ IsHomalgRing ],
        
  function( R )
    
    return HomalgFreeLeftModule( 0, R );
    
end );

##  <#GAPDoc Label="HomalgZeroRightModule">
##  <ManSection>
##    <Oper Arg="r, R" Name="HomalgZeroRightModule" Label="constructor for zero right modules"/>
##    <Returns>a &homalg; module</Returns>
##    <Description>
##      This constructor returns a zero right module of rank <A>r</A> over the &homalg; ring <A>R</A>.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> F := HomalgZeroRightModule( ZZ );
##  <A zero right module>
##  gap> ZZ * 0;
##  <The zero right module>
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( HomalgZeroRightModule,
        "constructor",
        [ IsHomalgRing ],
        
  function( R )
    
    return HomalgFreeRightModule( 0, R );
    
end );

##
InstallMethod( \*,
        "constructor",
        [ IsInt, IsHomalgRing ],
        
  function( rank, R )
    
    if rank = 0 then
        return R!.ZeroLeftModule;
    elif rank = 1 then
        return AsLeftModule( R );
    elif rank > 1 then
        return HomalgFreeLeftModule( rank, R );
    fi;
    
    Error( "virtual modules are not supported (yet)\n" );
    
end );

##
InstallMethod( \*,
        "constructor",
        [ IsHomalgRing, IsInt ],
        
  function( R, rank )
    
    if rank = 0 then
        return R!.ZeroRightModule;
    elif rank = 1 then
        return AsRightModule( R );
    elif rank > 1 then
        return HomalgFreeRightModule( rank, R );
    fi;
    
    Error( "virtual modules are not supported (yet)\n" );
    
end );

##
InstallMethod( LeftPresentationWithDegrees,
        "constructor",
        [ IsHomalgMatrix, IsList ],
        
  function( mat, weights )
    local M;
    
    if Length( weights ) <> NrColumns( mat ) then
        Error( "the number of weights must coincide with the number of columns\n" );
    fi;
    
    M := LeftPresentation( mat );
    
    GeneratorsOfModule( M )!.DegreesOfGenerators := weights;
    RelationsOfModule( M )!.DegreesOfGenerators := weights;
    
    return M;
    
end );

##
InstallMethod( LeftPresentationWithDegrees,
        "constructor",
        [ IsHomalgMatrix, IsInt ],
        
  function( mat, weight )
    
    return LeftPresentationWithDegrees( mat, ListWithIdenticalEntries( NrColumns( mat ), weight ) );
    
end );

##
InstallMethod( LeftPresentationWithDegrees,
        "constructor",
        [ IsHomalgMatrix ],
        
  function( mat )
    
    return LeftPresentationWithDegrees( mat, ListWithIdenticalEntries( NrColumns( mat ), 0 ) );
    
end );

##
InstallMethod( RightPresentationWithDegrees,
        "constructor",
        [ IsHomalgMatrix, IsList ],
        
  function( mat, weights )
    local M;
    
    if Length( weights ) <> NrRows( mat ) then
        Error( "the number of weights must coincide with the number of rows\n" );
    fi;
    
    M := RightPresentation( mat );
    
    GeneratorsOfModule( M )!.DegreesOfGenerators := weights;
    RelationsOfModule( M )!.DegreesOfGenerators := weights;
    
    return M;
    
end );

##
InstallMethod( RightPresentationWithDegrees,
        "constructor",
        [ IsHomalgMatrix, IsInt ],
        
  function( mat, weight )
    
    return RightPresentationWithDegrees( mat, ListWithIdenticalEntries( NrRows( mat ), weight ) );
    
end );

##
InstallMethod( RightPresentationWithDegrees,
        "constructor",
        [ IsHomalgMatrix ],
        
  function( mat )
    
    return RightPresentationWithDegrees( mat, ListWithIdenticalEntries( NrRows( mat ), 0 ) );
    
end );

##
InstallMethod( HomalgFreeLeftModuleWithDegrees,
        "constructor",
        [ IsHomalgRing, IsList ],
        
  function( R, weights )
    
    return LeftPresentationWithDegrees( HomalgZeroMatrix( 0, Length( weights ), R ), weights );
    
end );

##
InstallMethod( HomalgFreeLeftModuleWithDegrees,
        "constructor",
        [ IsInt, IsHomalgRing, IsInt ],
        
  function( rank, R, weight )
    
    return HomalgFreeLeftModuleWithDegrees( R, ListWithIdenticalEntries( rank, weight ) );
    
end );

##
InstallMethod( HomalgFreeLeftModuleWithDegrees,
        "constructor",
        [ IsInt, IsHomalgRing ],
        
  function( rank, R )
    
    return HomalgFreeLeftModuleWithDegrees( rank, R, 0 );
    
end );

##
InstallMethod( HomalgFreeRightModuleWithDegrees,
        "constructor",
        [ IsHomalgRing, IsList ],
        
  function( R, weights )
    
    return RightPresentationWithDegrees( HomalgZeroMatrix( Length( weights ), 0, R ), weights );
    
end );

##
InstallMethod( HomalgFreeRightModuleWithDegrees,
        "constructor",
        [ IsInt, IsHomalgRing, IsInt ],
        
  function( rank, R, weight )
    
    return HomalgFreeRightModuleWithDegrees( R, ListWithIdenticalEntries( rank, weight ) );
    
end );

##
InstallMethod( HomalgFreeRightModuleWithDegrees,
        "constructor",
        [ IsInt, IsHomalgRing ],
        
  function( rank, R )
    
    return HomalgFreeRightModuleWithDegrees( rank, R, 0 );
    
end );

##
InstallMethod( POW,
        "constructor",
        [ IsHomalgRing, IsInt ],
        
  function( R, twist )
    local On;
    
    if not IsBound( R!.left_twists ) then
        R!.left_twists := rec( );
    fi;
    
    On := HomalgFreeLeftModuleWithDegrees( 1, R, -twist );
    
    On!.distinguished := true;
    
    if not IsBound( R!.left_twists.(String( twist )) ) then
        R!.left_twists.(String( twist )) := On;
    fi;
    
    return R!.left_twists.(String( twist ));
    
end );

##
InstallMethod( POW,
        "constructor",
        [ IsHomalgRing, IsList ],
        
  function( R, twist )
    
    return HomalgFreeLeftModuleWithDegrees( R, -twist );
    
end );

##
InstallMethod( POW,
        "constructor",
        [ IsFinitelyPresentedModuleRep, IsInt ],
        
  function( M, twist )
    local R, On;
    
    R := HomalgRing( M );
    
    if IsIdenticalObj( M, 1 * R ) then
        
        return R^twist;
        
    elif IsIdenticalObj( M, R * 1 ) then
        
        if not IsBound( R!.right_twists ) then
            R!.right_twists := rec( );
        fi;
        
        On := HomalgFreeRightModuleWithDegrees( 1, R, -twist );
        
        On!.distinguished := true;
        
        if not IsBound( R!.right_twists.(String( twist )) ) then
            R!.right_twists.(String( twist )) := On;
        fi;
        
        return R!.right_twists.(String( twist ));
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \*,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep, IsHomalgRing ], 10001,
        
  function( M, R )
    
    return Subobject( R * M!.map_having_subobject_as_its_image );
    
end );

##  <#GAPDoc Label="\*:ModuleBaseChange">
##  <ManSection>
##    <Oper Arg="M, R" Name="\*" Label="transfer a module over a different ring"/>
##    <Oper Arg="R, M" Name="\*" Label="transfer a module over a different ring (left)"/>
##    <Returns>a &homalg; module</Returns>
##    <Description>
##      Transfers the <M>S</M>-module <A>M</A> over the &homalg; ring <A>R</A>. This works only in three cases:
##      <Enum>
##        <Item><M>S</M> is a subring of <A>R</A>.</Item>
##        <Item><A>R</A> is a residue class ring of <M>S</M> constructed using <C>/</C>
##        (&see; <Ref Oper="\/" Label="constructor for residue class rings" Style="Number"/>).</Item>
##        <Item><A>R</A> is a subring of <M>S</M> and the entries of the current matrix of <M>S</M>-relations of <A>M</A>
##          lie in <A>R</A>.</Item>
##      </Enum>
##      CAUTION: So it not suited for general base change.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );;
##  gap> Z4 := ZZ / [ 4 ];;
##  gap> Display( Z4 );
##  Z/( 4 )
##  gap> M := HomalgDiagonalMatrix( [ 2 .. 4 ], ZZ );
##  <An unevaluated diagonal homalg internal 3 by 3 matrix>
##  gap> M := LeftPresentation( M );
##  <A left module presented by 3 relations for 3 generators>
##  gap> N := Z4 * M;
##  <A non-zero left module presented by 2 relations for 3 generators>
##  gap> Display( M );
##  Z/< 2 > + Z/< 3 > + Z/< 4 >
##  gap> Display( N );
##  Z/( 4 )/< 2 > + Z/( 4 )^(1 x 1)
##  gap> M;
##  <A torsion left module presented by 3 relations for 3 generators>
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( \*,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep, IsHomalgRing ], 10001,
        
  function( M, R )
    local N;
    
    if IsIdenticalObj( HomalgRing( M ), R ) then
        TryNextMethod( );
    fi;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        if IsList( DegreesOfGenerators( M ) ) then
            N := LeftPresentationWithDegrees( MatrixOfRelations( M ) * R, DegreesOfGenerators( M ) );
        else
            N := LeftPresentation( MatrixOfRelations( M ) * R );
        fi;
    else
        if IsList( DegreesOfGenerators( M ) ) then
            N := RightPresentationWithDegrees( MatrixOfRelations( M ) * R, DegreesOfGenerators( M ) );
        else
            N := RightPresentation( MatrixOfRelations( M ) * R );
        fi;
    fi;
    
    return N * R;
    
end );

##
InstallMethod( \*,
        "for homalg modules",
        [ IsHomalgRing, IsHomalgModule ], 10001,
        
  function( R, M )
    
    return  M * R;
    
end );

##
InstallGlobalFunction( GetGenerators,
  function( arg )
    local nargs, M, pos, g, gen, mat, proc, l;
    
    nargs := Length( arg );
    
    if nargs > 0 and IsFinitelyPresentedModuleRep( arg[1] ) then
        
        M := arg[1];
        
        if nargs > 2 and IsPosInt( arg[3] ) then
            pos := arg[3];
        else
            pos := PositionOfTheDefaultSetOfGenerators( M );
        fi;
        
        gen := GeneratorsOfModule( M, pos );
        
    elif nargs > 0 and IsGeneratorsOfFinitelyGeneratedModuleRep( arg[1] ) then
        
        gen := arg[1];
        
    else
        
        Error( "the first argument must be a homalg module or a set of generators of a homalg module\n" );
        
    fi;
    
    g := [ 1 .. NrGenerators( gen ) ];
    
    if nargs > 1 then
        if IsPosInt( arg[2] ) then
            g := [ arg[2] ];
        elif IsHomogeneousList( arg[2] ) and ForAll( arg[2], IsPosInt ) then
            g := arg[2];
        fi;
    fi;
    
    mat := MatrixOfGenerators( gen );
    
    if IsHomalgGeneratorsOfLeftModule( gen ) then
        g := List( g, a -> CertainRows( mat, [ a ] ) );
    else
        g := List( g, a -> CertainColumns( mat, [ a ] ) );
    fi;
    
    if HasProcedureToReadjustGenerators( gen ) then
        proc := ProcedureToReadjustGenerators( gen );
        l := Length( proc );
        g := List( g, a -> CallFuncList( proc[1], Concatenation( [ a ], proc{[ 2 .. l ]} ) ) );
    fi;
    
    if nargs > 1 and IsPosInt( arg[2] ) then
        return g[1];
    fi;
    
    return g;
    
end );

##  <#GAPDoc Label="Subobject:map">
##  <ManSection>
##    <Oper Arg="phi" Name="Subobject" Label="constructor for submodules using maps"/>
##    <Returns>a &homalg; submodule</Returns>
##    <Description>
##      A synonym of <Ref Attr="ImageSubmodule" Label="for maps"/>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Subobject,
        "constructor",
        [ IsHomalgMap ],
        
  ImageSubmodule );

##  <#GAPDoc Label="Subobject">
##  <ManSection>
##    <Oper Arg="mat,M" Name="Subobject" Label="constructor for submodules"/>
##    <Returns>a &homalg; submodule</Returns>
##    <Description>
##      This constructor returns the finitely generated left/right submodule of the &homalg; module <A>M</A> with generators given by the
##      rows/columns of the &homalg; matrix <A>mat</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Subobject,
        "constructor",
        [ IsHomalgMatrix, IsFinitelyPresentedModuleRep ],
        
  function( gen, M )
    local gen_map;
    
    if not IsIdenticalObj( HomalgRing( gen ), HomalgRing( M ) ) then
        Error( "the matrix and the module are not defined over identically the same ring\n" );
    fi;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        if NrColumns( gen ) <> NrGenerators( M ) then
            Error( "the first argument is matrix with ", NrColumns( gen )," columns while the second argument is a module on ", NrGenerators( M ), " generators\n" );
        fi;
    else
        if NrRows( gen ) <> NrGenerators( M ) then
            Error( "the first argument is matrix with ", NrRows( gen )," rows while the second argument is a module on ", NrGenerators( M ), " generators\n" );
        fi;
    fi;
    
    gen_map := HomalgMap( gen, "free", M  );
    
    return ImageSubmodule( gen_map );
    
end );

##  <#GAPDoc Label="LeftSubmodule">
##  <ManSection>
##    <Oper Arg="mat" Name="LeftSubmodule" Label="constructor for left submodules"/>
##    <Returns>a &homalg; submodule</Returns>
##    <Description>
##      This constructor returns the finitely generated left submodule with generators given by the
##      rows of the &homalg; matrix <A>mat</A>.
##      <Listing Type="Code"><![CDATA[
InstallMethod( LeftSubmodule,
        "constructor",
        [ IsHomalgMatrix ],
        
  function( gen )
    local R;
    
    R := HomalgRing( gen );
    
    return Subobject( gen, NrColumns( gen ) * R );
    
end );
##  ]]></Listing>
##      <Example><![CDATA[
##  gap> Z4 := HomalgRingOfIntegers( ) / 4;;
##  gap> J := HomalgMatrix( "[ 2 ]", 1, 1, Z4 );
##  <A homalg internal 1 by 1 matrix>
##  gap> J := LeftSubmodule( J );
##  <A principal (left) ideal given by a cyclic generator>
##  gap> IsFree( J );
##  false
##  gap> J;
##  <A principal reflexive non-projective (left) ideal given by a cyclic generator\
##  >
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="RightSubmodule">
##  <ManSection>
##    <Oper Arg="mat" Name="RightSubmodule" Label="constructor for right submodules"/>
##    <Returns>a &homalg; submodule</Returns>
##    <Description>
##      This constructor returns the finitely generated right submodule with generators given by the
##      columns of the &homalg; matrix <A>mat</A>.
##      <Listing Type="Code"><![CDATA[
InstallMethod( RightSubmodule,
        "constructor",
        [ IsHomalgMatrix ],
        
  function( gen )
    local R;
    
    R := HomalgRing( gen );
    
    return Subobject( gen, R * NrRows( gen ) );
    
end );
##  ]]></Listing>
##      <Example><![CDATA[
##  gap> Z4 := HomalgRingOfIntegers( ) / 4;;
##  gap> J := HomalgMatrix( "[ 2 ]", 1, 1, Z4 );
##  <A homalg internal 1 by 1 matrix>
##  gap> J := RightSubmodule( J );
##  <A principal (right) ideal given by a cyclic generator>
##  gap> IsFree( J );
##  false
##  gap> J;
##  <A principal reflexive non-projective (right) ideal given by a cyclic generato\
##  r>
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

## create a globally defined ring of integers
HOMALG.ZZ := HomalgRingOfIntegers( );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for homalg modules",
        [ IsHomalgModule ],
        
  function( o )
    local is_submodule, M, R, left_module, num_gen, properties, nz, num_rel,
          gen_string, rel_string, locked;
    
    is_submodule := IsFinitelyPresentedSubmoduleRep( o );
    
    if is_submodule then
        M := UnderlyingObject( o );
        if HasIsFree( M ) and IsFree( M ) then
            SetIsFree( o, true );
            ViewObj( o );
            return;
        elif HasIsZero( M ) and IsZero( M ) then
            SetIsZero( o, true );
            ViewObj( o );
            return;
        fi;
    else
        M := o;
    fi;
    
    R := HomalgRing( M );
    
    left_module := IsHomalgLeftObjectOrMorphismOfLeftObjects( M );
    
    num_gen := NrGenerators( M );
    
    if num_gen = 1 then
        SetIsCyclic( M, true );
        num_gen := "a cyclic";
    fi;
    
    properties := "";
    
    if HasIsCyclic( M ) and IsCyclic( M ) then
        if is_submodule then
            Append( properties, " principal" );
        else
            Append( properties, " cyclic" );
        fi;
    fi;
    
    if HasIsStablyFree( M ) and IsStablyFree( M ) then
        Append( properties, " stably free" );
        if HasIsFree( M ) and not IsFree( M ) then	## the "not"s are obsolete but kept for better readability
            Append( properties, " non-free" );
            nz := true;
        fi;
    elif HasIsProjective( M ) and IsProjective( M ) then
        Append( properties, " projective" );
        if HasIsStablyFree( M ) and not IsStablyFree( M ) then
            Append( properties, " non-stably free" );
            nz := true;
        elif HasIsFree( M ) and not IsFree( M ) then
            Append( properties, " non-free" );
            nz := true;
        fi;
    elif HasIsReflexive( M ) and IsReflexive( M ) then
        Append( properties, " reflexive" );
        if HasIsProjective( M ) and not IsProjective( M ) then
            Append( properties, " non-projective" );
            nz := true;
        elif HasIsStablyFree( M ) and not IsStablyFree( M ) then
            Append( properties, " non-stably free" );
            nz := true;
        elif HasIsFree( M ) and not IsFree( M ) then
            Append( properties, " non-free" );
            nz := true;
        fi;
    elif HasIsTorsionFree( M ) and IsTorsionFree( M ) then
        if HasCodegreeOfPurity( M ) then
            if CodegreeOfPurity( M ) = [ 1 ] then
                Append( properties, Concatenation( " codegree-", String( 1 ), "-pure" ) );
            else
                Append( properties, Concatenation( " codegree-", String( CodegreeOfPurity( M ) ), "-pure" ) );
            fi;
            if not ( HasRankOfModule( M ) and RankOfModule( M ) > 0 ) then
                Print( " torsion-free" );
            fi;
            nz := true;
        else
            Append( properties, " torsion-free" );
            if HasIsReflexive( M ) and not IsReflexive( M ) then
                Append( properties, " non-reflexive" );
                nz := true;
            elif HasIsProjective( M ) and not IsProjective( M ) then
                Append( properties, " non-projective" );
                nz := true;
            elif HasIsStablyFree( M ) and not IsStablyFree( M ) then
                Append( properties, " non-stably free" );
                nz := true;
            elif HasIsFree( M ) and not IsFree( M ) then
                Append( properties, " non-free" );
                nz := true;
            fi;
        fi;
    fi;
    
    if HasIsTorsion( M ) and IsTorsion( M ) then
        if HasCodim( M ) then
            if HasIsPure( M ) then
                if IsPure( M ) then
                    ## only display the purity information if the global dimension of the ring is > 1:
                    if not ( left_module and HasLeftGlobalDimension( R ) and LeftGlobalDimension( R ) <= 1 ) and
                       not ( not left_module and HasRightGlobalDimension( R ) and RightGlobalDimension( R ) <= 1 ) then
                        if HasCodegreeOfPurity( M ) then
                            if CodegreeOfPurity( M ) = [ 0 ] then
                                Append( properties, " reflexively " );
                            elif CodegreeOfPurity( M ) = [ 1 ] then
                                Append( properties, Concatenation( " codegree-", String( 1 ), "-" ) );
                            else
                                Append( properties, Concatenation( " codegree-", String( CodegreeOfPurity( M ) ), "-" ) );
                            fi;
                        else
                            Append( properties, " " );
                        fi;
                        Append( properties, "pure" );
                    fi;
                else
                    Append( properties, " non-pure" );
                fi;
            fi;
            Append( properties, " codim " );
            Append( properties, String( Codim( M ) ) );
        else
            if HasIsPure( M ) then
                if IsPure( M ) then
                    ## only display the purity information if the global dimension of the ring is > 1:
                    if not ( left_module and HasLeftGlobalDimension( R ) and LeftGlobalDimension( R ) <= 1 ) and
                       not ( not left_module and HasRightGlobalDimension( R ) and RightGlobalDimension( R ) <= 1 ) then
                        if HasCodegreeOfPurity( M ) then
                            if CodegreeOfPurity( M ) = [ 0 ] then
                                Append( properties, " reflexively " );
                            elif CodegreeOfPurity( M ) = [ 1 ] then
                                Append( properties, Concatenation( " codegree-", String( 1 ), "-" ) );
                            else
                                Append( properties, Concatenation( " codegree-", String( CodegreeOfPurity( M ) ), "-" ) );
                            fi;
                        else
                            Append( properties, " " );
                        fi;
                        Append( properties, "pure" );
                    fi;
                else
                    Append( properties, " non-pure" );
                fi;
            elif HasIsZero( M ) and not IsZero( M ) then
                properties := Concatenation( " non-zero", properties );
            fi;
            Append( properties, " torsion" );
        fi;
    else
        if HasIsPure( M ) and not IsPure( M ) then
            Append( properties, " non-pure" );
        fi;
        if HasRankOfModule( M ) then
            Append( properties, " rank " );
            Append( properties, String( RankOfModule( M ) ) );
        elif HasIsZero( M ) and not IsZero( M ) and
          not ( HasIsPure( M ) and not IsPure( M ) ) and
          not ( IsBound( nz ) and nz = true ) then
            properties := Concatenation( " non-zero", properties );
        fi;
    fi;
    
    if IsList( DegreesOfGenerators( M ) ) then
        properties := Concatenation( " graded", properties );
    fi;
    
    if left_module then
        
        if IsInt( num_gen ) then
            gen_string := " generators";
        else
            gen_string := " generator";
        fi;
        
        if not is_submodule then
            if HasNrRelations( o ) = true then
                num_rel := NrRelations( o );
                if num_rel = 0 then
                    num_rel := "";
                    rel_string := "no relations for ";
                elif num_rel = 1 then
                    rel_string := " relation for ";
                else
                    rel_string := " relations for ";
                fi;
            else
                if RelationsOfModule( o ) = "unknown relations" then
                    num_rel := "unknown";
                else
                    num_rel := "an unknown number of";
                fi;
                rel_string := " relations for ";
            fi;
        fi;
        
        if IsLockedModule( o ) then
            locked := " (locked)";
        else
            locked := "";
        fi;
        
        if is_submodule then
            if IsIdenticalObj( SuperObject( o ), 1 * R ) or
               IsIdenticalObj( SuperObject( o ), ( 1 * R )^0 ) then
                if HasIsCommutative( R ) and IsCommutative( R ) then
                    Print( "<A", properties, " (left) ideal given by ", num_gen, gen_string, locked, ">" );
                else
                    Print( "<A", properties, " left ideal given by ", num_gen, gen_string, locked, ">" );
                fi;
            else
                Print( "<A", properties, " left submodule given by ", num_gen, gen_string, locked, ">" );
            fi;
        else
            Print( "<A", properties, " left module presented by ", num_rel, rel_string, num_gen, gen_string, locked, ">" );
        fi;
        
    else
        
        if is_submodule then
            if IsInt( num_gen ) then
                gen_string := " generators";
            else
                gen_string := " generator";
            fi;
        else
            if IsInt( num_gen ) then
                gen_string := " generators satisfying ";
            else
                gen_string := " generator satisfying ";
            fi;
        fi;
        
        if not is_submodule then
            if HasNrRelations( o ) = true then
                num_rel := NrRelations( o );
                if num_rel = 0 then
                    num_rel := "";
                    rel_string := "no relations";
                elif num_rel = 1 then
                    rel_string := " relation";
                else
                    rel_string := " relations";
                fi;
            else
                if RelationsOfModule( o ) = "unknown relations" then
                    num_rel := "unknown";
                else
                    num_rel := "an unknown number of";
                fi;
                rel_string := " relations";
            fi;
        fi;
        
        if IsLockedModule( o ) then
            locked := " (locked)";
        else
            locked := "";
        fi;
        
        if is_submodule then
            if IsIdenticalObj( SuperObject( o ), R * 1 ) or
               IsIdenticalObj( SuperObject( o ), ( R * 1 )^0 ) then
                if HasIsCommutative( R ) and IsCommutative( R ) then
                    Print( "<A", properties, " (right) ideal given by ", num_gen, gen_string, locked, ">" );
                else
                    Print( "<A", properties, " right ideal given by ", num_gen, gen_string, locked, ">" );
                fi;
            else
                Print( "<A", properties, " right submodule given by ", num_gen, gen_string, locked, ">" );
            fi;
        else
            Print( "<A", properties, " right module on ", num_gen, gen_string, num_rel, rel_string, locked, ">" );
        fi;
        
    fi;
    
end );

##
InstallMethod( ViewObj,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep and IsFree ], 1001, ## since we don't use the filter IsHomalgLeftObjectOrMorphismOfLeftObjects it is good to set the ranks high
        
  function( J )
    local M, left, R, r, rk;
    
    M := UnderlyingObject( J );
    
    left := IsHomalgLeftObjectOrMorphismOfLeftObjects( M );
    
    R := HomalgRing( M );
    
    Print( "<A " );
    
    if IsList( DegreesOfGenerators( M ) ) then
        Print( "graded " );
    fi;
    
    if left then
        if IsIdenticalObj( SuperObject( J ), 1 * R ) then
            Print( "principal " );
            if HasIsCommutative( R ) and IsCommutative( R ) then
                Print( "(left) " );
            else
                Print( "left " );
            fi;
            Print( "ideal" );
        else
            Print( "free left sumboule" );
        fi;
    else
        if IsIdenticalObj( SuperObject( J ), R * 1 ) then
            Print( "principal " );
            if HasIsCommutative( R ) and IsCommutative( R ) then
                Print( "(right) " );
            else
                Print( "right " );
            fi;
            Print( "ideal" );
        else
            Print( "free right sumboule" );
        fi;
    fi;
    
    r := NrGenerators( M );
    
    if HasRankOfModule( M ) then
        rk := RankOfModule( M );
        Print( " of rank ", rk, " on " );
        if r = rk then
            if r = 1 then
                Print( "a free generator" );
            else
                Print( "free generators" );
            fi;
        else ## => r > 1
            Print( r, " non-free generators" );
        fi;
    fi;
    
    Print( ">" );
    
end );
    
##
InstallMethod( ViewObj,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep and IsFree ], 1001, ## since we don't use the filter IsHomalgLeftObjectOrMorphismOfLeftObjects it is good to set the ranks high
        
  function( M )
    local r, rk, d;
    
    if IsBound( M!.distinguished ) then
        Print( "<The" );
    else
        Print( "<A" );
    fi;
    
    if IsList( DegreesOfGenerators( M ) ) then
        Print( " graded" );
    fi;
    
    Print( " free " );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        Print( "left" );
    else
        Print( "right" );
    fi;
    
    Print( " module" );
    
    r := NrGenerators( M );
    
    if HasRankOfModule( M ) then
        rk := RankOfModule( M );
        Print( " of rank ", rk );
        
        if IsBound( M!.distinguished ) then
            d := DegreesOfGenerators( M );
            if IsList( d ) and Length( d ) = 1 and d[1] <> 0 then
                Print( " shifted by ", -d[1] );
            fi;
        fi;
        
        Print( " on " );
        if r = rk then
            if r = 1 then
                Print( "a free generator" );
            else
                Print( "free generators" );
            fi;
        else ## => r > 1
            Print( r, " non-free generators" );
        fi;
    fi;
    
    Print( ">" );
    
end );
    
##
InstallMethod( ViewObj,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep and IsZero ], 1001, ## since we don't use the filter IsHomalgLeftObjectOrMorphismOfLeftObjects it is good to set the ranks high
        
  function( J )
    local M, left, R, r, rk;
    
    M := UnderlyingObject( J );
    
    left := IsHomalgLeftObjectOrMorphismOfLeftObjects( M );
    
    R := HomalgRing( M );
    
    Print( "<The zero " );
    
    if left then
        Print( "(left) " );
        if IsIdenticalObj( SuperObject( J ), 1 * R ) then
            Print( "ideal" );
        else
            Print( "sumboule" );
        fi;
    else
        Print( "(right) " );
        if IsIdenticalObj( SuperObject( J ), R * 1 ) then
            Print( "ideal" );
        else
            Print( "sumboule" );
        fi;
    fi;
    
    Print( ">" );
    
end );
    
##
InstallMethod( ViewObj,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep and IsZero ], 1001, ## since we don't use the filter IsHomalgLeftObjectOrMorphismOfLeftObjects we need to set the ranks high
        
  function( M )
    
    if IsBound( M!.distinguished ) then
        Print( "<The" );
    else
        Print( "<A" );
    fi;
    
    Print( " zero " );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        Print( "left" );
    else
        Print( "right" );
    fi;
    
    Print( " module>" );
    
end );
    
##
InstallMethod( Display,
        "for homalg submodules",
        [ IsFinitelyPresentedSubmoduleRep ],
        
  function( M )
    local R, gen, l;
    
    R := HomalgRing( M );
    
    gen := MatrixOfSubobjectGenerators( M );
    
    Display( gen );
    
    if IsList( DegreesOfGenerators( M ) ) then
        Print( "\n(graded, generators degrees: ", DegreesOfGenerators( M ), ")\n" );
    fi;
    
    Print( "\nA " );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        l := NrRows( gen );
        if IsIdenticalObj( SuperObject( M ), 1 * R ) or
           IsIdenticalObj( SuperObject( M ), ( 1 * R )^0 ) then
            if HasIsCommutative( R ) and IsCommutative( R ) then
                Print( "(left)" );
            else
                Print( "left" );
            fi;
            Print( " ideal generated by the " );
            if l = 1 then
                Print( "entry" );
            else
                Print( l, " entries" );
            fi;
        else
            Print( "left submodule generated by the " );
            if l = 1 then
                Print( "row" );
            else
                Print( l, " rows" );
            fi;
        fi;
        Print( " of the above matrix\n" );
    else
        l := NrColumns( gen );
        if IsIdenticalObj( SuperObject( M ), R * 1 ) or
           IsIdenticalObj( SuperObject( M ), ( R * 1 )^0 ) then
            if HasIsCommutative( R ) and IsCommutative( R ) then
                Print( "(right)" );
            else
                Print( "right" );
            fi;
            Print( " ideal generated by the " );
            if l = 1 then
                Print( "entry" );
            else
                Print( l, " entries" );
            fi;
        else
            Print( "right submodule generated by the " );
            if l = 1 then
                Print( "column" );
            else
                Print( l, " columns" );
            fi;
        fi;
        Print( " of the above matrix\n" );
    fi;
    
end );

##
InstallMethod( Display,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local R, l, D;
    
    R := HomalgRing( M );
    
    R := RingName( R );
    
    l := 10;
    
    if Length( R ) < l then
        D := R;
    else
        D := "R";
    fi;
    
    Display( MatrixOfRelations( M ) );
    
    if IsList( DegreesOfGenerators( M ) ) then
        Print( "\n(graded, generators degrees: ", DegreesOfGenerators( M ), ")\n" );
    fi;
    
    Print( "\nCokernel of the map\n\n" );
    
    if IsBound( HOMALG.color_display ) and HOMALG.color_display = true then
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
            Print( D, "^(1x\033[01m", NrRelations( M ), "\033[0m) --> ", D, "^(1x\033[01m", NrGenerators( M ), "\033[0m)," );
        else
            Print( D, "^(\033[01m", NrRelations( M ), "\033[0mx1) --> ", D, "^(\033[01m", NrGenerators( M ), "\033[0mx1)," );
        fi;
    else
        if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
            Print( D, "^(1x", NrRelations( M ), ") --> ", D, "^(1x", NrGenerators( M ), ")," );
        else
            Print( D, "^(", NrRelations( M ), "x1) --> ", D, "^(", NrGenerators( M ), "x1)," );
        fi;
    fi;
    
    if not IsSubset( R, "a way to display" ) and not Length( R ) < l then
        Print( " ( for ", D, " := ", R, "\033[0m )" );
    fi;
    
    Print( "\n\ncurrently represented by the above matrix\n" );
    
end );

##
InstallMethod( Display,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ], 1000,
        
  function( M )
    local r, rel, R, RP, name, elements, display, rk, get_string, color;
    
    r := NrRelations( M );
    
    rel := MatrixOfRelations( M );
    
    if not NrGenerators( M ) = 1 then
        TryNextMethod( );
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    name := RingName( R );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        elements := List( [ 1 .. r ], i -> GetEntryOfHomalgMatrix( rel, i, 1 ) );
    else
        elements := List( [ 1 .. r ], j -> GetEntryOfHomalgMatrix( rel, 1, j ) );
    fi;
    
    elements := Filtered( elements, x -> not IsZero( x ) );
    
    if IsHomalgInternalRingRep( R ) then
        get_string := String;
    else
        get_string := Name;
    fi;
    
    if IsBound( HOMALG.color_display ) and HOMALG.color_display = true then
        color := true;
    else
        color := false;
    fi;
    
    if elements <> [ ] then	## this will never happen, since the below method will catch it
        if color then
            display := List( elements, x -> [ "\033[01m", get_string( x ), "\033[0m, " ] );
        else
            display := List( elements, x -> [ get_string( x ), ", " ] );
        fi;
        display := Concatenation( display );
        display := Concatenation( display );
        Print( name, "/< ", display{ [ 1 .. Length( display ) - 2 ] }, " >" );
        
        if IsList( DegreesOfGenerators( M ) ) then
            Print( "\t (graded, generator degree: ", DegreesOfGenerators( M )[1], ")" );
        fi;
    else
        Print( "something went wrong!" );
    fi;
    
    Print( "\n" );
    
end );

##
InstallMethod( Display,
        "for homalg modules",
        [ IsFinitelyPresentedModuleRep ], 1001,
        
  function( M )
    local rel, R, RP, name, diag, display, rk, get_string, color;
    
    rel := MatrixOfRelations( M );
    
    if not HasElementaryDivisors( M ) and
       not IsDiagonalMatrix( rel ) then
        TryNextMethod( );
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    name := RingName( R );
    
    if HasElementaryDivisors( M ) then
        diag := ElementaryDivisors( M );
        rk := Length( Filtered( diag, IsZero ) );
    else
        diag := DiagonalEntries( rel );
        rk := Length( Filtered( diag, IsZero ) ) + NrGenerators( M ) - Length( diag );
    fi;
    
    ## rk is the rank if R is a domain
    
    if HasIsIntegralDomain( R ) and IsIntegralDomain( R ) and not HasRankOfModule( M ) then
        SetRankOfModule( M, rk );
    fi;
    
    diag := Filtered( diag, x -> not IsOne( x ) and not IsZero( x ) );
    
    if IsHomalgInternalRingRep( R ) then
        get_string := String;
    else
        get_string := Name;
    fi;
    
    if IsBound( HOMALG.color_display ) and HOMALG.color_display = true then
        color := true;
    else
        color := false;
    fi;
    
    if diag <> [ ] then
        if color then
            display := List( diag, x -> [ name, "/< \033[01m", get_string( x ), "\033[0m > + " ] );
        else
            display := List( diag, x -> [ name, "/< ", get_string( x ), " > + " ] );
        fi;
        display := Concatenation( display );
        display := Concatenation( display );
    else
        BasisOfModule( M );
        SetIsFree( M, true );
        display := "";
    fi;
    
    if rk <> 0 then
        if IsHomalgLeftObjectOrMorphismOfLeftObjects ( M ) then
            if color then
                Print( display, name, "^(1 x", " \033[01m", rk, "\033[0m)" );
            else
                Print( display, name, "^(1 x", " ", rk, ")" );
            fi;
        else
            if color then
                Print( display, name, "^(\033[01m", rk, "\033[0m x 1)" );
            else
                Print( display, name, "^(", rk, " x 1)" );
            fi;
        fi;
    else
        Print( display{ [ 1 .. Length( display ) - 2 ] } );
    fi;
    
    if IsList( DegreesOfGenerators( M ) ) then
        Print( "\t (graded, generators degrees: ", DegreesOfGenerators( M ), ")" );
    fi;
    
    Print( "\n" );
    
end );

##
InstallMethod( Display,
        "for homalg modules",
        [ IsHomalgModule and IsZero ], 2001, ## since we don't use the filter IsHomalgLeftObjectOrMorphismOfLeftObjects we need to set the ranks high
        
  function( M )
    
    Print( 0, "\n" );
    
end );

