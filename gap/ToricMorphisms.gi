#############################################################################
##
##  ToricMorphisms.gi         ToricVarieties         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Morphisms for toric varieties
##
#############################################################################

###############################
##
## Reps, Families and Types
##
###############################

DeclareRepresentation( "IsMatrixRep",
                       IsToricMorphism and IsAttributeStoringRep,
                       [ "matrix" ]
                      );

BindGlobal( "TheFamilyOfToricMorphisms",
        NewFamily( "TheFamilyOfToricMorphisms" , IsToricMorphism ) );

BindGlobal( "TheTypeToricMorphism",
        NewType( TheFamilyOfToricMorphisms,
                 IsMatrixRep  and IsStaticMorphismOfFinitelyGeneratedObjectsRep ) );

####################################
#
# global variables:
#
####################################

TORIC_VARIETIES.FunctorOn :=  [ IsToricVariety,
                      IsToricMorphism,
                      [ IsComplexOfFinitelyPresentedObjectsRep, IsCocomplexOfFinitelyPresentedObjectsRep ],
                      [ IsChainMorphismOfFinitelyPresentedObjectsRep, IsCochainMorphismOfFinitelyPresentedObjectsRep ] ];

###############################
##
## Properties
##
###############################

##
InstallMethod( IsMorphism,
               " for toric morphisms",
               [ IsToricMorphism ],
               
  function( morphism )
    local source_variety, matrix_of_morphism, cones_of_source, i, j, image_cones, cone_incidence_matrix;
    
    if not HasRange( morphism ) then
        
        return true;
        
    fi;
    
    source_variety := SourceObject( morphism );
    
    matrix_of_morphism := UnderlyingListList( morphism );
    
    if IsFanRep( source_variety ) then
        
        cones_of_source := MaximalCones( FanOfVariety( source_variety ) );
        
    else
        
        Error( "no rays, needed to compute normalfan\n" );
        
        TryNextMethod();
        
    fi;
    
    cones_of_source := List( cones_of_source, RayGenerators );
    
    cones_of_source := List( cones_of_source, i -> List( i, j -> j * matrix_of_morphism ) );
    
    image_cones := MaximalCones( FanOfVariety( RangeObject( morphism ) ) );
    
    if ForAll( cones_of_source, i -> ForAny( image_cones, j -> ForAll( i, k -> RayGeneratorContainedInCone( k, j ) ) ) ) then
        
        return true;
        
    else
        
        return false;
        
    fi;
    
    TryNextMethod();
    
end );

###############################
##
## Attributes
##
###############################

##
InstallMethod( ToricImageObject,
               " for toric morphisms",
               [ IsToricMorphism ],
               
  function( morphism )
    local cones_of_source, cones_of_image, toric_image;
    
    cones_of_source := SourceObject( morphism );
    
    cones_of_source := RayGenerators( MaximalCones ( FanOfVariety( cones_of_source ) ) );
    
    cones_of_image := List( cones_of_source, i -> List( j -> List( k -> k * UnderlyingListList( morphism ) ) ) );
    
    cones_of_image := Fan( cones_of_image );
    
    toric_image := ToricVariety( cones_of_image );
    
    SetRangeObject( toric_image );
    
    return toric_image;
    
end );

##
InstallMethod( UnderlyingGridMorphism,
               " for toric morphisms",
               [ IsToricMorphism ],
               
  function( morphism )
    local homalg_morphism;
    
    homalg_morphism := HomalgMatrix( UnderlyingListList( morphism ), HOMALG_MATRICES.ZZ );
    
    homalg_morphism := HomalgMap( homalg_morphism, CharacterLattice( SourceObject( morphism ) ), CharacterLattice( ToricImageObject( morphism ) ) );  
    
    return homalg_morphism;
    
end );

##
InstallMethod( MorphismOnWeilDivisorGroup,
               "for toric morphisms",
               [ IsToricMorphism and IsMorphism ],
               
  function( morphism )
    local source, range, source_rays, range_rays, range_maxcone_ray_incidence, range_rays_in_cones, rayimage_maxcone_incidence_matrix,
    current_row, images_of_rays, i, j , dim_range, ray_matrix, image_matrix, matrix_multiplier, temp_solution;
    
    source := SourceObject( morphism );
    
    range := RangeObject( morphism );
    
#     if not HasTorusInvariantDivisorGroup( source ) or not HasTorusInvariantDivisorGroup( range ) then
#         
#         Error( "divisorgroup not specified\n" );
#         
#     fi;
    
    source_rays := RayGenerators( FanOfVariety( source ) );
    
    images_of_rays := List( source_rays, i -> i * UnderlyingListList( morphism ) );
    
    range_rays := MaximalCones( FanOfVariety( range ) );
    
    range_rays_in_cones := List( range_rays, RayGenerators );
    
    rayimage_maxcone_incidence_matrix := [ 1 .. Length( images_of_rays ) ];
    
    for i in [ 1 .. Length( images_of_rays ) ] do
        
        for j in [ 1 .. Length( range_rays ) ] do
            
            if RayGeneratorContainedInCone( images_of_rays[ i ], range_rays[ j ] ) then
                
                rayimage_maxcone_incidence_matrix[ i ] := j;
                
                break;
                
            fi;
            
        od;
        
    od;
    
    range_maxcone_ray_incidence := RaysInMaximalCones( FanOfVariety( range ) );
    
    range_rays := RayGenerators( FanOfVariety( range ) );
    
    range_rays_in_cones := [ ];
    
    for i in range_maxcone_ray_incidence do
        
        current_row := [ ];
        
        for j in [ 1 .. Length( i ) ] do
            
            if i[ j ] = 1 then
                
                Add( current_row, range_rays[ j ] );
                
            else
                
                Add( current_row, List( [ 1 .. Length( range_rays[ j ] ) ], k -> 0 ) );
                
            fi;
            
        od;
        
        #current_row := TransposedMatMutable( current_row );
        
        Add( range_rays_in_cones, HomalgMatrix( current_row, HOMALG_MATRICES.ZZ ) );
        
    od;
    
    dim_range := Length( images_of_rays[ 1 ] );
    
    images_of_rays := List( images_of_rays, i -> HomalgMatrix( i, 1, dim_range, HOMALG_MATRICES.ZZ ) );
    
    image_matrix := [ ];
    
    for i in [ 1 .. Length( images_of_rays ) ] do
        
        current_row := images_of_rays[ i ];
        
        temp_solution := fail;
        
        matrix_multiplier := 1;
        
        ## The ray must have a generator that is combination of the rays, so this terminates.
        while temp_solution = fail do
            
            temp_solution := RightDivide( matrix_multiplier * current_row, range_rays_in_cones[ rayimage_maxcone_incidence_matrix[ i ] ] );
            
            matrix_multiplier := matrix_multiplier + 1;
            
        od;
        
        current_row := EntriesOfHomalgMatrix( temp_solution );
        
        for j in [ 1 .. Length( current_row ) ] do
            
            current_row[ j ] := current_row[ j ] * range_maxcone_ray_incidence[ rayimage_maxcone_incidence_matrix[ i ] ][ j ];
            
        od;
        
        Add( image_matrix, current_row );
        
    od;
    
    image_matrix := HomalgMatrix( image_matrix, HOMALG_MATRICES.ZZ );
    
    return HomalgMap( image_matrix, TorusInvariantDivisorGroup( source ), TorusInvariantDivisorGroup( range ) );
    
end );

##
RedispatchOnCondition( MorphismOnWeilDivisorGroup, true, [ IsToricMorphism ], [ IsMorphism ], 0 );

##
InstallMethod( MorphismOnCartierDivisorGroup,
               "for toric mophisms",
               [ IsToricMorphism ],
               
  function( morphism )
    local source, range, source_embedding, range_embedding, final_morphism;
    
    source := SourceObject( morphism );
    
    range := RangeObject( morphism );
    
    source_embedding := EmbeddingInSuperObject( CartierTorusInvariantDivisorGroup( source ) );
    
    range_embedding := EmbeddingInSuperObject( CartierTorusInvariantDivisorGroup( range ) );
    
    final_morphism := MorphismOnWeilDivisorGroup( morphism );
    
    final_morphism := PreCompose( source_embedding, final_morphism );
    
    final_morphism := PostDivide( final_morphism, range_embedding );
    
    ## This one must not exist!
    if final_morphism = fail then
        
        return TheZeroMorphism( CartierTorusInvariantDivisorGroup( source ), CartierTorusInvariantDivisorGroup( range ) );
        
    fi;
    
    return final_morphism;
    
end );

# ##
# InstallMethod( MorphismOnPicardGroup,
#                "for toric morphisms",
#                [ IsToricMorphism ],
#                
#   function( morphism )
#     local source, range, source_embedding, source_epi, range_embedding, range_epi, final_morphism;
#     
#     source := SourceObject( morphism );
#     
#     range := RangeObject( morphism );
#     
#     if not HasPicardGroup( source ) or not HasPicardGroup( range ) then
#         
#         Error( "picard group is not set in source or range\n" );
#         
#     fi;
#     
#     source_embedding := EmbeddingInSuperObject( CartierDivisorGroup( source ) );
#     
#     range_embedding := EmbeddingInSuperObject( CartierDivisorGroup( range ) );
#     
#     source_epi := PreCompose( source_embedding, MapFromCharacterToPrincipalDivisor( source ) );
#     
#     source_epi := CokernelEpi( source_epi );
#     
#     range_epi := PreCompose( range_embedding, MapFromCharacterToPrincipalDivisor( range ) );
#     
#     range_epi := CokernelEpi( range_epi );
#     
#     final_morphism := MorphismOnCartierDivisorGroup( morphism );
#     
#     final_morphism := PreDivide( source_epi, final_morphism );
#     
#     final_morphism := PreCompose( final_morphism, range_epi );
#     
#     return final_morphism;
#     
# end );

##
InstallMethod( SourceObject,
               "for toric morphisms",
               [ IsToricMorphism ],
               
  function( morphism )
    
    return Source( morphism );
    
end );

##
InstallMethod( RangeObject,
               "for toric morphisms",
               [ IsToricMorphism ],
               
  function( morphism )
    
    return Range( morphism );
    
end );

###############################
##
## Methods
##
###############################

##
InstallMethod( UnderlyingListList,
               " for toric morphisms",
               [ IsToricMorphism ],
               
  function( morph )
    
    return morph!.matrix;
    
end );

###############################
##
## Constructors
##
###############################

##
InstallMethod( ToricMorphism,
               "for variety and matrix",
               [ IsToricVariety, IsList ],
               
  function( variety, matrix )
    local morphism;
    
    morphism := rec( matrix := matrix );
    
    ObjectifyWithAttributes( morphism, TheTypeToricMorphism,
                             Source, variety
    );
    
    return morphism;
    
end );

##
InstallMethod( ToricMorphism,
               " for variety and matrix",
               [ IsToricVariety, IsList, IsToricVariety ],
               
  function( variety1, matrix, variety2 )
    local morphism, hom_matrix;
    
    morphism := rec( matrix := matrix );
    
    ObjectifyWithAttributes( morphism, TheTypeToricMorphism,
                             Source, variety1,
                             Range, variety2
                            );
    
    hom_matrix := HomalgMatrix( matrix, HOMALG_MATRICES.ZZ );
    
    hom_matrix := HomalgMap( hom_matrix, CharacterLattice( variety1 ), CharacterLattice( variety2 ) );
    
    SetUnderlyingGridMorphism( morphism, hom_matrix );
    
    return morphism;
    
end );

###############################
##
## View
##
###############################

##
InstallMethod( ViewObj,
               " for toric morphisms",
               [ IsToricMorphism ],
               
  function( morph )
    
    Print( "<A" );
    
    if HasIsMorphism( morph ) then
        
        if IsMorphism( morph ) then
            
            Print( " toric morphism" );
            
        else
            
            Print( " map between charactergrids" );
            
        fi;
        
    else
        
        Print( " \"toric morphism\"" );
        
    fi;
    
    Print( ">" );
    
end );

##
InstallMethod( Display,
               " for toric morphisms",
               [ IsToricMorphism ],
               
  function( morph )
    
    Print( "A" );
    
    if HasIsMorphism( morph ) then
        
        if IsMorphism( morph ) then
            
            Print( " toric morphism" );
            
        else
            
            Print( " map between charactergrids" );
            
        fi;
        
    else
        
        Print( " \"toric morphism\"" );
        
    fi;
    
    Print( "represended by the matrix ", UnderlyingListList( morph ), "." );
    
end );
