##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage("GAPDoc");

MakeGAPDocDoc("doc", "GaussForHomalg", [ "../gap/GaussForHomalg.gi", "../gap/GaussTools.gi", "../gap/GaussBasic.gi", "../gap/GaussFQI.gi" ], "GaussForHomalg");

GAPDocManualLab("GaussForHomalg");

quit;

