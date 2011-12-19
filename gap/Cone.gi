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
## Property Computation
##
#####################################

##
InstallMethod( IsPointedCone,
               "for homalg cones.",
               [ IsExternalConeRep ],
               
  function( cone )
    
    return EXT_IS_POINTED_CONE(  cone  );
    
end );

##
InstallMethod( IsSmooth,
               "for external cones",
               [ IsExternalConeRep ],
               
  function( cone )
    
    return EXT_IS_SMOOTH_CONE( cone );
    
end );

##
InstallMethod( IsRegular,
               "for homalg cones.",
               [ IsHomalgCone ],
  function( cone )
    
    return IsSmooth( cone );
    
end );

#####################################
##
## Attribute Computation
##
#####################################

##
InstallMethod( RayGenerators,
               "for external Cone",
               [ IsExternalConeRep ],
               
  function( cone )
    
    return EXT_GENERATING_RAYS_OF_CONE( cone );
    
end );

##
InstallMethod( DualCone,
               "for external cones",
               [ IsExternalConeRep ],
               
  function( cone )
    local dual;
    
    dual := EXT_CREATE_DUAL_CONE_OF_CONE( cone );
    
    dual := HomalgCone( dual );
    
    SetDualCone( dual, cone );
    
    return dual;
    
end );

##
InstallMethod( ContainingSpaceDimension,
               "for external cones",
               [ IsExternalConeRep ],
               
  function( cone )
    
    return EXT_AMBIENT_DIM_OF_CONE( cone );
    
end );

##
InstallMethod( ConeDimension,
               "for external cones",
               [ IsExternalConeRep ],
               
  function( cone )
    
    return EXT_DIM_OF_CONE( cone );
    
end );

##
InstallMethod( HilbertBasis,
               "for external cones",
               [ IsExternalConeRep ],
               
  function( cone )
    
    return EXT_HILBERT_BASIS_OF_CONE( cone );
    
end );

##
InstallMethod( RaysInFacets,
               " for external cones",
               [ IsExternalConeRep ],
               
  function( cone )
    
    return EXT_RAYS_IN_FACETS( cone );
    
end );

##
InstallMethod( Facets,
               " for external cones",
               [ IsExternalConeRep ],
               
  function( cone )
    local raylist, rays, conelist, i, lis, j;
    
    raylist := RaysInFacets( cone );
    
    rays := RayGenerators( cone );
    
    conelist := [ ];
    
    for i in [ 1..Length( raylist ) ] do
        
        lis := [ ];
        
        for j in raylist[ i ] do
            
            lis := Concatenation( lis, [ rays[ j ] ] );
            
        od;
        
        conelist := Concatenation( conelist, [ lis ] );
        
    od;
    
    return List( conelist, HomalgCone );
    
    TryNextMethod();
    
end );

###################################
##
## Constructors
##
###################################

##
InstallMethod( HomalgCone,
               "constructor for Cones by List",
               [ IsList ],
               
  function( raylist )
    local cone, vals;
    
    vals := EXT_CREATE_CONE_BY_RAYS( raylist );
    
    cone := rec( WeakPointerToExternalObject := vals );
    
    ObjectifyWithAttributes( 
        cone, TheTypePolymakeCone
     );
    
    return cone;
    
end );

##
InstallMethod( HomalgCone,
               "constructor for given Pointers",
               [ IsInt ],
               
  function( conepointer )
    local cone;
    
    cone := rec( WeakPointerToExternalObject := conepointer );
    
    ObjectifyWithAttributes(
      cone, TheTypePolymakeCone
    );
    
    return cone;
    
end );


################################
##
## Displays and Views
##
################################

##
InstallMethod( ViewObj,
               "for homalg cones",
               [ IsHomalgCone ],
               
  function( cone )
    local str;
    
    Print( "<A" );
    
    if HasIsSmooth( cone ) then
        
        if IsSmooth( cone ) then
            
            Print( " smooth" );
            
        fi;
        
    fi;
    
    if HasIsPointedCone( cone ) then
        
        if IsPointedCone( cone ) then
            
            Print( " pointed" );
            
        fi;
        
    fi;
    
    Print( " cone" );
    
    if HasConeDimension( cone ) then
        
        Print( " of dimension ", String( ConeDimension( cone ) ) );
        
    fi;
    
    if HasRayGenerators( cone ) then
        
        Print( " with ", String( Length( RayGenerators( cone ) ) )," ray generators" );
        
    fi;
    
    Print( ".>" );
    
end );

##
InstallMethod( Display,
               "for homalg cones",
               [ IsHomalgCone ],
               
  function( cone )
    local str;
    
    Print( "A" );
    
    if HasIsSmooth( cone ) then
        
        if IsSmooth( cone ) then
            
            Print( " smooth" );
            
        fi;
        
    fi;
    
    if HasIsPointedCone( cone ) then
        
        if IsPointedCone( cone ) then
            
            Print( " pointed" );
            
        fi;
        
    fi;
    
    Print( " cone" );
    
    if HasConeDimension( cone ) then
        
        Print( " of dimension ", String( ConeDimension( cone ) ) );
        
    fi;
    
    if HasRayGenerators( cone ) then
        
        Print( " with ray generators ", String( RayGenerators( cone ) ) );
        
    fi;
    
    Print( ".\n" );
    
end );