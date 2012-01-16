#############################################################################
##
##  Tools.gi        ToricVarieties         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Tools for toric varieties
##
#############################################################################

##################################
##
## Methods
##
##################################

##
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

##
InstallMethod( InstallMethodsForSubvarieties,
               " installing subvarieties",
               [ ],
               
  function( )
    local i;
    
    for i in List( TORIC_VARIETIES!.prop_and_attr_shared_by_vars_and_subvars, ValueGlobal ) do
        
        LogicalImplicationsForHomalgSubobjects( i, IsToricSubvariety, HasUnderlyingToricVariety, UnderlyingToricVariety );
        
    od;
    
    return true;
    
end );

###############################
##
## Precomputation
##
###############################

InstallMethodsForSubvarieties( );
