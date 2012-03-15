// The usual Header.
#include "loadgap.h"
#include "polymake_data.h"

#include <polymake/Main.h>
#include <polymake/Matrix.h>
#include <polymake/Rational.h>

#include <iostream>
#include <map>
#include <utility>

using std::cerr;
using std::endl;
using std::string;
using std::map;
using std::pair;


Obj REAL_CREATE_POLYTOPE_BY_POINTS( Polymake_Data* , Obj );


Obj REAL_VERTICES_OF_POLYTOPE( Polymake_Data* , Obj );


Obj REAL_CREATE_POLYTOPE_BY_INEQUALITIES( Polymake_Data*, Obj );


Obj REAL_LATTICE_POINTS_OF_POLYTOPE( Polymake_Data*, Obj );


Obj REAL_FACET_INEQUALITIES_OF_POLYTOPE( Polymake_Data*, Obj );


Obj REAL_INTERIOR_LATTICE_POINTS( Polymake_Data*, Obj );

// New 
Obj REAL_CREATE_POLYTOPE_BY_HOMOGENEOUS_POINTS( Polymake_Data*, Obj );


Obj REAL_HOMOGENEOUS_POINTS_OF_POLYTOPE( Polymake_Data*, Obj );


Obj REAL_TAIL_CONE_OF_POLYTOPE( Polymake_Data*, Obj );


Obj REAL_MINKOWSKI_SUM( Polymake_Data*, Obj, Obj );


Obj REAL_MINKOWSKI_SUM_WITH_COEFFICIENTS( Polymake_Data*, Obj, Obj, Obj, Obj );