#############################################################################
##
##  ToolFunctors.gi            homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for some tool functors.
##
#############################################################################

####################################
#
# install global functions/variables:
#
####################################

##
## AsComplex
##

InstallGlobalFunction( _Functor_AsComplex_OnObjects,	### defines: AsComplex
  function( phi, psi )
    local R, pre, post, C;
    
    R := HomalgRing( phi );
    
    if not IsIdenticalObj( R, HomalgRing( psi ) ) then
        Error( "the rings of the two morphisms are not identical\n" );
    fi;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) and IsHomalgLeftObjectOrMorphismOfLeftObjects( psi ) then
        pre := phi;
        post := psi;
    elif IsHomalgRightObjectOrMorphismOfRightObjects( phi ) and IsHomalgRightObjectOrMorphismOfRightObjects( psi ) then
        pre := psi;
        post := phi;
    else
        Error( "the two morphisms must either be both left or both right morphisms\n" );
    fi;
    
    C := HomalgComplex( post );
    Add( C, pre );
    
    if HasIsMorphism( pre ) and IsMorphism( pre ) and
       HasIsMorphism( post ) and IsMorphism( post ) then
        SetIsSequence( C, true );
    fi;
    
    SetIsComplexForDefectOfExactness( C, true );
    
    return C;
    
end );

InstallValue( Functor_AsComplex,
        CreateHomalgFunctor(
                [ "name", "AsComplex" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsHomalgMap ] ] ],
                [ "2", [ [ "covariant" ], [ IsHomalgMap ] ] ],
                [ "OnObjects", _Functor_AsComplex_OnObjects ]
                )
        );

Functor_AsComplex!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

##
## AsChainMapForPullback
##

InstallGlobalFunction( _Functor_AsChainMapForPullback_OnObjects,	### defines: AsChainMapForPullback
  function( phi, beta1 )
    local R, S, T, c;
    
    R := HomalgRing( phi );
    
    if not IsIdenticalObj( R, HomalgRing( beta1 ) ) then
        Error( "the rings of the two morphisms are not identical\n" );
    fi;
    
    S := HomalgComplex( Source( phi ), 0 );
    T := HomalgComplex( beta1, 1 );
    
    c := HomalgChainMap( phi, S, T, 0 );
    
    if HasIsMorphism( phi ) and IsMorphism( phi ) and
       HasIsMorphism( beta1 ) and IsMorphism( beta1 ) then
        SetIsMorphism( c, true );
    fi;
    
    SetIsChainMapForPullback( c, true );
    
    return c;
    
end );

InstallValue( Functor_AsChainMapForPullback,
        CreateHomalgFunctor(
                [ "name", "AsChainMapForPullback" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsHomalgMap ] ] ],
                [ "2", [ [ "covariant" ], [ IsHomalgMap ] ] ],
                [ "OnObjects", _Functor_AsChainMapForPullback_OnObjects ]
                )
        );

Functor_AsChainMapForPullback!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

##
## AsChainMapForPushout
##

InstallGlobalFunction( _Functor_AsChainMapForPushout_OnObjects,	### defines: AsChainMapForPushout
  function( alpha1, psi )
    local R, S, T, c;
    
    R := HomalgRing( psi );
    
    if not IsIdenticalObj( R, HomalgRing( alpha1 ) ) then
        Error( "the rings of the two morphisms are not identical\n" );
    fi;
    
    S := HomalgComplex( alpha1, 1 );
    T := HomalgComplex( Range( psi ), 1 );
    
    c := HomalgChainMap( psi, S, T, 1 );
    
    if HasIsMorphism( psi ) and IsMorphism( psi ) and
       HasIsMorphism( alpha1 ) and IsMorphism( alpha1 ) then
        SetIsMorphism( c, true );
    fi;
    
    SetIsChainMapForPushout( c, true );
    
    return c;
    
end );

InstallValue( Functor_AsChainMapForPushout,
        CreateHomalgFunctor(
                [ "name", "AsChainMapForPushout" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "covariant" ], [ IsHomalgMap ] ] ],
                [ "2", [ [ "covariant" ], [ IsHomalgMap ] ] ],
                [ "OnObjects", _Functor_AsChainMapForPushout_OnObjects ]
                )
        );

Functor_AsChainMapForPushout!.ContainerForWeakPointersOnComputedBasicObjects :=
  ContainerForWeakPointers( TheTypeContainerForWeakPointersOnComputedValuesOfFunctor );

####################################
#
# methods for operations & attributes:
#
####################################

##
## AsComplex( phi, psi )
##

InstallFunctorOnObjects( Functor_AsComplex );

##
## AsChainMapForPullback( phi, beta1 )
##

InstallFunctorOnObjects( Functor_AsChainMapForPullback );

##
## AsChainMapForPushout( alpha1, psi )
##

InstallFunctorOnObjects( Functor_AsChainMapForPushout );

