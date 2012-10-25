#############################################################################
##
##  ChainMorphisms.gi                                         homalg package
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations of homalg procedures for chain morphisms.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( DefectOfExactness,
        "for a homalg chain morphism",
        [ IsChainMorphismOfFinitelyPresentedObjectsRep, IsInt ],
        
  function( cm, i )
    local degree, degrees, S, source_degrees, T, target_degrees, sq, def;
    
    degree := DegreeOfMorphism( cm );
    
    degrees := DegreesOfChainMorphism( cm );
    
    S := Source( cm );
    
    source_degrees := ObjectDegreesOfComplex( S );
    
    T := Range( cm );
    
    target_degrees := ObjectDegreesOfComplex( T );
    
    if PositionSet( degrees, i ) = fail then
        Error( "the second argument ", i, " is outside the degree range of the chain morphism\n" );
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
        Error( "the ", i, ". morphism of the chain morphism is neither at one of the ends nor in the middle of both source and target complexes\n" );
    fi;
    
    return def;		## the output is handled by the methods installed by InstallSpecialFunctorOnMorphisms
    
end );

##
InstallMethod( DefectOfExactness,
        "for a homalg chain morphism",
        [ IsCochainMorphismOfFinitelyPresentedObjectsRep, IsInt ],
        
  function( cm, i )
    local degree, degrees, S, source_degrees, T, target_degrees, sq, def;
    
    degree := DegreeOfMorphism( cm );
    
    degrees := DegreesOfChainMorphism( cm );
    
    S := Source( cm );
    
    source_degrees := ObjectDegreesOfComplex( S );
    
    T := Range( cm );
    
    target_degrees := ObjectDegreesOfComplex( T );
    
    if PositionSet( degrees, i ) = fail then
        Error( "the second argument ", i, " is outside the degree range of the chain morphism\n" );
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
        Error( "the ", i, ". morphism of the chain morphism is neither at one of the ends nor in the middle of both source and target complexes\n" );
    fi;
    
    return def;		## the output is handled by the methods installed by InstallSpecialFunctorOnMorphisms
    
end );

##
InstallMethod( Homology,
        "for a homalg chain morphism",
        [ IsHomalgChainMorphism, IsInt ],
        
  function( cm, i )
    
    if IsCochainMorphismOfFinitelyPresentedObjectsRep( cm ) then
        Error( "this is a cocomplex: use \033[1mCohomology\033[0m instead\n" );
    fi;
    
    return DefectOfExactness( cm, i );
    
end );

##
InstallMethod( Cohomology,
        "for a homalg chain morphism",
        [ IsHomalgChainMorphism, IsInt ],
        
  function( cm, i )
    
    if IsChainMorphismOfFinitelyPresentedObjectsRep( cm ) then
        Error( "this is a complex: use \033[1mHomology\033[0m instead\n" );
    fi;
    
    return DefectOfExactness( cm, i );
    
end );

##
InstallMethod( DefectOfExactness,
        "for a homalg chain morphism",
        [ IsChainMorphismOfFinitelyPresentedObjectsRep ],
        
  function( cm )
    local degrees, S, T, def, i;
    
    degrees := DegreesOfChainMorphism( cm );
    
    S := DefectOfExactness( Source( cm ) );
    T := DefectOfExactness( Range( cm ) );
    
    def := HomalgChainMorphism( DefectOfExactness( cm, degrees[1] ), S, T );
    
    for i in degrees{[ 2 .. Length( degrees ) ]} do
        Add( def, DefectOfExactness( cm, i ) );
    od;
    
    SetIsGradedMorphism( def, true );
    
    return def;
    
end );

##
InstallMethod( DefectOfExactness,
        "for a homalg chain morphism",
        [ IsCochainMorphismOfFinitelyPresentedObjectsRep ],
        
  function( cm )
    local degrees, S, T, def, i;
    
    degrees := DegreesOfChainMorphism( cm );
    
    S := DefectOfExactness( Source( cm ) );
    T := DefectOfExactness( Range( cm ) );
    
    def := HomalgChainMorphism( DefectOfExactness( cm, degrees[1] ), S, T );
    
    for i in degrees{[ 2 .. Length( degrees ) ]} do
        Add( def, DefectOfExactness( cm, i ) );
    od;
    
    SetIsGradedMorphism( def, true );
    
    return def;
    
end );

##
InstallMethod( Homology,
        "for a homalg chain morphism",
        [ IsHomalgChainMorphism ],
        
  function( cm )
    
    if IsCochainMorphismOfFinitelyPresentedObjectsRep( cm ) then
        Error( "this is a cocomplex: use \033[1mCohomology\033[0m instead\n" );
    fi;
    
    return DefectOfExactness( cm );
    
end );

##
InstallMethod( Cohomology,
        "for a homalg chain morphism",
        [ IsHomalgChainMorphism ],
        
  function( cm )
    
    if IsChainMorphismOfFinitelyPresentedObjectsRep( cm ) then
        Error( "this is a complex: use \033[1mHomology\033[0m instead\n" );
    fi;
    
    return DefectOfExactness( cm );
    
end );

##
InstallMethod( CompleteChainMorphism,
        "for a homalg chain morphism",
        [ IsChainMorphismOfFinitelyPresentedObjectsRep, IsInt ],
        
  function( cm, d )
    local morphism, l, image_square;
    
    if not IsHomalgStaticMorphism( LowestDegreeMorphism( cm ) ) then
        TryNextMethod( );
    fi;
    
    morphism := HasIsMorphism( cm ) and IsMorphism( cm );
    
    l := HighestDegree( cm );
    
    while l < d do
        
        image_square := CertainMorphismAsImageSquare( cm, l );
        
        if image_square = fail then
            break;
        fi;
        
        Add( cm, CompleteImageSquare( image_square ) );
        
        ## prepare for the next step
        l := l + 1;
        
    od;
    
    if morphism then
        Assert( 1, IsMorphism( cm ) );
        SetIsMorphism( cm, true );
    fi;
    
    return cm;
    
end );

##
InstallMethod( CompleteChainMorphism,
        "for a homalg chain morphism",
        [ IsChainMorphismOfFinitelyPresentedObjectsRep ],
        
  function( cm )
    local d;
    
    d := HighestDegree( Source( cm ) );
    
    return CompleteChainMorphism( cm, d );
    
end );

##
InstallMethod( CokernelEpi,
        "for a homalg chain morphism",
        [ IsHomalgChainMorphism ],
        
  function( cm )
    local T, degree, l, cm_l, coker, cm_lp1, phi, alpha, beta, epi;
    
    if not IsHomalgStaticMorphism( LowestDegreeMorphism( cm ) ) then
        TryNextMethod( );
    fi;
    
    T := Range( cm );
    
    degree := DegreeOfMorphism( cm );
    
    l := LowestDegree( cm );
    
    cm_l := CertainMorphism( cm, l );
    
    if IsChainMorphismOfFinitelyPresentedObjectsRep( cm ) then
        
        coker := HomalgComplex( Cokernel( cm_l ), l + degree );
        
        while true do
            cm_lp1 := CertainMorphism( cm, l + 1 );
            if cm_lp1 = fail then
                break;
            fi;
            phi := CertainMorphism( T, l + 1 + degree );
            alpha := CokernelEpi( cm_lp1 );
            beta := CokernelEpi( cm_l );
            Add( coker, CompleteKernelSquare( alpha, phi, beta ) );
            ## prepare for the next step
            cm_l := cm_lp1;
            l := l + 1;
        od;
        
    else
        
        coker := HomalgCocomplex( Cokernel( cm_l ), l + degree );
        
        while true do
            cm_lp1 := CertainMorphism( cm, l + 1 );
            if cm_lp1 = fail then
                break;
            fi;
            phi := CertainMorphism( T, l + degree );
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
        Assert( 4, IsGradedObject( coker ) );
        
        SetIsGradedObject( coker, true );
    elif HasIsMorphism( cm ) and IsMorphism( cm ) then
        ## check assertion
        Assert( 4, IsComplex( coker ) );
        
        SetIsComplex( coker, true );
    fi;
    
    l := LowestDegree( cm );
    
    cm_l := CertainMorphism( cm, l );
    
    epi := HomalgChainMorphism( CokernelEpi( cm_l ), T, coker, [ l + degree, 0 ] );
    
    while true do
        cm_l := CertainMorphism( cm, l + 1 );
        if cm_l = fail then
            break;
        fi;
        Add( epi, CokernelEpi( cm_l ) );
        ## prepare for the next step
        l := l + 1;
    od;
    
    if HasIsMorphism( cm ) and IsMorphism( cm ) then
        ## check assertion
        Assert( 4, IsEpimorphism( epi ) );
        
        SetIsEpimorphism( epi, true );
    fi;
    
    if HasIsGradedMorphism( cm ) and IsGradedMorphism( cm ) then
        ## check assertion
        Assert( 4, IsGradedMorphism( epi ) );
        
        SetIsGradedMorphism( epi, true );
    fi;
    
    return epi;
    
end );

##
InstallMethod( Cokernel,
        "for a homalg chain morphism",
        [ IsHomalgChainMorphism ],
        
  function( cm )
    
    return Range( CokernelEpi( cm ) );
    
end );

##
InstallMethod( ImageObjectEmb,
        "for a homalg chain morphism",
        [ IsHomalgChainMorphism ],
        
  function( cm )
    local T, degree, l, cm_l, img, cm_lp1, phi, alpha, beta, emb;
    
    if not IsHomalgStaticMorphism( LowestDegreeMorphism( cm ) ) then
        TryNextMethod( );
    fi;
    
    T := Range( cm );
    
    degree := DegreeOfMorphism( cm );
    
    l := LowestDegree( cm );
    
    cm_l := CertainMorphism( cm, l );
    
    if IsChainMorphismOfFinitelyPresentedObjectsRep( cm ) then
        
        img := HomalgComplex( ImageObject( cm_l ), l + degree );
        
        while true do
            cm_lp1 := CertainMorphism( cm, l + 1 );
            if cm_lp1 = fail then
                break;
            fi;
            phi := CertainMorphism( T, l + 1 + degree );
            alpha := ImageObjectEmb( cm_lp1 );
            beta := ImageObjectEmb( cm_l );
            Add( img, CompleteImageSquare( alpha, phi, beta ) );
            ## prepare for the next step
            cm_l := cm_lp1;
            l := l + 1;
        od;
        
    else
        
        img := HomalgCocomplex( ImageObject( cm_l ), l + degree );
        
        while true do
            cm_lp1 := CertainMorphism( cm, l + 1 );
            if cm_lp1 = fail then
                break;
            fi;
            phi := CertainMorphism( T, l + degree );
            alpha := ImageObjectEmb( cm_l );
            beta := ImageObjectEmb( cm_lp1 );
            Add( img, CompleteImageSquare( alpha, phi, beta ) );
            ## prepare for the next step
            cm_l := cm_lp1;
            l := l + 1;
        od;
        
    fi;
    
    if HasIsGradedMorphism( cm ) and IsGradedMorphism( cm ) then
        ## check assertion
        Assert( 4, IsGradedObject( img ) );
        
        SetIsGradedObject( img, true );
    elif HasIsMorphism( cm ) and IsMorphism( cm ) then
        ## check assertion
        Assert( 4, IsComplex( img ) );
        
        SetIsComplex( img, true );
    fi;
    
    l := LowestDegree( cm );
    
    cm_l := CertainMorphism( cm, l );
    
    emb := HomalgChainMorphism( ImageObjectEmb( cm_l ), img, T, [ l + degree, 0 ] );
    
    while true do
        cm_l := CertainMorphism( cm, l + 1 );
        if cm_l = fail then
            break;
        fi;
        Add( emb, ImageObjectEmb( cm_l ) );
        ## prepare for the next step
        l := l + 1;
    od;
    
    if HasIsMorphism( cm ) and IsMorphism( cm ) then
        ## check assertion
        Assert( 4, IsMonomorphism( emb ) );
        
        SetIsMonomorphism( emb, true );
    fi;
    
    if HasIsGradedMorphism( cm ) and IsGradedMorphism( cm ) then
        ## check assertion
        Assert( 4, IsGradedMorphism( emb ) );
        
        SetIsGradedMorphism( emb, true );
    fi;
    
    return emb;
    
end );

##
InstallMethod( ImageObject,
        "for a homalg chain morphism",
        [ IsHomalgChainMorphism ],
        
  function( cm )
    
    return Source( ImageObjectEmb( cm ) );
    
end );

##
InstallMethod( KernelEmb,
        "for a homalg chain morphism",
        [ IsHomalgChainMorphism ],
        
  function( cm )
    local S, l, cm_l, ker, cm_lp1, phi, alpha, beta, emb;
    
    if not IsHomalgStaticMorphism( LowestDegreeMorphism( cm ) ) then
        TryNextMethod( );
    fi;
    
    S := Source( cm );
    
    l := LowestDegree( cm );
    
    cm_l := CertainMorphism( cm, l );
    
    if IsChainMorphismOfFinitelyPresentedObjectsRep( cm ) then
        
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
        Assert( 4, IsGradedObject( ker ) );
        
        SetIsGradedObject( ker, true );
    elif HasIsMorphism( cm ) and IsMorphism( cm ) then
        ## check assertion
        Assert( 4, IsComplex( ker ) );
        
        SetIsComplex( ker, true );
    fi;
    
    l := LowestDegree( cm );
    
    cm_l := CertainMorphism( cm, l );
    
    emb := HomalgChainMorphism( KernelEmb( cm_l ), ker, S, [ l, 0 ] );
    
    while true do
        cm_l := CertainMorphism( cm, l + 1 );
        if cm_l = fail then
            break;
        fi;
        Add( emb, KernelEmb( cm_l ) );
        ## prepare for the next step
        l := l + 1;
    od;
    
    if HasIsMorphism( cm ) and IsMorphism( cm ) then
        ## check assertion
        Assert( 4, IsMonomorphism( emb ) );
        
        SetIsMonomorphism( emb, true );
    fi;
    
    if HasIsGradedMorphism( cm ) and IsGradedMorphism( cm ) then
        ## check assertion
        Assert( 4, IsGradedMorphism( emb ) );
        
        SetIsGradedMorphism( emb, true );
    fi;
    
    return emb;
    
end );

##
InstallMethod( Kernel,
        "for a homalg chain morphism",
        [ IsHomalgChainMorphism ],
        
  function( cm )
    
    return Source( KernelEmb( cm ) );
    
end );

