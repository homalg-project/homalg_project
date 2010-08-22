#############################################################################
##
##  HomalgSpectralSequence.gi   homalg package               Mohamed Barakat
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##
##  Implementations for homalg spectral sequences.
##
#############################################################################

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

