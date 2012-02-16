extern Obj TheTypeExternalPolymakeCone;
extern Obj TheTypeExternalPolymakeFan;
extern Obj TheTypeExternalPolymakePolytope;

Obj NewPolymakeExternalObject(enum polymake_object_type t) {
  Obj o;
  o = NewBag(T_POLYMAKE, 2*sizeof(Obj));
 
  switch(t) {
    case T_POLYMAKE_EXTERNAL_CONE:
      ADDR_OBJ(o)[0] = &TheTypeExternalPolymakeCone;
      break;
    case T_POLYMAKE_EXTERNAL_FAN:
      ADDR_OBJ(o)[0] = &TheTypeExternalPolymakeFan;
      break;
    case T_POLYMAKE_EXTERNAL_POLYTOPE:
      ADDR_OBJ(o)[0] = &TheTypeExternalPolymakePolytope;
      break;
  }
  ADDR_OBJ(o)[1] = NULL;
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
