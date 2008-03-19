##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage("GAPDoc");

MakeGAPDocDoc("doc", "RingsForHomalg", [], "RingsForHomalg");

GAPDocManualLab("RingsForHomalg");

quit;

