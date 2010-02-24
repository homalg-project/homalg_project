#############################################################################
##
##  LILIN.gi                    LILIN subpackage             Mohamed Barakat
##
##         LILIN = Logical Implications for LINear systems
##
##  Copyright 2008-2009, Mohamed Barakat, Universität des Saarlandes
##
##  Implementation stuff for the LILIN subpackage.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( LILIN,
        rec(
            color := "\033[4;30;46m",
            intrinsic_attributes :=
            [ "Dimension",
              "DegreeOfLinearSystem" ]
            )
        );

##
InstallValue( LogicalImplicationsForLinearSystems,
        [ 
          
          
          ] );

####################################
#
# logical implications methods:
#
####################################

#InstallLogicalImplicationsForHomalgObjects( LogicalImplicationsForLinearSystems, IsLinearSystem );

####################################
#
# immediate methods for properties:
#
####################################

##
InstallImmediateMethod( IsEmpty,
        IsLinearSystem and HasDimension, 0,
        
  function( L )
    
    return Dimension( L ) < 0;
    
end );

####################################
#
# immediate methods for attributes:
#
####################################

####################################
#
# methods for properties:
#
####################################

##
InstallMethod( IsEmpty,
        "LILIN: for linear systems",
        [ IsLinearSystem ],
        
  function( L )
    
    return Dimension( L ) < 0;
    
end );

####################################
#
# methods for attributes:
#
####################################

##
InstallMethod( AssociatedGradedPolynomialRing,
        "LILIN: for linear systems",
        [ IsLinearSystem ],
        
  function( L )
    local x, dim, l;
    
    x := L!.variable_name;
    
    x := SplitString( x, "," );
    
    if x = [ ] then
        x := [ "x" ];
    fi;
    
    dim := Dimension( L );
    
    if dim = -1 then
        Error( "the linear system is empty\n" );
    fi;
    
    l := Length( x );
    
    if l = 1 then
        x := x[1];
        if dim > 0 then
            x := JoinStringsWithSeparator( List( [ 0 .. dim ], i -> Concatenation( x, String( i ) ) ) );
        fi;
    else
        if l <> dim + 1 then
            Error( "the number of variables must be one more than the dimension of the linear system\n" );
        fi;
        x := JoinStringsWithSeparator( x );
    fi;
    
    return HomalgRing( L ) * x;
    
end );

