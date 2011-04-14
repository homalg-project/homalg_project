#############################################################################
##
##  HomalgToCAS.gi           HomalgToCAS package             Mohamed Barakat
##
##  Copyright 2007-2010 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for HomalgToCAS.
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
            show_banners := true,
            variable_name := "homalg_variable_",
            InformAboutCASystemsWithoutActiveRings := true,
            SaveHomalgMaximumBackStream := false,
            color_display := false,
            DirectoryForTemporaryFiles := "/dev/shm/",
            DoNotFigureOutAnAlternativeDirectoryForTemporaryFiles := false,
            DoNotDeleteTemporaryFiles := false,
            ListOfAlternativeDirectoryForTemporaryFiles := [ "/dev/shm/", "/var/tmp/", "/tmp/", "./" ],
            FileNameCounter := 1,
            DeletePeriod := 500,
            PID := IO_getpid(),
            save_CAS_commands_to_file := false,
            suppress_CAS := false,
            suppress_PID := false,
              ##  <#GAPDoc Label="Pictograms">
              ##  <ManSection>
              ##    <Var Name="HOMALG_IO.Pictograms"/>
              ##    <Description>
              ##      The record of pictograms is a component of the record <C>HOMALG_IO</C>.
              ##    <Listing Type="Code"><![CDATA[
            Pictograms := rec(
                
                ##
                ## colors:
                ##
                
                ## pictogram color of a "need_command" or assignment operation:
                color_need_command                      := "\033[1;33;44m",
                
                ## pictogram color of a "need_output" or "need_display" operation:
                color_need_output                       := "\033[1;34;43m",
                
                ##
                ## good morning computer algebra system:
                ##
                
                ## initialize:
                initialize                              := "ini",
                
                ## define macros:
                define                                  := "def",
                
                ## get time:
                time                                    := ":ms",
                
                ## memory usage:
                memory                                  := "mem",
                
                ##
                ## external garbage collection:
                ##
                
                ## delete a variable:
                delete                                  := "xxx",
                
                ## delete serveral variables:
                multiple_delete                         := "XXX",
                
                ## trigger the garbage collector:
                garbage_collector                       := "grb",
                
                ##
                ## create lists:
                ##
                
                ## define a list:
                CreateList                              := "lst",
                
                ##
                ## create rings:
                ##
                
                ## define a ring:
                CreateHomalgRing                        := "R:=",
                
                ## get the names of the "variables" defining the ring:
                variables                               := "var",
                
                ## define zero:
                Zero                                    := "0:=",
                
                ## define one:
                One                                     := "1:=",
                
                ## define minus one:
                MinusOne                                := "-:=",
                
                ##
                ## mandatory ring operations:
                ##
                
                ## get the name of an element:
                ## (important if the CAS pretty-prints ring elements,
                ##  we need names that can be used as input!)
                ## (install a method instead of a homalgTable entry)
                homalgSetName                           := "\"a\"",
                
                ## a = 0 ?
                IsZero                                  := "a=0",
                
                ## a = 1 ?
                IsOne                                   := "a=1",
                
                ## substract two ring elements
                ## (needed by SimplerEquivalentMatrix in case
                ##  CopyRow/ColumnToIdentityMatrix are not defined):
                Minus                                   := "a-b",
                
                ## divide the element a by the unit u
                ## (needed by SimplerEquivalentMatrix in case
                ##  DivideEntryByUnit is not defined):
                DivideByUnit                            := "a/u",
                
                ## degree of the polynomial:
                DegreeOfRingElement                     := "deg",
                
                ## important ring operations:
                ## (important for performance since existing
                ##  fallback methods cause a lot of traffic):
                
                ## is u a unit?
                ## (mainly needed by the fallback methods for matrices, see below):
                IsUnit                                  := "?/u",
                
                ##
                ## optional ring operations:
                ##
                
                ## add two ring elements:
                Sum                                     := "a+b",
                
                ## multiply two ring elements:
                Product                                 := "a*b",
                
                ## the (greatest) common divisor:
                Gcd                                     := "gcd",
                
                ## cancel the (greatest) common divisor:
                CancelGcd                               := "ccd",
                
                ##
                ## create matrices:
                ##
                
                ## define a matrix:
                HomalgMatrix                            := "A:=",
                
                ## copy a matrix:
                CopyMatrix                              := "A>A",
                
                ## load a matrix from file:
                LoadHomalgMatrixFromFile                := "A<<",
                
                ## save a matrix to file:
                SaveHomalgMatrixToFile                  := "A>>",
                
                ## get a matrix entry as a string:
                GetEntryOfHomalgMatrix                  := "<ij",
                
                ## set a matrix entry from a string:
                SetEntryOfHomalgMatrix                  := ">ij",
                
                ## add to a matrix entry from a string:
                AddToEntryOfHomalgMatrix                := "+ij",
                
                ## get a list of the matrix entries as a string:
                GetListOfHomalgMatrixAsString           := "\"A\"",
                
                ## get a listlist of the matrix entries as a string:
                GetListListOfHomalgMatrixAsString       := "\"A\"",
                
                ## get a "sparse" list of the matrix entries as a string:
                GetSparseListOfHomalgMatrixAsString     := ".A.",
                
                ## assign a "sparse" list of matrix entries to a variable:
                sparse                                  := "spr",
                
                ##
                ## mandatory matrix operations:
                ##
                
                ## test if a matrix is the zero matrix:
                ## CAUTION: the external system must be able to check
                ##          if the matrix is zero modulo possible ring relations
                ##          only known to the external system!
                IsZeroMatrix                            := "A=0",
                
                ## number of rows:
                NrRows                                  := "#==",
                
                ## number of columns:
                NrColumns                               := "#||",
                
                ## determinant of a matrix over a (commutative) ring:
                Determinant                             := "det",
                
                ## create a zero matrix:
                ZeroMatrix                              := "(0)",
                
                ## create a initial zero matrix:
                InitialMatrix                           := "[0]",
                
                ## create an identity matrix:
                IdentityMatrix                          := "(1)",
                
                ## create an initial identity matrix:
                InitialIdentityMatrix                   := "[1]",
                
                ## "transpose" a matrix (with "the" involution of the ring):
                Involution                              := "A^*",
                
                ## get certain rows of a matrix:
                CertainRows                             := "===",
                
                ## get certain columns of a matrix:
                CertainColumns                          := "|||",
                
                ## stack to matrices vertically:
                UnionOfRows                             := "A_B",
                
                ## glue to matrices horizontally:
                UnionOfColumns                          := "A|B",
                
                ## create a block diagonal matrix:
                DiagMat                                 := "A\\B",
                
                ## the Kronecker (tensor) product of two matrices:
                KroneckerMat                            := "AoB",
                
                ## multiply a matrix with a ring element:
                MulMat                                  := "a*A",
                
                ## add two matrices:
                AddMat                                  := "A+B",
                
                ## substract two matrices:
                SubMat                                  := "A-B",
                
                ## multiply two matrices:
                Compose                                 := "A*B",
                
                ##
                ## important matrix operations:
                ## (important for performance since existing
                ##  fallback methods cause a lot of traffic):
                ##
                
                ## test if two matrices are equal:
                ## CAUTION: the external system must be able to check
                ##          equality of the two matrices modulo possible ring relations
                ##          only known to the external system!
                AreEqualMatrices                        := "A=B",
                
                ## test if a matrix is the identity matrix:
                IsIdentityMatrix                        := "A=1",
                
                ## test if a matrix is diagonal (needed by the display method):
                IsDiagonalMatrix                        := "A=\\",
                
                ## get the positions of the zero rows:
                ZeroRows                                := "0==",
                
                ## get the positions of the zero columns:
                ZeroColumns                             := "0||",
                
                ## get "column-independent" unit positions
                ## (needed by ReducedBasisOfModule):
                GetColumnIndependentUnitPositions       := "ciu",
                
                ## get "row-independent" unit positions
                ## (needed by ReducedBasisOfModule):
                GetRowIndependentUnitPositions          := "riu",
                
                ## transposed matrix:
                TransposedMatrix                        := "^tr",
                
                ## get the position of the "first" unit in the matrix
                ## (needed by SimplerEquivalentMatrix):
                GetUnitPosition                         := "gup",
                
                ## divide an entry of a matrix by a unit
                ## (needed by SimplerEquivalentMatrix in case
                ##  DivideRow/ColumnByUnit are not defined):
                DivideEntryByUnit                       := "ij/",
                
                ## divide a row by a unit
                ## (needed by SimplerEquivalentMatrix):
                DivideRowByUnit                         := "-/u",
                
                ## divide a column by a unit
                ## (needed by SimplerEquivalentMatrix):
                DivideColumnByUnit                      := "|/u",
                
                ## divide a row by a unit
                ## (needed by SimplerEquivalentMatrix):
                CopyRowToIdentityMatrix                 := "->-",
                
                ## divide a column by a unit
                ## (needed by SimplerEquivalentMatrix):
                CopyColumnToIdentityMatrix              := "|>|",
                
                ## set a column (except a certain row) to zero
                ## (needed by SimplerEquivalentMatrix):
                SetColumnToZero                         := "|=0",
                
                ## get the positions of the rows with a single one
                ## (needed by SimplerEquivalentMatrix):
                GetCleanRowsPositions                   := "crp",
                
                ## convert a single row matrix into a matrix
                ## with specified number of rows/columns
                ## (needed by the display methods for homomorphisms):
                ConvertRowToMatrix                      := "-%A",
                
                ## convert a single column matrix into a matrix
                ## with specified number of rows/columns
                ## (needed by the display methods for homomorphisms):
                ConvertColumnToMatrix                   := "|%A",
                
                ## convert a matrix into a single row matrix:
                ConvertMatrixToRow                      := "A%-",
                
                ## convert a matrix into a single column matrix:
                ConvertMatrixToColumn                   := "A%|",
                
                ## degrees of entries:
                DegreesOfEntries                        := "doe",
                
                ## degree of the first non-trivial entry per row:
                NonTrivialDegreePerRow                  := "dpr",
                
                ## degree of the first non-trivial entry per column:
                NonTrivialDegreePerColumn               := "dpc",
                
                ##
                ## basic matrix operations:
                ##
                
                ## compute a (r)educed (e)chelon (f)orm:
                ReducedEchelonForm                      := "ref",
                
                ## compute a "(bas)is" of a given set of module elements:
                BasisOfModule                           := "bas",
                
                ## compute a reduced "(Bas)is" of a given set of module elements:
                ReducedBasisOfModule                    := "Bas",
                
                ## (d)e(c)ide the ideal/submodule membership problem,
                ## i.e. if an element is (0) modulo the ideal/submodule:
                DecideZero                              := "dc0",
                
                ## compute a generating set of (syz)ygies:
                SyzygiesGenerators                      := "syz",
                
                ## compute a generating set of reduced (Syz)ygies:
                ReducedSyzygiesGenerators               := "Syz",
                
                ## compute a (R)educed (E)chelon (F)orm
                ## together with the matrix of coefficients:
                ReducedEchelonFormC                     := "REF",
                
                ## compute a "(BAS)is" of a given set of module elements
                ## together with the matrix of coefficients:
                BasisCoeff                              := "BAS",
                
                ## (D)e(C)ide the ideal/submodule membership problem,
                ## i.e. write an element effectively as (0) modulo the ideal/submodule:
                DecideZeroEffectively                   := "DC0",
                
                ##
                ## optional matrix operations:
                ##
                
                ## affine dimension of a module:
                AffineDimension                         := "dim",
                
                ## affine degree of a module:
                AffineDegree                            := "adg",
                
                ## the constant term of the hilbert polynomial:
                ConstantTermOfHilbertPolynomial         := "P_0",
                
                ## primary decomposition:
                PrimaryDecomposition                    := "YxZ",
                
                ## eliminate variables:
                Eliminate                               := "eli",
                
                ## coefficients:
                Coefficients                            := "cof",
                
                ##
                ## optional module operations:
                ##
                
                ## compute a better equivalent matrix
                ## (field -> row+col Gauss, PIR -> Smith, Dedekind domain -> Krull, etc ...):
                BestBasis                               := "(\\)",
                
                ## compute elementary divisors:
                ElementaryDivisors                      := "div",
                
                ##
                ## for the eye:
                ##
                
                ## display objects:
                Display                                 := "dsp",
                
                ## the LaTeX code of the mathematical entity:
                homalgLaTeX                             := "TeX",
                
              )
              ##  ]]></Listing>
              ##    </Description>
              ##  </ManSection>
              ##  <#/GAPDoc>
           )
);

####################################
#
# global functions and operations:
#
####################################

##
InstallGlobalFunction( homalgTime,
  function( arg )
    local nargs, st, object, stream, t;
    
    nargs := Length( arg );
    
    if nargs = 0 then
        return homalgTotalRuntimes( );
    elif nargs = 1 then
        st := arg[1];
        if IsInt( st ) then
            return homalgTotalRuntimes( ) - st;
        fi;
        return homalgTime( st, 0 );
    fi;
    
    ## we now know thar nargs > 1
    
    object := arg[1];
    
    if IsRecord( object ) then
        if not ( IsBound( object.lines ) and IsBound( object.pid ) ) then
            Error( "the first argument is a record but not a stream\n" );
        fi;
        stream := object;
    else
        stream := homalgStream( object );
    fi;
    
    t := arg[2];
    
    if not IsInt( t ) then
        Error( "the second argument must be an integer\n" );
    fi;
    
    if not IsBound( stream.time ) then
        Error( "the stream does not include a component called \"time\"\n" );
    fi;
    
    return stream.time( stream, t );
    
end );

##
InstallGlobalFunction( homalgMemoryUsage,
  function( arg )
    local nargs, o, object, stream;
    
    nargs := Length( arg );
    
    if nargs = 0 then
        Error( "empty input\n" );
    elif nargs = 1 then
        o := arg[1];
        return homalgMemoryUsage( o, 0 );
    fi;
    
    ## we now know thar nargs > 1
    
    object := arg[1];
    
    if IsRecord( object ) then
        if not ( IsBound( object.lines ) and IsBound( object.pid ) ) then
            Error( "the first argument is a record but not a stream\n" );
        fi;
        stream := object;
    else
        stream := homalgStream( object );
    fi;
    
    o := arg[2];
    
    if not IsInt( o ) then
        Error( "the second argument must be an integer\n" );
    fi;
    
    if not IsBound( stream.memory_usage ) then
        Error( "the stream does not include a component called \"memory_usage\"\n" );
    fi;
    
    return stream.memory_usage( stream, o );
    
end );

##
InstallGlobalFunction( FigureOutAnAlternativeDirectoryForTemporaryFiles,
  function( arg )
    local nargs, file, list, separator, pos_sep, l, directory, filename, fs;
    
    nargs := Length( arg );
    
    if nargs = 0 then
        Error( "empty input" );
    fi;
    
    file := arg[1];
    
    if IsBound( HOMALG_IO.ListOfAlternativeDirectoryForTemporaryFiles ) then
        list := HOMALG_IO.ListOfAlternativeDirectoryForTemporaryFiles;
    else
        list := [ "/dev/shm/", "/var/tmp/", "/tmp/" ];
    fi;
    
    ## figure out the directory separtor:
    if IsBound( GAPInfo.UserHome ) then
        separator := GAPInfo.UserHome[1];
    else
        separator := '/';
    fi;
    
    if nargs > 1 then
        pos_sep := PositionProperty( Reversed( file ), c -> c = separator );
        if pos_sep <> fail then
            l := Length( file );
            file := file{[ l - pos_sep + 2 .. l ]};
        fi;
    fi;
    
    for directory in list do
        
        if directory[Length( directory )] <> separator then
            filename := Concatenation( directory, [ separator ], file );
        else
            filename := Concatenation( directory, file );
        fi;
        
        fs := IO_File( filename, "w" );
        
        if fs <> fail then
            IO_Close( fs );
            if nargs > 1 and arg[2] = "with_filename" then
                return filename;
            else
                return directory;
            fi;
        fi;
        
    od;
    
    return fail;
    
end );

##  <#GAPDoc Label="homalgIOMode">
##  <ManSection>
##    <Func Arg="str[, str2[, str3]]" Name="homalgIOMode"/>
##    <Description>
##      This function sets different modes which influence how much of the communication becomes visible.
##      Handling the string <A>str</A> is <E>not</E> case-sensitive. <C>homalgIOMode</C> invokes
##      the global function <C>homalgMode</C> defined in the &homalg; package with an <Q>appropriate</Q> argument (see code below).
##      Alternatively, if a second or more strings are given, then <C>homalgMode</C> is invoked with the remaining strings
##      <A>str2</A>, <A>str3</A>, ... at the end. In particular, you can use <C>homalgIOMode</C>( <A>str</A>, "" ) to reset the effect
##      of invoking <C>homalgMode</C>.
##      <Table Align="l|c|l">
##      <Row>
##        <Item><A>str</A></Item>
##        <Item><A>str</A> (long form)</Item>
##        <Item>mode description</Item>
##      </Row>
##      <HorLine/>
##      <Row><Item></Item><Item></Item><Item></Item></Row>
##      <Row>
##        <Item>""</Item>
##        <Item>""</Item>
##        <Item>the default mode, i.e. the communication protocol won't be visible</Item>
##      </Row>
##      <Row>
##        <Item></Item>
##        <Item></Item>
##        <Item>(<C>homalgIOMode</C>( ) is a short form for <C>homalgIOMode</C>( "" ))</Item>
##      </Row>
##      <Row><Item></Item><Item></Item><Item></Item></Row>
##      <Row>
##        <Item>"a"</Item>
##        <Item>"all"</Item>
##        <Item>combine the modes "debug" and "file"</Item>
##      </Row>
##      <Row><Item></Item><Item></Item><Item></Item></Row>
##      <Row>
##        <Item>"b"</Item>
##        <Item>"basic"</Item>
##        <Item>the same as "picto" + <C>homalgMode</C>( "basic" )</Item>
##      </Row>
##      <Row><Item></Item><Item></Item><Item></Item></Row>
##      <Row>
##        <Item>"d"</Item>
##        <Item>"debug"</Item>
##        <Item>view the complete communication protocol</Item>
##      </Row>
##      <Row><Item></Item><Item></Item><Item></Item></Row>
##      <Row>
##        <Item>"f"</Item>
##        <Item>"file"</Item>
##        <Item>dump the communication protocol into a file with the name</Item>
##      </Row>
##      <Row>
##        <Item></Item>
##        <Item></Item>
##        <Item><C>Concatenation</C>( "commands_file_of_", CAS, "_with_PID_", PID )</Item>
##      </Row>
##      <Row><Item></Item><Item></Item><Item></Item></Row>
##      <Row>
##        <Item>"p"</Item>
##        <Item>"picto"</Item>
##        <Item>view the abbreviated communication protocol</Item>
##      </Row>
##      <Row>
##        <Item></Item>
##        <Item></Item>
##        <Item>using the preassigned pictograms</Item>
##      </Row>
##      <Row><Item></Item><Item></Item><Item></Item></Row>
##      <HorLine/>
##      </Table>
##      All modes other than the "default"-mode only set their specific values and leave
##      the other values untouched, which allows combining them to some extent. This also means that
##      in order to get from one mode to a new mode (without the aim to combine them)
##      one needs to reset to the "default"-mode first. <Br/><Br/>
##      <E>Caution</E>:
##      <List>
##        <Item>In case you choose one of the modes "file" or "all" you might want to set
##          the global variable <C>HOMALG_IO.DoNotDeleteTemporaryFiles</C> := <C>true</C>;
##          this is only important if during the computations some matrices get converted via files
##          (using <C>ConvertHomalgMatrixViaFile</C>), as reading these files will be part of the protocol!</Item>
##        <Item>It makes sense for the dumped communication protocol to be (re)executed with the respective external system,
##          only in case the latter is deterministic (i.e. same-input-same-output).</Item>
##      </List>
##      <Listing Type="Code"><![CDATA[
InstallGlobalFunction( homalgIOMode,
  function( arg )
    local nargs, mode, s;
    
    nargs := Length( arg );
    
    if nargs = 0 or ( IsString( arg[1] ) and arg[1] = "" ) then
        mode := "default";
    elif IsString( arg[1] ) then	## now we know, the string is not empty
        s := arg[1];
        if LowercaseString( s{[1]} ) = "a" then
            mode := "all";
        elif LowercaseString( s{[1]} ) = "b" then
            mode := "basic";
        elif LowercaseString( s{[1]} ) = "d" then
            mode := "debug";
        elif LowercaseString( s{[1]} ) = "f" then
            mode := "file";
        elif LowercaseString( s{[1]} ) = "p" then
            mode := "picto";
        else
            mode := "";
        fi;
    else
        Error( "the first argument must be a string\n" );
    fi;
    
    if mode = "default" then
        ## reset to the default values
        HOMALG_IO.color_display := false;
        HOMALG_IO.show_banners := true;
        HOMALG_IO.save_CAS_commands_to_file := false;
        HOMALG_IO.DoNotDeleteTemporaryFiles := false;
        HOMALG_IO.SaveHomalgMaximumBackStream := false;
        HOMALG_IO.InformAboutCASystemsWithoutActiveRings := true;
        SetInfoLevel( InfoHomalgToCAS, 1 );
        homalgMode( );
    elif mode = "all" then
        homalgIOMode( "debug" );
        homalgIOMode( "file" );
    elif mode = "basic" then
        HOMALG_IO.color_display := true;
        HOMALG_IO.show_banners := true;
        SetInfoLevel( InfoHomalgToCAS, 4 );
        homalgMode( "basic" );	## use homalgIOMode( "basic", "" ) to reset
    elif mode = "debug" then
        HOMALG_IO.color_display := true;
        HOMALG_IO.show_banners := true;
        SetInfoLevel( InfoHomalgToCAS, 8 );
        homalgMode( "debug" );	## use homalgIOMode( "debug", "" ) to reset
    elif mode = "file" then
        HOMALG_IO.save_CAS_commands_to_file := true;
    elif mode = "picto" then
        HOMALG_IO.color_display := true;
        HOMALG_IO.show_banners := true;
        SetInfoLevel( InfoHomalgToCAS, 4 );
        homalgMode( "logic" );	## use homalgIOMode( "picto", "" ) to reset
    fi;
    
    if nargs > 1 and IsString( arg[2] ) then
        CallFuncList( homalgMode, arg{[ 2 .. nargs ]} );
    fi;
    
end );
##  ]]></Listing>
##    </Description>
##    <#Include Label="homalgSendBlocking:view_communication">
##  </ManSection>
##  <#/GAPDoc>
