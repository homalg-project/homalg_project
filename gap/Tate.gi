#############################################################################
##
##  Tate.gi                     Sheaves package              Mohamed Barakat
##
##  Copyright 2008-2010, Mohamed Barakat, University of Kaiserslautern
##
##  Implementations of procedures for the pair of adjoint Tate functors.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( TateResolution,
        "for a coherent sheaf of modules",
        [ IsCoherentSheafRep, IsInt, IsInt ],
        
  function( E, degree_lowest, degree_highest )
    
    return TateResolution( UnderlyingModule( E ), degree_lowest, degree_highest );
    
end );

##
InstallMethod( TateResolution,
        "for a sheaf of rings",
        [ IsSheafOfRingsRep, IsInt, IsInt ],
        
  function( OX, degree_lowest, degree_highest )
    
    return TateResolution( AsModuleOverStructureSheafOfAmbientSpace( OX ), degree_lowest, degree_highest );
    
end );

##
InstallMethod( TateResolution,
        "for schemes",
        [ IsProjSchemeRep, IsInt, IsInt ],
        
  function( X, degree_lowest, degree_highest )
    
    return TateResolution( UnderlyingModule( X ), degree_lowest, degree_highest );
    
end );

