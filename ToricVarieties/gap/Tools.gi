#############################################################################
##
##  Tools.gi        ToricVarieties         Sebastian Gutsche
##
##  Copyright 2011- 2016, Sebastian Gutsche, TU Kaiserslautern
##                        Martin Bies,       ITP Heidelberg
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
InstallMethod( DefaultGradedFieldForToricVarieties,
               " the default field.",
               [ ],
               
  function( )
    
    if IsBound( TORIC_VARIETIES!.GRADED_FIELD ) then
        
        return TORIC_VARIETIES!.GRADED_FIELD;
        
    fi;
    
    TORIC_VARIETIES!.GRADED_FIELD := GradedRing( DefaultFieldForToricVarieties() );
    
    return TORIC_VARIETIES!.GRADED_FIELD;
    
end );

##
InstallMethod( InstallMethodsForSubvarieties,
               " installing subvarieties",
               [ ],
               
  function( )
    local attr;
    
    for attr in List( TORIC_VARIETIES!.prop_and_attr_shared_by_vars_and_subvars, ValueGlobal ) do
        
        LogicalImplicationsForHomalgSubobjects( attr, IsToricSubvariety, HasUnderlyingToricVariety, UnderlyingToricVariety );
        
    od;
    
    return true;
    
end );

##
InstallMethod( ProjectiveSpace,
               "creates projective space of given dim",
               [ IsInt ],
               
  function( dimension )
    local variety, zero_line, matrix;
    
    matrix := ShallowCopy( IdentityMat( dimension ) );
    
    zero_line := ListWithIdenticalEntries( dimension, 0 );
    
    Add( matrix, zero_line );
    
    variety := Polytope( matrix );
    
    return ToricVariety( variety );
    
end );

##
InstallMethod( AffineSpace,
               "create an affine space of given dim",
               [ IsInt ],
               
  function( dimension )
    local variety;
    
    variety := IdentityMat( dimension );
    
    return ToricVariety( Cone( variety ) );
    
end );

##
InstallMethod( HirzebruchSurface,
               "creates Hirzebruch surface",
               [ IsInt ],
               
  function( r )
    local fan;
    
    fan := Fan( [ [0,1],[1,0],[0,-1],[-1,r] ], [ [1,2],[2,3],[3,4],[4,1] ] );
    
    return ToricVariety( fan );
    
end );

###############################
##
## Precomputation
##
###############################

InstallMethodsForSubvarieties( );
