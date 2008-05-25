#############################################################################
##
##  homalg.gi                   homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for homalg.
##
#############################################################################

####################################
#
# representations:
#
####################################

# a new representation for the GAP-category IsHomalgRingOrObject:
DeclareRepresentation( "IsHomalgRingOrFinitelyPresentedObjectRep",
        IsHomalgRingOrObject,
        [ ] );

# a new representation for the GAP-category IsHomalgObject
# which is a subrepresentation of the representation IsHomalgRingOrFinitelyPresentedObjectRep:
DeclareRepresentation( "IsFinitelyPresentedObjectRep",
        IsHomalgObject and IsHomalgRingOrFinitelyPresentedObjectRep,
        [ ] );

# a new representation for the GAP-category IsHomalgMorphism:
DeclareRepresentation( "IsMorphismOfFinitelyGeneratedModulesRep",
        IsHomalgMorphism,
        [ ] );

# a new representation for the GAP-category IsContainerForWeakPointers:
DeclareRepresentation( "IsContainerForWeakPointersRep",
        IsContainerForWeakPointers,
        [ "weak_pointers", "counter", "deleted" ] );

####################################
#
# families and types:
#
####################################

# a new family:
BindGlobal( "TheFamilyOfContainersForWeakPointers",
        NewFamily( "TheFamilyOfContainersForWeakPointers" ) );

# a new type:
BindGlobal( "TheTypeContainerForWeakPointers",
        NewType( TheFamilyOfContainersForWeakPointers,
                IsContainerForWeakPointersRep ) );

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( HOMALG,
        rec(
            TotalRuntimes := 0,
            OtherInternalMatrixTypes := [ ],
            
            color_BOT := "\033[1;37;40m",		## (T)riangular basis: TriangularBasisOfRows/Columns
            color_BOW := "\033[1;37;40m",		## Triangular basis: TriangularBasisOfRows/Columns( M, W )
            color_BOB := "\033[1;37;45m",		## (B)asis: BasisOfRow/ColumnModule
            color_BOC := "\033[1;37;45m",		## Basis: BasisOfRows/Columns(C)oeff
            color_BOD := "\033[1;37;42m",		## existence of a particular solution: (D)ecideZeroRows/Columns
            color_BOP := "\033[1;37;42m",		## (P)articular solution: DecideZeroRows/Columns(Effectively)
            color_BOH := "\033[1;37;41m",		## solutions of the (H)omogeneous system: SyzygiesGeneratorsOfRows/Columns
            color_busy := "\033[01m\033[4;31;40m",
            color_done := "\033[01m\033[4;32;40m",
           )
);

####################################
#
# global functions:
#
####################################

InstallGlobalFunction( ContainerForWeakPointers,
  function( arg )
    local nargs, container, component, type;
    
    nargs := Length( arg );
    
    container := rec( weak_pointers := WeakPointerObj( [ ] ),
                      counter := 0,
                      deleted := [ ] );
    
    for component in arg{[ 2 .. nargs ]} do
        container.( component[1] ) := component[2];
    od;
               
    type := arg[1];
    
    ## Objectify:
    Objectify( type, container );
    
    return container;
    
end );

InstallGlobalFunction( homalgTotalRuntimes,
  function( arg )
    local r, t;
    
    r := Runtimes( );
    
    HOMALG.TotalRuntimes := r.user_time;
    
    if IsBound( r.system_time ) then
        HOMALG.TotalRuntimes := HOMALG.TotalRuntimes + r.system_time;
    fi;
    
    if IsBound( r.user_time_children ) then
        HOMALG.TotalRuntimes := HOMALG.TotalRuntimes + r.user_time_children;
    fi;
    
    if IsBound( r.system_time_children ) then
        HOMALG.TotalRuntimes := HOMALG.TotalRuntimes + r.system_time_children;
    fi;
    
    if Length( arg ) = 0 then
        return HOMALG.TotalRuntimes;
    fi;
    
    return TimeToString( HOMALG.TotalRuntimes - arg[1] );
    
end );

# a global function for logical implications:

InstallGlobalFunction( LogicalImplicationsForHomalg,
  function( property, filter )
    local propA, propB, propC;
    
    if Length( property ) = 3 then
        
        propA := property[1];
        propB := property[3];
        
        InstallTrueMethod( propB, filter and propA );
        
        InstallImmediateMethod( propA,
                filter and Tester( propB ), 0,
                
          function( M )
            if filter( M ) and not propB( M ) then
                return false;
            fi;
            
            TryNextMethod( );
            
        end );
        
    elif Length( property ) = 5 then
        
        propA := property[1];
        propB := property[3];
        propC := property[5];
        
        InstallTrueMethod( propC, filter and propA and propB );
        
        InstallImmediateMethod( propA,
                filter and Tester( propB ) and Tester( propC ), 0,
                
          function( M )
            if filter( M ) and propB( M ) and not propC( M ) then
                return false;
            fi;
            
            TryNextMethod( );
            
        end );
        
        InstallImmediateMethod( propB,
                filter and Tester( propA ) and Tester( propC ), 0,
                
          function( M )
            if filter( M ) and propA( M ) and not propC( M ) then
                return false;
            fi;
            
            TryNextMethod( );
            
        end );
        
    fi;
    
end );

InstallGlobalFunction( InstallLogicalImplicationsForHomalg,
  function( properties, filter )
    local property;
    
    for property in properties do;
        
        LogicalImplicationsForHomalg( property, filter );
        
    od;
    
end );

InstallGlobalFunction( homalgNamesOfComponentsToIntLists,
  function( arg )
    
    return Filtered(
                   List( NamesOfComponents( arg[1] ),
                         function( a )
                           local l;
                           l := SplitString( a, ",", "[ ]" );
                           if Length( l ) = 1 then
                               if Length( l[1] ) <= 24 then
                                   return Int( l[1] );
                               else
                                   return fail;
                               fi;
                           else
                               return List( l, Int );
                           fi;
                         end
                       ),
                  b -> b <> fail );
end );
