#############################################################################
##
##  LIGrMOD.gi                    LIGrMOD subpackage
##
##         LIGrMOD = Logical Implications for Graded MODules
##
##  Copyright 2010,      Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
##  Implementation stuff for the LIGrMOD subpackage.
##
#############################################################################



##
DeclareGlobalFunction( "InstallGradedModulesPropertiesMethods" );
InstallGlobalFunction( InstallGradedModulesPropertiesMethods, 
  function( prop );

  InstallImmediateMethod( prop,
          IsGradedModuleRep, 0,
          
    function( M )
    local U;
    
      U := UnderlyingModule( M );
      if Tester( prop )( U ) then
        return prop( U );
      else
        TryNextMethod();
      fi;
      
  end );
  
  InstallMethod( prop,
          "for homalg graded module maps",
          [ IsGradedModuleRep ],
          
    function( M )
      
      return prop( UnderlyingModule( M ) );
      
  end );

end );

             
for GRADEDMODULE_prop in [ 
     IsCyclic, IsZero, IsTorsionFree, IsArtinian, IsTorsion, IsPure, IsReflexive, IsHolonomic
   ] do
  InstallGradedModulesPropertiesMethods( GRADEDMODULE_prop );
od;
Unbind( GRADEDMODULE_prop );