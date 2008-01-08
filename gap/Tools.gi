#############################################################################
##
##  Tools.gi                    homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations of homalg tools.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( RankOfGauss,
        "for sets of relations",
	[ IsMatrixForHomalg and HasRankOfMatrix ],
        
  function( M )
    
    return RankOfMatrix( M );
    
end );
