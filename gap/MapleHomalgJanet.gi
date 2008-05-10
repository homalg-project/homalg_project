#############################################################################
##
##  MapleHomalgJanet.gi       RingsForHomalg package         Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations for the rings provided by the Maple package Janet
##  accessed via the Maple implementation of homalg.
##
#############################################################################

####################################
#
# constructor functions and methods:
#
####################################

InstallMethod( CreateHomalgTable,
        "for homalg rings provided by the maple package Janet",
        [ IsHomalgExternalRingObjectInMapleUsingJanetRep ],

  function( arg )
    local RP, RP_default, RP_BestBasis, RP_specific, component;
    
    RP := ShallowCopy( CommonHomalgTableForMapleHomalgTools );
    
    RP_default := ShallowCopy( CommonHomalgTableForMapleHomalgDefault );
    
    RP_BestBasis := ShallowCopy( CommonHomalgTableForMapleHomalgBestBasis );
    
    RP_specific :=
          rec(
               ## Must only then be provided by the RingPackage in case the default
               ## "service" function does not match the Ring
               
               MinusOne := HomalgExternalRingElement( "-1", "Maple" ),	## FIXME: sounds ridiculous but we have no other choice at the moment: the Janet package uses jmulmat which comes from the jets package's mulmat and is only meant to multiply a matrix differential operator by a scalar e.g. "-1" and not "[[-1,[]]]"
               
               
               ## Can optionally be provided by the RingPackage
               ## (homalg functions check if these functions are defined or not)
               ## (homalgTable gives no default value)
               
               RingName := R -> Concatenation( "B(", homalgSendBlocking( [ "op(", R, "[1])" ], HOMALG_IO.Pictograms.variables, "need_output" ), ")" )
               
          );
    
    for component in NamesOfComponents( RP_default ) do
        RP.(component) := RP_default.(component);
    od;
    
    for component in NamesOfComponents( RP_specific ) do
        RP.(component) := RP_specific.(component);
    od;
    
    Objectify( TheTypeHomalgTable, RP );
    
    return RP;
    
end );
