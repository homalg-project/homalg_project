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


Obj REAL_FAN_BY_CONES_SAVE( Polymake_Data*, Obj );


Obj REAL_FAN_BY_CONES( Polymake_Data*, Obj );


Obj REAL_FAN_BY_RAYS_AND_CONES( Polymake_Data*, Obj, Obj );