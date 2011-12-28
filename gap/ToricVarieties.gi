#############################################################################
##
##  ToricVariety.gi         ToricVarietiesForHomalg package         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  The Category of toric Varieties
##
#############################################################################

#################################
##
## Representations
##
#################################

DeclareRepresentation( "IsSheafRep",
                       IsToricVariety and IsAttributeStoringRep,
                       [ "Sheaf" ]
                      );

DeclareRepresentation( "IsCombinatoricalRep",
                       IsToricVariety and IsAttributeStoringRep,
                       [ "ConvexObject" ]
                      );

DeclareRepresentation( "IsFanRep",
                       IsCombinatoricalRep,
                       []
                      );

##################################
##
## Family and Type
##
##################################

BindGlobal( "TheFamilyOfToricVarietes",
        NewFamily( "TheFamilyOfToricVarietes" , IsToricVariety ) );

BindGlobal( "TheTypeFanToricVariety",
        NewType( TheFamilyOfToricVarietes,
                 IsFanRep ) );

##################################
##
## Properties
##
##################################

##
InstallMethod( IsAffine,
               " for convex varieties",
               [ IsFanRep ],
               
  function( vari )
    local conv;
    
    conv := UnderlyingConvexObject( vari );
    
    if Length( MaximalCones( conv ) ) = 1 then
        
        return true;
        
    fi;
    
    return false;
    
end );

##
InstallMethod( IsProjective,
               " for convex varieties",
               [ IsFanRep ],
               
  function( vari )
    
    return IsRegular( UnderlyingConvexObject( vari ) );
    
end );

##
InstallMethod( IsSmooth,
               " for convex varieties",
               [ IsFanRep ],
               
  function( vari )
    
    return IsSmooth( UnderlyingConvexObject( vari ) );
    
end );

##
InstallMethod( IsComplete,
               " for convex varieties",
               [ IsFanRep ],
               
  function( vari )
    
    return IsComplete( UnderlyingConvexObject( vari ) );
    
end );

##
InstallMethod( HasTorusfactor,
               " for convex varieties",
               [ IsFanRep ],
               
  function( vari )
    local ret;
    
    ret := IsFullDimensional( UnderlyingConvexObject( vari ) );
    
    if ret then
        
        SetDimensionOfTorusfactor( vari, 0 );
        
    fi;
    
    return not ret;
    
end );

##################################
##
## Attributes
##
##################################

##
InstallMethod( Dimension,
               " for convex varieties",
               [ IsFanRep ],
               
  function( vari )
    
    return ContainingSpaceDimension( UnderlyingConvexObject( vari ) );
    
end );

##
InstallMethod( DimensionOfTorusfactor,
               "for convex varieties",
               [ IsFanRep ],
               
  function( vari )
    local dim, cdim;
    
    if not HasTorusfactor( vari ) then
        
        return 0;
    fi;
    
    dim := Dimension( UnderlyingConvexObject( vari ) );
    
    cdim := Dimension( vari );
    
    return cdim - dim;
    
end );

##
InstallMethod( AffineOpenCovering,
               " for convex varieties",
               [ IsFanRep ],
               
  function( vari )
    local cones;
    
    cones := MaximalCones( UnderlyingConvexObject( vari ) );
    
    return List( cones, ToricVariety );
    
end );

##################################
##
## Methods
##
##################################

##
InstallMethod( UnderlyingConvexObject,
               " getter for convex object",
               [ IsToricVariety ],
               
  function( var )
    
    if IsBound( var!.ConvexObject ) then
        
        return var!.ConvexObject;
        
    else
        
        Error( " no combinatorical object." );
        
    fi;
    
end );

##
InstallMethod( UnderlyingSheaf,
               " getter for the sheaf",
               [ IsToricVariety ],
               
  function( var )
    
    if IsBound( var!.Sheaf ) then
        
        return var!.Sheaf;
        
    else
        
        Error( " no sheaf." );
        
    fi;
    
end );

##################################
##
## Constructors
##
##################################

##
InstallMethod( ToricVariety,
               " for homalg fans",
               [ IsHomalgFan ],
               
  function( fan )
    local var;
    
    if not IsPointed( fan ) then
        
        Error( " input fan must only contain strictly convex cones." );
        
    fi;
    
    var := rec(
                ConvexObject := fan
               );
    
    ObjectifyWithAttributes( 
                             var, TheTypeFanToricVariety
                            );
    
    return var;
    
end );

#################################
##
## Display
##
#################################

##
InstallMethod( ViewObj,
               " for toric varieties",
               [ IsToricVariety ],
               
  function( var )
    
    Print( "<A" );
    
    if HasIsAffine( var ) then
        
        if IsAffine( var ) then
            
            Print( "n affine");
            
        fi;
        
    fi;
    
    if HasIsSmooth( var ) then
        
        if IsSmooth( var ) then
            
            Print( " smooth");
            
        fi;
        
    fi;
    
    if HasIsProjective( var ) then
        
        if IsProjective( var ) then
            
            Print( " projective");
            
        fi;
        
    fi;
    
    if HasIsComplete( var ) then
        
        if IsComplete( var ) then
            
            Print( " complete");
            
        fi;
        
    fi;
    
    Print( " toric variety" );
    
    Print( ">" );
    
end );

##
InstallMethod( Display,
               " for toric varieties",
               [ IsToricVariety ],
               
  function( var )
    
    Print( "A" );
    
    if HasIsAffine( var ) then
        
        if IsAffine( var ) then
            
            Print( "n affine");
            
        fi;
        
    fi;
    
    if HasIsSmooth( var ) then
        
        if IsSmooth( var ) then
            
            Print( " smooth");
            
        fi;
        
    fi;
    
    if HasIsProjective( var ) then
        
        if IsProjective( var ) then
            
            Print( " projective");
            
        fi;
        
    fi;
    
    if HasIsComplete( var ) then
        
        if IsComplete( var ) then
            
            Print( " complete");
            
        fi;
        
    fi;
    
    Print( " toric variety" );
    
    Print( "." );
    
end );
