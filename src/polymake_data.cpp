#include "polymake_data.h"

extern Obj TheTypeExternalPolymakeCone;
extern Obj TheTypeExternalPolymakeFan;
extern Obj TheTypeExternalPolymakePolytope;
extern Obj TheTypeExternalPolymakeTropicalHypersurface;

Obj NewPolymakeExternalObject(enum polymake_object_type t) {
  Obj o;
  o = NewBag(T_POLYMAKE, 2*sizeof(Obj));
 
  switch(t) {
    case T_POLYMAKE_EXTERNAL_CONE:
      ADDR_OBJ(o)[0] = TheTypeExternalPolymakeCone;
      break;
    case T_POLYMAKE_EXTERNAL_FAN:
      ADDR_OBJ(o)[0] = TheTypeExternalPolymakeFan;
      break;
    case T_POLYMAKE_EXTERNAL_POLYTOPE:
      ADDR_OBJ(o)[0] = TheTypeExternalPolymakePolytope;
      break;
    case T_POLYMAKE_EXTERNAL_TROPICAL_HYPERSURFACE:
      ADDR_OBJ(o)[0] = TheTypeExternalPolymakeTropicalHypersurface;
      break;
  }
  ADDR_OBJ(o)[1] = NULL;
  return o;
}

/* Free function */
void ExternalPolymakeObjectFreeFunc(Obj o) {
  perlobj* p = PERLOBJ_POLYMAKEOBJ(o);
  if(p != NULL)
    delete p;
}

/* Type object function for the polymake object */
Obj ExternalPolymakeObjectTypeFunc(Obj o) {
  return ADDR_OBJ(o)[0];
}

void polymake_start( Polymake_Data* data ){
    if( ! data->initialized ){
      data->main_polymake_session = new polymake::Main;
      data->main_polymake_scope = new polymake::perl::Scope(data->main_polymake_session->newScope());
      data->initialized = true;
    }
    return;
}
