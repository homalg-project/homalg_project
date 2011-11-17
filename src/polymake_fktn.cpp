#include "polymake_fktn.h"



Obj REAL_CREATE_CONE_BY_RAYS( Polymake_Data* data, Obj rays ){
  
  if( ! IS_PLIST( rays ) ){
    ErrorMayQuit( "not a plain list", 0, 0);
    return NULL;
  }
  
  int len = LEN_PLIST( rays );
  Obj akt = ELM_PLIST( rays, 1 );
  Obj elem;
  
#ifdef MORE_TESTS
  if( !IS_PLIST( akt ) ){
    ErrorMayQuit( "not a plain list", 0, 0);
    return NULL;
  }
#endif

  int len_elem = LEN_PLIST( akt );
  data->main_polymake_session->set_application("polytope");
  
  pm::Rational ratarray[(len+1)*(len_elem+1)];
  
  for(int i=1;i<=len;i++){
      akt = ELM_PLIST( rays, i );
#ifdef MORE_TESTS
      if( !IS_PLIST( akt ) ){
        ErrorMayQuit( "not a plain list", 0, 0);
        return NULL;
      }
      if( LEN_PLIST( akt ) != len_elem ){
        ErrorMayQuit( "raygenerators are not of the same lenght", 0, 0);
        return NULL;
      }
#endif
      ratarray[(i-1)*(len_elem+1)] = 0;
      for(int j = 1; j <= len_elem; j++){
        elem = ELM_PLIST( akt, j);
#ifdef MORE_TESTS
        if( ! IS_INTOBJ( elem) ){
          ErrorMayQuit( "some entries are not integers", 0, 0);
          return NULL;
        }
#endif
        ratarray[(i-1)*(len_elem+1)+j] = INT_INTOBJ( elem );
      }
      
  }
  //Adding the Basepoint
  ratarray[len*(len_elem+1)] = 1;
  for(int i=1;i<=len_elem;i++){
    ratarray[len*(len_elem+1)+i]=0;
  }
  pm::Matrix<pm::Rational>* matr = new pm::Matrix<pm::Rational>(len+1,len_elem+1,ratarray);
  perlobj* p = new perlobj("Polytope<Rational>"); //Maybe Name the Polytope by the Number
  p->take("POINTS") << *matr; // This Matrix creates a memory leak, aks Thomas!
  //this needs to be fixed!!
  data->polymake_objects->insert( object_pair(data->new_polymake_object_number, p ) );
  elem = INTOBJ_INT( data->new_polymake_object_number );
  data->new_polymake_object_number++;
  return elem;
}



Obj REAL_CREATE_DUAL_CONE_OF_CONE(  Polymake_Data* data, Obj cone ){
  
  #ifdef MORE_TESTS
  if(! IS_INTOBJ(cone) ){
    ErrorMayQuit(" parameter is not an integer.",0,0);
    return NULL;
  }
#endif
  
  int conenumber = INT_INTOBJ( cone );
  iterator TestIt = data->polymake_objects->find(conenumber);
  perlobj* coneobj = (*TestIt).second;
  
#ifdef MORE_TESTS
  if( TestIt == data->polymake_objects->end()){
    ErrorMayQuit(" cone does not exist.",0,0);
    return NULL;
  }
#endif
  
  data->main_polymake_session->set_application_of(*coneobj);
  pm::Matrix<pm::Rational> matr = coneobj->give("FACETS");
  perlobj* p = new perlobj("Polytope<Rational>"); //Maybe Name the Polytope by the Number
  p->take("POINTS") << matr;
  pm::Matrix<pm::Rational> matr2 = coneobj->give("AFFINE_HULL");
  p->take("POINTS") << matr2;
  data->polymake_objects->insert( object_pair(data->new_polymake_object_number, p ) );
  Obj elem = INTOBJ_INT( data->new_polymake_object_number );
  data->new_polymake_object_number++;
  return elem;
  
}



Obj REAL_IS_SIMPLICIAL_CONE( Polymake_Data* data, Obj cone ){

#ifdef MORE_TESTS
  if(! IS_INTOBJ(cone) ){
    ErrorMayQuit(" parameter is not an integer.",0,0);
    return NULL;
  }
#endif

  int conenumber = INT_INTOBJ( cone );
  iterator MapIt = data->polymake_objects->find(conenumber);
  perlobj* coneobj = (*MapIt).second;
  data->main_polymake_session->set_application_of(*coneobj);

#ifdef MORE_TESTS
  if( MapIt == data->polymake_objects->end()){
    ErrorMayQuit(" cone does not exist.",0,0);
    return NULL;
  }
#endif

  bool i;
  coneobj->give("SIMPLICIAL") >> i;
  if(i) return True; return False;

}



Obj REAL_IS_LATTICE_CONE( Polymake_Data* data, Obj cone ){

#ifdef MORE_TESTS
  if(! IS_INTOBJ(cone) ){
    ErrorMayQuit(" parameter is not an integer.",0,0);
    return NULL;
  }
#endif

  int conenumber = INT_INTOBJ( cone );
  iterator MapIt = data->polymake_objects->find(conenumber);
  perlobj* coneobj = (*MapIt).second;
  data->main_polymake_session->set_application_of(*coneobj);

#ifdef MORE_TESTS
  if( MapIt == data->polymake_objects->end()){
    ErrorMayQuit(" cone does not exist.",0,0);
    return NULL;
  }
#endif

  bool i;
  coneobj->give("LATTICE") >> i;
  if(i) return True; return False;

}



Obj REAL_IS_STRICTLY_CONVEX_CONE( Polymake_Data* data, Obj cone){

#ifdef MORE_TESTS
  if(! IS_INTOBJ(cone) ){
    ErrorMayQuit(" parameter is not an integer.",0,0);
    return NULL;
  }
#endif

  int conenumber = INT_INTOBJ( cone );
  iterator MapIt = data->polymake_objects->find(conenumber);
  perlobj* coneobj = (*MapIt).second;
  data->main_polymake_session->set_application_of(*coneobj);

#ifdef MORE_TESTS
  if( MapIt == data->polymake_objects->end()){
    ErrorMayQuit(" cone does not exist.",0,0);
    return NULL;
  }
#endif

  pm::Matrix<pm::Rational> matr = coneobj->give("VERTICES");
  int len = matr.cols();
  pm::Rational ratarray[len];
  ratarray[0] = 1;
  for(int i=1;i<len;i++){
    ratarray[i]=0;
  }
  pm::Matrix<pm::Rational>* matr2 = new pm::Matrix<pm::Rational>(1,len,ratarray);
  perlobj* eins = new perlobj("Polytope<Rational>");
  eins->take("VERTICES") << *matr2;
  perlobj zwei = CallPolymakeFunction("scale",*coneobj,-1);
  perlobj drei = CallPolymakeFunction("intersection",*coneobj, zwei);
  bool tester = CallPolymakeFunction("equal_polyhedra",*eins,drei);
  if( tester ) return True; return False;

}



Obj REAL_GENERATING_RAYS_OF_CONE( Polymake_Data* data, Obj cone){

#ifdef MORE_TESTS
  if(! IS_INTOBJ(cone) ){
    ErrorMayQuit(" parameter is not an integer.",0,0);
    return NULL;
  }
#endif
  
  int conenumber = INT_INTOBJ( cone );
  iterator MapIt = data->polymake_objects->find(conenumber);
  perlobj* coneobj = (*MapIt).second;
  data->main_polymake_session->set_application_of(*coneobj);
  
#ifdef MORE_TESTS
  if( MapIt == data->polymake_objects->end()){
    ErrorMayQuit(" cone does not exist.",0,0);
    return NULL;
  }
#endif

  pm::Matrix<pm::Rational> matr = coneobj->give("VERTICES");
  Obj RETLI = NEW_PLIST( T_PLIST , matr.rows()-1);
  SET_LEN_PLIST( RETLI , matr.rows() -1 );
  Obj LIZeil;
  int helper = 0;
  for(int i = 0;i<matr.rows();i++){
    LIZeil = NEW_PLIST( T_PLIST, matr.cols()-1);
    SET_LEN_PLIST( LIZeil , matr.cols() -1 );
    if(! (matr(i,0) == 1)){
      for(int j = 1;j<matr.cols();j++){
        SET_ELM_PLIST(LIZeil,j,INTOBJ_INT(matr(i,j)*100));
      }
      SET_ELM_PLIST(RETLI,i+1-helper,LIZeil);
    }else{
      helper = 1;
    }
  }
  return RETLI;
  
}