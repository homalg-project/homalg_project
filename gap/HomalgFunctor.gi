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

# a new representation for the category IsHomalgFunctor:
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
InstallMethod( FunctorMap,
        "for homalg morphisms",
        [ IsHomalgFunctorRep, IsMorphismOfFinitelyGeneratedModulesRep, IsList ],
        
  function( Functor, phi, fixed_arguments_of_multi_functor )
    local container, weak_pointers, a, deleted, functor_name,
          number_of_arguments, arg_positions, S, T, pos,
          arg_before_pos, arg_behind_pos, arg_all, l, i, phi_rest_mor, arg_old,
          b, j, arg_source, arg_target, F_source, F_target, arg_phi, hull_phi,
          emb_source, emb_target, mor;
    
    if not fixed_arguments_of_multi_functor = [ ]
       and not ( ForAll( fixed_arguments_of_multi_functor, a -> IsList( a ) and Length( a ) = 2 and IsPosInt( a[1] ) ) ) then
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
    
    arg_positions := List( fixed_arguments_of_multi_functor, a -> a[1] );
    
    if Length( arg_positions ) <> number_of_arguments - 1 then
        Error( "the number of fixed arguments provided for the functor must be one less than the total number\n" );
    elif not IsDuplicateFree( arg_positions ) then
        Error( "the provided list of positions is not duplicate free: ", arg_positions, "\n" );
    elif arg_positions <> [ ] and Maximum( arg_positions ) > number_of_arguments then
        Error( "the list of positions must be a subset of [ 1 .. ", number_of_arguments, " ], but received: :",  arg_positions, "\n" );
    fi;
    
    S := Source( phi );
    T := Target( phi );
    
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
                    b := true;
                    for j in [ 1 .. l ] do
                        if not IsIdenticalObj( arg_old[j], arg_all[j] ) then
                            b := false;
                            break;
                        fi;
                    od;
                    if b then
                        return phi_rest_mor[2];
                    fi;
                fi;
            fi;
        od;
    fi;
    
    if IsBound( Functor!.( pos ) ) and Functor!.( pos )[1] = "covariant" then
        arg_source := Concatenation( arg_before_pos, [ S ], arg_behind_pos );
        arg_target := Concatenation( arg_before_pos, [ T ], arg_behind_pos );
    elif IsBound( Functor!.( pos ) ) and Functor!.( pos )[1] = "contravariant" then
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
	
        hull_phi :=
          HomalgMorphism( hull_phi, Target( emb_source ), Target( emb_target ) );
    else
        hull_phi := phi;
    fi;
    
    mor := CompleteImSq( emb_source, hull_phi, emb_target );
    
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
        [ IsHomalgFunctorRep, IsMorphismOfFinitelyGeneratedModulesRep ],
        
  function( Functor, phi )
    
    return FunctorMap( Functor, phi, [ ] );
    
end );

##
InstallMethod( InstallFunctorOnObjects,
        "for homalg functors",
        [ IsHomalgFunctorRep ],
        
  function( Functor )
    local functor_name, number_of_arguments, natural_transformation,
          filter_obj, filter1_obj, filter2_obj;
    
    functor_name := ValueGlobal( NameOfFunctor( Functor ) );
        
    number_of_arguments := MultiplicityOfFunctor( Functor );
    
    if number_of_arguments = 1 then
        
        filter_obj := Functor!.1[2];
        
        if IsFilter( filter_obj ) then
            
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
                
                return Functor!.OnObjects( obj );
                
            end );
            
        else
            
            Error( "wrong syntax: ", filter_obj, "\n" );
            
        fi;
        
    elif number_of_arguments = 2 then
        
        filter1_obj := Functor!.1[2];
        filter2_obj := Functor!.2[2];
        
        if IsFilter( filter1_obj ) and IsFilter( filter2_obj ) then
            
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
                    
                    if IsLeft( o1 ) then
                        obj2 := AsLeftModule( o2 );
                    else
                        obj2 := AsRightModule( o2 );
                    fi;
                elif IsHomalgRing( o1 ) and IsHomalgModule( o2 ) then
                    obj2 := o2;
                    
                    if IsLeft( o2 ) then
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
                
                return Functor!.OnObjects( obj1, obj2 );
                
            end );
            
            InstallOtherMethod( functor_name,
                    "for homalg modules",
                    [ filter1_obj ],
              function( o )
                local R;
                
                if IsHomalgRing( o ) then
                    ## I personally prefer the row convention and hence left modules:
                    R := AsLeftModule( o );
                else
                    R := HomalgRing( o );
                    if IsLeft( o ) then
                        R := AsLeftModule( R );
                    else
                        R := AsRightModule( R );
                    fi;
                fi;
                
                return Functor!.OnObjects( o, R  );
                
            end );
            
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
          filter1_obj, filter1_mor, filter2_obj, filter2_mor;
    
    functor_name := ValueGlobal( NameOfFunctor( Functor ) );
        
    number_of_arguments := MultiplicityOfFunctor( Functor );
    
    if number_of_arguments = 1 then
        
        filter_mor := Functor!.1[3];
        
        if IsFilter( filter_mor ) then
            
            InstallOtherMethod( functor_name,
                    "for homalg morphisms",
                    [ filter_mor ],
              function( m )
                
                return FunctorMap( Functor, m );
                
            end );
            
        else
            
            Error( "wrong syntax: ", filter_mor, "\n" );
            
        fi;
        
    elif number_of_arguments = 2 then
        
        filter1_obj := Functor!.1[2];
        filter1_mor := Functor!.1[3];
        
        filter2_obj := Functor!.2[2];
        filter2_mor := Functor!.2[3];
        
        if IsFilter( filter1_mor ) and IsFilter( filter2_mor ) then
            
            InstallOtherMethod( functor_name,
                    "for homalg morphisms",
                    [ filter1_mor ],
              function( m )
                local R;
                
                R := HomalgRing( m );
                
                if IsLeft( m ) then
                    R := AsLeftModule( R );
                else
                    R := AsRightModule( R );
                fi;
                
                return FunctorMap( Functor, m, [ [ 2, R ] ] );
                
            end );
            
            InstallOtherMethod( functor_name,
                    "for homalg morphisms",
                    [ filter1_mor, filter2_obj ],
              function( m, o )
                local obj;
                
                if IsHomalgModule( o ) then	## the most probable case
                    obj := o;
                elif IsHomalgRing( o ) then
                    if IsLeft( m ) then
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
                    if IsLeft( m ) then
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
            
        else
            
            Error( "wrong syntax: ", filter1_mor, filter2_mor, "\n" );
            
        fi;
        
    fi;
    
end );

InstallGlobalFunction( HelperToInstallUnivariateFunctorOnComplexes,
  function( functor_name, filter_cpx, complex_or_cocomplex, i )
    
    InstallOtherMethod( functor_name,
            "for homalg complexes",
            [ filter_cpx ],	## complexes
      function( c )
        local indices, l, morphisms, Fc, m;
        
        indices := ModuleIndicesOfComplex( c );
        
        l := Length( indices );
        
        if l = 1 then
            Fc := complex_or_cocomplex( functor_name( CertainModuleOfComplex( c, indices[1] ) ), indices[1] );
        else
            morphisms := MorphismsOfComplex( c );
            Fc := complex_or_cocomplex( functor_name( morphisms[1] ), indices[i] );
            for m in morphisms{[ 2 .. l - 1 ]} do
                Add( Fc, functor_name( m ) );
            od;
        fi;
        
        return Fc;
        
    end );
    
end );

InstallGlobalFunction( HelperToInstallBivariateFunctorOnComplexes,
  function( functor_name, filter1_cpx, filter2_cpx, filter1_obj, filter2_obj, complex_or_cocomplex1, complex_or_cocomplex2, i1, i2 )
    
    InstallOtherMethod( functor_name,
            "for homalg morphisms",
            [ filter1_cpx ],
      function( c )
        local R, indices, l, morphisms, Fc, m;
        
        R := HomalgRing( c );
        
        if IsLeft( c ) then
            R := AsLeftModule( R );
        else
            R := AsRightModule( R );
        fi;
        
        indices := ModuleIndicesOfComplex( c );
        
        l := Length( indices );
        
        if l = 1 then
            Fc := complex_or_cocomplex1( functor_name( CertainModuleOfComplex( c, indices[1] ), R ), indices[1] );
        else
            morphisms := MorphismsOfComplex( c );
            Fc := complex_or_cocomplex1( functor_name( morphisms[1], R ), indices[i1] );
            for m in morphisms{[ 2 .. l - 1 ]} do
                Add( Fc, functor_name( m, R ) );
            od;
        fi;
        
        return Fc;
        
    end );
    
    InstallOtherMethod( functor_name,
            "for homalg morphisms",
            [ filter1_cpx, filter2_obj ],
      function( c, o )
        local obj, indices, l, morphisms, Fc, m;
        
        if IsHomalgModule( o ) then	## the most probable case
            obj := o;
        elif IsHomalgRing( o ) then
            if IsLeft( c ) then
                obj := AsLeftModule( o );
            else
                obj := AsRightModule( o );
            fi;
        else
            ## the default:
            obj := o;
        fi;
                
        indices := ModuleIndicesOfComplex( c );
        
        l := Length( indices );
        
        if l = 1 then
            Fc := complex_or_cocomplex1( functor_name( CertainModuleOfComplex( c, indices[1] ), obj ), indices[1] );
        else
            morphisms := MorphismsOfComplex( c );
            Fc := complex_or_cocomplex1( functor_name( morphisms[1], obj ), indices[i1] );
            for m in morphisms{[ 2 .. l - 1 ]} do
                Add( Fc, functor_name( m, obj ) );
            od;
        fi;
        
        return Fc;
        
    end );
    
    InstallOtherMethod( functor_name,
            "for homalg morphisms",
            [ filter1_obj, filter2_cpx ],
      function( o, c )
        local obj, indices, l, morphisms, Fc, m;
        
        if IsHomalgModule( o ) then	## the most probable case
            obj := o;
        elif IsHomalgRing( o ) then
            if IsLeft( c ) then
                obj := AsLeftModule( o );
            else
                obj := AsRightModule( o );
            fi;
        else
            ## the default:
            obj := o;
        fi;
        
        indices := ModuleIndicesOfComplex( c );
        
        l := Length( indices );
        
        if l = 1 then
            Fc := complex_or_cocomplex2( functor_name( obj, CertainModuleOfComplex( c, indices[1] ) ), indices[1] );
        else
            morphisms := MorphismsOfComplex( c );
            Fc := complex_or_cocomplex2( functor_name( obj, morphisms[1] ), indices[i2] );
            for m in morphisms{[ 2 .. l - 1 ]} do
                Add( Fc, functor_name( obj, m ) );
            od;
        fi;
        
        return Fc;
        
    end );
    
end );

##
InstallMethod( InstallFunctorOnComplexes,
        "for homalg functors",
        [ IsHomalgFunctorRep ],
        
  function( Functor )
    local functor_name, number_of_arguments, filter_cpx,
          filter1_obj, filter1_cpx, filter2_obj, filter2_cpx,
          complex, cocomplex, complex_complex, complex_cocomplex,
	  cocomplex_complex, cocomplex_cocomplex;
    
    functor_name := ValueGlobal( NameOfFunctor( Functor ) );
        
    number_of_arguments := MultiplicityOfFunctor( Functor );
    
    if number_of_arguments = 1 then
        
        filter_cpx := Functor!.1[4];
        
        if IsList( filter_cpx ) and Length( filter_cpx ) = 2 and ForAll( filter_cpx, IsFilter ) then
            
            if Functor!.1[1] = "covariant" then
                complex := [ functor_name, filter_cpx[1], HomalgComplex, 2 ];
                cocomplex := [ functor_name, filter_cpx[2], HomalgCocomplex, 1 ];
            else
                complex := [ functor_name, filter_cpx[1], HomalgCocomplex, 1 ];
                cocomplex := [ functor_name, filter_cpx[2], HomalgComplex, 2  ];
            fi;
            
            CallFuncList( HelperToInstallUnivariateFunctorOnComplexes, complex );
            CallFuncList( HelperToInstallUnivariateFunctorOnComplexes, cocomplex );
            
        else
            
            Error( "wrong syntax: ", filter_cpx, "\n" );
            
        fi;
        
    elif number_of_arguments = 2 then
        
        filter1_obj := Functor!.1[2];
        filter1_cpx := Functor!.1[4];
        
        filter2_obj := Functor!.2[2];
        filter2_cpx := Functor!.2[4];
        
        if IsList( filter1_cpx ) and Length( filter1_cpx ) = 2 and ForAll( filter1_cpx, IsFilter )
            and IsList( filter2_cpx ) and Length( filter2_cpx ) = 2 and ForAll( filter2_cpx, IsFilter ) then
            
            if Functor!.1[1] = "covariant" and Functor!.2[1] = "covariant" then
                complex_complex := [ functor_name, filter1_cpx[1], filter2_cpx[1], filter1_obj, filter2_obj, HomalgComplex, HomalgComplex, 2, 2 ];
                complex_cocomplex := [ functor_name, filter1_cpx[1], filter2_cpx[2], filter1_obj, filter2_obj, HomalgComplex, HomalgCocomplex, 2, 1 ];
                cocomplex_complex := [ functor_name, filter1_cpx[2], filter2_cpx[1], filter1_obj, filter2_obj, HomalgCocomplex, HomalgComplex, 1, 2 ];
                cocomplex_cocomplex := [ functor_name, filter1_cpx[2], filter2_cpx[2], filter1_obj, filter2_obj, HomalgCocomplex, HomalgCocomplex, 1, 1 ];
            elif Functor!.1[1] = "covariant" then
                complex_complex := [ functor_name, filter1_cpx[1], filter2_cpx[1], filter1_obj, filter2_obj, HomalgComplex, HomalgCocomplex, 2, 1 ];
                complex_cocomplex := [ functor_name, filter1_cpx[1], filter2_cpx[2], filter1_obj, filter2_obj, HomalgComplex, HomalgComplex, 2, 2 ];
                cocomplex_complex := [ functor_name, filter1_cpx[2], filter2_cpx[1], filter1_obj, filter2_obj, HomalgCocomplex, HomalgCocomplex, 1, 1 ];
                cocomplex_cocomplex := [ functor_name, filter1_cpx[2], filter2_cpx[2], filter1_obj, filter2_obj, HomalgCocomplex, HomalgComplex, 1, 2 ];
            elif Functor!.2[1] = "covariant" then
                complex_complex := [ functor_name, filter1_cpx[1], filter2_cpx[1], filter1_obj, filter2_obj, HomalgCocomplex, HomalgComplex, 1, 2 ];
                complex_cocomplex := [ functor_name, filter1_cpx[1], filter2_cpx[2], filter1_obj, filter2_obj, HomalgCocomplex, HomalgCocomplex, 1, 1 ];
                cocomplex_complex := [ functor_name, filter1_cpx[2], filter2_cpx[1], filter1_obj, filter2_obj, HomalgComplex, HomalgComplex, 2, 2 ];
                cocomplex_cocomplex := [ functor_name, filter1_cpx[2], filter2_cpx[2], filter1_obj, filter2_obj, HomalgComplex, HomalgCocomplex, 2, 1 ];
            else
                complex_complex := [ functor_name, filter1_cpx[1], filter2_cpx[1], filter1_obj, filter2_obj, HomalgCocomplex, HomalgCocomplex, 1, 1 ];
                complex_cocomplex := [ functor_name, filter1_cpx[1], filter2_cpx[2], filter1_obj, filter2_obj, HomalgCocomplex, HomalgComplex, 1, 2 ];
                cocomplex_complex := [ functor_name, filter1_cpx[2], filter2_cpx[1], filter1_obj, filter2_obj, HomalgComplex, HomalgCocomplex, 2, 1 ];
                cocomplex_cocomplex := [ functor_name, filter1_cpx[2], filter2_cpx[2], filter1_obj, filter2_obj, HomalgComplex, HomalgComplex, 2, 2 ];
            fi;
            
            CallFuncList( HelperToInstallBivariateFunctorOnComplexes, complex_complex );
            CallFuncList( HelperToInstallBivariateFunctorOnComplexes, complex_cocomplex );
            CallFuncList( HelperToInstallBivariateFunctorOnComplexes, cocomplex_complex );
            CallFuncList( HelperToInstallBivariateFunctorOnComplexes, cocomplex_cocomplex );
            
        else
            
            Error( "wrong syntax: ", filter1_cpx, filter2_cpx, "\n" );
            
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
    
    #InstallFunctorOnChainMaps( Functor );
    
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

