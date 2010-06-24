##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "homalg" );
LoadPackage( "GAPDoc" );

list := [
         "../gap/homalg.gi",
         "../gap/HomalgDiagram.gd",
         "../gap/HomalgDiagram.gi",
         "../gap/HomalgRingMap.gd",
         "../gap/HomalgRingMap.gi",
         "../gap/HomalgRelations.gd",
         "../gap/HomalgRelations.gi",
         "../gap/HomalgGenerators.gd",
         "../gap/HomalgGenerators.gi",
         "../gap/HomalgObject.gd",
         "../gap/HomalgObject.gi",
         "../gap/HomalgSubmodule.gd",
         "../gap/HomalgSubmodule.gi",
         "../gap/HomalgMorphism.gd",
         "../gap/HomalgMorphism.gi",
         "../gap/HomalgFiltration.gd",
         "../gap/HomalgFiltration.gi",
         "../gap/HomalgComplex.gd",
         "../gap/HomalgComplex.gi",
         "../gap/HomalgChainMap.gd",
         "../gap/HomalgChainMap.gi",
         "../gap/HomalgBicomplex.gd",
         "../gap/HomalgBicomplex.gi",
         "../gap/HomalgBigradedObject.gd",
         "../gap/HomalgBigradedObject.gi",
         "../gap/HomalgSpectralSequence.gd",
         "../gap/HomalgSpectralSequence.gi",
         "../gap/HomalgFunctor.gd",
         "../gap/HomalgFunctor.gi",
         "../gap/BasicFunctors.gd",
         "../gap/BasicFunctors.gi",
         "../gap/StaticObjects.gi",
         "../gap/Modules/HomalgModule.gd",
         "../gap/Modules/HomalgModule.gi",
         "../gap/Modules/HomalgMap.gd",
         "../gap/Modules/HomalgMap.gi",
         "../gap/Modules/Modules.gi",
         "../gap/LIMAP.gi",
         "../gap/Modules/BasicFunctors.gi",
         "../examples/RHom_Z.g",
         "../examples/LTensorProduct_Z.g",
         "../examples/ExtExt.g",
         "../examples/Purity.g",
         "../examples/Grothendieck_TorExt.g",
         "../examples/TorExt.g",
         "../examples/Hom(Hom(-,Z128),Z16)_On_Seq.g",
         "../examples/Saturate.g",
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

MyTestManualExamples( DirectoriesPackageLibrary( "homalg", "doc" )[1]![1], "homalg.xml", list );

GAPDocManualLab( "homalg" );

SizeScreen( size );

quit;
