#############################################################################
##
##  Fan.gi         ConvexForHomalg package         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Fans for ConvexForHomalg.
##
#############################################################################

####################################
##
## Reps
##
####################################

DeclareRepresentation( "IsExternalFanRep",
                       IsHomalgFan and IsExternalConvexObjectRep,
                       [ ]
                      );

DeclareRepresentation( "IsPolymakeFanRep",
                       IsExternalFanRep,
                       [ ]
                      );

####################################
##
## Types and Families
##
####################################


BindGlobal( "TheFamilyOfFans",
        NewFamily( "TheFamilyOfFans" , IsHomalgFan ) );

BindGlobal( "TheTypeExternalFan",
        NewType( TheFamilyOfFans,
                 IsHomalgFan and IsExternalFanRep ) );

BindGlobal( "TheTypePolymakeFan",
        NewType( TheFamilyOfFans,
                 IsPolymakeFanRep ) );

####################################
##
## Constructors
##
####################################

InstallMethod( HomalgFan,
               " for lists of HomalgCones",
               [ IsList ],
               
  function( cones )
    local point;
    
    if Length( cones ) = 0 then
        
        Error( " fan has to have the trivial cone." );
        
    fi;
    
    if IsHomalgCone( cones[ 1 ] ) then
        
        cones := List( cones, RayGenerators );
        
    fi;
    
    point := rec( 
        WeakPointerToExternalObject := EXT_FAN_BY_CONES( cones )
        );
    
    ObjectifyWithAttributes(
        point, TheTypePolymakeFan
        );
    
    return point;
    
end );

