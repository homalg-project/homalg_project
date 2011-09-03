#############################################################################
##
##  HomalgFunctor.gi            homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for functors.
##
#############################################################################

##  <#GAPDoc Label="Functors:intro">
##    Functors and their natural transformations form the heart of the &homalg; package. Usually, a functor is realized
##    in computer algebra systems as a procedure which can be applied to a certain type of objects. In <Cite Key="BR"/>
##    it was explained how to implement a functor of Abelian categories -- by itself -- as an object which can be
##    further manipulated (composed, derived, ...).
##    So in addition to the constructor <Ref Oper="CreateHomalgFunctor" Label="constructor for functors"/>
##    which is used to create functors from scratch, &homalg; provides further easy-to-use constructors
##    to create new functors out of existing ones:
##    <List>
##      <Item><Ref Oper="InsertObjectInMultiFunctor" Label="constructor for functors given a multi-functor and an object"/></Item>
##      <Item><Ref Oper="RightSatelliteOfCofunctor" Label="constructor of the right satellite of a contravariant functor"/></Item>
##      <Item><Ref Oper="LeftSatelliteOfFunctor" Label="constructor of the left satellite of a covariant functor"/></Item>
##      <Item><Ref Oper="RightDerivedCofunctor" Label="constructor of the right derived functor of a contravariant functor"/></Item>
##      <Item><Ref Oper="LeftDerivedFunctor" Label="constructor of the left derived functor of a covariant functor"/></Item>
##      <Item><Ref Oper="ComposeFunctors" Label="constructor for functors given two functors"/></Item>
##    </List>
##    In &homalg; each functor is implemented as a &GAP4; object.
##    <P/>
##    So-called installers (&see; <Ref Oper="InstallFunctor"/> and <Ref Oper="InstallDeltaFunctor"/>)
##    take such a functor object and create operations in order to apply the functor on objects, morphisms,
##    complexes (of objects or again of complexes), and chain morphisms. The installer <Ref Oper="InstallDeltaFunctor"/>
##    creates additional operations for <M>\delta</M>-functors in order to compute connecting homomorphisms,
##    exact triangles, and associated long exact sequences by starting with a short exact sequence.
##    <P/>
##    In &homalg; special emphasis is laid on the action of functors on <E>morphisms</E>, as an essential part of the
##    very definition of a functor. This is for no obvious reason often neglected in computer algebra systems.
##    Starting from a functor where the action on morphisms is also defined, all the above constructors
##    again create functors with actions both on objects and on morphisms (and hence on chain complexes and chain morphisms).
##    <P/>
##    It turned out that in a variety of situations a caching mechanism for functors is not only extremely
##    useful (e.g. to avoid repeated expensive computations) but also an absolute necessity for the coherence of data.
##    Functors in &homalg; are therefore endowed with a caching mechanism.
##    <P/>
##    If <M>R</M> is a &homalg; ring in which the component <M>R</M>!.<C>ByASmallerPresentation</C> is set to true
##    <Br/><Br/>
##    <C>R!.ByASmallerPresentation := true</C>;
##    <Br/><Br/>
##    any functor which returns an object over <M>R</M> will first apply
##    <C>ByASmallerPresentation</C> to its result before returning it. <P/>
##    One of the highlights in &homalg; is the computation of Grothendieck's spectral sequences connecting
##    the composition of the derivations of two functors with the derived functor of their composite.
##  <#/GAPDoc>

####################################
#
# representations:
#
####################################

# a new representation for the GAP-category IsHomalgFunctor:

##  <#GAPDoc Label="IsHomalgFunctorRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="E" Name="IsHomalgFunctorRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; representation of &homalg; (multi-)functors. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgFunctor"/>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsHomalgFunctorRep",
        IsHomalgFunctor,
        [ ] );

# a new subrepresentation of the representation IsContainerForWeakPointersRep:

##
DeclareRepresentation( "IsContainerForWeakPointersOnComputedValuesOfFunctorRep",
        IsContainerForWeakPointersOnObjectsRep,
        [ "weak_pointers", "active", "deleted", "counter", "accessed", "cache_misses", "cache_hits" ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfHomalgFunctors",
        NewFamily( "TheFamilyOfHomalgFunctors" ) );

# a new type:
BindGlobal( "TheTypeHomalgFunctor",
        NewType(  TheFamilyOfHomalgFunctors,
                IsHomalgFunctorRep ) );

# a new type:
BindGlobal( "TheTypeContainerForWeakPointersOnComputedValuesOfFunctor",
        NewType( TheFamilyOfContainersForWeakPointers,
                IsContainerForWeakPointersOnComputedValuesOfFunctorRep ) );

####################################
#
# global values:
#
####################################

HOMALG.FunctorOn :=
  [ IsStructureObjectOrFinitelyPresentedObjectRep,
    IsStaticMorphismOfFinitelyGeneratedObjectsRep,
    [ IsComplexOfFinitelyPresentedObjectsRep, IsCocomplexOfFinitelyPresentedObjectsRep ],
    [ IsChainMorphismOfFinitelyPresentedObjectsRep, IsCochainMorphismOfFinitelyPresentedObjectsRep ] ];
  
####################################
#
# methods for operations:
#
####################################

##
InstallMethod( NaturalGeneralizedEmbedding,
        "for homalg objects being values of functors on objects",
        [ IsStaticFinitelyPresentedObjectRep ],
        
  function( FM )
    
    if IsBound(FM!.NaturalGeneralizedEmbedding) then
        return FM!.NaturalGeneralizedEmbedding;
    else
        Error( "the object does not have a component \"NaturalGeneralizedEmbedding\"; either the object is not the result of a functor or the functor is not properly implemented (cf. arXiv:math/0701146)\n" );
    fi;
    
end );

##
InstallMethod( NameOfFunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep ],
        
  function( Functor )
    
    if not IsBound( Functor!.name ) then
        Error( "the provided functor is nameless\n" );
    fi;
    
    return Functor!.name;
    
end );

##
InstallMethod( OperationOfFunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep ],
        
  function( Functor )
    local functor_operation;
    
    if not IsBound( Functor!.operation ) then
        Error( "unable to find the functor component \"operation\"\n" );
    fi;
    
    functor_operation := ValueGlobal( Functor!.operation );
    
    ## for this to work you need to declare one instance of the functor,
    ## although all methods will be installed using InstallOtherMethod!
    if not IsOperation( functor_operation ) and
       not IsFunction( functor_operation ) then
        Error( "the functor ", NameOfFunctor( Functor ), " neither points to an operation nor to a function\n" );
    fi;
    
    return functor_operation;
    
end );

##
InstallMethod( CategoryOfFunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep ],
        
  function( Functor )
    
    if not IsBound( Functor!.category ) then
        Error( "unable to find the functor component \"category\"\n" );
    fi;
    
    return Functor!.category;
    
end );

##
InstallMethod( DescriptionOfCategory,
        "for homalg functors",
        [ IsHomalgFunctorRep ],
        
  function( Functor )
    local category;
    
    category := CategoryOfFunctor( Functor );
    
    if not IsBound( category.description ) then
        Error( "unable to find the category component \"description\"\n" );
    fi;
    
    return category.description;
    
end );

##
InstallMethod( ShortDescriptionOfCategory,
        "for homalg functors",
        [ IsHomalgFunctorRep ],
        
  function( Functor )
    local category;
    
    category := CategoryOfFunctor( Functor );
    
    if not IsBound( category.short_description ) then
        Error( "unable to find the category component \"short_description\"\n" );
    fi;
    
    return category.short_description;
    
end );

##
InstallMethod( IsSpecialFunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep ],
        
  function( Functor )
    
    if IsBound( Functor!.special ) and Functor!.special = true then
        return true;
    fi;
    
    return false;
    
end );

##
InstallMethod( MultiplicityOfFunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep ],
        
  function( Functor )
    
    if IsBound( Functor!.number_of_arguments ) then
        return Functor!.number_of_arguments;
    fi;
    
    return 1;
    
end );

##
InstallMethod( IsCovariantFunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsInt ],
        
  function( Functor, pos )
    
    if pos < 1 then
        Error( "the second argument must be a positive integer\n" );
    fi;
    
    if IsBound( Functor!.(pos) ) then
        if Functor!.( pos )[1][1] = "covariant" then
            return true;
        elif Functor!.( pos )[1][1] = "contravariant" then
            return false;
        fi;
    fi;
    
    return fail;
    
end );

##
InstallMethod( IsCovariantFunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep ],
        
  function( Functor )
    
    return IsCovariantFunctor( Functor, 1 );
    
end );

##
InstallMethod( IsDistinguishedArgumentOfFunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsPosInt ],
        
  function( Functor, pos )
    local l;
    
    if IsBound( Functor!.(String( pos )) ) and IsBound( Functor!.(String( pos ))[1] ) then
        l := Length( Functor!.(String( pos ))[1] );
        
        if l > 1 and Functor!.(String( pos ))[1][l] = "distinguished" then
            return true;
        fi;
    fi;
    
    return false;
    
end );

##
InstallMethod( IsDistinguishedFirstArgumentOfFunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep ],
        
  function( Functor )
    
    return IsDistinguishedArgumentOfFunctor( Functor, 1 );
    
end );

##
InstallMethod( IsAdditiveFunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsPosInt ],
        
  function( Functor, pos )
    local prop;
    
    if IsBound( Functor!.(pos) ) and Length( Functor!.( pos )[1] ) > 1 then
        prop := Functor!.( pos )[1][2];
        if prop in [ "additive", "left exact", "right exact", "exact", "right adjoint", "left adjoint" ] then
            return true;
        fi;
    fi;
    
    return fail;
    
end );

##
InstallMethod( IsAdditiveFunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep ],
        
  function( Functor )
    
    return IsAdditiveFunctor( Functor, 1 );
    
end );

##
InstallMethod( IsLeftExactFunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsPosInt ],
        
  function( Functor, pos )
    local prop;
    
    if IsBound( Functor!.(pos) ) and Length( Functor!.( pos )[1] ) > 1 then
        prop := Functor!.( pos )[1][2];
        if prop in [ "left exact", "exact", "right adjoint" ] then
            return true;
        fi;
    fi;
    
    return fail;
    
end );

##
InstallMethod( IsLeftExactFunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep ],
        
  function( Functor )
    
    return IsLeftExactFunctor( Functor, 1 );
    
end );

##
InstallMethod( IsRightExactFunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsPosInt ],
        
  function( Functor, pos )
    local prop;
    
    if IsBound( Functor!.(pos) ) and Length( Functor!.( pos )[1] ) > 1 then
        prop := Functor!.( pos )[1][2];
        if prop in [ "right exact", "exact", "left adjoint" ] then
            return true;
        fi;
    fi;
    
    return fail;
    
end );

##
InstallMethod( IsRightExactFunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep ],
        
  function( Functor )
    
    return IsRightExactFunctor( Functor, 1 );
    
end );

##
InstallMethod( IsIdenticalObjForFunctors,
        "for two objects",
        [ IsObject, IsObject ],
        
  function( o1, o2 )
    local l1, l2;
    
    if IsHomalgObjectOrMorphism( o1 ) then
        return IsIdenticalObj( o1, o2 );
    elif IsString( o1 ) and IsString( o2 ) then
        return o1 = o2;
    elif IsList( o1 ) and IsList( o2 ) then
        l1 := Length( o1 );
        l2 := Length( o2 );
        return l1 = l2 and
               ForAll( [ 1 .. l1 ], i -> IsIdenticalObjForFunctors( o1[i], o2[i] ) );
    fi;
    
    return IsIdenticalObj( o1, o2 );
    
end );

##
InstallMethod( SetFunctorObjCachedValue,
        "for homalg Functors",
        [ IsHomalgFunctorRep, IsList, IsObject ],
        
  function( Functor, args_of_functor, obj )
    local container, arguments_of_functor, p, l, context_of_arguments, arg_all;
    
    if not IsBound( Functor!.ContainerForWeakPointersOnComputedBasicObjects ) then
        
        return fail;
        
    fi;
    
    container := Functor!.ContainerForWeakPointersOnComputedBasicObjects;
    
    ## convert subobjects into objects
    arguments_of_functor :=
      List( args_of_functor,
            function( a )
              if IsStaticFinitelyPresentedSubobjectRep( a ) then
                  return UnderlyingObject( a );
              else
                  return a;
              fi;
            end );
    
    if IsBound( Functor!.0 ) then
        p := 1;
    else
        p := 0;
    fi;
    l := Length( arguments_of_functor );
    
    context_of_arguments := List( arguments_of_functor{[ 1 + p .. l ]}, PositionOfTheDefaultPresentation );
    
    arg_all := rec( );
    
    arg_all.("arguments_of_functor") := arguments_of_functor;
    arg_all.("context_of_arguments") := context_of_arguments;
    arg_all.("Functor") := Functor;
    arg_all.("PositionOfTheDefaultPresentationOfTheOutput")
      := PositionOfTheDefaultPresentation( obj );
    
    arg_all := [ arg_all, obj ];
    
    if not HasGenesis( obj ) then
        SetGenesis( obj, [ arg_all ] );
    else
        Add( Genesis( obj ), arg_all );
    fi;
    
    if IsBound( container ) then
        _AddElmWPObj_ForHomalg( container, arg_all );
    fi;
    
    return obj;
    
  end );

##
InstallMethod( GetFunctorObjCachedValue,
        "for homalg Functors",
        [ IsHomalgFunctorRep, IsList ],
        
  function( Functor, args_of_functor )
    local container, weak_pointers, lp, active, l_active, arguments_of_functor,
          functor_name, p, l, context_of_arguments, cache_hit, i, arg_old_obj,
          context, arg_old, obj;
    
    if not IsBound( Functor!.ContainerForWeakPointersOnComputedBasicObjects ) then
        
        return fail;
        
    fi;
    
    container := Functor!.ContainerForWeakPointersOnComputedBasicObjects;
    
    weak_pointers := container!.weak_pointers;
    
    lp := LengthWPObj( weak_pointers );
    
    active := Filtered( container!.active, i -> i <= lp );
    
    l_active := Length( active );
    
    ## convert subobjects into objects
    arguments_of_functor :=
      List( args_of_functor,
            function( a )
              if IsStaticFinitelyPresentedSubobjectRep( a ) then
                  return UnderlyingObject( a );
              else
                  return a;
              fi;
            end );
    
    #=====# begin of the core procedure #=====#
    
    functor_name := NameOfFunctor( Functor );
    
    if IsBound( Functor!.0 ) then
        p := 1;
    else
        p := 0;
    fi;
    l := Length( arguments_of_functor );
    context_of_arguments := List( arguments_of_functor{[ 1 + p .. l ]}, PositionOfTheDefaultPresentation );
    
    cache_hit := false;
    i := 1;
    while i <= l_active do
        arg_old_obj := ElmWPObj( weak_pointers, active[i] );
        if arg_old_obj <> fail then
            arg_old := arg_old_obj[1];
            context := arg_old.("context_of_arguments");
            arg_old := arg_old.("arguments_of_functor");
            obj := arg_old_obj[2];
            if l = Length( arg_old ) then
                
                if ForAny( arguments_of_functor, IsHomalgStaticObject ) then
                    
                    if ForAll( [ 1 .. l ], j -> IsIdenticalObjForFunctors( arg_old[j], arguments_of_functor[j] ) ) then
                        
                        if ForAll( [ 1 .. l - p ], j -> context[j] = context_of_arguments[j] ) then
                            
                            cache_hit := true;
                            break;
                            
                        elif ForAll( [ 1 .. l - p ],
                                function( j )
                                  if context[j] = context_of_arguments[j] then
                                      return true;
                                  else
                                      return IsIdenticalObj(
                                                      PartOfPresentationRelevantForOutputOfFunctors( arg_old[j+p], context[j] ),
                                                      PartOfPresentationRelevantForOutputOfFunctors( arguments_of_functor[j+p], context_of_arguments[j] ) );
                                  fi;
                                end ) then
                            
                            cache_hit := true;
                            break;
                            
                        elif IsBound( obj!.IgnoreContextOfArgumentsOfFunctor ) and
                          obj!.IgnoreContextOfArgumentsOfFunctor = true then
                            
                            cache_hit := true;
                            break;
                            
                        elif IsBound( Functor!.CompareArgumentsForFunctorObj ) and  ## no static objects
                          Functor!.CompareArgumentsForFunctorObj( arg_old, arguments_of_functor ) then
                            
                            cache_hit := true;
                            break;
                            
                        #elif IsBound( Functor!.OnMorphisms ) then
                            ## TODO: merge the new output with the old one
                        fi;
                    fi;
                    
                elif not ( IsBound( Functor!.DontCompareEquality ) and Functor!.DontCompareEquality ) and
                  ForAll( [ 1 .. l ], j -> arg_old[j] = arguments_of_functor[j] ) then ## no static objects
                    
                    ## this "elif" is extremely important:
                    ## To apply a certain functor (e.g. derived ones) to an object
                    ## we might need to apply another functor to a morphism A. This
                    ## morphisms could be the outcome of a third functor applied to another
                    ## morphism B, and although there is a caching for functors applied
                    ## to morphisms, B often becomes obsolete since it was only used in an
                    ## intermediat step and gets deleted after a while
                    ## (e.g. CompleteImageSquare( alpha1, Functor(morphism), beta1 )).
                    ## Hence B has to be recomputed to get B' and A has to be recomputed
                    ## using B' to get A'. Now A=A' but not identical!
                    
                    cache_hit := true;
                    break;
                    
                elif IsBound( Functor!.CompareArgumentsForFunctorObj ) and  ## no static objects
                  Functor!.CompareArgumentsForFunctorObj( arg_old, arguments_of_functor ) then
                    
                    cache_hit := true;
                    break;
                    
                fi;
                
            fi;
            i := i + 1;
        else  ## active[i] is no longer active
            Remove( active, i );
            l_active := l_active - 1;
        fi;
    od;
    
    container!.active := active;
    container!.deleted := Difference( [ 1 .. lp ], active );
    
    container!.accessed := container!.accessed + 1;
    container!.cache_misses := container!.cache_misses + i - 1;
    
    if cache_hit then
        container!.cache_hits := container!.cache_hits + 1;
        return obj;
    fi;
    
    return fail;
    
  end );

##
InstallMethod( FunctorObj,
        "for homalg morphisms",
        [ IsHomalgFunctorRep, IsList ],
        
  function( Functor, args_of_functor )
    local arguments_of_functor, obj, genesis, Functor_orig, arg_pos,
          Functor_arg, Functor_post, Functor_pre, post_arg_pos,
          functor_orig_operation, m_orig, arg_orig,
          functor_pre_operation, m_pre, functor_post_operation, m_post,
          arg_pre, arg_post, R;
    
    ## convert subobjects into objects
    arguments_of_functor :=
      List( args_of_functor,
            function( a )
              if IsStaticFinitelyPresentedSubobjectRep( a ) then
                  return UnderlyingObject( a );
              else
                  return a;
              fi;
            end );
    
    obj := GetFunctorObjCachedValue( Functor, args_of_functor );
    if obj <> fail then
        return obj;
    fi;
    
    #=====# begin of the core procedure #=====#
    
    if HasGenesis( Functor ) then
        genesis := Genesis( Functor );
        if genesis[1] = "InsertObjectInMultiFunctor" then
            Functor_orig := genesis[2];
            arg_pos := genesis[3];
            Functor_arg := genesis[4];
        elif genesis[1] = "ComposeFunctors" then
            Functor_post := genesis[2][1];
            Functor_pre := genesis[2][2];
            post_arg_pos := genesis[3];
        fi;
    fi;
    
    if IsBound( Functor_orig ) then
        ## the functor is specialized: Functor := Functor_orig( ..., Functor_arg, ... )
        
        functor_orig_operation := OperationOfFunctor( Functor_orig );
        
        m_orig := MultiplicityOfFunctor( Functor_orig );
        
        if IsBound( Functor_orig!.0 ) then
            arg_orig := arguments_of_functor{[ 1 .. arg_pos ]};
        else
            arg_orig := arguments_of_functor{[ 1 .. arg_pos - 1 ]};
        fi;
        
        Add( arg_orig, Functor_arg );
        Append( arg_orig, arguments_of_functor{[ arg_pos + 1 .. m_orig ]} );
        
        obj := CallFuncList( functor_orig_operation, arg_orig );
        
    elif IsBound( Functor_post ) then
        ## the functor is composed: Functor := Functor_post @ Functor_pre
        
        functor_pre_operation := OperationOfFunctor( Functor_pre );
        
        functor_post_operation := OperationOfFunctor( Functor_post );
        
        m_pre := MultiplicityOfFunctor( Functor_pre );
        
        m_post := MultiplicityOfFunctor( Functor_post );
        
        arg_pre := arguments_of_functor{[ post_arg_pos .. post_arg_pos + m_pre - 1 ]};
        
        arg_post := Concatenation(
                            arguments_of_functor{[ 1 .. post_arg_pos - 1 ]},
                            [ CallFuncList( functor_pre_operation, arg_pre ) ],
                            arguments_of_functor{[ post_arg_pos + m_pre .. m_post + m_pre - 1 ]}
                            );
        
        obj := CallFuncList( functor_post_operation, arg_post );
        
    else
        
        obj := CallFuncList( Functor!.OnObjects, arguments_of_functor );
        
    fi;
    
    if IsHomalgStaticObject( obj ) then
        R := StructureObject( obj );
        if IsBound( R!.ByASmallerPresentation ) then
            ByASmallerPresentation( obj );
        fi;
    fi;
    
    #=====# end of the core procedure #=====#
    
    SetFunctorObjCachedValue( Functor, arguments_of_functor, obj );
    
    return obj;
    
end );

##
InstallMethod( FunctorMor,
        "for homalg morphisms",
        [ IsHomalgFunctorRep, IsMorphismOfFinitelyGeneratedObjectsRep, IsList ],
        
  function( Functor, phi, fixed_arguments_of_multi_functor )
    local container, weak_pointers, lp, active, l_active, functor_name,
          number_of_arguments, pos0, arg_positions, S, T, pos,
          arg_before_pos, arg_behind_pos, arg_all, cache_hit, i, l,
          arg_old_mor, arg_old, arg_source, arg_target, functor_operation,
          F_source, F_target, genesis, Functor_orig, arg_pos, Functor_arg,
          Functor_post, Functor_pre, post_arg_pos,
          functor_orig_operation, m_orig, arg_orig,
          functor_pre_operation, m_pre, functor_post_operation, m_post,
          arg_pre, arg_post, emb_source, emb_target, arg_phi, hull_phi, mor;
    
    if not fixed_arguments_of_multi_functor = [ ] and
       not ( ForAll( fixed_arguments_of_multi_functor, a -> IsList( a ) and Length( a ) = 2 and IsPosInt( a[1] ) ) ) then
        Error( "the last argument has a wrong syntax\n" );
    fi;
    
    if IsBound( Functor!.ContainerForWeakPointersOnComputedBasicMorphisms ) then
        
        container := Functor!.ContainerForWeakPointersOnComputedBasicMorphisms;
        
        weak_pointers := container!.weak_pointers;
        
        lp := LengthWPObj( weak_pointers );
        
        active := Filtered( container!.active, i -> i <= lp );
        
        l_active := Length( active );
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    functor_name := NameOfFunctor( Functor );
    
    number_of_arguments := MultiplicityOfFunctor( Functor );
    
    if IsBound( Functor!.0 ) and IsList( Functor!.0 ) then
        number_of_arguments := number_of_arguments + 1;
        pos0 := 1;
    else
        pos0 := 0;
    fi;
    
    arg_positions := List( fixed_arguments_of_multi_functor, a -> a[1] );
    
    if Length( arg_positions ) <> number_of_arguments - 1 then
        Error( "the number of fixed arguments provided for the functor must be one less than the total number\n" );
    elif not IsDuplicateFree( arg_positions ) then
        Error( "the provided list of positions is not duplicate free: ", arg_positions, "\n" );
    elif arg_positions <> [ ] and Maximum( arg_positions ) > number_of_arguments then
        Error( "the list of positions must be a subset of [ 1 .. ", number_of_arguments, " ], but received: :",  arg_positions, "\n" );
    fi;
    
    S := Source( phi );
    T := Range( phi );
    
    pos := Filtered( [ 1 .. number_of_arguments ], a -> not a in arg_positions )[1];
    
    arg_positions := fixed_arguments_of_multi_functor;
    
    Sort( arg_positions, function( v, w ) return v[1] < w[1]; end );
    
    arg_before_pos := List( arg_positions{[ 1 .. pos - 1 ]}, a -> a[2] );
    arg_behind_pos := List( arg_positions{[ pos .. number_of_arguments - 1 ]}, a -> a[2] );
    
    arg_all := Concatenation( arg_before_pos, [ phi ], arg_behind_pos );
    
    if IsBound( container ) then
        cache_hit := false;
        i := 1;
        while i <= l_active do
            arg_old_mor := ElmWPObj( weak_pointers, active[i] );
            if arg_old_mor <> fail then
                arg_old := arg_old_mor[1];
                l := Length( arg_old );
                if l = Length( arg_all ) then
                    if ForAll( [ 1 .. l ], j -> IsIdenticalObjForFunctors( arg_old[j], arg_all[j] ) ) then
                        cache_hit := true;
                        break;
                    fi;
                fi;
                i := i + 1;
            else	## active[i] is no longer active
                Remove( active, i );
                l_active := l_active - 1;
            fi;
        od;
        
        container!.active := active;
        container!.deleted := Difference( [ 1 .. lp ], active );
        
        container!.accessed := container!.accessed + 1;
        container!.cache_misses := container!.cache_misses + i - 1;
        
        if cache_hit then
            container!.cache_hits := container!.cache_hits + 1;
            return arg_old_mor[2];
        fi;
        
    fi;
    
    pos := pos - pos0;
    
    if IsCovariantFunctor( Functor, pos ) = true then
        arg_source := Concatenation( arg_before_pos, [ S ], arg_behind_pos );
        arg_target := Concatenation( arg_before_pos, [ T ], arg_behind_pos );
    elif IsCovariantFunctor( Functor, pos ) = false then	## not fail
        arg_source := Concatenation( arg_before_pos, [ T ], arg_behind_pos );
        arg_target := Concatenation( arg_before_pos, [ S ], arg_behind_pos );
    else
        Error( "the functor ", functor_name, " must be either co- or contravriant in its argument number ", pos, "\n" );
    fi;
    
    functor_operation := OperationOfFunctor( Functor );
    
    F_source := CallFuncList( functor_operation, arg_source );
    F_target := CallFuncList( functor_operation, arg_target );
    
    if HasGenesis( Functor ) then
        genesis := Genesis( Functor );
        if genesis[1] = "InsertObjectInMultiFunctor" then
            Functor_orig := genesis[2];
            arg_pos := genesis[3];
            Functor_arg := genesis[4];
        elif genesis[1] = "ComposeFunctors" then
            Functor_post := genesis[2][1];
            Functor_pre := genesis[2][2];
            post_arg_pos := genesis[3];
        fi;
    fi;
    
    if IsBound( Functor_orig ) then
        ## the functor is specialized: Functor := Functor_orig( ..., Functor_arg, ... )
        
        functor_orig_operation := OperationOfFunctor( Functor_orig );
        
        m_orig := MultiplicityOfFunctor( Functor_orig );
        
        if IsBound( Functor_orig!.0 ) then
            arg_orig := arg_all{[ 1 .. arg_pos ]};
        else
            arg_orig := arg_all{[ 1 .. arg_pos - 1 ]};
        fi;
        
        Add( arg_orig, Functor_arg );
        Append( arg_orig, arg_all{[ arg_pos + 1 .. m_orig ]} );
        
        mor := CallFuncList( functor_orig_operation, arg_orig );
        
    elif IsBound( Functor_post ) then
        ## the functor is composed: Functor := Functor_post @ Functor_pre
        
        functor_pre_operation := OperationOfFunctor( Functor_pre );
        
        functor_post_operation := OperationOfFunctor( Functor_post );
        
        m_pre := MultiplicityOfFunctor( Functor_pre );
        
        m_post := MultiplicityOfFunctor( Functor_post );
        
        arg_pre := arg_all{[ post_arg_pos .. post_arg_pos + m_pre - 1 ]};
        
        arg_post := Concatenation(
                            arg_all{[ 1 .. post_arg_pos - 1 ]},
                            [ CallFuncList( functor_pre_operation, arg_pre ) ],
                            arg_all{[ post_arg_pos + m_pre .. m_post + m_pre - 1 ]}
                            );
        
        mor := CallFuncList( functor_post_operation, arg_post );
        
    elif IsBound( Functor!.IsIdentityOnObjects ) and Functor!.IsIdentityOnObjects then
        
        if IsBound( Functor!.OnMorphisms ) then
            arg_phi := Concatenation( arg_before_pos, [ phi ], arg_behind_pos );
            mor := CallFuncList( Functor!.OnMorphisms, arg_phi );
            
            if IsBound( Functor!.MorphismConstructor ) then
                mor := Functor!.MorphismConstructor( mor, F_source, F_target );
                
                ## otherwise the result mor cannot automatically be marked IsMorphism
                SetIsMorphism( mor, true );
            fi;
        else
            mor := phi;
        fi;
        
    elif IsBound( Functor!.OnMorphisms ) then
        
        mor := Functor!.OnMorphisms( F_source, F_target, arg_before_pos, phi, arg_behind_pos );
        
    else ## old style, will be eliminated soon
        
        emb_source := NaturalGeneralizedEmbedding( F_source );
        emb_target := NaturalGeneralizedEmbedding( F_target );
        
        if IsBound( Functor!.OnMorphismsHull ) then
            arg_phi := Concatenation( arg_before_pos, [ phi ], arg_behind_pos );
            hull_phi := CallFuncList( Functor!.OnMorphismsHull, arg_phi );
            
            if IsBound( Functor!.MorphismConstructor ) then
                hull_phi := Functor!.MorphismConstructor( hull_phi, Range( emb_source ), Range( emb_target ) );
                
                ## otherwise the result mor cannot automatically be marked IsMorphism
                SetIsMorphism( hull_phi, true );
            fi;
        else
            hull_phi := phi;
        fi;
        
        mor := CompleteImageSquare( emb_source, hull_phi, emb_target );
        
        ## CAUTION: this is experimental!!!
        if HasIsGeneralizedMonomorphism( emb_source ) and IsGeneralizedMonomorphism( emb_source ) and
           HasIsGeneralizedMonomorphism( emb_target ) and IsGeneralizedMonomorphism( emb_target ) and
           HasIsMorphism( phi ) and IsMorphism( phi ) then
            
            ## check assertion
            Assert( 1, IsMorphism( mor ) );
            
            SetIsMorphism( mor, true );
        fi;
        
    fi;
    
    SetPropertiesOfFunctorMor( Functor, phi, mor, pos, arg_before_pos, arg_behind_pos );
    
    #=====# end of the core procedure #=====#
    
    arg_all := [ arg_all, mor ];
    
    if not HasGenesis( mor ) then
        SetGenesis( mor, [ arg_all ] );
    else
        Add( Genesis( mor ), arg_all );
    fi;
    
    if IsBound( container ) then
        _AddElmWPObj_ForHomalg( container, arg_all );
    fi;
    
    return mor;
    
end );

##
InstallMethod( FunctorMor,
        "for homalg morphisms",
        [ IsHomalgFunctorRep, IsStaticMorphismOfFinitelyGeneratedObjectsRep ],
        
  function( Functor, phi )
    
    return FunctorMor( Functor, phi, [ ] );
    
end );

InstallMethod( SetPropertiesOfFunctorMor,
        "for homalg morphisms",
        [ IsHomalgFunctorRep, IsHomalgMorphism, IsHomalgMorphism, IsInt, IsList, IsList ],
        
  function( Functor, phi, mor, pos, arg_before_pos, arg_behind_pos )
    local alpha;
    
    if HasIsIsomorphism( phi ) and IsIsomorphism( phi ) then
        
        Assert( 1, IsIsomorphism( mor ) );
        SetIsIsomorphism( mor, true );
        
    fi;
        
    if HasIsMorphism( phi ) and IsMorphism( phi ) then
        
        Assert( 1, IsMorphism( mor ) );
        SetIsMorphism( mor, true );
        
    fi;
    
    if IsLeftExactFunctor( Functor, pos ) = true then
        
        if IsCovariantFunctor( Functor, pos ) = true then
            
            if  HasIsMonomorphism( phi ) and IsMonomorphism( phi ) then
                
                Assert( 1, IsMonomorphism( mor ) );
                SetIsMonomorphism( mor, true );
                
            fi;
            
            if HasKernelEmb( phi ) then
                alpha := GetFunctorObjCachedValue( Functor, Concatenation( arg_before_pos, [ KernelEmb( phi ) ], arg_behind_pos ) );
                if alpha <> fail then
                    SetKernelEmb( mor, alpha );
                fi;
            fi;
            
        fi;
        
        if IsCovariantFunctor( Functor, pos ) = false then
            
            if  HasIsEpimorphism( phi ) and IsEpimorphism( phi ) then
                
                Assert( 1, IsMonomorphism( mor ) );
                SetIsMonomorphism( mor, true );
                
            fi;
            
            if HasCokernelEpi( phi ) then
                alpha := GetFunctorObjCachedValue( Functor, Concatenation( arg_before_pos, [ CokernelEpi( phi ) ], arg_behind_pos ) );
                if alpha <> fail then
                    Error( "juhu 2" );
                    SetKernelEmb( mor, alpha );
                fi;
            fi;
            
        fi;
        
    fi;
    
    if IsRightExactFunctor( Functor, pos ) = true then
        
        if IsCovariantFunctor( Functor, pos ) = true then
            
            if  HasIsEpimorphism( phi ) and IsEpimorphism( phi ) then
                
                Assert( 1, IsEpimorphism( mor ) );
                SetIsEpimorphism( mor, true );
                
            fi;
            
            if HasCokernelEpi( phi ) then
                alpha := GetFunctorObjCachedValue( Functor, Concatenation( arg_before_pos, [ CokernelEpi( phi ) ], arg_behind_pos ) );
                if alpha <> fail then
                    SetCokernelEpi( mor, alpha );
                fi;
            fi;
            
        fi;
        
        if IsCovariantFunctor( Functor, pos ) = false then
            
            if  HasIsMonomorphism( phi ) and IsMonomorphism( phi ) then
                
                Assert( 1, IsEpimorphism( mor ) );
                SetIsEpimorphism( mor, true );
                
            fi;
            
            if HasKernelEmb( phi ) then
                alpha := GetFunctorObjCachedValue( Functor, Concatenation( arg_before_pos, [ KernelEmb( phi ) ], arg_behind_pos ) );
                if alpha <> fail then
                    SetCokernelEpi( mor, alpha );
                fi;
            fi;
            
        fi;
        
    fi;
    
    UpdateObjectsByMorphism( mor );
    
    return mor;
    
end );

##
InstallMethod( InstallFunctorOnObjects,
        "for homalg functors",
        [ IsHomalgFunctorRep ],
        
  function( Functor )
    local genesis, der_arg, functor_operation, number_of_arguments,
          natural_transformation,
          natural_transformation1, natural_transformation2,
          natural_transformation3, natural_transformation4,
          filter_obj, filter0, filter1_obj, filter2_obj, filter3_obj;
    
    if HasGenesis( Functor ) then
        genesis := Genesis( Functor );
        if IsBound( genesis[3] ) then
            der_arg := genesis[3];
        fi;
    fi;
    
    functor_operation := OperationOfFunctor( Functor );
    
    number_of_arguments := MultiplicityOfFunctor( Functor );
    
    if number_of_arguments = 1 then
        
        if not IsBound( Functor!.1[2] ) then
            Functor!.1[2] := HOMALG.FunctorOn;
        fi;
        
        if not IsBound( Functor!.1[2][1] ) then
            return fail;
        fi;
        
        filter_obj := Functor!.1[2][1];
        
        if IsFilter( filter_obj ) then
            
            if IsBound( Functor!.0 ) and IsList( Functor!.0 ) then
                
                if Length( Functor!.0 ) = 1 then
                    filter0 := Functor!.0[1];
                else
                    filter0 := IsList;
                fi;
                
                InstallOtherMethod( functor_operation,
                        "for homalg objects",
                        [ filter0, filter_obj ],
                  function( c, o )
                    local obj;
                    
                    if IsStructureObject( o ) then
                        ## I personally prefer left objects:
                        obj := AsLeftObject( o );
                    else
                        obj := o;
                    fi;
                    
                    return FunctorObj( Functor, [ c, obj ] );
                    
                end );
                
            else
                
                if IsBound( Functor!.natural_transformation ) then
                    
                    natural_transformation := ValueGlobal( Functor!.natural_transformation );
                    
                    InstallOtherMethod( natural_transformation,
                            "for homalg objects",
                            [ filter_obj ],
                      function( o )
                        
                        functor_operation( o );			## this sets the attribute named "natural_transformation"
                        
                        return natural_transformation( o );	## not an infinite loop because of the side effect of the above line
                        
                    end );
                    
                fi;
                
                if IsBound( Functor!.natural_transformation1 ) then
                    
                    natural_transformation1 := ValueGlobal( Functor!.natural_transformation1 );
                    
                    InstallOtherMethod( natural_transformation1,
                            "for homalg objects",
                            [ filter_obj ],
                      function( o )
                        
                        functor_operation( o );			## this sets the attribute named "natural_transformation"
                        
                        return natural_transformation1( o );	## not an infinite loop because of the side effect of the above line
                        
                    end );
                    
                fi;
                
                if IsBound( Functor!.natural_transformation2 ) then
                    
                    natural_transformation2 := ValueGlobal( Functor!.natural_transformation2 );
                    
                    InstallOtherMethod( natural_transformation2,
                            "for homalg objects",
                            [ filter_obj ],
                      function( o )
                        
                        functor_operation( o );			## this sets the attribute named "natural_transformation"
                        
                        return natural_transformation2( o );	## not an infinite loop because of the side effect of the above line
                        
                    end );
                    
                fi;
                
                if IsBound( Functor!.natural_transformation3 ) then
                    
                    natural_transformation3 := ValueGlobal( Functor!.natural_transformation3 );
                    
                    InstallOtherMethod( natural_transformation3,
                            "for homalg objects",
                            [ filter_obj ],
                      function( o )
                        
                        functor_operation( o );			## this sets the attribute named "natural_transformation"
                        
                        return natural_transformation3( o );	## not an infinite loop because of the side effect of the above line
                        
                    end );
                    
                fi;
                
                if IsBound( Functor!.natural_transformation4 ) then
                    
                    natural_transformation4 := ValueGlobal( Functor!.natural_transformation4 );
                    
                    InstallOtherMethod( natural_transformation4,
                            "for homalg objects",
                            [ filter_obj ],
                      function( o )
                        
                        functor_operation( o );			## this sets the attribute named "natural_transformation"
                        
                        return natural_transformation4( o );	## not an infinite loop because of the side effect of the above line
                        
                    end );
                    
                fi;
                
                InstallOtherMethod( functor_operation,
                        "for homalg objects",
                        [ filter_obj ],
                  function( o )
                    local obj;
                    
                    if IsStructureObject( o ) then
                        ## I personally prefer left objects:
                        obj := AsLeftObject( o );
                    else
                        obj := o;
                    fi;
                    
                    return FunctorObj( Functor, [ obj ] );
                    
                end );
                
            fi;
            
        else
            
            Error( "wrong syntax: ", filter_obj, "\n" );
            
        fi;
        
    elif number_of_arguments = 2 then
        
        if not IsBound( Functor!.1[2] ) then
            Functor!.1[2] := HOMALG.FunctorOn;
        fi;
        
        if not IsBound( Functor!.2[2] ) then
            Functor!.2[2] := HOMALG.FunctorOn;
        fi;
        
        if not IsBound( Functor!.1[2][1] ) or not IsBound( Functor!.2[2][1] ) then
            return fail;
        fi;
        
        filter1_obj := Functor!.1[2][1];
        filter2_obj := Functor!.2[2][1];
        
        if IsFilter( filter1_obj ) and IsFilter( filter2_obj ) then
            
            if IsBound( Functor!.0 ) and IsList( Functor!.0 ) then
                
                if Length( Functor!.0 ) = 1 then
                    filter0 := Functor!.0[1];
                else
                    filter0 := IsList;
                fi;
                
                if IsDistinguishedFirstArgumentOfFunctor( Functor ) then
                    
                    InstallOtherMethod( functor_operation,
                            "for homalg objects",
                            [ filter0, filter1_obj ],
                      function( c, o )
                        local R;
                        
                        if IsStructureObject( o ) then
                            R := o;
                        else
                            R := StructureObject( o );
                        fi;
                        
                        return functor_operation( c, o, R );
                        
                    end );
                    
                    InstallOtherMethod( functor_operation,
                            "for homalg objects",
                            [ IsInt, filter1_obj, IsString ],
                      function( c, o, s )
                        local R;
                        
                        if IsStructureObject( o ) then
                            R := o;
                        else
                            R := StructureObject( o );
                        fi;
                        
                        return functor_operation( c, o, R, s );
                        
                    end );
                    
                    if IsBound( der_arg ) and der_arg = 1 then
                        
                        InstallOtherMethod( functor_operation,
                                "for homalg objects",
                                [ filter1_obj ],
                          function( o )
                            local R;
                            
                            if IsStructureObject( o ) then
                                R := o;
                            else
                                R := StructureObject( o );
                            fi;
                            
                            return functor_operation( o, R );
                            
                        end );
                        
                    fi;
                    
                fi;
                
                InstallOtherMethod( functor_operation,
                        "for homalg objects",
                        [ filter0, filter1_obj, filter2_obj ],
                  function( c, o1, o2 )
                    local obj1, obj2;
                    
                    if IsHomalgStaticObject( o1 ) and IsHomalgStaticObject( o2 ) then	## the most probable case
                        obj1 := o1;
                        obj2 := o2;
                    elif IsHomalgStaticObject( o1 ) and IsStructureObject( o2 ) then
                        obj1 := o1;
                        
                        if IsHomalgLeftObjectOrMorphismOfLeftObjects( o1 ) then
                            obj2 := AsLeftObject( o2 );
                        else
                            obj2 := AsRightObject( o2 );
                        fi;
                    elif IsStructureObject( o1 ) and IsHomalgStaticObject( o2 ) then
                        obj2 := o2;
                        
                        if IsHomalgLeftObjectOrMorphismOfLeftObjects( o2 ) then
                            obj1 := AsLeftObject( o1 );
                        else
                            obj1 := AsRightObject( o1 );
                        fi;
                    elif IsStructureObject( o1 ) and IsStructureObject( o2 ) then
                        if not IsIdenticalObj( o1, o2 ) then
                            Error( "the two rings are not identical\n" );
                        fi;
                        
                        ## I personally prefer left objects:
                        obj1 := AsLeftObject( o1 );
                        obj2 := obj1;
                    else
                        ## the default:
                        obj1 := o1;
                        obj2 := o2;
                    fi;
                    
                    return FunctorObj( Functor, [ c, obj1, obj2 ] );
                    
                end );
                
                if IsBound( der_arg ) then
                    
                    if IsCovariantFunctor( Functor, der_arg ) then
                        
                        InstallOtherMethod( functor_operation,
                                "for homalg objects",
                                [ IsInt, filter1_obj, filter2_obj, IsString ],
                          function( n, o1, o2, s )
                            local H, C, j;
                            
                            if s <> "a" then
                                TryNextMethod( );
                            fi;
                            
                            H := functor_operation( 0, o1, o2 );
                            
                            C := HomalgComplex( H );
                            
                            for j in [ 1 .. n ] do
                                
                                H := functor_operation( j, o1, o2 );
                                
                                Add( C, H );
                                
                            od;
                            
                            return C;
                            
                        end );
                        
                    else
                        
                        InstallOtherMethod( functor_operation,
                                "for homalg objects",
                                [ IsInt, filter1_obj, filter2_obj, IsString ],
                          function( n, o1, o2, s )
                            local H, C, j;
                            
                            if s <> "a" then
                                TryNextMethod( );
                            fi;
                            
                            H := functor_operation( 0, o1, o2 );
                            
                            C := HomalgCocomplex( H );
                            
                            for j in [ 1 .. n ] do
                                
                                H := functor_operation( j, o1, o2 );
                                
                                Add( C, H );
                                
                            od;
                            
                            return C;
                            
                        end );
                        
                    fi;
                    
                    InstallOtherMethod( functor_operation,
                            "for homalg objects",
                            [ filter1_obj, filter2_obj ],
                      function( o1, o2 )
                        local n;
                        
                        if der_arg = 1 then
                            n := LengthOfResolution( o1 );
                        else
                            n := LengthOfResolution( o2 );
                        fi;
                        
                        return functor_operation( n, o1, o2, "a" );
                        
                    end );
                    
                fi;
                
            else
                
                if IsDistinguishedFirstArgumentOfFunctor( Functor ) then
                    
                    InstallOtherMethod( functor_operation,
                            "for homalg objects",
                            [ filter1_obj ],
                      function( o )
                        local R;
                        
                        if IsStructureObject( o ) then
                            R := o;
                        else
                            R := StructureObject( o );
                        fi;
                        
                        return functor_operation( o, R );
                        
                    end );
                    
                fi;
                
                InstallOtherMethod( functor_operation,
                        "for homalg objects",
                        [ filter1_obj, filter2_obj ],
                  function( o1, o2 )
                    local obj1, obj2;
                    
                    if IsHomalgStaticObject( o1 ) and IsHomalgStaticObject( o2 ) then	## the most probable case
                        obj1 := o1;
                        obj2 := o2;
                    elif IsHomalgStaticObject( o1 ) and IsStructureObject( o2 ) then
                        obj1 := o1;
                        
                        if IsHomalgLeftObjectOrMorphismOfLeftObjects( o1 ) then
                            obj2 := AsLeftObject( o2 );
                        else
                            obj2 := AsRightObject( o2 );
                        fi;
                    elif IsStructureObject( o1 ) and IsHomalgStaticObject( o2 ) then
                        obj2 := o2;
                        
                        if IsHomalgLeftObjectOrMorphismOfLeftObjects( o2 ) then
                            obj1 := AsLeftObject( o1 );
                        else
                            obj1 := AsRightObject( o1 );
                        fi;
                    elif IsStructureObject( o1 ) and IsStructureObject( o2 ) then
                        if not IsIdenticalObj( o1, o2 ) then
                            Error( "the two rings are not identical\n" );
                        fi;
                        
                        ## I personally prefer left objects:
                        obj1 := AsLeftObject( o1 );
                        obj2 := obj1;
                    else
                        ## the default:
                        obj1 := o1;
                        obj2 := o2;
                    fi;
                    
                    return FunctorObj( Functor, [ obj1, obj2 ] );
                    
                end );
                
            fi;
            
        else
            
            Error( "wrong syntax: ", filter1_obj, filter2_obj, "\n" );
            
        fi;
        
    elif number_of_arguments = 3 then
        
        if not IsBound( Functor!.1[2] ) then
            Functor!.1[2] := HOMALG.FunctorOn;
        fi;
        
        if not IsBound( Functor!.2[2] ) then
            Functor!.2[2] := HOMALG.FunctorOn;
        fi;
        
        if not IsBound( Functor!.3[2] ) then
            Functor!.3[2] := HOMALG.FunctorOn;
        fi;
        
        if not IsBound( Functor!.1[2][1] ) or
           not IsBound( Functor!.2[2][1] ) or
           not IsBound( Functor!.3[2][1] ) then
            return fail;
        fi;
        
        filter1_obj := Functor!.1[2][1];
        filter2_obj := Functor!.2[2][1];
        filter3_obj := Functor!.3[2][1];
        
        if IsFilter( filter1_obj ) and
           IsFilter( filter2_obj ) and
           IsFilter( filter3_obj ) then
            
            if IsBound( Functor!.0 ) and IsList( Functor!.0 ) then
                
                if Length( Functor!.0 ) = 1 then
                    filter0 := Functor!.0[1];
                else
                    filter0 := IsList;
                fi;
                
                if IsDistinguishedFirstArgumentOfFunctor( Functor ) then
                    
                    InstallOtherMethod( functor_operation,
                            "for homalg objects",
                            [ filter0, filter1_obj ],
                      function( c, o )
                        local R;
                        
                        if IsStructureObject( o ) then
                            R := o;
                        else
                            R := StructureObject( o );
                        fi;
                        
                        return functor_operation( c, o, R, R );
                        
                    end );
                    
                    InstallOtherMethod( functor_operation,
                            "for homalg objects",
                            [ IsInt, filter1_obj, IsString ],
                      function( c, o, s )
                        local R;
                        
                        if IsStructureObject( o ) then
                            R := o;
                        else
                            R := StructureObject( o );
                        fi;
                        
                        return functor_operation( c, o, R, R, s );
                        
                    end );
                    
                fi;
                
                InstallOtherMethod( functor_operation,
                        "for homalg objects",
                        [ filter0, filter1_obj, filter2_obj, filter3_obj ],
                  function( c, o1, o2, o3 )
                    local obj1, obj2, obj3;
                    
                    if IsHomalgStaticObject( o1 ) and
                       IsHomalgStaticObject( o2 ) and
                       IsHomalgStaticObject( o3 ) then	## the most probable case
                        obj1 := o1;
                        obj2 := o2;
                        obj3 := o3;
                    elif IsHomalgStaticObject( o1 ) and IsStructureObject( o2 ) and IsStructureObject( o3 ) then
                        obj1 := o1;
                        
                        if not IsIdenticalObj( o2, o3 ) then
                            Error( "the last two rings are not identical\n" );
                        fi;
                        
                        if IsHomalgLeftObjectOrMorphismOfLeftObjects( o1 ) then
                            obj2 := AsLeftObject( o2 );
                            obj3 := AsLeftObject( o3 );
                        else
                            obj2 := AsRightObject( o2 );
                            obj3 := AsRightObject( o3 );
                        fi;
                    ## FIXME: there are missing cases
                    elif ForAll( [ o1, o2, o3 ], IsStructureObject ) then
                        if not IsIdenticalObj( o1, o2 ) then
                            Error( "the first two rings are not identical\n" );
                        elif not IsIdenticalObj( o2, o3 ) then
                            Error( "the last two rings are not identical\n" );
                        fi;
                        
                        ## I personally prefer left objects:
                        obj1 := AsLeftObject( o1 );
                        obj2 := obj1;
                        obj3 := obj1;
                    else
                        ## the default:
                        obj1 := o1;
                        obj2 := o2;
                        obj3 := o3;
                    fi;
                    
                    return FunctorObj( Functor, [ c, obj1, obj2, obj3 ] );
                    
                end );
                
                if IsBound( der_arg ) then
                    
                    if IsCovariantFunctor( Functor, der_arg ) then
                        
                        InstallOtherMethod( functor_operation,
                                "for homalg objects",
                                [ IsInt, filter1_obj, filter2_obj, filter3_obj, IsString ],
                          function( n, o1, o2, o3, s )
                            local H, C, j;
                            
                            if s <> "a" then
                                TryNextMethod( );
                            fi;
                            
                            H := functor_operation( 0, o1, o2, o3 );
                            
                            C := HomalgComplex( H );
                            
                            for j in [ 1 .. n ] do
                                
                                H := functor_operation( j, o1, o2, o3 );
                                
                                Add( C, H );
                                
                            od;
                            
                            return C;
                            
                        end );
                        
                    else
                        
                        InstallOtherMethod( functor_operation,
                                "for homalg objects",
                                [ IsInt, filter1_obj, filter2_obj, filter3_obj, IsString ],
                          function( n, o1, o2, o3, s )
                            local H, C, j;
                            
                            if s <> "a" then
                                TryNextMethod( );
                            fi;
                            
                            H := functor_operation( 0, o1, o2, o3 );
                            
                            C := HomalgCocomplex( H );
                            
                            for j in [ 1 .. n ] do
                                
                                H := functor_operation( j, o1, o2, o3 );
                                
                                Add( C, H );
                                
                            od;
                            
                            return C;
                            
                        end );
                        
                    fi;
                    
                fi;
                
            else
                
                if IsDistinguishedFirstArgumentOfFunctor( Functor ) then
                    
                    InstallOtherMethod( functor_operation,
                            "for homalg objects",
                            [ filter1_obj ],
                      function( o )
                        local R;
                        
                        if IsStructureObject( o ) then
                            R := o;
                        else
                            R := StructureObject( o );
                        fi;
                        
                        return functor_operation( o, R, R );
                        
                    end );
                    
                fi;
                
                InstallOtherMethod( functor_operation,
                        "for homalg objects",
                        [ filter1_obj, filter2_obj, filter3_obj ],
                  function( o1, o2, o3 )
                    local obj1, obj2, obj3;
                    
                    if IsHomalgStaticObject( o1 ) and
                       IsHomalgStaticObject( o2 ) and
                       IsHomalgStaticObject( o3 ) then	## the most probable case
                        obj1 := o1;
                        obj2 := o2;
                        obj3 := o3;
                    elif IsHomalgStaticObject( o1 ) and IsStructureObject( o2 ) and IsStructureObject( o3 ) then
                        obj1 := o1;
                        
                        if not IsIdenticalObj( o2, o3 ) then
                            Error( "the last two rings are not identical\n" );
                        fi;
                        
                        if IsHomalgLeftObjectOrMorphismOfLeftObjects( o1 ) then
                            obj2 := AsLeftObject( o2 );
                            obj3 := AsLeftObject( o3 );
                        else
                            obj2 := AsRightObject( o2 );
                            obj3 := AsRightObject( o3 );
                        fi;
                    ## FIXME: there are missing cases
                    elif ForAll( [ o1, o2, o3 ], IsStructureObject ) then
                        if not IsIdenticalObj( o1, o2 ) then
                            Error( "the first two rings are not identical\n" );
                        elif not IsIdenticalObj( o2, o3 ) then
                            Error( "the last two rings are not identical\n" );
                        fi;
                        
                        ## I personally prefer left objects:
                        obj1 := AsLeftObject( o1 );
                        obj2 := obj1;
                        obj3 := obj1;
                    else
                        ## the default:
                        obj1 := o1;
                        obj2 := o2;
                        obj3 := o3;
                    fi;
                    
                    return FunctorObj( Functor, [ obj1, obj2, obj3 ] );
                    
                end );
                
            fi;
            
        else
            
            Error( "wrong syntax: ", filter1_obj, filter2_obj, filter3_obj, "\n" );
            
        fi;
        
    fi;
    
    InstallNaturalTransformationsOfFunctor( Functor );
    
end );

##
InstallMethod( InstallNaturalTransformationsOfFunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep ],
        
  function( Functor )
    local functor_operation, number_of_arguments, natural_transformations, arg0, filter_obj, i, natural_transformation, operation, main_argument;
    
    if not IsBound( Functor!.natural_transformations ) then
        return fail;
    fi;
    
    functor_operation := OperationOfFunctor( Functor );
    
    number_of_arguments := MultiplicityOfFunctor( Functor );
    
    natural_transformations := Functor!.natural_transformations;
    
    arg0 := IsBound( Functor!.0 );
    
    if arg0 then
        filter_obj := ShallowCopy( Functor!.0 );
    else
        filter_obj := [ ];
    fi;
    
    i := 1;
    while IsBound( Functor!.(i) ) do
        
        Add( filter_obj, Functor!.(i)[2][1] );
        
        i := i + 1;
    od;
    
    for natural_transformation in natural_transformations do
        
        operation := ValueGlobal( natural_transformation[1] );
        
        if IsBound( natural_transformation[2] ) then
            main_argument := natural_transformation[2];
        else
            if arg0 then
                main_argument := 2;
            else
                main_argument := 1;
            fi;
        fi;
        
        InstallOtherMethod( operation,
                "for homalg objects",
                filter_obj,
          function( arg )
            local context_of_arguments, l, arguments_of_functor, cache_arg, arg_old, context_old, M;
            
            context_of_arguments := List( arg, PositionOfTheDefaultPresentation );
            
            l := Length( context_of_arguments );
            
            arguments_of_functor := List( arg, function( a )
                                                 if IsStaticFinitelyPresentedSubobjectRep( a ) then
                                                     return UnderlyingObject( a );
                                                 else
                                                     return a;
                                                 fi;
                                               end );
            
            # if it is not set, call the functor
            CallFuncList( functor_operation, arguments_of_functor );     ## this sets the informations needed below
            
            M := arguments_of_functor[ main_argument ];
            
            # an return the natural transformation, which should be set now
            if IsBound( M!.natural_transformations ) then
                
                if IsBound( M!.natural_transformations!.(natural_transformation[1]) ) then
                    
                    for cache_arg in M!.natural_transformations!.(natural_transformation[1]) do
                        
                        if Length( cache_arg[1] ) = l then
                            
                            arg_old := cache_arg[1];
                            
                            context_old := cache_arg[2];
                            
                            if arg_old = arguments_of_functor then
                            
                                if context_of_arguments = context_old or 
                                   ForAll( [ 1 .. l ],
                                    function( j )
                                      if context_old[j] = context_of_arguments[j] then
                                          return true;
                                      else
                                          return IsIdenticalObj(
                                                          PartOfPresentationRelevantForOutputOfFunctors( arg_old[j], context_old[j] ),
                                                          PartOfPresentationRelevantForOutputOfFunctors( arguments_of_functor[j], context_of_arguments[j] ) );
                                      fi;
                                    end )
                                    then
                                
                                    return cache_arg[3];
                                
                                fi;
                                
                            fi;
                            
                        fi;
                        
                    od;
                    
                fi;
            fi;
            
            Error( "natural transformation not set by functor" );
            
        end );
        
        
    od;
    
end );

##
InstallMethod( SetNaturalTransformation,
        "for homalg functors",
        [ IsHomalgFunctor, IsList, IsString, IsObject ],
        
  function( Functor, args, name, nat )
    local pos, natural_transformation, main_argument;
    
    pos := PositionFirstComponent( Functor!.natural_transformations, name );
    
    natural_transformation := Functor!.natural_transformations[ pos ];
    
    if IsBound( natural_transformation[2] ) then
        main_argument := natural_transformation[2];
    else
        if IsBound( Functor!.0 ) then
            main_argument := 2;
        else
            main_argument := 1;
        fi;
    fi;
    
    main_argument := args[ main_argument ];
    
    if not IsBound( main_argument!.natural_transformations ) then
        main_argument!.natural_transformations := rec( );
    fi;
    if not IsBound( main_argument!.natural_transformations!.(name) ) then
        main_argument!.natural_transformations!.(name) := [ ];
    fi;
    Add( main_argument!.natural_transformations!.(name), [ args, List( args, PositionOfTheDefaultPresentation ), nat ] );
    
end );

##
InstallMethod( InstallFunctorOnMorphisms,
        "for homalg functors",
        [ IsHomalgFunctorRep ],
        
  function( Functor )
    local genesis, der_arg, functor_operation, number_of_arguments, filter_mor,
          filter0, filter1_obj, filter1_mor, filter2_obj, filter2_mor,
          filter3_obj, filter3_mor;
    
    if HasGenesis( Functor ) then
        genesis := Genesis( Functor );
        if IsBound( genesis[3] ) then
            der_arg := genesis[3];
        fi;
    fi;
    
    functor_operation := OperationOfFunctor( Functor );
    
    number_of_arguments := MultiplicityOfFunctor( Functor );
    
    if number_of_arguments = 1 then
        
        if not IsBound( Functor!.1[2] ) then
            Functor!.1[2] := HOMALG.FunctorOn;
        fi;
        
        if not IsBound( Functor!.1[2][2] ) then
            return fail;
        fi;
        
        filter_mor := Functor!.1[2][2];
        
        if IsFilter( filter_mor ) then
            
            if IsBound( Functor!.0 ) and IsList( Functor!.0 ) then
                
                if Length( Functor!.0 ) = 1 then
                    filter0 := Functor!.0[1];
                else
                    filter0 := IsList;
                fi;
                
                InstallOtherMethod( functor_operation,
                        "for homalg morphisms",
                        [ filter0, filter_mor ],
                  function( c, m )
                    
                    return FunctorMor( Functor, m, [ [ 1, c ] ] );
                    
                end );
                
            else
                
                InstallOtherMethod( functor_operation,
                        "for homalg morphisms",
                        [ filter_mor ],
                  function( m )
                    
                    return FunctorMor( Functor, m );
                    
                end );
                
            fi;
            
        else
            
            Error( "wrong syntax: ", filter_mor, "\n" );
            
        fi;
        
    elif number_of_arguments = 2 then
        
        if not IsBound( Functor!.1[2] ) then
            Functor!.1[2] := HOMALG.FunctorOn;
        fi;
        
        if not IsBound( Functor!.2[2] ) then
            Functor!.2[2] := HOMALG.FunctorOn;
        fi;
        
        if not IsBound( Functor!.1[2][1] ) or not IsBound( Functor!.2[2][1] ) or
           not IsBound( Functor!.1[2][2] ) or not IsBound( Functor!.2[2][2] ) then
            return fail;
        fi;
        
        filter1_obj := Functor!.1[2][1];
        filter1_mor := Functor!.1[2][2];
        
        filter2_obj := Functor!.2[2][1];
        filter2_mor := Functor!.2[2][2];
        
        if IsFilter( filter1_mor ) and IsFilter( filter2_mor ) then
            
            if IsBound( Functor!.0 ) and IsList( Functor!.0 ) then
                
                if Length( Functor!.0 ) = 1 then
                    filter0 := Functor!.0[1];
                else
                    filter0 := IsList;
                fi;
                
                if IsDistinguishedFirstArgumentOfFunctor( Functor ) then
                    
                    InstallOtherMethod( functor_operation,
                            "for homalg morphisms",
                            [ filter0, filter1_mor ],
                      function( c, m )
                        local R;
                        
                        R := StructureObject( m );
                        
                        return functor_operation( c, m, R );
                        
                    end );
                    
                    InstallOtherMethod( functor_operation,
                            "for homalg morphisms",
                            [ IsInt, filter1_mor, IsString ],
                      function( c, m, s )
                        local R;
                        
                        R := StructureObject( m );
                        
                        return functor_operation( c, m, R, s );
                        
                    end );
                    
                fi;
                
                InstallOtherMethod( functor_operation,
                        "for homalg morphisms",
                        [ filter0, filter1_mor, filter2_obj ],
                  function( c, m, o )
                    local obj;
                    
                    if IsHomalgStaticObject( o ) then	## the most probable case
                        obj := o;
                    elif IsStructureObject( o ) then
                        if IsHomalgLeftObjectOrMorphismOfLeftObjects( m ) then
                            obj := AsLeftObject( o );
                        else
                            obj := AsRightObject( o );
                        fi;
                    else
                        ## the default:
                        obj := o;
                    fi;
                    
                    return FunctorMor( Functor, m, [ [ 1, c ], [ 3, obj ] ] );
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg morphisms",
                        [ filter0, filter1_obj, filter2_mor ],
                  function( c, o, m )
                    local obj;
                    
                    if IsHomalgStaticObject( o ) then	## the most probable case
                        obj := o;
                    elif IsStructureObject( o ) then
                        if IsHomalgLeftObjectOrMorphismOfLeftObjects( m ) then
                            obj := AsLeftObject( o );
                        else
                            obj := AsRightObject( o );
                        fi;
                    else
                        ## the default:
                        obj := o;
                    fi;
                    
                    return FunctorMor( Functor, m, [ [ 1, c ], [ 2, obj ] ] );
                    
                end );
                
                if IsCovariantFunctor( Functor, 1 ) = true and
                   IsCovariantFunctor( Functor, 2 ) = true then
                    
                    InstallOtherMethod( functor_operation,
                            "for homalg morphisms",
                            [ filter0, filter1_mor, filter2_mor ],
                      function( c, m1, m2 )
                        local Fm1, Fm2;
                        
                        Fm1 := functor_operation( c, m1, Source( m2 ) );
                        Fm2 := functor_operation( c, Range( m1 ), m2 );
                        
                        if IsHomalgLeftObjectOrMorphismOfLeftObjects( Fm1 ) then
                            return Fm1 * Fm2;
                        else
                            return Fm2 * Fm1;
                        fi;
                        
                    end );
                
                elif IsCovariantFunctor( Functor, 1 ) = false and
                  IsCovariantFunctor( Functor, 2 ) = true then
                    
                    InstallOtherMethod( functor_operation,
                            "for homalg morphisms",
                            [ filter0, filter1_mor, filter2_mor ],
                      function( c, m1, m2 )
                        local Fm1, Fm2;
                        
                        Fm1 := functor_operation( c, m1, Source( m2 ) );
                        Fm2 := functor_operation( c, Source( m1 ), m2 );
                        
                        if IsHomalgLeftObjectOrMorphismOfLeftObjects( Fm1 ) then
                            return Fm1 * Fm2;
                        else
                            return Fm2 * Fm1;
                        fi;
                        
                    end );
                
                fi;
                
                if IsBound( der_arg ) then
                    
                    if IsCovariantFunctor( Functor, der_arg ) then
                        
                        InstallOtherMethod( functor_operation,
                                "for homalg morphisms",
                                [ IsInt, filter1_mor, filter2_obj, IsString ],
                          function( q, m, o, s )
                            local S, T, HS, HT, Hm, c, j;
                            
                            if s <> "a" then
                                TryNextMethod( );
                            fi;
                            
                            S := Source( m );
                            T := Range( m );
                            
                            HS := functor_operation( q, S, o, "a" );
                            HT := functor_operation( q, T, o, "a" );
                            
                            Hm := functor_operation( 0, m, o );
                            
                            c := HomalgChainMorphism( Hm, HS, HT );
                            
                            for j in [ 1 .. q ] do
                                
                                Hm := functor_operation( j, m, o );
                                
                                Add( c, Hm );
                                
                            od;
                            
                            SetIsMorphism( c, true );
                            
                            return c;
                            
                        end );
                        
                    else
                        
                        InstallOtherMethod( functor_operation,
                                "for homalg morphisms",
                                [ IsInt, filter1_mor, filter2_obj, IsString ],
                          function( q, m, o, s )
                            local S, T, HS, HT, Hm, c, j;
                            
                            if s <> "a" then
                                TryNextMethod( );
                            fi;
                            
                            S := Source( m );
                            T := Range( m );
                            
                            HS := functor_operation( q, S, o, "a" );
                            HT := functor_operation( q, T, o, "a" );
                            
                            Hm := functor_operation( 0, m, o );
                            
                            c := HomalgChainMorphism( Hm, HT, HS );
                            
                            for j in [ 1 .. q ] do
                                
                                Hm := functor_operation( j, m, o );
                                
                                Add( c, Hm );
                                
                            od;
                            
                            SetIsMorphism( c, true );
                            
                            return c;
                            
                        end );
                        
                    fi;
                    
                fi;
                
            else
                
                if IsDistinguishedFirstArgumentOfFunctor( Functor ) then
                    
                    InstallOtherMethod( functor_operation,
                            "for homalg morphisms",
                            [ filter1_mor ],
                      function( m )
                        local R;
                        
                        R := StructureObject( m );
                        
                        return functor_operation( m, R );
                        
                    end );
                    
                fi;
                
                InstallOtherMethod( functor_operation,
                        "for homalg morphisms",
                        [ filter1_mor, filter2_obj ],
                  function( m, o )
                    local obj;
                    
                    if IsHomalgStaticObject( o ) then	## the most probable case
                        obj := o;
                    elif IsStructureObject( o ) then
                        if IsHomalgLeftObjectOrMorphismOfLeftObjects( m ) then
                            obj := AsLeftObject( o );
                        else
                            obj := AsRightObject( o );
                        fi;
                    else
                        ## the default:
                        obj := o;
                    fi;
                    
                    return FunctorMor( Functor, m, [ [ 2, obj ] ] );
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg morphisms",
                        [ filter1_obj, filter2_mor ],
                  function( o, m )
                    local obj;
                    
                    if IsHomalgStaticObject( o ) then	## the most probable case
                        obj := o;
                    elif IsStructureObject( o ) then
                        if IsHomalgLeftObjectOrMorphismOfLeftObjects( m ) then
                            obj := AsLeftObject( o );
                        else
                            obj := AsRightObject( o );
                        fi;
                    else
                        ## the default:
                        obj := o;
                    fi;
                    
                    return FunctorMor( Functor, m, [ [ 1, obj ] ] );
                    
                end );
                
                if IsCovariantFunctor( Functor, 1 ) = true and
                   IsCovariantFunctor( Functor, 2 ) = true then
                    
                    InstallOtherMethod( functor_operation,
                            "for homalg morphisms",
                            [ filter1_mor, filter2_mor ],
                      function( m1, m2 )
                        local Fm1, Fm2;
                        
                        Fm1 := functor_operation( m1, Source( m2 ) );
                        Fm2 := functor_operation( Range( m1 ), m2 );
                        
                        if IsHomalgLeftObjectOrMorphismOfLeftObjects( Fm1 ) then
                            return Fm1 * Fm2;
                        else
                            return Fm2 * Fm1;
                        fi;
                        
                    end );
                
                elif IsCovariantFunctor( Functor, 1 ) = false and
                  IsCovariantFunctor( Functor, 2 ) = true then
                    
                    InstallOtherMethod( functor_operation,
                            "for homalg morphisms",
                            [ filter1_mor, filter2_mor ],
                      function( m1, m2 )
                        local Fm1, Fm2;
                        
                        Fm1 := functor_operation( m1, Source( m2 ) );
                        Fm2 := functor_operation( Source( m1 ), m2 );
                        
                        if IsHomalgLeftObjectOrMorphismOfLeftObjects( Fm1 ) then
                            return Fm1 * Fm2;
                        else
                            return Fm2 * Fm1;
                        fi;
                        
                    end );
                
                fi;
                
            fi;
            
        else
            
            Error( "wrong syntax: ", filter1_mor, filter2_mor, "\n" );
            
        fi;
        
    elif number_of_arguments = 3 then
        
        if not IsBound( Functor!.1[2] ) then
            Functor!.1[2] := HOMALG.FunctorOn;
        fi;
        
        if not IsBound( Functor!.2[2] ) then
            Functor!.2[2] := HOMALG.FunctorOn;
        fi;
        
        if not IsBound( Functor!.3[2] ) then
            Functor!.3[2] := HOMALG.FunctorOn;
        fi;
        
        if not IsBound( Functor!.1[2][1] ) or not IsBound( Functor!.2[2][1] ) or not IsBound( Functor!.3[2][1] ) or
           not IsBound( Functor!.1[2][2] ) or not IsBound( Functor!.2[2][2] ) or not IsBound( Functor!.3[2][2] ) then
            return fail;
        fi;
        
        filter1_obj := Functor!.1[2][1];
        filter1_mor := Functor!.1[2][2];
        
        filter2_obj := Functor!.2[2][1];
        filter2_mor := Functor!.2[2][2];
        
        filter3_obj := Functor!.3[2][1];
        filter3_mor := Functor!.3[2][2];
        
        if IsFilter( filter1_mor ) and IsFilter( filter2_mor ) and IsFilter( filter3_mor ) then
            
            if IsBound( Functor!.0 ) and IsList( Functor!.0 ) then
                
                if Length( Functor!.0 ) = 1 then
                    filter0 := Functor!.0[1];
                else
                    filter0 := IsList;
                fi;
                
                if IsDistinguishedFirstArgumentOfFunctor( Functor ) then
                    
                    InstallOtherMethod( functor_operation,
                            "for homalg morphisms",
                            [ filter0, filter1_mor ],
                      function( c, m )
                        local R;
                        
                        R := StructureObject( m );
                        
                        return functor_operation( c, m, R, R );
                        
                    end );
                    
                    InstallOtherMethod( functor_operation,
                            "for homalg morphisms",
                            [ IsInt, filter1_mor, IsString ],
                      function( c, m, s )
                        local R;
                        
                        R := StructureObject( m );
                        
                        return functor_operation( c, m, R, R, s );
                        
                    end );
                    
                fi;
                
                InstallOtherMethod( functor_operation,
                        "for homalg morphisms",
                        [ filter0, filter1_mor, filter2_obj, filter3_obj ],
                  function( c, m, o2, o3 )
                    local obj2, obj3;
                    
                    if IsHomalgStaticObject( o2 ) then	## the most probable case
                        obj2 := o2;
                    elif IsStructureObject( o2 ) then
                        if IsHomalgLeftObjectOrMorphismOfLeftObjects( m ) then
                            obj2 := AsLeftObject( o2 );
                        else
                            obj2 := AsRightObject( o2 );
                        fi;
                    else
                        ## the default:
                        obj2 := o2;
                    fi;
                    
                    if IsHomalgStaticObject( o3 ) then	## the most probable case
                        obj3 := o3;
                    elif IsStructureObject( o3 ) then
                        if IsHomalgLeftObjectOrMorphismOfLeftObjects( m ) then
                            obj3 := AsLeftObject( o3 );
                        else
                            obj3 := AsRightObject( o3 );
                        fi;
                    else
                        ## the default:
                        obj3 := o3;
                    fi;
                    
                    return FunctorMor( Functor, m, [ [ 1, c ], [ 3, obj2 ], [ 4, obj3 ] ] );
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg morphisms",
                        [ filter0, filter1_obj, filter2_mor, filter3_obj ],
                  function( c, o1, m, o3 )
                    local obj1, obj3;
                    
                    if IsHomalgStaticObject( o1 ) then	## the most probable case
                        obj1 := o1;
                    elif IsStructureObject( o1 ) then
                        if IsHomalgLeftObjectOrMorphismOfLeftObjects( m ) then
                            obj1 := AsLeftObject( o1 );
                        else
                            obj1 := AsRightObject( o1 );
                        fi;
                    else
                        ## the default:
                        obj1 := o1;
                    fi;
                    
                    if IsHomalgStaticObject( o3 ) then	## the most probable case
                        obj3 := o3;
                    elif IsStructureObject( o3 ) then
                        if IsHomalgLeftObjectOrMorphismOfLeftObjects( m ) then
                            obj3 := AsLeftObject( o3 );
                        else
                            obj3 := AsRightObject( o3 );
                        fi;
                    else
                        ## the default:
                        obj3 := o3;
                    fi;
                    
                    return FunctorMor( Functor, m, [ [ 1, c ], [ 2, obj1 ], [ 4, obj3 ] ] );
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg morphisms",
                        [ filter0, filter1_obj, filter2_obj, filter3_mor ],
                  function( c, o1, o2, m )
                    local obj1, obj2;
                    
                    if IsHomalgStaticObject( o1 ) then	## the most probable case
                        obj1 := o1;
                    elif IsStructureObject( o1 ) then
                        if IsHomalgLeftObjectOrMorphismOfLeftObjects( m ) then
                            obj1 := AsLeftObject( o1 );
                        else
                            obj1 := AsRightObject( o1 );
                        fi;
                    else
                        ## the default:
                        obj1 := o1;
                    fi;
                    
                    if IsHomalgStaticObject( o2 ) then	## the most probable case
                        obj2 := o2;
                    elif IsStructureObject( o2 ) then
                        if IsHomalgLeftObjectOrMorphismOfLeftObjects( m ) then
                            obj2 := AsLeftObject( o2 );
                        else
                            obj2 := AsRightObject( o2 );
                        fi;
                    else
                        ## the default:
                        obj2 := o2;
                    fi;
                    
                    return FunctorMor( Functor, m, [ [ 1, c ], [ 2, obj1 ], [ 3, obj2 ] ] );
                    
                end );
                
                if IsCovariantFunctor( Functor, 1 ) = true and
                   IsCovariantFunctor( Functor, 2 ) = true and
                   IsCovariantFunctor( Functor, 3 ) = true then
                    
                    InstallOtherMethod( functor_operation,
                            "for homalg morphisms",
                            [ filter0, filter1_mor, filter2_mor, filter3_mor ],
                      function( c, m1, m2, m3 )
                        local Fm1, Fm2, Fm3;
                        
                        Fm1 := functor_operation( c, m1, Source( m2 ), Source( m3 ) );
                        Fm2 := functor_operation( c, Range( m1 ), m2, Source( m3 ) );
                        Fm3 := functor_operation( c, Range( m1 ), Range( m2 ), m3 );
                        
                        if IsHomalgLeftObjectOrMorphismOfLeftObjects( Fm1 ) then
                            return Fm1 * Fm2 * Fm3;
                        else
                            return Fm3 * Fm2 * Fm1;
                        fi;
                        
                    end );
                    
                    ## FIXME: add more cases
                    
                fi;
                
                if IsBound( der_arg ) then
                    
                    if IsCovariantFunctor( Functor, der_arg ) then
                        
                        InstallOtherMethod( functor_operation,
                                "for homalg morphisms",
                                [ IsInt, filter1_mor, filter2_obj, filter3_obj, IsString ],
                          function( q, m, o2, o3, s )
                            local S, T, HS, HT, Hm, c, j;
                            
                            if s <> "a" then
                                TryNextMethod( );
                            fi;
                            
                            S := Source( m );
                            T := Range( m );
                            
                            HS := functor_operation( q, S, o2, o3, "a" );
                            HT := functor_operation( q, T, o2, o3, "a" );
                            
                            Hm := functor_operation( 0, m, o2, o3 );
                            
                            c := HomalgChainMorphism( Hm, HS, HT );
                            
                            for j in [ 1 .. q ] do
                                
                                Hm := functor_operation( j, m, o2, o3 );
                                
                                Add( c, Hm );
                                
                            od;
                            
                            SetIsMorphism( c, true );
                            
                            return c;
                            
                        end );
                        
                    else
                        
                        InstallOtherMethod( functor_operation,
                                "for homalg morphisms",
                                [ IsInt, filter1_mor, filter2_obj, filter3_obj, IsString ],
                          function( q, m, o2, o3, s )
                            local S, T, HS, HT, Hm, c, j;
                            
                            if s <> "a" then
                                TryNextMethod( );
                            fi;
                            
                            S := Source( m );
                            T := Range( m );
                            
                            HS := functor_operation( q, S, o2, o3, "a" );
                            HT := functor_operation( q, T, o2, o3, "a" );
                            
                            Hm := functor_operation( 0, m, o2, o3 );
                            
                            c := HomalgChainMorphism( Hm, HT, HS );
                            
                            for j in [ 1 .. q ] do
                                
                                Hm := functor_operation( j, m, o2, o3 );
                                
                                Add( c, Hm );
                                
                            od;
                            
                            SetIsMorphism( c, true );
                            
                            return c;
                            
                        end );
                        
                    fi;
                    
                fi;
                
            else
                
                if IsDistinguishedFirstArgumentOfFunctor( Functor ) then
                    
                    InstallOtherMethod( functor_operation,
                            "for homalg morphisms",
                            [ filter1_mor ],
                      function( m )
                        local R;
                        
                        R := StructureObject( m );
                        
                        return functor_operation( m, R, R );
                        
                    end );
                    
                fi;
                
                InstallOtherMethod( functor_operation,
                        "for homalg morphisms",
                        [ filter1_mor, filter2_obj, filter3_obj ],
                  function( m, o2, o3 )
                    local obj2, obj3;
                    
                    if IsHomalgStaticObject( o2 ) then	## the most probable case
                        obj2 := o2;
                    elif IsStructureObject( o2 ) then
                        if IsHomalgLeftObjectOrMorphismOfLeftObjects( m ) then
                            obj2 := AsLeftObject( o2 );
                        else
                            obj2 := AsRightObject( o2 );
                        fi;
                    else
                        ## the default:
                        obj2 := o2;
                    fi;
                    
                    return FunctorMor( Functor, m, [ [ 2, obj2 ], [ 3, obj3 ] ] );
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg morphisms",
                        [ filter1_obj, filter2_mor, filter3_obj ],
                  function( o1, m, o3 )
                    local obj1, obj3;
                    
                    if IsHomalgStaticObject( o1 ) then	## the most probable case
                        obj1 := o1;
                    elif IsStructureObject( o1 ) then
                        if IsHomalgLeftObjectOrMorphismOfLeftObjects( m ) then
                            obj1 := AsLeftObject( o1 );
                        else
                            obj1 := AsRightObject( o1 );
                        fi;
                    else
                        ## the default:
                        obj1 := o1;
                    fi;
                    
                    if IsHomalgStaticObject( o3 ) then	## the most probable case
                        obj3 := o3;
                    elif IsStructureObject( o3 ) then
                        if IsHomalgLeftObjectOrMorphismOfLeftObjects( m ) then
                            obj3 := AsLeftObject( o3 );
                        else
                            obj3 := AsRightObject( o3 );
                        fi;
                    else
                        ## the default:
                        obj3 := o3;
                    fi;
                    
                    return FunctorMor( Functor, m, [ [ 1, obj1 ], [ 3, obj3 ] ] );
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg morphisms",
                        [ filter1_mor, filter2_obj, filter3_obj ],
                  function( m, o2, o3 )
                    local obj2, obj3;
                    
                    if IsHomalgStaticObject( o2 ) then	## the most probable case
                        obj2 := o2;
                    elif IsStructureObject( o2 ) then
                        if IsHomalgLeftObjectOrMorphismOfLeftObjects( m ) then
                            obj2 := AsLeftObject( o2 );
                        else
                            obj2 := AsRightObject( o2 );
                        fi;
                    else
                        ## the default:
                        obj2 := o2;
                    fi;
                    
                    if IsHomalgStaticObject( o3 ) then	## the most probable case
                        obj3 := o3;
                    elif IsStructureObject( o3 ) then
                        if IsHomalgLeftObjectOrMorphismOfLeftObjects( m ) then
                            obj3 := AsLeftObject( o3 );
                        else
                            obj3 := AsRightObject( o3 );
                        fi;
                    else
                        ## the default:
                        obj3 := o3;
                    fi;
                    
                    return FunctorMor( Functor, m, [ [ 2, obj2 ], [ 3, obj3 ] ] );
                    
                end );
                
                if IsCovariantFunctor( Functor, 1 ) = true and
                   IsCovariantFunctor( Functor, 2 ) = true and
                   IsCovariantFunctor( Functor, 3 ) = true then
                    
                    InstallOtherMethod( functor_operation,
                            "for homalg morphisms",
                            [ filter1_mor, filter2_mor, filter3_mor ],
                      function( m1, m2, m3 )
                        local Fm1, Fm2, Fm3;
                        
                        Fm1 := functor_operation( m1, Source( m2 ), Source( m3 ) );
                        Fm2 := functor_operation( Range( m1 ), m2, Source( m3 ) );
                        Fm3 := functor_operation( Range( m1 ), Range( m2 ), m3 );
                        
                        if IsHomalgLeftObjectOrMorphismOfLeftObjects( Fm1 ) then
                            return Fm1 * Fm2 * Fm3;
                        else
                            return Fm3 * Fm2 * Fm1;
                        fi;
                        
                    end );
                    
                    ## FIXME: add more cases
                    
                fi;
                
            fi;
            
        else
            
            Error( "wrong syntax: ", filter1_mor, filter2_mor, filter3_mor, "\n" );
            
        fi;
        
    fi;
    
end );

## for the special functors: Cokernel, Kernel, and DefectOfExactness
InstallMethod( InstallSpecialFunctorOnMorphisms,
        "for homalg functors",
        [ IsHomalgFunctorRep ],
        
  function( Functor )
    local functor_operation, filter_mor, filter_special;
    
    functor_operation := OperationOfFunctor( Functor );
    
    if not IsBound( Functor!.1[2] ) or not IsBound( Functor!.1[2][2] ) or not IsList( Functor!.1[2][2] ) then
        return fail;
    fi;
    
    filter_mor := Functor!.1[2][2][1];
    filter_special := Functor!.1[2][2][2];
    
    if IsIdenticalObj( OperationOfFunctor( Functor ), ValueGlobal( "Cokernel" ) ) then
        
        InstallOtherMethod( functor_operation,
                "for homalg special chain morphisms",
                [ filter_mor and filter_special ], 10001,
                function( sq )
            local dS, dT, phi, epiS, epiT;
            
            dS := SourceOfSpecialChainMorphism( sq );
            dT := RangeOfSpecialChainMorphism( sq );
            
            phi := CertainMorphismOfSpecialChainMorphism( sq );
            
            epiS := CokernelEpi( dS );
            epiT := CokernelEpi( dT );
            
            return CompleteKernelSquare( epiS, phi, epiT );
            
        end );
        
    else
        
        InstallOtherMethod( functor_operation,
                "for homalg special chain morphisms",
                [ filter_mor and filter_special ], 10001,
                function( sq )
            local dS, dT, phi, muS, muT, psi;
            
            dS := SourceOfSpecialChainMorphism( sq );
            dT := RangeOfSpecialChainMorphism( sq );
            
            phi := CertainMorphismOfSpecialChainMorphism( sq );
            
            muS := NaturalGeneralizedEmbedding( functor_operation( dS ) );
            muT := NaturalGeneralizedEmbedding( functor_operation( dT ) );
            
            psi := CompleteImageSquare( muS, phi, muT );
            
            Assert( 1, IsMorphism( psi ) );
            
            SetIsMorphism( psi, true );
            
            return psi;
            
        end );
        
    fi;
    
end );

##
InstallGlobalFunction( HelperToInstallUnivariateFunctorOnComplexes,
  function( Functor, filter_cpx, complex_or_cocomplex, i )
    local functor_operation, filter0;
    
    functor_operation := OperationOfFunctor( Functor );
    
    if IsBound( Functor!.0 ) and IsList( Functor!.0 ) then
        
        if Length( Functor!.0 ) = 1 then
            filter0 := Functor!.0[1];
        else
            filter0 := IsList;
        fi;
        
        if IsAdditiveFunctor( Functor ) = true then
            
            InstallOtherMethod( functor_operation,
                    "for homalg complexes",
                    [ filter0, filter_cpx ],
              function( q, c )
                local degrees, l, morphisms, Fc, m;
                
                degrees := ObjectDegreesOfComplex( c );
                
                l := Length( degrees );
                
                if l = 1 then
                    Fc := complex_or_cocomplex( functor_operation( q, CertainObject( c, degrees[1] ) ), degrees[1] );
                else
                    morphisms := MorphismsOfComplex( c );
                    Fc := complex_or_cocomplex( functor_operation( q, morphisms[1] ), degrees[i] );
                    for m in morphisms{[ 2 .. l - 1 ]} do
                        Add( Fc, functor_operation( q, m ) );
                    od;
                fi;
                
                if HasIsGradedObject( c ) and IsGradedObject( c ) then;
                    SetIsGradedObject( Fc, true );
                elif HasIsSplitShortExactSequence( c ) and IsSplitShortExactSequence( c ) then
                    SetIsSplitShortExactSequence( Fc, true );
                elif HasIsComplex( c ) and IsComplex( c ) then
                    SetIsComplex( Fc, true );
                elif HasIsSequence( c ) and IsSequence ( c ) then
                    SetIsSequence( Fc, true );
                fi;
                
                if HasIsATwoSequence( c ) and
                   IsATwoSequence( c ) then
                    SetIsATwoSequence( Fc, true );
                    Fc := AsATwoSequence( Fc );
                fi;
                
                return Fc;
                
            end );
            
        else
            
            InstallOtherMethod( functor_operation,
                    "for homalg complexes",
                    [ filter0, filter_cpx ],
              function( q, c )
                local degrees, l, morphisms, Fc, m;
                
                degrees := ObjectDegreesOfComplex( c );
                
                l := Length( degrees );
                
                if l = 1 then
                    Fc := complex_or_cocomplex( functor_operation( q, CertainObject( c, degrees[1] ) ), degrees[1] );
                else
                    morphisms := MorphismsOfComplex( c );
                    Fc := complex_or_cocomplex( functor_operation( q, morphisms[1] ), degrees[i] );
                    for m in morphisms{[ 2 .. l - 1 ]} do
                        Add( Fc, functor_operation( q, m ) );
                    od;
                fi;
                
                if HasIsATwoSequence( c ) and
                   IsATwoSequence( c ) then
                    SetIsATwoSequence( Fc, true );
                    Fc := AsATwoSequence( Fc );
                fi;
                
                return Fc;
                
            end );
            
        fi;
        
    else
        
        if IsAdditiveFunctor( Functor ) = true then
            
            InstallOtherMethod( functor_operation,
                    "for homalg complexes",
                    [ filter_cpx ],
              function( c )
                local degrees, l, morphisms, Fc, m;
                
                degrees := ObjectDegreesOfComplex( c );
                
                l := Length( degrees );
                
                if l = 1 then
                    Fc := complex_or_cocomplex( functor_operation( CertainObject( c, degrees[1] ) ), degrees[1] );
                else
                    morphisms := MorphismsOfComplex( c );
                    Fc := complex_or_cocomplex( functor_operation( morphisms[1] ), degrees[i] );
                    for m in morphisms{[ 2 .. l - 1 ]} do
                        Add( Fc, functor_operation( m ) );
                    od;
                fi;
                
                if HasIsGradedObject( c ) and IsGradedObject( c ) then;
                    SetIsGradedObject( Fc, true );
                elif HasIsSplitShortExactSequence( c ) and IsSplitShortExactSequence( c ) then
                    SetIsSplitShortExactSequence( Fc, true );
                elif HasIsComplex( c ) and IsComplex( c ) then
                    SetIsComplex( Fc, true );
                elif HasIsSequence( c ) and IsSequence ( c ) then
                    SetIsSequence( Fc, true );
                fi;
                
                if HasIsATwoSequence( c ) and
                   IsATwoSequence( c ) then
                    SetIsATwoSequence( Fc, true );
                    Fc := AsATwoSequence( Fc );
                fi;
                
                return Fc;
                
            end );
            
        else
            
            InstallOtherMethod( functor_operation,
                    "for homalg complexes",
                    [ filter_cpx ],
              function( c )
                local degrees, l, morphisms, Fc, m;
                
                degrees := ObjectDegreesOfComplex( c );
                
                l := Length( degrees );
                
                if l = 1 then
                    Fc := complex_or_cocomplex( functor_operation( CertainObject( c, degrees[1] ) ), degrees[1] );
                else
                    morphisms := MorphismsOfComplex( c );
                    Fc := complex_or_cocomplex( functor_operation( morphisms[1] ), degrees[i] );
                    for m in morphisms{[ 2 .. l - 1 ]} do
                        Add( Fc, functor_operation( m ) );
                    od;
                fi;
                
                if HasIsATwoSequence( c ) and
                   IsATwoSequence( c ) then
                    SetIsATwoSequence( Fc, true );
                    Fc := AsATwoSequence( Fc );
                fi;
                
                return Fc;
                
            end );
            
        fi;
        
    fi;
    
end );

##
InstallGlobalFunction( HelperToInstallFirstArgumentOfBivariateFunctorOnComplexes,
  function( Functor, filter2_obj, filter1_cpx, complex_or_cocomplex, i )
    local functor_operation, filter0;
    
    functor_operation := OperationOfFunctor( Functor );
    
    if IsBound( Functor!.0 ) and IsList( Functor!.0 ) then
        
        if Length( Functor!.0 ) = 1 then
            filter0 := Functor!.0[1];
        else
            filter0 := IsList;
        fi;
        
        if IsDistinguishedFirstArgumentOfFunctor( Functor ) then
            
            InstallOtherMethod( functor_operation,
                    "for homalg complexes",
                    [ filter0, filter1_cpx ],
              function( q, c )
                local R;
                
                R := StructureObject( c );
                
                return functor_operation( q, c, R );
                
            end );
            
        fi;
        
        if IsAdditiveFunctor( Functor, 1 ) = true then
            
            InstallOtherMethod( functor_operation,
                    "for homalg complexes",
                    [ filter0, filter1_cpx, filter2_obj ],
              function( q, c, o )
                local obj, degrees, l, morphisms, Fc, m;
                
                if IsHomalgStaticObject( o ) then	## the most probable case
                    obj := o;
                elif IsStructureObject( o ) then
                    if IsHomalgLeftObjectOrMorphismOfLeftObjects( c ) then
                        obj := AsLeftObject( o );
                    else
                        obj := AsRightObject( o );
                    fi;
                else
                    ## the default:
                    obj := o;
                fi;
                
                degrees := ObjectDegreesOfComplex( c );
                
                l := Length( degrees );
                
                if l = 1 then
                    Fc := complex_or_cocomplex( functor_operation( q, CertainObject( c, degrees[1] ), obj ), degrees[1] );
                else
                    morphisms := MorphismsOfComplex( c );
                    Fc := complex_or_cocomplex( functor_operation( q, morphisms[1], obj ), degrees[i] );
                    for m in morphisms{[ 2 .. l - 1 ]} do
                        Add( Fc, functor_operation( q, m, obj ) );
                    od;
                fi;
                
                if HasIsGradedObject( c ) and IsGradedObject( c ) then;
                    SetIsGradedObject( Fc, true );
                elif HasIsSplitShortExactSequence( c ) and IsSplitShortExactSequence( c ) then
                    SetIsSplitShortExactSequence( Fc, true );
                elif HasIsComplex( c ) and IsComplex( c ) then
                    SetIsComplex( Fc, true );
                elif HasIsSequence( c ) and IsSequence ( c ) then
                    SetIsSequence( Fc, true );
                fi;
                
                if HasIsATwoSequence( c ) and
                   IsATwoSequence( c ) then
                    SetIsATwoSequence( Fc, true );
                    Fc := AsATwoSequence( Fc );
                fi;
                
                return Fc;
                
            end );
            
        else
            
            InstallOtherMethod( functor_operation,
                    "for homalg complexes",
                    [ filter0, filter1_cpx, filter2_obj ],
              function( q, c, o )
                local obj, degrees, l, morphisms, Fc, m;
                
                if IsHomalgStaticObject( o ) then	## the most probable case
                    obj := o;
                elif IsStructureObject( o ) then
                    if IsHomalgLeftObjectOrMorphismOfLeftObjects( c ) then
                        obj := AsLeftObject( o );
                    else
                        obj := AsRightObject( o );
                    fi;
                else
                    ## the default:
                    obj := o;
                fi;
                
                degrees := ObjectDegreesOfComplex( c );
                
                l := Length( degrees );
                
                if l = 1 then
                    Fc := complex_or_cocomplex( functor_operation( q, CertainObject( c, degrees[1] ), obj ), degrees[1] );
                else
                    morphisms := MorphismsOfComplex( c );
                    Fc := complex_or_cocomplex( functor_operation( q, morphisms[1], obj ), degrees[i] );
                    for m in morphisms{[ 2 .. l - 1 ]} do
                        Add( Fc, functor_operation( q, m, obj ) );
                    od;
                fi;
                
                if HasIsATwoSequence( c ) and
                   IsATwoSequence( c ) then
                    SetIsATwoSequence( Fc, true );
                    Fc := AsATwoSequence( Fc );
                fi;
                
                return Fc;
                
            end );
            
        fi;
        
    else
        
        if IsDistinguishedFirstArgumentOfFunctor( Functor ) then
            
            InstallOtherMethod( functor_operation,
                    "for homalg complexes",
                    [ filter1_cpx ],
              function( c )
                local R;
                
                R := StructureObject( c );
                
                return functor_operation( c, R );
                
            end );
            
        fi;
        
        if IsAdditiveFunctor( Functor, 1 ) = true then
            
            InstallOtherMethod( functor_operation,
                    "for homalg complexes",
                    [ filter1_cpx, filter2_obj ],
              function( c, o )
                local obj, degrees, l, morphisms, Fc, m;
                
                if IsHomalgStaticObject( o ) then	## the most probable case
                    obj := o;
                elif IsStructureObject( o ) then
                    if IsHomalgLeftObjectOrMorphismOfLeftObjects( c ) then
                        obj := AsLeftObject( o );
                    else
                        obj := AsRightObject( o );
                    fi;
                else
                    ## the default:
                    obj := o;
                fi;
                
                degrees := ObjectDegreesOfComplex( c );
                
                l := Length( degrees );
                
                if l = 1 then
                    Fc := complex_or_cocomplex( functor_operation( CertainObject( c, degrees[1] ), obj ), degrees[1] );
                else
                    morphisms := MorphismsOfComplex( c );
                    Fc := complex_or_cocomplex( functor_operation( morphisms[1], obj ), degrees[i] );
                    for m in morphisms{[ 2 .. l - 1 ]} do
                        Add( Fc, functor_operation( m, obj ) );
                    od;
                fi;
                
                if HasIsGradedObject( c ) and IsGradedObject( c ) then;
                    SetIsGradedObject( Fc, true );
                elif HasIsSplitShortExactSequence( c ) and IsSplitShortExactSequence( c ) then
                    SetIsSplitShortExactSequence( Fc, true );
                elif HasIsComplex( c ) and IsComplex( c ) then
                    SetIsComplex( Fc, true );
                elif HasIsSequence( c ) and IsSequence ( c ) then
                    SetIsSequence( Fc, true );
                fi;
                
                if HasIsATwoSequence( c ) and
                   IsATwoSequence( c ) then
                    SetIsATwoSequence( Fc, true );
                    Fc := AsATwoSequence( Fc );
                fi;
                
                return Fc;
                
            end );
            
        else
            
            InstallOtherMethod( functor_operation,
                    "for homalg complexes",
                    [ filter1_cpx, filter2_obj ],
              function( c, o )
                local obj, degrees, l, morphisms, Fc, m;
                
                if IsHomalgStaticObject( o ) then	## the most probable case
                    obj := o;
                elif IsStructureObject( o ) then
                    if IsHomalgLeftObjectOrMorphismOfLeftObjects( c ) then
                        obj := AsLeftObject( o );
                    else
                        obj := AsRightObject( o );
                    fi;
                else
                    ## the default:
                    obj := o;
                fi;
                
                degrees := ObjectDegreesOfComplex( c );
                
                l := Length( degrees );
                
                if l = 1 then
                    Fc := complex_or_cocomplex( functor_operation( CertainObject( c, degrees[1] ), obj ), degrees[1] );
                else
                    morphisms := MorphismsOfComplex( c );
                    Fc := complex_or_cocomplex( functor_operation( morphisms[1], obj ), degrees[i] );
                    for m in morphisms{[ 2 .. l - 1 ]} do
                        Add( Fc, functor_operation( m, obj ) );
                    od;
                fi;
                
                if HasIsATwoSequence( c ) and
                   IsATwoSequence( c ) then
                    SetIsATwoSequence( Fc, true );
                    Fc := AsATwoSequence( Fc );
                fi;
                
                return Fc;
                
            end );
            
        fi;
        
    fi;
    
end );

##
InstallGlobalFunction( HelperToInstallSecondArgumentOfBivariateFunctorOnComplexes,
  function( Functor, filter1_obj, filter2_cpx, complex_or_cocomplex, i )
    local functor_operation, filter0;
    
    functor_operation := OperationOfFunctor( Functor );
    
    if IsBound( Functor!.0 ) and IsList( Functor!.0 ) then
        
        if Length( Functor!.0 ) = 1 then
            filter0 := Functor!.0[1];
        else
            filter0 := IsList;
        fi;
        
        if IsAdditiveFunctor( Functor, 2 ) = true then
            
            InstallOtherMethod( functor_operation,
                    "for homalg complexes",
                    [ filter0, filter1_obj, filter2_cpx ],
              function( q, o, c )
                local obj, degrees, l, morphisms, Fc, m;
                
                if IsHomalgStaticObject( o ) then	## the most probable case
                    obj := o;
                elif IsStructureObject( o ) then
                    if IsHomalgLeftObjectOrMorphismOfLeftObjects( c ) then
                        obj := AsLeftObject( o );
                    else
                        obj := AsRightObject( o );
                    fi;
                else
                    ## the default:
                    obj := o;
                fi;
                
                degrees := ObjectDegreesOfComplex( c );
                
                l := Length( degrees );
                
                if l = 1 then
                    Fc := complex_or_cocomplex( functor_operation( q, obj, CertainObject( c, degrees[1] ) ), degrees[1] );
                else
                    morphisms := MorphismsOfComplex( c );
                    Fc := complex_or_cocomplex( functor_operation( q, obj, morphisms[1] ), degrees[i] );
                    for m in morphisms{[ 2 .. l - 1 ]} do
                        Add( Fc, functor_operation( q, obj, m ) );
                    od;
                fi;
                
                if HasIsGradedObject( c ) and IsGradedObject( c ) then;
                    SetIsGradedObject( Fc, true );
                elif HasIsSplitShortExactSequence( c ) and IsSplitShortExactSequence( c ) then
                    SetIsSplitShortExactSequence( Fc, true );
                elif HasIsComplex( c ) and IsComplex( c ) then
                    SetIsComplex( Fc, true );
                elif HasIsSequence( c ) and IsSequence ( c ) then
                    SetIsSequence( Fc, true );
                fi;
                
                if HasIsATwoSequence( c ) and
                   IsATwoSequence( c ) then
                    SetIsATwoSequence( Fc, true );
                    Fc := AsATwoSequence( Fc );
                fi;
                
                return Fc;
                
            end );
            
        else
            
            InstallOtherMethod( functor_operation,
                    "for homalg complexes",
                    [ filter0, filter1_obj, filter2_cpx ],
              function( q, o, c )
                local obj, degrees, l, morphisms, Fc, m;
                
                if IsHomalgStaticObject( o ) then	## the most probable case
                    obj := o;
                elif IsStructureObject( o ) then
                    if IsHomalgLeftObjectOrMorphismOfLeftObjects( c ) then
                        obj := AsLeftObject( o );
                    else
                        obj := AsRightObject( o );
                    fi;
                else
                    ## the default:
                    obj := o;
                fi;
                
                degrees := ObjectDegreesOfComplex( c );
                
                l := Length( degrees );
                
                if l = 1 then
                    Fc := complex_or_cocomplex( functor_operation( q, obj, CertainObject( c, degrees[1] ) ), degrees[1] );
                else
                    morphisms := MorphismsOfComplex( c );
                    Fc := complex_or_cocomplex( functor_operation( q, obj, morphisms[1] ), degrees[i] );
                    for m in morphisms{[ 2 .. l - 1 ]} do
                        Add( Fc, functor_operation( q, obj, m ) );
                    od;
                fi;
                
                if HasIsATwoSequence( c ) and
                   IsATwoSequence( c ) then
                    SetIsATwoSequence( Fc, true );
                    Fc := AsATwoSequence( Fc );
                fi;
                
                return Fc;
                
            end );
            
        fi;
        
    else
        
        if IsAdditiveFunctor( Functor, 2 ) = true then
            
            InstallOtherMethod( functor_operation,
                    "for homalg complexes",
                    [ filter1_obj, filter2_cpx ],
              function( o, c )
                local obj, degrees, l, morphisms, Fc, m;
                
                if IsHomalgStaticObject( o ) then	## the most probable case
                    obj := o;
                elif IsStructureObject( o ) then
                    if IsHomalgLeftObjectOrMorphismOfLeftObjects( c ) then
                        obj := AsLeftObject( o );
                    else
                        obj := AsRightObject( o );
                    fi;
                else
                    ## the default:
                    obj := o;
                fi;
                
                degrees := ObjectDegreesOfComplex( c );
                
                l := Length( degrees );
                
                if l = 1 then
                    Fc := complex_or_cocomplex( functor_operation( obj, CertainObject( c, degrees[1] ) ), degrees[1] );
                else
                    morphisms := MorphismsOfComplex( c );
                    Fc := complex_or_cocomplex( functor_operation( obj, morphisms[1] ), degrees[i] );
                    for m in morphisms{[ 2 .. l - 1 ]} do
                        Add( Fc, functor_operation( obj, m ) );
                    od;
                fi;
                
                if HasIsGradedObject( c ) and IsGradedObject( c ) then;
                    SetIsGradedObject( Fc, true );
                elif HasIsSplitShortExactSequence( c ) and IsSplitShortExactSequence( c ) then
                    SetIsSplitShortExactSequence( Fc, true );
                elif HasIsComplex( c ) and IsComplex( c ) then
                    SetIsComplex( Fc, true );
                elif HasIsSequence( c ) and IsSequence ( c ) then
                    SetIsSequence( Fc, true );
                fi;
                
                if HasIsATwoSequence( c ) and
                   IsATwoSequence( c ) then
                    SetIsATwoSequence( Fc, true );
                    Fc := AsATwoSequence( Fc );
                fi;
                
                return Fc;
                
            end );
            
        else
            
            InstallOtherMethod( functor_operation,
                    "for homalg complexes",
                    [ filter1_obj, filter2_cpx ],
              function( o, c )
                local obj, degrees, l, morphisms, Fc, m;
                
                if IsHomalgStaticObject( o ) then	## the most probable case
                    obj := o;
                elif IsStructureObject( o ) then
                    if IsHomalgLeftObjectOrMorphismOfLeftObjects( c ) then
                        obj := AsLeftObject( o );
                    else
                        obj := AsRightObject( o );
                    fi;
                else
                    ## the default:
                    obj := o;
                fi;
                
                degrees := ObjectDegreesOfComplex( c );
                
                l := Length( degrees );
                
                if l = 1 then
                    Fc := complex_or_cocomplex( functor_operation( obj, CertainObject( c, degrees[1] ) ), degrees[1] );
                else
                    morphisms := MorphismsOfComplex( c );
                    Fc := complex_or_cocomplex( functor_operation( obj, morphisms[1] ), degrees[i] );
                    for m in morphisms{[ 2 .. l - 1 ]} do
                        Add( Fc, functor_operation( obj, m ) );
                    od;
                fi;
                
                if HasIsATwoSequence( c ) and
                   IsATwoSequence( c ) then
                    SetIsATwoSequence( Fc, true );
                    Fc := AsATwoSequence( Fc );
                fi;
                
                return Fc;
                
            end );
            
        fi;
        
    fi;
    
end );

##
InstallGlobalFunction( HelperToInstallFirstArgumentOfBivariateFunctorOnMorphismsAndSecondArgumentOnComplexes,
  function( Functor, filter_mor, filter_cpx )
    local functor_operation, covariant1, filter0;
    
    functor_operation := OperationOfFunctor( Functor );
    
    covariant1 := IsCovariantFunctor( Functor, 1 );
    
    if IsBound( Functor!.0 ) and IsList( Functor!.0 ) then
        
        if Length( Functor!.0 ) = 1 then
            filter0 := Functor!.0[1];
        else
            filter0 := IsList;
        fi;
        
        if IsAdditiveFunctor( Functor, 1 ) = true then
            ## FIXME: add code
        fi;
        
    else
        
        if IsAdditiveFunctor( Functor, 1 ) = true then
            
            InstallOtherMethod( functor_operation,
                    "for homalg complexes",
                    [ filter_mor, filter_cpx ],
              function( m, c )
                local degrees, l, objects, Fc_source, Fc_target, Fc, o;
                
                degrees := ObjectDegreesOfComplex( c );
                
                l := Length( degrees );
                
                objects := ObjectsOfComplex( c );
                
                if covariant1 = true then
                    Fc_source := functor_operation( Source( m ), c );
                    Fc_target := functor_operation( Range( m ), c );
                else
                    Fc_target := functor_operation( Source( m ), c );
                    Fc_source := functor_operation( Range( m ), c );
                fi;
                
                Fc := HomalgChainMorphism( functor_operation( m, objects[1] ), Fc_source, Fc_target );
                
                for o in objects{[ 2 .. l ]} do
                    Add( Fc, functor_operation( m, o ) );
                od;
                
                if HasIsGradedObject( c ) and IsGradedObject( c ) then;
                    SetIsGradedMorphism( Fc, true );
                elif HasIsComplex( c ) and IsComplex( c ) then
                    SetIsMorphism( Fc, true );
                fi;
                
                return Fc;
                
            end );
            
        fi;
        
    fi;
    
end );

##
InstallGlobalFunction( HelperToInstallFirstAndSecondArgumentOfBivariateFunctorOnComplexes,
  function( Functor, filter1_cpx, filter2_cpx )
    local functor_operation, covariant1, filter0;
    
    covariant1 := IsCovariantFunctor( Functor, 1 );
    
    functor_operation := OperationOfFunctor( Functor );
    
    if IsBound( Functor!.0 ) and IsList( Functor!.0 ) then
        
        if Length( Functor!.0 ) = 1 then
            filter0 := Functor!.0[1];
        else
            filter0 := IsList;
        fi;
        
        if IsAdditiveFunctor( Functor, 1 ) = true then
            ## FIXME: add code
        fi;
        
    else
        
        if IsAdditiveFunctor( Functor, 1 ) = true then
            
            InstallOtherMethod( functor_operation,
                    "for homalg complexes",
                    [ filter1_cpx, filter2_cpx ],
              function( c, C )
                local degrees, l, morphisms, Fc, m;
                
                degrees := ObjectDegreesOfComplex( c );
                
                l := Length( degrees );
                
                morphisms := MorphismsOfComplex( c );
                
                if l = 1 then
                    if IsComplexOfFinitelyPresentedObjectsRep( c ) then
                        if covariant1 = true then
                            Fc := HomalgComplex( functor_operation( CertainObject( c, degrees[1] ), C ), degrees[1] );
                        else
                            Fc := HomalgCocomplex( functor_operation( CertainObject( c, degrees[1] ), C ), degrees[1] );
                        fi;
                    else
                        if covariant1 = true then
                            Fc := HomalgCocomplex( functor_operation( CertainObject( c, degrees[1] ), C ), degrees[1] );
                        else
                            Fc := HomalgComplex( functor_operation( CertainObject( c, degrees[1] ), C ), degrees[1] );
                        fi;
                    fi;
                else
                    morphisms := MorphismsOfComplex( c );
                    if IsComplexOfFinitelyPresentedObjectsRep( c ) then
                        if covariant1 then
                            Fc := HomalgComplex( functor_operation( morphisms[1], C ), degrees[2] );
                        else
                            Fc := HomalgCocomplex( functor_operation( morphisms[1], C ), degrees[1] );
                        fi;
                    else
                        if covariant1 then
                            Fc := HomalgCocomplex( functor_operation( morphisms[1], C ), degrees[1] );
                        else
                            Fc := HomalgComplex( functor_operation( morphisms[1], C ), degrees[2] );
                        fi;
                    fi;
                    for m in morphisms{[ 2 .. l - 1 ]} do
                        Add( Fc, functor_operation( m, C ) );
                    od;
                fi;
                
                if HasIsGradedObject( c ) and IsGradedObject( c ) then;
                    SetIsGradedObject( Fc, true );
                elif HasIsSplitShortExactSequence( c ) and IsSplitShortExactSequence( c ) then
                    SetIsSplitShortExactSequence( Fc, true );
                elif HasIsComplex( c ) and IsComplex( c ) then
                    SetIsComplex( Fc, true );
                elif HasIsSequence( c ) and IsSequence ( c ) then
                    SetIsSequence( Fc, true );
                fi;
                
                return Fc;
                
            end );
            
        fi;
        
    fi;
    
end );

##
InstallMethod( InstallFunctorOnComplexes,
        "for homalg functors",
        [ IsHomalgFunctorRep ],
        
  function( Functor )
    local number_of_arguments, filter_cpx,
          filter1_obj, filter1_cpx, filter2_obj, filter2_cpx,
          ar, i, complex, cocomplex, head;
    
    number_of_arguments := MultiplicityOfFunctor( Functor );
    
    if number_of_arguments = 1 then
        
        if not IsBound( Functor!.1[2] ) then
            Functor!.1[2] := HOMALG.FunctorOn;
        fi;
        
        if not IsBound( Functor!.1[2][3] ) then
            return fail;
        fi;
        
        filter_cpx := Functor!.1[2][3];
        
        if IsList( filter_cpx ) and Length( filter_cpx ) = 2 and ForAll( filter_cpx, IsFilter ) then
            
            if IsCovariantFunctor( Functor ) = true then
                complex := [ HomalgComplex, 2 ];
                cocomplex := [ HomalgCocomplex, 1 ];
            else
                complex := [ HomalgCocomplex, 1 ];
                cocomplex := [ HomalgComplex, 2  ];
            fi;
            
            head := [ Functor ];
            
            complex := Concatenation( head, [ filter_cpx[1] ], complex );
            cocomplex := Concatenation( head, [ filter_cpx[2] ], cocomplex );
            
            CallFuncList( HelperToInstallUnivariateFunctorOnComplexes, complex );
            CallFuncList( HelperToInstallUnivariateFunctorOnComplexes, cocomplex );
            
        else
            
            Error( "wrong syntax: ", filter_cpx, "\n" );
            
        fi;
        
    elif number_of_arguments = 2 then
        
        if not IsBound( Functor!.1[2] ) then
            Functor!.1[2] := HOMALG.FunctorOn;
        fi;
        
        if not IsBound( Functor!.2[2] ) then
            Functor!.2[2] := HOMALG.FunctorOn;
        fi;
        
        if not IsBound( Functor!.1[2][1] ) or not IsBound( Functor!.2[2][1] ) or
           not IsBound( Functor!.1[2][3] ) or not IsBound( Functor!.2[2][3] ) then
            return fail;
        fi;
        
        filter1_obj := Functor!.1[2][1];
        filter1_cpx := Functor!.1[2][3];
        
        filter2_obj := Functor!.2[2][1];
        filter2_cpx := Functor!.2[2][3];
        
        if IsList( filter1_cpx ) and Length( filter1_cpx ) = 2 and ForAll( filter1_cpx, IsFilter ) and
           IsList( filter2_cpx ) and Length( filter2_cpx ) = 2 and ForAll( filter2_cpx, IsFilter ) then
            
            ar := [ [ filter2_obj, filter1_cpx, HelperToInstallFirstArgumentOfBivariateFunctorOnComplexes ],
                    [ filter1_obj, filter2_cpx, HelperToInstallSecondArgumentOfBivariateFunctorOnComplexes ] ];
            
            for i in [ 1 .. number_of_arguments ] do
                
                if IsCovariantFunctor( Functor, i ) = true then
                    complex :=  [ HomalgComplex, 2 ];
                    cocomplex := [ HomalgCocomplex, 1 ];
                else
                    complex := [ HomalgCocomplex, 1 ];
                    cocomplex := [ HomalgComplex, 2 ];
                fi;
                
                head := [ Functor, ar[i][1] ];
                
                complex := Concatenation( head, [ ar[i][2][1] ], complex );
                cocomplex := Concatenation( head, [ ar[i][2][2] ], cocomplex );
                
                CallFuncList( ar[i][3], complex );
                CallFuncList( ar[i][3], cocomplex );
                
            od;
            
            HelperToInstallFirstArgumentOfBivariateFunctorOnMorphismsAndSecondArgumentOnComplexes( Functor, IsHomalgMorphism, IsHomalgComplex );
            HelperToInstallFirstAndSecondArgumentOfBivariateFunctorOnComplexes( Functor, IsHomalgComplex, IsHomalgComplex );
            
        else
            
            Error( "wrong syntax: ", filter1_cpx, filter2_cpx, "\n" );
            
        fi;
        
    fi;
    
end );

##
InstallGlobalFunction( HelperToInstallUnivariateFunctorOnChainMorphisms,
  function( Functor, filter_chm, source_target, i )
    local functor_operation, filter0;
    
    functor_operation := OperationOfFunctor( Functor );
    
    if IsBound( Functor!.0 ) and IsList( Functor!.0 ) then
        
        if Length( Functor!.0 ) = 1 then
            filter0 := Functor!.0[1];
        else
            filter0 := IsList;
        fi;
        
        if IsAdditiveFunctor( Functor ) = true then
            
            InstallOtherMethod( functor_operation,
                    "for homalg chain morphisms",
                    [ filter0, filter_chm ],
              function( q, c )
                local d, degrees, l, source, target, morphisms, Fc, m;
                
                d := DegreeOfMorphism( c );
                
                degrees := DegreesOfChainMorphism( c );
                
                l := Length( degrees );
                
                source := functor_operation( q, source_target[1]( c ) );
                target := functor_operation( q, source_target[2]( c ) );
                
                morphisms := MorphismsOfChainMorphism( c );
                
                Fc := HomalgChainMorphism( functor_operation( q, morphisms[1] ), source, target, [ degrees[1] + i * d, (-1)^i * d ] );
                
                for m in morphisms{[ 2 .. l ]} do
                    Add( Fc, functor_operation( q, m ) );
                od;
                
                if HasIsMorphism( c ) and IsMorphism( c ) then
                    SetIsMorphism( Fc, true );
                fi;
                
                return Fc;
                
            end );
            
        else
            
            InstallOtherMethod( functor_operation,
                    "for homalg chain morphisms",
                    [ filter0, filter_chm ],
              function( q, c )
                local d, degrees, l, source, target, morphisms, Fc, m;
                
                d := DegreeOfMorphism( c );
                
                degrees := DegreesOfChainMorphism( c );
                
                l := Length( degrees );
                
                source := functor_operation( q, source_target[1]( c ) );
                target := functor_operation( q, source_target[2]( c ) );
                
                morphisms := MorphismsOfChainMorphism( c );
                
                Fc := HomalgChainMorphism( functor_operation( q, morphisms[1] ), source, target, [ degrees[1] + i * d, (-1)^i * d ] );
                
                for m in morphisms{[ 2 .. l ]} do
                    Add( Fc, functor_operation( q, m ) );
                od;
                
                return Fc;
                
            end );
            
        fi;
        
    else
        
        if IsAdditiveFunctor( Functor ) = true then
            
            InstallOtherMethod( functor_operation,
                    "for homalg chain morphisms",
                    [ filter_chm ],
              function( c )
                local d, degrees, l, source, target, morphisms, Fc, m;
                
                d := DegreeOfMorphism( c );
                
                degrees := DegreesOfChainMorphism( c );
                
                l := Length( degrees );
                
                source := functor_operation( source_target[1]( c ) );
                target := functor_operation( source_target[2]( c ) );
                
                morphisms := MorphismsOfChainMorphism( c );
                
                Fc := HomalgChainMorphism( functor_operation( morphisms[1] ), source, target, [ degrees[1] + i * d, (-1)^i * d ] );
                
                for m in morphisms{[ 2 .. l ]} do
                    Add( Fc, functor_operation( m ) );
                od;
                
                if HasIsMorphism( c ) and IsMorphism( c ) then
                    SetIsMorphism( Fc, true );
                fi;
                
                return Fc;
                
            end );
            
        else
            
            InstallOtherMethod( functor_operation,
                    "for homalg chain morphisms",
                    [ filter_chm ],
              function( c )
                local d, degrees, l, source, target, morphisms, Fc, m;
                
                d := DegreeOfMorphism( c );
                
                degrees := DegreesOfChainMorphism( c );
                
                l := Length( degrees );
                
                source := functor_operation( source_target[1]( c ) );
                target := functor_operation( source_target[2]( c ) );
                
                morphisms := MorphismsOfChainMorphism( c );
                
                Fc := HomalgChainMorphism( functor_operation( morphisms[1] ), source, target, [ degrees[1] + i * d, (-1)^i * d ] );
                
                for m in morphisms{[ 2 .. l ]} do
                    Add( Fc, functor_operation( m ) );
                od;
                
                return Fc;
                
            end );
            
        fi;
        
    fi;
    
end );

##
InstallGlobalFunction( HelperToInstallFirstArgumentOfBivariateFunctorOnChainMorphisms,
  function( Functor, filter2_obj, filter1_chm, source_target, i )
    local functor_operation, filter0;
    
    functor_operation := OperationOfFunctor( Functor );
    
    if IsBound( Functor!.0 ) and IsList( Functor!.0 ) then
        
        if Length( Functor!.0 ) = 1 then
            filter0 := Functor!.0[1];
        else
            filter0 := IsList;
        fi;
        
        if IsDistinguishedFirstArgumentOfFunctor( Functor ) then
            
            InstallOtherMethod( functor_operation,
                    "for homalg chain morphisms",
                    [ filter0, filter1_chm ],
              function( q, c )
                local R;
                
                R := StructureObject( c );
                
                return functor_operation( q, c, R );
                
            end );
            
        fi;
        
        if IsAdditiveFunctor( Functor, 1 ) = true then
            
            InstallOtherMethod( functor_operation,
                    "for homalg chain morphisms",
                    [ filter0, filter1_chm, filter2_obj ],
              function( q, c, o )
                local obj, d, degrees, l, source, target, morphisms, Fc, m;
                
                if IsHomalgStaticObject( o ) then	## the most probable case
                    obj := o;
                elif IsStructureObject( o ) then
                    if IsHomalgLeftObjectOrMorphismOfLeftObjects( c ) then
                        obj := AsLeftObject( o );
                    else
                        obj := AsRightObject( o );
                    fi;
                else
                    ## the default:
                    obj := o;
                fi;
                
                d := DegreeOfMorphism( c );
                
                degrees := DegreesOfChainMorphism( c );
                
                l := Length( degrees );
                
                source := functor_operation( q, source_target[1]( c ), obj );
                target := functor_operation( q, source_target[2]( c ), obj );
                
                morphisms := MorphismsOfChainMorphism( c );
                
                Fc := HomalgChainMorphism( functor_operation( q, morphisms[1], obj ), source, target, [ degrees[1] + i * d, (-1)^i * d ] );
                
                for m in morphisms{[ 2 .. l ]} do
                    Add( Fc, functor_operation( q, m, obj ) );
                od;
                
                if HasIsMorphism( c ) and IsMorphism( c ) then
                    SetIsMorphism( Fc, true );
                fi;
                
                return Fc;
                
            end );
            
        else
            
            InstallOtherMethod( functor_operation,
                    "for homalg chain morphisms",
                    [ filter0, filter1_chm, filter2_obj ],
              function( q, c, o )
                local obj, d, degrees, l, source, target, morphisms, Fc, m;
                
                if IsHomalgStaticObject( o ) then	## the most probable case
                    obj := o;
                elif IsStructureObject( o ) then
                    if IsHomalgLeftObjectOrMorphismOfLeftObjects( c ) then
                        obj := AsLeftObject( o );
                    else
                        obj := AsRightObject( o );
                    fi;
                else
                    ## the default:
                    obj := o;
                fi;
                
                d := DegreeOfMorphism( c );
                
                degrees := DegreesOfChainMorphism( c );
                
                l := Length( degrees );
                
                source := functor_operation( q, source_target[1]( c ), obj );
                target := functor_operation( q, source_target[2]( c ), obj );
                
                morphisms := MorphismsOfChainMorphism( c );
                
                Fc := HomalgChainMorphism( functor_operation( q, morphisms[1], obj ), source, target, [ degrees[1] + i * d, (-1)^i * d ] );
                
                for m in morphisms{[ 2 .. l ]} do
                    Add( Fc, functor_operation( q, m, obj ) );
                od;
                
                return Fc;
                
            end );
            
        fi;
        
    else
        
        if IsDistinguishedFirstArgumentOfFunctor( Functor ) then
            
            InstallOtherMethod( functor_operation,
                    "for homalg chain morphisms",
                    [ filter1_chm ],
              function( c )
                local R;
                
                R := StructureObject( c );
                
                return functor_operation( c, R );
                
            end );
            
        fi;
        
        if IsAdditiveFunctor( Functor, 1 ) = true then
            
            InstallOtherMethod( functor_operation,
                    "for homalg chain morphisms",
                    [ filter1_chm, filter2_obj ],
              function( c, o )
                local obj, d, degrees, l, source, target, morphisms, Fc, m;
                
                if IsHomalgStaticObject( o ) then	## the most probable case
                    obj := o;
                elif IsStructureObject( o ) then
                    if IsHomalgLeftObjectOrMorphismOfLeftObjects( c ) then
                        obj := AsLeftObject( o );
                    else
                        obj := AsRightObject( o );
                    fi;
                else
                    ## the default:
                    obj := o;
                fi;
                
                d := DegreeOfMorphism( c );
                
                degrees := DegreesOfChainMorphism( c );
                
                l := Length( degrees );
                
                source := functor_operation( source_target[1]( c ), obj );
                target := functor_operation( source_target[2]( c ), obj );
                
                morphisms := MorphismsOfChainMorphism( c );
                
                Fc := HomalgChainMorphism( functor_operation( morphisms[1], obj ), source, target, [ degrees[1] + i * d, (-1)^i * d ] );
                
                for m in morphisms{[ 2 .. l ]} do
                    Add( Fc, functor_operation( m, obj ) );
                od;
                
                if HasIsMorphism( c ) and IsMorphism( c ) then
                    SetIsMorphism( Fc, true );
                fi;
                
                return Fc;
                
            end );
            
        else
            
            InstallOtherMethod( functor_operation,
                    "for homalg chain morphisms",
                    [ filter1_chm, filter2_obj ],
              function( c, o )
                local obj, d, degrees, l, source, target, morphisms, Fc, m;
                
                if IsHomalgStaticObject( o ) then	## the most probable case
                    obj := o;
                elif IsStructureObject( o ) then
                    if IsHomalgLeftObjectOrMorphismOfLeftObjects( c ) then
                        obj := AsLeftObject( o );
                    else
                        obj := AsRightObject( o );
                    fi;
                else
                    ## the default:
                    obj := o;
                fi;
                
                d := DegreeOfMorphism( c );
                
                degrees := DegreesOfChainMorphism( c );
                
                l := Length( degrees );
                
                source := functor_operation( source_target[1]( c ), obj );
                target := functor_operation( source_target[2]( c ), obj );
                
                morphisms := MorphismsOfChainMorphism( c );
                
                Fc := HomalgChainMorphism( functor_operation( morphisms[1], obj ), source, target, [ degrees[1] + i * d, (-1)^i * d ] );
                
                for m in morphisms{[ 2 .. l ]} do
                    Add( Fc, functor_operation( m, obj ) );
                od;
                
                return Fc;
                
            end );
            
        fi;
        
    fi;
    
end );

##
InstallGlobalFunction( HelperToInstallSecondArgumentOfBivariateFunctorOnChainMorphisms,
  function( Functor, filter1_obj, filter2_chm, source_target, i )
    local functor_operation, filter0;
    
    functor_operation := OperationOfFunctor( Functor );
    
    if IsBound( Functor!.0 ) and IsList( Functor!.0 ) then
        
        if Length( Functor!.0 ) = 1 then
            filter0 := Functor!.0[1];
        else
            filter0 := IsList;
        fi;
        
        if IsAdditiveFunctor( Functor, 2 ) = true then
            
            InstallOtherMethod( functor_operation,
                    "for homalg chain morphisms",
                    [ filter0, filter1_obj, filter2_chm ],
              function( q, o, c )
                local obj, d, degrees, l, source, target, morphisms, Fc, m;
                
                if IsHomalgStaticObject( o ) then	## the most probable case
                    obj := o;
                elif IsStructureObject( o ) then
                    if IsHomalgLeftObjectOrMorphismOfLeftObjects( c ) then
                        obj := AsLeftObject( o );
                    else
                        obj := AsRightObject( o );
                    fi;
                else
                    ## the default:
                    obj := o;
                fi;
                
                d := DegreeOfMorphism( c );
                
                degrees := DegreesOfChainMorphism( c );
                
                l := Length( degrees );
                
                source := functor_operation( q, obj, source_target[1]( c ) );
                target := functor_operation( q, obj, source_target[2]( c ) );
                
                morphisms := MorphismsOfChainMorphism( c );
                
                Fc := HomalgChainMorphism( functor_operation( q, obj, morphisms[1] ), source, target, [ degrees[1] + i * d, (-1)^i * d ] );
                
                for m in morphisms{[ 2 .. l ]} do
                    Add( Fc, functor_operation( q, obj, m ) );
                od;
                
                if HasIsMorphism( c ) and IsMorphism( c ) then
                    SetIsMorphism( Fc, true );
                fi;
                
                return Fc;
                
            end );
            
        else
            
            InstallOtherMethod( functor_operation,
                    "for homalg chain morphisms",
                    [ filter0, filter1_obj, filter2_chm ],
              function( q, o, c )
                local obj, d, degrees, l, source, target, morphisms, Fc, m;
                
                if IsHomalgStaticObject( o ) then	## the most probable case
                    obj := o;
                elif IsStructureObject( o ) then
                    if IsHomalgLeftObjectOrMorphismOfLeftObjects( c ) then
                        obj := AsLeftObject( o );
                    else
                        obj := AsRightObject( o );
                    fi;
                else
                    ## the default:
                    obj := o;
                fi;
                
                d := DegreeOfMorphism( c );
                
                degrees := DegreesOfChainMorphism( c );
                
                l := Length( degrees );
                
                source := functor_operation( q, obj, source_target[1]( c ) );
                target := functor_operation( q, obj, source_target[2]( c ) );
                
                morphisms := MorphismsOfChainMorphism( c );
                
                Fc := HomalgChainMorphism( functor_operation( q, obj, morphisms[1] ), source, target, [ degrees[1] + i * d, (-1)^i * d ] );
                
                for m in morphisms{[ 2 .. l ]} do
                    Add( Fc, functor_operation( q, obj, m ) );
                od;
                
                return Fc;
                
            end );
            
        fi;
        
    else
        
        if IsAdditiveFunctor( Functor, 2 ) = true then
            
            InstallOtherMethod( functor_operation,
                    "for homalg chain morphisms",
                    [ filter1_obj, filter2_chm ],
              function( o, c )
                local obj, d, degrees, l, source, target, morphisms, Fc, m;
                
                if IsHomalgStaticObject( o ) then	## the most probable case
                    obj := o;
                elif IsStructureObject( o ) then
                    if IsHomalgLeftObjectOrMorphismOfLeftObjects( c ) then
                        obj := AsLeftObject( o );
                    else
                        obj := AsRightObject( o );
                    fi;
                else
                    ## the default:
                    obj := o;
                fi;
                
                d := DegreeOfMorphism( c );
                
                degrees := DegreesOfChainMorphism( c );
                
                l := Length( degrees );
                
                source := functor_operation( obj, source_target[1]( c ) );
                target := functor_operation( obj, source_target[2]( c ) );
                
                morphisms := MorphismsOfChainMorphism( c );
                
                Fc := HomalgChainMorphism( functor_operation( obj, morphisms[1] ), source, target, [ degrees[1] + i * d, (-1)^i * d ] );
                
                for m in morphisms{[ 2 .. l ]} do
                    Add( Fc, functor_operation( obj, m ) );
                od;
                
                if HasIsMorphism( c ) and IsMorphism( c ) then
                    SetIsMorphism( Fc, true );
                fi;
                
                return Fc;
                
            end );
            
        else
            
            InstallOtherMethod( functor_operation,
                    "for homalg chain morphisms",
                    [ filter1_obj, filter2_chm ],
              function( o, c )
                local obj, d, degrees, l, source, target, morphisms, Fc, m;
                
                if IsHomalgStaticObject( o ) then	## the most probable case
                    obj := o;
                elif IsStructureObject( o ) then
                    if IsHomalgLeftObjectOrMorphismOfLeftObjects( c ) then
                        obj := AsLeftObject( o );
                    else
                        obj := AsRightObject( o );
                    fi;
                else
                    ## the default:
                    obj := o;
                fi;
                
                d := DegreeOfMorphism( c );
                
                degrees := DegreesOfChainMorphism( c );
                
                l := Length( degrees );
                
                source := functor_operation( obj, source_target[1]( c ) );
                target := functor_operation( obj, source_target[2]( c ) );
                
                morphisms := MorphismsOfChainMorphism( c );
                
                Fc := HomalgChainMorphism( functor_operation( obj, morphisms[1] ), source, target, [ degrees[1] + i * d, (-1)^i * d ] );
                
                for m in morphisms{[ 2 .. l ]} do
                    Add( Fc, functor_operation( obj, m ) );
                od;
                
                return Fc;
                
            end );
            
        fi;
        
    fi;
    
end );

##
InstallMethod( InstallFunctorOnChainMorphisms,
        "for homalg functors",
        [ IsHomalgFunctorRep ],
        
  function( Functor )
    local number_of_arguments, filter_chm,
          filter1_obj, filter1_chm, filter2_obj, filter2_chm,
          ar, i, chainmorphism, cochainmorphism, head;
    
    number_of_arguments := MultiplicityOfFunctor( Functor );
    
    if number_of_arguments = 1 then
        
        if not IsBound( Functor!.1[2] ) then
            Functor!.1[2] := HOMALG.FunctorOn;
        fi;
        
        if not IsBound( Functor!.1[2][4] ) then
            return fail;
        fi;
        
        filter_chm := Functor!.1[2][4];
        
        if IsList( filter_chm ) and Length( filter_chm ) = 2 and ForAll( filter_chm, IsFilter ) then
            
            if IsCovariantFunctor( Functor ) = true then
                chainmorphism := [ [ Source, Range ], 0 ];
                cochainmorphism := [ [ Source, Range ], 0 ];
            else
                chainmorphism := [ [ Range, Source ], 1 ];
                cochainmorphism := [ [ Range, Source ], 1 ];
            fi;
            
            head := [ Functor ];
            
            chainmorphism := Concatenation( head, [ filter_chm[1] ], chainmorphism );
            cochainmorphism := Concatenation( head, [ filter_chm[2] ], cochainmorphism );
            
            CallFuncList( HelperToInstallUnivariateFunctorOnChainMorphisms, chainmorphism );
            CallFuncList( HelperToInstallUnivariateFunctorOnChainMorphisms, cochainmorphism );
            
        else
            
            Error( "wrong syntax: ", filter_chm, "\n" );
            
        fi;
        
    elif number_of_arguments = 2 then
        
        if not IsBound( Functor!.1[2] ) then
            Functor!.1[2] := HOMALG.FunctorOn;
        fi;
        
        if not IsBound( Functor!.2[2] ) then
            Functor!.2[2] := HOMALG.FunctorOn;
        fi;
        
        if not IsBound( Functor!.1[2][1] ) or not IsBound( Functor!.2[2][1] ) or
           not IsBound( Functor!.1[2][4] ) or not IsBound( Functor!.2[2][4] ) then
            return fail;
        fi;
        
        filter1_obj := Functor!.1[2][1];
        filter1_chm := Functor!.1[2][4];
        
        filter2_obj := Functor!.2[2][1];
        filter2_chm := Functor!.2[2][4];
        
        if IsList( filter1_chm ) and Length( filter1_chm ) = 2 and ForAll( filter1_chm, IsFilter ) and
           IsList( filter2_chm ) and Length( filter2_chm ) = 2 and ForAll( filter2_chm, IsFilter ) then
            
            ar := [ [ filter2_obj, filter1_chm, HelperToInstallFirstArgumentOfBivariateFunctorOnChainMorphisms ],
                    [ filter1_obj, filter2_chm, HelperToInstallSecondArgumentOfBivariateFunctorOnChainMorphisms ] ];
            
            for i in [ 1 .. number_of_arguments ] do
                
                if IsCovariantFunctor( Functor, i ) = true then
                    chainmorphism := [ [ Source, Range ], 0 ];
                    cochainmorphism := [ [ Source, Range ], 0 ];
                else
                    chainmorphism := [ [ Range, Source ], 1 ];
                    cochainmorphism := [ [ Range, Source ], 1 ];
                fi;
                
                head := [ Functor, ar[i][1] ];
                
                chainmorphism := Concatenation( head, [ ar[i][2][1] ], chainmorphism );
                cochainmorphism := Concatenation( head, [ ar[i][2][2] ], cochainmorphism );
                
                CallFuncList( ar[i][3], chainmorphism );
                CallFuncList( ar[i][3], cochainmorphism );
                
            od;
            
        else
            
            Error( "wrong syntax: ", filter1_chm, filter2_chm, "\n" );
            
        fi;
        
    fi;
    
end );

##  <#GAPDoc Label="InstallFunctor">
##  <ManSection>
##    <Oper Arg="F" Name="InstallFunctor"/>
##    <Description>
##      Install several methods for &GAP; operations that get declared under the name of the &homalg; (multi-)functor
##      <A>F</A> (&see; <Ref Oper="NameOfFunctor"/>). These methods are used to apply the functor to objects, morphisms,
##      (co)complexes of objects, and (co)chain morphisms. The objects in the (co)complexes might again be (co)complexes.
##      <P/>
##      (For purely technical reasons the multiplicity of the functor might at most be three.
##       This restriction should disappear in future versions.)
##      <Listing Type="Code"><![CDATA[
InstallMethod( InstallFunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep ],
        
  function( Functor )
    
    InstallFunctorOnObjects( Functor );
    
    if IsSpecialFunctor( Functor ) then
        
        InstallSpecialFunctorOnMorphisms( Functor );
        
    else
        
        InstallFunctorOnMorphisms( Functor );
        
        InstallFunctorOnComplexes( Functor );
        
        InstallFunctorOnChainMorphisms( Functor );
        
    fi;
    
end );
##  ]]></Listing>
##      The method does not return anything.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##
InstallGlobalFunction( HelperToInstallUnivariateDeltaFunctor,
  function( Functor )
    local genesis, der, original_operation, functor_operation,
          filter0;
    
    genesis := Genesis( Functor );
    
    der := genesis[1];
    
    original_operation := OperationOfFunctor( genesis[2] );
    
    functor_operation := OperationOfFunctor( Functor );
    
    if IsBound( Functor!.0 ) and IsList( Functor!.0 ) then
        
        if Length( Functor!.0 ) = 1 then
            filter0 := Functor!.0[1];
        else
            filter0 := IsList;
        fi;
        
        if IsAdditiveFunctor( Functor ) = true and genesis[3] = 1 then
            
            if der = "LeftDerivedFunctor" then
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsInt, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsString ],
                  function( n, E, s )
                    local M, N, horse_shoe, d_psi, d_phi, dE, FnM, Fn_1N, j_n, b_n, i_n_1;
                    
                    if s <> "c" then
                        TryNextMethod( );
                    fi;
                    
                    M := LowestDegreeObject( E );
                    N := HighestDegreeObject( E );
                    
                    horse_shoe := Resolution( n, E );
                    
                    d_psi := LowestDegreeMorphism( horse_shoe );
                    d_phi := HighestDegreeMorphism( horse_shoe );
                    
                    dE := Source( d_psi );
                    
                    FnM := functor_operation( n, M );
                    Fn_1N := functor_operation( n - 1, N );
                    
                    j_n := CertainMorphism( d_psi, n );
                    b_n := CertainMorphism( dE, n );
                    i_n_1 := CertainMorphism( d_phi, n - 1 );
                    
                    j_n := original_operation( j_n );
                    b_n := original_operation( b_n );
                    i_n_1 := original_operation( i_n_1 );
                    
                    return ConnectingHomomorphism( FnM, j_n, b_n, i_n_1, Fn_1N );
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsInt, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsString ],
                  function( n, E, s )
                    local M, N, HM, HN, delta, c, j;
                    
                    if s <> "a" then
                        TryNextMethod( );
                    fi;
                    
                    M := LowestDegreeObject( E );
                    N := HighestDegreeObject( E );
                    
                    HM := functor_operation( n, M, "a" );
                    HN := functor_operation( n, N, "a" );
                    
                    delta := functor_operation( 1, E, "c" );
                    
                    c := HomalgChainMorphism( delta, HM, HN, [ 1, -1 ] );
                    
                    for j in [ 2 .. n ] do
                        
                        delta := functor_operation( j, E, "c" );
                        
                        Add( c, delta );
                        
                    od;
                    
                    SetIsMorphism( c, true );
                    
                    return c;
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsInt, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsString ],
                  function( n, E, s )
                    local psi, phi, Hpsi, Hphi, delta, T;
                    
                    if s <> "t" then
                        TryNextMethod( );
                    fi;
                    
                    psi := LowestDegreeMorphism( E );
                    phi := HighestDegreeMorphism( E );
                    
                    Hpsi := functor_operation( n, psi, "a" );
                    Hphi := functor_operation( n, phi, "a" );
                    
                    delta := functor_operation( n, E, "a" );
                    
                    T := HomalgComplex( Hpsi );
                    Add( T, Hphi );
                    Add( T, delta );
                    
                    SetIsExactTriangle( T, true );
                    
                    return T;
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence ],
                  function( E )
                    local M, N, n, psi, phi, Hpsi, Hphi, delta, T;
                    
                    M := LowestDegreeObject( E );
                    N := HighestDegreeObject( E );
                    
                    n := Maximum( List( [ M, N ], LengthOfResolution ) );
                    
                    return functor_operation( n, E, "t" );
                    
                end );
                
            elif der = "RightDerivedCofunctor" then
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsInt, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsString ],
                  function( n, E, s )
                    local M, N, horse_shoe, d_psi, d_phi, dE, FnN, Fnp1M, i_n, b_np1, j_np1, b_n;
                    
                    if s <> "c" then
                        TryNextMethod( );
                    fi;
                    
                    M := LowestDegreeObject( E );
                    N := HighestDegreeObject( E );
                    
                    horse_shoe := Resolution( n + 1, E );
                    
                    d_psi := LowestDegreeMorphism( horse_shoe );
                    d_phi := HighestDegreeMorphism( horse_shoe );
                    
                    dE := Source( d_psi );
                    
                    FnN := functor_operation( n, N );
                    Fnp1M := functor_operation( n + 1, M );
                    
                    i_n := CertainMorphism( d_phi, n );
                    b_np1 := CertainMorphism( dE, n + 1 );
                    j_np1 := CertainMorphism( d_psi, n + 1 );
                    
                    i_n := original_operation( i_n );
                    b_n := original_operation( b_np1 );
                    j_np1 := original_operation( j_np1 );
                    
                    return ConnectingHomomorphism( FnN, i_n, b_n, j_np1, Fnp1M );
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsInt, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsString ],
                  function( n, E, s )
                    local M, N, HM, HN, delta, c, j;
                    
                    if s <> "a" then
                        TryNextMethod( );
                    fi;
                    
                    M := LowestDegreeObject( E );
                    N := HighestDegreeObject( E );
                    
                    HM := functor_operation( n + 1, M, "a" );
                    HN := functor_operation( n + 1, N, "a" );
                    
                    delta := functor_operation( 0, E, "c" );
                    
                    c := HomalgChainMorphism( delta, HN, HM, [ 0, 1 ] );
                    
                    for j in [ 1 .. n ] do
                        
                        delta := functor_operation( j, E, "c" );
                        
                        Add( c, delta );
                        
                    od;
                    
                    SetIsMorphism( c, true );
                    
                    return c;
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsInt, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsString ],
                  function( n, E, s )
                    local psi, phi, Hpsi, Hphi, delta, T;
                    
                    if s <> "t" then
                        TryNextMethod( );
                    fi;
                    
                    psi := LowestDegreeMorphism( E );
                    phi := HighestDegreeMorphism( E );
                    
                    Hpsi := functor_operation( n + 1, psi, "a" );
                    Hphi := functor_operation( n + 1, phi, "a" );
                    
                    delta := functor_operation( n, E, "a" );
                    
                    T := HomalgCocomplex( Hpsi );
                    Add( T, Hphi );
                    Add( T, delta );
                    
                    SetIsExactTriangle( T, true );
                    
                    return T;
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence ],
                  function( E )
                    local M, N, n, psi, phi, Hpsi, Hphi, delta, T;
                    
                    M := LowestDegreeObject( E );
                    N := HighestDegreeObject( E );
                    
                    n := Maximum( List( [ M, N ], LengthOfResolution ) );
                    
                    return functor_operation( n - 1, E, "t" );
                    
                end );
                
            fi;
            
        fi;
        
    fi;
    
end );

##
InstallGlobalFunction( HelperToInstallFirstArgumentOfBivariateDeltaFunctor,
  function( Functor )
    local genesis, der, original_operation, functor_operation,
          filter0;
    
    genesis := Genesis( Functor );
    
    der := genesis[1];
    
    original_operation := OperationOfFunctor( genesis[2] );
    
    functor_operation := OperationOfFunctor( Functor );
    
    if IsBound( Functor!.0 ) and IsList( Functor!.0 ) then
        
        if Length( Functor!.0 ) = 1 then
            filter0 := Functor!.0[1];
        else
            filter0 := IsList;
        fi;
        
        if IsDistinguishedFirstArgumentOfFunctor( Functor ) then
            
            InstallOtherMethod( functor_operation,
                    "for homalg complexes",
                    [ IsInt, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsString ],
              function( n, E, s )
                local R;
                
                R := StructureObject( E );
                
                return functor_operation( n, E, R, s );
                
            end );
            
            InstallOtherMethod( functor_operation,
                    "for homalg complexes",
                    [ IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence ],
              function( E )
                local R;
                
                R := StructureObject( E );
                
                return functor_operation( E, R );
                
            end );
            
        fi;
        
        if IsAdditiveFunctor( Functor, 1 ) = true and genesis[3] = 1 then
            
            if der = "LeftDerivedFunctor" then
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsInt, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsStructureObjectOrFinitelyPresentedObjectRep, IsString ],
                  function( n, E, o, s )
                    local M, N, horse_shoe, d_psi, d_phi, dE, FnM, Fn_1N, j_n, b_n, i_n_1;
                    
                    if s <> "c" then
                        TryNextMethod( );
                    fi;
                    
                    M := LowestDegreeObject( E );
                    N := HighestDegreeObject( E );
                    
                    horse_shoe := Resolution( n, E );
                    
                    d_psi := LowestDegreeMorphism( horse_shoe );
                    d_phi := HighestDegreeMorphism( horse_shoe );
                    
                    dE := Source( d_psi );
                    
                    FnM := functor_operation( n, M, o );
                    Fn_1N := functor_operation( n - 1, N, o );
                    
                    j_n := CertainMorphism( d_psi, n );
                    b_n := CertainMorphism( dE, n );
                    i_n_1 := CertainMorphism( d_phi, n - 1 );
                    
                    j_n := original_operation( j_n, o );
                    b_n := original_operation( b_n, o );
                    i_n_1 := original_operation( i_n_1, o );
                    
                    return ConnectingHomomorphism( FnM, j_n, b_n, i_n_1, Fn_1N );
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsInt, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsStructureObjectOrFinitelyPresentedObjectRep, IsString ],
                  function( n, E, o, s )
                    local M, N, HM, HN, delta, c, j;
                    
                    if s <> "a" then
                        TryNextMethod( );
                    fi;
                    
                    M := LowestDegreeObject( E );
                    N := HighestDegreeObject( E );
                    
                    HM := functor_operation( n, M, o, "a" );
                    HN := functor_operation( n, N, o, "a" );
                    
                    delta := functor_operation( 1, E, o, "c" );
                    
                    c := HomalgChainMorphism( delta, HM, HN, [ 1, -1 ] );
                    
                    for j in [ 2 .. n ] do
                        
                        delta := functor_operation( j, E, o, "c" );
                        
                        Add( c, delta );
                        
                    od;
                    
                    SetIsMorphism( c, true );
                    
                    return c;
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsInt, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsStructureObjectOrFinitelyPresentedObjectRep, IsString ],
                  function( n, E, o, s )
                    local psi, phi, Hpsi, Hphi, delta, T;
                    
                    if s <> "t" then
                        TryNextMethod( );
                    fi;
                    
                    psi := LowestDegreeMorphism( E );
                    phi := HighestDegreeMorphism( E );
                    
                    Hpsi := functor_operation( n, psi, o, "a" );
                    Hphi := functor_operation( n, phi, o, "a" );
                    
                    delta := functor_operation( n, E, o, "a" );
                    
                    T := HomalgComplex( Hpsi );
                    Add( T, Hphi );
                    Add( T, delta );
                    
                    SetIsExactTriangle( T, true );
                    
                    return T;
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsStructureObjectOrFinitelyPresentedObjectRep ],
                  function( E, o )
                    local M, N, n, psi, phi, Hpsi, Hphi, delta, T;
                    
                    M := LowestDegreeObject( E );
                    N := HighestDegreeObject( E );
                    
                    n := Maximum( List( [ M, N ], LengthOfResolution ) );
                    
                    return functor_operation( n, E, o, "t" );
                    
                end );
                
            elif der = "RightDerivedCofunctor" then
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsInt, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsStructureObjectOrFinitelyPresentedObjectRep, IsString ],
                  function( n, E, o, s )
                    local M, N, horse_shoe, d_psi, d_phi, dE, FnN, Fnp1M, i_n, b_np1, j_np1, b_n;
                    
                    if s <> "c" then
                        TryNextMethod( );
                    fi;
                    
                    M := LowestDegreeObject( E );
                    N := HighestDegreeObject( E );
                    
                    horse_shoe := Resolution( n + 1, E );
                    
                    d_psi := LowestDegreeMorphism( horse_shoe );
                    d_phi := HighestDegreeMorphism( horse_shoe );
                    
                    dE := Source( d_psi );
                    
                    FnN := functor_operation( n, N, o );
                    Fnp1M := functor_operation( n + 1, M, o );
                    
                    i_n := CertainMorphism( d_phi, n );
                    b_np1 := CertainMorphism( dE, n + 1 );
                    j_np1 := CertainMorphism( d_psi, n + 1 );
                    
                    i_n := original_operation( i_n, o );
                    b_n := original_operation( b_np1, o );
                    j_np1 := original_operation( j_np1, o );
                    
                    return ConnectingHomomorphism( FnN, i_n, b_n, j_np1, Fnp1M );
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsInt, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsStructureObjectOrFinitelyPresentedObjectRep, IsString ],
                  function( n, E, o, s )
                    local M, N, HM, HN, delta, c, j;
                    
                    if s <> "a" then
                        TryNextMethod( );
                    fi;
                    
                    M := LowestDegreeObject( E );
                    N := HighestDegreeObject( E );
                    
                    HM := functor_operation( n + 1, M, o, "a" );
                    HN := functor_operation( n + 1, N, o, "a" );
                    
                    delta := functor_operation( 0, E, o, "c" );
                    
                    c := HomalgChainMorphism( delta, HN, HM, [ 0, 1 ] );
                    
                    for j in [ 1 .. n ] do
                        
                        delta := functor_operation( j, E, o, "c" );
                        
                        Add( c, delta );
                        
                    od;
                    
                    SetIsMorphism( c, true );
                    
                    return c;
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsInt, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsStructureObjectOrFinitelyPresentedObjectRep, IsString ],
                  function( n, E, o, s )
                    local psi, phi, Hpsi, Hphi, delta, T;
                    
                    if s <> "t" then
                        TryNextMethod( );
                    fi;
                    
                    psi := LowestDegreeMorphism( E );
                    phi := HighestDegreeMorphism( E );
                    
                    Hpsi := functor_operation( n + 1, psi, o, "a" );
                    Hphi := functor_operation( n + 1, phi, o, "a" );
                    
                    delta := functor_operation( n, E, o, "a" );
                    
                    T := HomalgCocomplex( Hpsi );
                    Add( T, Hphi );
                    Add( T, delta );
                    
                    SetIsExactTriangle( T, true );
                    
                    return T;
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsStructureObjectOrFinitelyPresentedObjectRep ],
                  function( E, o )
                    local M, N, n, psi, phi, Hpsi, Hphi, delta, T;
                    
                    M := LowestDegreeObject( E );
                    N := HighestDegreeObject( E );
                    
                    n := Maximum( List( [ M, N ], LengthOfResolution ) );
                    
                    return functor_operation( n - 1, E, o, "t" );
                    
                end );
                
            fi;
            
        fi;
        
    fi;
    
end );

##
InstallGlobalFunction( HelperToInstallSecondArgumentOfBivariateDeltaFunctor,
  function( Functor )
    local genesis, der, covariant, original_operation, functor_operation,
          filter0;
    
    genesis := Genesis( Functor );
    
    der := genesis[1];
    
    original_operation := OperationOfFunctor( genesis[2] );
    
    functor_operation := OperationOfFunctor( Functor );
    
    if IsBound( Functor!.0 ) and IsList( Functor!.0 ) then
        
        if Length( Functor!.0 ) = 1 then
            filter0 := Functor!.0[1];
        else
            filter0 := IsList;
        fi;
        
        if IsAdditiveFunctor( Functor, 2 ) = true and genesis[3] = 2 then
            
            if der = "LeftDerivedFunctor" then
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsInt, IsStructureObjectOrFinitelyPresentedObjectRep, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsString ],
                  function( n, o, E, s )
                    local M, N, horse_shoe, d_psi, d_phi, dE, FnM, Fn_1N, j_n, b_n, i_n_1;
                    
                    if s <> "c" then
                        TryNextMethod( );
                    fi;
                    
                    M := LowestDegreeObject( E );
                    N := HighestDegreeObject( E );
                    
                    horse_shoe := Resolution( n, E );
                    
                    d_psi := LowestDegreeMorphism( horse_shoe );
                    d_phi := HighestDegreeMorphism( horse_shoe );
                    
                    dE := Source( d_psi );
                    
                    FnM := functor_operation( n, o, M );
                    Fn_1N := functor_operation( n - 1, o, N );
                    
                    j_n := CertainMorphism( d_psi, n );
                    b_n := CertainMorphism( dE, n );
                    i_n_1 := CertainMorphism( d_phi, n - 1 );
                    
                    j_n := original_operation( o, j_n );
                    b_n := original_operation( o, b_n );
                    i_n_1 := original_operation( o, i_n_1 );
                    
                    return ConnectingHomomorphism( FnM, j_n, b_n, i_n_1, Fn_1N );
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsInt, IsStructureObjectOrFinitelyPresentedObjectRep, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsString ],
                  function( n, o, E, s )
                    local M, N, HM, HN, delta, c, j;
                    
                    if s <> "a" then
                        TryNextMethod( );
                    fi;
                    
                    M := LowestDegreeObject( E );
                    N := HighestDegreeObject( E );
                    
                    HM := functor_operation( n, o, M, "a" );
                    HN := functor_operation( n, o, N, "a" );
                    
                    delta := functor_operation( 1, o, E, "c" );
                    
                    c := HomalgChainMorphism( delta, HM, HN, [ 1, -1 ] );
                    
                    for j in [ 2 .. n ] do
                        
                        delta := functor_operation( j, o, E, "c" );
                        
                        Add( c, delta );
                        
                    od;
                    
                    SetIsMorphism( c, true );
                    
                    return c;
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsInt, IsStructureObjectOrFinitelyPresentedObjectRep, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsString ],
                  function( n, o, E, s )
                    local psi, phi, Hpsi, Hphi, delta, T;
                    
                    if s <> "t" then
                        TryNextMethod( );
                    fi;
                    
                    psi := LowestDegreeMorphism( E );
                    phi := HighestDegreeMorphism( E );
                    
                    Hpsi := functor_operation( n, o, psi, "a" );
                    Hphi := functor_operation( n, o, phi, "a" );
                    
                    delta := functor_operation( n, o, E, "a" );
                    
                    T := HomalgComplex( Hpsi );
                    Add( T, Hphi );
                    Add( T, delta );
                    
                    SetIsExactTriangle( T, true );
                    
                    return T;
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsStructureObjectOrFinitelyPresentedObjectRep, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence ],
                  function( o, E )
                    local M, N, n, psi, phi, Hpsi, Hphi, delta, T;
                    
                    M := LowestDegreeObject( E );
                    N := HighestDegreeObject( E );
                    
                    n := Maximum( List( [ M, N ], LengthOfResolution ) );
                    
                    return functor_operation( n, o, E, "t" );
                    
                end );
                
            elif der = "RightDerivedCofunctor" then
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsInt, IsStructureObjectOrFinitelyPresentedObjectRep, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsString ],
                  function( n, o, E, s )
                    local M, N, horse_shoe, d_psi, d_phi, dE, FnN, Fnp1M, i_n, b_np1, j_np1, b_n;
                    
                    if s <> "c" then
                        TryNextMethod( );
                    fi;
                    
                    M := LowestDegreeObject( E );
                    N := HighestDegreeObject( E );
                    
                    horse_shoe := Resolution( n + 1, E );
                    
                    d_psi := LowestDegreeMorphism( horse_shoe );
                    d_phi := HighestDegreeMorphism( horse_shoe );
                    
                    dE := Source( d_psi );
                    
                    FnN := functor_operation( n, o, N );
                    Fnp1M := functor_operation( n + 1, o, M );
                    
                    i_n := CertainMorphism( d_phi, n );
                    b_np1 := CertainMorphism( dE, n + 1 );
                    j_np1 := CertainMorphism( d_psi, n + 1 );
                    
                    i_n := original_operation( o, i_n );
                    b_n := original_operation( o, b_np1 );
                    j_np1 := original_operation( o, j_np1 );
                    
                    return ConnectingHomomorphism( FnN, i_n, b_n, j_np1, Fnp1M );
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsInt, IsStructureObjectOrFinitelyPresentedObjectRep, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsString ],
                  function( n, o, E, s )
                    local M, N, HM, HN, delta, c, j;
                    
                    if s <> "a" then
                        TryNextMethod( );
                    fi;
                    
                    M := LowestDegreeObject( E );
                    N := HighestDegreeObject( E );
                    
                    HM := functor_operation( n + 1, o, M, "a" );
                    HN := functor_operation( n + 1, o, N, "a" );
                    
                    delta := functor_operation( 0, o, E, "c" );
                    
                    c := HomalgChainMorphism( delta, HN, HM, [ 0, 1 ] );
                    
                    for j in [ 1 .. n ] do
                        
                        delta := functor_operation( j, o, E, "c" );
                        
                        Add( c, delta );
                        
                    od;
                    
                    SetIsMorphism( c, true );
                    
                    return c;
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsInt, IsStructureObjectOrFinitelyPresentedObjectRep, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsString ],
                  function( n, o, E, s )
                    local psi, phi, Hpsi, Hphi, delta, T;
                    
                    if s <> "t" then
                        TryNextMethod( );
                    fi;
                    
                    psi := LowestDegreeMorphism( E );
                    phi := HighestDegreeMorphism( E );
                    
                    Hpsi := functor_operation( n + 1, o, psi, "a" );
                    Hphi := functor_operation( n + 1, o, phi, "a" );
                    
                    delta := functor_operation( n, o, E, "a" );
                    
                    T := HomalgCocomplex( Hpsi );
                    Add( T, Hphi );
                    Add( T, delta );
                    
                    SetIsExactTriangle( T, true );
                    
                    return T;
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsStructureObjectOrFinitelyPresentedObjectRep, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence ],
                  function( o, E )
                    local M, N, n, psi, phi, Hpsi, Hphi, delta, T;
                    
                    M := LowestDegreeObject( E );
                    N := HighestDegreeObject( E );
                    
                    n := Maximum( List( [ M, N ], LengthOfResolution ) );
                    
                    return functor_operation( n - 1, o, E, "t" );
                    
                end );
                
            fi;
            
        fi;
        
    fi;
    
end );

##
InstallGlobalFunction( HelperToInstallFirstArgumentOfTrivariateDeltaFunctor,
  function( Functor )
    local genesis, der, original_operation, functor_operation,
          filter0;
    
    genesis := Genesis( Functor );
    
    der := genesis[1];
    
    original_operation := OperationOfFunctor( genesis[2] );
    
    functor_operation := OperationOfFunctor( Functor );
    
    if IsBound( Functor!.0 ) and IsList( Functor!.0 ) then
        
        if Length( Functor!.0 ) = 1 then
            filter0 := Functor!.0[1];
        else
            filter0 := IsList;
        fi;
        
        if IsDistinguishedFirstArgumentOfFunctor( Functor ) then
            
            InstallOtherMethod( functor_operation,
                    "for homalg complexes",
                    [ IsInt, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsString ],
              function( n, E, s )
                local R;
                
                R := StructureObject( E );
                
                return functor_operation( n, E, R, R, s );
                
            end );
            
        fi;
        
        if IsAdditiveFunctor( Functor, 1 ) = true and genesis[3] = 1 then
            
            if der = "LeftDerivedFunctor" then
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsInt, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsStructureObjectOrFinitelyPresentedObjectRep, IsStructureObjectOrFinitelyPresentedObjectRep, IsString ],
                  function( n, E, o2, o3, s )
                    local M, N, horse_shoe, d_psi, d_phi, dE, FnM, Fn_1N, j_n, b_n, i_n_1;
                    
                    if s <> "c" then
                        TryNextMethod( );
                    fi;
                    
                    M := LowestDegreeObject( E );
                    N := HighestDegreeObject( E );
                    
                    horse_shoe := Resolution( n, E );
                    
                    d_psi := LowestDegreeMorphism( horse_shoe );
                    d_phi := HighestDegreeMorphism( horse_shoe );
                    
                    dE := Source( d_psi );
                    
                    FnM := functor_operation( n, M, o2, o3 );
                    Fn_1N := functor_operation( n - 1, N, o2, o3 );
                    
                    j_n := CertainMorphism( d_psi, n );
                    b_n := CertainMorphism( dE, n );
                    i_n_1 := CertainMorphism( d_phi, n - 1 );
                    
                    j_n := original_operation( j_n, o2, o3 );
                    b_n := original_operation( b_n, o2, o3 );
                    i_n_1 := original_operation( i_n_1, o2, o3 );
                    
                    return ConnectingHomomorphism( FnM, j_n, b_n, i_n_1, Fn_1N );
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsInt, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsStructureObjectOrFinitelyPresentedObjectRep, IsStructureObjectOrFinitelyPresentedObjectRep, IsString ],
                  function( n, E, o2, o3, s )
                    local M, N, HM, HN, delta, c, j;
                    
                    if s <> "a" then
                        TryNextMethod( );
                    fi;
                    
                    M := LowestDegreeObject( E );
                    N := HighestDegreeObject( E );
                    
                    HM := functor_operation( n, M, o2, o3, "a" );
                    HN := functor_operation( n, N, o2, o3, "a" );
                    
                    delta := functor_operation( 1, E, o2, o3, "c" );
                    
                    c := HomalgChainMorphism( delta, HM, HN, [ 1, -1 ] );
                    
                    for j in [ 2 .. n ] do
                        
                        delta := functor_operation( j, E, o2, o3, "c" );
                        
                        Add( c, delta );
                        
                    od;
                    
                    SetIsMorphism( c, true );
                    
                    return c;
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsInt, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsStructureObjectOrFinitelyPresentedObjectRep, IsStructureObjectOrFinitelyPresentedObjectRep, IsString ],
                  function( n, E, o2, o3, s )
                    local psi, phi, Hpsi, Hphi, delta, T;
                    
                    if s <> "t" then
                        TryNextMethod( );
                    fi;
                    
                    psi := LowestDegreeMorphism( E );
                    phi := HighestDegreeMorphism( E );
                    
                    Hpsi := functor_operation( n, psi, o2, o3, "a" );
                    Hphi := functor_operation( n, phi, o2, o3, "a" );
                    
                    delta := functor_operation( n, E, o2, o3, "a" );
                    
                    T := HomalgComplex( Hpsi );
                    Add( T, Hphi );
                    Add( T, delta );
                    
                    SetIsExactTriangle( T, true );
                    
                    return T;
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsStructureObjectOrFinitelyPresentedObjectRep, IsStructureObjectOrFinitelyPresentedObjectRep ],
                  function( E, o2, o3 )
                    local M, N, n, psi, phi, Hpsi, Hphi, delta, T;
                    
                    M := LowestDegreeObject( E );
                    N := HighestDegreeObject( E );
                    
                    n := Maximum( List( [ M, N ], LengthOfResolution ) );
                    
                    return functor_operation( n, E, o2, o3, "t" );
                    
                end );
                
            elif der = "RightDerivedCofunctor" then
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsInt, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsStructureObjectOrFinitelyPresentedObjectRep, IsStructureObjectOrFinitelyPresentedObjectRep, IsString ],
                  function( n, E, o2, o3, s )
                    local M, N, horse_shoe, d_psi, d_phi, dE, FnN, Fnp1M, i_n, b_np1, j_np1, b_n;
                    
                    if s <> "c" then
                        TryNextMethod( );
                    fi;
                    
                    M := LowestDegreeObject( E );
                    N := HighestDegreeObject( E );
                    
                    horse_shoe := Resolution( n + 1, E );
                    
                    d_psi := LowestDegreeMorphism( horse_shoe );
                    d_phi := HighestDegreeMorphism( horse_shoe );
                    
                    dE := Source( d_psi );
                    
                    FnN := functor_operation( n, N, o2, o3 );
                    Fnp1M := functor_operation( n + 1, M, o2, o3 );
                    
                    i_n := CertainMorphism( d_phi, n );
                    b_np1 := CertainMorphism( dE, n + 1 );
                    j_np1 := CertainMorphism( d_psi, n + 1 );
                    
                    i_n := original_operation( i_n, o2, o3 );
                    b_n := original_operation( b_np1, o2, o3 );
                    j_np1 := original_operation( j_np1, o2, o3 );
                    
                    return ConnectingHomomorphism( FnN, i_n, b_n, j_np1, Fnp1M );
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsInt, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsStructureObjectOrFinitelyPresentedObjectRep, IsStructureObjectOrFinitelyPresentedObjectRep, IsString ],
                  function( n, E, o2, o3, s )
                    local M, N, HM, HN, delta, c, j;
                    
                    if s <> "a" then
                        TryNextMethod( );
                    fi;
                    
                    M := LowestDegreeObject( E );
                    N := HighestDegreeObject( E );
                    
                    HM := functor_operation( n + 1, M, o2, o3, "a" );
                    HN := functor_operation( n + 1, N, o2, o3, "a" );
                    
                    delta := functor_operation( 0, E, o2, o3, "c" );
                    
                    c := HomalgChainMorphism( delta, HN, HM, [ 0, 1 ] );
                    
                    for j in [ 1 .. n ] do
                        
                        delta := functor_operation( j, E, o2, o3, "c" );
                        
                        Add( c, delta );
                        
                    od;
                    
                    SetIsMorphism( c, true );
                    
                    return c;
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsInt, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsStructureObjectOrFinitelyPresentedObjectRep, IsStructureObjectOrFinitelyPresentedObjectRep, IsString ],
                  function( n, E, o2, o3, s )
                    local psi, phi, Hpsi, Hphi, delta, T;
                    
                    if s <> "t" then
                        TryNextMethod( );
                    fi;
                    
                    psi := LowestDegreeMorphism( E );
                    phi := HighestDegreeMorphism( E );
                    
                    Hpsi := functor_operation( n + 1, psi, o2, o3, "a" );
                    Hphi := functor_operation( n + 1, phi, o2, o3, "a" );
                    
                    delta := functor_operation( n, E, o2, o3, "a" );
                    
                    T := HomalgCocomplex( Hpsi );
                    Add( T, Hphi );
                    Add( T, delta );
                    
                    SetIsExactTriangle( T, true );
                    
                    return T;
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsStructureObjectOrFinitelyPresentedObjectRep, IsStructureObjectOrFinitelyPresentedObjectRep ],
                  function( E, o2, o3 )
                    local M, N, n, psi, phi, Hpsi, Hphi, delta, T;
                    
                    M := LowestDegreeObject( E );
                    N := HighestDegreeObject( E );
                    
                    n := Maximum( List( [ M, N ], LengthOfResolution ) );
                    
                    return functor_operation( n - 1, E, o2, o3, "t" );
                    
                end );
                
            fi;
            
        fi;
        
    fi;
    
end );

##
InstallGlobalFunction( HelperToInstallSecondArgumentOfTrivariateDeltaFunctor,
  function( Functor )
    local genesis, der, covariant, original_operation, functor_operation,
          filter0;
    
    genesis := Genesis( Functor );
    
    der := genesis[1];
    
    original_operation := OperationOfFunctor( genesis[2] );
    
    functor_operation := OperationOfFunctor( Functor );
    
    if IsBound( Functor!.0 ) and IsList( Functor!.0 ) then
        
        if Length( Functor!.0 ) = 1 then
            filter0 := Functor!.0[1];
        else
            filter0 := IsList;
        fi;
        
        if IsAdditiveFunctor( Functor, 2 ) = true and genesis[3] = 2 then
            
            if der = "LeftDerivedFunctor" then
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsInt, IsStructureObjectOrFinitelyPresentedObjectRep, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsStructureObjectOrFinitelyPresentedObjectRep, IsString ],
                  function( n, o1, E, o3, s )
                    local M, N, horse_shoe, d_psi, d_phi, dE, FnM, Fn_1N, j_n, b_n, i_n_1;
                    
                    if s <> "c" then
                        TryNextMethod( );
                    fi;
                    
                    M := LowestDegreeObject( E );
                    N := HighestDegreeObject( E );
                    
                    horse_shoe := Resolution( n, E );
                    
                    d_psi := LowestDegreeMorphism( horse_shoe );
                    d_phi := HighestDegreeMorphism( horse_shoe );
                    
                    dE := Source( d_psi );
                    
                    FnM := functor_operation( n, o1, M, o3 );
                    Fn_1N := functor_operation( n - 1, o1, N, o3 );
                    
                    j_n := CertainMorphism( d_psi, n );
                    b_n := CertainMorphism( dE, n );
                    i_n_1 := CertainMorphism( d_phi, n - 1 );
                    
                    j_n := original_operation( o1, j_n, o3 );
                    b_n := original_operation( o1, b_n, o3 );
                    i_n_1 := original_operation( o1, i_n_1, o3 );
                    
                    return ConnectingHomomorphism( FnM, j_n, b_n, i_n_1, Fn_1N );
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsInt, IsStructureObjectOrFinitelyPresentedObjectRep, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsStructureObjectOrFinitelyPresentedObjectRep, IsString ],
                  function( n, o1, E, o3, s )
                    local M, N, HM, HN, delta, c, j;
                    
                    if s <> "a" then
                        TryNextMethod( );
                    fi;
                    
                    M := LowestDegreeObject( E );
                    N := HighestDegreeObject( E );
                    
                    HM := functor_operation( n, o1, M, o3, "a" );
                    HN := functor_operation( n, o1, N, o3, "a" );
                    
                    delta := functor_operation( 1, o1, E, o3, "c" );
                    
                    c := HomalgChainMorphism( delta, HM, HN, [ 1, -1 ] );
                    
                    for j in [ 2 .. n ] do
                        
                        delta := functor_operation( j, o1, E, o3, "c" );
                        
                        Add( c, delta );
                        
                    od;
                    
                    SetIsMorphism( c, true );
                    
                    return c;
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsInt, IsStructureObjectOrFinitelyPresentedObjectRep, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsStructureObjectOrFinitelyPresentedObjectRep, IsString ],
                  function( n, o1, E, o3, s )
                    local psi, phi, Hpsi, Hphi, delta, T;
                    
                    if s <> "t" then
                        TryNextMethod( );
                    fi;
                    
                    psi := LowestDegreeMorphism( E );
                    phi := HighestDegreeMorphism( E );
                    
                    Hpsi := functor_operation( n, o1, psi, o3, "a" );
                    Hphi := functor_operation( n, o1, phi, o3, "a" );
                    
                    delta := functor_operation( n, o1, E, o3, "a" );
                    
                    T := HomalgComplex( Hpsi );
                    Add( T, Hphi );
                    Add( T, delta );
                    
                    SetIsExactTriangle( T, true );
                    
                    return T;
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsStructureObjectOrFinitelyPresentedObjectRep, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsStructureObjectOrFinitelyPresentedObjectRep ],
                  function( o1, E, o3 )
                    local M, N, n, psi, phi, Hpsi, Hphi, delta, T;
                    
                    M := LowestDegreeObject( E );
                    N := HighestDegreeObject( E );
                    
                    n := Maximum( List( [ M, N ], LengthOfResolution ) );
                    
                    return functor_operation( n, o1, E, o3, "t" );
                    
                end );
                
            elif der = "RightDerivedCofunctor" then
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsInt, IsStructureObjectOrFinitelyPresentedObjectRep, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsStructureObjectOrFinitelyPresentedObjectRep, IsString ],
                  function( n, o1, E, o3, s )
                    local M, N, horse_shoe, d_psi, d_phi, dE, FnN, Fnp1M, i_n, b_np1, j_np1, b_n;
                    
                    if s <> "c" then
                        TryNextMethod( );
                    fi;
                    
                    M := LowestDegreeObject( E );
                    N := HighestDegreeObject( E );
                    
                    horse_shoe := Resolution( n + 1, E );
                    
                    d_psi := LowestDegreeMorphism( horse_shoe );
                    d_phi := HighestDegreeMorphism( horse_shoe );
                    
                    dE := Source( d_psi );
                    
                    FnN := functor_operation( n, o1, N, o3 );
                    Fnp1M := functor_operation( n + 1, o1, M, o3 );
                    
                    i_n := CertainMorphism( d_phi, n );
                    b_np1 := CertainMorphism( dE, n + 1 );
                    j_np1 := CertainMorphism( d_psi, n + 1 );
                    
                    i_n := original_operation( o1, i_n, o3 );
                    b_n := original_operation( o1, b_np1, o3 );
                    j_np1 := original_operation( o1, j_np1, o3 );
                    
                    return ConnectingHomomorphism( FnN, i_n, b_n, j_np1, Fnp1M );
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsInt, IsStructureObjectOrFinitelyPresentedObjectRep, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsStructureObjectOrFinitelyPresentedObjectRep, IsString ],
                  function( n, o1, E, o3, s )
                    local M, N, HM, HN, delta, c, j;
                    
                    if s <> "a" then
                        TryNextMethod( );
                    fi;
                    
                    M := LowestDegreeObject( E );
                    N := HighestDegreeObject( E );
                    
                    HM := functor_operation( n + 1, o1, M, o3, "a" );
                    HN := functor_operation( n + 1, o1, N, o3, "a" );
                    
                    delta := functor_operation( 0, o1, E, o3, "c" );
                    
                    c := HomalgChainMorphism( delta, HN, HM, [ 0, 1 ] );
                    
                    for j in [ 1 .. n ] do
                        
                        delta := functor_operation( j, o1, E, o3, "c" );
                        
                        Add( c, delta );
                        
                    od;
                    
                    SetIsMorphism( c, true );
                    
                    return c;
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsInt, IsStructureObjectOrFinitelyPresentedObjectRep, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsStructureObjectOrFinitelyPresentedObjectRep, IsString ],
                  function( n, o1, E, o3, s )
                    local psi, phi, Hpsi, Hphi, delta, T;
                    
                    if s <> "t" then
                        TryNextMethod( );
                    fi;
                    
                    psi := LowestDegreeMorphism( E );
                    phi := HighestDegreeMorphism( E );
                    
                    Hpsi := functor_operation( n + 1, o1, psi, o3, "a" );
                    Hphi := functor_operation( n + 1, o1, phi, o3, "a" );
                    
                    delta := functor_operation( n, o1, E, o3, "a" );
                    
                    T := HomalgCocomplex( Hpsi );
                    Add( T, Hphi );
                    Add( T, delta );
                    
                    SetIsExactTriangle( T, true );
                    
                    return T;
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsStructureObjectOrFinitelyPresentedObjectRep, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsStructureObjectOrFinitelyPresentedObjectRep ],
                  function( o1, E, o3 )
                    local M, N, n, psi, phi, Hpsi, Hphi, delta, T;
                    
                    M := LowestDegreeObject( E );
                    N := HighestDegreeObject( E );
                    
                    n := Maximum( List( [ M, N ], LengthOfResolution ) );
                    
                    return functor_operation( n - 1, o1, E, o3, "t" );
                    
                end );
                
            fi;
            
        fi;
        
    fi;
    
end );

##
InstallGlobalFunction( HelperToInstallThirdArgumentOfTrivariateDeltaFunctor,
  function( Functor )
    local genesis, der, covariant, original_operation, functor_operation,
          filter0;
    
    genesis := Genesis( Functor );
    
    der := genesis[1];
    
    original_operation := OperationOfFunctor( genesis[2] );
    
    functor_operation := OperationOfFunctor( Functor );
    
    if IsBound( Functor!.0 ) and IsList( Functor!.0 ) then
        
        if Length( Functor!.0 ) = 1 then
            filter0 := Functor!.0[1];
        else
            filter0 := IsList;
        fi;
        
        if IsAdditiveFunctor( Functor, 3 ) = true and genesis[3] = 3 then
            
            if der = "LeftDerivedFunctor" then
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsInt, IsStructureObjectOrFinitelyPresentedObjectRep, IsStructureObjectOrFinitelyPresentedObjectRep, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsString ],
                  function( n, o1, o2, E, s )
                    local M, N, horse_shoe, d_psi, d_phi, dE, FnM, Fn_1N, j_n, b_n, i_n_1;
                    
                    if s <> "c" then
                        TryNextMethod( );
                    fi;
                    
                    M := LowestDegreeObject( E );
                    N := HighestDegreeObject( E );
                    
                    horse_shoe := Resolution( n, E );
                    
                    d_psi := LowestDegreeMorphism( horse_shoe );
                    d_phi := HighestDegreeMorphism( horse_shoe );
                    
                    dE := Source( d_psi );
                    
                    FnM := functor_operation( n, o1, o2, M );
                    Fn_1N := functor_operation( n - 1, o1, o2, N );
                    
                    j_n := CertainMorphism( d_psi, n );
                    b_n := CertainMorphism( dE, n );
                    i_n_1 := CertainMorphism( d_phi, n - 1 );
                    
                    j_n := original_operation( o1, o2, j_n );
                    b_n := original_operation( o1, o2, b_n );
                    i_n_1 := original_operation( o1, o2, i_n_1 );
                    
                    return ConnectingHomomorphism( FnM, j_n, b_n, i_n_1, Fn_1N );
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsInt, IsStructureObjectOrFinitelyPresentedObjectRep, IsStructureObjectOrFinitelyPresentedObjectRep, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsString ],
                  function( n, o1, o2, E, s )
                    local M, N, HM, HN, delta, c, j;
                    
                    if s <> "a" then
                        TryNextMethod( );
                    fi;
                    
                    M := LowestDegreeObject( E );
                    N := HighestDegreeObject( E );
                    
                    HM := functor_operation( n, o1, o2, M, "a" );
                    HN := functor_operation( n, o1, o2, N, "a" );
                    
                    delta := functor_operation( 1, o1, o2, E, "c" );
                    
                    c := HomalgChainMorphism( delta, HM, HN, [ 1, -1 ] );
                    
                    for j in [ 2 .. n ] do
                        
                        delta := functor_operation( j, o1, o2, E, "c" );
                        
                        Add( c, delta );
                        
                    od;
                    
                    SetIsMorphism( c, true );
                    
                    return c;
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsInt, IsStructureObjectOrFinitelyPresentedObjectRep, IsStructureObjectOrFinitelyPresentedObjectRep, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsString ],
                  function( n, o1, o2, E, s )
                    local psi, phi, Hpsi, Hphi, delta, T;
                    
                    if s <> "t" then
                        TryNextMethod( );
                    fi;
                    
                    psi := LowestDegreeMorphism( E );
                    phi := HighestDegreeMorphism( E );
                    
                    Hpsi := functor_operation( n, o1, o2, psi, "a" );
                    Hphi := functor_operation( n, o1, o2, phi, "a" );
                    
                    delta := functor_operation( n, o1, o2, E, "a" );
                    
                    T := HomalgComplex( Hpsi );
                    Add( T, Hphi );
                    Add( T, delta );
                    
                    SetIsExactTriangle( T, true );
                    
                    return T;
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsStructureObjectOrFinitelyPresentedObjectRep, IsStructureObjectOrFinitelyPresentedObjectRep, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence ],
                  function( o1, o2, E )
                    local M, N, n, psi, phi, Hpsi, Hphi, delta, T;
                    
                    M := LowestDegreeObject( E );
                    N := HighestDegreeObject( E );
                    
                    n := Maximum( List( [ M, N ], LengthOfResolution ) );
                    
                    return functor_operation( n, o1, o2, E, "t" );
                    
                end );
                
            elif der = "RightDerivedCofunctor" then
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsInt, IsStructureObjectOrFinitelyPresentedObjectRep, IsStructureObjectOrFinitelyPresentedObjectRep, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsString ],
                  function( n, o1, o2, E, s )
                    local M, N, horse_shoe, d_psi, d_phi, dE, FnN, Fnp1M, i_n, b_np1, j_np1, b_n;
                    
                    if s <> "c" then
                        TryNextMethod( );
                    fi;
                    
                    M := LowestDegreeObject( E );
                    N := HighestDegreeObject( E );
                    
                    horse_shoe := Resolution( n + 1, E );
                    
                    d_psi := LowestDegreeMorphism( horse_shoe );
                    d_phi := HighestDegreeMorphism( horse_shoe );
                    
                    dE := Source( d_psi );
                    
                    FnN := functor_operation( n, o1, o2, N );
                    Fnp1M := functor_operation( n + 1, o1, o2, M );
                    
                    i_n := CertainMorphism( d_phi, n );
                    b_np1 := CertainMorphism( dE, n + 1 );
                    j_np1 := CertainMorphism( d_psi, n + 1 );
                    
                    i_n := original_operation( o1, o2, i_n );
                    b_n := original_operation( o1, o2, b_np1 );
                    j_np1 := original_operation( o1, o2, j_np1 );
                    
                    return ConnectingHomomorphism( FnN, i_n, b_n, j_np1, Fnp1M );
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsInt, IsStructureObjectOrFinitelyPresentedObjectRep, IsStructureObjectOrFinitelyPresentedObjectRep, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsString ],
                  function( n, o1, o2, E, s )
                    local M, N, HM, HN, delta, c, j;
                    
                    if s <> "a" then
                        TryNextMethod( );
                    fi;
                    
                    M := LowestDegreeObject( E );
                    N := HighestDegreeObject( E );
                    
                    HM := functor_operation( n + 1, o1, o2, M, "a" );
                    HN := functor_operation( n + 1, o1, o2, N, "a" );
                    
                    delta := functor_operation( 0, o1, o2, E, "c" );
                    
                    c := HomalgChainMorphism( delta, HN, HM, [ 0, 1 ] );
                    
                    for j in [ 1 .. n ] do
                        
                        delta := functor_operation( j, o1, o2, E, "c" );
                        
                        Add( c, delta );
                        
                    od;
                    
                    SetIsMorphism( c, true );
                    
                    return c;
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsInt, IsStructureObjectOrFinitelyPresentedObjectRep, IsStructureObjectOrFinitelyPresentedObjectRep, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence, IsString ],
                  function( n, o1, o2, E, s )
                    local psi, phi, Hpsi, Hphi, delta, T;
                    
                    if s <> "t" then
                        TryNextMethod( );
                    fi;
                    
                    psi := LowestDegreeMorphism( E );
                    phi := HighestDegreeMorphism( E );
                    
                    Hpsi := functor_operation( n + 1, o1, o2, psi, "a" );
                    Hphi := functor_operation( n + 1, o1, o2, phi, "a" );
                    
                    delta := functor_operation( n, o1, o2, E, "a" );
                    
                    T := HomalgCocomplex( Hpsi );
                    Add( T, Hphi );
                    Add( T, delta );
                    
                    SetIsExactTriangle( T, true );
                    
                    return T;
                    
                end );
                
                InstallOtherMethod( functor_operation,
                        "for homalg complexes",
                        [ IsStructureObjectOrFinitelyPresentedObjectRep, IsStructureObjectOrFinitelyPresentedObjectRep, IsComplexOfFinitelyPresentedObjectsRep and IsShortExactSequence ],
                  function( o1, o2, E )
                    local M, N, n, psi, phi, Hpsi, Hphi, delta, T;
                    
                    M := LowestDegreeObject( E );
                    N := HighestDegreeObject( E );
                    
                    n := Maximum( List( [ M, N ], LengthOfResolution ) );
                    
                    return functor_operation( n - 1, o1, o2, E, "t" );
                    
                end );
                
            fi;
            
        fi;
        
    fi;
    
end );

##  <#GAPDoc Label="InstallDeltaFunctor">
##  <ManSection>
##    <Oper Arg="F" Name="InstallDeltaFunctor"/>
##    <Description>
##      In case <A>F</A> is a <M>\delta</M>-functor in the sense of Grothendieck the procedure installs several
##      operations under the name of the &homalg; (multi-)functor <A>F</A> (&see; <Ref Oper="NameOfFunctor"/>)
##      allowing one to compute connecting homomorphisms, exact triangles, and associated long exact sequences.
##      The input of these operations is a short exact sequence.
##      <P/>
##      (For purely technical reasons the multiplicity of the functor might at most be three.
##       This restriction should disappear in future versions.)
##      <Listing Type="Code"><![CDATA[
InstallMethod( InstallDeltaFunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep ],
        
  function( Functor )
    local number_of_arguments;
    
    number_of_arguments := MultiplicityOfFunctor( Functor );
    
    if number_of_arguments = 1 then
        
        HelperToInstallUnivariateDeltaFunctor( Functor );
        
    elif number_of_arguments = 2 then
        
        HelperToInstallFirstArgumentOfBivariateDeltaFunctor( Functor );
        HelperToInstallSecondArgumentOfBivariateDeltaFunctor( Functor );
        
    elif number_of_arguments = 3 then
        
        HelperToInstallFirstArgumentOfTrivariateDeltaFunctor( Functor );
        HelperToInstallSecondArgumentOfTrivariateDeltaFunctor( Functor );
        HelperToInstallThirdArgumentOfTrivariateDeltaFunctor( Functor );
        
    fi;
    
end );
##  ]]></Listing>
##      The method does not return anything.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##
InstallGlobalFunction( CallOperationFromCategory,
  function( name, arg )
    local M, category;
    
    M := First( arg, IsStructureObjectOrObjectOrMorphism );
    
    if M = fail then
        Error( "no argument points to a category\n" );
    fi;
    
    category := HomalgCategory( M );
    
    if not IsBound( category!.(name) ) then
        Error( "there is no component called ", name, " in the category record" );
    elif not IsFunction( category!.(name) ) then
        Error( "the component called ", name, " in the category record is not a function" );
    fi;
    
    return CallFuncList( category!.(name), arg );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##  <#GAPDoc Label="CreateHomalgFunctor">
##  <ManSection>
##    <Func Arg="list1, list2, ..." Name="CreateHomalgFunctor" Label="constructor for functors"/>
##    <Returns>a &homalg; functor</Returns>
##    <Description>
##      This constructor is used to create functors for &homalg; from scratch. <A>listN</A> is of the form
##      <A>listN = [ stringN, valueN ]</A>. <A>stringN</A> will be the name of a component of the created functor and
##      <A>valueN</A> will be its value. This constructor is listed here for the sake of completeness.
##      Its documentation is rather better placed in a &homalg; programmers guide. The remaining constructors
##      create new functors out of existing ones and are probably more interesting for end users.
##      <P/>
##      The constructor does <E>not</E> invoke <Ref Oper="InstallFunctor"/>. This has to be done manually!
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( CreateHomalgFunctor,
  function( arg )
    local ar, functor, type;
    
    functor := rec( );
    
    for ar in arg do
        if not IsString( ar ) and IsList( ar ) and Length( ar ) = 2 and IsString( ar[1] ) then
            functor.( ar[1] ) := ar[2];
        fi;
    od;
    
    type := TheTypeHomalgFunctor;
    
    ## Objectify:
    Objectify( type, functor );
    
    SetGenesis( functor, Concatenation( [ "CreateHomalgFunctor" ], arg ) );
    
    return functor;
    
end );

##  <#GAPDoc Label="InsertObjectInMultiFunctor">
##  <ManSection>
##    <Oper Arg="F, p, obj, H" Name="InsertObjectInMultiFunctor" Label="constructor for functors given a multi-functor and an object"/>
##    <Returns>a &homalg; functor</Returns>
##    <Description>
##      Given a &homalg; multi-functor <A>F</A> with multiplicity <M>m</M> and a string <A>H</A> return the functor
##      <C>Functor_</C><A>H</A> <M>:=</M> <A>F</A><M>(...,</M><A>obj</A><M>,...)</M>, where <A>obj</A> is inserted at
##      the <A>p</A>-th position. Of course <A>obj</A> must be an object (e.g. ring, module, ...) that can be inserted
##      at this particular position. The string <A>H</A> becomes the name of the returned functor
##      (&see; <Ref Oper="NameOfFunctor"/>). The variable <C>Functor_</C><A>H</A> will automatically be assigned if free,
##      otherwise a warning is issued.
##      <P/>
##      The constructor automatically invokes <Ref Oper="InstallFunctor"/> which installs several necessary operations
##      under the name <A>H</A>.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );
##  Z
##  gap> ZZ * 1;
##  <The free right module of rank 1 on a free generator>
##  gap> InsertObjectInMultiFunctor( Functor_Hom_for_fp_modules, 2, ZZ * 1, "Hom_ZZ" );
##  <The functor Hom_ZZ for f.p. modules and their maps over computable rings>
##  gap> Functor_Hom_ZZ_for_fp_modules;	## got automatically defined
##  <The functor Hom_ZZ for f.p. modules and their maps over computable rings>
##  gap> Hom_ZZ;		## got automatically defined
##  <Operation "Hom_ZZ">
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( InsertObjectInMultiFunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsInt, IsStructureObjectOrFinitelyPresentedObjectRep, IsString, IsString ],
        
  function( Functor, p, o, name, operation )
    local m, functor_name, functor_operation, functor_data, data, i, Fp, fname;
    
    m := MultiplicityOfFunctor( Functor );
    
    if p < 1 then
        Error( "the second argument must be a positive integer\n" );
    elif p > m then
        Error( "the second argument exceeded the multiplicity of the functor\n" );
    fi;
    
    functor_name := NameOfFunctor( Functor );
    
    functor_operation := OperationOfFunctor( Functor );
    
    if m = 1 then
        return functor_operation( o );
    fi;
    
    functor_data := List( [ 1 .. m ], i -> StructuralCopy( Functor!.(i) ) );
    
    if IsBound( Functor!.0 ) then
        data := [ [ "0", Functor!.0 ] ];
    else
        data := [ ];
    fi;
    
    for i in [ 1 .. m ] do
        if i < p then
            Add( data, [ String(i), functor_data[i] ] );
        elif i > p then
            Add( data, [ String(i - 1), functor_data[i] ] );
        fi;
    od;
    
    data := Concatenation(
                    [ [ "name", name ],
                      [ "category", CategoryOfFunctor( Functor ) ],
                      [ "operation", operation ],
                      [ "number_of_arguments", m - 1 ] ],
                    data );
    
    Fp := CallFuncList( CreateHomalgFunctor, data );
    
    ResetFilterObj( Fp, Genesis );
    SetGenesis( Fp, [ "InsertObjectInMultiFunctor", Functor, p, o ] );
    
    if m > 1 then
        Fp!.ContainerForWeakPointersOnComputedBasicObjects :=
          ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );
        Fp!.ContainerForWeakPointersOnComputedBasicMorphisms :=
          ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );
    fi;
    
    if IsBoundGlobal( operation ) then
        if not IsOperation( ValueGlobal( operation ) ) then
            Error( operation, " is bound but is not an operation\n" );
        fi;
    else
        ## it is only important to declare and almost regardless how
        DeclareOperation( operation, [ IsHomalgObjectOrMorphism ] );
    fi;
    
    InstallFunctor( Fp );
    
    fname := Concatenation( [ "Functor_", name, ShortDescriptionOfCategory( Functor ) ] );
    
    ConvertToStringRep( fname );
    
    if IsBoundGlobal( fname ) then
        Info( InfoWarning, 1, "unable to save the specialized functor under the default name ", fname, " since it is reserved" );
    else
        DeclareGlobalVariable( fname );
        InstallValue( ValueGlobal( fname ), Fp );
    fi;
    
    Fp!.GlobalName := fname;
    
    return Fp;
    
end );

##
InstallMethod( InsertObjectInMultiFunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsInt, IsStructureObjectOrFinitelyPresentedObjectRep, IsString ],
        
  function( Functor, p, o, name )
    
    return InsertObjectInMultiFunctor( Functor, p, o, name, name );
    
end );

##  <#GAPDoc Label="ComposeFunctors">
##  <ManSection>
##    <Oper Arg="F[, p], G[, H]" Name="ComposeFunctors" Label="constructor for functors given two functors"/>
##    <Returns>a &homalg; functor</Returns>
##    <Description>
##      Given two &homalg; (multi-)functors <A>F</A> and <A>G</A> and a string <A>H</A> return the composed functor
##      <C>Functor_</C><A>H</A> <M>:=</M> <A>F</A><M>(...,</M><A>G</A><M>(...),...)</M>, where <A>G</A> is inserted at
##      the <A>p</A>-th position. Of course <A>G</A> must be a functor that can be inserted
##      at this particular position. The string <A>H</A> becomes the name of the returned functor
##      (&see; <Ref Oper="NameOfFunctor"/>). The variable <C>Functor_</C><A>H</A> will automatically be assigned if free,
##      otherwise a warning is issued.
##      <P/>
##      If <A>p</A> is not specified it is assumed <M>1</M>. If the string <A>H</A> is not specified the names
##      of <A>F</A> and <A>G</A> are concatenated in this order (&see; <Ref Oper="NameOfFunctor"/>).
##      <P/>
##      <A>F</A> * <A>G</A> is a shortcut for <C>ComposeFunctors</C>(<A>F</A>,1,<A>G</A>).
##      <P/>
##      The constructor automatically invokes <Ref Oper="InstallFunctor"/> which installs several necessary operations
##      under the name <A>H</A>.
##      <P/>
##      Check this:
##      <Example><![CDATA[
##  gap> Functor_Hom_for_fp_modules * Functor_TensorProduct_for_fp_modules;
##  <The functor HomTensorProduct for f.p. modules and their maps over computable \
##  rings>
##  gap> Functor_HomTensorProduct_for_fp_modules;	## got automatically defined
##  <The functor HomTensorProduct for f.p. modules and their maps over computable \
##  rings>
##  gap> HomTensorProduct;		## got automatically defined
##  <Operation "HomTensorProduct">
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( ComposeFunctors,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsInt, IsHomalgFunctorRep, IsString, IsString ],
        
  function( Functor_post, p, Functor_pre, name, operation )
    local m_post, m_pre, data_post, data_pre, m, data, i, d, property, fname,
          GF;
    
    if p < 1 then
        Error( "the second argument must be a positive integer\n" );
    fi;
    
    if IsBound( Functor_post!.0 ) or IsBound(  Functor_pre!.0 ) then
        Error( "ComposeFunctors does not support functors with a zero-th argument yet\n" );
    fi;
    
    m_post := MultiplicityOfFunctor( Functor_post );
    m_pre := MultiplicityOfFunctor( Functor_pre );
    
    data_post := List( [ 1 .. m_post ], i -> StructuralCopy( Functor_post!.(i) ) );
    data_pre := List( [ 1 .. m_pre ], i -> StructuralCopy( Functor_pre!.(i) ) );
    
    m := m_post + m_pre - 1;
    
    data := [ ];
    
    for i in [ 1 .. m ] do
        if i < p then
            Add( data, [ String(i), data_post[i] ] );
        elif i > p + m_pre - 1 then
            Add( data, [ String(i), data_post[i - m_pre + 1] ] );
        else
            d := [ ];
            if IsCovariantFunctor( Functor_post, p ) = true and
               IsCovariantFunctor( Functor_pre, i - p + 1 ) = true then
                property := "covariant";
            elif IsCovariantFunctor( Functor_post, p ) = true and
              IsCovariantFunctor( Functor_pre, i - p + 1 ) = false then
                property := "contravariant";
            elif IsCovariantFunctor( Functor_post, p ) = false and
              IsCovariantFunctor( Functor_pre, i - p + 1 ) = true then
                property := "contravariant";
            elif IsCovariantFunctor( Functor_post, p ) = false and
              IsCovariantFunctor( Functor_pre, i - p + 1 ) = false then
                property := "covariant";
            fi;
            if IsBound( property ) then
                Add( d, property );
            fi;
            if IsAdditiveFunctor( Functor_post, p ) and
               IsAdditiveFunctor( Functor_pre, i - p + 1 ) then
                Add( d, "additive" );
            fi;
            if IsDistinguishedArgumentOfFunctor( Functor_post, p ) and
               IsDistinguishedArgumentOfFunctor( Functor_pre, i - p + 1 ) then
                Add( d, "distinguished" );
            fi;
            Add( data, [ String(i), [ d, data_pre[i - p + 1][2] ] ] );
        fi;
    od;
    
    data := Concatenation(
                    [ [ "name", name ],
                      [ "category", CategoryOfFunctor( Functor_pre ) ],
                      [ "operation", operation ],
                      [ "number_of_arguments", m ] ],
                    data );
    
    GF := CallFuncList( CreateHomalgFunctor, data );
    
    ResetFilterObj( GF, Genesis );
    SetGenesis( GF, [ "ComposeFunctors", [ Functor_post, Functor_pre ], p ] );
    
    if m > 1 then
        GF!.ContainerForWeakPointersOnComputedBasicObjects :=
          ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );
        GF!.ContainerForWeakPointersOnComputedBasicMorphisms :=
          ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );
    fi;
    
    if IsBoundGlobal( operation ) then
        if not IsOperation( ValueGlobal( operation ) ) then
            Error( operation, " is bound but is not an operation\n" );
        fi;
    else
        ## it is only important to declare and almost regardless how
        DeclareOperation( operation, [ IsHomalgObjectOrMorphism ] );
    fi;
    
    InstallFunctor( GF );
    
    fname := Concatenation( [ "Functor_", name, ShortDescriptionOfCategory( Functor_pre ) ] );
    
    ConvertToStringRep( fname );
    
    if IsBoundGlobal( fname ) then
        Info( InfoWarning, 1, "unable to save the composed functor under the default name ", fname, " since it is reserved" );
    else
        DeclareGlobalVariable( fname );
        InstallValue( ValueGlobal( fname ), GF );
    fi;
    
    GF!.GlobalName := fname;
    
    return GF;
    
end );

##
InstallMethod( ComposeFunctors,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsInt, IsHomalgFunctorRep ],
        
  function( Functor_post, p, Functor_pre )
    local name;
    
    if p = 1 then
        name := Concatenation( NameOfFunctor( Functor_post ), NameOfFunctor( Functor_pre ) );
    else
        name := Concatenation( NameOfFunctor( Functor_post ), String( p ), NameOfFunctor( Functor_pre ) );
    fi;
    
    return ComposeFunctors( Functor_post, p, Functor_pre, name );
    
end );

##
InstallMethod( ComposeFunctors,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsHomalgFunctorRep, IsString, IsString ],
        
  function( Functor_post, Functor_pre, name, operation )
    
    return ComposeFunctors( Functor_post, 1, Functor_pre, name, operation );
    
end );

##
InstallMethod( ComposeFunctors,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsHomalgFunctorRep, IsString ],
        
  function( Functor_post, Functor_pre, name )
    
    return ComposeFunctors( Functor_post, Functor_pre, name, name );
    
end );

##
InstallMethod( ComposeFunctors,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsInt, IsHomalgFunctorRep, IsString ],
        
  function( Functor_post, p, Functor_pre, name )
    
    return ComposeFunctors( Functor_post, p, Functor_pre, name, name );
    
end );

##
InstallMethod( ComposeFunctors,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsHomalgFunctorRep ],
        
  function( Functor_post, Functor_pre )
    
    return ComposeFunctors( Functor_post, 1, Functor_pre );
    
end );

##
InstallMethod( \*,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsHomalgFunctorRep ],
        
  function( Functor_post, Functor_pre )
    
    return ComposeFunctors( Functor_post, Functor_pre );
    
end );

##  <#GAPDoc Label="RightSatelliteOfCofunctor">
##  <ManSection>
##    <Oper Arg="F[, p][, H]" Name="RightSatelliteOfCofunctor" Label="constructor of the right satellite of a contravariant functor"/>
##    <Returns>a &homalg; functor</Returns>
##    <Description>
##      Given a &homalg; (multi-)functor <A>F</A> and a string <A>H</A> return the right satellite of
##      <A>F</A> with respect to its <A>p</A>-th argument. <A>F</A> is assumed contravariant in its <A>p</A>-th argument.
##      The string <A>H</A> becomes the name of the returned functor (&see; <Ref Oper="NameOfFunctor"/>).
##      The variable <C>Functor_</C><A>H</A> will automatically be assigned if free, otherwise a warning is issued.
##      <P/>
##      If <A>p</A> is not specified it is assumed <M>1</M>. If the string <A>H</A> is not specified the
##      letter 'S' is added to the left of the name of <A>F</A> (&see; <Ref Oper="NameOfFunctor"/>).
##      <P/>
##      The constructor automatically invokes <Ref Oper="InstallFunctor"/> which installs several necessary operations
##      under the name <A>H</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( RightSatelliteOfCofunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsPosInt, IsString, IsString ],
        
  function( Functor, p, name, operation )
    local functor_name, functor_operation, _Functor_OnObjects, _Functor_OnMorphisms,
          m, z, data, i, SF, fname;
    
    if IsCovariantFunctor( Functor, p ) <> false then
        Error( "the functor does not seem to be contravariant in its ", p, ". argument\n" );
    fi;
    
    functor_name :=  NameOfFunctor( Functor );
    
    functor_operation := OperationOfFunctor( Functor );
    
    _Functor_OnObjects :=
      function( arg )
        local c, mu, ar, F_mu, sat;
        
        c := arg[1];
        
        if c < 0 then
            Error( "the negative ", c, ". right satellite is not defined\n" );
        fi;
        
        mu := SyzygiesObjectEmb( c, arg[p + 1] );
        
        ar := Concatenation( arg{[ 2 .. p ]}, [ mu ], arg{[ p + 2 .. Length( arg ) ]} );
        
        F_mu := CallFuncList( functor_operation, ar );
        
        sat := Cokernel( F_mu );
        
        SetAsCokernel( sat, F_mu );
        
        return sat;
        
    end;
    
    _Functor_OnMorphisms :=
      function( F_source, F_target, arg_before_pos, phi, arg_behind_pos )
        local arg, c, d, d_c_1, mu, ar, hull_phi, emb_source, emb_target;
        
        arg := Concatenation( arg_before_pos, [ phi ], arg_behind_pos );
        
        c := arg[1];
        
        if c < 0 then
            Error( "the negative ", c, ". right satellite is not defined\n" );
        fi;
        
        if c - 1 > -1 then
            d := Resolution( c - 1, arg[p + 1] );
        else
            d := Resolution( 0, arg[p + 1] );
        fi;
        
        if IsHomalgStaticMorphism( arg[p + 1] ) then
            if c = 0 then
                mu := arg[p + 1];
            else
                d_c_1 := CertainMorphismAsKernelSquare( d, c - 1 );
                mu := Kernel( d_c_1 );
            fi;
        else
            ## the following is not really mu but Source( mu ):
            mu := SyzygiesObject( c, arg[p + 1] );
        fi;
        
        ar := Concatenation( arg{[ 2 .. p ]}, [ mu ], arg{[ p + 2 .. Length( arg ) ]} );
        
        hull_phi := CallFuncList( functor_operation, ar );
        
        emb_source := NaturalGeneralizedEmbedding( F_source );
        emb_target := NaturalGeneralizedEmbedding( F_target );
        
        return CompleteImageSquare( emb_source, hull_phi, emb_target );
        
        ## HasIsIsomorphism( phi ) and IsIsomorphism( phi ), resp.
        ## HasIsMorphism( phi ) and IsMorphism( phi ), and
        ## UpdateObjectsByMorphism( mor )
        ## will be taken care of in FunctorMor
        
    end;
    
    m := MultiplicityOfFunctor( Functor );
    
    if IsBound( Functor!.0 ) then
        if IsList( Functor!.0 ) then
            z := Concatenation( [ IsInt ], Functor!.0 );
        else
            Error( "the zeroth argument of the functor is not a list" );
        fi;
    else
        z := [ IsInt ];
    fi;
    
    data := List( [ 1 .. m ], i -> [ String( i ), StructuralCopy( Functor!.(String( i )) ) ] );
    
    for i in [ 1 .. m ] do
        if IsBound( data[i][2] ) and IsBound( data[i][2][1] ) and IsBound( data[i][2][1][2] ) and
           data[i][2][1][2] in [ "left exact", "right exact", "right adjoint", "left adjoint" ] then
            data[i][2][1][2] := "additive";
            if i = p or functor_name = "Hom" then
                Add( data[i][2][1], "delta-functor", 3 );
                Add( data[i][2][1], "effaceable", 4 );
            fi;
        fi;
    od;
    
    data := Concatenation(
                    [ [ "name", name ],
                      [ "category", CategoryOfFunctor( Functor ) ],
                      [ "operation", operation ],
                      [ "number_of_arguments", m ] ],
                    [ [ "0", z ] ],
                    data,
                    [ [ "OnObjects", _Functor_OnObjects ] ],
                    [ [ "OnMorphisms", _Functor_OnMorphisms ] ] );
    
    SF := CallFuncList( CreateHomalgFunctor, data );
    
    ResetFilterObj( SF, Genesis );
    SetGenesis( SF, [ "RightSatelliteOfCofunctor", Functor, p ] );
    
    if m > 1 then
        SF!.ContainerForWeakPointersOnComputedBasicObjects :=
          ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );
        SF!.ContainerForWeakPointersOnComputedBasicMorphisms :=
          ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );
    fi;
    
    if IsBoundGlobal( operation ) then
        if not IsOperation( ValueGlobal( operation ) ) then
            Error( operation, " is bound but is not an operation\n" );
        fi;
    else
        ## it is only important to declare and almost regardless how
        DeclareOperation( operation, [ IsHomalgObjectOrMorphism ] );
    fi;
    
    InstallFunctor( SF );
    
    fname := Concatenation( [ "Functor_", name, ShortDescriptionOfCategory( Functor ) ] );
    
    ConvertToStringRep( fname );
    
    if IsBoundGlobal( fname ) then
        Info( InfoWarning, 1, "unable to save the right satellite under the default name ", fname, " since it is reserved" );
    else
        DeclareGlobalVariable( fname );
        InstallValue( ValueGlobal( fname ), SF );
    fi;
    
    SF!.GlobalName := fname;
    
    return SF;
    
end );

##
InstallMethod( RightSatelliteOfCofunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsPosInt, IsString ],
        
  function( Functor, p, name )
    
    return RightSatelliteOfCofunctor( Functor, p, name, name );
    
end );

##
InstallMethod( RightSatelliteOfCofunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsPosInt ],
        
  function( Functor, p )
    local name;
    
    name := NameOfFunctor( Functor );
    
    name := Concatenation( "S", name );
    
    return RightSatelliteOfCofunctor( Functor, p, name );
    
end );

##
InstallMethod( RightSatelliteOfCofunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsString, IsString ],
        
  function( Functor, name, operation )
    
    return RightSatelliteOfCofunctor( Functor, 1, name, operation );
    
end );

##
InstallMethod( RightSatelliteOfCofunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsString ],
        
  function( Functor, name )
    
    return RightSatelliteOfCofunctor( Functor, 1, name );
    
end );

##
InstallMethod( RightSatelliteOfCofunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep ],
        
  function( Functor )
    
    return RightSatelliteOfCofunctor( Functor, 1 );
    
end );

##  <#GAPDoc Label="LeftSatelliteOfFunctor">
##  <ManSection>
##    <Oper Arg="F[, p][, H]" Name="LeftSatelliteOfFunctor" Label="constructor of the left satellite of a covariant functor"/>
##    <Returns>a &homalg; functor</Returns>
##    <Description>
##      Given a &homalg; (multi-)functor <A>F</A> and a string <A>H</A> return the left satellite of
##      <A>F</A> with respect to its <A>p</A>-th argument. <A>F</A> is assumed covariant in its <A>p</A>-th argument.
##      The string <A>H</A> becomes the name of the returned functor (&see; <Ref Oper="NameOfFunctor"/>).
##      The variable <C>Functor_</C><A>H</A> will automatically be assigned if free, otherwise a warning is issued.
##      <P/>
##      If <A>p</A> is not specified it is assumed <M>1</M>. If the string <A>H</A> is not specified
##      the string <Q>S_</Q> is added to the left of the name of <A>F</A> (&see; <Ref Oper="NameOfFunctor"/>).
##      <P/>
##      The constructor automatically invokes <Ref Oper="InstallFunctor"/> which installs several necessary operations
##      under the name <A>H</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( LeftSatelliteOfFunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsPosInt, IsString, IsString ],
        
  function( Functor, p, name, operation )
    local functor_name, functor_operation, _Functor_OnObjects, _Functor_OnMorphisms,
          m, z, data, i, SF, fname;
    
    if IsCovariantFunctor( Functor, p ) <> true then
        Error( "the functor does not seem to be covariant in its ", p, ". argument\n" );
    fi;
    
    functor_name :=  NameOfFunctor( Functor );
    
    functor_operation := OperationOfFunctor( Functor );
    
    _Functor_OnObjects :=
      function( arg )
        local functor_operation, c, mu, ar, F_mu, sat;
        
        functor_operation := OperationOfFunctor( Functor );
        
        c := arg[1];
        
        if c < 0 then
            Error( "the negative ", c, ". left satellite is not defined\n" );
        fi;
        
        mu := SyzygiesObjectEmb( c, arg[p + 1] );
        
        ar := Concatenation( arg{[ 2 .. p ]}, [ mu ], arg{[ p + 2 .. Length( arg ) ]} );
        
        F_mu := CallFuncList( functor_operation, ar );
        
        sat := Kernel( F_mu );
        
        SetAsKernel( sat, F_mu );
        
        return sat;
        
    end;
    
    _Functor_OnMorphisms :=
      function( F_source, F_target, arg_before_pos, phi, arg_behind_pos )
        local arg, c, d, d_c_1, mu, ar, hull_phi, emb_source, emb_target;
        
        arg := Concatenation( arg_before_pos, [ phi ], arg_behind_pos );
        
        c := arg[1];
        
        if c < 0 then
            Error( "the negative ", c, ". left satellite is not defined\n" );
        fi;
        
        if c - 1 > -1 then
            d := Resolution( c - 1, arg[p + 1] );
        else
            d := Resolution( 0, arg[p + 1] );
        fi;
        
        if IsHomalgStaticMorphism( arg[p + 1] ) then
            if c = 0 then
                mu := arg[p + 1];
            else
                d_c_1 := CertainMorphismAsKernelSquare( d, c - 1 );
                mu := Kernel( d_c_1 );
            fi;
        else
            ## the following is not really mu but Source( mu ):
            mu := SyzygiesObject( c, arg[p + 1] );
        fi;
        
        ar := Concatenation( arg{[ 2 .. p ]}, [ mu ], arg{[ p + 2 .. Length( arg ) ]} );
        
        hull_phi := CallFuncList( functor_operation, ar );
        
        emb_source := NaturalGeneralizedEmbedding( F_source );
        emb_target := NaturalGeneralizedEmbedding( F_target );
        
        return CompleteImageSquare( emb_source, hull_phi, emb_target );
        
        ## HasIsIsomorphism( phi ) and IsIsomorphism( phi ), resp.
        ## HasIsMorphism( phi ) and IsMorphism( phi ), and
        ## UpdateObjectsByMorphism( mor )
        ## will be taken care of in FunctorMor
        
    end;
    
    m := MultiplicityOfFunctor( Functor );
    
    if IsBound( Functor!.0 ) then
        if IsList( Functor!.0 ) then
            z := Concatenation( [ IsInt ], Functor!.0 );
        else
            Error( "the zeroth argument of the functor is not a list" );
        fi;
    else
        z := [ IsInt ];
    fi;
    
    data := List( [ 1 .. m ], i -> [ String( i ), StructuralCopy( Functor!.(String( i )) ) ] );
    
    for i in [ 1 .. m ] do
        if IsBound( data[i][2] ) and IsBound( data[i][2][1] ) and IsBound( data[i][2][1][2] ) and
           data[i][2][1][2] in [ "left exact", "right exact", "right adjoint", "left adjoint" ] then
            data[i][2][1][2] := "additive";
            if i = p or functor_name = "TensorProduct" then
                Add( data[i][2][1], "delta-functor", 3 );
                Add( data[i][2][1], "coeffaceable", 4 );
            fi;
        fi;
    od;
    
    data := Concatenation(
                    [ [ "name", name ],
                      [ "category", CategoryOfFunctor( Functor ) ],
                      [ "operation", operation ],
                      [ "number_of_arguments", m ] ],
                    [ [ "0", z ] ],
                    data,
                    [ [ "OnObjects", _Functor_OnObjects ] ],
                    [ [ "OnMorphisms", _Functor_OnMorphisms ] ] );
    
    SF := CallFuncList( CreateHomalgFunctor, data );
    
    ResetFilterObj( SF, Genesis );
    SetGenesis( SF, [ "LeftSatelliteOfFunctor", Functor, p ] );
    
    if m > 1 then
        SF!.ContainerForWeakPointersOnComputedBasicObjects :=
          ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );
        SF!.ContainerForWeakPointersOnComputedBasicMorphisms :=
          ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );
    fi;
    
    if IsBoundGlobal( operation ) then
        if not IsOperation( ValueGlobal( operation ) ) then
            Error( operation, " is bound but is not an operation\n" );
        fi;
    else
        ## it is only important to declare and almost regardless how
        DeclareOperation( operation, [ IsHomalgObjectOrMorphism ] );
    fi;
    
    InstallFunctor( SF );
    
    fname := Concatenation( [ "Functor_", name, ShortDescriptionOfCategory( Functor ) ] );
    
    ConvertToStringRep( fname );
    
    if IsBoundGlobal( fname ) then
        Info( InfoWarning, 1, "unable to save the left satellite under the default name ", fname, " since it is reserved" );
    else
        DeclareGlobalVariable( fname );
        InstallValue( ValueGlobal( fname ), SF );
    fi;
    
    SF!.GlobalName := fname;
    
    return SF;
    
end );

##
InstallMethod( LeftSatelliteOfFunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsPosInt, IsString ],
        
  function( Functor, p, name )
    
    return LeftSatelliteOfFunctor( Functor, p, name, name );
    
end );

##
InstallMethod( LeftSatelliteOfFunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsPosInt ],
        
  function( Functor, p )
    local name;
    
    name := NameOfFunctor( Functor );
    
    name := Concatenation( "S_", name );
    
    return LeftSatelliteOfFunctor( Functor, p, name );
    
end );

##
InstallMethod( LeftSatelliteOfFunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsString, IsString ],
        
  function( Functor, name, operation )
    
    return LeftSatelliteOfFunctor( Functor, 1, name, operation );
    
end );

##
InstallMethod( LeftSatelliteOfFunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsString ],
        
  function( Functor, name )
    
    return LeftSatelliteOfFunctor( Functor, 1, name );
    
end );

##
InstallMethod( LeftSatelliteOfFunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep ],
        
  function( Functor )
    
    return LeftSatelliteOfFunctor( Functor, 1 );
    
end );

##  <#GAPDoc Label="RightDerivedCofunctor">
##  <ManSection>
##    <Oper Arg="F[, p][, H]" Name="RightDerivedCofunctor" Label="constructor of the right derived functor of a contravariant functor"/>
##    <Returns>a &homalg; functor</Returns>
##    <Description>
##      Given a &homalg; (multi-)functor <A>F</A> and a string <A>H</A> return the right derived functor of
##      <A>F</A> with respect to its <A>p</A>-th argument. <A>F</A> is assumed contravariant in its <A>p</A>-th argument.
##      The string <A>H</A> becomes the name of the returned functor (&see; <Ref Oper="NameOfFunctor"/>).
##      The variable <C>Functor_</C><A>H</A> will automatically be assigned if free, otherwise a warning is issued.
##      <P/>
##      If <A>p</A> is not specified it is assumed <M>1</M>. If the string <A>H</A> is not specified
##      the letter 'R' is added to the left of the name of <A>F</A> (&see; <Ref Oper="NameOfFunctor"/>).
##      <P/>
##      The constructor automatically invokes <Ref Oper="InstallFunctor"/> and <Ref Oper="InstallDeltaFunctor"/>
##      which install several necessary operations under the name <A>H</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( RightDerivedCofunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsPosInt, IsString, IsString ],
        
  function( Functor, p, name, operation )
    local functor_name, functor_operation, _Functor_OnObjects, _Functor_OnMorphisms,
          m, z, data, i, RF, fname;
    
    if IsCovariantFunctor( Functor, p ) <> false then
        Error( "the functor does not seem to be contravariant in its ", p, ". argument\n" );
    fi;
    
    functor_name :=  NameOfFunctor( Functor );
    
    functor_operation := OperationOfFunctor( Functor );
    
    _Functor_OnObjects :=
      function( arg )
        local c, dd, ar, F_dd, der;
        
        c := arg[1];
        
        if c < 0 then
            Error( "the negative ", c, ". right derived cofunctor is not defined\n" );
        fi;
        
        dd := SubResolution( c, arg[p + 1] );
        
        ar := Concatenation( arg{[ 2 .. p ]}, [ dd ], arg{[ p + 2 .. Length( arg ) ]} );
        
        F_dd := CallFuncList( functor_operation, ar );
        
        der := DefectOfHoms( F_dd );
        
        return der;
        
    end;
    
    _Functor_OnMorphisms :=
      function( F_source, F_target, arg_before_pos, phi, arg_behind_pos )
        local arg, c, d, d_c, ar, hull_phi, emb_source, emb_target;
        
        arg := Concatenation( arg_before_pos, [ phi ], arg_behind_pos );
        
        c := arg[1];
        
        if c < 0 then
            Error( "the negative ", c, ". right derived cofunctor is not defined\n" );
        fi;
        
        d := Resolution( c, arg[p + 1] );
        
        if IsHomalgStaticMorphism( arg[p + 1] ) then
            d_c := CertainMorphism( d, c );
        else
            d_c := CertainObject( d, c );
        fi;
        
        ar := Concatenation( arg{[ 2 .. p ]}, [ d_c ], arg{[ p + 2 .. Length( arg ) ]} );
        
        hull_phi := CallFuncList( functor_operation, ar );
        
        emb_source := NaturalGeneralizedEmbedding( F_source );
        emb_target := NaturalGeneralizedEmbedding( F_target );
        
        return CompleteImageSquare( emb_source, hull_phi, emb_target );
        
        ## HasIsIsomorphism( phi ) and IsIsomorphism( phi ), resp.
        ## HasIsMorphism( phi ) and IsMorphism( phi ), and
        ## UpdateObjectsByMorphism( mor )
        ## will be taken care of in FunctorMor
        
    end;
    
    m := MultiplicityOfFunctor( Functor );
    
    if IsBound( Functor!.0 ) then
        if IsList( Functor!.0 ) then
            z := Concatenation( [ IsInt ], Functor!.0 );
        else
            Error( "the zeroth argument of the functor is not a list" );
        fi;
    else
        z := [ IsInt ];
    fi;
    
    data := List( [ 1 .. m ], i -> [ String( i ), StructuralCopy( Functor!.(String( i )) ) ] );
    
    for i in [ 1 .. m ] do
        if IsBound( data[i][2] ) and IsBound( data[i][2][1] ) and IsBound( data[i][2][1][2] ) and
           data[i][2][1][2] in [ "left exact", "right exact", "right adjoint", "left adjoint" ] then
            data[i][2][1][2] := "additive";
            if i = p or functor_name = "Hom" then
                Add( data[i][2][1], "delta-functor", 3 );
                Add( data[i][2][1], "effaceable", 4 );
            fi;
        fi;
    od;
    
    data := Concatenation(
                    [ [ "name", name ],
                      [ "category", CategoryOfFunctor( Functor ) ],
                      [ "operation", operation ],
                      [ "number_of_arguments", m ] ],
                    [ [ "0", z ] ],
                    data,
                    [ [ "OnObjects", _Functor_OnObjects ] ],
                    [ [ "OnMorphisms", _Functor_OnMorphisms ] ] );
    
    RF := CallFuncList( CreateHomalgFunctor, data );
    
    ResetFilterObj( RF, Genesis );
    SetGenesis( RF, [ "RightDerivedCofunctor", Functor, p ] );
    
    if m > 1 then
        RF!.ContainerForWeakPointersOnComputedBasicObjects :=
          ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );
        RF!.ContainerForWeakPointersOnComputedBasicMorphisms :=
          ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );
    fi;
    
    if IsBoundGlobal( operation ) then
        if not IsOperation( ValueGlobal( operation ) ) then
            Error( operation, " is bound but is not an operation\n" );
        fi;
    else
        ## it is only important to declare and almost regardless how
        DeclareOperation( operation, [ IsHomalgObjectOrMorphism ] );
    fi;
    
    InstallFunctor( RF );
    
    InstallDeltaFunctor( RF );
    
    fname := Concatenation( [ "Functor_", name, ShortDescriptionOfCategory( Functor ) ] );
    
    ConvertToStringRep( fname );
    
    if IsBoundGlobal( fname ) then
        Info( InfoWarning, 1, "unable to save the right derived cofunctor under the default name ", fname, " since it is reserved" );
    else
        DeclareGlobalVariable( fname );
        InstallValue( ValueGlobal( fname ), RF );
    fi;
    
    RF!.GlobalName := fname;
    
    return RF;
    
end );

##
InstallMethod( RightDerivedCofunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsPosInt, IsString ],
        
  function( Functor, p, name )
    
    return RightDerivedCofunctor( Functor, p, name, name );
    
end );

##
InstallMethod( RightDerivedCofunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsPosInt ],
        
  function( Functor, p )
    local name;
    
    name := NameOfFunctor( Functor );
    
    name := Concatenation( "R", name );
    
    return RightDerivedCofunctor( Functor, p, name );
    
end );

##
InstallMethod( RightDerivedCofunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsString, IsString ],
        
  function( Functor, name, operation )
    
    return RightDerivedCofunctor( Functor, 1, name, operation );
    
end );

##
InstallMethod( RightDerivedCofunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsString ],
        
  function( Functor, name )
    
    return RightDerivedCofunctor( Functor, 1, name );
    
end );

##
InstallMethod( RightDerivedCofunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep ],
        
  function( Functor )
    
    return RightDerivedCofunctor( Functor, 1 );
    
end );

##  <#GAPDoc Label="LeftDerivedFunctor">
##  <ManSection>
##    <Oper Arg="F[, p][, H]" Name="LeftDerivedFunctor" Label="constructor of the left derived functor of a covariant functor"/>
##    <Returns>a &homalg; functor</Returns>
##    <Description>
##      Given a &homalg; (multi-)functor <A>F</A> and a string <A>H</A> return the left derived functor of
##      <A>F</A> with respect to its <A>p</A>-th argument. <A>F</A> is assumed covariant in its <A>p</A>-th argument.
##      The string <A>H</A> becomes the name of the returned functor (&see; <Ref Oper="NameOfFunctor"/>).
##      The variable <C>Functor_</C><A>H</A> will automatically be assigned if free, otherwise a warning is issued.
##      <P/>
##      If <A>p</A> is not specified it is assumed <M>1</M>. If the string <A>H</A> is not specified
##      the letter <Q>S_</Q> is added to the left of the name of <A>F</A> (&see; <Ref Oper="NameOfFunctor"/>).
##      <P/>
##      The constructor automatically invokes <Ref Oper="InstallFunctor"/> and <Ref Oper="InstallDeltaFunctor"/>
##      which install several necessary operations under the name <A>H</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( LeftDerivedFunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsPosInt, IsString, IsString ],
        
  function( Functor, p, name, operation )
    local functor_name, functor_operation, _Functor_OnObjects, _Functor_OnMorphisms,
          m, z, data, i, LF, fname;
    
    if IsCovariantFunctor( Functor, p ) <> true then
        Error( "the functor does not seem to be covariant in its ", p, ". argument\n" );
    fi;
    
    functor_name :=  NameOfFunctor( Functor );
    
    functor_operation := OperationOfFunctor( Functor );
    
    _Functor_OnObjects :=
      function( arg )
        local c, dd, ar, F_dd, der;
        
        c := arg[1];
        
        if c < 0 then
            Error( "the negative ", c, ". left derived functor is not defined\n" );
        fi;
        
        dd := SubResolution( c, arg[p + 1] );
        
        ar := Concatenation( arg{[ 2 .. p ]}, [ dd ], arg{[ p + 2 .. Length( arg ) ]} );
        
        F_dd := CallFuncList( functor_operation, ar );
        
        der := DefectOfHoms( F_dd );
        
        return der;
        
    end;
    
    _Functor_OnMorphisms :=
      function( F_source, F_target, arg_before_pos, phi, arg_behind_pos )
        local arg, c, d, d_c, ar, hull_phi, emb_source, emb_target;
        
        arg := Concatenation( arg_before_pos, [ phi ], arg_behind_pos );
        
        c := arg[1];
        
        if c < 0 then
            Error( "the negative ", c, ". left derived functor is not defined\n" );
        fi;
        
        d := Resolution( c, arg[p + 1] );
        
        if IsHomalgStaticMorphism( arg[p + 1] ) then
            d_c := CertainMorphism( d, c );
        else
            d_c := CertainObject( d, c );
        fi;
        
        ar := Concatenation( arg{[ 2 .. p ]}, [ d_c ], arg{[ p + 2 .. Length( arg ) ]} );
        
        hull_phi := CallFuncList( functor_operation, ar );
        
        emb_source := NaturalGeneralizedEmbedding( F_source );
        emb_target := NaturalGeneralizedEmbedding( F_target );
        
        return CompleteImageSquare( emb_source, hull_phi, emb_target );
        
        ## HasIsIsomorphism( phi ) and IsIsomorphism( phi ), resp.
        ## HasIsMorphism( phi ) and IsMorphism( phi ), and
        ## UpdateObjectsByMorphism( mor )
        ## will be taken care of in FunctorMor
        
    end;
    
    m := MultiplicityOfFunctor( Functor );
    
    if IsBound( Functor!.0 ) then
        if IsList( Functor!.0 ) then
            z := Concatenation( [ IsInt ], Functor!.0 );
        else
            Error( "the zeroth argument of the functor is not a list" );
        fi;
    else
        z := [ IsInt ];
    fi;
    
    data := List( [ 1 .. m ], i -> [ String( i ), StructuralCopy( Functor!.(String( i )) ) ] );
    
    for i in [ 1 .. m ] do
        if IsBound( data[i][2] ) and IsBound( data[i][2][1] ) and IsBound( data[i][2][1][2] ) and
           data[i][2][1][2] in [ "left exact", "right exact", "right adjoint", "left adjoint" ] then
            data[i][2][1][2] := "additive";
            if i = p or functor_name = "Hom" then
                Add( data[i][2][1], "delta-functor", 3 );
                Add( data[i][2][1], "coeffaceable", 4 );
            fi;
        fi;
    od;
    
    data := Concatenation(
                    [ [ "name", name ],
                      [ "category", CategoryOfFunctor( Functor ) ],
                      [ "operation", operation ],
                      [ "number_of_arguments", m ] ],
                    [ [ "0", z ] ],
                    data,
                    [ [ "OnObjects", _Functor_OnObjects ] ],
                    [ [ "OnMorphisms", _Functor_OnMorphisms ] ] );
    
    LF := CallFuncList( CreateHomalgFunctor, data );
    
    ResetFilterObj( LF, Genesis );
    SetGenesis( LF, [ "LeftDerivedFunctor", Functor, p ] );
    
    if m > 1 then
        LF!.ContainerForWeakPointersOnComputedBasicObjects :=
          ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );
        LF!.ContainerForWeakPointersOnComputedBasicMorphisms :=
          ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );
    fi;
    
    if IsBoundGlobal( operation ) then
        if not IsOperation( ValueGlobal( operation ) ) then
            Error( operation, " is bound but is not an operation\n" );
        fi;
    else
        ## it is only important to declare and almost regardless how
        DeclareOperation( operation, [ IsHomalgObjectOrMorphism ] );
    fi;
    
    InstallFunctor( LF );
    
    InstallDeltaFunctor( LF );
    
    fname := Concatenation( [ "Functor_", name, ShortDescriptionOfCategory( Functor ) ] );
    
    ConvertToStringRep( fname );
    
    if IsBoundGlobal( fname ) then
        Info( InfoWarning, 1, "unable to save the left derived functor under the default name ", fname, " since it is reserved" );
    else
        DeclareGlobalVariable( fname );
        InstallValue( ValueGlobal( fname ), LF );
    fi;
    
    LF!.GlobalName := fname;
    
    return LF;
    
end );

##
InstallMethod( LeftDerivedFunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsPosInt, IsString ],
        
  function( Functor, p, name )
    
    return LeftDerivedFunctor( Functor, p, name, name );
    
end );

##
InstallMethod( LeftDerivedFunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsPosInt ],
        
  function( Functor, p )
    local name;
    
    name := NameOfFunctor( Functor );
    
    name := Concatenation( "L", name );
    
    return LeftDerivedFunctor( Functor, p, name );
    
end );

##
InstallMethod( LeftDerivedFunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsString, IsString ],
        
  function( Functor, name, operation )
    
    return LeftDerivedFunctor( Functor, 1, name, operation );
    
end );

##
InstallMethod( LeftDerivedFunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsString ],
        
  function( Functor, name )
    
    return LeftDerivedFunctor( Functor, 1, name );
    
end );

##
InstallMethod( LeftDerivedFunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep ],
        
  function( Functor )
    
    return LeftDerivedFunctor( Functor, 1 );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for homalg functors",
        [ IsHomalgFunctorRep ],
        
  function( o )
    
    Print( "<The functor ", NameOfFunctor( o ), " for ", DescriptionOfCategory( o ), ">" );
    
end );

##
InstallMethod( Display,
        "for homalg functors",
        [ IsHomalgFunctorRep ],
        
  function( o )
    
    Print( NameOfFunctor( o ), "\n" );
    
end );

##
InstallMethod( ViewObj,
        "for containers of weak pointers on the computed values of a functor",
        [ IsContainerForWeakPointersOnComputedValuesOfFunctorRep ],
        
  function( o )
    local a, e;
    
    UpdateContainerOfWeakPointers( o );
    
    a := Length( o!.active );
    
    if not IsBound( o!.Functor ) and a > 0 then
        e := ElmWPObj( o!.weak_pointers, o!.active[1] );
        if e <> fail then
            if IsList( e ) and Length( e ) > 0 then
                e := e[1];
                if IsRecord( e ) and IsBound( e.Functor ) then
                    o!.Functor := e.Functor;
                fi;
            fi;
        fi;
    fi;
    
    Print( "<A container for weak pointers on computed values of " );
    
    if IsBound( o!.Functor ) then
        ViewObj( o!.Functor );
    else
        Print( "a functor" );
    fi;
    
    Print( ": active = ", a, ", deleted = ", o!.counter - a, ", counter = ", o!.counter, ", accessed = ", o!.accessed, ", cache_misses = ", o!.cache_misses, ", cache_hits = ", o!.cache_hits, ">" );
    
end );
