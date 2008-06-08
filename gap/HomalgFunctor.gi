#############################################################################
##
##  HomalgFunctor.gi            homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for functors.
##
#############################################################################

####################################
#
# representations:
#
####################################

# a new representation for the GAP-category IsHomalgFunctor:
DeclareRepresentation( "IsHomalgFunctorRep",
        IsHomalgFunctor,
        [ ] );

# a new subrepresentation of the representation IsContainerForWeakPointersRep:
DeclareRepresentation( "IsContainerForWeakPointersOnComputedValuesOfFunctorRep",
        IsContainerForWeakPointersRep,
        [ "weak_pointers", "counter", "deleted" ] );

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

# a new family:
BindGlobal( "TheFamilyOfContainersForWeakPointersOnComputedValuesOfFunctor",
        NewFamily( "TheFamilyOfContainersForWeakPointersOnComputedValuesOfFunctor" ) );

# a new type:
BindGlobal( "TheTypeContainerForWeakPointersOnComputedValuesOfFunctor",
        NewType( TheFamilyOfContainersForWeakPointersOnComputedValuesOfFunctor,
                IsContainerForWeakPointersOnComputedValuesOfFunctorRep ) );

####################################
#
# global values:
#
####################################

HOMALG.FunctorOn :=
  [ IsHomalgRingOrFinitelyPresentedObjectRep,
    IsMapOfFinitelyGeneratedModulesRep,
    [ IsComplexOfFinitelyPresentedObjectsRep, IsCocomplexOfFinitelyPresentedObjectsRep ],
    [ IsChainMapOfFinitelyPresentedObjectsRep, IsCochainMapOfFinitelyPresentedObjectsRep ] ];
  
####################################
#
# methods for operations:
#
####################################

##
InstallMethod( NameOfFunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep ],
        
  function( Functor )
    local functor_name;
    
    if IsBound( Functor!.name ) then
        functor_name := Functor!.name;
        ## for this to work you need to declare one instance of the funtor,
        ## although all methods will be installed using InstallOtherMethod!
        if not IsOperation( ValueGlobal( functor_name ) ) and not IsFunction( ValueGlobal( functor_name ) ) then
            Error( "the functor ", functor_name, " neither points to an operation nor a function\n" );
        fi;
    else
        Error( "the provided functor is nameless\n" );
    fi;
    
    return functor_name;
    
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
        [ IsHomalgFunctorRep, IsPosInt ],
        
  function( Functor, pos )
    
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
InstallMethod( IsAdditiveFunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsPosInt ],
        
  function( Functor, pos )
    local prop;
    
    if IsBound( Functor!.(pos) ) and Length( Functor!.( pos )[1] ) > 1 then
        prop := Functor!.( pos )[1][2];
        if prop in [ "additive", "left exact", "right exact", "exact" ] then
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
InstallMethod( FunctorObj,
        "for homalg morphisms",
        [ IsHomalgFunctorRep, IsList ],
        
  function( Functor, arguments_of_functor )
    local container, weak_pointers, a, deleted, functor_name,
          arg_all, p, i, arg_old, l, obj;
    
    if IsBound( Functor!.ContainerForWeakPointersOnComputedModules ) then
        
        container := Functor!.ContainerForWeakPointersOnComputedModules;
        
        weak_pointers := container!.weak_pointers;
        
        a := container!.counter;
        
        deleted := Filtered( [ 1 .. a ], i -> not IsBoundElmWPObj( weak_pointers, i ) );
        
        container!.deleted := deleted;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    functor_name := NameOfFunctor( Functor );
    
    if IsBound( container ) then
        if IsBound( Functor!.0 ) then
            p := 1;
        else
            p := 0;
        fi;
        l := Length( arguments_of_functor );
        arg_all :=
          [ arguments_of_functor,
            List( arguments_of_functor{[ 1 + p .. l ]}, PositionOfTheDefaultSetOfRelations ) ];
        for i in Difference( [ 1 .. a ], deleted ) do
            obj := ElmWPObj( weak_pointers, i );
            if obj <> fail then
                arg_old := Genesis( obj ){[ 2 .. 3 ]};
                if l = Length( arg_old[1] ) then
                    if ForAll( [ 1 .. l ], j -> IsIdenticalObj( arg_old[1][j], arg_all[1][j] ) ) and
                       ForAll( [ 1 .. l - p ], j -> arg_old[2][j] = arg_all[2][j] ) then
                        return obj;
                    fi;
                fi;
            fi;
        od;
    fi;
    
    obj := CallFuncList( Functor!.OnObjects, arguments_of_functor );
    
    #=====# end of the core procedure #=====#
    
    if IsBound( container ) then
        p := PositionOfTheDefaultSetOfRelations( obj );
        
        SetGenesis( obj, Concatenation( [ Functor ], arg_all, [ p ] ) );
        
        a := a + 1;
        
        container!.counter := a;
        
        SetElmWPObj( weak_pointers, a, obj );
    fi;
    
    return obj;
    
end );

##
InstallMethod( FunctorMap,
        "for homalg morphisms",
        [ IsHomalgFunctorRep, IsMapOfFinitelyGeneratedModulesRep, IsList ],
        
  function( Functor, phi, fixed_arguments_of_multi_functor )
    local container, weak_pointers, a, deleted, functor_name,
          number_of_arguments, pos0, arg_positions, S, T, pos,
          arg_before_pos, arg_behind_pos, arg_all, l, i, phi_rest_mor, arg_old,
          arg_source, arg_target, F_source, F_target, arg_phi, hull_phi,
          emb_source, emb_target, mor;
    
    if not fixed_arguments_of_multi_functor = [ ] and
       not ( ForAll( fixed_arguments_of_multi_functor, a -> IsList( a ) and Length( a ) = 2 and IsPosInt( a[1] ) ) ) then
        Error( "the last argument has a wrong syntax\n" );
    fi;
    
    if IsBound( Functor!.ContainerForWeakPointersOnComputedMorphisms ) then
        
        container := Functor!.ContainerForWeakPointersOnComputedMorphisms;
        
        weak_pointers := container!.weak_pointers;
        
        a := container!.counter;
        
        deleted := Filtered( [ 1 .. a ], i -> not IsBoundElmWPObj( weak_pointers, i ) );
        
        container!.deleted := deleted;
        
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
    
    if IsBound( container ) then
        arg_all := Concatenation( arg_before_pos, [ phi ], arg_behind_pos );
        for i in Difference( [ 1 .. a ], deleted ) do
            phi_rest_mor := ElmWPObj( weak_pointers, i );
            if IsList( phi_rest_mor ) and Length( phi_rest_mor ) = 2 then
                arg_old := phi_rest_mor[1];
                l := Length( arg_old );
                if l = Length( arg_all ) then
                    if ForAll( [ 1 .. l ], j -> IsIdenticalObj( arg_old[j], arg_all[j] ) ) then
                        return phi_rest_mor[2];
                    fi;
                fi;
            fi;
        od;
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
    
    F_source := CallFuncList( ValueGlobal( functor_name ), arg_source );
    F_target := CallFuncList( ValueGlobal( functor_name ), arg_target );
    
    emb_source := F_source!.NaturalEmbedding;
    emb_target := F_target!.NaturalEmbedding;
        
    if IsBound( Functor!.OnMorphisms ) then
        arg_phi := Concatenation( arg_before_pos, [ phi ], arg_behind_pos );
        hull_phi := CallFuncList( Functor!.OnMorphisms, arg_phi );
        
        if IsHomalgMatrix( hull_phi ) then
            hull_phi :=
              HomalgMap( hull_phi, Range( emb_source ), Range( emb_target ) );
        fi;
    else
        hull_phi := phi;
    fi;
    
    mor := CompleteImageSquare( emb_source, hull_phi, emb_target );
    
    #=====# end of the core procedure #=====#
    
    if IsBound( container ) then
        a := a + 1;
        
        container!.counter := a;
        
        SetElmWPObj( weak_pointers, a, [ arg_all, mor ] );
    fi;
    
    return mor;
    
end );

##
InstallMethod( FunctorMap,
        "for homalg morphisms",
        [ IsHomalgFunctorRep, IsMapOfFinitelyGeneratedModulesRep ],
        
  function( Functor, phi )
    
    return FunctorMap( Functor, phi, [ ] );
    
end );

##
InstallMethod( InstallFunctorOnObjects,
        "for homalg functors",
        [ IsHomalgFunctorRep ],
        
  function( Functor )
    local functor_name, number_of_arguments, natural_transformation,
          filter_obj, filter0, filter1_obj, filter2_obj;
    
    functor_name := ValueGlobal( NameOfFunctor( Functor ) );
        
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
                
                InstallOtherMethod( functor_name,
                        "for homalg modules",
                        [ filter0, filter_obj ],
                  function( c, o )
                    local obj;
                    
                    if IsHomalgRing( o ) then
                        ## I personally prefer the row convention and hence left modules:
                        obj := AsLeftModule( o );
                    else
                        obj := o;
                    fi;
                    
                    return FunctorObj( Functor, [ c, obj ] );
                    
                end );
                
            else
                
                if IsBound( Functor!.natural_transformation ) then
                    
                    natural_transformation := ValueGlobal( Functor!.natural_transformation );
                    
                    InstallOtherMethod( natural_transformation,
                            "for homalg modules",
                            [ filter_obj ],
                      function( o )
                        
                        functor_name( o );			## this sets the attribute named "natural_transformation"
                        
                        return natural_transformation( o );	## not an infinite loop because of the side effect of the above line
                        
                    end );
                    
                fi;
                
                InstallOtherMethod( functor_name,
                        "for homalg modules",
                        [ filter_obj ],
                  function( o )
                    local obj;
                    
                    if IsHomalgRing( o ) then
                        ## I personally prefer the row convention and hence left modules:
                        obj := AsLeftModule( o );
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
                
                if Length( Functor!.1[1] ) > 1 and Functor!.1[1][Length( Functor!.1[1] )] = "distinguished" then
                    
                    InstallOtherMethod( functor_name,
                            "for homalg modules",
                            [ filter0, filter1_obj ],
                      function( c, o )
                        local R;
                        
                        if IsHomalgRing( o ) then
                            R := o;
                        else
                            R := HomalgRing( o );
                        fi;
                        
                        return functor_name( c, o, R );
                        
                    end );
                    
                fi;
                
                InstallOtherMethod( functor_name,
                        "for homalg modules",
                        [ filter0, filter1_obj, filter2_obj ],
                  function( c, o1, o2 )
                    local obj1, obj2;
                    
                    if IsHomalgModule( o1 ) and IsHomalgModule( o2 ) then	## the most probable case
                        obj1 := o1;
                        obj2 := o2;
                    elif IsHomalgModule( o1 ) and IsHomalgRing( o2 ) then
                        obj1 := o1;
                        
                        if IsHomalgLeftObjectOrMorphismOfLeftObjects( o1 ) then
                            obj2 := AsLeftModule( o2 );
                        else
                            obj2 := AsRightModule( o2 );
                        fi;
                    elif IsHomalgRing( o1 ) and IsHomalgModule( o2 ) then
                        obj2 := o2;
                        
                        if IsHomalgLeftObjectOrMorphismOfLeftObjects( o2 ) then
                            obj1 := AsLeftModule( o1 );
                        else
                            obj1 := AsRightModule( o1 );
                        fi;
                    elif IsHomalgRing( o1 ) and IsHomalgRing( o2 ) then
                        if not IsIdenticalObj( o1, o2 ) then
                            Error( "the two rings are not identical\n" );
                        fi;
                        
                        ## I personally prefer the row convention and hence left modules:
                        obj1 := AsLeftModule( o1 );
                        obj2 := obj1;
                    else
                        ## the default:
                        obj1 := o1;
                        obj2 := o2;
                    fi;
                    
                    return FunctorObj( Functor, [ c, obj1, obj2 ] );
                    
                end );
                
            else
                
                if Length( Functor!.1[1] ) > 1 and Functor!.1[1][Length( Functor!.1[1] )] = "distinguished" then
                    
                    InstallOtherMethod( functor_name,
                            "for homalg modules",
                            [ filter1_obj ],
                      function( o )
                        local R;
                        
                        if IsHomalgRing( o ) then
                            R := o;
                        else
                            R := HomalgRing( o );
                        fi;
                        
                        return functor_name( o, R );
                        
                    end );
                    
                fi;
                
                InstallOtherMethod( functor_name,
                        "for homalg modules",
                        [ filter1_obj, filter2_obj ],
                  function( o1, o2 )
                    local obj1, obj2;
                    
                    if IsHomalgModule( o1 ) and IsHomalgModule( o2 ) then	## the most probable case
                        obj1 := o1;
                        obj2 := o2;
                    elif IsHomalgModule( o1 ) and IsHomalgRing( o2 ) then
                        obj1 := o1;
                        
                        if IsHomalgLeftObjectOrMorphismOfLeftObjects( o1 ) then
                            obj2 := AsLeftModule( o2 );
                        else
                            obj2 := AsRightModule( o2 );
                        fi;
                    elif IsHomalgRing( o1 ) and IsHomalgModule( o2 ) then
                        obj2 := o2;
                        
                        if IsHomalgLeftObjectOrMorphismOfLeftObjects( o2 ) then
                            obj1 := AsLeftModule( o1 );
                        else
                            obj1 := AsRightModule( o1 );
                        fi;
                    elif IsHomalgRing( o1 ) and IsHomalgRing( o2 ) then
                        if not IsIdenticalObj( o1, o2 ) then
                            Error( "the two rings are not identical\n" );
                        fi;
                        
                        ## I personally prefer the row convention and hence left modules:
                        obj1 := AsLeftModule( o1 );
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
        
    fi;
    
end );

##
InstallMethod( InstallFunctorOnMorphisms,
        "for homalg functors",
        [ IsHomalgFunctorRep ],
        
  function( Functor )
    local functor_name, number_of_arguments, filter_mor,
          filter0, filter1_obj, filter1_mor, filter2_obj, filter2_mor;
    
    functor_name := ValueGlobal( NameOfFunctor( Functor ) );
        
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
                
                InstallOtherMethod( functor_name,
                        "for homalg morphisms",
                        [ filter0, filter_mor ],
                  function( c, m )
                    
                    return FunctorMap( Functor, m, [ [ 1, c ] ] );
                    
                end );
                
            else
                
                InstallOtherMethod( functor_name,
                        "for homalg morphisms",
                        [ filter_mor ],
                  function( m )
                    
                    return FunctorMap( Functor, m );
                    
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
                
                if Length( Functor!.1[1] ) > 1 and Functor!.1[1][Length( Functor!.1[1] )] = "distinguished" then
                    
                    InstallOtherMethod( functor_name,
                            "for homalg morphisms",
                            [ filter0, filter1_mor ],
                      function( c, m )
                        local R;
                        
                        R := HomalgRing( m );
                        
                        return functor_name( c, m, R );
                        
                    end );
                    
                fi;
                
                InstallOtherMethod( functor_name,
                        "for homalg morphisms",
                        [ filter0, filter1_mor, filter2_obj ],
                  function( c, m, o )
                    local obj;
                    
                    if IsHomalgModule( o ) then	## the most probable case
                        obj := o;
                    elif IsHomalgRing( o ) then
                        if IsHomalgLeftObjectOrMorphismOfLeftObjects( m ) then
                            obj := AsLeftModule( o );
                        else
                            obj := AsRightModule( o );
                        fi;
                    else
                        ## the default:
                        obj := o;
                    fi;
                    
                    return FunctorMap( Functor, m, [ [ 1, c ], [ 3, obj ] ] );
                    
                end );
                
                InstallOtherMethod( functor_name,
                        "for homalg morphisms",
                        [ filter0, filter1_obj, filter2_mor ],
                  function( c, o, m )
                    local obj;
                    
                    if IsHomalgModule( o ) then	## the most probable case
                        obj := o;
                    elif IsHomalgRing( o ) then
                        if IsHomalgLeftObjectOrMorphismOfLeftObjects( m ) then
                            obj := AsLeftModule( o );
                        else
                            obj := AsRightModule( o );
                        fi;
                    else
                        ## the default:
                        obj := o;
                    fi;
                    
                    return FunctorMap( Functor, m, [ [ 1, c ], [ 2, obj ] ] );
                    
                end );
                
            else
                
                if Length( Functor!.1[1] ) > 1 and Functor!.1[1][Length( Functor!.1[1] )] = "distinguished" then
                    
                    InstallOtherMethod( functor_name,
                            "for homalg morphisms",
                            [ filter1_mor ],
                      function( m )
                        local R;
                        
                        R := HomalgRing( m );
                        
                        return functor_name( m, R );
                        
                    end );
                    
                fi;
                
                InstallOtherMethod( functor_name,
                        "for homalg morphisms",
                        [ filter1_mor, filter2_obj ],
                  function( m, o )
                    local obj;
                    
                    if IsHomalgModule( o ) then	## the most probable case
                        obj := o;
                    elif IsHomalgRing( o ) then
                        if IsHomalgLeftObjectOrMorphismOfLeftObjects( m ) then
                            obj := AsLeftModule( o );
                        else
                            obj := AsRightModule( o );
                        fi;
                    else
                        ## the default:
                        obj := o;
                    fi;
                    
                    return FunctorMap( Functor, m, [ [ 2, obj ] ] );
                    
                end );
                
                InstallOtherMethod( functor_name,
                        "for homalg morphisms",
                        [ filter1_obj, filter2_mor ],
                  function( o, m )
                    local obj;
                    
                    if IsHomalgModule( o ) then	## the most probable case
                        obj := o;
                    elif IsHomalgRing( o ) then
                        if IsHomalgLeftObjectOrMorphismOfLeftObjects( m ) then
                            obj := AsLeftModule( o );
                        else
                            obj := AsRightModule( o );
                        fi;
                    else
                        ## the default:
                        obj := o;
                    fi;
                    
                    return FunctorMap( Functor, m, [ [ 1, obj ] ] );
                    
                end );
                
            fi;
            
        else
            
            Error( "wrong syntax: ", filter1_mor, filter2_mor, "\n" );
            
        fi;
        
    fi;
    
end );

InstallGlobalFunction( HelperToInstallUnivariateFunctorOnComplexes,
  function( Functor, filter_cpx, complex_or_cocomplex, i )
    local filter0, functor_name;
    
    functor_name := ValueGlobal( NameOfFunctor( Functor ) );
    
    if IsBound( Functor!.0 ) and IsList( Functor!.0 ) then
        
        if Length( Functor!.0 ) = 1 then
            filter0 := Functor!.0[1];
        else
            filter0 := IsList;
        fi;
        
        if IsAdditiveFunctor( Functor ) then
            
            InstallOtherMethod( functor_name,
                    "for homalg complexes",
                    [ filter0, filter_cpx ],
              function( q, c )
                local degrees, l, morphisms, Fc, m;
                
                degrees := ObjectDegreesOfComplex( c );
                
                l := Length( degrees );
                
                if l = 1 then
                    Fc := complex_or_cocomplex( functor_name( q, CertainObject( c, degrees[1] ) ), degrees[1] );
                else
                    morphisms := MorphismsOfComplex( c );
                    Fc := complex_or_cocomplex( functor_name( q, morphisms[1] ), degrees[i] );
                    for m in morphisms{[ 2 .. l - 1 ]} do
                        Add( Fc, functor_name( q, m ) );
                    od;
                fi;
                
                if HasIsGradedObject( c ) and IsGradedObject( c ) then;
                    SetIsGradedObject( Fc, true );
                elif HasIsComplex( c ) and IsComplex( c ) then
                    SetIsComplex( Fc, true );
                elif HasIsSequence( c ) and IsSequence ( c ) then
                    SetIsSequence( Fc, true );
                fi;
                
                return Fc;
                
            end );
            
        else
            
            InstallOtherMethod( functor_name,
                    "for homalg complexes",
                    [ filter0, filter_cpx ],
              function( q, c )
                local degrees, l, morphisms, Fc, m;
                
                degrees := ObjectDegreesOfComplex( c );
                
                l := Length( degrees );
                
                if l = 1 then
                    Fc := complex_or_cocomplex( functor_name( q, CertainObject( c, degrees[1] ) ), degrees[1] );
                else
                    morphisms := MorphismsOfComplex( c );
                    Fc := complex_or_cocomplex( functor_name( q, morphisms[1] ), degrees[i] );
                    for m in morphisms{[ 2 .. l - 1 ]} do
                        Add( Fc, functor_name( q, m ) );
                    od;
                fi;
                
                return Fc;
                
            end );
            
        fi;
        
    else
        
        if IsAdditiveFunctor( Functor ) then
            
            InstallOtherMethod( functor_name,
                    "for homalg complexes",
                    [ filter_cpx ],
              function( c )
                local degrees, l, morphisms, Fc, m;
                
                degrees := ObjectDegreesOfComplex( c );
                
                l := Length( degrees );
                
                if l = 1 then
                    Fc := complex_or_cocomplex( functor_name( CertainObject( c, degrees[1] ) ), degrees[1] );
                else
                    morphisms := MorphismsOfComplex( c );
                    Fc := complex_or_cocomplex( functor_name( morphisms[1] ), degrees[i] );
                    for m in morphisms{[ 2 .. l - 1 ]} do
                        Add( Fc, functor_name( m ) );
                    od;
                fi;
                
                if HasIsGradedObject( c ) and IsGradedObject( c ) then;
                    SetIsGradedObject( Fc, true );
                elif HasIsComplex( c ) and IsComplex( c ) then
                    SetIsComplex( Fc, true );
                elif HasIsSequence( c ) and IsSequence ( c ) then
                    SetIsSequence( Fc, true );
                fi;
                
                return Fc;
                
            end );
            
        else
            
            InstallOtherMethod( functor_name,
                    "for homalg complexes",
                    [ filter_cpx ],
              function( c )
                local degrees, l, morphisms, Fc, m;
                
                degrees := ObjectDegreesOfComplex( c );
                
                l := Length( degrees );
                
                if l = 1 then
                    Fc := complex_or_cocomplex( functor_name( CertainObject( c, degrees[1] ) ), degrees[1] );
                else
                    morphisms := MorphismsOfComplex( c );
                    Fc := complex_or_cocomplex( functor_name( morphisms[1] ), degrees[i] );
                    for m in morphisms{[ 2 .. l - 1 ]} do
                        Add( Fc, functor_name( m ) );
                    od;
                fi;
                
                return Fc;
                
            end );
            
        fi;
        
    fi;
    
end );

InstallGlobalFunction( HelperToInstallFirstArgumentOfBivariateFunctorOnComplexes,
  function( Functor, filter2_obj, filter1_cpx, complex_or_cocomplex, i )
    local filter0, functor_name;
    
    functor_name := ValueGlobal( NameOfFunctor( Functor ) );
    
    if IsBound( Functor!.0 ) and IsList( Functor!.0 ) then
        
        if Length( Functor!.0 ) = 1 then
            filter0 := Functor!.0[1];
        else
            filter0 := IsList;
        fi;
        
        if Length( Functor!.1[1] ) > 1 and Functor!.1[1][Length( Functor!.1[1] )] = "distinguished" then
            
            InstallOtherMethod( functor_name,
                    "for homalg complexes",
                    [ filter0, filter1_cpx ],
              function( q, c )
                local R;
                
                R := HomalgRing( c );
                
                return functor_name( q, c, R );
                
            end );
            
        fi;
        
        if IsAdditiveFunctor( Functor, 1 ) then
            
            InstallOtherMethod( functor_name,
                    "for homalg complexes",
                    [ filter0, filter1_cpx, filter2_obj ],
              function( q, c, o )
                local obj, degrees, l, morphisms, Fc, m;
                
                if IsHomalgModule( o ) then	## the most probable case
                    obj := o;
                elif IsHomalgRing( o ) then
                    if IsHomalgLeftObjectOrMorphismOfLeftObjects( c ) then
                        obj := AsLeftModule( o );
                    else
                        obj := AsRightModule( o );
                    fi;
                else
                    ## the default:
                    obj := o;
                fi;
                
                degrees := ObjectDegreesOfComplex( c );
                
                l := Length( degrees );
                
                if l = 1 then
                    Fc := complex_or_cocomplex( functor_name( q, CertainObject( c, degrees[1] ), obj ), degrees[1] );
                else
                    morphisms := MorphismsOfComplex( c );
                    Fc := complex_or_cocomplex( functor_name( q, morphisms[1], obj ), degrees[i] );
                    for m in morphisms{[ 2 .. l - 1 ]} do
                        Add( Fc, functor_name( q, m, obj ) );
                    od;
                fi;
                
                if HasIsGradedObject( c ) and IsGradedObject( c ) then;
                    SetIsGradedObject( Fc, true );
                elif HasIsComplex( c ) and IsComplex( c ) then
                    SetIsComplex( Fc, true );
                elif HasIsSequence( c ) and IsSequence ( c ) then
                    SetIsSequence( Fc, true );
                fi;
                
                return Fc;
                
            end );
            
        else
            
            InstallOtherMethod( functor_name,
                    "for homalg complexes",
                    [ filter0, filter1_cpx, filter2_obj ],
              function( q, c, o )
                local obj, degrees, l, morphisms, Fc, m;
                
                if IsHomalgModule( o ) then	## the most probable case
                    obj := o;
                elif IsHomalgRing( o ) then
                    if IsHomalgLeftObjectOrMorphismOfLeftObjects( c ) then
                        obj := AsLeftModule( o );
                    else
                        obj := AsRightModule( o );
                    fi;
                else
                    ## the default:
                    obj := o;
                fi;
                
                degrees := ObjectDegreesOfComplex( c );
                
                l := Length( degrees );
                
                if l = 1 then
                    Fc := complex_or_cocomplex( functor_name( q, CertainObject( c, degrees[1] ), obj ), degrees[1] );
                else
                    morphisms := MorphismsOfComplex( c );
                    Fc := complex_or_cocomplex( functor_name( q, morphisms[1], obj ), degrees[i] );
                    for m in morphisms{[ 2 .. l - 1 ]} do
                        Add( Fc, functor_name( q, m, obj ) );
                    od;
                fi;
                
                return Fc;
                
            end );
            
        fi;
        
    else
        
        if Length( Functor!.1[1] ) > 1 and Functor!.1[1][Length( Functor!.1[1] )] = "distinguished" then
            
            InstallOtherMethod( functor_name,
                    "for homalg complexes",
                    [ filter1_cpx ],
              function( c )
                local R;
                
                R := HomalgRing( c );
                
                return functor_name( c, R );
                
            end );
            
        fi;
        
        if IsAdditiveFunctor( Functor, 1 ) then
            
            InstallOtherMethod( functor_name,
                    "for homalg complexes",
                    [ filter1_cpx, filter2_obj ],
              function( c, o )
                local obj, degrees, l, morphisms, Fc, m;
                
                if IsHomalgModule( o ) then	## the most probable case
                    obj := o;
                elif IsHomalgRing( o ) then
                    if IsHomalgLeftObjectOrMorphismOfLeftObjects( c ) then
                        obj := AsLeftModule( o );
                    else
                        obj := AsRightModule( o );
                    fi;
                else
                    ## the default:
                    obj := o;
                fi;
                
                degrees := ObjectDegreesOfComplex( c );
                
                l := Length( degrees );
                
                if l = 1 then
                    Fc := complex_or_cocomplex( functor_name( CertainObject( c, degrees[1] ), obj ), degrees[1] );
                else
                    morphisms := MorphismsOfComplex( c );
                    Fc := complex_or_cocomplex( functor_name( morphisms[1], obj ), degrees[i] );
                    for m in morphisms{[ 2 .. l - 1 ]} do
                        Add( Fc, functor_name( m, obj ) );
                    od;
                fi;
                
                if HasIsGradedObject( c ) and IsGradedObject( c ) then;
                    SetIsGradedObject( Fc, true );
                elif HasIsComplex( c ) and IsComplex( c ) then
                    SetIsComplex( Fc, true );
                elif HasIsSequence( c ) and IsSequence ( c ) then
                    SetIsSequence( Fc, true );
                fi;
                
                return Fc;
                
            end );
            
        else
            
            InstallOtherMethod( functor_name,
                    "for homalg complexes",
                    [ filter1_cpx, filter2_obj ],
              function( c, o )
                local obj, degrees, l, morphisms, Fc, m;
                
                if IsHomalgModule( o ) then	## the most probable case
                    obj := o;
                elif IsHomalgRing( o ) then
                    if IsHomalgLeftObjectOrMorphismOfLeftObjects( c ) then
                        obj := AsLeftModule( o );
                    else
                        obj := AsRightModule( o );
                    fi;
                else
                    ## the default:
                    obj := o;
                fi;
                
                degrees := ObjectDegreesOfComplex( c );
                
                l := Length( degrees );
                
                if l = 1 then
                    Fc := complex_or_cocomplex( functor_name( CertainObject( c, degrees[1] ), obj ), degrees[1] );
                else
                    morphisms := MorphismsOfComplex( c );
                    Fc := complex_or_cocomplex( functor_name( morphisms[1], obj ), degrees[i] );
                    for m in morphisms{[ 2 .. l - 1 ]} do
                        Add( Fc, functor_name( m, obj ) );
                    od;
                fi;
                
                return Fc;
                
            end );
            
        fi;
        
    fi;
    
end );

InstallGlobalFunction( HelperToInstallSecondArgumentOfBivariateFunctorOnComplexes,
  function( Functor, filter1_obj, filter2_cpx, complex_or_cocomplex, i )
    local filter0, functor_name;
    
    functor_name := ValueGlobal( NameOfFunctor( Functor ) );
    
    if IsBound( Functor!.0 ) and IsList( Functor!.0 ) then
        
        if Length( Functor!.0 ) = 1 then
            filter0 := Functor!.0[1];
        else
            filter0 := IsList;
        fi;
        
        if IsAdditiveFunctor( Functor, 2 ) then
            
            InstallOtherMethod( functor_name,
                    "for homalg complexes",
                    [ filter0, filter1_obj, filter2_cpx ],
              function( q, o, c )
                local obj, degrees, l, morphisms, Fc, m;
                
                if IsHomalgModule( o ) then	## the most probable case
                    obj := o;
                elif IsHomalgRing( o ) then
                    if IsHomalgLeftObjectOrMorphismOfLeftObjects( c ) then
                        obj := AsLeftModule( o );
                    else
                        obj := AsRightModule( o );
                    fi;
                else
                    ## the default:
                    obj := o;
                fi;
                
                degrees := ObjectDegreesOfComplex( c );
                
                l := Length( degrees );
                
                if l = 1 then
                    Fc := complex_or_cocomplex( functor_name( q, obj, CertainObject( c, degrees[1] ) ), degrees[1] );
                else
                    morphisms := MorphismsOfComplex( c );
                    Fc := complex_or_cocomplex( functor_name( q, obj, morphisms[1] ), degrees[i] );
                    for m in morphisms{[ 2 .. l - 1 ]} do
                        Add( Fc, functor_name( q, obj, m ) );
                    od;
                fi;
                
                return Fc;
                
                if HasIsGradedObject( c ) and IsGradedObject( c ) then;
                    SetIsGradedObject( Fc, true );
                elif HasIsComplex( c ) and IsComplex( c ) then
                    SetIsComplex( Fc, true );
                elif HasIsSequence( c ) and IsSequence ( c ) then
                    SetIsSequence( Fc, true );
                fi;
                
            end );
            
        else
            
            InstallOtherMethod( functor_name,
                    "for homalg complexes",
                    [ filter0, filter1_obj, filter2_cpx ],
              function( q, o, c )
                local obj, degrees, l, morphisms, Fc, m;
                
                if IsHomalgModule( o ) then	## the most probable case
                    obj := o;
                elif IsHomalgRing( o ) then
                    if IsHomalgLeftObjectOrMorphismOfLeftObjects( c ) then
                        obj := AsLeftModule( o );
                    else
                        obj := AsRightModule( o );
                    fi;
                else
                    ## the default:
                    obj := o;
                fi;
                
                degrees := ObjectDegreesOfComplex( c );
                
                l := Length( degrees );
                
                if l = 1 then
                    Fc := complex_or_cocomplex( functor_name( q, obj, CertainObject( c, degrees[1] ) ), degrees[1] );
                else
                    morphisms := MorphismsOfComplex( c );
                    Fc := complex_or_cocomplex( functor_name( q, obj, morphisms[1] ), degrees[i] );
                    for m in morphisms{[ 2 .. l - 1 ]} do
                        Add( Fc, functor_name( q, obj, m ) );
                    od;
                fi;
                
                return Fc;
                
            end );
            
        fi;
        
    else
        
        if IsAdditiveFunctor( Functor, 2 ) then
            
            InstallOtherMethod( functor_name,
                    "for homalg complexes",
                    [ filter1_obj, filter2_cpx ],
              function( o, c )
                local obj, degrees, l, morphisms, Fc, m;
                
                if IsHomalgModule( o ) then	## the most probable case
                    obj := o;
                elif IsHomalgRing( o ) then
                    if IsHomalgLeftObjectOrMorphismOfLeftObjects( c ) then
                        obj := AsLeftModule( o );
                    else
                        obj := AsRightModule( o );
                    fi;
                else
                    ## the default:
                    obj := o;
                fi;
                
                degrees := ObjectDegreesOfComplex( c );
                
                l := Length( degrees );
                
                if l = 1 then
                    Fc := complex_or_cocomplex( functor_name( obj, CertainObject( c, degrees[1] ) ), degrees[1] );
                else
                    morphisms := MorphismsOfComplex( c );
                    Fc := complex_or_cocomplex( functor_name( obj, morphisms[1] ), degrees[i] );
                    for m in morphisms{[ 2 .. l - 1 ]} do
                        Add( Fc, functor_name( obj, m ) );
                    od;
                fi;
                
                return Fc;
                
                if HasIsGradedObject( c ) and IsGradedObject( c ) then;
                    SetIsGradedObject( Fc, true );
                elif HasIsComplex( c ) and IsComplex( c ) then
                    SetIsComplex( Fc, true );
                elif HasIsSequence( c ) and IsSequence ( c ) then
                    SetIsSequence( Fc, true );
                fi;
                
            end );
            
        else
            
            InstallOtherMethod( functor_name,
                    "for homalg complexes",
                    [ filter1_obj, filter2_cpx ],
              function( o, c )
                local obj, degrees, l, morphisms, Fc, m;
                
                if IsHomalgModule( o ) then	## the most probable case
                    obj := o;
                elif IsHomalgRing( o ) then
                    if IsHomalgLeftObjectOrMorphismOfLeftObjects( c ) then
                        obj := AsLeftModule( o );
                    else
                        obj := AsRightModule( o );
                    fi;
                else
                    ## the default:
                    obj := o;
                fi;
                
                degrees := ObjectDegreesOfComplex( c );
                
                l := Length( degrees );
                
                if l = 1 then
                    Fc := complex_or_cocomplex( functor_name( obj, CertainObject( c, degrees[1] ) ), degrees[1] );
                else
                    morphisms := MorphismsOfComplex( c );
                    Fc := complex_or_cocomplex( functor_name( obj, morphisms[1] ), degrees[i] );
                    for m in morphisms{[ 2 .. l - 1 ]} do
                        Add( Fc, functor_name( obj, m ) );
                    od;
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
            
        else
            
            Error( "wrong syntax: ", filter1_cpx, filter2_cpx, "\n" );
            
        fi;
        
    fi;
    
end );

InstallGlobalFunction( HelperToInstallUnivariateFunctorOnChainMaps,
  function( Functor, filter_chm, source_target, i )
    local filter0, functor_name;
    
    functor_name := ValueGlobal( NameOfFunctor( Functor ) );
    
    if IsBound( Functor!.0 ) and IsList( Functor!.0 ) then
        
        if Length( Functor!.0 ) = 1 then
            filter0 := Functor!.0[1];
        else
            filter0 := IsList;
        fi;
        
        if IsAdditiveFunctor( Functor ) then
            
            InstallOtherMethod( functor_name,
                    "for homalg chain maps",
                    [ filter0, filter_chm ],
              function( q, c )
                local d, degrees, l, source, target, morphisms, Fc, m;
                
                d := DegreeOfMorphism( c );
                
                degrees := DegreesOfChainMap( c );
                
                l := Length( degrees );
                
                source := functor_name( q, source_target[1]( c ) );
                target := functor_name( q, source_target[2]( c ) );
                
                morphisms := MorphismsOfChainMap( c );
                
                Fc := HomalgChainMap( functor_name( q, morphisms[1] ), source, target, [ degrees[1] + i * d, (-1)^i * d ] );
                
                for m in morphisms{[ 2 .. l ]} do
                    Add( Fc, functor_name( q, m ) );
                od;
                
                if HasIsMorphism( c ) and IsMorphism( c ) then
                    SetIsMorphism( Fc, true );
                fi;
                
                return Fc;
                
            end );
            
        else
            
            InstallOtherMethod( functor_name,
                    "for homalg chain maps",
                    [ filter0, filter_chm ],
              function( q, c )
                local d, degrees, l, source, target, morphisms, Fc, m;
                
                d := DegreeOfMorphism( c );
                
                degrees := DegreesOfChainMap( c );
                
                l := Length( degrees );
                
                source := functor_name( q, source_target[1]( c ) );
                target := functor_name( q, source_target[2]( c ) );
                
                morphisms := MorphismsOfChainMap( c );
                
                Fc := HomalgChainMap( functor_name( q, morphisms[1] ), source, target, [ degrees[1] + i * d, (-1)^i * d ] );
                
                for m in morphisms{[ 2 .. l ]} do
                    Add( Fc, functor_name( q, m ) );
                od;
                
                return Fc;
                
            end );
            
        fi;
        
    else
        
        if IsAdditiveFunctor( Functor ) then
            
            InstallOtherMethod( functor_name,
                    "for homalg chain maps",
                    [ filter_chm ],
              function( c )
                local d, degrees, l, source, target, morphisms, Fc, m;
                
                d := DegreeOfMorphism( c );
                
                degrees := DegreesOfChainMap( c );
                
                l := Length( degrees );
                
                source := functor_name( source_target[1]( c ) );
                target := functor_name( source_target[2]( c ) );
                
                morphisms := MorphismsOfChainMap( c );
                
                Fc := HomalgChainMap( functor_name( morphisms[1] ), source, target, [ degrees[1] + i * d, (-1)^i * d ] );
                
                for m in morphisms{[ 2 .. l ]} do
                    Add( Fc, functor_name( m ) );
                od;
                
                if HasIsMorphism( c ) and IsMorphism( c ) then
                    SetIsMorphism( Fc, true );
                fi;
                
                return Fc;
                
            end );
            
        else
            
            InstallOtherMethod( functor_name,
                    "for homalg chain maps",
                    [ filter_chm ],
              function( c )
                local d, degrees, l, source, target, morphisms, Fc, m;
                
                d := DegreeOfMorphism( c );
                
                degrees := DegreesOfChainMap( c );
                
                l := Length( degrees );
                
                source := functor_name( source_target[1]( c ) );
                target := functor_name( source_target[2]( c ) );
                
                morphisms := MorphismsOfChainMap( c );
                
                Fc := HomalgChainMap( functor_name( morphisms[1] ), source, target, [ degrees[1] + i * d, (-1)^i * d ] );
                
                for m in morphisms{[ 2 .. l ]} do
                    Add( Fc, functor_name( m ) );
                od;
                
                return Fc;
                
            end );
            
        fi;
        
    fi;
    
end );

InstallGlobalFunction( HelperToInstallFirstArgumentOfBivariateFunctorOnChainMaps,
  function( Functor, filter2_obj, filter1_chm, source_target, i )
    local filter0, functor_name;
    
    functor_name := ValueGlobal( NameOfFunctor( Functor ) );
    
    if IsBound( Functor!.0 ) and IsList( Functor!.0 ) then
        
        if Length( Functor!.0 ) = 1 then
            filter0 := Functor!.0[1];
        else
            filter0 := IsList;
        fi;
        
        if Length( Functor!.1[1] ) > 1 and Functor!.1[1][Length( Functor!.1[1] )] = "distinguished" then
            
            InstallOtherMethod( functor_name,
                    "for homalg chain maps",
                    [ filter0, filter1_chm ],
              function( q, c )
                local R;
                
                R := HomalgRing( c );
                
                return functor_name( q, c, R );
                
            end );
            
        fi;
        
        if IsAdditiveFunctor( Functor, 1 ) then
            
            InstallOtherMethod( functor_name,
                    "for homalg chain maps",
                    [ filter0, filter1_chm, filter2_obj ],
              function( q, c, o )
                local obj, d, degrees, l, source, target, morphisms, Fc, m;
                
                if IsHomalgModule( o ) then	## the most probable case
                    obj := o;
                elif IsHomalgRing( o ) then
                    if IsHomalgLeftObjectOrMorphismOfLeftObjects( c ) then
                        obj := AsLeftModule( o );
                    else
                        obj := AsRightModule( o );
                    fi;
                else
                    ## the default:
                    obj := o;
                fi;
                
                d := DegreeOfMorphism( c );
                
                degrees := DegreesOfChainMap( c );
                
                l := Length( degrees );
                
                source := functor_name( q, source_target[1]( c ), obj );
                target := functor_name( q, source_target[2]( c ), obj );
                
                morphisms := MorphismsOfChainMap( c );
                
                Fc := HomalgChainMap( functor_name( q, morphisms[1], obj ), source, target, [ degrees[1] + i * d, (-1)^i * d ] );
                
                for m in morphisms{[ 2 .. l ]} do
                    Add( Fc, functor_name( q, m, obj ) );
                od;
                
                if HasIsMorphism( c ) and IsMorphism( c ) then
                    SetIsMorphism( Fc, true );
                fi;
                
                return Fc;
                
            end );
            
        else
            
            InstallOtherMethod( functor_name,
                    "for homalg chain maps",
                    [ filter0, filter1_chm, filter2_obj ],
              function( q, c, o )
                local obj, d, degrees, l, source, target, morphisms, Fc, m;
                
                if IsHomalgModule( o ) then	## the most probable case
                    obj := o;
                elif IsHomalgRing( o ) then
                    if IsHomalgLeftObjectOrMorphismOfLeftObjects( c ) then
                        obj := AsLeftModule( o );
                    else
                        obj := AsRightModule( o );
                    fi;
                else
                    ## the default:
                    obj := o;
                fi;
                
                d := DegreeOfMorphism( c );
                
                degrees := DegreesOfChainMap( c );
                
                l := Length( degrees );
                
                source := functor_name( q, source_target[1]( c ), obj );
                target := functor_name( q, source_target[2]( c ), obj );
                
                morphisms := MorphismsOfChainMap( c );
                
                Fc := HomalgChainMap( functor_name( q, morphisms[1], obj ), source, target, [ degrees[1] + i * d, (-1)^i * d ] );
                
                for m in morphisms{[ 2 .. l ]} do
                    Add( Fc, functor_name( q, m, obj ) );
                od;
                
                return Fc;
                
            end );
            
        fi;
        
    else
        
        if Length( Functor!.1[1] ) > 1 and Functor!.1[1][Length( Functor!.1[1] )] = "distinguished" then
            
            InstallOtherMethod( functor_name,
                    "for homalg chain maps",
                    [ filter1_chm ],
              function( c )
                local R;
                
                R := HomalgRing( c );
                
                return functor_name( c, R );
                
            end );
            
        fi;
        
        if IsAdditiveFunctor( Functor, 1 ) then
            
            InstallOtherMethod( functor_name,
                    "for homalg chain maps",
                    [ filter1_chm, filter2_obj ],
              function( c, o )
                local obj, d, degrees, l, source, target, morphisms, Fc, m;
                
                if IsHomalgModule( o ) then	## the most probable case
                    obj := o;
                elif IsHomalgRing( o ) then
                    if IsHomalgLeftObjectOrMorphismOfLeftObjects( c ) then
                        obj := AsLeftModule( o );
                    else
                        obj := AsRightModule( o );
                    fi;
                else
                    ## the default:
                    obj := o;
                fi;
                
                d := DegreeOfMorphism( c );
                
                degrees := DegreesOfChainMap( c );
                
                l := Length( degrees );
                
                source := functor_name( source_target[1]( c ), obj );
                target := functor_name( source_target[2]( c ), obj );
                
                morphisms := MorphismsOfChainMap( c );
                
                Fc := HomalgChainMap( functor_name( morphisms[1], obj ), source, target, [ degrees[1] + i * d, (-1)^i * d ] );
                
                for m in morphisms{[ 2 .. l ]} do
                    Add( Fc, functor_name( m, obj ) );
                od;
                
                if HasIsMorphism( c ) and IsMorphism( c ) then
                    SetIsMorphism( Fc, true );
                fi;
                
                return Fc;
                
            end );
            
        else
            
            InstallOtherMethod( functor_name,
                    "for homalg chain maps",
                    [ filter1_chm, filter2_obj ],
              function( c, o )
                local obj, d, degrees, l, source, target, morphisms, Fc, m;
                
                if IsHomalgModule( o ) then	## the most probable case
                    obj := o;
                elif IsHomalgRing( o ) then
                    if IsHomalgLeftObjectOrMorphismOfLeftObjects( c ) then
                        obj := AsLeftModule( o );
                    else
                        obj := AsRightModule( o );
                    fi;
                else
                    ## the default:
                    obj := o;
                fi;
                
                d := DegreeOfMorphism( c );
                
                degrees := DegreesOfChainMap( c );
                
                l := Length( degrees );
                
                source := functor_name( source_target[1]( c ), obj );
                target := functor_name( source_target[2]( c ), obj );
                
                morphisms := MorphismsOfChainMap( c );
                
                Fc := HomalgChainMap( functor_name( morphisms[1], obj ), source, target, [ degrees[1] + i * d, (-1)^i * d ] );
                
                for m in morphisms{[ 2 .. l ]} do
                    Add( Fc, functor_name( m, obj ) );
                od;
                
                return Fc;
                
            end );
            
        fi;
        
    fi;
    
end );

InstallGlobalFunction( HelperToInstallSecondArgumentOfBivariateFunctorOnChainMaps,
  function( Functor, filter1_obj, filter2_chm, source_target, i )
    local filter0, functor_name;
    
    functor_name := ValueGlobal( NameOfFunctor( Functor ) );
    
    if IsBound( Functor!.0 ) and IsList( Functor!.0 ) then
        
        if Length( Functor!.0 ) = 1 then
            filter0 := Functor!.0[1];
        else
            filter0 := IsList;
        fi;
        
        if IsAdditiveFunctor( Functor, 2 ) then
            
            InstallOtherMethod( functor_name,
                    "for homalg chain maps",
                    [ filter0, filter1_obj, filter2_chm ],
              function( q, o, c )
                local obj, d, degrees, l, source, target, morphisms, Fc, m;
                
                if IsHomalgModule( o ) then	## the most probable case
                    obj := o;
                elif IsHomalgRing( o ) then
                    if IsHomalgLeftObjectOrMorphismOfLeftObjects( c ) then
                        obj := AsLeftModule( o );
                    else
                        obj := AsRightModule( o );
                    fi;
                else
                    ## the default:
                    obj := o;
                fi;
                
                d := DegreeOfMorphism( c );
                
                degrees := DegreesOfChainMap( c );
                
                l := Length( degrees );
                
                source := functor_name( q, obj, source_target[1]( c ) );
                target := functor_name( q, obj, source_target[2]( c ) );
                
                morphisms := MorphismsOfChainMap( c );
                
                Fc := HomalgChainMap( functor_name( q, obj, morphisms[1] ), source, target, [ degrees[1] + i * d, (-1)^i * d ] );
                
                for m in morphisms{[ 2 .. l ]} do
                    Add( Fc, functor_name( q, obj, m ) );
                od;
                
                if HasIsMorphism( c ) and IsMorphism( c ) then
                    SetIsMorphism( Fc, true );
                fi;
                
                return Fc;
                
            end );
            
        else
            
            InstallOtherMethod( functor_name,
                    "for homalg chain maps",
                    [ filter0, filter1_obj, filter2_chm ],
              function( q, o, c )
                local obj, d, degrees, l, source, target, morphisms, Fc, m;
                
                if IsHomalgModule( o ) then	## the most probable case
                    obj := o;
                elif IsHomalgRing( o ) then
                    if IsHomalgLeftObjectOrMorphismOfLeftObjects( c ) then
                        obj := AsLeftModule( o );
                    else
                        obj := AsRightModule( o );
                    fi;
                else
                    ## the default:
                    obj := o;
                fi;
                
                d := DegreeOfMorphism( c );
                
                degrees := DegreesOfChainMap( c );
                
                l := Length( degrees );
                
                source := functor_name( q, obj, source_target[1]( c ) );
                target := functor_name( q, obj, source_target[2]( c ) );
                
                morphisms := MorphismsOfChainMap( c );
                
                Fc := HomalgChainMap( functor_name( q, obj, morphisms[1] ), source, target, [ degrees[1] + i * d, (-1)^i * d ] );
                
                for m in morphisms{[ 2 .. l ]} do
                    Add( Fc, functor_name( q, obj, m ) );
                od;
                
                return Fc;
                
            end );
            
        fi;
        
    else
        
        if IsAdditiveFunctor( Functor, 2 ) then
            
            InstallOtherMethod( functor_name,
                    "for homalg chain maps",
                    [ filter1_obj, filter2_chm ],
              function( o, c )
                local obj, d, degrees, l, source, target, morphisms, Fc, m;
                
                if IsHomalgModule( o ) then	## the most probable case
                    obj := o;
                elif IsHomalgRing( o ) then
                    if IsHomalgLeftObjectOrMorphismOfLeftObjects( c ) then
                        obj := AsLeftModule( o );
                    else
                        obj := AsRightModule( o );
                    fi;
                else
                    ## the default:
                    obj := o;
                fi;
                
                d := DegreeOfMorphism( c );
                
                degrees := DegreesOfChainMap( c );
                
                l := Length( degrees );
                
                source := functor_name( obj, source_target[1]( c ) );
                target := functor_name( obj, source_target[2]( c ) );
                
                morphisms := MorphismsOfChainMap( c );
                
                Fc := HomalgChainMap( functor_name( obj, morphisms[1] ), source, target, [ degrees[1] + i * d, (-1)^i * d ] );
                
                for m in morphisms{[ 2 .. l ]} do
                    Add( Fc, functor_name( obj, m ) );
                od;
                
                if HasIsMorphism( c ) and IsMorphism( c ) then
                    SetIsMorphism( Fc, true );
                fi;
                
                return Fc;
                
            end );
            
        else
            
            InstallOtherMethod( functor_name,
                    "for homalg chain maps",
                    [ filter1_obj, filter2_chm ],
              function( o, c )
                local obj, d, degrees, l, source, target, morphisms, Fc, m;
                
                if IsHomalgModule( o ) then	## the most probable case
                    obj := o;
                elif IsHomalgRing( o ) then
                    if IsHomalgLeftObjectOrMorphismOfLeftObjects( c ) then
                        obj := AsLeftModule( o );
                    else
                        obj := AsRightModule( o );
                    fi;
                else
                    ## the default:
                    obj := o;
                fi;
                
                d := DegreeOfMorphism( c );
                
                degrees := DegreesOfChainMap( c );
                
                l := Length( degrees );
                
                source := functor_name( obj, source_target[1]( c ) );
                target := functor_name( obj, source_target[2]( c ) );
                
                morphisms := MorphismsOfChainMap( c );
                
                Fc := HomalgChainMap( functor_name( obj, morphisms[1] ), source, target, [ degrees[1] + i * d, (-1)^i * d ] );
                
                for m in morphisms{[ 2 .. l ]} do
                    Add( Fc, functor_name( obj, m ) );
                od;
                
                return Fc;
                
            end );
            
        fi;
        
    fi;
    
end );

##
InstallMethod( InstallFunctorOnChainMaps,
        "for homalg functors",
        [ IsHomalgFunctorRep ],
        
  function( Functor )
    local number_of_arguments, filter_chm,
          filter1_obj, filter1_chm, filter2_obj, filter2_chm,
          ar, i, chainmap, cochainmap, head;
    
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
                chainmap := [ [ Source, Range ], 0 ];
                cochainmap := [ [ Source, Range ], 0 ];
            else
                chainmap := [ [ Range, Source ], 1 ];
                cochainmap := [ [ Range, Source ], 1 ];
            fi;
            
            head := [ Functor ];
            
            chainmap := Concatenation( head, [ filter_chm[1] ], chainmap );
            cochainmap := Concatenation( head, [ filter_chm[2] ], cochainmap );
            
            CallFuncList( HelperToInstallUnivariateFunctorOnChainMaps, chainmap );
            CallFuncList( HelperToInstallUnivariateFunctorOnChainMaps, cochainmap );
            
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
            
            ar := [ [ filter2_obj, filter1_chm, HelperToInstallFirstArgumentOfBivariateFunctorOnChainMaps ],
                    [ filter1_obj, filter2_chm, HelperToInstallSecondArgumentOfBivariateFunctorOnChainMaps ] ];
            
            for i in [ 1 .. number_of_arguments ] do
                
                if IsCovariantFunctor( Functor, i ) = true then
                    chainmap := [ [ Source, Range ], 0 ];
                    cochainmap := [ [ Source, Range ], 0 ];
                else
                    chainmap := [ [ Range, Source ], 1 ];
                    cochainmap := [ [ Range, Source ], 1 ];
                fi;
                
                head := [ Functor, ar[i][1] ];
                
                chainmap := Concatenation( head, [ ar[i][2][1] ], chainmap );
                cochainmap := Concatenation( head, [ ar[i][2][2] ], cochainmap );
                
                CallFuncList( ar[i][3], chainmap );
                CallFuncList( ar[i][3], cochainmap );
                
            od;
            
        else
            
            Error( "wrong syntax: ", filter1_chm, filter2_chm, "\n" );
            
        fi;
        
    fi;
    
end );

##
InstallMethod( InstallFunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep ],
        
  function( Functor )
    
    InstallFunctorOnObjects( Functor );
    
    InstallFunctorOnMorphisms( Functor );
    
    InstallFunctorOnComplexes( Functor );
    
    InstallFunctorOnChainMaps( Functor );
    
end );

##
InstallMethod( RightSatelliteOfCofunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsString, IsPosInt ],
        
  function( Functor, name, p )
    local _Functor_OnObjects, _Functor_OnMorphisms, m, z, data, SF;
    
    if IsCovariantFunctor( Functor, p ) <> false then
        Error( "the functor does not seem to be contravariant in its ", p, ". argument\n" );
    fi;
    
    _Functor_OnObjects :=
      function( arg )
        local functor_name, c, d, d_c_1, mu, ar, F_mu;
        
        functor_name := ValueGlobal( NameOfFunctor( Functor ) );
        
        c := arg[1];
        
        if c < 0 then
            Error( "the negative ", c, ". right satellite is not defined\n" );
        fi;
        
        d := Resolution( arg[p + 1], c - 1 );
        
        if c = 0 then
            mu := TheZeroMorphism( arg[p + 1] );
        else
            if c = 1 then
                d_c_1 := CokernelEpi( CertainMorphism( d, 1 ) );
            else
                d_c_1 := CertainMorphism( d, c - 1 );
            fi;
            
            mu := KernelEmb( d_c_1 );
        fi;
        
        ar := Concatenation( arg{[ 2 .. p ]}, [ mu ], arg{[ p + 2 .. Length( arg ) ]} );
        
        F_mu := CallFuncList( functor_name, ar );
        
        return Cokernel( F_mu );
        
    end;
    
    _Functor_OnMorphisms :=
      function( arg )
        local functor_name, c, d, d_c_1, mu, ar;
        
        functor_name := ValueGlobal( NameOfFunctor( Functor ) );
        
        c := arg[1];
        
        if c < 0 then
            Error( "the negative ", c, ". right satellite is not defined\n" );
        fi;
        
        d := Resolution( arg[p + 1], c - 1 );
        
        if IsHomalgMap( arg[p + 1] ) then
            if c = 0 then
                mu := arg[p + 1];
            else
                d_c_1 := CertainMorphismAsKernelSquare( d, c - 1 );
                mu := Kernel( d_c_1 );
            fi;
        else
	    ## the following is not really mu but Source( mu ):
            if c = 0 then
                mu := arg[p + 1];
            else
                if c = 1 then
                    mu := Kernel( CokernelEpi( CertainMorphism( d, 1 ) ) );
                else
                    mu := Kernel( CertainMorphism( d, c - 1 ) );
                fi;
            fi;
        fi;
        
        ar := Concatenation( arg{[ 2 .. p ]}, [ mu ], arg{[ p + 2 .. Length( arg ) ]} );
        
        return CallFuncList( functor_name, ar );
        
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
    
    data := List( [ 1 .. m ], i -> [ String( i ), Functor!.( i ) ] );
    
    data := Concatenation(
                    [ [ "name", name ], [ "number_of_arguments", m ] ],
                    [ [ "0", z ] ],
                    data,
                    [ [ "OnObjects", _Functor_OnObjects ] ],
                    [ [ "OnMorphisms", _Functor_OnMorphisms ] ] );
    
    SF := CallFuncList( CreateHomalgFunctor, data );
    
    if m > 1 then
        SF!.ContainerForWeakPointersOnComputedModules :=
          ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );
        SF!.ContainerForWeakPointersOnComputedMorphisms :=
          ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );
    fi;
    
    InstallFunctorOnObjects( SF );
    InstallFunctorOnMorphisms( SF );
    InstallFunctorOnComplexes( SF );
    InstallFunctorOnChainMaps( SF );
    
    return SF;
    
end );

##
InstallMethod( LeftSatelliteOfFunctor,
        "for homalg functors",
        [ IsHomalgFunctorRep, IsString, IsPosInt ],
        
  function( Functor, name, p )
    local _Functor_OnObjects, _Functor_OnMorphisms, m, z, data, SF;
    
    if IsCovariantFunctor( Functor, p ) <> true then
        Error( "the functor does not seem to be covariant in its ", p, ". argument\n" );
    fi;
    
    _Functor_OnObjects :=
      function( arg )
        local functor_name, c, d, d_c_1, mu, ar, F_mu;
        
        functor_name := ValueGlobal( NameOfFunctor( Functor ) );
        
        c := arg[1];
        
        if c < 0 then
            Error( "the negative ", c, ". left satellite is not defined\n" );
        fi;
        
        d := Resolution( arg[p + 1], c - 1 );
        
        if c = 0 then
            mu := TheZeroMorphism( arg[p + 1] );
        else
            if c = 1 then
                d_c_1 := CokernelEpi( CertainMorphism( d, 1 ) );
            else
                d_c_1 := CertainMorphism( d, c - 1 );
            fi;
            
            mu := KernelEmb( d_c_1 );
        fi;
        
        ar := Concatenation( arg{[ 2 .. p ]}, [ mu ], arg{[ p + 2 .. Length( arg ) ]} );
        
        F_mu := CallFuncList( functor_name, ar );
        
        return Kernel( F_mu );
        
    end;
    
    _Functor_OnMorphisms :=
      function( arg )
        local functor_name, c, d, d_c_1, mu, ar;
        
        functor_name := ValueGlobal( NameOfFunctor( Functor ) );
        
        c := arg[1];
        
        if c < 0 then
            Error( "the negative ", c, ". right satellite is not defined\n" );
        fi;
        
        d := Resolution( arg[p + 1], c - 1 );
        
        if IsHomalgMap( arg[p + 1] ) then
            if c = 0 then
                mu := arg[p + 1];
            else
                d_c_1 := CertainMorphismAsKernelSquare( d, c - 1 );
                mu := Kernel( d_c_1 );
            fi;
        else
	    ## the following is not really mu but Source( mu ):
            if c = 0 then
                mu := arg[p + 1];
            else
                if c = 1 then
                    mu := Kernel( CokernelEpi( CertainMorphism( d, 1 ) ) );
                else
                    mu := Kernel( CertainMorphism( d, c - 1 ) );
                fi;
            fi;
        fi;
        
        mu := Kernel( d_c_1 );
        
        ar := Concatenation( arg{[ 2 .. p ]}, [ mu ], arg{[ p + 2 .. Length( arg ) ]} );
        
        return CallFuncList( functor_name, ar );
        
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
    
    data := List( [ 1 .. m ], i -> [ String( i ), Functor!.( i ) ] );
    
    data := Concatenation(
                    [ [ "name", name ], [ "number_of_arguments", m ] ],
                    [ [ "0", z ] ],
                    data,
                    [ [ "OnObjects", _Functor_OnObjects ] ],
                    [ [ "OnMorphisms", _Functor_OnMorphisms ] ] );
    
    SF := CallFuncList( CreateHomalgFunctor, data );
    
    if m > 1 then
        SF!.ContainerForWeakPointersOnComputedModules :=
          ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );
        SF!.ContainerForWeakPointersOnComputedMorphisms :=
          ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );
    fi;
    
    InstallFunctorOnObjects( SF );
    InstallFunctorOnMorphisms( SF );
    InstallFunctorOnComplexes( SF );
    InstallFunctorOnChainMaps( SF );
    
    return SF;
    
end );

####################################
#
# constructor functions and methods:
#
####################################

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
    
    return functor;
    
end );


####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( ViewObj,
        "for homalg functors",
        [ IsHomalgFunctorRep ],
        
  function( o )
    local functor_name;
    
    functor_name := NameOfFunctor( o );
    
    if functor_name <> fail then
        Print( "<The functor ", functor_name, ">" );
    else
        Print( "<A functor for homalg>" );
    fi;
    
end );

InstallMethod( Display,
        "for homalg functors",
        [ IsHomalgFunctorRep ],
        
  function( o )
    
    Print( NameOfFunctor( o ), "\n" );
    
end );

InstallMethod( ViewObj,
        "for containers of weak pointers on homalg external rings",
        [ IsContainerForWeakPointersOnComputedValuesOfFunctorRep ],
        
  function( o )
    local del;
    
    del := Length( o!.deleted );
    
    Print( "<A container of weak pointers on computed values of the functor : active = ", o!.counter - del, ", deleted = ", del, ">" );
    
end );

InstallMethod( Display,
        "for containers of weak pointers on homalg external rings",
        [ IsContainerForWeakPointersOnComputedValuesOfFunctorRep ],
        
  function( o )
    local weak_pointers;
    
    weak_pointers := o!.weak_pointers;
    
    Print( List( [ 1 .. LengthWPObj( weak_pointers ) ], function( i ) if IsBoundElmWPObj( weak_pointers, i ) then return i; else return 0; fi; end ), "\n" );
    
end );

