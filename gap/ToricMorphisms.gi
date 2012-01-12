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
                       IsToricMorphism,
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

###############################
##
## Attributes
##
###############################

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
    
    SetImageObject( morph, vari2 );
    
    hommat := HomalgMatrix( matr, HOMALG_MATRIX.ZZ );
    
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
    
    Print( "represended by the matrix ", UnderlyingListList( vari ), "." );
    
end );
