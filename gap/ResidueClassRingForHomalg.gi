#############################################################################
##
##  ResidueClassRingForHomalg.gi  MatricesForHomalg package  Mohamed Barakat
##
##  Copyright 2007-2009 Mohamed Barakat, Universität des Saarlandes
##
##  Implementation stuff for homalg residue class rings.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

##
InstallValue( HOMALG_RESIDUE_CLASS_RING,
        rec(
           )
);

##
InstallValue( CommonHomalgTableForResidueClassRings,
        rec(
            RingName :=
              function( R )
                local ring_rel, name;
                
                ring_rel := RingRelations( R );
                ring_rel := MatrixOfRelations( ring_rel );
                ring_rel := EntriesOfHomalgMatrix( ring_rel );
                
                if ring_rel = [ ] then
                    ring_rel := "0";
                elif IsHomalgInternalRingRep( AmbientRing( R ) ) then
                    ring_rel := JoinStringsWithSeparator( List( ring_rel, String ), ", " );
                else
                    ring_rel := JoinStringsWithSeparator( List( ring_rel, Name ), ", " );
                fi;
                
                name := RingName( AmbientRing( R ) );
                
                return String( Concatenation( name, "/( ", ring_rel, " )" ) );
                
            end,
              
         )
);

