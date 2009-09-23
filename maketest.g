##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "homalg" );
LoadPackage( "GAPDoc" );

list := [
         "../gap/HomalgDiagram.gd",
         "../gap/HomalgDiagram.gi",
         "../gap/HomalgRing.gd",
         "../gap/HomalgRing.gi",
         "../gap/HomalgRingMap.gd",
         "../gap/HomalgRingMap.gi",
         "../gap/LIRNG.gi",
         "../gap/HomalgMatrix.gd",
         "../gap/HomalgMatrix.gi",
         "../gap/HomalgRelations.gd",
         "../gap/HomalgRelations.gi",
         "../gap/HomalgGenerators.gd",
         "../gap/HomalgGenerators.gi",
         "../gap/HomalgResidueClassRing.gd",
         "../gap/HomalgResidueClassRing.gi",
         "../gap/HomalgModule.gd",
         "../gap/HomalgModule.gi",
         "../gap/HomalgMap.gd",
         "../gap/HomalgMap.gi",
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
         "../gap/Modules.gi",
         "../gap/Tools.gi",
         "../examples/RHom_Z.g",
         "../examples/LTensorProduct_Z.g",
         "../examples/ExtExt.g",
         "../examples/Purity.g",
         "../examples/torext.g",
         "../examples/TorExt.g",
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

MyTestManualExamples( "doc", "homalg.xml", list );

GAPDocManualLab( "homalg" );

quit;
