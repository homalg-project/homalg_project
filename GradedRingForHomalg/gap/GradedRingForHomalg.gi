#############################################################################
##
##  GradedRingForHomalg.gi  GradedRingForHomalg package      Mohamed Barakat
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

HOMALG_IO.Pictograms.DegreesOfEntries := "doe"; ## degrees of entries
HOMALG_IO.Pictograms.NonTrivialDegreePerRow := "dpr"; ## degree of the first non-trivial entry per row
HOMALG_IO.Pictograms.NonTrivialDegreePerColumn := "dpc"; ## degree of the first non-trivial entry per column
HOMALG_IO.Pictograms.LinearSyzygiesGenerators := "lsy"; ## linear syzygies

##
InstallValue( CommonHomalgTableForGradedRings,
        rec(
            RingName :=
              function( S )
                local w;
                
                if HasName( S ) then
                    return Name( S );
                fi;
                
                w := WeightsOfIndeterminates( S );
                if w <> [] then
                    return Concatenation( RingName( UnderlyingNonGradedRing( S ) ), " (with weights ", String( WeightsOfIndeterminates( S ) ), ")" );
                else
                    return RingName( UnderlyingNonGradedRing( S ) );
                fi;
                
              end,
              
         )
);

