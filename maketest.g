##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "Modules" );
LoadPackage( "GAPDoc" );

list := [
         "../gap/HomalgRingMap.gd",
         "../gap/HomalgRingMap.gi",
         "../gap/HomalgRelations.gd",
         "../gap/HomalgRelations.gi",
         "../gap/HomalgGenerators.gd",
         "../gap/HomalgGenerators.gi",
         "../gap/HomalgModule.gd",
         "../gap/HomalgModule.gi",
         "../gap/HomalgSubmodule.gd",
         "../gap/HomalgSubmodule.gi",
         "../gap/HomalgMap.gd",
         "../gap/HomalgMap.gi",
         "../gap/Modules.gi",
         "../gap/LIMAP.gi",
         "../gap/BasicFunctors.gi",
         "../examples/RHom_Z.g",
         "../examples/LTensorProduct_Z.g",
         "../examples/ExtExt.g",
         "../examples/Purity.g",
         "../examples/TorExt_Grothendieck.g",
         "../examples/TorExt.g",
         "../examples/Hom(Hom(-,Z128),Z16)_On_Seq.g",
         "../examples/Saturate.g",
         "../gap/Tools.gi",
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

MyTestManualExamples( DirectoriesPackageLibrary( "Modules", "doc" )[1]![1], "ModulesForHomalg.xml", list );

GAPDocManualLab( "Modules" );

SizeScreen( size );

quit;
