# SPDX-License-Identifier: GPL-2.0-or-later
# MatricesForHomalg: Matrices for the homalg project
#
# Implementations
#

####################################
#
# representations:
#
####################################

# a new representation for the GAP-category IshomalgTable:
DeclareRepresentation( "IshomalgTableRep",
        IshomalgTable,
        [ "ring" ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfHomalgTables",
        NewFamily( "TheFamilyOfHomalgTables" ) );

# a new type:
BindGlobal( "TheTypeHomalgTable",
        NewType( TheFamilyOfHomalgTables,
                IshomalgTableRep ) );

####################################
#
# View, Print, and Display methods:
#
####################################

InstallMethod( ViewObj,
        "for homalg ring package conversion tables",
        [ IshomalgTableRep ],
        
  function( o )
    
    Print( "<A homalg ring package conversion table>" );
    
end );
