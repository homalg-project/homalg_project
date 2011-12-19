#############################################################################
##
##  Fan.gi         ConvexForHomalg package         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Fans for ConvexForHomalg.
##
#############################################################################

####################################
##
## Reps
##
####################################

DeclareRepresentation( "IsExternalFanRep",
                       IsHomalgFan and IsExternalConvexObjectRep,
                       [ ]
                      );

DeclareRepresentation( "IsPolymakeFanRep",
                       IsExternalFanRep,
                       [ ]
                      );

####################################
##
## Types and Families
##
####################################


BindGlobal( "TheFamilyOfFans",
        NewFamily( "TheFamilyOfFans" , IsHomalgFan ) );

BindGlobal( "TheTypeExternalFan",
        NewType( TheFamilyOfFans,
                 IsHomalgFan and IsExternalFanRep ) );

BindGlobal( "TheTypePolymakeFan",
        NewType( TheFamilyOfFans,
                 IsPolymakeFanRep ) );