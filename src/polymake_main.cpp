/***************************************************************************
**
**  polymake_main.cpp       Sebastian Gutsche       A file to provide Polymake
**                                                  to GAP.
**
*/

#include "loadgap.h"

static const char * Revision_polymake_main_c =
   "polymake_main.cpp, V0.1";

# define MORE_TESTS 1


// This is the include of the polymake headers,
// make shure that you have installed polymake properly

#include <polymake/Main.h>
#include <polymake/Matrix.h>
#include <polymake/Rational.h>

#include <iostream>
#include <map>
#include <utility>

#include "polymake_fktn.h"
#include "polymake_polytopes.h"
#include "polymake_cone.h"
#include "polymake_fan.h"
#include "polymake_tropical.h"

using std::cerr;
using std::endl;
using std::string;
using std::map;
using std::pair;


static Polymake_Data akt_data;

Obj TheTypeExternalPolymakeCone;
Obj TheTypeExternalPolymakeFan;
Obj TheTypeExternalPolymakePolytope;
Obj TheTypeExternalPolymakeTropicalHypersurface;
Obj TheTypeExternalPolymakeTropicalPolytope;

Obj FuncPOLYMAKE_CREATE_CONE_BY_RAYS( Obj self, Obj rays ) {
  
  polymake_start( &akt_data );
  return REAL_CREATE_CONE_BY_RAYS( &akt_data,rays);

}

Obj FuncPOLYMAKE_CREATE_CONE_BY_RAYS_UNSAVE( Obj self, Obj rays ) {
  
  polymake_start( &akt_data );
  return REAL_CREATE_CONE_BY_RAYS_UNSAVE( &akt_data,rays);

}


Obj FuncPOLYMAKE_CREATE_CONE_BY_INEQUALITIES( Obj self, Obj rays ) {
  
  polymake_start( &akt_data );
  return REAL_CREATE_CONE_BY_INEQUALITIES( &akt_data,rays);

}



Obj FuncPOLYMAKE_CREATE_DUAL_CONE_OF_CONE( Obj self, Obj cone ) {
  
  return REAL_CREATE_DUAL_CONE_OF_CONE( &akt_data, cone );

}


Obj FuncPOLYMAKE_IS_NONEMPTY_POLYTOPE( Obj self, Obj cone ){

  //return REAL_IS_SIMPLICIAL_OBJECT( &akt_data, cone );
  return REAL_OBJECT_HAS_PROPERTY( &akt_data, cone, "FEASIBLE" );

}


Obj FuncPOLYMAKE_IS_SIMPLICIAL_OBJECT( Obj self, Obj cone ){

  //return REAL_IS_SIMPLICIAL_OBJECT( &akt_data, cone );
  return REAL_OBJECT_HAS_PROPERTY( &akt_data, cone, "SIMPLICIAL" );

}


Obj FuncPOLYMAKE_IS_SIMPLE_OBJECT( Obj self, Obj cone ){

  //return REAL_IS_SIMPLICIAL_OBJECT( &akt_data, cone );
  return REAL_OBJECT_HAS_PROPERTY( &akt_data, cone, "SIMPLE" );

}


Obj FuncPOLYMAKE_IS_SIMPLICIAL_CONE( Obj self, Obj cone ){

  //return REAL_IS_SIMPLICIAL_OBJECT( &akt_data, cone );
  return REAL_OBJECT_HAS_PROPERTY( &akt_data, cone, "SIMPLICIAL_CONE" );

}



Obj FuncPOLYMAKE_IS_LATTICE_OBJECT( Obj self, Obj cone ) {

  //return REAL_IS_LATTICE_OBJECT( &akt_data, cone );
  return REAL_OBJECT_HAS_PROPERTY( &akt_data, cone, "LATTICE" );

}


Obj FuncPOLYMAKE_IS_NORMAL_OBJECT( Obj self, Obj cone ) {

  //return REAL_IS_NORMAL_OBJECT( &akt_data, cone );
  return REAL_OBJECT_HAS_PROPERTY( &akt_data, cone, "NORMAL" );

}


Obj FuncPOLYMAKE_IS_VERYAMPLE_OBJECT( Obj self, Obj cone ) {

  //return REAL_IS_VERYAMPLE_OBJECT( &akt_data, cone );
  return REAL_OBJECT_HAS_PROPERTY( &akt_data, cone, "VERY_AMPLE" );

}


Obj FuncPOLYMAKE_IS_SMOOTH_OBJECT( Obj self, Obj cone ) {

  //return REAL_IS_SMOOTH_OBJECT( &akt_data, cone );
  return REAL_OBJECT_HAS_PROPERTY( &akt_data, cone, "SMOOTH" );

}



Obj FuncPOLYMAKE_IS_STRICTLY_CONVEX_CONE( Obj self, Obj cone){

  //return REAL_IS_STRICTLY_CONVEX_CONE( &akt_data, cone );
  return REAL_OBJECT_HAS_PROPERTY( &akt_data, cone, "POINTED" );

}


Obj FuncPOLYMAKE_IS_SMOOTH_CONE( Obj self, Obj cone){

  return REAL_OBJECT_HAS_PROPERTY( &akt_data, cone, "SMOOTH_CONE" );

}

Obj FuncPOLYMAKE_GENERATING_RAYS_OF_CONE( Obj self, Obj cone){

  return REAL_GENERATING_RAYS_OF_CONE( &akt_data, cone );

}

Obj FuncPOLYMAKE_CREATE_POLYTOPE_BY_POINTS( Obj self, Obj polytope ){
  
  polymake_start( &akt_data );
  return REAL_CREATE_POLYTOPE_BY_POINTS( &akt_data, polytope );
  
}

Obj FuncPOLYMAKE_VERTICES_OF_POLYTOPE( Obj self, Obj polytope){
  
  return REAL_VERTICES_OF_POLYTOPE( &akt_data, polytope);
  
}

Obj FuncPOLYMAKE_CREATE_POLYTOPE_BY_INEQUALITIES( Obj self, Obj polytope ){
  
  polymake_start( &akt_data );
  return REAL_CREATE_POLYTOPE_BY_INEQUALITIES( &akt_data, polytope );
  
}

Obj FuncPOLYMAKE_AMBIENT_DIM_OF_CONE( Obj self, Obj cone ){
  
  return REAL_OBJECT_HAS_INT_PROPERTY( &akt_data, cone, "CONE_AMBIENT_DIM" );
  
}

Obj FuncPOLYMAKE_DIM_OF_CONE( Obj self, Obj cone ){
  
  return REAL_OBJECT_HAS_INT_PROPERTY( &akt_data, cone, "CONE_DIM" );
  
}

Obj FuncPOLYMAKE_AMBIENT_DIM_OF_FAN( Obj self, Obj fan ){
  
  return REAL_OBJECT_HAS_INT_PROPERTY( &akt_data, fan, "FAN_AMBIENT_DIM" );
  
}

Obj FuncPOLYMAKE_DIM_OF_FAN( Obj self, Obj fan ){
  
  return REAL_OBJECT_HAS_INT_PROPERTY( &akt_data, fan, "FAN_DIM" );
  
}

Obj FuncPOLYMAKE_HILBERT_BASIS_OF_CONE( Obj self, Obj cone ){
  
  return REAL_HILBERT_BASIS_OF_CONE( &akt_data, cone );
  
}

Obj FuncPOLYMAKE_RAYS_IN_FACETS( Obj self, Obj cone ){
  
  return REAL_RAYS_IN_FACETS( &akt_data, cone );
  
}

Obj FuncPOLYMAKE_LATTICE_POINTS_OF_POLYTOPE( Obj self, Obj polytope ){
  
  return REAL_LATTICE_POINTS_OF_POLYTOPE( &akt_data, polytope );
  
}

Obj FuncPOLYMAKE_FAN_BY_CONES( Obj self, Obj cones ){
  
  polymake_start( &akt_data );
  return REAL_FAN_BY_CONES( &akt_data, cones );
  
}

Obj FuncPOLYMAKE_FAN_BY_RAYS_AND_CONES( Obj self, Obj rays, Obj cones ){
  
  polymake_start( &akt_data );
  return REAL_FAN_BY_RAYS_AND_CONES( &akt_data, rays, cones );
  
}

Obj FuncPOLYMAKE_FAN_BY_RAYS_AND_CONES_UNSAVE( Obj self, Obj rays, Obj cones ){
  
  polymake_start( &akt_data );
  return REAL_FAN_BY_RAYS_AND_CONES_UNSAVE( &akt_data, rays, cones );
  
}

Obj FuncPOLYMAKE_RAYS_IN_MAXCONES_OF_FAN( Obj self, Obj fan){
  
  return REAL_RAYS_IN_MAXCONES_OF_FAN( &akt_data, fan );
  
}

Obj FuncPOLYMAKE_RAYS_OF_FAN( Obj self, Obj fan){
  
  return REAL_RAYS_OF_FAN( &akt_data, fan );
  
}

Obj FuncPOLYMAKE_IS_POINTED_FAN( Obj self, Obj fan){
  
  return REAL_OBJECT_HAS_PROPERTY( &akt_data, fan, "POINTED" );
  
}

Obj FuncPOLYMAKE_IS_SMOOTH_FAN( Obj self, Obj fan ){
  
  return REAL_OBJECT_HAS_PROPERTY( &akt_data, fan, "SMOOTH_FAN" );
  
}

Obj FuncPOLYMAKE_IS_COMPLETE_FAN( Obj self, Obj fan ){
  
  return REAL_OBJECT_HAS_PROPERTY( &akt_data, fan, "COMPLETE" );
  
}

Obj FuncPOLYMAKE_OBJECT_HAS_PROPERTY( Obj self, Obj conv, Obj prop){
  
  if( ! IS_STRING( prop ) )
      ErrorMayQuit(" given property is not a string", 0 ,0 );
  
  return REAL_OBJECT_HAS_PROPERTY( &akt_data, conv, CSTR_STRING( prop ) );
  
}

Obj FuncPOLYMAKE_OBJECT_HAS_INT_PROPERTY( Obj self, Obj conv, Obj prop){
  
  if( ! IS_STRING( prop ) )
      ErrorMayQuit(" given property is not a string", 0 ,0 );
  
  return REAL_OBJECT_HAS_INT_PROPERTY( &akt_data, conv, CSTR_STRING( prop ) );
  
}

Obj FuncPOLYMAKE_IS_REGULAR_OBJECT( Obj self, Obj fan ){
  
  return REAL_OBJECT_HAS_PROPERTY( &akt_data, fan, "REGULAR" );
  
}

Obj FuncPOLYMAKE_NORMALFAN_OF_POLYTOPE( Obj self, Obj polytope ){
  
  polymake_start( &akt_data );
  return REAL_NORMALFAN_OF_POLYTOPE( &akt_data, polytope );
  
}

Obj FuncPOLYMAKE_IS_FULL_DIMENSIONAL_OBJECT( Obj self, Obj cone ){
  
  return REAL_OBJECT_HAS_PROPERTY( &akt_data, cone, "FULL_DIM" );
  
}

Obj FuncPOLYMAKE_IS_BOUNDED_POLYTOPE( Obj self, Obj polytope ){
  
  return REAL_OBJECT_HAS_PROPERTY( &akt_data, polytope, "BOUNDED" );
  
}

Obj FuncPOLYMAKE_DRAW( Obj self, Obj cone ){
  
  polymake_start( &akt_data );
  return REAL_POLYMAKE_DRAW( &akt_data, cone );
  
}

Obj FuncPOLYMAKE_SKETCH( Obj self, Obj cone ){
  
  polymake_start( &akt_data );
  return REAL_POLYMAKE_SKETCH( &akt_data, cone );
  
}

Obj FuncPOLYMAKE_SKETCH_WITH_OPTIONS_KERNEL( Obj self, Obj cone, Obj filename, Obj options ){
  
  polymake_start( &akt_data );
  return REAL_POLYMAKE_SKETCH_WITH_OPTIONS( &akt_data, cone, filename, options );
  
}

Obj FuncPOLYMAKE_DEFINING_INEQUALITIES_OF_CONE( Obj self, Obj cone ){
  
  return REAL_DEFINING_INEQUALITIES_OF_CONE( &akt_data, cone );
  
}

Obj FuncPOLYMAKE_FACET_INEQUALITIES_OF_POLYTOPE( Obj self, Obj poly ){
  
  return REAL_FACET_INEQUALITIES_OF_POLYTOPE( &akt_data, poly );
  
}

Obj FuncPOLYMAKE_EQUALITIES_OF_POLYTOPE( Obj self, Obj poly ){
  
  return REAL_EQUALITIES_OF_POLYTOPE( &akt_data, poly );
  
}

Obj FuncPOLYMAKE_INTERIOR_LATTICE_POINTS( Obj self, Obj poly ){
  
  return REAL_INTERIOR_LATTICE_POINTS( &akt_data, poly );
  
}

Obj FuncPOLYMAKE_CREATE_POLYTOPE_BY_HOMOGENEOUS_POINTS( Obj self, Obj points ){
  
  polymake_start( &akt_data );
  return REAL_CREATE_POLYTOPE_BY_HOMOGENEOUS_POINTS( &akt_data, points );
  
}

Obj FuncPOLYMAKE_HOMOGENEOUS_POINTS_OF_POLYTOPE( Obj self, Obj polytope ){
  
  return REAL_HOMOGENEOUS_POINTS_OF_POLYTOPE( &akt_data, polytope );
  
}

Obj FuncPOLYMAKE_TAIL_CONE_OF_POLYTOPE( Obj self, Obj polytope ){
  
  polymake_start( &akt_data );
  return REAL_TAIL_CONE_OF_POLYTOPE( &akt_data, polytope );
  
}

Obj FuncPOLYMAKE_LINEALITY_SPACE_OF_CONE( Obj self, Obj cone ){
  
  return REAL_LINEALITY_SPACE_OF_CONE( &akt_data, cone );
  
}

Obj FuncPOLYMAKE_MINKOWSKI_SUM( Obj self, Obj polytope1, Obj polytope2 ){
  
  return REAL_MINKOWSKI_SUM( &akt_data, polytope1, polytope2 );
  
}

Obj FuncPOLYMAKE_INTERSECTION_OF_CONES( Obj self, Obj cone1, Obj cone2 ){
  
  return REAL_INTERSECTION_OF_CONES( &akt_data, cone1, cone2 );
  
}

Obj FuncPOLYMAKE_CREATE_CONE_BY_EQUALITIES_AND_INEQUALITIES( Obj self, Obj equalities, Obj inequalities ){
  
  polymake_start( &akt_data );
  return REAL_CREATE_CONE_BY_EQUALITIES_AND_INEQUALITIES( &akt_data, equalities, inequalities );
  
}

Obj FuncPOLYMAKE_EQUALITIES_OF_CONE( Obj self, Obj cone ){
  
  return REAL_EQUALITIES_OF_CONE( &akt_data, cone );
  
}

Obj FuncPOLYMAKE_STELLAR_SUBDIVISION( Obj self, Obj ray, Obj fan){
  
  return REAL_STELLAR_SUBDIVISION( &akt_data, ray, fan );
  
}

Obj FuncPOLYMAKE_TROPICAL_HYPERSURFACE_BY_MONOMS_AND_COEFFICIENTS( Obj self, Obj mon, Obj coeff){
  
  polymake_start( &akt_data );
  return REAL_TROPICAL_HYPERSURFACE_BY_MONOMS_AND_COEFFICIENTS( &akt_data, mon, coeff );
  
}

Obj FuncPOLYMAKE_MONOMIALS_OF_HYPERSURFACE( Obj self, Obj surf ){
  
  polymake_start( &akt_data );
  return REAL_MONOMIALS_OF_HYPERSURFACE( &akt_data, surf );
  
}

Obj FuncPOLYMAKE_LATTICE_POINTS_GENERATORS( Obj self, Obj polytope ){
  
  polymake_start( &akt_data );
  return REAL_LATTICE_POINTS_GENERATORS( &akt_data, polytope );
  
}

Obj FuncPOLYMAKE_TROPICAL_POLYTOPE_BY_POINTS( Obj self, Obj points ){
  
  polymake_start( &akt_data );
  return REAL_TROPICAL_POLYTOPE_BY_POINTS( &akt_data, points );
  
}

Obj FuncPOLYMAKE_SET_PROPERTY_TRUE( Obj self, Obj conv, Obj prop){
  
  if( ! IS_STRING( prop ) )
      ErrorMayQuit(" given property is not a string", 0 ,0 );
  
  REAL_SET_PROPERTY_TRUE( &akt_data, conv, CSTR_STRING( prop ) );
  return INTOBJ_INT( 0 );
  
}

Obj FuncPOLYMAKE_RESET_WORKSPACE( Obj self ){
  
  delete akt_data.main_polymake_session;
  akt_data.main_polymake_session = new polymake::Main;
  akt_data.main_polymake_scope = new polymake::perl::Scope(akt_data.main_polymake_session->newScope());
  
  return True;
  
}

/******************************************************************************
*V  GVarFuncs . . . . . . . . . . . . . . . . . . list of functions to export
*/
static StructGVarFunc GVarFuncs [] = {

    { "POLYMAKE_CREATE_CONE_BY_RAYS", 1, "rays",
    (Obj(*)())FuncPOLYMAKE_CREATE_CONE_BY_RAYS,
    "polymake_main.cpp:POLYMAKE_CREATE_CONE_BY_RAYS" },

    { "POLYMAKE_CREATE_CONE_BY_RAYS_UNSAVE", 1, "rays",
    (Obj(*)())FuncPOLYMAKE_CREATE_CONE_BY_RAYS_UNSAVE,
    "polymake_main.cpp:POLYMAKE_CREATE_CONE_BY_RAYS_UNSAVE" },

    { "POLYMAKE_CREATE_CONE_BY_INEQUALITIES", 1, "rays",
    (Obj(*)())FuncPOLYMAKE_CREATE_CONE_BY_INEQUALITIES,
    "polymake_main.cpp:POLYMAKE_CREATE_CONE_BY_INEQUALITIES" },
    
    { "POLYMAKE_CREATE_DUAL_CONE_OF_CONE", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_CREATE_DUAL_CONE_OF_CONE,
    "polymake_main.cpp:POLYMAKE_CREATE_DUAL_CONE_OF_CONE" },
     
    { "POLYMAKE_IS_NONEMPTY_POLYTOPE", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_IS_NONEMPTY_POLYTOPE,
    "polymake_main.cpp:POLYMAKE_IS_NONEMPTY_POLYTOPE" },
     
    { "POLYMAKE_IS_SIMPLICIAL_OBJECT", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_IS_SIMPLICIAL_OBJECT,
    "polymake_main.cpp:POLYMAKE_IS_SIMPLICIAL_OBJECT" },
     
    { "POLYMAKE_IS_SIMPLE_OBJECT", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_IS_SIMPLE_OBJECT,
    "polymake_main.cpp:POLYMAKE_IS_SIMPLE_OBJECT" },
     
    { "POLYMAKE_IS_SIMPLICIAL_CONE", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_IS_SIMPLICIAL_CONE,
    "polymake_main.cpp:POLYMAKE_IS_SIMPLICIAL_CONE" },
    
    { "POLYMAKE_IS_LATTICE_OBJECT", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_IS_LATTICE_OBJECT,
    "polymake_main.cpp:POLYMAKE_IS_LATTICE_OBJECT" },
    
    { "POLYMAKE_IS_NORMAL_OBJECT", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_IS_NORMAL_OBJECT,
    "polymake_main.cpp:POLYMAKE_IS_NORMAL_OBJECT" },
    
    { "POLYMAKE_IS_VERYAMPLE_OBJECT", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_IS_VERYAMPLE_OBJECT,
    "polymake_main.cpp:POLYMAKE_IS_VERYAMPLE_OBJECT" },
    
    { "POLYMAKE_IS_SMOOTH_OBJECT", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_IS_SMOOTH_OBJECT,
    "polymake_main.cpp:POLYMAKE_IS_SMOOTH_OBJECT" },
    
    { "POLYMAKE_IS_STRICTLY_CONVEX_CONE", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_IS_STRICTLY_CONVEX_CONE,
    "polymake_main.cpp:POLYMAKE_IS_STRICTLY_CONVEX_CONE" },
    
    { "POLYMAKE_IS_SMOOTH_CONE", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_IS_SMOOTH_CONE,
    "polymake_main.cpp:POLYMAKE_IS_SMOOTH_CONE" },
    
    { "POLYMAKE_GENERATING_RAYS_OF_CONE", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_GENERATING_RAYS_OF_CONE,
    "polymake_main.cpp:POLYMAKE_GENERATING_RAYS_OF_CONE" },
    
    { "POLYMAKE_CREATE_POLYTOPE_BY_POINTS", 1, "polytope",
    (Obj(*)())FuncPOLYMAKE_CREATE_POLYTOPE_BY_POINTS,
    "polymake_main.cpp:POLYMAKE_CREATE_POLYTOPE_BY_POINTS" },
    
    { "POLYMAKE_VERTICES_OF_POLYTOPE", 1, "polytope",
    (Obj(*)())FuncPOLYMAKE_VERTICES_OF_POLYTOPE,
    "polymake_main.cpp:POLYMAKE_VERTICES_OF_POLYTOPE" },
    
    { "POLYMAKE_CREATE_POLYTOPE_BY_INEQUALITIES", 1, "polytope",
    (Obj(*)())FuncPOLYMAKE_CREATE_POLYTOPE_BY_INEQUALITIES,
    "polymake_main.cpp:POLYMAKE_CREATE_POLYTOPE_BY_INEQUALITIES" },
    
    { "POLYMAKE_AMBIENT_DIM_OF_CONE", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_AMBIENT_DIM_OF_CONE,
    "polymake_main.cpp:POLYMAKE_AMBIENT_DIM_OF_CONE" },
    
    { "POLYMAKE_DIM_OF_CONE", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_DIM_OF_CONE,
    "polymake_main.cpp:POLYMAKE_DIM_OF_CONE" },
    
    { "POLYMAKE_HILBERT_BASIS_OF_CONE", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_HILBERT_BASIS_OF_CONE,
    "polymake_main.cpp:POLYMAKE_HILBERT_BASIS_OF_CONE" },
    
    { "POLYMAKE_RAYS_IN_FACETS", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_RAYS_IN_FACETS,
    "polymake_main.cpp:POLYMAKE_RAYS_IN_FACETS" },
    
    { "POLYMAKE_LATTICE_POINTS_OF_POLYTOPE", 1, "polytope",
    (Obj(*)())FuncPOLYMAKE_LATTICE_POINTS_OF_POLYTOPE,
    "polymake_main.cpp:POLYMAKE_LATTICE_POINTS_OF_POLYTOPE" },
    
    { "POLYMAKE_FAN_BY_CONES", 1, "cones",
    (Obj(*)())FuncPOLYMAKE_FAN_BY_CONES,
    "polymake_main.cpp:POLYMAKE_FAN_BY_CONES" },
    
    { "POLYMAKE_FAN_BY_RAYS_AND_CONES", 2, "rays,cones",
    (Obj(*)())FuncPOLYMAKE_FAN_BY_RAYS_AND_CONES,
    "polymake_main.cpp:POLYMAKE_FAN_BY_RAYS_AND_CONES" },
    
    { "POLYMAKE_FAN_BY_RAYS_AND_CONES_UNSAVE", 2, "rays,cones",
    (Obj(*)())FuncPOLYMAKE_FAN_BY_RAYS_AND_CONES_UNSAVE,
    "polymake_main.cpp:POLYMAKE_FAN_BY_RAYS_AND_CONES_UNSAVE" },
    
    { "POLYMAKE_RAYS_IN_MAXCONES_OF_FAN", 1, "fan",
    (Obj(*)())FuncPOLYMAKE_RAYS_IN_MAXCONES_OF_FAN,
    "polymake_main.cpp:POLYMAKE_RAYS_IN_MAXCONES_OF_FAN" },
    
    { "POLYMAKE_RAYS_OF_FAN", 1, "fan",
    (Obj(*)())FuncPOLYMAKE_RAYS_OF_FAN,
    "polymake_main.cpp:POLYMAKE_RAYS_OF_FAN" },
    
    { "POLYMAKE_IS_POINTED_FAN", 1, "fan",
    (Obj(*)())FuncPOLYMAKE_IS_POINTED_FAN,
    "polymake_main.cpp:POLYMAKE_IS_POINTED_FAN" },
    
    { "POLYMAKE_IS_SMOOTH_FAN", 1, "fan",
    (Obj(*)())FuncPOLYMAKE_IS_SMOOTH_FAN,
    "polymake_main.cpp:POLYMAKE_IS_SMOOTH_FAN" },
    
    { "POLYMAKE_IS_COMPLETE_FAN", 1, "fan",
    (Obj(*)())FuncPOLYMAKE_IS_COMPLETE_FAN,
    "polymake_main.cpp:POLYMAKE_IS_COMPLETE_FAN" },
    
    { "POLYMAKE_OBJECT_HAS_PROPERTY", 2, "conv,prop",
    (Obj(*)())FuncPOLYMAKE_OBJECT_HAS_PROPERTY,
    "polymake_main.cpp:POLYMAKE_OBJECT_HAS_PROPERTY" },
    
    { "POLYMAKE_OBJECT_HAS_INT_PROPERTY", 2, "conv,prop",
    (Obj(*)())FuncPOLYMAKE_OBJECT_HAS_INT_PROPERTY,
    "polymake_main.cpp:POLYMAKE_OBJECT_HAS_INT_PROPERTY" },
    
    { "POLYMAKE_IS_REGULAR_OBJECT", 1, "fan",
    (Obj(*)())FuncPOLYMAKE_IS_REGULAR_OBJECT,
    "polymake_main.cpp:POLYMAKE_IS_REGULAR_OBJECT" },
    
    { "POLYMAKE_NORMALFAN_OF_POLYTOPE", 1, "polytope",
    (Obj(*)())FuncPOLYMAKE_NORMALFAN_OF_POLYTOPE,
    "polymake_main.cpp:POLYMAKE_NORMALFAN_OF_POLYTOPE" },
    
    { "POLYMAKE_AMBIENT_DIM_OF_FAN", 1, "fan",
    (Obj(*)())FuncPOLYMAKE_AMBIENT_DIM_OF_FAN,
    "polymake_main.cpp:POLYMAKE_AMBIENT_DIM_OF_FAN" },
    
    { "POLYMAKE_DIM_OF_FAN", 1, "fan",
    (Obj(*)())FuncPOLYMAKE_DIM_OF_FAN,
    "polymake_main.cpp:POLYMAKE_DIM_OF_FAN" },
    
    { "POLYMAKE_IS_FULL_DIMENSIONAL_OBJECT", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_IS_FULL_DIMENSIONAL_OBJECT,
    "polymake_main.cpp:POLYMAKE_IS_FULL_DIMENSIONAL_OBJECT" },
    
    { "POLYMAKE_DRAW", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_DRAW,
    "polymake_main.cpp:POLYMAKE_DRAW" },
    
    { "POLYMAKE_SKETCH", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_SKETCH,
    "polymake_main.cpp:POLYMAKE_SKETCH" },
    
    { "POLYMAKE_SKETCH_WITH_OPTIONS_KERNEL", 3, "cone,filename,options",
    (Obj(*)())FuncPOLYMAKE_SKETCH_WITH_OPTIONS_KERNEL,
    "polymake_main.cpp:POLYMAKE_SKETCH_WITH_OPTIONS_KERNEL" },
    
    { "POLYMAKE_DEFINING_INEQUALITIES_OF_CONE", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_DEFINING_INEQUALITIES_OF_CONE,
    "polymake_main.cpp:POLYMAKE_DEFINING_INEQUALITIES_OF_CONE" },
    
    { "POLYMAKE_RESET_WORKSPACE", 0, "",
    (Obj(*)())FuncPOLYMAKE_RESET_WORKSPACE,
    "polymake_main.cpp:POLYMAKE_RESET_WORKSPACE" },
    
    { "POLYMAKE_FACET_INEQUALITIES_OF_POLYTOPE", 1, "poly",
    (Obj(*)())FuncPOLYMAKE_FACET_INEQUALITIES_OF_POLYTOPE,
    "polymake_main.cpp:POLYMAKE_FACET_INEQUALITIES_OF_POLYTOPE" },
    
    { "POLYMAKE_EQUALITIES_OF_POLYTOPE", 1, "poly",
    (Obj(*)())FuncPOLYMAKE_EQUALITIES_OF_POLYTOPE,
    "polymake_main.cpp:POLYMAKE_EQUALITIES_OF_POLYTOPE" },
    
    { "POLYMAKE_INTERIOR_LATTICE_POINTS", 1, "poly",
    (Obj(*)())FuncPOLYMAKE_INTERIOR_LATTICE_POINTS,
    "polymake_main.cpp:POLYMAKE_INTERIOR_LATTICE_POINTS" },
    
    { "POLYMAKE_IS_BOUNDED_POLYTOPE", 1, "polytope",
    (Obj(*)())FuncPOLYMAKE_IS_BOUNDED_POLYTOPE,
    "polymake_main.cpp:POLYMAKE_IS_BOUNDED_POLYTOPE" },
    
    { "POLYMAKE_CREATE_POLYTOPE_BY_HOMOGENEOUS_POINTS", 1, "points",
    (Obj(*)())FuncPOLYMAKE_CREATE_POLYTOPE_BY_HOMOGENEOUS_POINTS,
    "polymake_main.cpp:POLYMAKE_CREATE_POLYTOPE_BY_HOMOGENEOUS_POINTS" },
    
    { "POLYMAKE_HOMOGENEOUS_POINTS_OF_POLYTOPE", 1, "polytope",
    (Obj(*)())FuncPOLYMAKE_HOMOGENEOUS_POINTS_OF_POLYTOPE,
    "polymake_main.cpp:POLYMAKE_HOMOGENEOUS_POINTS_OF_POLYTOPE" },
    
    { "POLYMAKE_TAIL_CONE_OF_POLYTOPE", 1, "polytope",
    (Obj(*)())FuncPOLYMAKE_TAIL_CONE_OF_POLYTOPE,
    "polymake_main.cpp:POLYMAKE_TAIL_CONE_OF_POLYTOPE" },
    
    { "POLYMAKE_MINKOWSKI_SUM", 2, "polytope1,polytope2",
    (Obj(*)())FuncPOLYMAKE_MINKOWSKI_SUM,
    "polymake_main.cpp:POLYMAKE_MINKOWSKI_SUM" },
    
    { "POLYMAKE_LINEALITY_SPACE_OF_CONE", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_LINEALITY_SPACE_OF_CONE,
    "polymake_main.cpp:POLYMAKE_LINEALITY_SPACE_OF_CONE" },
    
    { "POLYMAKE_EQUALITIES_OF_CONE", 1, "cone",
    (Obj(*)())FuncPOLYMAKE_EQUALITIES_OF_CONE,
    "polymake_main.cpp:POLYMAKE_EQUALITIES_OF_CONE" },
    
    { "POLYMAKE_STELLAR_SUBDIVISION", 2, "ray,fan",
    (Obj(*)())FuncPOLYMAKE_STELLAR_SUBDIVISION,
    "polymake_main.cpp:STELLAR_SUBDIVSION" },
    
    { "POLYMAKE_SET_PROPERTY_TRUE", 2, "conv,prop",
    (Obj(*)())FuncPOLYMAKE_SET_PROPERTY_TRUE,
    "polymake_main.cpp:POLYMAKE_SET_PROPERTY_TRUE" },
    
    { "POLYMAKE_CREATE_CONE_BY_EQUALITIES_AND_INEQUALITIES", 2, "equalities,inequalities",
    (Obj(*)())FuncPOLYMAKE_CREATE_CONE_BY_EQUALITIES_AND_INEQUALITIES,
    "polymake_main.cpp:POLYMAKE_CREATE_CONE_BY_EQUALITIES_AND_INEQUALITIES" },
    
    { "POLYMAKE_INTERSECTION_OF_CONES", 2, "cone1,cone2",
    (Obj(*)())FuncPOLYMAKE_INTERSECTION_OF_CONES,
    "polymake_main.cpp:POLYMAKE_INTERSECTION_OF_CONES" },
    
    { "POLYMAKE_TROPICAL_HYPERSURFACE_BY_MONOMS_AND_COEFFICIENTS", 2, "mon,coeff",
    (Obj(*)())FuncPOLYMAKE_TROPICAL_HYPERSURFACE_BY_MONOMS_AND_COEFFICIENTS,
    "polymake_main.cpp:POLYMAKE_TROPICAL_HYPERSURFACE_BY_MONOMS_AND_COEFFICIENTS" },
    
    { "POLYMAKE_MONOMIALS_OF_HYPERSURFACE", 1, "surf",
    (Obj(*)())FuncPOLYMAKE_MONOMIALS_OF_HYPERSURFACE,
    "polymake_main.cpp:POLYMAKE_MONOMIALS_OF_HYPERSURFACE" },
    
    { "POLYMAKE_LATTICE_POINTS_GENERATORS", 1, "polytope",
    (Obj(*)())FuncPOLYMAKE_LATTICE_POINTS_GENERATORS,
    "polymake_main.cpp:POLYMAKE_LATTICE_POINTS_GENERATORS" },
    
    { "POLYMAKE_TROPICAL_POLYTOPE_BY_POINTS", 1, "points",
    (Obj(*)())FuncPOLYMAKE_TROPICAL_POLYTOPE_BY_POINTS,
    "polymake_main.cpp:POLYMAKE_TROPICAL_POLYTOPE_BY_POINTS" },
    
  { 0 }
};

/******************************************************************************
*F  InitKernel( <module> )  . . . . . . . . initialise kernel data structures
*/
static Int InitKernel ( StructInitInfo *module )
{
    /* init filters and functions                                          */
    InitHdlrFuncsFromTable( GVarFuncs );
    

    InitCopyGVar( "TheTypeExternalPolymakeCone", &TheTypeExternalPolymakeCone );
    InitCopyGVar( "TheTypeExternalPolymakeFan", &TheTypeExternalPolymakeFan );
    InitCopyGVar( "TheTypeExternalPolymakePolytope", &TheTypeExternalPolymakePolytope );
    InitCopyGVar( "TheTypeExternalPolymakeTropicalHypersurface", &TheTypeExternalPolymakeTropicalHypersurface );
    InitCopyGVar( "TheTypeExternalPolymakeTropicalPolytope", &TheTypeExternalPolymakeTropicalPolytope );

    InfoBags[T_POLYMAKE].name = "ExternalPolymakeObject";
    InitMarkFuncBags(T_POLYMAKE, &MarkOneSubBags);
    InitFreeFuncBag(T_POLYMAKE, &ExternalPolymakeObjectFreeFunc);
    TypeObjFuncs[T_POLYMAKE] = &ExternalPolymakeObjectTypeFunc;


    /* return success                                                      */
    return 0;
}

/******************************************************************************
*F  InitLibrary( <module> ) . . . . . . .  initialise library data structures
*/
static Int InitLibrary ( StructInitInfo *module )
{
    Int i, gvar;
    
    // We start with initialising the polymake classes.
    akt_data.initialized = false;
//     akt_data.main_polymake_session = new polymake::Main;
//     akt_data.main_polymake_scope = new polymake::perl::Scope(akt_data.main_polymake_session->newScope());
//     akt_data.main_polymake_session->set_application("polytope");
//     akt_data.main_polymake_session->set_custom("$Verbose::scheduler",1);
    //This is pretty slow.
    //akt_data.polymake_objects = new map<int, pm::perl::Object*>;
    //akt_data.new_polymake_object_number=0;
    // We now have everything to handle polymake, lets do the gapthings

    /* init filters and functions
       we assign the functions to components of a record "IO"         */
    for ( i = 0; GVarFuncs[i].name != 0;  i++ ) {
      gvar = GVarName(GVarFuncs[i].name);
      AssGVar(gvar,NewFunctionC( GVarFuncs[i].name, GVarFuncs[i].nargs,
                                 GVarFuncs[i].args, GVarFuncs[i].handler ));
      MakeReadOnlyGVar(gvar);
    }

    /* return success                                                      */
    return 0;
}

/******************************************************************************
*F  InitInfopl()  . . . . . . . . . . . . . . . . . table of init functions
*/
static StructInitInfo module = {
 /* type        = */ MODULE_DYNAMIC,
 /* name        = */ "polymake_main",
 /* revision_c  = */ 0,
 /* revision_h  = */ 0,
 /* version     = */ 0,
 /* crc         = */ 0,
 /* initKernel  = */ InitKernel,
 /* initLibrary = */ InitLibrary,
 /* checkInit   = */ 0,
 /* preSave     = */ 0,
 /* postSave    = */ 0,
 /* postRestore = */ 0
};

extern "C" {

StructInitInfo * Init__Dynamic ( void )
{
  module.revision_c = Revision_polymake_main_c;
  return &module;
}

}


/*
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; version 2 of the License.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 */
