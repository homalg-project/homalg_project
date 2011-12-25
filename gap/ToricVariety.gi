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
                       [ "Sheaf" ],
                      );

DeclareRepresentation( "IsCombinatoricalRep",
                       IsToricVariety and IsAttributeStoringRep,
                       [ "ConvexObject" ]
                      );

##################################
##
## Family and Type
##
##################################

BindGlobal( "TheFamilyOfToricVarietes",
        NewFamily( "TheFamilyOfToricVarietes" , IsToricVariety ) );

BindGlobal( "TheTypeCombinatoricalToricVarietes",
        NewType( TheFamilyOfToricVarietes,
                 IsToricVariety and IsCombinatoricalRep ) );

##################################
##
## Properties
##
##################################


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
               " getter for the sheaf"
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

