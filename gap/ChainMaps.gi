#############################################################################
##
##  ChainMaps.gi                homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations of homalg procedures for chain maps.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( DefectOfExactness,
        "for a homalg chain maps",
        [ IsChainMapOfFinitelyPresentedObjectsRep, IsInt ],
        
  function( cm, i )
    local degree, degrees, S, source_degrees, T, target_degrees, sq, def;
    
    degree := DegreeOfMorphism( cm );
    
    degrees := DegreesOfChainMap( cm );
    
    S := Source( cm );
    
    source_degrees := ObjectDegreesOfComplex( S );
    
    T := Range( cm );
    
    target_degrees := ObjectDegreesOfComplex( T );
    
    if PositionSet( degrees, i ) = fail then
        Error( "the second argument ", i, " is outside the degree range of the chain map\n" );
    elif HasIsGradedObject( S ) and IsGradedObject( S ) and
      HasIsGradedObject( T ) and IsGradedObject( T ) then
        return CertainMorphism( cm, i );
    elif i = degrees[1] and i = source_degrees[1] and i + degree = target_degrees[1] then
        sq := CertainMorphismAsImageSquare( cm, i );
        def := Cokernel( sq );
    elif i = degrees[Length( degrees )] and i = source_degrees[Length( source_degrees )] and i + degree = target_degrees[Length( target_degrees )] then
        sq := CertainMorphismAsKernelSquare( cm, i );
        def := Kernel( sq );
    elif i <> source_degrees[1] and i + degree <> target_degrees[1] and
      i <> source_degrees[Length( source_degrees )] and i + degree <> target_degrees[Length( target_degrees )] then
        sq := CertainMorphismAsLambekPairOfSquares( cm, i );
        def := DefectOfExactness( sq );
    else
        Error( "the ", i, ". morphism of the chain map is neither at one of the ends nor in the middle of both source and target complexes\n" );
    fi;
    
    return def;		## the output is handled by the methods installed by InstallSpecialFunctorOnMorphisms
    
end );

##
InstallMethod( DefectOfExactness,
        "for a homalg chain maps",
        [ IsCochainMapOfFinitelyPresentedObjectsRep, IsInt ],
        
  function( cm, i )
    local degree, degrees, S, source_degrees, T, target_degrees, sq, def;
    
    degree := DegreeOfMorphism( cm );
    
    degrees := DegreesOfChainMap( cm );
    
    S := Source( cm );
    
    source_degrees := ObjectDegreesOfComplex( S );
    
    T := Range( cm );
    
    target_degrees := ObjectDegreesOfComplex( T );
    
    if PositionSet( degrees, i ) = fail then
        Error( "the second argument ", i, " is outside the degree range of the chain map\n" );
    elif HasIsGradedObject( S ) and IsGradedObject( S ) and
      HasIsGradedObject( T ) and IsGradedObject( T ) then
        return CertainMorphism( cm, i );
    elif i = degrees[1] and i = source_degrees[1] and i + degree = target_degrees[1] then
        sq := CertainMorphismAsKernelSquare( cm, i );
        def := Kernel( sq );
    elif i = degrees[Length( degrees )] and i = source_degrees[Length( source_degrees )] and i + degree = target_degrees[Length( target_degrees )] then
        sq := CertainMorphismAsImageSquare( cm, i );
        def := Cokernel( sq );
    elif i <> source_degrees[1] and i + degree <> target_degrees[1] and
      i <> source_degrees[Length( source_degrees )] and i + degree <> target_degrees[Length( target_degrees )] then
        sq := CertainMorphismAsLambekPairOfSquares( cm, i );
        def := DefectOfExactness( sq );
    else
        Error( "the ", i, ". morphism of the chain map is neither at one of the ends nor in the middle of both source and target complexes\n" );
    fi;
    
    return def;		## the output is handled by the methods installed by InstallSpecialFunctorOnMorphisms
    
end );

##
InstallMethod( Homology,
        "for a homalg chain maps",
        [ IsHomalgChainMap, IsInt ],
        
  function( cm, i )
    
    if IsCochainMapOfFinitelyPresentedObjectsRep( cm ) then
        Error( "this is a cocomplex: use \033[1mCohomology\033[0m instead\n" );
    fi;
    
    return DefectOfExactness( cm, i );
    
end );

##
InstallMethod( Cohomology,
        "for a homalg chain maps",
        [ IsHomalgChainMap, IsInt ],
        
  function( cm, i )
    
    if IsChainMapOfFinitelyPresentedObjectsRep( cm ) then
        Error( "this is a complex: use \033[1mHomology\033[0m instead\n" );
    fi;
    
    return DefectOfExactness( cm, i );
    
end );

##
InstallMethod( DefectOfExactness,
        "for a homalg chain maps",
        [ IsChainMapOfFinitelyPresentedObjectsRep ],
        
  function( cm )
    local degrees, S, T, def, i;
    
    degrees := DegreesOfChainMap( cm );
    
    S := DefectOfExactness( Source( cm ) );
    T := DefectOfExactness( Range( cm ) );
    
    def := HomalgChainMap( DefectOfExactness( cm, degrees[1] ), S, T );
    
    for i in degrees{[ 2 .. Length( degrees ) ]} do
        Add( def, DefectOfExactness( cm, i ) );
    od;
    
    SetIsGradedMorphism( def, true );
    
    return def;
    
end );

##
InstallMethod( DefectOfExactness,
        "for a homalg chain maps",
        [ IsCochainMapOfFinitelyPresentedObjectsRep ],
        
  function( cm )
    local degrees, S, T, def, i;
    
    degrees := DegreesOfChainMap( cm );
    
    S := DefectOfExactness( Source( cm ) );
    T := DefectOfExactness( Range( cm ) );
    
    def := HomalgChainMap( DefectOfExactness( cm, degrees[1] ), S, T );
    
    for i in degrees{[ 2 .. Length( degrees ) ]} do
        Add( def, DefectOfExactness( cm, i ) );
    od;
    
    SetIsGradedMorphism( def, true );
    
    return def;
    
end );

##
InstallMethod( Homology,
        "for a homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( cm )
    
    if IsCochainMapOfFinitelyPresentedObjectsRep( cm ) then
        Error( "this is a cocomplex: use \033[1mCohomology\033[0m instead\n" );
    fi;
    
    return DefectOfExactness( cm );
    
end );

##
InstallMethod( Cohomology,
        "for a homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( cm )
    
    if IsChainMapOfFinitelyPresentedObjectsRep( cm ) then
        Error( "this is a complex: use \033[1mHomology\033[0m instead\n" );
    fi;
    
    return DefectOfExactness( cm );
    
end );

##
InstallMethod( CompleteChainMap,
        "for a homalg chain maps",
        [ IsChainMapOfFinitelyPresentedObjectsRep, IsInt ],
        
  function( cm, d )
    local l, image_square;
    
    if not IsHomalgMap( LowestDegreeMorphism( cm ) ) then
        TryNextMethod( );
    fi;
    
    l := HighestDegree( cm );
    
    while true and l < d do
        
        image_square := CertainMorphismAsImageSquare( cm, l );
        
        if image_square = fail then
            break;
        fi;
        
        Add( cm, CompleteImageSquare( image_square ) );
        
        ## prepare for the next step
        l := l + 1;
        
    od;
    
    return cm;
    
end );

##
InstallMethod( CompleteChainMap,
        "for a homalg chain maps",
        [ IsChainMapOfFinitelyPresentedObjectsRep ],
        
  function( cm )
    local d;
    
    d := HighestDegree( Source( cm ) );
    
    return CompleteChainMap( cm, d );
    
end );

##
InstallMethod( Cokernel,
        "for a homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( cm )
    local T, l, cm_l, coker, cm_lp1, phi, alpha, beta;
    
    if not IsHomalgMap( LowestDegreeMorphism( cm ) ) then
        TryNextMethod( );
    fi;
    
    T := Range( cm );
    
    l := LowestDegree( cm );
    
    cm_l := CertainMorphism( cm, l );
    
    if IsChainMapOfFinitelyPresentedObjectsRep( cm ) then
        
        coker := HomalgComplex( Cokernel( cm_l ), l );
        
        while true do
            cm_lp1 := CertainMorphism( cm, l + 1 );
            if cm_lp1 = fail then
                break;
            fi;
            phi := CertainMorphism( T, l + 1 );
            alpha := CokernelEpi( cm_lp1 );
            beta := CokernelEpi( cm_l );
            Add( coker, CompleteKernelSquare( alpha, phi, beta ) );
            ## prepare for the next step
            cm_l := cm_lp1;
            l := l + 1;
        od;
        
    else
        
        coker := HomalgCocomplex( Cokernel( cm_l ), l );
        
        while true do
            cm_lp1 := CertainMorphism( cm, l + 1 );
            if cm_lp1 = fail then
                break;
            fi;
            phi := CertainMorphism( T, l );
            alpha := CokernelEpi( cm_l );
            beta := CokernelEpi( cm_lp1 );
            Add( coker, CompleteKernelSquare( alpha, phi, beta ) );
            ## prepare for the next step
            cm_l := cm_lp1;
            l := l + 1;
        od;
        
    fi;
    
    if HasIsGradedMorphism( cm ) and IsGradedMorphism( cm ) then
        ## check assertion
        Assert( 2, IsGradedObject( coker ) );
        
        SetIsGradedObject( coker, true );
    elif HasIsMorphism( cm ) and IsMorphism( cm ) then
        ## check assertion
        Assert( 2, IsComplex( coker ) );
        
        SetIsComplex( coker, true );
    fi;
    
    return coker;
    
end );

##
InstallMethod( Kernel,
        "for a homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( cm )
    local S, l, cm_l, ker, cm_lp1, phi, alpha, beta;
    
    if not IsHomalgMap( LowestDegreeMorphism( cm ) ) then
        TryNextMethod( );
    fi;
    
    S := Source( cm );
    
    l := LowestDegree( cm );
    
    cm_l := CertainMorphism( cm, l );
    
    if IsChainMapOfFinitelyPresentedObjectsRep( cm ) then
        
        ker := HomalgComplex( Kernel( cm_l ), l );
        
        while true do
            cm_lp1 := CertainMorphism( cm, l + 1 );
            if cm_lp1 = fail then
                break;
            fi;
            phi := CertainMorphism( S, l + 1 );
            alpha := KernelEmb( cm_lp1 );
            beta := KernelEmb( cm_l );
            Add( ker, CompleteImageSquare( alpha, phi, beta ) );
            ## prepare for the next step
            cm_l := cm_lp1;
            l := l + 1;
        od;
        
    else
        ker := HomalgCocomplex( Kernel( cm_l ), l );
        
        while true do
            cm_lp1 := CertainMorphism( cm, l + 1 );
            if cm_lp1 = fail then
                break;
            fi;
            phi := CertainMorphism( S, l );
            alpha := KernelEmb( cm_l );
            beta := KernelEmb( cm_lp1 );
            Add( ker, CompleteImageSquare( alpha, phi, beta ) );
            ## prepare for the next step
            cm_l := cm_lp1;
            l := l + 1;
        od;
        
    fi;
    
    if HasIsGradedMorphism( cm ) and IsGradedMorphism( cm ) then
        ## check assertion
        Assert( 2, IsGradedObject( ker ) );
        
        SetIsGradedObject( ker, true );
    elif HasIsMorphism( cm ) and IsMorphism( cm ) then
        ## check assertion
        Assert( 2, IsComplex( ker ) );
        
        SetIsComplex( ker, true );
    fi;
    
    return ker;
    
end );

