# SPDX-License-Identifier: GPL-2.0-or-later
# GradedModules: A homalg based package for the Abelian category of finitely presented graded modules over computable graded rings
#
# Implementations
#

##         LIGrRNG = Logical Implications for homalg GRaded RiNGs

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

