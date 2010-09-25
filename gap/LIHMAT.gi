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
          ] );

####################################
#
# methods for properties:
#
####################################

##
DeclareGlobalFunction( "InstallGradedMatrixPropertiesMethods" );
InstallGlobalFunction( InstallGradedMatrixPropertiesMethods,
  function( prop );

  InstallImmediateMethod( prop,
          IsHomalgHomogeneousMatrixRep, 0,
          
    function( M )
    local U;
    
      if HasIsVoidMatrix( M ) and IsVoidMatrix( M ) then
        TryNextMethod();
      fi;
    
      U := UnderlyingNonHomogeneousMatrix( M );
      if Tester( prop )( U ) then
        return prop( U );
      else
        TryNextMethod();
      fi;
      
  end );
  
  InstallMethod( prop,
          "for homalg homogeneous matrices",
          [ IsHomalgHomogeneousMatrixRep ],
          
    function( M )
      
      return prop( UnderlyingNonHomogeneousMatrix( M ) );
      
  end );

end );

             
for HOMOGENEOUSMATRIX_prop in [ 
     IsOne, IsZero, IsEmptyMatrix, IsRightInvertibleMatrix, IsLeftInvertibleMatrix, IsRightRegular, IsLeftRegular, IsUpperStairCaseMatrix, IsLowerStairCaseMatrix, IsDiagonalMatrix
   ] do
  InstallGradedMatrixPropertiesMethods( HOMOGENEOUSMATRIX_prop );
od;
Unbind( HOMOGENEOUSMATRIX_prop );

####################################
#
# methods for attributes:
#
####################################