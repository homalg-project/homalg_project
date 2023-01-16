# SPDX-License-Identifier: GPL-2.0-or-later
# 4ti2Interface: A link to 4ti2
#
# Implementations
#

BindGlobal( "4ti2Interface_BINARIES",
        rec(
            required_binaries := [ "groebner", "hilbert", "zsolve", "graver" ],
            ) );

for name in 4ti2Interface_BINARIES.required_binaries do
    path := Filename( DirectoriesSystemPrograms(), name );
    if IsStringRep( path ) then
        4ti2Interface_BINARIES.(name) := path;
        continue;
    fi;
    path := Filename( DirectoriesSystemPrograms(), Concatenation( "4ti2-", name ) );
    if IsStringRep( path ) then
        4ti2Interface_BINARIES.(name) := path;
        continue;
    fi;
    ## the AvailabilityTest in the PackageInfo will prevent this error from being raised
    Error( "4ti2 cannot be found on your system\n" );
od;

##
InstallGlobalFunction( 4ti2Interface_Cut_Vector,
                       
  function ( vec, l )
    local  d, new, i;
    
    if Length( vec ) = 0  then
        
        return [  ];
        
    fi;
    
    d := Length( vec ) / l;
    
    new := [  ];
    
    for i  in [ 1 .. l ]  do
        
        Add( new, vec{[ d * (i - 1) + 1 .. d * i ]} );
        
    od;
    
    return new;
    
end );

##
InstallGlobalFunction( 4ti2Interface_Read_Matrix_From_File,
                       
  function( filename )
    local filestream, matrix, string, nr_rows, nr_cols;
    
    if not IsExistingFile( filename ) then
        
        Error( "this file ", filename, " does not exist, it should have been created by 4ti2\n" );
        
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
    
    matrix := 4ti2Interface_Cut_Vector( matrix, nr_rows );
    
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
InstallGlobalFunction( 4ti2Interface_groebner,
  function( arg )
    local matrix, dir, filename, exec, precision, filestream, err;
    
    if Length( arg ) < 1 then
        
        Error( "too few arguments" );
        
    fi;
    
    matrix := arg[ 1 ];
    
    dir := DirectoryTemporary();
    
    filename := Filename( dir, "gap_4ti2_temp_matrix" );
    
    if IsIdenticalObj( ValueOption( "transposed" ), true ) then
        ## 4ti2 works with right kernel.
        4ti2Interface_Write_Matrix_To_File( TransposedMat( matrix ), Concatenation( filename, ".mat" ) );
    else
        4ti2Interface_Write_Matrix_To_File( matrix, Concatenation( filename, ".mat" ) );
    fi;
    
    if Length( arg ) > 1 then
        
        if not IsMatrix( arg[ 2 ] ) then
            arg[ 2 ] := [ arg[ 2 ] ];
        fi;
        
        4ti2Interface_Write_Matrix_To_File( arg[ 2 ], Concatenation( filename, ".cost" ) );
        
    fi;

    exec := 4ti2Interface_BINARIES.groebner;
    
    precision := ValueOption( "precision" );
    
    if IsInt( precision ) then
        
        precision := String( precision );
        
    elif precision = fail then
        
        precision := "arb";
        
    fi;
    
    filestream := IO_Popen3( exec, [ Concatenation( "--precision=", precision ), filename ] );
    
    err := Concatenation( IO_ReadLines( filestream.stderr ) );
    
    err := ReplacedString( err, "egrep: warning: egrep is obsolescent; using grep -E\n", "" );
    
    err := ReplacedString( err, "egrep: warning: egrep is obsolescent; using ggrep -E\n", "" );
    
    while IO_ReadLine( filestream.stdout ) <> "" do od;
    
    IO_Close( filestream.stdin );
    
    IO_Close( filestream.stdout );
    
    IO_Close( filestream.stderr );
    
    if not IsEmpty( err ) then
        Error( err, "\n" );
    fi;
    
    matrix := 4ti2Interface_Read_Matrix_From_File( Concatenation( filename, ".gro" ) );
    
    return matrix;
    
end );

##
InstallGlobalFunction( 4ti2Interface_groebner_matrix,
  function( arg )
    
    return CallFuncList( 4ti2Interface_groebner, arg : transposed := true );
    
end );

##
InstallGlobalFunction( 4ti2Interface_groebner_basis,
  function( arg )
    
    return CallFuncList( 4ti2Interface_groebner, arg : transposed := false );
    
end );

##
InstallGlobalFunction( 4ti2Interface_hilbert_inequalities,
                       
  function( matrix )
    local dir, filename, rel_list, sign_list, exec, precision, filestream, err;
    
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

    exec := 4ti2Interface_BINARIES.hilbert;
    
    precision := ValueOption( "precision" );
    
    if IsInt( precision ) then
        
        precision := String( precision );
        
    elif precision = fail then
        
        precision := "gmp";
        
    fi;
    
    filestream := IO_Popen3( exec, [ Concatenation( "--precision=", precision ), filename ] );
    
    err := Concatenation( IO_ReadLines( filestream.stderr ) );
    
    while IO_ReadLine( filestream.stdout ) <> "" do od;
    
    IO_Close( filestream.stdin );
    
    IO_Close( filestream.stdout );
    
    IO_Close( filestream.stderr );
    
    if not IsEmpty( err ) then
        Error( err, "\n" );
    fi;
    
    matrix := 4ti2Interface_Read_Matrix_From_File( Concatenation( filename, ".hil" ) );
    
    return matrix;
    
end );

##
InstallGlobalFunction( 4ti2Interface_hilbert_inequalities_in_positive_orthant,
                       
  function( matrix )
    local dir, filename, rel_list, sign_list, exec, precision, filestream, err;
    
    if matrix = [ ] then
        
        return [ ];
        
    fi;
    
    dir := DirectoryTemporary();
    
    filename := Filename( dir, "gap_4ti2_temp_ineqs" );
    
    4ti2Interface_Write_Matrix_To_File( matrix, Concatenation( filename, ".mat" ) );
    
    rel_list := [ List( matrix, i -> ">" ) ];
    
    4ti2Interface_Write_Matrix_To_File( rel_list, Concatenation( filename, ".rel" ) );

    exec := 4ti2Interface_BINARIES.hilbert;
    
    precision := ValueOption( "precision" );
    
    if IsInt( precision ) then
        
        precision := String( precision );
        
    elif precision = fail then
        
        precision := "gmp";
        
    fi;

    filestream := IO_Popen3( exec, [ Concatenation( "--precision=", precision ), filename ] );
    
    err := Concatenation( IO_ReadLines( filestream.stderr ) );
    
    while IO_ReadLine( filestream.stdout ) <> "" do od;
    
    IO_Close( filestream.stdin );
    
    IO_Close( filestream.stdout );
    
    IO_Close( filestream.stderr );
    
    if not IsEmpty( err ) then
        Error( err, "\n" );
    fi;
    
    matrix := 4ti2Interface_Read_Matrix_From_File( Concatenation( filename, ".hil" ) );
    
    return matrix;
    
end );

##
InstallGlobalFunction( 4ti2Interface_hilbert_equalities_in_positive_orthant,
                       
  function( matrix )
    local dir, filename, rel_list, sign_list, exec, precision, filestream, err;
    
    if matrix = [ ] then
        
        return [ ];
        
    fi;
    
    dir := DirectoryTemporary();
    
    filename := Filename( dir, "gap_4ti2_temp_ineqs" );
    
    4ti2Interface_Write_Matrix_To_File( matrix, Concatenation( filename, ".mat" ) );
    
    rel_list := [ List( matrix, i -> "=" ) ];
    
    4ti2Interface_Write_Matrix_To_File( rel_list, Concatenation( filename, ".rel" ) );
    
    exec := 4ti2Interface_BINARIES.hilbert;
    
    precision := ValueOption( "precision" );
    
    if IsInt( precision ) then
        
        precision := String( precision );
        
    elif precision = fail then
        
        precision := "gmp";
        
    fi;
    
    filestream := IO_Popen3( exec, [ Concatenation( "--precision=", precision ), filename ] );
    
    err := Concatenation( IO_ReadLines( filestream.stderr ) );
    
    while IO_ReadLine( filestream.stdout ) <> "" do od;
    
    IO_Close( filestream.stdin );
    
    IO_Close( filestream.stdout );
    
    IO_Close( filestream.stderr );
    
    if not IsEmpty( err ) then
        Error( err, "\n" );
    fi;
    
    matrix := 4ti2Interface_Read_Matrix_From_File( Concatenation( filename, ".hil" ) );
    
    return matrix;
    
end );

##
InstallGlobalFunction( 4ti2Interface_hilbert_equalities_and_inequalities,
                       
  function( eqs, ineqs )
    local concat_list, dir, filename, rel_list, sign_list,
          exec, precision, filestream, err, return_matrix;
    
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

    exec := 4ti2Interface_BINARIES.hilbert;
    
    precision := ValueOption( "precision" );
    
    if IsInt( precision ) then
        
        precision := String( precision );
        
    elif precision = fail then
        
        precision := "gmp";
        
    fi;
    
    filestream := IO_Popen3( exec, [ Concatenation( "--precision=", precision ), filename ] );
    
    err := Concatenation( IO_ReadLines( filestream.stderr ) );
    
    while IO_ReadLine( filestream.stdout ) <> "" do od;
    
    IO_Close( filestream.stdin );
    
    IO_Close( filestream.stdout );
    
    IO_Close( filestream.stderr );
    
    if not IsEmpty( err ) then
        Error( err, "\n" );
    fi;
    
    return_matrix := 4ti2Interface_Read_Matrix_From_File( Concatenation( filename, ".hil" ) );
    
    return return_matrix;
    
end );

##
InstallGlobalFunction( 4ti2Interface_hilbert_equalities_and_inequalities_in_positive_orthant,
                       
  function( eqs, ineqs )
    local concat_list, dir, filename, rel_list, sign_list,
          exec, precision, filestream, err, return_matrix;
    
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
    
    exec := 4ti2Interface_BINARIES.hilbert;
    
    precision := ValueOption( "precision" );
    
    if IsInt( precision ) then
        
        precision := String( precision );
        
    elif precision = fail then
        
        precision := "gmp";
        
    fi;
    
    filestream := IO_Popen3( exec, [ Concatenation( "--precision=", precision ), filename ] );
    
    err := Concatenation( IO_ReadLines( filestream.stderr ) );
    
    while IO_ReadLine( filestream.stdout ) <> "" do od;
    
    IO_Close( filestream.stdin );
    
    IO_Close( filestream.stdout );
    
    IO_Close( filestream.stderr );
    
    if not IsEmpty( err ) then
        Error( err, "\n" );
    fi;
    
    return_matrix := 4ti2Interface_Read_Matrix_From_File( Concatenation( filename, ".hil" ) );
    
    return return_matrix;
    
end );

##
InstallGlobalFunction( 4ti2Interface_zsolve_equalities_and_inequalities,
                       
  function( arg )
    local eqs, eqs_rhs, ineqs, ineqs_rhs, signs,
          concat_list, dir, filename, rel_list, concat_rhs,
          exec, precision, filestream, err, return_matrix;
    
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
    
    exec := 4ti2Interface_BINARIES.zsolve;
    
    precision := ValueOption( "precision" );
    
    if IsInt( precision ) then
        
        precision := String( precision );
        
    elif precision = fail then
        
        precision := "gmp";
        
    fi;
    
    filestream := IO_Popen3( exec, [ Concatenation( "--precision=", precision ), filename ] );
    
    err := Concatenation( IO_ReadLines( filestream.stderr ) );
    
    while IO_ReadLine( filestream.stdout ) <> "" do od;
    
    IO_Close( filestream.stdin );
    
    IO_Close( filestream.stdout );
    
    IO_Close( filestream.stderr );
    
    if not IsEmpty( err ) then
        Error( err, "\n" );
    fi;
    
    return_matrix := [ 1, 2, 3 ];
    
    return_matrix[ 1 ] := 4ti2Interface_Read_Matrix_From_File( Concatenation( filename, ".zinhom" ) );
    
    return_matrix[ 2 ] := 4ti2Interface_Read_Matrix_From_File( Concatenation( filename, ".zhom" ) );
    
    if IsExistingFile( Concatenation( filename, ".zfree" ) ) then
      
      return_matrix[ 3 ] := 4ti2Interface_Read_Matrix_From_File( Concatenation( filename, ".zfree" ) );
      
    else
      
      return_matrix[ 3 ] := [ ];
      
    fi;
    
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
        
        signs := ListWithIdenticalEntries( Length( eqs[ 1 ] ), 1 );
        
    else
        
        signs := ListWithIdenticalEntries( Length( ineqs[ 1 ] ), 1 );
        
    fi;
    
    Add( call_list, signs );
    
    return CallFuncList( 4ti2Interface_zsolve_equalities_and_inequalities, call_list );
    
end );

##
InstallGlobalFunction( 4ti2Interface_graver_equalities,
                       
  function( arg )
    local eqs, signs, dir, filename,
          exec, precision, filestream, err, return_matrix;
    
    if Length( arg ) < 1 then
        
        Error( "too few arguments" );
        
        return [ ];
        
    fi;
    
    eqs := arg[ 1 ];
    
    if eqs = [ ] then
        
        return [ ];
        
    fi;
    
    if Length( arg ) > 1 then
        
        signs := [ arg[ 2 ] ];
        
    else
        
        signs := [ ListWithIdenticalEntries( Length( eqs[ 1 ] ), 0 ) ];
        
    fi;
    
    dir := DirectoryTemporary();
    
    filename := Filename( dir, "gap_4ti2_graver" );
    
    4ti2Interface_Write_Matrix_To_File( eqs, Concatenation( filename, ".mat" ) );
    
    4ti2Interface_Write_Matrix_To_File( signs, Concatenation( filename, ".sign" ) );
    
    exec := 4ti2Interface_BINARIES.graver;
    
    precision := ValueOption( "precision" );
    
    if IsInt( precision ) then
        
        precision := String( precision );
        
    elif precision = fail then
        
        precision := "gmp";
        
    fi;
    
    filestream := IO_Popen3( exec, [ Concatenation( "--precision=", precision ), filename ] );
    
    err := Concatenation( IO_ReadLines( filestream.stderr ) );
    
    while IO_ReadLine( filestream.stdout ) <> "" do od;
    
    IO_Close( filestream.stdin );
    
    IO_Close( filestream.stdout );
    
    IO_Close( filestream.stderr );
    
    if not IsEmpty( err ) then
        Error( err, "\n" );
    fi;
    
    return_matrix := 4ti2Interface_Read_Matrix_From_File( Concatenation( filename, ".gra" ) );
    
    return return_matrix;
    
end );

##
InstallGlobalFunction( 4ti2Interface_graver_equalities_in_positive_orthant,
                       
  function( eqs )
    local dir, filename, exec, precision, filestream, err, return_matrix;
    
    dir := DirectoryTemporary();
    
    filename := Filename( dir, "gap_4ti2_graver" );
    
    4ti2Interface_Write_Matrix_To_File( eqs, Concatenation( filename, ".mat" ) );

    exec := 4ti2Interface_BINARIES.graver;
    
    precision := ValueOption( "precision" );
    
    if IsInt( precision ) then
        
        precision := String( precision );
        
    elif precision = fail then
        
        precision := "gmp";
        
    fi;
    
    filestream := IO_Popen3( exec, [ Concatenation( "--precision=", precision ), filename ] );
    
    err := Concatenation( IO_ReadLines( filestream.stderr ) );
    
    while IO_ReadLine( filestream.stdout ) <> "" do od;
    
    IO_Close( filestream.stdin );
    
    IO_Close( filestream.stdout );
    
    IO_Close( filestream.stderr );
    
    if not IsEmpty( err ) then
        Error( err, "\n" );
    fi;
    
    return_matrix := 4ti2Interface_Read_Matrix_From_File( Concatenation( filename, ".gra" ) );
    
    return return_matrix;
    
end );
