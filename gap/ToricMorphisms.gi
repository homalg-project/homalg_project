#############################################################################
##
##  ToricMorphisms.gi         ToricVarietiesForHomalg package         Sebastian Gutsche
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
InstallMethod( IsDefined,
               " for toric morphisms",
               [ IsToricMorphism ],
               
  function( morph )
    local sourcevar, matr, coneimg , rays, i, j, imagecones, conematrix;
    
    if not HasToricImageObject( morph ) then
        
        return true;
        
    fi;
    
    sourcevar := SourceObject( morph );
    
    matr := UnderlyingListList( morph );
    
    if IsFanRep( sourcevar ) then
        
        coneimg := MaximalCones( UnderlyingConvexObject( sourcevar ) );
        
    else
        
        Error( " no rays, needed to compute normalfan" );
        
        return fail;
        
    fi;
    
    coneimg := List( coneimg, RayGenerators );
    
    coneimg := List( coneimg, i -> List( i, j -> j*matr ) );
    
    if IsFanRep( ToricImageObject( morph ) ) then
        
        imagecones := MaximalCones( UnderlyingConvexObject( ToricImageObject( morph ) ) );
        
    else
        
        Error( " need to compute normalfan of image" );
        
    fi;
    
    imagecones := List( imagecones, DefiningInequalities );
    
    conematrix := List( coneimg, i -> List( imagecones, j -> List( i , k -> List( j, l -> k * l ) ) ) );
    
    if ForAll( conematrix, i -> ForAny( i, j -> ForAll( j, m -> ForAll( m, k -> k >= 0 ) ) ) ) then
        
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
               
  function( morph )
    local cones;
    
    cones := SourceObject( morph );
    
    cones := RayGenerators( MaximalCones ( UnderlyingConvexObject( cones ) ) );
    
    cones := List( cones, i -> List( j -> List( k -> k * UnderlyingListList( morph ) ) ) );
    
    cones := HomalgFan( cones );
    
    cones := ToricVariety( cones );
    
    return cones;
    
end );

##
InstallMethod( UnderlyingGridMorphism,
               " for toric morphisms",
               [ IsToricMorphism ],
               
  function( morph )
    local mor;
    
    mor := HomalgMatrix( UnderlyingListList( morph ), HOMALG_MATRICES.ZZ );
    
    mor := HomalgMap( mor, CharacterGrid( SourceObject( morph ) ), CharacterGrid( ToricImageObject( morph ) ) );  
    
    return mor;
    
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
               " for variety and matrix",
               [ IsToricVariety, IsList ],
               
  function( vari, matr )
    local morph;
    
    morph := rec( matrix := matr );
    
    ObjectifyWithAttributes( morph, TheTypeToricMorphism );
    
    SetSourceObject( morph, vari );
    
    return morph;
    
end );

##
InstallMethod( ToricMorphism,
               " for variety and matrix",
               [ IsToricVariety, IsList, IsToricVariety ],
               
  function( vari, matr, vari2 )
    local morph, hommat;
    
    morph := rec( matrix := matr );
    
    ObjectifyWithAttributes( morph, TheTypeToricMorphism );
    
    SetSourceObject( morph, vari );
    
    SetToricImageObject( morph, vari2 );
    
    hommat := HomalgMatrix( matr, HOMALG_MATRICES.ZZ );
    
    hommat := HomalgMap( hommat, CharacterGrid( vari ), CharacterGrid( vari2 ) );
    
    SetUnderlyingGridMorphism( morph, hommat );
    
    return morph;
    
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
    
    if HasIsDefined( morph ) then
        
        if IsDefined( morph ) then
            
            Print( " toric morphism" );
            
        else
            
            Print( " map between charactergrids" );
            
        fi;
        
    else
        
        Print( " maybe toric morphism" );
        
    fi;
    
    Print( ">" );
    
end );

##
InstallMethod( Display,
               " for toric morphisms",
               [ IsToricMorphism ],
               
  function( morph )
    
    Print( "A" );
    
    if HasIsDefined( morph ) then
        
        if IsDefined( morph ) then
            
            Print( " toric morphism" );
            
        else
            
            Print( " map between charactergrids" );
            
        fi;
        
    else
        
        Print( " maybe toric morphism" );
        
    fi;
    
    Print( "represended by the matrix ", UnderlyingListList( morph ), "." );
    
end );
