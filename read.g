#############################################################################
##
##  read.g                    Gauss package                   Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Reading the implementation part of the Gauss package.
##
#############################################################################

################################
# First look after our C part: #
################################

# load kernel function if it is installed:
if (not IsBound(ADD_SPARSE_GF2_VECS)) and ("gauss" in SHOW_STAT()) then
  # try static module
  LoadStaticModule("gauss");
fi;
if (not IsBound(ADD_SPARSE_GF2_VECS)) and
   (Filename(DirectoriesPackagePrograms("gauss"), "gauss.so") <> fail) then
  LoadDynamicModule(Filename(DirectoriesPackagePrograms("gauss"), "gauss.so"));
fi;

ReadPackage( "Gauss", "gap/GaussDense.gi" );

##

ReadPackage( "Gauss", "gap/SparseMatrix.gi" );

ReadPackage( "Gauss", "gap/SparseMatrixGF2.gi" );

##

ReadPackage( "Gauss", "gap/Sparse.gi" );

ReadPackage( "Gauss", "gap/GaussSparse.gi" );

ReadPackage( "Gauss", "gap/GaussSparseGF2.gi" );

ReadPackage( "Gauss", "gap/HermiteSparse.gi" );

