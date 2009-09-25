#############################################################################
##
##  ResidueClassRingForHomalg.gi   homalg package            Mohamed Barakat
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
                local ring_rel, l, name;
                
                ring_rel := RingRelations( R );
                ring_rel := MatrixOfRelations( ring_rel );
                ring_rel := EntriesOfHomalgMatrix( ring_rel );
                
                l := Length( ring_rel );
                
                if ring_rel = [ ] then
                    TryNextMethod( );
                elif IsHomalgInternalRingRep( AmbientRing( R ) ) then
                    ring_rel := Concatenation( Flat( List( ring_rel{[ 1 .. l - 1 ]}, a -> Concatenation( " ", String( a ), "," ) ) ), Concatenation( " ", String( ring_rel[l] ) ) );
                else
                    ring_rel := Concatenation( Flat( List( ring_rel{[ 1 .. l - 1 ]}, a -> Concatenation( " ", Name( a ), "," ) ) ), Concatenation( " ", Name( ring_rel[l] ) ) );
                fi;
                
                name := RingName( AmbientRing( R ) );
                
                return Flat( [ name, "/(", ring_rel, " )" ] );
                
            end,
              
         )
);

