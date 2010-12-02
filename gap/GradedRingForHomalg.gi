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

HOMALG_IO.Pictograms.MonomialMatrix := "mon"; ## create the i-th monomial matrix
HOMALG_IO.Pictograms.Diff := "dif";   ## differentiate a matrix M w.r.t. a matrix D

##
InstallValue( CommonHomalgTableForGradedRings,
        rec(
            RingName :=
              function( S )
                
                if HasName( S ) then
                    return Name( S );
                fi;
                
                return Concatenation( RingName( UnderlyingNonGradedRing( S ) ), "\t(with weights ", String( WeightsOfIndeterminates( S ) ), ")" );
                
              end,
              
         )
);

