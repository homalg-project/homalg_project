#############################################################################
##
##  LIGrMAT.gi                  LIGrMAT subpackage           Mohamed Barakat
##                                                    Markus Lange-Hegermann
##
##         LIGrMAT = Logical Implications for homalg Graded MATrices
##
##  Copyright 2010, Mohamed Barakat, University of Kaiserslautern
##           Markus Lange-Hegermann, RWTH-Aachen University
##
##  Implementations for the LIGrMAT subpackage.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( LIGrMAT,
        rec(
            color := "\033[4;30;46m",
            intrinsic_properties := LIMAT.intrinsic_properties,
            intrinsic_attributes := LIMAT.intrinsic_attributes,
            )
        );

Append( LIGrMAT.intrinsic_properties,
        [ 
          ] );

Append( LIGrMAT.intrinsic_attributes,
        [ 
          ] );

####################################
#
# methods for properties:
#
####################################

####################################
#
# methods for attributes:
#
####################################

