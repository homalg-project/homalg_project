#############################################################################
##
##  LITorDiv.gi     ToricVarieties       Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Logical implications for toric divisors
##
#############################################################################

#############################
##
## True methods
##
#############################

##
## <=
##

##
InstallTrueMethod( IsCartier, IsPrincipal );

##
InstallTrueMethod( IsBasepointFree, IsAmple );

##
InstallTrueMethod( IsNumericallyEffective, IsBasepointFree );

#############################
##
## Immediate Methods
##
#############################

##
InstallImmediateMethod( IsPrincipal,
                        IsToricDivisor and IsCartier,
                        0,
  function( divi )
    local ambvari;
    
    ambvari := AmbientToricVariety( divi );
    
    if HasIsAffine( ambvari ) then
        
        if IsAffine( ambvari ) then
            
            return true;
            
        fi;
        
    fi;
    
    TryNextMethod( );
    
end );

