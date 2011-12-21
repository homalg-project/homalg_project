#############################################################################
##
##  Polytope.gi         ConvexForHomalg package         Sebastian Gutsche
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

DeclareRepresentation( "IsExternalPolytopeRep",
                       IsHomalgPolytope and IsExternalConvexObjectRep,
                       [ ]
                      );

DeclareRepresentation( "IsPolymakePolytopeRep",
                       IsExternalPolytopeRep,
                       [ ]
                      );

####################################
##
## Types and Families
##
####################################


BindGlobal( "TheFamilyOfPolytopes",
        NewFamily( "TheFamilyOfPolytopes" , IsHomalgPolytope ) );

BindGlobal( "TheTypeExternalPolytope",
        NewType( TheFamilyOfPolytopes,
                 IsHomalgPolytope and IsExternalPolytopeRep ) );

BindGlobal( "TheTypePolymakePolytope",
        NewType( TheFamilyOfPolytopes,
                 IsPolymakePolytopeRep ) );

####################################
##
## Properties
##
####################################

InstallMethod( IsVeryAmple,
               " for external polytopes.",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    return EXT_IS_VERY_AMPLE_POLYTOPE( polytope );
    
end );

####################################
##
## Attribute
##
####################################

InstallMethod( LatticePoints,
               "for external polytopes",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    return EXT_LATTICE_POINTS_OF_POLYTOPE( polytope );
    
end );

####################################
##
## Constructors
##
####################################

##
InstallMethod( HomalgPolytope,
               "creates a PolymakePolytope.",
               [ IsList ],
               
  function( pointlist )
    local polyt;
    
    polyt := EXT_CREATE_POLYTOPE_BY_POINTS( pointlist );
    
    polyt := rec( WeakPointerToExternalObject := polyt );
    
     ObjectifyWithAttributes( 
        polyt, TheTypePolymakePolytope
     );
     
     return polyt;
     
end );


##
InstallMethod( HomalgPolytopeByInequalities,
               "creates a PolymakePolytope.",
               [ IsList ],
               
  function( pointlist )
    local polyt;
    
    polyt := EXT_CREATE_POLYTOPE_BY_INEQUALITIES( pointlist );
    
    polyt := rec( WeakPointerToExternalObject := polyt );
    
     ObjectifyWithAttributes( 
        polyt, TheTypePolymakePolytope
     );
     
     return polyt;
     
end );

####################################
##
## Display Methods
##
####################################

##
InstallMethod( ViewObj,
               "for homalg polytopes",
               [ IsHomalgPolytope ],
               
  function( polytope )
    local str;
    
    Print( "<A" );
    
    if HasIsVeryAmple( polytope ) then
        
        if IsVeryAmple( polytope ) then
            
            Print( " very ample" );
            
        fi;
    
    fi;
    
    Print( " polytope" );
    
    if HasVertices( polytope ) then
        
        Print( " with ", String( Length( Vertices( polytope ) ) )," vertices" );
        
    fi;
    
    Print( ">" );
    
end );

##
InstallMethod( Display,
               "for homalg polytopes",
               [ IsHomalgPolytope ],
               
  function( polytope )
    local str;
    
    Print( "A" );
    
    if HasIsVeryAmple( polytope ) then
        
        if IsVeryAmple( polytope ) then
            
            Print( " very ample" );
            
        fi;
    
    fi;
    
    Print( " polytope" );
    
    if HasVertices( polytope ) then
        
        Print( " with ", String( Length( Vertices( polytope ) ) )," vertices" );
        
    fi;
    
    Print( ".\n" );
    
end );