#############################################################################
##
##  LIGrRNG.gi                                            LIGrRNG subpackage
##
##         LIGrRNG = Logical Implications for homalg GRaded RiNGs
##
##  Copyright 2011, Mohamed Barakat, University of Kaiserslautern
##           Markus Lange-Hegermann, RWTH-Aachen University
##
##  Implementations for the LIGrRNG subpackage.
##
#############################################################################

####################################
#
# immediate methods for properties:
#
####################################

####################################
#
# immediate methods for attributes:
#
####################################

####################################
#
# methods for properties:
#
####################################

##
InstallMethod( IsCohenMacaulay,
        "LIGrRNG: for homalg graded rings",
        [ IsHomalgGradedRingRep and HasRingRelations ],
        
  function( S )
    
    return IsCohenMacaulay( DefiningIdeal( S ) );
    
end );

####################################
#
# methods for attributes:
#
####################################

##
InstallMethod( DefiningIdeal,
        "LIGrRNG: for homalg graded rings",
        [ IsHomalgGradedRingRep and HasRingRelations ],
        
  function( S )
    
    return GradedLeftSubmodule( MatrixOfRelations( S ) );
    
end );

