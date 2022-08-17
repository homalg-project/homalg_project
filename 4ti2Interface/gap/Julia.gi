# SPDX-License-Identifier: GPL-2.0-or-later
# 4ti2Interface: A link to 4ti2
#
# Implementations
#

##
InstallGlobalFunction( lib4ti2_prepare_gap_input,
 function( arg )
    
    arg := arg[1];
    
    return
      List( arg,
            function( a )
              if IsJuliaObject( a ) then
                  a := JuliaToGAP( IsList, a );
              fi;
              return List( a,
                           function( b )
                             if IsJuliaObject( b ) then
                                 b := JuliaToGAP( IsList, b );
                             fi;
                             if IsList( b ) and ForAll( b, IsJuliaObject ) then
                                 return List( b, c -> JuliaToGAP( IsList, c ) );
                             fi;
                             return b;
                         end );
                     end );
    
end );

##
InstallGlobalFunction( lib4ti2_groebner,
 function( arg )
    
    return CallFuncList( 4ti2Interface_groebner, lib4ti2_prepare_gap_input( arg ) );
    
end );

##
InstallGlobalFunction( lib4ti2_groebner_matrix,
  function( arg )
    
    return CallFuncList( 4ti2Interface_groebner_matrix, lib4ti2_prepare_gap_input( arg ) );
    
end );

##
InstallGlobalFunction( lib4ti2_groebner_basis,
  function( arg )
    
    return CallFuncList( 4ti2Interface_groebner_basis, lib4ti2_prepare_gap_input( arg ) );
    
end );

##
InstallGlobalFunction( lib4ti2_hilbert_inequalities,
  function( arg )
    
    return CallFuncList( 4ti2Interface_hilbert_inequalities, lib4ti2_prepare_gap_input( arg ) );
    
end );

##
InstallGlobalFunction( lib4ti2_hilbert_inequalities_in_positive_orthant,
  function( arg )
    
    return CallFuncList( 4ti2Interface_hilbert_inequalities_in_positive_orthant, lib4ti2_prepare_gap_input( arg ) );
    
end );

##
InstallGlobalFunction( lib4ti2_hilbert_equalities_in_positive_orthant,
  function( arg )
    
    return CallFuncList( 4ti2Interface_hilbert_equalities_in_positive_orthant, lib4ti2_prepare_gap_input( arg ) );
    
end );

##
InstallGlobalFunction( lib4ti2_hilbert_equalities_and_inequalities,
  function( arg )
    
    return CallFuncList( 4ti2Interface_hilbert_equalities_and_inequalities, lib4ti2_prepare_gap_input( arg ) );
    
end );

##
InstallGlobalFunction( lib4ti2_hilbert_equalities_and_inequalities_in_positive_orthant,
  function( arg )
    
    return CallFuncList( 4ti2Interface_hilbert_equalities_and_inequalities_in_positive_orthant, lib4ti2_prepare_gap_input( arg ) );
    
end );

##
InstallGlobalFunction( lib4ti2_zsolve_equalities_and_inequalities,
  function( arg )
    
    return CallFuncList( 4ti2Interface_zsolve_equalities_and_inequalities, lib4ti2_prepare_gap_input( arg ) );
    
end );

##
InstallGlobalFunction( lib4ti2_zsolve_equalities_and_inequalities_in_positive_orthant,
  function( arg )
    
    return CallFuncList( 4ti2Interface_zsolve_equalities_and_inequalities_in_positive_orthant, lib4ti2_prepare_gap_input( arg ) );
    
end );

##
InstallGlobalFunction( lib4ti2_graver_equalities,
  function( arg )
    
    return CallFuncList( 4ti2Interface_graver_equalities, lib4ti2_prepare_gap_input( arg ) );
    
end );

##
InstallGlobalFunction( lib4ti2_graver_equalities_in_positive_orthant,
  function( arg )
    
    return CallFuncList( 4ti2Interface_graver_equalities_in_positive_orthant, lib4ti2_prepare_gap_input( arg ) );
    
end );
