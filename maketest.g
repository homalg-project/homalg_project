##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "Sheaves" );

LoadPackage( "IO_ForHomalg" );

HOMALG_IO.show_banners := false;
HOMALG_IO.use_common_stream := true;

LoadPackage( "GAPDoc" );

list := [
         "../gap/Modules/RingMaps.gd",
         "../gap/Modules/RingMaps.gi",
         "../gap/Modules/Modules.gd",
         "../gap/Modules/Modules.gi",
         "../gap/Modules/Tate.gd",
         "../gap/Modules/Tate.gi",
         "../gap/Modules/Relative.gd",
         "../gap/Modules/Relative.gi",
         "../gap/LinearSystems.gd",
         "../gap/LinearSystems.gi",
         "../gap/Sheaves.gd",
         "../gap/Sheaves.gi",
         "../gap/Schemes.gd",
         "../gap/Schemes.gi",
         "../gap/MorphismsOfSchemes.gd",
         "../gap/MorphismsOfSchemes.gi",
         "../gap/Curves.gd",
         "../gap/Curves.gi",
         "../gap/Modules/Tools.gd",
         "../gap/Modules/Tools.gi",
         "../examples/DE-2.2.g",
         "../examples/DE-Code.g",
         ];

MyTestManualExamples :=
function ( arg )
    local  ex, bad, res, a;
    if IsRecord( arg[1] )  then
        ex := ManualExamplesXMLTree( arg[1], "Single" );
    else
        ex := ManualExamples( arg[1], arg[2], arg[3], "Single" );
    fi;
    bad := Filtered( ex, function ( a )
            return TestExamplesString( a ) <> true;
        end );
    res := [  ];
    for a  in bad  do
        Print( "===========================\n" );
        PrintFormattedString( a );
        Add( res, TestExamplesString( a, true ) );
    od;
    return res;
end;

size := SizeScreen( );
SizeScreen([80]);

MyTestManualExamples( DirectoriesPackageLibrary( "Sheaves", "doc" )[1]![1], "SheavesForHomalg.xml", list );

GAPDocManualLab("Sheaves");

SizeScreen( size );

quit;

