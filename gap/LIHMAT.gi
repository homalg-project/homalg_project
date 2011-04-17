#############################################################################
##
##  LIHMAT.gdi                 LIHMAT subpackage           Mohamed Barakat
##                                                    Markus Lange-Hegermann
##
##         LIHMAT = Logical Implications for homalg Homogeneous MATrices
##
##  Copyright 2010, Mohamed Barakat, University of Kaiserslautern
##           Markus Lange-Hegermann, RWTH-Aachen University
##
##  Implementations for the LIHMAT subpackage.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( LIHMAT,
        rec(
            color := "\033[4;30;46m",
            intrinsic_properties := LIMAT.intrinsic_properties,
            intrinsic_attributes := LIMAT.intrinsic_attributes,
            )
        );

Append( LIHMAT.intrinsic_properties,
        [ 
          ] );

Append( LIHMAT.intrinsic_attributes,
        [ 
          "DegreesOfEntries",
          ] );

####################################
#
# methods for properties:
#
####################################

##
InstallMethodToPullPropertiesOrAttributes(
        IsHomalgHomogeneousMatrixRep and HasEval, IsHomalgHomogeneousMatrixRep,
        LIMAT.intrinsic_properties,
        UnderlyingNonHomogeneousMatrix );

##
InstallImmediateMethodToTwitterPropertiesOrAttributes(
        Twitter, IsHomalgHomogeneousMatrixRep and HasEval, LIMAT.intrinsic_properties, UnderlyingNonHomogeneousMatrix );

####################################
#
# methods for attributes:
#
####################################

##
InstallMethodToPullPropertiesOrAttributes(
        IsHomalgHomogeneousMatrixRep and HasEval, IsHomalgHomogeneousMatrixRep,
        LIMAT.intrinsic_attributes,
        UnderlyingNonHomogeneousMatrix );

##
InstallImmediateMethodToTwitterPropertiesOrAttributes(
        Twitter, IsHomalgHomogeneousMatrixRep and HasEval, LIMAT.intrinsic_attributes, UnderlyingNonHomogeneousMatrix );

##
InstallMethod( DegreesOfEntries,
        "for homalg matrices over graded rings",
        [ IsMatrixOverGradedRing ],
        
  function( C )
    
    return DegreesOfEntries( UnderlyingNonHomogeneousMatrix( C ), HomalgRing( C ) );
    
end );

##
InstallMethod( NonTrivialDegreePerRow,
        "for homalg matrices over graded rings",
        [ IsMatrixOverGradedRing ],
        
  function( C )
    
    return NonTrivialDegreePerRow( UnderlyingNonHomogeneousMatrix( C ), HomalgRing( C ) );
    
end );

##
InstallMethod( NonTrivialDegreePerRow,
        "for homalg matrices over graded rings",
        [ IsMatrixOverGradedRing, IsList ],
        
  function( C, col_degrees )
    
    return NonTrivialDegreePerRow( UnderlyingNonHomogeneousMatrix( C ), HomalgRing( C ), col_degrees );
    
end );

##
InstallMethod( NonTrivialDegreePerColumn,
        "for homalg matrices over graded rings",
        [ IsMatrixOverGradedRing ],
        
  function( C )
    
    return NonTrivialDegreePerColumn( UnderlyingNonHomogeneousMatrix( C ), HomalgRing( C ) );
    
end );

##
InstallMethod( NonTrivialDegreePerColumn,
        "for homalg matrices over graded rings",
        [ IsMatrixOverGradedRing, IsList ],
        
  function( C, row_degrees )
    
    return NonTrivialDegreePerColumn( UnderlyingNonHomogeneousMatrix( C ), HomalgRing( C ), row_degrees );
    
end );
