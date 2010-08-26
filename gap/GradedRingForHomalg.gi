#############################################################################
##
##  GradedRingForHomalg.gd  GradedRingForHomalg package      Mohamed Barakat
##                                                    Markus Lange-Hegermann
##
##  Copyright 2010,
##
##  Implementation stuff for GradedRingForHomalg.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

##
InstallValue( HOMALG_GRADED_RING,
        rec(
           )
);

##
InstallValue( CommonHomalgTableForGradedRings,
        rec(
            RingName :=
              function( S )
                
                if HasName( S ) then
                    return Name( S );
                fi;
                
                return Concatenation( RingName( UnderlyingNonGradedRing( S ) ), "(with weights ", String( WeightsOfIndeterminates( S ) ), ")" );
                
              end,
              
         )
);

