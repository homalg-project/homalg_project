#############################################################################
##
##  ExternalSystem.gd          ConvexForHomalg package      Sebastian Gutsche
##
##  Copyright 2011-2012 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declares Methods for an external CAS
##
#############################################################################


####################################
#
# Cone Methods
#
####################################


DeclareMethod( "EXT_GENERATE_CONE_BY_RAYS",
        [ IsList ] );
        
DeclareMethod( "EXT_CREATE_DUAL_CONE_OF_CONE",
        [ IsInt ] );

####################################
#
# Recover Methods
#
####################################
        
DeclareMethod( "EXT_GENERATING_RAYS_OF_CONE",
        [ IsInt ] );