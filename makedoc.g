##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage("GAPDoc");

MakeGAPDocDoc("doc", "IO_ForHomalg", [], "IO_ForHomalg");

GAPDocManualLab("IO_ForHomalg");

quit;

