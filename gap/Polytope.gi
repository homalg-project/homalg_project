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

##
InstallMethod( IsNotEmpty,
               " for external polytopes.",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    return EXT_IS_NOT_EMPTY_POLYTOPE( polytope );
    
end );

##
InstallMethod( IsVeryAmple,
               " for external polytopes.",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    return EXT_IS_VERY_AMPLE_POLYTOPE( polytope );
    
end );

##
InstallMethod( IsNormalPolytope,
               " for external polytopes.",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    return EXT_IS_NORMAL_POLYTOPE( polytope );
    
end );

##
InstallMethod( IsSimplicial,
               " for external polytopes.",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    return EXT_IS_SIMPLICIAL_POLYTOPE( polytope );
    
end );

##
InstallMethod( IsSimplePolytope,
               " for external polytopes.",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    return EXT_IS_SIMPLE_POLYTOPE( polytope );
    
end );

##
InstallMethod( IsLatticePolytope,
               " for external polytopes.",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    return EXT_IS_LATTICE_POLYTOPE( polytope );
    
end );

####################################
##
## Attribute
##
####################################

##
InstallMethod( LatticePoints,
               "for external polytopes",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    return EXT_LATTICE_POINTS_OF_POLYTOPE( polytope );
    
end );

##
InstallMethod( Vertices,
               "for external polytopes",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    return EXT_VERTICES_OF_POLYTOPE( polytope );
    
end );

##
InstallMethod( FacetInequalities,
               " for external polytopes",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    return EXT_FACET_INEQUALITIES_OF_POLYTOPE( polytope );
    
end );

##
InstallMethod( VerticesInFacets,
               " for external polytopes",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    return EXT_VERTICES_IN_FACETS( polytope );
    
end );

##
InstallMethod( NormalFan,
               " for external polytopes",
               [ IsHomalgPolytope ],
               
  function( polytope )
    local ineqs, vertsinfacs, fan, i, aktcone, j;
    
    ineqs := FacetInequalities( polytope );
    
    ineqs := List( ineqs, i -> i{ [ 2 .. Length( i ) ] } );
    
    vertsinfacs := VerticesInFacets( polytope );
    
    fan := [ ];
    
    for i in vertsinfacs do
        
        aktcone := [ ];
        
        for j in [ 1 .. Length( i ) ] do
            
            if i[ j ] = 1 then
                
                Add( aktcone, ineqs[ j ] );
                
            fi;
            
        od;
        
        Add( fan, aktcone );
        
    od;
    
    fan := HomalgFan( fan );
    
    SetIsRegularFan( fan, true );
    
    SetIsComplete( fan, true );
    
    return fan;
    
end );

##
InstallMethod( AffineCone,
               " for homalg polytopes",
               [ IsHomalgPolytope ],
               
  function( polytope )
    local cone, newcone, i, j;
    
    cone := LatticePoints( polytope );
    
    newcone := [ ];
    
    for i in cone do
        
        j := ShallowCopy( i );
        
        Add( j, 1 );
        
        Add( newcone, j );
        
    od;
    
    return HomalgCone( newcone );
    
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
    
    if HasIsNotEmpty( polytope ) then
        
        if IsNotEmpty( polytope ) then
            
            Print( " not empty" );
            
        fi;
    
    fi;
    
    if HasIsNormalPolytope( polytope ) then
        
        if IsNormalPolytope( polytope ) then
            
            Print( " normal" );
            
        fi;
    
    fi;
    
    if HasIsSimplicial( polytope ) then
        
        if IsSimplicial( polytope ) then
            
            Print( " simplicial" );
            
        fi;
    
    fi;
    
    if HasIsSimplePolytope( polytope ) then
        
        if IsSimplePolytope( polytope ) then
            
            Print( " simple" );
            
        fi;
    
    fi;
    
    if HasIsVeryAmple( polytope ) then
        
        if IsVeryAmple( polytope ) then
            
            Print( " very ample" );
            
        fi;
    
    fi;
    
    Print( " " );
    
    if HasIsLatticePolytope( polytope) then
        
        if IsLatticePolytope( polytope ) then
            
            Print( "lattice" );
            
        fi;
        
    fi;
    
    Print( "polytope" );
    
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
    
    if HasIsNotEmpty( polytope ) then
        
        if IsNotEmpty( polytope ) then
            
            Print( " not empty" );
            
        fi;
    
    fi;
    
    if HasIsNormalPolytope( polytope ) then
        
        if IsNormalPolytope( polytope ) then
            
            Print( " normal" );
            
        fi;
    
    fi;
    
    if HasIsSimplicial( polytope ) then
        
        if IsSimplicial( polytope ) then
            
            Print( " simplicial" );
            
        fi;
    
    fi;
    
    if HasIsSimplePolytope( polytope ) then
        
        if IsSimplePolytope( polytope ) then
            
            Print( " simple" );
            
        fi;
    
    fi;
    
    if HasIsVeryAmple( polytope ) then
        
        if IsVeryAmple( polytope ) then
            
            Print( " very ample" );
            
        fi;
    
    fi;
    
    Print( " " );
    
    if HasIsLatticePolytope( polytope) then
        
        if IsLatticePolytope( polytope ) then
            
            Print( "lattice" );
            
        fi;
        
    fi;
    
    Print( "polytope" );
    
    if HasVertices( polytope ) then
        
        Print( " with ", String( Length( Vertices( polytope ) ) )," vertices" );
        
    fi;
    
    Print( ".\n" );
    
end );