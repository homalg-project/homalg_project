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
InstallMethod( FunctorMap,
        "for homalg morphisms",
        [ IsHomalgFunctorRep, IsMorphismOfFinitelyGeneratedModulesRep, IsList ],
        
  function( Functor, phi, fixed_arguments_of_multi_functor )
    local name, number_of_arguments, arg_positions, S, T, pos, arg_before_pos, arg_behind_pos,
          arg_source, arg_target, F_source, F_target, arg_phi, hull_phi, emb_source, emb_target;
    
    if IsBound( Functor!.name ) then
        name := Functor!.name;
        if not IsOperation( ValueGlobal( name ) ) and not IsFunction( ValueGlobal( name ) ) then
            Error( "the functor ", name, " neither points to an operation nor a function\n" );
        fi;
    else
        Error( "the provided functor is nameless\n" );
    fi;
        
    if not fixed_arguments_of_multi_functor = [ ]
       and not ( ForAll( fixed_arguments_of_multi_functor, a -> IsList( a ) and Length( a ) = 2 and IsPosInt( a[1] ) ) ) then
        Error( "the last argument has a wrong syntax\n" );
    fi;
    
    if IsBound( Functor!.number_of_arguments ) then
        number_of_arguments := Functor!.number_of_arguments;
    else
        number_of_arguments := 1;
    fi;
    
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
    
    if IsBound( Functor!.( pos ) ) and Functor!.( pos ) = "covariant" then
        arg_source := Concatenation( arg_before_pos, [ S ], arg_behind_pos );
        arg_target := Concatenation( arg_before_pos, [ T ], arg_behind_pos );
    elif IsBound( Functor!.( pos ) ) and Functor!.( pos ) = "contravariant" then
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
