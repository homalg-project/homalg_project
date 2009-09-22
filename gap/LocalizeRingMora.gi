InstallMethod( LocalizePolynomialRingAtZeroWithMora,
        "for homalg rings in Singular",
        [ IsHomalgExternalRingInSingularRep ],
  function( R )
    local var, properties, stream, ext_obj, Rloc, S, v, RP, c, n_gens, gens;

    #check whether base ring is polynomial and then extract needed data
    if HasIndeterminatesOfPolynomialRing( R ) and IsCommutative( R ) then
      var := IndeterminatesOfPolynomialRing( R );
    else
      Error( "base ring is not a polynomial ring" );
    fi;
    
    properties := [ IsCommutative, IsLocalRing ];
    
    if Length( var ) <= 1 then
        Add( properties, IsPrincipalIdealRing );
    fi;
    
    RP := CreateHomalgTableForLocalizedRingsWithMora( R );
    
    ## create the new ring
    ext_obj := homalgSendBlocking( [ Characteristic( R ), ",(", var, "),ds" ], [ "ring" ], R, properties, TheTypeHomalgExternalRingObjectInSingular, HOMALG_IO.Pictograms.CreateHomalgRing );
    
    ##!!create homalg external pseudo ring
    Rloc := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInSingular );
    
    _Singular_SetRing( Rloc );
    
    RP!.SetInvolution :=
      function( R )
        homalgSendBlocking( "\nproc Involution (matrix m)\n{\n  return(transpose(m));\n}\n\n", "need_command", Rloc, HOMALG_IO.Pictograms.define );
    end;
    
    S := CreateHomalgRing( Rloc, [ TheTypeHomalgLocalRing, TheTypeHomalgLocalMatrix ], HomalgLocalRingElement, RP );
    
    S!.AssociatedGlobalRing := R;
    
    S!.AssociatedComputationRing := Rloc;
    
    homalgSendBlocking( "option(redTail);short=0;", "need_command", R, HOMALG_IO.Pictograms.initialize );
    
    n_gens := Length( var );
    
    gens := HomalgMatrix( var, n_gens, 1, R );
    
    SetGeneratorsOfMaximalLeftIdeal( S, gens );
    
    gens := HomalgMatrix( var, 1, n_gens, R );
    
    SetGeneratorsOfMaximalRightIdeal( S, gens );
    
    return S;
    
end );

##
InstallMethod( CreateHomalgTableForLocalizedRingsWithMora,
        "for Singular rings",
        [ IsHomalgRing and IsCommutative and IsFreePolynomialRing ],
        
  function( globalR )
    local globalRP, RP, RP_General, RP_Basic, RP_specific, component;
    
    globalRP := homalgTable( globalR );
    
    RP := ShallowCopy( CommonHomalgTableForLocalizedRingsTools );
    
    RP_General := ShallowCopy( CommonHomalgTableForLocalizedRings );
    
    RP_Basic := ShallowCopy( CommonHomalgTableForLocalizedRingsBasic );
    
    RP_specific := rec (
                        Zero := globalRP!.Zero,

                        One := globalRP!.One,

                        MinusOne := globalRP!.MinusOne,
                        
#                         IsUnit :=
#                           function( R, u )
#                           local globalR;
#                             
#                             globalR := AssociatedComputationRing( R );
#                             
#                             return IsUnit( globalR, Numerator( u ) ) ;
#                             
#                           end,
                        
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

