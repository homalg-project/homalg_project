InstallMethod( LocalizePolynomialRingAtZeroWithMora,
        "for homalg rings in Singular",
        [ IsHomalgExternalRingInSingularRep ],
  function( R )
    local var, Rloc, S, v, RP, c, n_gens, gens;

    RP := CreateHomalgTableForLocalizedRingsWithMora( R );
    
    Rloc := LocalizePolynomialRingAtZero( R );
    
    var := IndeterminatesOfPolynomialRing( R );
    
    S := CreateHomalgRing( Rloc, [ TheTypeHomalgLocalRing, TheTypeHomalgLocalMatrix ], HomalgLocalRingElement, RP );
    
    ## for the view method: <A homalg local matrix>
    S!.description := "local";
    
    S!.AssociatedGlobalRing := R;
    
    S!.AssociatedComputationRing := Rloc;
    
    SetIsLocalRing( S, true );
    
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

