#############################################################################
##
##  SymmetricAlgebra.gi                                      Modules package
##
##  Copyright 2013, Mohamed Barakat, University of Kaiserslautern
##
##  Implementations for symmetric powers.
##
#############################################################################

##
InstallMethod( SymmetricPower,
        "for free modules",
        [ IsInt, IsFinitelyPresentedModuleRep and IsFree ],
        
  function( k, M )
    local R, r, P, powers;
    
    if HasSymmetricPowers( M ) then
        powers := SymmetricPowers( M );
        if IsBound( powers!.( k ) ) then
            return powers!.( k );
        fi;
    else
        powers := rec( );
    fi;
    
    R := HomalgRing( M );
    r := Rank( M );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        P := HomalgFreeLeftModule( Binomial( r + k - 1, k ), R );
    else
        P := HomalgFreeRightModule( Binomial( r + k - 1, k ), R );
    fi;
    
    SetIsSymmetricPower( P, true );
    SetSymmetricPowerExponent( P, k );
    SetSymmetricPowerBaseModule( P, M );
    
    powers!.( k ) := P;
    SetSymmetricPowers( M, powers );
    
    return P;
end );

##
InstallMethod( SymmetricPower,
        "for free modules",
        [ IsInt, IsHomalgModule and IsStaticFinitelyPresentedSubobjectRep ],
        
  function( k, M )
    
    return SymmetricPower( k, UnderlyingObject( M ) );
    
end );

##
InstallMethod( SymmetricPowerOfPresentationMorphism,
        "for a homalg maps",
        [ IsInt, IsHomalgMap ],
        
  function( k, phi )
    local T, mat, R, one, g, r, bg, power, z0, z1, union_of_gens,
          certain_gens, union_of_rels, g_range, rr, power_rr, gg, pos;
    
    T := Range( phi );
    
    if k = 0 then
        return MatrixOfMap( PresentationMorphism( One( T ) ) );
    elif k = 1 then
        return MatrixOfMap( phi );
    elif not k in [ 2 .. NrGenerators( T ) ] then
        return MatrixOfMap( PresentationMorphism( Zero( T ) ) );
    fi;
    
    mat := MatrixOfMap( phi );
    
    R := HomalgRing( mat );
    
    one := One( R );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( T ) then
        g := NrColumns( mat );
        r := NrRows( mat );
        
        bg := Binomial( g + k - 1, k );
        
        power := HomalgZeroMatrix( 0, bg, R );
        z0 := HomalgZeroMatrix( r, 0, R );
        z1 := HomalgZeroMatrix( r, 1, R );
        
        union_of_gens := UnionOfColumns;
        certain_gens := CertainColumns;
        union_of_rels := UnionOfRows;
        
    else
        g := NrRows( mat );
        r := NrColumns( mat );
        
        bg := Binomial( g + k - 1, k );
        
        power := HomalgZeroMatrix( bg, 0, R );
        z0 := HomalgZeroMatrix( 0, r, R );
        z1 := HomalgZeroMatrix( 1, r, R );
        
        union_of_gens := UnionOfRows;
        certain_gens := CertainRows;
        union_of_rels := UnionOfColumns;
        
    fi;
    
    g_range := [ 1 .. g ];
    
    for rr in UnorderedTuples( g_range, k - 1 ) do
        rr := Collected( rr );
        power_rr := z0;
        for gg in UnorderedTuples( g_range, k ) do
            gg := Collected( gg );
            pos := Union( Difference( gg, rr ), Difference( rr, gg ) );
            ## this one way to implement IsSublist;
            ## if you intend to change this code you need check the correctness
            ## of the third power, at least
            if Length( pos ) = 1 or ( Length( pos ) = 2 and pos[1][1] = pos[2][1] ) then
                power_rr := union_of_gens( power_rr, certain_gens( mat, [ pos[1][1] ] ) );
            else
                power_rr := union_of_gens( power_rr, z1 );
            fi;
        od;
        power := union_of_rels( power, power_rr );
    od;
    
    return power;
    
end );

##
InstallMethod( SymmetricPower,
        "for homalg modules",
        [ IsInt, IsFinitelyPresentedModuleRep ],
        
  function( k, M )
    local phi, T;
    
    if k = 0 then
        return One( M );
    elif k = 1 then
        return M;
    elif not k in [ 2 .. NrGenerators( M ) ] then
        return Zero( M );
    fi;
    
    phi := PresentationMorphism( M );
    
    T := SymmetricPower( k, Range( phi ) );
    
    phi := SymmetricPowerOfPresentationMorphism( k, phi );
    
    phi := HomalgMap( phi, "free", T );
    
    return Cokernel( phi );
    
end );

