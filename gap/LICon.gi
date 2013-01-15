#############################################################################
##
##  LICon.gd         ConvexForHomalg package         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  logical implications for cones.
##
#############################################################################

##
InstallImmediateMethod( IsComplete,
                        IsCone and IsPointed,
                        0,
                        
  function( i )
    
    return false;
    
end );

