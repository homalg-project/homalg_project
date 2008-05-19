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
InstallMethod( DefectOfHoms,
        "for a homalg complexes",
        [ IsComplexOfFinitelyPresentedModulesRep ],
        
  function( C )
    local indices, l, morphisms, T, left, H, i, S;
    
    if IsGradedObject( C ) then
        return C;
    elif IsBound(C!.HomologyModules) then
        return C!.HomologyModules;
    fi;
    
    if not IsComplex( C ) then
        Error( "the input is not a complex" );
    fi;
    
    indices := MorphismIndicesOfComplex( C );
    
    l := Length(indices);
    
    morphisms := MorphismsOfComplex( C );
    
    T := Cokernel( morphisms[1] );
    
    if IsLeftModule( T ) then
        left := true;
    else
        left := false;
    fi;
    
    H := HomalgComplex( T, indices[1] - 1 );
    
    for i in indices{[ 1 .. l - 1 ]} do
        if left then
            S := DefectOfHoms( [ C!.((i + 1)), C!.(i) ] );
        else
            S := DefectOfHoms( [ C!.(i), C!.((i + 1)) ] );
        fi;
        Add( H, HomalgZeroMorphism( S, T ) );
        T := S;
    od;
    
    S := Kernel( morphisms[l] );
    
    Add( H, HomalgZeroMorphism( S, T ) );
    
    SetIsGradedObject( H, true );
    
    C!.HomologyModules := H;
    
    return H;
    
end );

##
InstallMethod( DefectOfHoms,
        "for a homalg complexes",
        [ IsCocomplexOfFinitelyPresentedModulesRep ],
        
  function( C )
    local indices, l, morphisms, S, left, H, i, T;
    
    if IsGradedObject( C ) then
        return C;
    elif IsBound(C!.CohomologyModules) then
        return C!.CohomologyModules;
    fi;
    
    if not IsComplex( C ) then
        Error( "the input is not a cocomplex" );
    fi;
    
    indices := MorphismIndicesOfComplex( C );
    
    l := Length(indices);
    
    morphisms := MorphismsOfComplex( C );
    
    S := Kernel( morphisms[1] );
    
    if IsLeftModule( S ) then
        left := true;
    else
        left := false;
    fi;
    
    H := HomalgComplex( S, indices[1] );
    
    for i in indices{[ 1 .. l - 1 ]} do
        if left then
            T := DefectOfHoms( [ C!.(i), C!.((i + 1)) ] );
        else
            T := DefectOfHoms( [ C!.((i + 1)), C!.(i) ] );
        fi;
        Add( H, HomalgZeroMorphism( S, T ) );
        S := T;
    od;
    
    T := Cokernel( morphisms[l] );
    
    Add( H, HomalgZeroMorphism( S, T ) );
    
    SetIsGradedObject( H, true );
    
    C!.CohomologyModules := H;
    
    return H;
    
end );

##
InstallMethod( Homology,				### defines: Homology (HomologyModules)
        "for a homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    
    if IsCocomplexOfFinitelyPresentedModulesRep( C ) then
        Error( "this is a cocomplex: use Cohomology instead\n" );
    fi;
    
    return DefectOfHoms( C );
    
end );

##
InstallMethod( Cohomology,				### defines: Cohomology (CohomologyModules)
        "for a homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    
    if IsComplexOfFinitelyPresentedModulesRep( C ) then
        Error( "this is a complex: use Homology instead\n" );
    fi;
    
    return DefectOfHoms( C );
    
end );

