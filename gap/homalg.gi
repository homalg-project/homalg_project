#############################################################################
##
##  homalg.gi                   homalg package               Mohamed Barakat
##
##  Copyright 2007 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for homalg.
##
#############################################################################


####################################
#
# global variables:
#
####################################

# A central place for configuration variables:

InstallValue( HOMALG, rec( ) );

# A global function for logical implications:

InstallGlobalFunction( LogicalImplicationsForHomalg,
  function( arg )
    local property;
    
    for property in arg do;
        
        if Length(property) = 3 then
            
            InstallTrueMethod( property[3],
                    property[1] );
            
            InstallImmediateMethod( property[1],
                    IsModuleForHomalg, 0, ## FIXME: find a way to put Tester(property[3]) here
                    
              function( M )
                if Tester(property[3])( M ) and not property[3]( M ) then
                    return false;
                else
                    TryNextMethod();
                fi;
                
            end );
            
        elif Length(property) = 5 then
            
            InstallTrueMethod( property[5],
                    property[1] and property[3] );
            
            InstallImmediateMethod( property[1],
                    IsModuleForHomalg, 0, ## FIXME: find a way to put Tester(property[3]) and Tester(property[5]) here
                    
              function( M )
                if Tester(property[3])( M ) and Tester(property[5])( M )
                   and property[3]( M ) and not property[5]( M ) then
                    return false;
                else
                    TryNextMethod();
                fi;
                
            end );
            
            InstallImmediateMethod( property[3],
                    IsModuleForHomalg, 0, ## FIXME: find a way to put Tester(property[1]) and Tester(property[5]) here
                    
              function( M )
                if Tester(property[1])( M ) and Tester(property[5])( M )
                   and property[1]( M ) and not property[5]( M ) then
                    return false;
                else
                    TryNextMethod();
                fi;
                
            end );
            
        fi;
        
    od;
    
end );
