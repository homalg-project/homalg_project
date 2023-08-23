# SPDX-License-Identifier: GPL-2.0-or-later
# Modules: A homalg based package for the Abelian category of finitely presented modules over computable rings
#
# Implementations
#

##         LIREL = Logical Implications for homalg module RELations

####################################
#
# global variables:
#
####################################

####################################
#
# immediate methods for properties:
#
####################################

####################################
#
# immediate methods for attributes:
#
####################################

####################################
#
# methods for operations:
#
####################################

#-----------------------------------
# RightDivide
#-----------------------------------

##
InstallMethod( RightDivide,
        "LIREL: for homalg matrices (check input)",
        [ IsHomalgMatrix, IsHomalgMatrix, IsHomalgRelationsOfLeftModule ], 10001,
        
  function( B, A, L )
    
    if NumberColumns( A ) <> NumberColumns( B ) then
        Error( "the first and the second matrix must have the same number of columns\n" );
    fi;
    
    if NumberColumns( A ) <> NrGenerators( L ) then
        Error( "the number of columns of the first matrix and the number of generators of the last argment do not coincide\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( RightDivide,
        "LIREL: for homalg matrices (IsOne)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsOne, IsHomalgRelationsOfLeftModule ],
        
  function( B, A, L )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIREL\033[0m ", LIMAT.color, "RightDivide( IsHomalgMatrix, IsOne(Matrix), IsHomalgRelations )", "\033[0m" );
    
    return B;
    
end );

##
InstallMethod( RightDivide,
        "LIREL: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero, IsHomalgMatrix, IsHomalgRelationsOfLeftModule ],
        
  function( B, A, L )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIREL\033[0m ", LIMAT.color, "RightDivide( IsZero(Matrix), IsHomalgMatrix, IsHomalgRelations )", "\033[0m" );
    
    return HomalgZeroMatrix( NumberRows( B ), NumberRows( A ), HomalgRing( B ) );
    
end );

#-----------------------------------
# LeftDivide
#-----------------------------------

##
InstallMethod( LeftDivide,
        "LIREL: for homalg matrices (check input)",
        [ IsHomalgMatrix, IsHomalgMatrix, IsHomalgRelationsOfRightModule ], 10001,
        
  function( A, B, L )
    
    if NumberRows( A ) <> NumberRows( B ) then
        Error( "the first and the second matrix must have the same number of rows\n" );
    fi;
    
    if NumberRows( A ) <> NrGenerators( L ) then
        Error( "the number of rows of the first matrix and the number of generators of the last argment do not coincide\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( LeftDivide,
        "LIREL: for homalg matrices (IsOne)",
        [ IsHomalgMatrix and IsOne, IsHomalgMatrix, IsHomalgRelationsOfRightModule ],
        
  function( A, B, L )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIREL\033[0m ", LIMAT.color, "LeftDivide( IsOne(Matrix), IsHomalgMatrix, IsHomalgRelations )", "\033[0m" );
    
    return B;
    
end );

##
InstallMethod( LeftDivide,
        "LIREL: for homalg matrices (IsZero)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsZero, IsHomalgRelationsOfRightModule ],
        
  function( A, B, L )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIREL\033[0m ", LIMAT.color, "LeftDivide( IsHomalgMatrix, IsZero(Matrix), IsHomalgRelations )", "\033[0m" );
    
    return HomalgZeroMatrix( NumberColumns( A ), NumberColumns( B ), HomalgRing( B ) );
    
end );

