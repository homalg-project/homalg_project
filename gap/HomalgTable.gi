#############################################################################
##
##  HomalgTable.gi          homalg package                   Mohamed Barakat
##
##  Copyright 2007 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for rings.
##
#############################################################################

###############
# declarations:
###############

# a new representation for the category IsHomalgTable:
DeclareRepresentation( "IsHomalgTableRep",
        IsHomalgTable,
        [ "ring" ] );

# a new family:
BindGlobal( "HomalgTableFamily",
        NewFamily( "HomalgTableFamily" ));

# a new type:
BindGlobal( "HomalgTableType",
        NewType( HomalgTableFamily,
                IsHomalgTableRep ));

######################
# constructor methods:
######################

InstallMethod( CreateHomalgTable,
        "for rings",
        [ IsSemiringWithOneAndZero ],
        
  function ( arg )
    local RP;
    
    RP := rec( ring := arg[1] );
    
    Objectify( HomalgTableType, RP );
    
    return RP;
    
end );

##
InstallMethod( BasisOfModule,
        "for homalg tables",
        [ IsHomalgTable ],
        
  function( RP )
    
    return BasisOfModule;
    
end );

##
InstallMethod( CertainRows,
        "for homalg tables",
        [ IsHomalgTable ],
        
  function( RP )
    
    return CertainRows;
    
end );

##
InstallOtherMethod( RankOfGauss,
        "for sets of relations",
	[ IsObject ],
        
  function( M )
    
    return M.rank;
    
end );

##
InstallOtherMethod( BasisOfModule,
        "for a homalg module",
	[ IsModuleForHomalg ],
        
  function( M )
    
    return BasisOfModule(RelationsOfModule(M),LeftActingDomain(M));
    
end );
          
###################################
# View, Print, and Display methods:
###################################

InstallMethod( ViewObj,
        "for a homalg ring package conversion table",
        [ IsHomalgTable ],
        
  function( o )
    
    Print("<A homalg ring package conversion table>");
    
end );

