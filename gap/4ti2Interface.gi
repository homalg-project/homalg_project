#############################################################################
##
##                                                      4ti2Interface package
##
##  Copyright 2013,           Sebastian Gutsche, University of Kaiserslautern
##
##  Reading the declaration part of the 4ti2Interface package.
##
#############################################################################

##
InstallGlobalFunction( 4ti2Interface_Read_Matrix_From_File,
                       
  function( filename )
    local filestream, matrix, string, nr_rows, nr_cols;
    
    if not IsExistingFile( filename ) then
        
        return [ ];
        
    fi;
    
    filestream := IO_File( filename, "r" );
    
    matrix := [ ];
    
    string := IO_ReadLine( filestream );
    
    while string <> "" do
        
        NormalizeWhitespace( string );
        
        string := SplitString( string, " ", " \n" );
        
        string := List( string, Int );
        
        matrix := Concatenation( matrix, string );
        
        string := IO_ReadLine( filestream );
        
    od;
    
    IO_Close( filestream );
    
    nr_rows := Remove( matrix, 1 );
    
    nr_cols := Remove( matrix, 1 );
    
    if not Length( matrix ) = nr_cols * nr_rows then
        
        Error( "wrong input matrix dimension" );
        
        return [ fail, [ nr_rows, nr_cols ], matrix ];
        
    fi;
    
    matrix := CutVector( matrix, nr_rows );
    
    return matrix;
    
end );

##
InstallGlobalFunction( 4ti2Interface_Write_Matrix_To_File,
                       
  function( matrix, string )
    local filestream, i, j;
    
    filestream := IO_File( string, "w" );
    
    i := Length( matrix );
    
    if i = 0 then
        
        return matrix;
        
    fi;
    
    j := Length( matrix[ 1 ] );
    
    if j = 0 then
        
        return matrix;
        
    fi;
    
    if not ForAll( matrix, k -> Length( k ) = j ) then
        
        Error( "Input is not a matrix" );
        
        return fail;
        
    fi;
    
    IO_Write( filestream, Concatenation( String( i ), " ", String( j ), "\n"  ) );
    
    for i in matrix do
        
        for j in i do
            
            IO_Write( filestream, Concatenation( String( j ), " " ) );
            
        od;
        
        IO_Write( filestream, "\n" );
        
    od;
    
    IO_Flush( filestream );
    
    IO_Close( filestream );
    
end );

##
InstallGlobalFunction( 4ti2Interface_groebner_matrix,
                       
  function( arg )
    local matrix, dir, filename, exec, filestream;
    
    if Length( arg ) < 1 then
        
        Error( "too few arguments" );
        
    fi;
    
    matrix := arg[ 1 ];
    
    dir := DirectoryTemporary();
    
    filename := Filename( dir, "gap_4ti2_temp_matrix" );
    
    ## 4ti2 works with right kernel.
    4ti2Interface_Write_Matrix_To_File( TransposedMat( matrix ), Concatenation( filename, ".mat" ) );
    
    if Length( arg ) > 1 then
        
        4ti2Interface_Write_Matrix_To_File( [ arg[ 2 ] ], Concatenation( filename, ".cost" ) );
        
    fi;
    
    exec := IO_FindExecutable( "groebner" );
    
    filestream := IO_Popen2( exec, [ "-parb", filename ]);
    
    while IO_ReadLine( filestream.stdout ) <> "" do od;
    
    matrix := 4ti2Interface_Read_Matrix_From_File( Concatenation( filename, ".gro" ) );
    
    return matrix;
    
end );

##
InstallGlobalFunction( 4ti2Interface_groebner_basis,
                       
  function( arg )
    local matrix, dir, filename, exec, filestream;
    
    dir := DirectoryTemporary();
    
    if Length( arg ) < 1 then
        
        Error( "too few arguments" );
        
    fi;
    
    matrix := arg[ 1 ];
    
    filename := Filename( dir, "gap_4ti2_temp_lattice" );
    
    4ti2Interface_Write_Matrix_To_File( matrix, Concatenation( filename, ".lat" ) );
    
    if Length( arg ) > 1 then
        
        4ti2Interface_Write_Matrix_To_File( [ arg[ 2 ] ], Concatenation( filename, ".cost" ) );
        
    fi;
    
    exec := IO_FindExecutable( "groebner" );
    
    filestream := IO_Popen2( exec, [ filename ]);
    
    while IO_ReadLine( filestream.stdout ) <> "" do od;
    
    matrix := 4ti2Interface_Read_Matrix_From_File( Concatenation( filename, ".gro" ) );
    
    return matrix;
    
end );

##
InstallGlobalFunction( 4ti2Interface_hilbert_inequalities,
                       
  function( matrix )
    local dir, filename, rel_list, sign_list, exec, filestream;
    
    if matrix = [ ] then
        
        return [ ];
        
    fi;
    
    dir := DirectoryTemporary();
    
    filename := Filename( dir, "gap_4ti2_temp_ineqs" );
    
    4ti2Interface_Write_Matrix_To_File( matrix, Concatenation( filename, ".mat" ) );
    
    rel_list := [ List( matrix, i -> ">" ) ];
    
    4ti2Interface_Write_Matrix_To_File( rel_list, Concatenation( filename, ".rel" ) );
    
    sign_list := [ List( matrix[ 1 ], i -> 0 ) ];
    
    4ti2Interface_Write_Matrix_To_File( sign_list, Concatenation( filename, ".sign" ) );
    
    exec := IO_FindExecutable( "hilbert" );
    
    filestream := IO_Popen2( exec, [ filename ]);
    
    while IO_ReadLine( filestream.stdout ) <> "" do od;
    
    matrix := 4ti2Interface_Read_Matrix_From_File( Concatenation( filename, ".hil" ) );
    
    return matrix;
    
end );

##
InstallGlobalFunction( 4ti2Interface_hilbert_inequalities_in_positive_orthant,
                       
  function( matrix )
    local dir, filename, rel_list, sign_list, exec, filestream;
    
    if matrix = [ ] then
        
        return [ ];
        
    fi;
    
    dir := DirectoryTemporary();
    
    filename := Filename( dir, "gap_4ti2_temp_ineqs" );
    
    4ti2Interface_Write_Matrix_To_File( matrix, Concatenation( filename, ".mat" ) );
    
    rel_list := [ List( matrix, i -> ">" ) ];
    
    4ti2Interface_Write_Matrix_To_File( rel_list, Concatenation( filename, ".rel" ) );
    
    exec := IO_FindExecutable( "hilbert" );
    
    filestream := IO_Popen2( exec, [ filename ]);
    
    while IO_ReadLine( filestream.stdout ) <> "" do od;
    
    matrix := 4ti2Interface_Read_Matrix_From_File( Concatenation( filename, ".hil" ) );
    
    return matrix;
    
end );

##
InstallGlobalFunction( 4ti2Interface_hilbert_equalities_in_positive_orthant,
                       
  function( matrix )
    local dir, filename, rel_list, sign_list, exec, filestream;
    
    if matrix = [ ] then
        
        return [ ];
        
    fi;
    
    dir := DirectoryTemporary();
    
    filename := Filename( dir, "gap_4ti2_temp_ineqs" );
    
    4ti2Interface_Write_Matrix_To_File( matrix, Concatenation( filename, ".mat" ) );
    
    rel_list := [ List( matrix, i -> "=" ) ];
    
    4ti2Interface_Write_Matrix_To_File( rel_list, Concatenation( filename, ".rel" ) );
    
    exec := IO_FindExecutable( "hilbert" );
    
    filestream := IO_Popen2( exec, [ filename ]);
    
    while IO_ReadLine( filestream.stdout ) <> "" do od;
    
    matrix := 4ti2Interface_Read_Matrix_From_File( Concatenation( filename, ".hil" ) );
    
    return matrix;
    
end );

##
InstallGlobalFunction( 4ti2Interface_hilbert_equalities_and_inequalities,
                       
  function( eqs, ineqs )
    local concat_list, dir, filename, rel_list, sign_list,
          return_matrix, exec, filestream;
    
    if eqs = [ ] and ineqs = [ ] then
        
        return [ ];
        
    fi;
    
    dir := DirectoryTemporary();
    
    filename := Filename( dir, "gap_4ti2_temp_ineqs" );
    
    concat_list := Concatenation( eqs, ineqs );
    
    4ti2Interface_Write_Matrix_To_File( concat_list, Concatenation( filename, ".mat" ) );
    
    rel_list := [ Concatenation( List( eqs, i -> "=" ), List( ineqs, i -> ">" ) ) ];
    
    4ti2Interface_Write_Matrix_To_File( rel_list, Concatenation( filename, ".rel" ) );
    
    sign_list := [ List( concat_list[ 1 ] , i -> 0 ) ];
    
    4ti2Interface_Write_Matrix_To_File( sign_list, Concatenation( filename, ".sign" ) );
    
    exec := IO_FindExecutable( "hilbert" );
    
    filestream := IO_Popen2( exec, [ filename ]);
    
    while IO_ReadLine( filestream.stdout ) <> "" do od;
    
    return_matrix := 4ti2Interface_Read_Matrix_From_File( Concatenation( filename, ".hil" ) );
    
    return return_matrix;
    
end );

##
InstallGlobalFunction( 4ti2Interface_hilbert_equalities_and_inequalities_in_positive_orthant,
                       
  function( eqs, ineqs )
    local concat_list, dir, filename, rel_list, sign_list,
          exec, filestream, return_matrix;
    
    if eqs = [ ] and ineqs = [ ] then
        
        return [ ];
        
    fi;
    
    dir := DirectoryTemporary();
    
    filename := Filename( dir, "gap_4ti2_temp_ineqs" );
    
    concat_list := Concatenation( eqs, ineqs );
    
    4ti2Interface_Write_Matrix_To_File( concat_list, Concatenation( filename, ".mat" ) );
    
    rel_list := [ Concatenation( List( eqs, i -> "=" ), List( ineqs, i -> ">" ) ) ];
    
    4ti2Interface_Write_Matrix_To_File( rel_list, Concatenation( filename, ".rel" ) );
    
    sign_list := [ List( concat_list[ 1 ] , i -> 0 ) ];
    
    4ti2Interface_Write_Matrix_To_File( sign_list, Concatenation( filename, ".sign" ) );
    
    exec := IO_FindExecutable( "hilbert" );
    
    filestream := IO_Popen2( exec, [ filename ]);
    
    while IO_ReadLine( filestream.stdout ) <> "" do od;
    
    return_matrix := 4ti2Interface_Read_Matrix_From_File( Concatenation( filename, ".hil" ) );
    
    return return_matrix;
    
end );

##
InstallGlobalFunction( 4ti2Interface_zsolve_equalities_and_inequalities,
                       
  function( arg )
    local eqs, eqs_rhs, ineqs, ineqs_rhs, signs,
          concat_list, dir, filename, rel_list, concat_rhs,
          return_matrix, exec, filestream;
    
    if Length( arg ) < 4 then
        
        Error( "too few arguments" );
        
        return [ ];
        
    fi;
    
    eqs := arg[ 1 ];
    
    eqs_rhs := arg[ 2 ];
    
    ineqs := arg[ 3 ];
    
    ineqs_rhs := arg[ 4 ];
    
    if eqs = [ ] and ineqs = [ ] then
        
        return [ ];
        
    fi;
    
    if Length( arg ) > 4 then
        
        signs := [ arg[ 5 ] ];
        
    else
        
        if Length( eqs ) > 0 then
            
            signs := [ ListWithIdenticalEntries( Length( eqs[ 1 ] ), 0 ) ];
            
        else
            
            signs := [ ListWithIdenticalEntries( Length( ineqs[ 1 ] ), 0 ) ];
            
        fi;
        
    fi;
    
    dir := DirectoryTemporary();
    
    filename := Filename( dir, "gap_4ti2_zsolve" );
    
    concat_list := Concatenation( eqs, ineqs );
    
    4ti2Interface_Write_Matrix_To_File( concat_list, Concatenation( filename, ".mat" ) );
    
    rel_list := [ Concatenation( List( eqs, i -> "=" ), List( ineqs, i -> ">" ) ) ];
    
    4ti2Interface_Write_Matrix_To_File( rel_list, Concatenation( filename, ".rel" ) );
    
    4ti2Interface_Write_Matrix_To_File( signs, Concatenation( filename, ".sign" ) );
    
    concat_rhs := [ Concatenation( eqs_rhs, ineqs_rhs ) ];
    
    4ti2Interface_Write_Matrix_To_File( concat_rhs, Concatenation( filename, ".rhs" ) );
    
    exec := IO_FindExecutable( "zsolve" );
    
    filestream := IO_Popen2( exec, [ filename ]);
    
    while IO_ReadLine( filestream.stdout ) <> "" do od;
    
    return_matrix := [ 1, 2, 3 ];
    
    return_matrix[ 1 ] := 4ti2Interface_Read_Matrix_From_File( Concatenation( filename, ".zinhom" ) );
    
    return_matrix[ 2 ] := 4ti2Interface_Read_Matrix_From_File( Concatenation( filename, ".zhom" ) );
    
    return_matrix[ 3 ] := 4ti2Interface_Read_Matrix_From_File( Concatenation( filename, ".zfree" ) );
    
    return return_matrix;
    
end );

##
InstallGlobalFunction( 4ti2Interface_zsolve_equalities_and_inequalities_in_positive_orthant,
                       
  function( eqs, eqs_rhs, ineqs, ineqs_rhs )
    local signs, call_list;
    
    call_list := [ eqs, eqs_rhs, ineqs, ineqs_rhs ];
    
    if Length( eqs ) = 0 and Length( ineqs ) = 0 then
        
        return [ ];
        
    fi;
    
    if Length( eqs ) > 0 then
        
        signs := [ ListWithIdenticalEntries( Length( eqs[ 1 ] ), 0 ) ];
        
    else
        
        signs := [ ListWithIdenticalEntries( Length( ineqs[ 1 ] ), 0 ) ];
        
    fi;
    
    Add( call_list, signs );
    
    return CallFuncList( 4ti2Interface_zsolve_equalities_and_inequalities, call_list );
    
end );
