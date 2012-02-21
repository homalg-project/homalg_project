#include "polymake_polytopes.h"


Obj REAL_CREATE_POLYTOPE_BY_POINTS( Polymake_Data* data, Obj polytope ){
  
#ifdef MORE_TESTS
  if( ! IS_PLIST( polytope ) ){
    ErrorMayQuit( "not a plain list", 0, 0);
    return NULL;
  }
#endif
  
  int len = LEN_PLIST( polytope );
  Obj akt = ELM_PLIST( polytope, 1 );
  Obj elem;
  
#ifdef MORE_TESTS
  if( !IS_PLIST( akt ) ){
    ErrorMayQuit( "not a plain list", 0, 0);
    return NULL;
  }
#endif

  int len_elem = LEN_PLIST( akt );
  data->main_polymake_session->set_application("polytope");
  
  pm::Rational* ratarray;
  ratarray = new pm::Rational[(len)*(len_elem+1)];
  
  for(int i=1;i<=len;i++){
      akt = ELM_PLIST( polytope, i );
#ifdef MORE_TESTS
      if( !IS_PLIST( akt ) ){
        delete [] ratarray;
        ErrorMayQuit( "not a plain list", 0, 0);
        return NULL;
      }
      if( LEN_PLIST( akt ) != len_elem ){
        delete [] ratarray;
        ErrorMayQuit( "raygenerators are not of the same lenght", 0, 0);
        return NULL;
      }
#endif
      
      ratarray[(i-1)*(len_elem+1)] = 1;
      for(int j = 1; j <= len_elem; j++){
        elem = ELM_PLIST( akt, j);
        
#ifdef MORE_TESTS
        if( ! IS_INTOBJ( elem ) ){
          delete [] ratarray;
          ErrorMayQuit( "some entries are not integers", 0, 0);
          return NULL;
        }
#endif
        
        ratarray[(i-1)*(len_elem+1)+j] = INT_INTOBJ( elem );
      }
      
  }

  pm::Matrix<pm::Rational>* matr = new pm::Matrix<pm::Rational>(len,len_elem+1,ratarray);
  delete [] ratarray;
  perlobj* p = new perlobj("LatticePolytope");
  p->take("POINTS") << *matr;
  delete matr;
  elem = NewPolymakeExternalObject( T_POLYMAKE_EXTERNAL_POLYTOPE );
  POLYMAKEOBJ_SET_PERLOBJ( elem, p );
  return elem;
}



Obj REAL_VERTICES_OF_POLYTOPE( Polymake_Data* data, Obj polytope){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_POLYTOPE(polytope) ){
    ErrorMayQuit(" parameter is not a polytope.",0,0);
    return NULL;
  }
#endif

  perlobj* polyobj = PERLOBJ_POLYMAKEOBJ( polytope );
  data->main_polymake_session->set_application_of(*polyobj);
  
  pm::Matrix<pm::Rational> matr = polyobj->give("VERTICES");
  Obj RETLI = NEW_PLIST( T_PLIST , matr.rows());
  SET_LEN_PLIST( RETLI , matr.rows() );
  Obj LIZeil;
  for(int i = 0;i<matr.rows();i++){
    LIZeil = NEW_PLIST( T_PLIST, matr.cols()-1);
    SET_LEN_PLIST( LIZeil , matr.cols() -1 );
    for(int j = 1;j<matr.cols();j++){
      SET_ELM_PLIST(LIZeil,j,INTOBJ_INT(matr(i,j)));
    }
    SET_ELM_PLIST(RETLI,i+1,LIZeil);
  }
  return RETLI;
  
}



Obj REAL_LATTICE_POINTS_OF_POLYTOPE( Polymake_Data* data, Obj polytope){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_POLYTOPE(polytope) ){
    ErrorMayQuit(" parameter is not a polytope.",0,0);
    return NULL;
  }
#endif

  perlobj* polyobj = PERLOBJ_POLYMAKEOBJ( polytope );
  data->main_polymake_session->set_application_of(*polyobj);
  
  pm::Matrix<pm::Rational> matr = polyobj->give("LATTICE_POINTS");
  Obj RETLI = NEW_PLIST( T_PLIST , matr.rows());
  SET_LEN_PLIST( RETLI , matr.rows() );
  Obj LIZeil;
  for(int i = 0;i<matr.rows();i++){
    LIZeil = NEW_PLIST( T_PLIST, matr.cols()-1);
    SET_LEN_PLIST( LIZeil , matr.cols() -1 );
    for(int j = 1;j<matr.cols();j++){
      SET_ELM_PLIST(LIZeil,j,INTOBJ_INT(matr(i,j)));
    }
    SET_ELM_PLIST(RETLI,i+1,LIZeil);
  }
  return RETLI;
  
}



Obj REAL_CREATE_POLYTOPE_BY_INEQUALITIES( Polymake_Data* data, Obj polytope){
  
#ifdef MORE_TESTS
  if( ! IS_PLIST( polytope ) ){
    ErrorMayQuit( "not a plain list", 0, 0);
    return NULL;
  }
#endif
  
  int len = LEN_PLIST( polytope );
  Obj akt = ELM_PLIST( polytope, 1 );
  Obj elem;
  
#ifdef MORE_TESTS
  if( !IS_PLIST( akt ) ){
    ErrorMayQuit( "not a plain list", 0, 0);
    return NULL;
  }
#endif

  int len_elem = LEN_PLIST( akt );
  data->main_polymake_session->set_application("polytope");
  
  pm::Rational* ratarray;
  ratarray = new pm::Rational[(len)*(len_elem)];
  
  for(int i=0;i<len;i++){
      akt = ELM_PLIST( polytope, i+1 );
#ifdef MORE_TESTS
      if( !IS_PLIST( akt ) ){
        delete [] ratarray;
        ErrorMayQuit( "not a plain list", 0, 0);
        return NULL;
      }
      if( LEN_PLIST( akt ) != len_elem ){
        delete [] ratarray;
        ErrorMayQuit( "raygenerators are not of the same lenght", 0, 0);
        return NULL;
      }
#endif
      for(int j = 0; j < len_elem; j++){
        elem = ELM_PLIST( akt, j+1);
#ifdef MORE_TESTS
        if( ! IS_INTOBJ( elem ) ){
          delete [] ratarray;
          ErrorMayQuit( "some entries are not integers", 0, 0);
          return NULL;
        }
#endif
        ratarray[i*(len_elem)+j] = INT_INTOBJ( elem );
      }
      
  }

  pm::Matrix<pm::Rational>* matr = new pm::Matrix<pm::Rational>(len,len_elem,ratarray);
  delete [] ratarray;
  perlobj* p = new perlobj("LatticePolytope"); //Maybe Name the Polytope by the Number
  p->take("INEQUALITIES") << *matr;
  delete matr;
  elem = NewPolymakeExternalObject( T_POLYMAKE_EXTERNAL_POLYTOPE );
  POLYMAKEOBJ_SET_PERLOBJ( elem, p );
  return elem;
}



Obj REAL_FACET_INEQUALITIES_OF_POLYTOPE( Polymake_Data* data, Obj polytope){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_POLYTOPE(polytope) ){
    ErrorMayQuit(" parameter is not a polytope.",0,0);
    return NULL;
  }
#endif

  perlobj* polyobj = PERLOBJ_POLYMAKEOBJ( polytope );
  data->main_polymake_session->set_application_of(*polyobj);
  
  pm::Matrix<pm::Rational> matr = polyobj->give("FACETS");
  Obj RETLI = NEW_PLIST( T_PLIST , matr.rows());
  SET_LEN_PLIST( RETLI , matr.rows() );
  Obj LIZeil;
  for(int i = 0;i<matr.rows();i++){
    LIZeil = NEW_PLIST( T_PLIST, matr.cols() );
    SET_LEN_PLIST( LIZeil , matr.cols() );
    for(int j = 0;j<matr.cols();j++){
      SET_ELM_PLIST(LIZeil,j+1,INTOBJ_INT(matr(i,j)));
    }
    SET_ELM_PLIST(RETLI,i+1,LIZeil);
  }
  return RETLI;
  
}


Obj REAL_INTERIOR_LATTICE_POINTS( Polymake_Data* data, Obj polytope){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_POLYTOPE(polytope) ){
    ErrorMayQuit(" parameter is not a polytope.",0,0);
    return NULL;
  }
#endif

  perlobj* polyobj = PERLOBJ_POLYMAKEOBJ( polytope );
  data->main_polymake_session->set_application_of(*polyobj);
  
  pm::Matrix<pm::Rational> matr = polyobj->give("INTERIOR_LATTICE_POINTS");
  Obj RETLI = NEW_PLIST( T_PLIST , matr.rows());
  SET_LEN_PLIST( RETLI , matr.rows() );
  Obj LIZeil;
  for(int i = 0;i<matr.rows();i++){
    LIZeil = NEW_PLIST( T_PLIST, matr.cols()-1);
    SET_LEN_PLIST( LIZeil , matr.cols() -1 );
    for(int j = 1;j<matr.cols();j++){
      SET_ELM_PLIST(LIZeil,j,INTOBJ_INT(matr(i,j)));
    }
    SET_ELM_PLIST(RETLI,i+1,LIZeil);
  }
  return RETLI;
  
}
