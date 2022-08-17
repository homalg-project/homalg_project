# SPDX-License-Identifier: GPL-2.0-or-later
# Modules: A homalg based package for the Abelian category of finitely presented modules over computable rings
#
# Implementations
#

##  Implementations for homalg spectral sequences.

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( HomalgRing,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    
    return HomalgRing( LowestLevelSheetInSpectralSequence( E ) );
    
end );

##
InstallMethod( OnLessGenerators,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    
    return OnLessGenerators( HighestLevelSheetInSpectralSequence( E ) );
    
end );

##
InstallMethod( BasisOfModule,
        "for homalg spectral sequences",
        [ IsHomalgSpectralSequence ],
        
  function( E )
    
    return BasisOfModule( HighestLevelSheetInSpectralSequence( E ) );
    
end );

