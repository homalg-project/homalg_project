#############################################################################
##
##  HomalgObject.gi             homalg package               Mohamed Barakat
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##
##  Implementation for objects of (Abelian) categories.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( ShallowCopy,
        "for homalg objects",
        [ IsHomalgObject ],
        
  function( M )
    
    return Source( AnIsomorphism( M ) );
    
end );

