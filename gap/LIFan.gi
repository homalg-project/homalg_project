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
InstallImmediateMethod( IsRegular,
                        IsFan and HasIsComplete,
                        0,
                        
  function( fan )
    
    if not IsComplete( fan ) then
        
        return false;
        
    fi;
    
    TryNextMethod();
    
end );
