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
    local name;
    
    if IsBound( Functor!.name ) then
        name := Functor!.name;
        if not IsOperation( ValueGlobal( name ) ) and not IsFunction( ValueGlobal( name ) ) then
            Error( "the functor ", name, " neither points to an operation nor a function\n" );
        fi;
    else
        Error( "the provided functor is nameless\n" );
    fi;
    
    return name;
    
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
    local name, number_of_arguments, arg_positions, S, T, pos, arg_before_pos, arg_behind_pos,
          arg_source, arg_target, F_source, F_target, arg_phi, hull_phi, emb_source, emb_target;
    
    if not fixed_arguments_of_multi_functor = [ ]
       and not ( ForAll( fixed_arguments_of_multi_functor, a -> IsList( a ) and Length( a ) = 2 and IsPosInt( a[1] ) ) ) then
        Error( "the last argument has a wrong syntax\n" );
    fi;
    
    name := NameOfFunctor( Functor );
        
    number_of_arguments := MultiplicityOfFunctor( Functor );
    
    arg_positions := List( fixed_arguments_of_multi_functor, a -> a[1] );
    
    if Length( arg_positions ) <> number_of_arguments - 1 then
        Error( "the number of fixed arguments provided for the functor must be one less than the total number\n" );
    elif not IsDuplicateFree( arg_positions ) then
        Error( "the provided list of positions is not duplicate free: ", arg_positions, "\n" );
    elif Maximum( arg_positions ) > number_of_arguments then
        Error( "the list of positions must be a subset of [ 1 .. ", number_of_arguments, " ], but received: :",  arg_positions, "\n" );
    fi;
    
    S := SourceOfMorphism( phi );
    T := TargetOfMorphism( phi );
    
    pos := Filtered( [ 1 .. number_of_arguments ], a -> not a in arg_positions )[1];
    
    arg_positions := fixed_arguments_of_multi_functor;
    
    Sort( arg_positions, function( v, w ) return v[1] < w[1]; end );
    
    arg_before_pos := List( arg_positions{[ 1 .. pos - 1 ]}, a -> a[2] );
    arg_behind_pos := List( arg_positions{[ pos .. number_of_arguments - 1 ]}, a -> a[2] );
    
    if IsBound( Functor!.( pos ) ) and Functor!.( pos )[1] = "covariant" then
        arg_source := Concatenation( arg_before_pos, [ S ], arg_behind_pos );
        arg_target := Concatenation( arg_before_pos, [ T ], arg_behind_pos );
    elif IsBound( Functor!.( pos ) ) and Functor!.( pos )[1] = "contravariant" then
        arg_source := Concatenation( arg_before_pos, [ T ], arg_behind_pos );
        arg_target := Concatenation( arg_before_pos, [ S ], arg_behind_pos );
    else
        Error( "the functor ", name, " must be either co- or contravriant in its argument number ", pos, "\n" );
    fi;
    
    F_source := CallFuncList( ValueGlobal( name ), arg_source );
    F_target := CallFuncList( ValueGlobal( name ), arg_target );
    
    if IsBound( Functor!.OnMorphisms ) then
        arg_phi := Concatenation( arg_before_pos, [ phi ], arg_behind_pos );
        hull_phi := CallFuncList( Functor!.OnMorphisms, arg_phi );
    else
        hull_phi := phi;
    fi;
    
    emb_source := F_source!.NaturalEmbedding;
    emb_target := F_target!.NaturalEmbedding;
    
    hull_phi :=
      HomalgMorphism( hull_phi, TargetOfMorphism( emb_source ), TargetOfMorphism( emb_target ) );
    
    return CompleteImSq( emb_source, hull_phi, emb_target );
    
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
    local name, number_of_arguments, natural_transformation,
          filter_obj, filter1_obj, filter2_obj;
    
    name := ValueGlobal( NameOfFunctor( Functor ) );
        
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
                    local obj;
                    
                    obj := name( o );			## this sets the attribute named "natural_transformation"
                    
                    return natural_transformation( o );	## not an infinite loop because of the side effect of the above line
                    
                end );
                
            fi;
            
            InstallOtherMethod( name,
                    "for homalg modules",
                    [ filter_obj ],
              function( o )
                
                return Functor!.OnObjects( o );
                
            end );
            
        elif IsList( filter_obj ) and Length( filter_obj ) = 2 and ForAll( filter_obj, IsFilter ) and filter_obj[2] = IsHomalgRing then
            
            InstallOtherMethod( name,
                    "for homalg modules",
                    [ filter_obj[1] ],
              function( o )
                
                return Functor!.OnObjects( o );
                
            end );
            
            InstallOtherMethod( name,
                    "for homalg modules",
                    [ IsHomalgRing ],
              function( R )
                
                return Functor!.OnObjects( AsLeftModule( R ) );
                
            end );
            
        else
            
            Error( "wrong syntax: ", filter_obj, "\n" );
            
        fi;
        
    elif number_of_arguments = 2 then
        
        filter1_obj := Functor!.1[2];
        filter2_obj := Functor!.2[2];
        
        if IsFilter( filter1_obj ) and IsFilter( filter2_obj ) then
            
            InstallOtherMethod( name,
                    "for homalg modules",
                    [ filter1_obj, filter2_obj ],
              function( o )
                
                return Functor!.OnObjects( o );
                
            end );
            
        elif IsList( filter1_obj ) and Length( filter1_obj ) = 2 and ForAll( filter1_obj, IsFilter ) and filter1_obj[2] = IsHomalgRing
          and IsList( filter2_obj ) and Length( filter2_obj ) = 2 and ForAll( filter2_obj, IsFilter ) and filter2_obj[2] = IsHomalgRing then
            
            InstallOtherMethod( name,
                    "for homalg modules",
                    [ filter1_obj[1], filter2_obj[1] ],
              function( o1, o2 )
                
                return Functor!.OnObjects( o1, o2 );
                
            end );
            
            InstallOtherMethod( name,
                    "for homalg modules",
                    [ filter1_obj[1], IsHomalgRing ],
              function( o1, R )
                local o2;
                
                if IsLeft( o1 ) then
                    o2 := AsLeftModule( R );
                else
                    o2 := AsRightModule( R );
                fi;
                
                return Functor!.OnObjects( o1, o2  );
                
            end );
            
            InstallOtherMethod( name,
                    "for homalg modules",
                    [ filter1_obj[1] ],
              function( o1 )
                local R, o2;
                
                R := HomalgRing( o1 );
                
                if IsLeft( o1 ) then
                    o2 := AsLeftModule( R );
                else
                    o2 := AsRightModule( R );
                fi;
                
                return Functor!.OnObjects( o1, o2  );
                
            end );
            
            InstallOtherMethod( name,
                    "for homalg modules",
                    [ IsHomalgRing ],
              function( R )
                local o1, o2;
                
                ## I personally prefer the row convention and hence left modules:
                o1 := AsLeftModule( R );
                o2 := AsLeftModule( R );
                
                return Functor!.OnObjects( o1, o2  );
                
            end );
            
            InstallOtherMethod( name,
                    "for homalg modules",
                    [ IsHomalgRing, filter2_obj[1] ],
              function( R, o2 )
                local o1;
                
                if IsLeft( o2 ) then
                    o1 := AsLeftModule( R );
                else
                    o1 := AsRightModule( R );
                fi;
                
                return Functor!.OnObjects( o1, o2  );
                
            end );
            
            InstallOtherMethod( name,
                    "for homalg modules",
                    [ IsHomalgRing, IsHomalgRing ],
              function( R1, R2 )
                local o1, o2;
                
                ## I personally prefer the row convention and hence left modules:
                o1 := AsLeftModule( R1 );
                o2 := AsLeftModule( R2 );
                
                return Functor!.OnObjects( o1, o2  );
                
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
    local name, number_of_arguments, filter_mor,
          filter1_obj, filter1_mor, filter2_obj, filter2_mor;
    
    name := ValueGlobal( NameOfFunctor( Functor ) );
        
    number_of_arguments := MultiplicityOfFunctor( Functor );
    
    if number_of_arguments = 1 then
        
        filter_mor := Functor!.1[3];
        
        if IsFilter( filter_mor ) then
            
            InstallOtherMethod( name,
                    "for homalg morphisms",
                    [ filter_mor ],
              function( o )
                
                return Functor!.OnObjects( o );
                
            end );
            
        else
            
            Error( "wrong syntax: ", filter_mor, "\n" );
            
        fi;
        
    elif number_of_arguments = 2 then
        
        filter1_obj := Functor!.1[2];
        filter1_mor := Functor!.1[3];
        
        filter2_obj := Functor!.2[2];
        filter2_mor := Functor!.2[3];
        
        if IsFilter( filter1_obj ) and IsFilter( filter2_obj ) then
            
            InstallOtherMethod( name,
                    "for homalg modules",
                    [ filter1_obj, filter2_mor ],
              function( m, o )
                
                return FunctorMap( Functor, m, [ [ 2, o ] ] );
                
            end );
            
            InstallOtherMethod( name,
                    "for homalg modules",
                    [ filter1_mor, filter2_obj ],
              function( o, m )
                
                return FunctorMap( Functor, m, [ [ 1, o ] ] );
                
            end );
            
        elif IsList( filter1_obj ) and Length( filter1_obj ) = 2 and ForAll( filter1_obj, IsFilter ) and filter1_obj[2] = IsHomalgRing
          and IsList( filter2_obj ) and Length( filter2_obj ) = 2 and ForAll( filter2_obj, IsFilter ) and filter2_obj[2] = IsHomalgRing then
            
            InstallOtherMethod( name,
                    "for homalg modules",
                    [ filter1_mor, filter2_obj[1] ],
              function( m, o )
                
                return FunctorMap( Functor, m, [ [ 2, o ] ] );
                
            end );
            
            InstallOtherMethod( name,
                    "for homalg modules",
                    [ filter1_mor, IsHomalgRing ],
              function( m, R )
                local o;
                
                if IsLeft( m ) then
                    o := AsLeftModule( R );
                else
                    o := AsRightModule( R );
                fi;
                
                return FunctorMap( Functor, m, [ [ 2, o ] ] );
                
            end );
            
            InstallOtherMethod( name,
                    "for homalg modules",
                    [ filter1_mor ],
              function( m )
                local R, o;
                
                R := HomalgRing( m );
                
                if IsLeft( m ) then
                    o := AsLeftModule( R );
                else
                    o := AsRightModule( R );
                fi;
                
                return FunctorMap( Functor, m, [ [ 2, o ] ] );
                
            end );
            
            InstallOtherMethod( name,
                    "for homalg modules",
                    [ filter1_obj[1], filter2_mor ],
              function( o, m )
                
                return FunctorMap( Functor, m, [ [ 1, o ] ] );
                
            end );
            
            InstallOtherMethod( name,
                    "for homalg modules",
                    [ IsHomalgRing, filter2_mor ],
              function( R, m )
                local o;
                
                if IsLeft( m ) then
                    o := AsLeftModule( R );
                else
                    o := AsRightModule( R );
                fi;
                
                return FunctorMap( Functor, m, [ [ 1, o ] ] );
                
            end );
            
        else
            
            Error( "wrong syntax: ", filter1_obj, filter2_obj, "\n" );
            
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
    
    #InstallFunctorOnComplexes( Functor );
    
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
    
    Print( "<A functor for homalg>" );
    
end );

InstallMethod( Display,
        "for homalg functors",
        [ IsHomalgFunctorRep ],
        
  function( o )
    
    Print( o!.name );
    
end );
