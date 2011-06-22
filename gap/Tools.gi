#############################################################################
##
##  Tools.gi                    Modules package              Mohamed Barakat
##
##  Copyright 2009, Mohamed Barakat, Universität des Saarlandes
##
##  Implementations of tool procedures.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( AffineDimension,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP;
    
    if IsBound( M!.AffineDimension ) then
        return M!.AffineDimension;
    fi;
    
    R := HomalgRing( M );
    
    ## take care of zero matrices, especially of empty matrices
    if NrColumns( M ) = 0 then
        return -1;
    elif IsZero( M ) = 0 and HasKrullDimension( R ) then
        return KrullDimension( R );
    fi;
    
    RP := homalgTable( R );
    
    if IsBound(RP!.AffineDimension) then
        M!.AffineDimension := RP!.AffineDimension( M );
        return M!.AffineDimension;
    fi;
    
    if not IsHomalgInternalRingRep( R ) then
        Error( "could not find a procedure called AffineDimension ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( AffineDegree,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP;
    
    if IsBound( M!.AffineDegree ) then
        return M!.AffineDegree;
    fi;
    
    ## take care of zero matrices, especially of empty matrices
    if NrColumns( M ) = 0 then
        return 0;
    elif IsZero( M ) = 0 then
        return NrColumns( M );
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.AffineDegree) then
        M!.AffineDegree := RP!.AffineDegree( M );
        return M!.AffineDegree;
    fi;
    
    if not IsHomalgInternalRingRep( R ) then
        Error( "could not find a procedure called AffineDegree ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( ConstantTermOfHilbertPolynomial,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP;
    
    if IsBound( M!.ConstantTermOfHilbertPolynomial ) then
        return M!.ConstantTermOfHilbertPolynomial;
    fi;
    
    ## take care of zero matrices, especially of empty matrices
    if NrColumns( M ) = 0 then
        return 0;
    elif IsZero( M ) = 0 then
        return NrColumns( M );
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.ConstantTermOfHilbertPolynomial) then
        M!.ConstantTermOfHilbertPolynomial := RP!.ConstantTermOfHilbertPolynomial( M );
        return M!.ConstantTermOfHilbertPolynomial;
    fi;
    
    if not IsHomalgInternalRingRep( R ) then
        Error( "could not find a procedure called ConstantTermOfHilbertPolynomial ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( PrimaryDecompositionOp,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, one;
    
    if IsBound( M!.PrimaryDecomposition ) then
        return M!.PrimaryDecomposition;
    fi;
    
    R := HomalgRing( M );
    
    if IsZero( M ) then
        one := HomalgIdentityMatrix( 1, 1, R );
        M!.PrimaryDecomposition := [ [ one, one ] ];
        return M!.PrimaryDecomposition;
    fi;
    
    RP := homalgTable( R );
    
    if IsBound(RP!.PrimaryDecomposition) then
        M!.PrimaryDecomposition := RP!.PrimaryDecomposition( M );
        return M!.PrimaryDecomposition;
    fi;
    
    if not IsHomalgInternalRingRep( R ) then
        Error( "could not find a procedure called PrimaryDecomposition ",
               "in the homalgTable of the non-internal ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( PrimaryDecompositionOp,
        "for a homalg matrix over a residue class ring",
        [ IsHomalgResidueClassMatrixRep ],
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    return List( PrimaryDecompositionOp( Eval( M ) ), a -> List( a, b -> R * b ) );
    
end );
