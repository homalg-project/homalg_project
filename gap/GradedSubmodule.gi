#############################################################################
##
##  GradedSubmodule.gi      Graded Modules package
##
##  Copyright 2010,      Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH Aachen
##
##  Implementation stuff for graded submodules.
##
#############################################################################

# two new types:
BindGlobal( "TheTypeHomalgLeftGradedSubmodule",
        NewType( TheFamilyOfHomalgModules,
                IsGradedSubmoduleRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeHomalgRightGradedSubmodule",
        NewType( TheFamilyOfHomalgModules,
                IsGradedSubmoduleRep and IsHomalgRightObjectOrMorphismOfRightObjects ) );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallMethod( UnderlyingModule,
        "for homalg graded submodules",
        [ IsGradedSubmoduleRep ],
        
  function( M )
    
    return M!.UnderlyingModule;
    
end );

##
InstallMethod( Subobject,
        "for homalg graded modules",
        [ IsHomalgMatrix, IsGradedModuleRep ],
        
  function( gen, M )
    local gen2, gen_map;
    
    if IsIdenticalObj( HomalgRing( gen ), HomalgRing( UnderlyingModule( M ) ) ) then
      gen2 := gen;
    elif IsIdenticalObj( HomalgRing( gen ), HomalgRing( M ) ) then
      gen2 := UnderlyingNonHomogeneousMatrix( gen );
    else
      Error( "the matrix and the module are not defined over identically the same ring\n" );
    fi;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        if NrColumns( gen ) <> NrGenerators( M ) then
            Error( "the first argument is matrix with ", NrColumns( gen )," columns while the second argument is a module on ", NrGenerators( M ), " generators\n" );
        fi;
    else
        if NrRows( gen ) <> NrGenerators( M ) then
            Error( "the first argument is matrix with ", NrRows( gen )," rows while the second argument is a module on ", NrGenerators( M ), " generators\n" );
        fi;
    fi;
    
    gen_map := GradedMap( gen2, "free", M  );
    
    return ImageSubobject( gen_map );
end );

##
InstallMethod( Subobject,
        "for homalg graded modules",
        [ IsHomalgRelations, IsGradedModuleRep ],
        
  function( rel, M )
    return Subobject( MatrixOfRelations( rel ), M );
end );

##
InstallMethod( ImageSubobject,
        "graded submodule constructor",
        [ IsHomalgGradedMap ],
        
  function( phi )
    local img, T, S, N;
    
    img := ImageSubobject( UnderlyingMorphism( phi ) );
    
    T := Range( phi );
    
    S := HomalgRing( T );
    
    N := rec(
             ring := S,
             map_having_subobject_as_its_image := phi,
             UnderlyingModule := img
             );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( phi ) then
        ## Objectify:
        ObjectifyWithAttributes(
                N, TheTypeHomalgLeftGradedSubmodule,
                ConstructedAsAnIdeal, ConstructedAsAnIdeal( img ),
                LeftActingDomain, S );
        N!.DegreesOfGenerators := NonTrivialDegreePerRow( MatrixOfMap( phi ), DegreesOfGenerators( T ) );
    else
        ## Objectify:
        ObjectifyWithAttributes(
                N, TheTypeHomalgRightGradedSubmodule,
                ConstructedAsAnIdeal, ConstructedAsAnIdeal( img ),
                RightActingDomain, S );
        N!.DegreesOfGenerators := NonTrivialDegreePerColumn( MatrixOfMap( phi ), DegreesOfGenerators( T ) );
    fi;
    
    ## immediate methods will check if they can set
    ## SetIsTorsionFree( N, true ); and SetIsTorsion( N, true );
    ## by checking if the corresponding property for T is true
    
    if not IsGradedSubmoduleRep( N ) then
      Error( "Not the expected type" );
    fi;
    
    return N;
    
end );

InstallMethod( GradedLeftSubmodule,
        "constructor for homalg graded submodules",
        [ IsHomalgMatrix ],
        
  function( gen )
    local S;
    
    S := HomalgRing( gen );
    
    return Subobject( gen, ( NrColumns( gen ) * S )^0 );
    
end );

##
InstallMethod( GradedLeftSubmodule,
        "constructor for homalg graded submodules",
        [ IsHomalgRing ],
        
  function( S )
    
    return GradedLeftSubmodule( HomalgIdentityMatrix( 1, S ) );
    
end );

##
InstallMethod( GradedLeftSubmodule,
        "constructor for homalg ideals",
        [ IsList ],
        
  function( gen )
    local S;
    
    if gen = [ ] then
        Error( "an empty list of ring elements\n" );
    elif not ForAll( gen, IsRingElement ) then
        Error( "a list of ring elements is expected\n" );
    fi;
    
    S := HomalgRing( gen[1] );
    
    return GradedLeftSubmodule( HomalgMatrix( gen, Length( gen ), 1, S ) );
    
end );

##
InstallMethod( GradedLeftSubmodule,
        "constructor for homalg ideals",
        [ IsList, IsHomalgGradedRingRep ],
        
  function( gen, S )
    local Gen;
    
    if gen = [ ] then
        return GradedLeftSubmodule( S );
    fi;
    
    Gen := List( gen,
                 function( r )
                   if IsString( r ) then
                       return HomalgRingElement( r, S );
                   elif IsRingElement( r ) then
                       return r;
                   else
                       Error( r, " is neither a string nor a ring element\n" );
                   fi;
                 end );
    
    return GradedLeftSubmodule( HomalgMatrix( Gen, Length( Gen ), 1, S ) );
    
end );

##
InstallMethod( GradedLeftSubmodule,
        "constructor for homalg ideals",
        [ IsString, IsHomalgGradedRingRep ],
        
  function( gen, S )
    local Gen;
    
    Gen := ShallowCopy( gen );
    
    RemoveCharacters( Gen, "[]" );
    
    return GradedLeftSubmodule( SplitString( Gen, "," ), S );
    
end );

##
InstallMethod( GradedRightSubmodule,
        "constructor for homalg graded submodules",
        [ IsHomalgMatrix ],
        
  function( gen )
    local R;
    
    R := HomalgRing( gen );
    
    return Subobject( gen, ( R * NrRows( gen ) )^0 );
    
end );

##
InstallMethod( GradedRightSubmodule,
        "constructor for homalg graded submodules",
        [ IsHomalgGradedRingRep ],
        
  function( S )
    
    return GradedRightSubmodule( HomalgIdentityMatrix( 1, S ) );
    
end );

##
InstallMethod( GradedRightSubmodule,
        "constructor for homalg ideals",
        [ IsList ],
        
  function( gen )
    local S;
    
    if gen = [ ] then
        Error( "an empty list of ring elements\n" );
    elif not ForAll( gen, IsRingElement ) then
        Error( "a list of ring elements is expected\n" );
    fi;
    
    S := HomalgRing( gen[1] );
    
    return GradedRightSubmodule( HomalgMatrix( gen, 1, Length( gen ), S ) );
    
end );

##
InstallMethod( GradedRightSubmodule,
        "constructor for homalg ideals",
        [ IsList, IsHomalgRing ],
        
  function( gen, S )
    local Gen;
    
    if gen = [ ] then
        return GradedRightSubmodule( S );
    fi;
    
    Gen := List( gen,
                 function( r )
                   if IsString( r ) then
                       return HomalgRingElement( r, S );
                   elif IsRingElement( r ) then
                       return r;
                   else
                       Error( r, " is neither a string nor a ring element\n" );
                   fi;
                 end );
    
    return GradedRightSubmodule( HomalgMatrix( Gen, 1, Length( Gen ), S ) );
    
end );

##
InstallMethod( GradedRightSubmodule,
        "constructor for homalg ideals",
        [ IsString, IsHomalgRing ],
        
  function( gen, S )
    local Gen;
    
    Gen := ShallowCopy( gen );
    
    RemoveCharacters( Gen, "[]" );
    
    return GradedRightSubmodule( SplitString( Gen, "," ), S );
    
end );

##
InstallMethod( GradedLeftIdealOfMinors,
        "constructor for homalg ideals",
        [ IsInt, IsHomalgMatrix ],
        
  function( d, M )
    
    return GradedLeftSubmodule( Minors( d, M ) );
    
end );

##
InstallMethod( GradedLeftIdealOfMaximalMinors,
        "constructor for homalg ideals",
        [ IsHomalgMatrix ],
        
  function( M )
    
    return GradedLeftSubmodule( MaximalMinors( M ) );
    
end );

##
InstallMethod( GradedRightIdealOfMinors,
        "constructor for homalg ideals",
        [ IsInt, IsHomalgMatrix ],
        
  function( d, M )
    
    return GradedRightSubmodule( Minors( d, M ) );
    
end );

##
InstallMethod( GradedRightIdealOfMaximalMinors,
        "constructor for homalg ideals",
        [ IsHomalgMatrix ],
        
  function( M )
    
    return GradedRightSubmodule( MaximalMinors( M ) );
    
end );

##  <#GAPDoc Label="SubmoduleGeneratedByHomogeneousPart">
##  <ManSection>
##    <Oper Arg="d, M" Name="SubmoduleGeneratedByHomogeneousPart"/>
##    <Returns>a &homalg; module</Returns>
##    <Description>
##      The submodule of the &homalg; module <A>M</A> generated by the image of the <A>d</A>-th monomial map
##      (&see; <Ref Oper="MonomialMap"/>), or equivalently, by the basis of the <A>d</A>-th homogeneous part of <A>M</A>.
##      <Example><![CDATA[
##  gap> S := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";;
##  gap> M := HomalgMatrix( "[ x^3, y^2, z,   z, 0, 0 ]", 2, 3, S );;
##  gap> M := LeftPresentationWithDegrees( M, [ -1, 0, 1 ] );
##  <A graded non-torsion left module presented by 2 relations for 3 generators>
##  gap> n := SubmoduleGeneratedByHomogeneousPart( 1, M );
##  <A graded left submodule given by 7 generators>
##   gap> Display( M );
##   z,  0,    0,  
##   0,  y^2*z,z^2,
##   x^3,y^2,  z   
##   
##   (graded, generators degrees: [ -1, 0, 1 ])
##   
##   Cokernel of the map
##   
##   Q[x,y,z]^(1x3) --> Q[x,y,z]^(1x3),
##   
##   currently represented by the above matrix
##   gap> Display( n );
##   x^2,0,0,
##   x*y,0,0,
##   y^2,0,0,
##   0,  x,0,
##   0,  y,0,
##   0,  z,0,
##   0,  0,1 
##   
##   A left submodule generated by the 7 rows of the above matrix
##  gap> N := UnderlyingObject( n );
##  <A graded left module presented by yet unknown relations for 7 generators>
##   gap> Display( N );
##   z,0, 0, 0,    0,  0,0,   
##   0,z, 0, 0,    0,  0,0,   
##   0,0, z, 0,    0,  0,0,   
##   0,0, 0, 0,    -z, y,0,   
##   x,-y,0, 0,    0,  0,0,   
##   0,x, -y,0,    0,  0,0,   
##   0,0, x, 0,    y,  0,z,   
##   0,0, 0, -y,   x,  0,0,   
##   0,0, 0, -z,   0,  x,0,   
##   0,0, 0, 0,    y*z,0,z^2, 
##   0,0, 0, y^2*z,0,  0,x*z^2
##   
##   (graded, generators degrees: [ 1, 1, 1, 1, 1, 1, 1 ])
##   
##   Cokernel of the map
##   
##   Q[x,y,z]^(1x11) --> Q[x,y,z]^(1x7),
##   
##   currently represented by the above matrix
##  gap> gens := GeneratorsOfModule( N );
##  <A set of 7 generators of a homalg left module>
##   gap> Display( gens );
##   a set of 7 generators given by the rows of the matrix
##   
##   y^2,0,0,
##   x*y,0,0,
##   x^2,0,0,
##   0,  x,0,
##   0,  y,0,
##   0,  z,0,
##   0,  0,1 
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( SubmoduleGeneratedByHomogeneousPart,
        "for homalg modules",
        [ IsInt, IsHomalgModule ],
        
  function( d, M )
    local result;
    
    if not IsBound( M!.SubmodulesGeneratedByHomogeneousPart ) then
        M!.SubmodulesGeneratedByHomogeneousPart := rec( );
    fi;
    
    if IsBound( M!.SubmodulesGeneratedByHomogeneousPart!.(d) ) then
        return M!.SubmodulesGeneratedByHomogeneousPart!.(d);
    fi;
    
    result := Subobject( BasisOfHomogeneousPart( d, M ), M );
    
    M!.SubmodulesGeneratedByHomogeneousPart!.(d) := result;
    
    return result;
    
end );

##
InstallMethod( SubmoduleGeneratedByHomogeneousPart,
        "for homalg submodules",
        [ IsInt, IsStaticFinitelyPresentedSubobjectRep and IsHomalgModule ],
        
  function( d, N )
    
    return SubmoduleGeneratedByHomogeneousPart( d, UnderlyingObject( N ) );
    
end );

##
InstallOtherMethod( \*,
        "for homalg graded modules",
        [ IsGradedSubmoduleRep, IsGradedModuleRep ],
        
  function( J, M )
    local JM, scalar;
    
    JM := UnderlyingModule( J ) * UnderlyingModule( M );
    
    scalar := GradedMap( JM!.map_having_subobject_as_its_image, "create", M );
    
    return ImageSubobject( scalar );
    
end );

##
InstallOtherMethod( \*,
        "for homalg submodules",
        [ IsGradedSubmoduleRep, IsGradedSubmoduleRep ],
        
  function( I, J )
    local super, sub;
    
    super := SuperObject( I );
    
    if not IsIdenticalObj( super, SuperObject( J ) ) then
        Error( "the super objects must coincide\n" );
    elif not ( ConstructedAsAnIdeal( I ) and ConstructedAsAnIdeal( J ) ) then
        Error( "can only multiply ideals in a common ring\n" );
    fi;
    
    sub := UnderlyingModule( I ) * UnderlyingModule( J );
    
    sub := GradedMap( sub!.map_having_subobject_as_its_image, "create", super );
    
    return ImageSubobject( sub );
    
end );

##
InstallMethod( \/,
        "for homalg ideals",
        [ IsHomalgGradedRingRep, IsGradedSubmoduleRep and ConstructedAsAnIdeal ],
        
  function( S, J )
    
    if not IsIdenticalObj( HomalgRing( J ), S ) then
        Error( "the given ring and the ring of the ideal are not identical\n" );
    fi;
    
    return ResidueClassRing( J );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

