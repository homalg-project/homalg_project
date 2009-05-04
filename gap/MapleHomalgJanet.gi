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

  function( ext_ring_obj )
    local RP, RP_Basic, RP_General, RP_BestBasis, RP_specific, component;
    
    RP := ShallowCopy( CommonHomalgTableForMapleHomalgTools );
    
    RP_General := ShallowCopy( CommonHomalgTableForRings );
    
    RP_Basic := ShallowCopy( CommonHomalgTableForMapleHomalgBasic );
    
    RP_BestBasis := ShallowCopy( CommonHomalgTableForMapleHomalgBestBasis );
    
    RP_specific :=
          rec(
               ## Must only then be provided by the RingPackage in case the default
               ## "service" function does not match the Ring
               
               MinusOne := HomalgExternalRingElement( "-1", "Maple" ),	## FIXME: sounds ridiculous but we have no other choice at the moment: the Janet package uses jmulmat which comes from the jets package's mulmat and is only meant to multiply a matrix differential operator by a scalar e.g. "-1" and not "[[-1,[]]]"
               
               
               ## Can optionally be provided by the RingPackage
               ## (homalg functions check if these functions are defined or not)
               ## (homalgTable gives no default value)
               
               RingName := R -> Concatenation( "B(", homalgSendBlocking( [ "op(", R, "[1])" ], HOMALG_IO.Pictograms.variables, "need_output" ), ")" ),
               
               AreEqualMatrices :=
                 function( A, B )
                   local R;
                   
                   R := HomalgRing( A );
                   
                   return homalgSendBlocking( [ "`homalg/AreEqualMatrices`(", A, B, R, ")" ] , HOMALG_IO.Pictograms.AreEqualMatrices, "need_output" ) = "true";
                   
                 end,
               
               IsZeroMatrix :=
                 function( M )
                   local R;
                   
                   R := HomalgRing( M );
                   
                   return homalgSendBlocking( [ "`homalg/IsZeroMatrix`(", M, R, ")" ], HOMALG_IO.Pictograms.IsZeroMatrix, "need_output" ) = "true";
                   
                 end,
               
          );
    
    for component in NamesOfComponents( RP_General ) do
        RP.(component) := RP_General.(component);
    od;
    
    for component in NamesOfComponents( RP_Basic ) do
        RP.(component) := RP_Basic.(component);
    od;
    
    for component in NamesOfComponents( RP_specific ) do
        RP.(component) := RP_specific.(component);
    od;
    
    Objectify( TheTypeHomalgTable, RP );
    
    return RP;
    
end );
