#include "polymake_tropical.h"


Obj REAL_TROPICAL_HYPERSURFACE_BY_MONOMS_AND_COEFFICIENTS( Polymake_Data* data, Obj monomials, Obj coefficients ){

#ifdef MORE_TESTS
  if( ! IS_PLIST( monomials ) ){
    ErrorMayQuit( "not a plain list", 0, 0);
    return NULL;
  }
#endif
  
  int len = LEN_PLIST( monomials );
  Obj akt = ELM_PLIST( monomials, 1 );
  Obj elem;
  
#ifdef MORE_TESTS
  if( !IS_PLIST( akt ) ){
    ErrorMayQuit( "not a plain list", 0, 0);
    return NULL;
  }
#endif
  
#ifdef MORE_TESTS
  if( !IS_PLIST( coefficients ) ){
     ErrorMayQuit( "coefficients not a plain list", 0, 0);
    return NULL;
  }
#endif


  int len_elem = LEN_PLIST( akt );
  data->main_polymake_session->set_application("tropical");

  polymake::Matrix<int> matr(len, len_elem);
  polymake::Vector<int> coeff(len);

  for(int i=1;i<=len;i++){
      akt = ELM_PLIST( monomials, i );
#ifdef MORE_TESTS
      if( !IS_PLIST( akt ) ){
        ErrorMayQuit( "not a plain list", 0, 0);
        return NULL;
      }
      if( LEN_PLIST( akt ) != len_elem ){
        ErrorMayQuit( "monomials are not of the same lenght", 0, 0);
        return NULL;
      }
#endif

      for(int j = 1; j <= len_elem; j++){
        elem = ELM_PLIST( akt, j);

#ifdef MORE_TESTS
        if( ! IS_INTOBJ( elem ) ){
          ErrorMayQuit( "some entries are not integers", 0, 0);
          return NULL;
        }
#endif

        matr(i-1,j-1) = INT_INTOBJ( elem );
      }

      elem = ELM_PLIST( coefficients, i );

#ifdef MORE_TESTS
        if( ! IS_INTOBJ( elem ) ){
          ErrorMayQuit( "some entries are not integers", 0, 0);
          return NULL;
        }
#endif

      coeff[ i - 1 ] = INT_INTOBJ( elem );
  }

  perlobj* p = new perlobj("TropicalHypersurface");
  p->take("MONOMIALS") << matr;
  p->take("COEFFICIENTS") << coeff;
  elem = NewPolymakeExternalObject( T_POLYMAKE_EXTERNAL_TROPICAL_HYPERSURFACE );
  POLYMAKEOBJ_SET_PERLOBJ( elem, p );
  return elem;
}


Obj REAL_MONOMIALS_OF_HYPERSURFACE( Polymake_Data* data, Obj hypersurf){

#ifdef MORE_TESTS
  if(! IS_POLYMAKE_TROPICAL_HYPERSURFACE(hypersurf) ){
    ErrorMayQuit(" parameter is not a hypersurface.",0,0);
    return NULL;
  }
#endif

  perlobj* polyobj = PERLOBJ_POLYMAKEOBJ( hypersurf );
  data->main_polymake_session->set_application_of(*polyobj);
  polymake::Matrix<int> matr;
  try{
    polyobj->give("MONOMIALS") >> matr;
  }
  
  POLYMAKE_GAP_CATCH
  
  UInt l = 10;
  Obj RETLI = NEW_PLIST( T_PLIST , l );
  SET_LEN_PLIST(RETLI, l );
  UInt k = 0;
  Obj LIZeil;
  UInt matr_cols = matr.cols();
  for(int i = 0;i<matr.rows();i++){
      if( ++k > l){
        GROW_PLIST(RETLI,l*=2);
        SET_LEN_PLIST(RETLI, l );
      }
      LIZeil = NEW_PLIST( T_PLIST, matr.cols());
      SET_LEN_PLIST( LIZeil , matr_cols );
      for(int j = 0;j<matr.cols();j++){
        SET_ELM_PLIST(LIZeil,j+1,INTOBJ_INT(matr(i,j)));
      }
      SET_ELM_PLIST(RETLI,k,LIZeil);
      CHANGED_BAG(RETLI);
  }
  SHRINK_PLIST(RETLI,k);
  SET_LEN_PLIST(RETLI, k );
  return RETLI;
  
}

Obj REAL_TROPICAL_POLYTOPE_BY_POINTS( Polymake_Data* data, Obj points ){
    if( ! IS_PLIST( points ) ){
    ErrorMayQuit( "not a plain list", 0, 0);
    return NULL;
  }
  
  int len = LEN_PLIST( points );
  Obj akt = ELM_PLIST( points, 1 );
  Obj elem;
  
#ifdef MORE_TESTS
  if( !IS_PLIST( akt ) ){
    ErrorMayQuit( "first ray is not a plain list", 0, 0);
    return NULL;
  }
#endif

  int len_elem = LEN_PLIST( akt );
  data->main_polymake_session->set_application("tropical");

  polymake::Matrix<polymake::Rational> matr(len,len_elem);

  for(int i=0;i<len;i++){
      akt = ELM_PLIST( points, i+1 );
#ifdef MORE_TESTS
      if( !IS_PLIST( akt ) ){
        ErrorMayQuit( "one point is not a plain list", 0, 0);
        return NULL;
      }
      if( LEN_PLIST( akt ) != len_elem ){
        ErrorMayQuit( "points are not of the same lenght", 0, 0);
        return NULL;
      }
#endif
      for(int j = 0; j < len_elem; j++){
        elem = ELM_PLIST( akt, j+1);
#ifdef MORE_TESTS
        if( ! IS_INTOBJ( elem) ){
          ErrorMayQuit( "some entries are not integers", 0, 0);
          return NULL;
        }
#endif
        matr(i,j) = INT_INTOBJ( elem );
      }
  }

  perlobj* p = new perlobj("TropicalPolytope");
  p->take("POINTS") << matr;
  elem = NewPolymakeExternalObject(T_POLYMAKE_EXTERNAL_POLYTOPE);

  POLYMAKEOBJ_SET_PERLOBJ(elem, p);

  return elem;
}

