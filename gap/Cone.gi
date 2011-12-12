#############################################################################
##
##  Cone.gi         ConvexForHomalg package         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Cones for ConvexForHomalg.
##
#############################################################################

####################################
##
## Reps
##
####################################

DeclareRepresentation( "IsExternalConeRep",
                       IsHomalgCone and IsExternalConvexObjectRep,
                       [ ]
                      );

DeclareRepresentation( "IsPolymakeConeRep",
                       IsExternalConeRep,
                       [ ]
                      );

####################################
##
## Types and Families
##
####################################


BindGlobal( "TheFamilyOfCones",
            NewFamily( "TheFamilyOfCones" , IsHomalgCone ) );

BindGlobal( "TheTypeExternalCone",
        NewType( TheFamilyOfCones,
                 IsHomalgCone and IsExternalConeRep ) );

BindGlobal( "TheTypePolymakeCone",
        NewType( TheFamilyOfCones,
                 IsPolymakeConeRep ) );

#####################################
##
## Methods
##
#####################################



InstallMethod( IsPointedCone,
               "for homalg cones.",
               [ IsExternalConeRep ],
               
  function( cone )
    
    return EXT_IS_POINTED_CONE(  cone  );
    
end );

###################################
##
## Constructors
##
###################################

InstallMethod( HomalgCone,
               "constructor for Cones by List",
               [ IsList ],
               
  function( raylist )
    local cone, vals;
    
    vals := EXT_CREATE_CONE_BY_RAYS( raylist );
    
    cone := rec( rays := raylist,
                 WeakPointerToExternalObject := vals );
    
    ObjectifyWithAttributes( 
        cone, TheTypePolymakeCone
     );
    
    return cone;
    
end );
    