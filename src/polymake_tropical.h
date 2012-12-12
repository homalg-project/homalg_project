#include "loadgap.h"
#include "polymake_data.h"

#include <polymake/Main.h>
#include <polymake/Matrix.h>
#include <polymake/Rational.h>
#include <polymake/IncidenceMatrix.h>
#include <polymake/Array.h>
#include <polymake/Set.h>

#include <iostream>
#include <map>
#include <utility>

using std::cerr;
using std::endl;
using std::string;
using std::map;
using std::pair;

Obj REAL_TROPICAL_HYPERSURFACE_BY_MONOMS_AND_COEFFICIENTS( Polymake_Data*, Obj, Obj );

Obj REAL_MONOMIALS_OF_HYPERSURFACE( Polymake_Data*, Obj );

Obj REAL_COEFFICIENTS_OF_HYPERSURFACE( Polymake_Data*, Obj );