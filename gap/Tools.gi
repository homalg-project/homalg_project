#############################################################################
##
##  Tools.gi                    homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations of homalg tools.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( CertainRows,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep, IsList ],
        
  function( M, plist )
    local R, RP;
    
    R := M!.ring;
    
    RP := HomalgTable( R );
  
    if IsBound( RP!.CertainRows ) then
        return RP!.CertainRows( M, plist );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    return MatrixForHomalg( Eval( M ){plist}, M!.ring );
    
end );

