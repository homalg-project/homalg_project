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
                 IsMatrixRep ) );

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
    local source_variety, matrix_of_morphism, cones_of_source, i, j, inequalities_for_image_cones, cone_incidence_matrix;
    
    if not HasToricImageObject( morphism ) then
        
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
    
    inequalities_for_image_cones := MaximalCones( FanOfVariety( ToricImageObject( morphism ) ) );
    
    inequalities_for_image_cones := List( inequalities_for_image_cones, DefiningInequalities );
    
    cone_incidence_matrix := List( cones_of_source, i -> List( inequalities_for_image_cones, j -> List( i , k -> List( j, l -> k * l ) ) ) );
    
    if ForAll( cone_incidence_matrix, i -> ForAny( i, j -> ForAll( j, m -> ForAll( m, k -> k >= 0 ) ) ) ) then
        
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
    local cones_of_source, cones_of_image;
    
    cones_of_source := SourceObject( morphism );
    
    cones_of_source := RayGenerators( MaximalCones ( FanOfVariety( cones_of_source ) ) );
    
    cones_of_image := List( cones_of_source, i -> List( j -> List( k -> k * UnderlyingListList( morphism ) ) ) );
    
    cones_of_image := Fan( cones_of_image );
    
    return ToricVariety( cones_of_image );
    
end );

##
InstallMethod( UnderlyingGridMorphism,
               " for toric morphisms",
               [ IsToricMorphism ],
               
  function( morphism )
    local homalg_morphism;
    
    homalg_morphism := HomalgMatrix( UnderlyingListList( morphism ), HOMALG_MATRICES.ZZ );
    
    homalg_morphism := HomalgMap( homalg_morphism, CharacterGrid( SourceObject( morphism ) ), CharacterGrid( ToricImageObject( morphism ) ) );  
    
    return homalg_morphism;
    
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
                             SourceObject, variety
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
    
    ObjectifyWithAttributes( morphism, TheTypeToricMorphism );
    
    SetSourceObject( morphism, variety1 );
    
    SetToricImageObject( morphism, variety2 );
    
    hom_matrix := HomalgMatrix( matrix, HOMALG_MATRICES.ZZ );
    
    hom_matrix := HomalgMap( hom_matrix, CharacterGrid( variety1 ), CharacterGrid( variety2 ) );
    
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
