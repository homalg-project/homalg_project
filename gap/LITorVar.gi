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

###########################
##
## Immediate Methods
##
###########################

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
    
    return ZeroSubobject( Cokernel( MapFromCharacterToPrincipalDivisor( variety ) ) );
    
end );

## On A smooth variety every divisor is cartier
##
InstallImmediateMethod( PicardGroup,
               IsToricVariety and IsSmooth and HasClassGroup,
               0,
               
  function( variety )
    
    return FullSubobject( ClassGroup( variety ) );
    
end );

## A toric variety is smooth iff Pic(X) = Cl(X)
##
InstallImmediateMethod( IsSmooth,
                        IsToricVariety and HasClassGroup and HasPicardGroup,
                        0,
                        
  function( variety )
    
    return IsIdenticalObj( ClassGroup( variety ), PicardGroup( variety ) );
    
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
