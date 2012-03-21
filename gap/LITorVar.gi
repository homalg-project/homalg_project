#############################################################################
##
##  LITorVar.gi     ToricVarieties       Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Logical implications for toric divisors
##
##############################################################################

###########################
##
## True Methods
##
###########################

## InstallFalseMethod( IsAffine, IsProjective );

## InstallFalseMethod( IsProjective, IsAffine );

###########################
##
## Immediate Methods
##
###########################

## Cox: 4.2.2
##
InstallImmediateMethod( IsAffine,
                        IsToricVariety and HasPicardGroup,
                        0,
               
  function( variety )
    
    if not IsZero( PicardGroup( variety ) ) then
        
        return false;
        
    fi;
    
    TryNextMethod();
    
end );

##
InstallImmediateMethod( CoxVariety,
                        IsToricVariety and HasMorphismFromCoxVariety,
                        0,
               
  function( variety )
    
    return SourceObject( MorphismFromCoxVariety( variety ) );
    
end );

## On an affine variety, every cartier
## divisor is principal.
##
InstallImmediateMethod( CartierTorusInvariantDivisorGroup,
                        IsToricVariety and HasMapFromCharacterToPrincipalDivisor and IsAffine,
                        0,
                        
  function( variety )
    
    return ImageSubobject( MapFromCharacterToPrincipalDivisor( variety ) );
    
end );

## The picard group of an affine variety is trivial
##
InstallImmediateMethod( PicardGroup,
               IsToricVariety and IsAffine and HasMapFromCharacterToPrincipalDivisor,
               0,
               
  function( variety )
    
    return UnderlyingObject( ZeroSubobject( Cokernel( MapFromCharacterToPrincipalDivisor( variety ) ) ) );
    
end );

## On A smooth variety every divisor is cartier
##
InstallImmediateMethod( PicardGroup,
               IsToricVariety and IsSmooth and HasClassGroup,
               0,
               
  function( variety )
    
    return UnderlyingObject( FullSubobject( ClassGroup( variety ) ) );
    
end );

## A toric variety is smooth iff Pic(X) = Cl(X)
##FixMe: No identical obj.
##
InstallImmediateMethod( IsSmooth,
                        IsToricVariety and HasClassGroup and HasPicardGroup,
                        0,
                        
  function( variety )
    local emb;
    
    if IsIdenticalObj( ClassGroup( variety ), PicardGroup( variety ) ) then
        
        return true;
        
    fi;
    
    if not HasUnderlyingSubobject( PicardGroup( variety ) ) then
        
        TryNextMethod();
        
    fi;
    
    emb := UnderlyingSubobject( PicardGroup( variety ) );
    
    emb := EmbeddingInSuperObject( emb );
    
    if HasIsEpimorphism( emb ) then
        
        return IsEpimorphism( emb );
        
    fi;
    
    TryNextMethod();
    
end );

##
InstallImmediateMethod( HasTorusfactor,
                        IsToricVariety and HasHasNoTorusfactor,
                        0,
  function( variety )
    
    return not HasNoTorusfactor( variety );
    
end );

## This is so obvious, dont even ask!
##
InstallImmediateMethod( HasNoTorusfactor,
                        IsToricVariety and HasHasTorusfactor,
                        0,
  function( variety )
    
    return not HasTorusfactor( variety );
    
end );

##
InstallImmediateMethod( IsProjective,
                        IsToricVariety and HasIsProductOf,
                        0,
                        
  function( variety )
    
    if ForAll( IsProductOf( variety ), HasIsProjective ) then
        
        return ForAll( IsProductOf( variety ), IsProjective );
        
    fi;
    
    TryNextMethod();
    
end );

##
InstallImmediateMethod( IsAffine,
                        IsToricVariety and HasIsProductOf,
                        0,
                        
  function( variety )
    
    if ForAll( IsProductOf( variety ), HasIsAffine ) then
        
        return ForAll( IsProductOf( variety ), IsAffine );
        
    fi;
    
    TryNextMethod();
    
end );

##
InstallImmediateMethod( IsSmooth,
                        IsToricVariety and HasIsProductOf,
                        0,
                        
  function( variety )
    
    if ForAll( IsProductOf( variety ), HasIsSmooth ) then
        
        return ForAll( IsProductOf( variety ), IsSmooth );
        
    fi;
    
    TryNextMethod();
    
end );

##
InstallImmediateMethod( IsOrbifold,
                        IsToricVariety and HasIsProductOf,
                        0,
                        
  function( variety )
    
    if ForAll( IsProductOf( variety ), HasIsOrbifold ) then
        
        return ForAll( IsProductOf( variety ), IsSmooth );
        
    fi;
    
    TryNextMethod();
    
end );

##
InstallImmediateMethod( Dimension,
               IsToricVariety and HasIsProductOf,
               0,
               
  function( variety )
    
    if Length( IsProductOf( variety ) ) > 1 and ForAll( IsProductOf( variety ), HasDimension ) then
        
        return Sum( List( IsProductOf( variety ), Dimension ) );
        
    fi;
    
    TryNextMethod();
    
end );

##
InstallImmediateMethod( Dimension,
               IsToricVariety and HasPolytopeOfVariety,
               0,
               
  function( variety )
    
    return AmbientSpaceDimension( PolytopeOfVariety( variety ) );
    
end );

##
InstallImmediateMethod( Dimension,
               IsToricVariety and HasConeOfVariety,
               0,
               
  function( variety )
    
    return AmbientSpaceDimension( FanOfVariety( variety ) );
    
end );

##
InstallImmediateMethod( Dimension,
               IsToricVariety and HasFanOfVariety,
               0,
               
  function( variety )
    
    return AmbientSpaceDimension( FanOfVariety( variety ) );
    
end );

##
InstallImmediateMethod( twitter,
               IsToricVariety and HasNoTorusfactor and HasMapFromCharacterToPrincipalDivisor,
               0,
               
  function( variety )
    
    SetIsMonomorphism( MapFromCharacterToPrincipalDivisor( variety ), HasNoTorusfactor( variety ) );
    
    TryNextMethod();
    
end );

## On a smooth variety every torus invariant divisor is cartier
##
InstallImmediateMethod( twitter,
               IsToricVariety and IsSmooth,
               0,
               
  function( variety )
    local i;
    
    for i in WeilDivisorsOfVariety( variety ) do
        
        SetIsCartier( i, true );
        
    od;
    
    TryNextMethod();
    
end );