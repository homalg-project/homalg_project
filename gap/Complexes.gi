#############################################################################
##
##  Complexes.gi                homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations of homalg procedures for complexes.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( DefectOfExactness,
        "for a homalg complexes",
        [ IsComplexOfFinitelyPresentedObjectsRep ],
        
  function( C )
    local display, display_string, on_less_generators, left, indices, l,
          morphisms, T, H, i, S;
    
    if IsBound( C!.DisplayHomology ) and C!.DisplayHomology = true then
        display := true;
    else
        display := false;
    fi;
    
    if IsBound( C!.StringBeforeDisplay ) and IsStringRep( C!.StringBeforeDisplay ) then
        display_string := C!.StringBeforeDisplay;
    else
        display_string := "";
    fi;
    
    if IsBound( C!.HomologyOnLessGenerators ) and C!.HomologyOnLessGenerators = true then
        on_less_generators := true;
    else
        on_less_generators := false;
    fi;
        
    if IsGradedObject( C ) then
        H := C;
    elif IsBound(C!.HomologyGradedObject) then
        H := C!.HomologyGradedObject;
    fi;
    
    if IsBound( H ) then
        if on_less_generators then
            OnLessGenerators( H );
        fi;
        
        if display then
            for i in ObjectsOfComplex( H ) do
                Print( display_string );
                Display( i );
            od;
        fi;
        
        return H;
    fi;
    
    if not IsComplex( C ) then
        Error( "the input is not a complex" );
    fi;
    
    left := IsHomalgLeftObjectOrMorphismOfLeftObjects( C );
    
    indices := MorphismDegreesOfComplex( C );
    
    l := Length(indices);
    
    morphisms := MorphismsOfComplex( C );
    
    if not IsBound( C!.SkipLowestDegreeHomology ) then
        T := Cokernel( morphisms[1] );
        H := HomalgComplex( T, indices[1] - 1 );
    else
        if left then
            T := DefectOfExactness( [ morphisms[2], morphisms[1] ] );
        else
            T := DefectOfExactness( [ morphisms[1], morphisms[2] ] );
        fi;
        H := HomalgComplex( T, indices[1] );
        morphisms := morphisms{[ 2 .. l ]};
        l := l - 1;
    fi;
    
    if on_less_generators then
        OnLessGenerators( T );
    fi;
    
    if display then
        Print( display_string );
        Display( T );
    fi;
    
    for i in [ 1 .. l - 1 ] do
        if left then
            S := DefectOfExactness( [ morphisms[i + 1], morphisms[i] ] );
        else
            S := DefectOfExactness( [ morphisms[i], morphisms[i + 1] ] );
        fi;
        Add( H, HomalgZeroMorphism( S, T ) );
        T := S;
        
        if on_less_generators then
            OnLessGenerators( T );
        fi;
        
        if display then
            Print( display_string );
            Display( T );
        fi;
    od;
    
    if not ( IsBound( C!.SkipHighestDegreeHomology ) and C!.SkipHighestDegreeHomology = true ) then
        S := Kernel( morphisms[l] );
        Add( H, HomalgZeroMorphism( S, T ) );
        
        if on_less_generators then
            OnLessGenerators( S );
        fi;
        
        if display then
            Print( display_string );
            Display( S );
        fi;
    fi;
    
    SetIsGradedObject( H, true );
    
    C!.HomologyGradedObject := H;
    
    return H;
    
end );

##
InstallMethod( DefectOfExactness,
        "for a homalg complexes",
        [ IsCocomplexOfFinitelyPresentedObjectsRep ],
        
  function( C )
    local display, display_string, on_less_generators, left, indices, l,
          morphisms, S, H, i, T;
    
    if IsBound( C!.DisplayCohomology ) and C!.DisplayCohomology = true then
        display := true;
    else
        display := false;
    fi;
    
    if IsBound( C!.CohomologyOnLessGenerators ) and C!.CohomologyOnLessGenerators = true then
        on_less_generators := true;
    else
        on_less_generators := false;
    fi;
        
    if IsBound( C!.StringBeforeDisplay ) and IsStringRep( C!.StringBeforeDisplay ) then
        display_string := C!.StringBeforeDisplay;
    else
        display_string := "";
    fi;
    
    if IsGradedObject( C ) then
        H := C;
    elif IsBound(C!.CohomologyGradedObject) then
        H := C!.CohomologyGradedObject;
    fi;
    
    if IsBound( H ) then
        if on_less_generators then
            OnLessGenerators( H );
        fi;
        
        if display then
            for i in ObjectsOfComplex( H ) do
                Print( display_string );
                Display( i );
            od;
        fi;
        
        return H;
    fi;
    
    if not IsComplex( C ) then
        Error( "the input is not a cocomplex" );
    fi;
    
    left := IsHomalgLeftObjectOrMorphismOfLeftObjects( C );
    
    indices := MorphismDegreesOfComplex( C );
    
    l := Length(indices);
    
    morphisms := MorphismsOfComplex( C );
    
    if not IsBound( C!.SkipLowestDegreeCohomology ) then
        S := Kernel( morphisms[1] );
        H := HomalgCocomplex( S, indices[1] );
    else
        if left then
            S := DefectOfExactness( [ morphisms[1], morphisms[2] ] );
        else
            S := DefectOfExactness( [ morphisms[2], morphisms[1] ] );
        fi;
        H := HomalgCocomplex( S, indices[1] + 1 );
        morphisms := morphisms{[ 2 .. l ]};
        l := l - 1;
    fi;
    
    if on_less_generators then
        OnLessGenerators( S );
    fi;
    
    if display then
        Print( display_string );
        Display( S );
    fi;
    
    for i in [ 1 .. l - 1 ] do
        if left then
            T := DefectOfExactness( [ morphisms[i], morphisms[i + 1] ] );
        else
            T := DefectOfExactness( [ morphisms[i + 1], morphisms[i] ] );
        fi;
        Add( H, HomalgZeroMorphism( S, T ) );
        S := T;
        
        if on_less_generators then
            OnLessGenerators( S );
        fi;
        
        if display then
            Print( display_string );
            Display( S );
        fi;
    od;
    
    if not ( IsBound( C!.SkipHighestDegreeCohomology ) and C!.SkipHighestDegreeCohomology = true ) then
        T := Cokernel( morphisms[l] );
        Add( H, HomalgZeroMorphism( S, T ) );
        
        if on_less_generators then
            OnLessGenerators( T );
        fi;
        
        if display then
            Print( display_string );
            Display( T );
        fi;
    fi;
    
    SetIsGradedObject( H, true );
    
    C!.CohomologyGradedObject := H;
    
    return H;
    
end );

##
InstallMethod( Homology,			### defines: Homology (HomologyModules)
        "for a homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    
    if IsCocomplexOfFinitelyPresentedObjectsRep( C ) then
        Error( "this is a cocomplex: use \033[1mCohomology\033[0m instead\n" );
    fi;
    
    return DefectOfExactness( C );
    
end );

##
InstallMethod( Cohomology,			### defines: Cohomology (CohomologyModules)
        "for a homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    
    if IsComplexOfFinitelyPresentedObjectsRep( C ) then
        Error( "this is a complex: use \033[1mHomology\033[0m instead\n" );
    fi;
    
    return DefectOfExactness( C );
    
end );

