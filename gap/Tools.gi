#############################################################################
##
##  Tools.gd         ToricVarietiesForHomalg package         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Tools for toric varieties
##
#############################################################################

#######################
##
## Methods
##
#######################

InstallMethod( DefaultFieldForToricVarieties,
               " the default field.",
               [ ],
               
  function( )
    
    if IsBound( TORIC_VARIETIES!.FIELD ) then
        
        return TORIC_VARIETIES!.FIELD;
        
    fi;
    
    TORIC_VARIETIES!.FIELD := HomalgFieldOfRationalsInDefaultCAS();
    
    return TORIC_VARIETIES!.FIELD;
    
end );