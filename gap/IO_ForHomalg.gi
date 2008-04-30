#############################################################################
##
##  HomalgExternalRing.gi     IO_ForHomalg package           Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for IO_ForHomalg.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( HOMALG_IO,
        rec(
            SaveHomalgMaximumBackStream := false,
            color_display := false,
	    DirectoryForTemporaryFiles := "./",
	    DoNotFigureOutAnAlternativeDirectoryForTemporaryFiles := false,
	    DoNotDeleteTemporaryFiles := false,
	    ListOfAlternativeDirectoryForTemporaryFiles := [ "/dev/shm/", "/var/tmp/", "/tmp/" ],
            FileNameCounter := 1,
            PID := IO_getpid(),
            CODE := [ 
                      ## good morning computer algebra system:
                      "ini",	## initialize
                      "def",	## define macros
                      
                      ## create rings:
                      "R:=",	## define a ring ............................................... CreateHomalgRing
                      
                      ## ring operations:
                      "a-b",	## substract two ring elements ................................. Minus
                      
                      ## create matrices:
                      "A:=",	## define a matrix ............................................. HomalgMatrix (CreateHomalgMatrix, CreateHomalgSparseMatrix)
                      "<<A",	## load a matrix from file                                       LoadDataOfHomalgMatrixFromFile
                      "A>>",	## save a matrix to file ....................................... SaveDataOfHomalgMatrixToFile
                      "<ij",	## get a matrix entry as a string                                GetEntryOfHomalgMatrixAsString
                      "ij>",	## set a matrix entry from a string ............................ SetEntryOfHomalgMatrix
                      "\"A\"",	## get a list of the matrix entries as a string                  GetListOfHomalgMatrixAsString
                      "\"A\"",	## get a listlist of the matrix entries as a string ............ GetListListOfHomalgMatrixAsString
                      ".A.",	## get a "sparse" list of the matrix entries as a string         GetSparseListOfHomalgMatrixAsString
                      "spr",	## assign a "sparse" list of matrix entries to a variable
                      
                      ## matrix operations:
                      "A=0",	## test if a matrix is the zero matrix ......................... IsZeroMatrix
                      "0==",	## get the positions of the zero rows                            ZeroRows
                      "0||",	## get the positions of the zero columns ....................... ZeroColumns
                      "A=B",	## test if two matrices are equal                                AreEqualMatrices
                      "(0)",	## create a zero matrix ........................................ ZeroMatrix
                      "(1)",	## create an identity matrix                                     IdentityMatrix
                      "A^*",	## "transpose" a matrix (with "the" involution of the ring) .... Involution
                      "===",	## get certain rows of a matrix                                  CertainRows
                      "A_B",	## stack to matrices vertically ................................ UnionOfRows
                      "A|B",	## glue to matrices horizontally                                 UnionOfColumns
                      "A\\B",	## create a block diagonal matrix .............................. DiagMat
                      "A°B",	## the Kronecker (tensor) product of two matrices                KroneckerMat
                      "a*A",	## multiply a matrix with a ring element ....................... MulMat
                      "A+B",	## add two matrices                                              AddMat
                      "A-B",	## substract two matrices ...................................... SubMat
                      "A*B",	## multiply two matrices                                         Compose
                      "#==",	## number of rows .............................................. NrRows
                      "#||",	## number of columns                                             NrColumns
                      
                      ## operations to compute a simpler equivalent matrix (one also needs Minus and DivideByUnit from above):
                      "gup",	## get the position of the "first" unit in the matrix .......... GetUnitPosition
                      "crp",	## get the positions of the rows with a single one               GetCleanRowsPositions
                      
                      ## basic operations:
                      "TRI",	## compute a triangular basis .................................. TriangularBasisOfRows, TriangularBasisOfColumns
                      "BAS",	## compute a "basis" of a given set of module elements           BasisOfRowModule, BasisOfColumnModule
                      "DC0",	## decide the ideal/submodule membership problem ............... DecideZeroRows, DecideZeroColumns
                      "SYZ",	## compute a generating set of syzygies                          SyzygiesGeneratorsOfRows, SyzygiesGeneratorsOfColumns
                      
                      ## optional operations:
                      "(\\)",	## compute a better equivalent matrix (Smith, Krull) ........... BestBasis
                      "div",	## compute elementary divisors                                   ElementaryDivisors
                      
                      ## for the eye:
                      "dsp",	## display whatever you want ;) ................................ Display
                      "TeX",	## the LaTeX code of the mathematical entity ................... homalgLaTeX
                    ]
           )
);

####################################
#
# global functions and operations:
#
####################################

##
InstallGlobalFunction( FigureOutAnAlternativeDirectoryForTemporaryFiles,
  function( file )
    local list, separator, directory, filename, fs;
    
    if IsBound( HOMALG_IO.ListOfAlternativeDirectoryForTemporaryFiles ) then
        list := HOMALG_IO.ListOfAlternativeDirectoryForTemporaryFiles;
    else
        list := [ "/dev/shm/", "/var/tmp/", "/tmp/" ];
    fi;
    
    ## figure out the directory separtor:
    if IsBound( GAPInfo.UserHome ) then
        separator := GAPInfo.UserHome{[1]};
    else
        separator := "/";
    fi;
    
    for directory in list do
        
        if directory{[Length(directory)]} <> separator then
            filename := Concatenation( directory, separator, file );
        else
            filename := Concatenation( directory, file );
        fi;
        
        fs := IO_File( filename, "w" );
        
        if fs <> fail then
	    IO_Close( fs );
            return directory;
        fi;
        
    od;
    
    return fail;
    
end );
