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
        
        Error( "file does not exist" );
        
        return fail;
        
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
                       
  function( matrix )
    local dir, filename, exec, filestream;
    
    dir := DirectoryTemporary();
    
    filename := Filename( dir, "gap_4ti2_temp_matrix" );
    
    4ti2Interface_Write_Matrix_To_File( matrix, Concatenation( filename, ".mat" ) );
    
    exec := IO_FindExecutable( "groebner" );
    
    filestream := IO_Popen2( exec, [ filename ]);
    
    while IO_ReadLine( filestream.stdout ) <> "" do od;
    
    matrix := 4ti2Interface_Read_Matrix_From_File( Concatenation( filename, ".gro" ) );
    
    return matrix;
    
end );

##
InstallGlobalFunction( 4ti2Interface_groebner_basis,
                       
  function( matrix )
    local dir, filename, exec, filestream;
    
    dir := DirectoryTemporary();
    
    filename := Filename( dir, "gap_4ti2_temp_lattice" );
    
    4ti2Interface_Write_Matrix_To_File( matrix, Concatenation( filename, ".lat" ) );
    
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
