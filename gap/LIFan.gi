#############################################################################
##
##  LIFan.gd         ConvexForHomalg package         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  logical implications for Fans.
##
#############################################################################

############################
##
## True Methods
##
############################

##
InstallTrueMethod( IsSimplicial, IsSmooth );

############################
##
## True Methods
##
############################

##
InstallImmediateMethod( IsRegularFan,
                        IsFan and HasIsComplete,
                        0,
                        
  function( fan )
    
    if not IsComplete( fan ) then
        
        return false;
        
    elif AmbientSpaceDimension( fan ) <= 2 then
        
        return true;
        
    fi;
    
    TryNextMethod();
    
end );
