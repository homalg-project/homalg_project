# SPDX-License-Identifier: GPL-2.0-or-later
# RingsForHomalg: Dictionaries of external rings
#
# Implementations
#

##  Implementation stuff for the external computer algebra system Oscar.

####################################
#
# global variables:
#
####################################

BindGlobal( "HOMALG_IO_Oscar",
        rec(
            cas := "oscar", ## normalized name on which the user should have no control
            name := "Oscar",
            executable := [ "julia" ], ## this list is processed from left to right
            environment := [ "NEMO_THREADED=1" ],
            options := [ "--history-file=no", "--depwarn=error", "--color=no", "--code-coverage=none" ],
            #options := [ "--depwarn=error", "--color=no", "--code-coverage=none" ],
            BUFSIZE := 1024,
            READY := "!%&/)(",
            READY_printed := Concatenation( "\"", ~.READY, "\"" ),
            CUT_POS_BEGIN := 1, ## these are the most
            CUT_POS_END := 1,   ## delicate values!
            eoc_verbose := "",
            eoc_quiet := ";0", ## an Oscar specific
            normalized_white_space := NormalizedWhitespace, ## an Oscar specific
            setring := _Oscar_SetRing, ## an Oscar specific
            ## prints polynomials in a format compatible with other CASs
            setinvol := _Oscar_SetInvolution,## an Oscar specific
            define := "=",
            delete := function( var, stream ) homalgSendBlocking( [ var, " = nothing" ], "need_command", stream, "delete" ); end,
            multiple_delete := _Oscar_multiple_delete,
            garbage_collector := function( stream ) homalgSendBlocking( [ "Base.GC.gc()" ], "need_command", stream, "garbage_collector" ); end,
            prompt := "\033[01mjulia>\033[0m ",
            output_prompt := "\033[1;30;43m<julia\033[0m ",
            display_color := "\033[0;30;47m",
            banner := """\
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |
 _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
|__/                   |\
""",
            init_string := "import Singular; import Nemo; import AbstractAlgebra; using Hecke; Nemo.flint_set_num_threads(8)",
            InitializeCASMacros := InitializeOscarMacros,
            time := function( stream, t ) return Int( Int( homalgSendBlocking( [ "Int(time()*10^6)" ], "need_output", stream, "time" ) ) / 10^3 ) - t; end,
            memory_usage := function( stream, o ) return Int( homalgSendBlocking( [ "memory(", o, ")" ], "need_output", stream, "memory" ) ); end,
           )
);

HOMALG_IO_Oscar.READY_LENGTH := Length( HOMALG_IO_Oscar.READY_printed );

####################################
#
# families and types:
#
####################################

# a new type:
BindGlobal( "TheTypeHomalgExternalRingObjectInOscar",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingObjectInOscarRep ) );

# a new type:
BindGlobal( "TheTypeHomalgExternalRingInOscar",
        NewType( TheFamilyOfHomalgRings,
                IsHomalgExternalRingInOscarRep ) );

####################################
#
# global functions and variables:
#
####################################

## will be automatically invoked in homalgSendBlocking once stream.active_ring is set;
## so there is no need to invoke it explicitly for a ring which can never be
## created as the first ring in the stream!
InstallGlobalFunction( _Oscar_SetRing,
  function( R )
    local stream;
    
    stream := homalgStream( R );
    
    ## since _Oscar_SetRing might be called from homalgSendBlocking,
    ## we first set the new active ring to avoid infinite loops:
    stream.active_ring := R;
    
    if IsBound( HOMALG_IO_Oscar.setring_post ) then
        homalgSendBlocking( HOMALG_IO_Oscar.setring_post, "need_command", stream, "initialize" );
    fi;
    
end );

##
InstallGlobalFunction( _Oscar_SetInvolution,
  function( R )
    local RP;
    
    RP := homalgTable( R );
    
    if IsBound( RP!.SetInvolution ) then
        RP!.SetInvolution( R );
    fi;
    
end );

##
InstallGlobalFunction( _Oscar_multiple_delete,
  function( var_list, stream )
    local str, var;
    
    str:="";
    
    for var in var_list do
      str := Concatenation( str, String ( var ) , " = nothing;" );
    od;
    
    homalgSendBlocking( str, "need_command", stream, "multiple_delete" );
    
end );

##
BindGlobal( "OscarMacros",
        rec(

            init := """

function Singular.vector(R::Singular.PolyRing{T}, a::Array)::Singular.svector where T <:AbstractAlgebra.RingElem
   Singular.vector(R, a...)
end

function Singular.Module(R::Singular.PolyRing{T}, vecs::Array{Singular.svector{Singular.spoly{T}},1})::Singular.smodule where T <:AbstractAlgebra.RingElem
   Singular.Module(R, vecs...)
end

function Singular.Matrix(R::Singular.PolyRing{T}, r::Int, c::Int, a::Array{Singular.spoly{T},1})::Singular.smatrix where T<:AbstractAlgebra.RingElem
    Singular.transpose(Singular.Matrix(Singular.Module(R, [Singular.vector(R, a[c*(i-1)+1:c*i]) for i in 1:r])))
end

function Singular.Matrix(R::Singular.PolyRing, r::Int, c::Int, a::Array)::Singular.smatrix
    Singular.Matrix(R, r, c, [R(e) for e in a])
end

function Singular.Module(R::Singular.PolyRing{T}, a::Array{Singular.spoly{T},2})::Singular.smodule where T <:AbstractAlgebra.RingElem
    Singular.Module(R, [Singular.vector(R, a[1:size(a,1), i:i]) for i in 1:size(a,2)])
end

function Singular.Module(a::AbstractAlgebra.Generic.MatSpaceElem{T})::Singular.smodule where T <:AbstractAlgebra.RingElem
    Singular.Module(base_ring(a), AbstractAlgebra.Array(a))
end

function IsDiagonalMatrix(M::TypeOfMatrixForHomalg)::Bool
    for i in 1:nrows(M)
        for j in (i+1):ncols(M)
            iszero(M[i,j]) && return false
        end
    end
    for i in 1:nrows(M)
        for j in 1:(i-1)
            iszero(M[i,j]) && return false
        end
    end
    true
end

function Singular.check_parent(I::Singular.smodule{T}, J::Singular.smodule{T}) where T <: AbstractAlgebra.RingElem
   base_ring(I) != base_ring(J) && error("Incompatible modules")
end

function Singular.reduce(M::Singular.smodule, G::Singular.smodule)
   Singular.check_parent(M, G)
   R = base_ring(M)
   !G.isGB && error("Not a Groebner basis")
   ptr = Singular.libSingular.p_Reduce(M.ptr, G.ptr, R.ptr)
   return Singular.Module(R, ptr)
end

function SyzForHomalg(M::TypeOfMatrixForHomalg)::TypeOfMatrixForHomalg
    MatrixForHomalg(Singular.syz(Singular.Module(M)))
end

function Singular.dimension(I::Singular.smodule{S}) where S <: Union{Singular.spoly{T}, Singular.spoly{Singular.n_unknown{U}}} where {T <: Singular.FieldElem, U <: Nemo.FieldElem}
   I.isGB == false && error("I needs to be a Gröbner basis.")
   R = base_ring(I)
   return Int(Singular.libSingular.scDimInt(I.ptr, R.ptr))
end

function Singular.dimension(I::Singular.smodule{S}) where S <: Union{Singular.spoly{T}, Singular.spoly{Singular.n_unknown{U}}} where {T <: Singular.n_Z, U <: Nemo.Integer}
   I.isGB == false && error("I needs to be a Gröbner basis.")
   R = base_ring(I)
   return Int(Singular.libSingular.scDimInt(I.ptr, R.ptr))
end

function Dimension(M::TypeOfMatrixForHomalg)::Int64
    mM = Singular.Module(M)
    mM.isGB = true
    Singular.dimension(mM)
end

function (f::Singular.SAlgHom)(M::AbstractAlgebra.Generic.MatSpaceElem)
    MatrixForHomalg(codomain(f), [f(a) for a in Array(M)])
end

function ref_ff_rc!(M)
  rk = 0
  for i=1:nrows(M)
    c = Hecke.content(M[i, :])
    if !Hecke.isone(c)
      M[i, :] = Hecke.divexact(M[i, :], c)
    end
  end
  j = 1
  for i=1:nrows(M)
    best_j = 0
    best_t = typemax(Int)
    while j <= ncols(M)
      best_i = 0
      best_t = 0
      for ii = i:nrows(M)
        if Hecke.iszero(M[ii, j])
          continue
        end
        if best_i == 0
          best_i = ii
          best_t = length(M[ii, j])
        elseif best_t > length(M[ii, j])
          best_t = length(M[ii, j])
          best_i = ii
        end
      end
      if best_i == 0
        j += 1
        continue
      end
      if best_i > i
        M = Hecke.swap_rows!(M, i, best_i)
      end
      break
    end
    if j > ncols(M)
      return rk
    end
    rk += 1

    for k=i+1:nrows(M)
      if Hecke.iszero(M[k, j])
        continue
      end
      g = Hecke.gcd(M[k, j], M[i, j])
      if Hecke.isone(g)
        M[k, :] = M[i, j] * M[k, :] - M[k, j] * M[i, :]
      else
        M[k, :] = Hecke.divexact(M[i, j], g) * M[k, :] - Hecke.divexact(M[k, j], g) * M[i, :]
      end
      M[k, :] = Hecke.divexact(M[k, :], Hecke.content(M[k, :]))
    end
    j += 1
  end
  M[rk, :] = Hecke.divexact(M[rk, :], Hecke.content(M[rk, :]))
  return rk
end

function rref_ff_rc!(M)
  j = 2
  for i=2:nrows(M)
    while j <= ncols(M)
      if Hecke.iszero(M[i, j])
         j += 1
        continue
      end
      for k=1:i-1
        if Hecke.iszero(M[k, j])
          continue
        end
        g = Hecke.gcd(M[k, j], M[i, j])
        if Hecke.isone(g)
          M[k, :] = M[i, j] * M[k, :] - M[k, j] * M[i, :]
        else
          M[k, :] = Hecke.divexact(M[i, j], g) * M[k, :] - Hecke.divexact(M[k, j], g) * M[i, :]
        end
        M[k, :] = Hecke.divexact(M[k, :], Hecke.content(M[k, :]))
      end
      j += 1
      break
    end
  end
end

function cef_ff_rc!(M; ignore = 0)
  rk = 0
  for i=1:ncols(M)
    c = Hecke.content(M[:, i])
    if !Hecke.isone(c)
      M[:, i] = Hecke.divexact(M[:, i], c)
    end
  end
  j = 1
  m = nrows(M) - ignore
  for i=1:ncols(M)
    best_j = 0
    best_t = typemax(Int)
    while j <= m
      best_i = 0
      best_t = 0
      for ii = i:ncols(M)
        if Hecke.iszero(M[j, ii])
          continue
        end
        if best_i == 0
          best_i = ii
          best_t = length(M[j, ii])
        elseif best_t > length(M[j, ii])
          best_t = length(M[j, ii])
          best_i = ii
        end
      end
      if best_i == 0
        j += 1
        continue
      end
      if best_i > i
        M = Hecke.swap_cols!(M, best_i, i)
      end
      break
    end
    if j > m
      return rk
    end
    rk += 1

    for k=i+1:ncols(M)
      if Hecke.iszero(M[j, k])
        continue
      end
      g = Hecke.gcd(M[j, k], M[j, i])
      if Hecke.isone(g)
        M[:, k] = M[j, i] * M[:, k] - M[j, k] * M[:, i]
      else
        M[:, k] = Hecke.divexact(M[j, i], g) * M[:, k] - Hecke.divexact(M[j, k], g) * M[:, i]
      end
      M[:, k] = Hecke.divexact(M[:, k], Hecke.content(M[:, k]))
    end
    j += 1
  end
  M[:, rk] = Hecke.divexact(M[:, rk], Hecke.content(M[:, rk]))
  return rk
end

function rcef_ff_rc!(M)
  j = 2
  for i=2:ncols(M)
    while j <= nrows(M)
      if Hecke.iszero(M[j, i])
         j += 1
        continue
      end
      for k=1:i-1
        if Hecke.iszero(M[j, j])
          continue
        end
        g = Hecke.gcd(M[j, k], M[j, i])
        if Hecke.isone(g)
          M[:, k] = M[j, i] * M[:, k] - M[j, k] * M[:, i]
        else
          M[:, k] = Hecke.divexact(M[j, i], g) * M[:, k] - Hecke.divexact(M[j, k], g) * M[:, i]
        end
        M[:, k] = Hecke.divexact(M[:, k], Hecke.content(M[:, k]))
      end
      j += 1
      break
    end
  end
end
""",

    init2 := Concatenation( "include(\"", Filename( DirectoriesPackageLibrary( "RingsForHomalg", "gap" )[1], "Euclidean.jl" ), "\")" ),

    DiagMat := """

function DiagMat(e...)
    R = base_ring(e[1])
    l = length(e)
    function f(i,j)
        i == j && return e[i]
        ZeroMatrixForHomalg(R, nrows(e[i]), ncols(e[j]))
    end
    function g(i)
        a = map(j->f(i,j), 1:l)
        UnionOfRows(a...)
    end
    b = map(g, 1:l)
    UnionOfColumns(b...)
end
""",
    
    GetColumnIndependentUnitPositions := """

function GetColumnIndependentUnitPositions(M, poslist)
    rest = 1:nrows(M)
    pos = [ ]
    for j in 1:ncols(M)
        for k in reverse(rest)
            if !( [j, k] in poslist ) && isunit(M[k, j])
                push!(pos, [j, k])
                rest = filter(a -> iszero(M[a, j]), rest)
                break
            end
        end
    end

    if length(pos) == 0
        println("[]")
    else
        println(pos)
    end
end
""",

    GetRowIndependentUnitPositions := """

function GetRowIndependentUnitPositions(M, poslist)
    rest = 1:ncols(M)
    pos = [ ]
    for i in 1:nrows(M)
        for k in reverse(rest)
            if !( [i, k] in poslist ) && isunit(M[i, k])
                push!(pos, [i, k])
                rest = filter(a -> iszero(M[i, a]), rest)
                break
            end
        end
    end

    if length(pos) == 0
        println("[]")
    else
        println(pos)
    end
end
""",

    GetUnitPosition := """
function GetUnitPosition(M, poslist)
    m = ncols(M)
    n = nrows(M)
    for i in 1:m
        for j in 1:n
            if !( [i, j] in poslist ) && !( j in poslist ) && isunit(M[j, i])
                println([i, j])
                return
            end
        end
    end
    false
end
""",

    RowEchelonForm := """

function RowEchelonForm(M::TypeOfMatrixForHomalg; ignore::Int = 0)::TypeOfMatrixForHomalg
  N = copy(M)
  cef_ff_rc!(N, ignore = ignore)
  N[:, filter(i->!iszero(N[:, [i]]),1:ncols(M))]
end
""",

    ColumnEchelonForm := """

function ColumnEchelonForm(M::TypeOfMatrixForHomalg)::TypeOfMatrixForHomalg
  N = copy(M)
  ref_ff_rc!(N)
  N[filter(i->!iszero(N[[i], :]),1:nrows(M)), :]
end
""",

    ReducedRowEchelonForm := """

function ReducedRowEchelonForm(M::TypeOfMatrixForHomalg)::TypeOfMatrixForHomalg
  N = RowEchelonForm(M)
  rcef_ff_rc!(N)
  N
end
""",

    ReducedColumnEchelonForm := """

function ReducedColumnEchelonForm(M::TypeOfMatrixForHomalg)::TypeOfMatrixForHomalg
  N = ColumnEchelonForm(M)
  rref_ff_rc!(N)
  N
end
""",

    BasisOfRowModule := """

function BasisOfRowModule(M::TypeOfMatrixForHomalg)::TypeOfMatrixForHomalg
  MatrixForHomalg(Singular.std(Singular.Module(M), complete_reduction=true))
end
""",

    BasisOfColumnModule := """

function BasisOfColumnModule(M::TypeOfMatrixForHomalg)::TypeOfMatrixForHomalg
  Involution(BasisOfRowModule(Involution(M)))
end
""",

    BasisOfRowsCoeff := """

function BasisOfRowsCoeff(M::TypeOfMatrixForHomalg)
  B = BasisOfRowModule(M)
  T, rest = Singular.lift(Singular.Module(M), Singular.Module(B))
  B, MatrixForHomalg(T)
end
""",
  
    BasisOfColumnsCoeff := """

function BasisOfColumnsCoeff(M::TypeOfMatrixForHomalg)
  B, T = BasisOfRowsCoeff(Involution(M))
  Involution(B), Involution(T)
end
""",
  
    DecideZeroRows := """

function DecideZeroRows(A::TypeOfMatrixForHomalg, B::TypeOfMatrixForHomalg)::TypeOfMatrixForHomalg
  mA = Singular.Module(A)
  mB = Singular.Module(B)
  mB.isGB = true
  MatrixForHomalg(Singular.reduce(mA, mB))
end
""",

    DecideZeroColumns := """

function DecideZeroColumns(A::TypeOfMatrixForHomalg, B::TypeOfMatrixForHomalg)::TypeOfMatrixForHomalg
  Involution(DecideZeroRows(Involution(A), Involution(B)))
end
""",

    DecideZeroRowsEffectively := """

function DecideZeroRowsEffectively(A::TypeOfMatrixForHomalg, B::TypeOfMatrixForHomalg)
  mB = Singular.Module(B)
  mB.isGB = true
  M = DecideZeroRows(A, B)
  T, rest = Singular.lift(mB, Singular.Module(M-A))
  M, MatrixForHomalg(T)
end
""",

    DecideZeroColumnsEffectively := """

function DecideZeroColumnsEffectively(A::TypeOfMatrixForHomalg, B::TypeOfMatrixForHomalg)
  M, T = DecideZeroRowsEffectively(Involution(A), Involution(B))
  Involution(M), Involution(T)
end
""",
  
    SyzygiesGeneratorsOfRows := """

function SyzygiesGeneratorsOfRows(M::TypeOfMatrixForHomalg)::TypeOfMatrixForHomalg
  SyzForHomalg(M)
end
""",
    
    SyzygiesGeneratorsOfColumns := """

function SyzygiesGeneratorsOfColumns(M::TypeOfMatrixForHomalg)::TypeOfMatrixForHomalg
  Involution(SyzForHomalg(Involution(M)))
end
""",

    RelativeSyzygiesGeneratorsOfRows := """

function RelativeSyzygiesGeneratorsOfRows(M1::TypeOfMatrixForHomalg, M2::TypeOfMatrixForHomalg)::TypeOfMatrixForHomalg
  BasisOfRowModule(MatrixForHomalg(Singular.modulo(Singular.Module(M1), Singular.Module(M2))))
end
""",

    RelativeSyzygiesGeneratorsOfColumns := """

function RelativeSyzygiesGeneratorsOfColumns(M1::TypeOfMatrixForHomalg, M2::TypeOfMatrixForHomalg)::TypeOfMatrixForHomalg
  Involution(RelativeSyzygiesGeneratorsOfRows(Involution(M1), Involution(M2)))
end
""",

    RadicalSubobject := """

function RadicalSubobject(M::TypeOfMatrixForHomalg)::TypeOfMatrixForHomalg
  MatrixForHomalg(Singular.LibPrimdec.radical(Singular.Module(M)))
end
""",

    RadicalSubobject_Z := """

function RadicalSubobject_Z(M::TypeOfMatrixForHomalg)::TypeOfMatrixForHomalg
  MatrixForHomalg(Singular.LibPrimdecint.radicalZ(Singular.Module(M)))
end
""",

    Diff := """
function Diff(m, n) # following the Macaulay2 convention
  f = nrows(m)
  p = ncols(m)
  g = nrows(n)
  q = ncols(n)
  h = ZeroMatrixForHomalg(base_ring(m), f*g, p*q)
  for i = 1:f
    for j = 1:g
      for k = 1:p
        for l = 1:q
            h[g*(i-1)+j, q*(k-1)+l] = derivative(n[j,l], m[i,k])
        end
      end
    end
  end
  return h
end
""",
    
    )

);

if true then ## AbstactAlgebra matrices

OscarMacros.("$matrices") := """

TypeOfMatrixForHomalg = AbstractAlgebra.Generic.MatSpaceElem

MatrixForHomalg = AbstractAlgebra.matrix

function AbstractAlgebra.matrix(R::Singular.PolyRing{T}, a::Array{Singular.spoly{T},2})::AbstractAlgebra.Generic.MatSpaceElem where T <:AbstractAlgebra.RingElem
    AbstractAlgebra.transpose(AbstractAlgebra.matrix(R, size(a)[2], size(a)[1], reshape(a, :)))
end

function AbstractAlgebra.matrix(a::Singular.smodule)::AbstractAlgebra.Generic.MatSpaceElem
    if ngens(a) == 0
        ## empty matrices currently crash AbstractAlgebra, and homalg will take care of these corner cases anyway
        return ZeroMatrixForHomalg(base_ring(a),1,1)
    end
    aa = [ AbstractAlgebra.Array(a[i]) for i in 1:ngens(a) ]
    AbstractAlgebra.matrix(base_ring(a), hcat(aa...))
end

function AbstractAlgebra.matrix(a::Singular.sideal)::AbstractAlgebra.Generic.MatSpaceElem
    if ngens(a) == 0
        ## empty matrices currently crash AbstractAlgebra, and homalg will take care of these corner cases anyway
        return ZeroMatrixForHomalg(base_ring(a),1,1)
    end
    aa = [a[i] for i in 1:ngens(a)]
    AbstractAlgebra.matrix(base_ring(a), reshape(aa, 1, ngens(a)))
end

function ZeroMatrixForHomalg(R, r, c)
    AbstractAlgebra.matrix(R, fill(zero(R), r, c))
end

function IdentityMatrixForHomalg(R, r)
    id = fill(zero(R), r, r)
    o = one(R)
    for i in 1:r
        id[i,i] = o
    end
    AbstractAlgebra.matrix(R, id)
end

Determinant = AbstractAlgebra.det

function UnionOfRows(A::AbstractAlgebra.MatElem...)
  r = nrows(A[1])
  c = ncols(A[1])
  R = base_ring(A[1])
  for i=2:length(A)
    @assert nrows(A[i]) == r
    @assert base_ring(A[i]) == R
    c += ncols(A[i])
  end
  X = similar(A[1], r, c)
  o = 1
  for i=1:length(A)
    for j=1:ncols(A[i])
      X[:, o] = A[i][:, j]
      o += 1
    end
  end
  return X
end

function UnionOfColumns(A::AbstractAlgebra.MatElem...)
  r = nrows(A[1])
  c = ncols(A[1])
  R = base_ring(A[1])
  for i=2:length(A)
    @assert ncols(A[i]) == c
    @assert base_ring(A[i]) == R
    r += nrows(A[i])
  end
  X = similar(A[1], r, c)
  o = 1
  for i=1:length(A)
    for j=1:nrows(A[i])
      X[o, :] = A[i][j, :]
      o += 1
    end
  end
  return X
end

function CertainRows(m::TypeOfMatrixForHomalg, list)::TypeOfMatrixForHomalg
    m[:, list]
end

function CertainColumns(m::TypeOfMatrixForHomalg, list)::TypeOfMatrixForHomalg
    m[list, :]
end

function ZeroRows(M::TypeOfMatrixForHomalg)
    l = filter(i->iszero(M[:, [i]]),1:ncols(M))
    if length(l) == 0
        println("[]")
    else
        println(l)
    end
end

function ZeroColumns(M::TypeOfMatrixForHomalg)
    l = filter(i->iszero(M[[i], :]),1:nrows(M))
    if length(l) == 0
        println("[]")
    else
        println(l)
    end
end
""";

else ## Singular matrices

OscarMacros.("$matrices") := """

TypeOfMatrixForHomalg = Singular.smatrix

MatrixForHomalg = Singular.Matrix

ZeroMatrixForHomalg = Singular.zero_matrix

IdentityMatrixForHomalg = Singular.identity_matrix

#function Singular.Matrix(R::Singular.PolyRing{T}, a::Array{Singular.spoly{T}, 2})::Singular.smatrix{Singular.spoly{T}} where T <:AbstractAlgebra.RingElem
#    Singular.Matrix(R::Singular.PolyRing{T}, size(a)[1], size(a)[2], reshape(a,:))
#end

function isone(r::Singular.spoly{T})::Bool where T r == one(r) end
function isone(M::Singular.smatrix)::Bool nrows(M) == ncols(M) && iszero(M - IdentityMatrixForHomalg(base_ring(M), nrows(M))) end

Determinant = Singular.det

function UnionOfRows(Ms::Singular.smatrix...)::Singular.smatrix
    list = [[M[i] for i in 1:ngens(M)] for M in [Singular.Module(M) for M in Ms]]
    list = vcat(list...)
    Singular.Matrix(Singular.Module(base_ring(Ms[1]), list))
end

function UnionOfColumns(Ms::Singular.smatrix...)::Singular.smatrix
    list = [[M[i] for i in 1:ngens(M)] for M in [Singular.Module(Singular.transpose(M)) for M in Ms]]
    list = vcat(list...)
    Singular.transpose(Singular.Matrix(Singular.Module(base_ring(Ms[1]), list)))
end

function CertainRows(m::TypeOfMatrixForHomalg, list)::TypeOfMatrixForHomalg
    M = Singular.Module(m)
    MatrixForHomalg(Singular.Module(base_ring(M), [M[i] for i in list]))
end

function CertainColumns(m::TypeOfMatrixForHomalg, list)::TypeOfMatrixForHomalg
    Singular.transpose(CertainRows(Singular.transpose(m), list))
end

function ZeroRows(m::TypeOfMatrixForHomalg)
    M = Singular.Module(m)
    l = filter(i->iszero(M[i]),1:ngens(M))
    if length(l) == 0
        println("[]")
    else
        println(l)
    end
end

function ZeroColumns(m::TypeOfMatrixForHomalg)
    ZeroRows(Singular.transpose(m))
end
""";

fi;
    

##
InstallGlobalFunction( InitializeOscarMacros,
  function( stream )
    
    return InitializeMacros( OscarMacros, stream );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( RingForHomalgInOscar,
  function( arg )
    local finalizers, nargs, ar, R, RP;
    
    finalizers := PositionProperty( arg, i -> IsList( i ) and ForAll( i, IsFunction ) );
    
    if not finalizers = fail then
        finalizers := Remove( arg, finalizers );
    fi;
    
    nargs := Length( arg );
    
    ar := [ arg[1] ];
    
    Add( ar, TheTypeHomalgExternalRingObjectInOscar );
    
    if nargs > 1 then
        Append( ar, arg{[ 2 .. nargs ]} );
    fi;
    
    ar := [ ar, TheTypeHomalgExternalRingInOscar ];
    
    Add( ar, "HOMALG_IO_Oscar" );
    
    if not finalizers = fail then
        Add( ar, finalizers );
    fi;
    
    R := CallFuncList( CreateHomalgExternalRing, ar );
    
    if not IsBound( homalgStream( R ).start_time ) then
        homalgStream( R ).start_time := homalgTime( R );
    fi;
    
    _Oscar_SetRing( R );
    
    RP := homalgTable( R );
    
    RP!.SetInvolution :=
      function( R )
        homalgSendBlocking( "\nfunction Involution(m) return transpose(m) end\n\n", "need_command", R, "define" );
    end;
    
    RP!.NumeratorAndDenominatorOfPolynomial := RP!.NumeratorAndDenominatorOfRational;
    
    homalgStream( R ).setinvol( R );
    
    LetWeakPointerListOnExternalObjectsContainRingCreationNumbers( R );
    
    return R;
    
end );

##
InstallGlobalFunction( HomalgRingOfIntegersInOscar,
  function( arg )
    local zz, nargs, c, d, param, minimal_polynomial, r, R, RP;
    
    zz := "Singular.ZZ";
    
    nargs := Length( arg );
    
    if nargs > 0 and IsInt( arg[1] ) and arg[1] <> 0 then
        ## characteristic:
        c := AbsInt( arg[1] );
        arg := arg{[ 2 .. nargs ]};
        if nargs > 1 and IsPosInt( arg[1] ) then
            d := arg[1];
            if d > 1 then
                param := Concatenation( "Z", String( c ), "_", String( d ) );
                arg := Concatenation( [ c, param, d ], arg{[ 2 .. nargs - 1 ]} );
                R := CallFuncList( HomalgRingOfIntegersInOscar, arg );
                SetRingProperties( R, c, d );
                R!.NameOfPrimitiveElement := param;
                SetName( R, Concatenation( "GF(", String( c ), "^", String( d ), ")" ) );
                return R;
            fi;
            arg := arg{[ 2 .. Length( arg ) ]};
        fi;
    else
        ## characteristic:
        c := 0;
        if nargs > 0 and arg[1] = 0 then
            arg := arg{[ 2 .. nargs ]};
        fi;
    fi;
    
    if not ( IsZero( c ) or IsPrime( c ) ) then
        return HomalgRingOfIntegersInOscar( ) / c;
    fi;
    
    ## we create GF(p)[dummy_variable] and feed only expressions without
    ## "dummy_variable" to Oscar. Since GAP does not know about
    ## the dummy_variable it will vanish during the next ring extension
    
    nargs := Length( arg );
    
    if nargs > 0 and IsString( arg[1] ) then
        
        param := ParseListOfIndeterminates( SplitString( arg[1], "," ) );
        
        arg := arg{[ 2 .. nargs ]};
        
        if nargs > 1 and IsString( arg[1] ) then
            minimal_polynomial := arg[1];
            arg := arg{[ 2 .. nargs - 1 ]};
        fi;
        
        r := CallFuncList( HomalgRingOfIntegersInOscar, arg );
        
        R := [ "Hecke.PolynomialRing(Hecke.ZZ, ", String( param ), ")" ];
        R := Concatenation( [ R ], [ [ "" ] ], [ [ ", (", JoinStringsWithSeparator( param ), ")" ] ], [ IsPrincipalIdealRing ], arg );
        
    else
        
        if not IsZero( c ) then
            zz := Concatenation( "Singular.FiniteField(", String( c ), ", 1, \"Zc_1\")[1]" );
        fi;
        
        R := Concatenation( "Singular.PolynomialRing(", zz, ", [\"dummy_variable\"])" );
        R := Concatenation( [ R ], [ [ "" ] ], [ [ ", dummy_variable" ] ], [ IsPrincipalIdealRing ], arg );
    
    fi;
    
    if IsBound( r ) then
        ## R will be defined in the same instance of Oscar as r
        Add( R, r );
    fi;
    
    if IsBound( minimal_polynomial ) then
        ## FIXME: we assume the polynomial is irreducible of degree > 1
        Add( R,
             [ function( R )
                 local name;
                 
                 name := homalgSendBlocking( [ minimal_polynomial ], "need_output", R, "homalgSetName" );
                 if name[1] = '(' and name[Length( name )] = ')' then
                     name := name{[ 2 .. Length( name ) - 1 ]};
                 fi;
                 R!.MinimalPolynomialOfPrimitiveElement := name;
                 homalgSendBlocking( [ "minpoly=", minimal_polynomial ], "need_command", R, "define" );
               end ] );
    fi;
    
    R := CallFuncList( RingForHomalgInOscar, R );
    
    R!.RingWithoutDummyVariable := zz;
    
    if IsBound( param ) then
        
        param := List( param, function( a ) local r; r := HomalgExternalRingElement( a, R ); SetName( r, a ); return r; end );
        
        SetRationalParameters( R, param );
        
        SetIsResidueClassRingOfTheIntegers( R, false );
        
        if IsPrime( c ) then
            SetIsFieldForHomalg( R, true );
            ## FIXME: we assume the polynomial is irreducible of degree > 1
            if not IsBound( minimal_polynomial ) then
                SetCoefficientsRing( R, r );
            fi;
        else
            SetCoefficientsRing( R, r );
            SetIsFieldForHomalg( R, false );
            SetIsPrincipalIdealRing( R, true );
            SetIsCommutative( R, true );
        fi;
        
    else
        
        SetIsResidueClassRingOfTheIntegers( R, true );
        
    fi;
    
    SetRingProperties( R, c );

    RP := homalgTable( R );
    Unbind( RP!.ReducedRowEchelonForm );
    Unbind( RP!.ReducedColumnEchelonForm );
    
    if HasIsIntegersForHomalg( R ) and IsIntegersForHomalg( R ) then
        RP!.PrimaryDecomposition := RP!.PrimaryDecomposition_Z;
        RP!.RadicalSubobject := RP!.RadicalSubobject_Z;
        RP!.RadicalDecomposition := RP!.RadicalDecomposition_Z;
        Unbind( RP!.CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries );
        Unbind( RP!.MaximalDegreePart );
    fi;
    
    return R;
    
end );

##
InstallMethod( HomalgRingOfIntegersInUnderlyingCAS,
        "for an integer and homalg ring in Oscar",
        [ IsInt, IsHomalgExternalRingInOscarRep ],
        
  HomalgRingOfIntegersInOscar );

##
InstallGlobalFunction( HomalgFieldOfRationalsInOscar,
  function( arg )
    local QQ, nargs, param, minimal_polynomial, Q, R;
    
    QQ := "Singular.QQ";
    
    nargs := Length( arg );
    
    if nargs > 0 and IsString( arg[1] ) then
        
        param := ParseListOfIndeterminates( SplitString( arg[1], "," ) );
        
        arg := arg{[ 2 .. nargs ]};
        
        if nargs > 1 and IsString( arg[1] ) then
            minimal_polynomial := arg[1];
            arg := arg{[ 2 .. nargs - 1 ]};
        fi;
        
        Q := CallFuncList( HomalgFieldOfRationalsInOscar, arg );
        
        if param = [ ] then
            R := [ "Singular.PolynomialRing(", QQ, ", [\"dummy_variable\"])" ];
            R := Concatenation( [ R ], [ [ "" ] ], [ [ ", dummy_variable" ] ], [ IsPrincipalIdealRing ], arg );
        else
            R := [ "Hecke.PolynomialRing(Hecke.QQ, ", String( param ), ")" ];
            R := Concatenation( [ R ], [ [ "" ] ], [ [ ", (", JoinStringsWithSeparator( param ), ")" ] ], [ IsPrincipalIdealRing ], arg );
        fi;
        
    else
        
        R := [ "Singular.PolynomialRing(", QQ, ", [\"dummy_variable\"])" ];
        R := Concatenation( [ R ], [ [ "" ] ], [ [ ", dummy_variable" ] ], [ IsPrincipalIdealRing ], arg );
        
    fi;
    
    if IsBound( Q ) then
        ## R will be defined in the same instance of Oscar as Q
        Add( R, Q );
    fi;
    
    if IsBound( minimal_polynomial ) then
        ## FIXME: we assume the polynomial is irreducible of degree > 1
        Add( R,
             [ function( R )
                 local name;
                 
                 name := homalgSendBlocking( [ minimal_polynomial ], "need_output", R, "homalgSetName" );
                 if name[1] = '(' and name[Length( name )] = ')' then
                     name := name{[ 2 .. Length( name ) - 1 ]};
                 fi;
                 R!.MinimalPolynomialOfPrimitiveElement := name;
                 homalgSendBlocking( [ "minpoly=", minimal_polynomial ], "need_command", R, "define" );
               end ] );
    fi;
    
    R := CallFuncList( RingForHomalgInOscar, R );
    
    R!.RingWithoutDummyVariable := QQ;
    
    if IsBound( param ) and not IsEmpty( param ) then
        
        param := List( param, function( a ) local r; r := HomalgExternalRingElement( a, R ); SetName( r, a ); return r; end );
        
        SetRationalParameters( R, param );
        
        SetIsFieldForHomalg( R, true );
        
        SetCoefficientsRing( R, Q );
        
    else
        
        SetIsRationalsForHomalg( R, true );
        
    fi;
    
    SetRingProperties( R, 0 );
    
    return R;
    
end );

##
InstallMethod( HomalgFieldOfRationalsInUnderlyingCAS,
        "for a homalg ring in Oscar",
        [ IsHomalgExternalRingInOscarRep ],
        
  HomalgFieldOfRationalsInOscar );

##
InstallMethod( FieldOfFractions,
        "for homalg rings in Oscar",
        [ IsHomalgExternalRingInOscarRep and IsIntegersForHomalg ],
        
  function( zz )
    
    return HomalgFieldOfRationalsInOscar( zz );
    
end );

##
InstallGlobalFunction( HomalgRingOfCyclotomicIntegersInOscar,
  function( arg )
    local degree, var, v, R, RP;
    
    if Length( arg ) < 2 then
        
        Error( "too few arguments" );
        
    fi;
    
    degree := arg[ 1 ];
    
    var := arg[ 2 ];
    
    arg := arg{ [ 3 .. Length( arg )] };
    
    if degree = 1 then
        
        return CallFuncList( HomalgRingOfIntegersInOscar, arg );
        
    elif not IsInt( degree ) or not IsString( var ) then
        
        Error( "input must be an integer > 1 and a string\n" );
        
    fi;
    
    R := [ [ "RingOfCyclotomicIntegers(", String( degree ), ")" ], [ "" ], [ ", ", var ] ];
    
    R := CallFuncList( RingForHomalgInOscar, R );

    SetName( R, Concatenation( "Z[", var, "]" ) );
    
    SetIsRationalsForHomalg( R, false );
    
    SetIsFieldForHomalg( R, false );
    
    SetBaseRing( R, R );

    RP := homalgTable( R );
    
    Unbind( RP!.BasisOfRowModule );
    Unbind( RP!.BasisOfColumnModule );
    Unbind( RP!.BasisOfRowsCoeff );
    Unbind( RP!.BasisOfColumnsCoeff );
    Unbind( RP!.DecideZeroRows );
    Unbind( RP!.DecideZeroColumns );
    Unbind( RP!.DecideZeroRowsEffectively );
    Unbind( RP!.DecideZeroColumnsEffectively );
    Unbind( RP!.SyzygiesGeneratorsOfRows );
    Unbind( RP!.SyzygiesGeneratorsOfColumns );
    Unbind( RP!.RelativeSyzygiesGeneratorsOfRows );
    Unbind( RP!.RelativeSyzygiesGeneratorsOfColumns );
    
    return R;
    
end );

##
InstallGlobalFunction( HomalgRingOfGoldenRatioIntegersInOscar,
  function( arg )
    local var, v, R, RP;
    
    if Length( arg ) < 1 then
        
        Error( "too few arguments" );
        
    fi;
    
    var := arg[ 1 ];
    
    arg := arg{ [ 2 .. Length( arg )] };
    
    R := [ [ "RingOfGoldenRatioIntegers()" ], [ "" ], [ ", ", var ] ];
    
    R := CallFuncList( RingForHomalgInOscar, R );

    SetName( R, Concatenation( "Z[", var, "]" ) );
    
    SetIsRationalsForHomalg( R, false );
    
    SetIsFieldForHomalg( R, false );
    
    SetBaseRing( R, R );

    RP := homalgTable( R );
    
    Unbind( RP!.BasisOfRowModule );
    Unbind( RP!.BasisOfColumnModule );
    Unbind( RP!.BasisOfRowsCoeff );
    Unbind( RP!.BasisOfColumnsCoeff );
    Unbind( RP!.DecideZeroRows );
    Unbind( RP!.DecideZeroColumns );
    Unbind( RP!.DecideZeroRowsEffectively );
    Unbind( RP!.DecideZeroColumnsEffectively );
    Unbind( RP!.SyzygiesGeneratorsOfRows );
    Unbind( RP!.SyzygiesGeneratorsOfColumns );
    Unbind( RP!.RelativeSyzygiesGeneratorsOfRows );
    Unbind( RP!.RelativeSyzygiesGeneratorsOfColumns );
    
    return R;
    
end );

##
InstallMethod( PolynomialRing,
        "for homalg rings in Oscar",
        [ IsHomalgExternalRingInOscarRep, IsList ],
        
  function( R, indets )
    local order, ar, r, var, nr_var, properties, param, l, var_base, var_fibr, a, ext_obj, S, weights, P, L, W, RP;
    
    order := ValueOption( "order" );
    
    ar := _PrepareInputForPolynomialRing( R, indets );
    
    r := ar[1];
    var := ar[2];    ## all indeterminates, relative and base
    nr_var := ar[3]; ## the number of relative indeterminates
    properties := ar[4];
    param := ar[5];
    
    l := Length( var );
    
    ## create the new ring
    if IsString( order ) and Length( order ) >= 3 and order{[ 1 .. 3 ]} = "lex" then
        
        var_base := var{[ 1 .. l - nr_var ]};
        var_fibr := var{[ l - nr_var + 1 .. l ]};
        
        ## lex order
        if HasIsIntegersForHomalg( r ) and IsIntegersForHomalg( r ) then
            ext_obj := homalgSendBlocking( [ "(integer", param, "),(", Concatenation( var_fibr, var_base ), "),(lp,c)" ], TheTypeHomalgExternalRingObjectInOscar, properties, R, "CreateHomalgRing" );
        else
            ext_obj := homalgSendBlocking( [ "(", Characteristic( R ), param, "),(", Concatenation( var_fibr, var_base ), "),(lp,c)" ], TheTypeHomalgExternalRingObjectInOscar, properties, R, "CreateHomalgRing" );
        fi;
        
    elif IsRecord( order ) and IsBound( order.weights ) then
        
        ## weighted degrevlex order
        if HasIsIntegersForHomalg( r ) and IsIntegersForHomalg( r ) then
            ext_obj := homalgSendBlocking( [ "(integer", param, "),(", var, "),(wp(", order.weights, "),c)" ], TheTypeHomalgExternalRingObjectInOscar, properties, R, "CreateHomalgRing" );
        else
            ext_obj := homalgSendBlocking( [ "(", Characteristic( R ), param, "),(", var, "),(wp(", order.weights, "),c)" ], TheTypeHomalgExternalRingObjectInOscar, properties, R, "CreateHomalgRing" );
        fi;
        
    elif order = "product" or order = "block" then
        
        var_base := var{[ 1 .. l - nr_var ]};
        var_fibr := var{[ l - nr_var + 1 .. l ]};
        
        ## block order
        weights := Concatenation( Concatenation( List( [ 1 .. Length( var_base ) ], a -> "0," ) ), Concatenation( List( [ 1 .. Length( var_fibr ) ], a -> "1," ) ) );
        weights := weights{[ 1 .. Length( weights ) - 1 ]}; # remove trailing comma
        if HasIsIntegersForHomalg( r ) and IsIntegersForHomalg( r ) then
            ext_obj := homalgSendBlocking( [ "(integer", param, "),(", var_base, var_fibr, "),(a(", weights, "),dp,C)" ], TheTypeHomalgExternalRingObjectInOscar, properties, R, "CreateHomalgRing" );
        else
            ext_obj := homalgSendBlocking( [ "(", Characteristic( R ), param, "),(", var_base, var_fibr, "),(a(", weights, "),dp,C)" ], TheTypeHomalgExternalRingObjectInOscar, properties, R, "CreateHomalgRing" );
        fi;
        
    else

        if IsBound( R!.RingWithoutDummyVariable ) then
            a := R!.RingWithoutDummyVariable;
        else
            a := CoefficientsRing( R )!.RingWithoutDummyVariable;
        fi;
        
        ## degrevlex order
        if Length( var ) = 1 then
            ext_obj := homalgSendBlocking( [ "Singular.PolynomialRing(", a, ", ", var, ")" ], [ "" ], [ Concatenation( ", (", JoinStringsWithSeparator( var ), ",)" ) ], TheTypeHomalgExternalRingObjectInOscar, properties, R, "CreateHomalgRing" );
        else
            ext_obj := homalgSendBlocking( [ "Singular.PolynomialRing(", a, ", ", var, ")" ], [ "" ], [ Concatenation( ", (", JoinStringsWithSeparator( var ), ")" ) ], TheTypeHomalgExternalRingObjectInOscar, properties, R, "CreateHomalgRing" );
        fi;
        
    fi;
    
    ## this must precede CreateHomalgExternalRing as otherwise
    ## the definition of 0,1,-1 would precede "minpoly=";
    ## causing an error in the new Oscar
    if IsBound( r!.MinimalPolynomialOfPrimitiveElement ) then
        homalgSendBlocking( [ "minpoly=", r!.MinimalPolynomialOfPrimitiveElement ], "need_command", ext_obj, "define" );
    fi;
    
    S := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInOscar );
    
    S!.order := order;
    
    var := List( var, a -> HomalgExternalRingElement( a, S ) );
    
    Perform( var, Name );
    
    SetIsFreePolynomialRing( S, true );
    
    if HasIndeterminatesOfPolynomialRing( R ) and IndeterminatesOfPolynomialRing( R ) <> [ ] then
        
        SetBaseRing( S, R );
        SetRelativeIndeterminatesOfPolynomialRing( S, var{[ l - nr_var + 1 .. l ]} );
        
        if false then # order = fail then
            
            P := PolynomialRingWithProductOrdering( R, indets );
            
            weights := Concatenation( ListWithIdenticalEntries( l - nr_var, 0 ), ListWithIdenticalEntries( nr_var, 1 ) );
            W := PolynomialRing( R, indets : order := rec( weights := weights ) );
            
            SetPolynomialRingWithDegRevLexOrdering( S, S );
            SetPolynomialRingWithDegRevLexOrdering( P, S );
            SetPolynomialRingWithDegRevLexOrdering( W, S );
            
            SetPolynomialRingWithProductOrdering( S, P );
            SetPolynomialRingWithProductOrdering( P, P );
            SetPolynomialRingWithProductOrdering( W, P );
            
            SetPolynomialRingWithWeightedOrdering( S, W );
            SetPolynomialRingWithWeightedOrdering( P, W );
            SetPolynomialRingWithWeightedOrdering( W, W );
            
        fi;
        
    else
        
        if order = fail then
            
            SetPolynomialRingWithDegRevLexOrdering( S, S );
            
        fi;
        
    fi;
    
    SetRingProperties( S, r, var );
    
    RP := homalgTable( S );
    
    homalgStream( S ).setinvol( S );
    
    if not ( HasIsFieldForHomalg( r ) and IsFieldForHomalg( r ) ) then
        Unbind( RP!.IsUnit );
        Unbind( RP!.GetColumnIndependentUnitPositions );
        Unbind( RP!.GetRowIndependentUnitPositions );
        Unbind( RP!.GetUnitPosition );
    fi;
    
    if HasIsIntegersForHomalg( r ) and IsIntegersForHomalg( r ) then
        RP!.PrimaryDecomposition := RP!.PrimaryDecomposition_Z;
        RP!.RadicalSubobject := RP!.RadicalSubobject_Z;
        RP!.RadicalDecomposition := RP!.RadicalDecomposition_Z;
        Unbind( RP!.CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries );
        Unbind( RP!.MaximalDegreePart );
    fi;
    
    Unbind( RP!.ReducedRowEchelonForm );
    Unbind( RP!.ReducedColumnEchelonForm );
    
    return S;
    
end );

##
InstallMethod( PolynomialRingWithProductOrdering,
        "for homalg rings in Oscar",
        [ IsHomalgExternalRingInOscarRep, IsList ],
        
  function( R, indets )
    
    return PolynomialRing( R, indets : order := "product" );
    
end );

##
InstallMethod( PolynomialRingWithLexicographicOrdering,
        "for homalg rings in Oscar",
        [ IsHomalgExternalRingInOscarRep, IsList ],
        
  function( R, indets )
    
    return PolynomialRing( R, indets : order := "lex" );
    
end );

##
InstallMethod( RingOfDerivations,
        "for homalg rings in Oscar",
        [ IsHomalgExternalRingInOscarRep, IsList ],
        
  function( R, indets )
    local ar, r, var, der, param, base, stream, display_color, ext_obj, b, n, S, RP;
    
    ar := _PrepareInputForRingOfDerivations( R, indets );
    
    r := ar[1];
    var := ar[2];
    der := ar[3];
    param := ar[4];
    base := ar[5];
    
    stream := homalgStream( R );
    
    if ( not ( IsBound( HOMALG_IO.show_banners ) and HOMALG_IO.show_banners = false )
         and not ( IsBound( stream.show_banner ) and stream.show_banner = false )
         and not ( IsBound( stream.show_banner_PLURAL ) and stream.show_banner_PLURAL = false ) ) then
        
        if IsBound( stream.color_display ) then
            display_color := stream.color_display;
        else
            display_color := "";
        fi;
        
        Print( "================================================================\n" );
        
        ## leave the below indentation untouched!
        Print( display_color, "\
                     SINGULAR::PLURAL\n\
The SINGULAR Subsystem for Non-commutative Polynomial Computations\n\
     by: G.-M. Greuel, V. Levandovskyy, H. Schoenemann\n\
FB Mathematik der Universitaet, D-67653 Kaiserslautern\033[0m\n\
================================================================\n" );
        
        stream.show_banner_PLURAL := false;
        
    fi;
    
    ## create the new ring in 2 steps: expand polynomial ring with derivatives and then
    ## add the Weyl-structure
    ## todo: this creates a block ordering with a new "dp"-block
    if HasIsIntegersForHomalg( r ) and IsIntegersForHomalg( r ) then
        if base <> "" then
            ext_obj := homalgSendBlocking( [ "(integer", param,  "),(", base, var, der, "),(dp(", Length( base ), "),dp,C)" ], R, "initialize" );
        else
            ext_obj := homalgSendBlocking( [ "(integer", param,  "),(", var, der, "),(dp,C)" ], R, "initialize" );
        fi;
    else
        if base <> "" then
            ext_obj := homalgSendBlocking( [ "(", Characteristic( R ), param, "),(", base, var, der, "),(dp(", Length( base ), "),dp,C)" ], R, "initialize" );
        else
            ext_obj := homalgSendBlocking( [ "(", Characteristic( R ), param, "),(", var, der, "),(dp,C)" ], R, "initialize" );
        fi;
    fi;
    
    ## as we are not yet done we cannot call CreateHomalgExternalRing
    ## to create a HomalgRing, and only then would homalgSendBlocking call stream.setring,
    ## so till then we have to prevent the garbage collector from stepping in
    stream.DeletePeriod_save := stream.DeletePeriod;
    stream.DeletePeriod := false;
    
    if base <> "" then
        b := Length( base );
        n := b + Length( var ) + Length( der );
        homalgSendBlocking( [ "matrix @M[", n, "][", n, "]" ], "need_command", ext_obj, "initialize" );
        n := Length( der );
        b := List( [ 1 .. Length( der ) ], i -> Concatenation( "@M[", String( b + i ), ",", String( b + n + i ), "] = 1;" ) );
        homalgSendBlocking( Concatenation( b ), "need_command", ext_obj, "initialize" );
        ext_obj := homalgSendBlocking( [ "nc_algebra(1,@M)" ], TheTypeHomalgExternalRingObjectInOscar, ext_obj, "CreateHomalgRing" );
    else
        ext_obj := homalgSendBlocking( [ "Weyl()" ], TheTypeHomalgExternalRingObjectInOscar, ext_obj, "CreateHomalgRing" );
    fi;
    
    ## this must precede CreateHomalgExternalRing as otherwise
    ## the definition of 0,1,-1 would precede "minpoly=";
    ## causing an error in the new Oscar
    if IsBound( r!.MinimalPolynomialOfPrimitiveElement ) then
        homalgSendBlocking( [ "minpoly=", r!.MinimalPolynomialOfPrimitiveElement ], "need_command", ext_obj, "define" );
    fi;
    
    S := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInOscar );
    
    ## now it is safe to call the garbage collector
    stream.DeletePeriod := stream.DeletePeriod_save;
    Unbind( stream.DeletePeriod_save );
    
    der := List( der , a -> HomalgExternalRingElement( a, S ) );
    
    Perform( der, Name );
    
    SetIsWeylRing( S, true );
    
    SetBaseRing( S, R );
    
    SetRingProperties( S, R, der );
    
    RP := homalgTable( S );
    
    RP!.SetInvolution :=
      function( R )
        homalgSendBlocking( Concatenation(
                [ "\nproc Involution (matrix M)\n{\n" ],
                [ "  map F = ", R, ", " ],
                [ JoinStringsWithSeparator( List( IndeterminateCoordinatesOfRingOfDerivations( R ), String ) ) ],
                Concatenation( List( IndeterminateDerivationsOfRingOfDerivations( R ), a -> [ ", -" , String( a ) ] ) ),
                [ ";\n  return( transpose( involution( M, F ) ) );\n}\n\n" ]
                ), "need_command", "define" );
    end;
    
    homalgStream( S ).setinvol( S );
    
    RP!.Compose :=
      function( A, B )
        
        # fix the broken design of Plural
        return homalgSendBlocking( [ "transpose( transpose(", A, ") * transpose(", B, ") )" ], [ "matrix" ], "Compose" );
        
    end;
    
    ## there exists a bug in Plural (3-0-4,3-1-0) that occurs with nres(M,2)[2];
    if homalgSendBlocking( "\n\
// start: check the nres-isHomog-bug in Plural:\n\
ring homalg_Weyl_1 = 0,(x,y,z,Dx,Dy,Dz),dp;\n\
def homalg_Weyl_2 = Weyl();\n\
setring homalg_Weyl_2;\n\
option(redTail);short=0;\n\
matrix homalg_Weyl_3[1][3] = 3*Dy-Dz,2*x,3*Dx+3*Dz;\n\
matrix homalg_Weyl_4 = nres(homalg_Weyl_3,2)[2];\n\
ncols(homalg_Weyl_4) == 2; kill homalg_Weyl_4; kill homalg_Weyl_3; kill homalg_Weyl_2; kill homalg_Weyl_1;\n\
// end: check the nres-isHomog-bug in Plural."
    , "need_output", S, "initialize" ) = "1" then;
    
        Unbind( RP!.ReducedSyzygiesGeneratorsOfRows );
        Unbind( RP!.ReducedSyzygiesGeneratorsOfColumns );
    fi;
    
    _Oscar_SetRing( S );
    
    ## there seems to exists a bug in Plural that occurs with mres(M,1)[1];
    Unbind( RP!.ReducedBasisOfRowModule );
    Unbind( RP!.ReducedBasisOfColumnModule );
    
    if not ( HasIsFieldForHomalg( r ) and IsFieldForHomalg( r ) ) then
        Unbind( RP!.IsUnit );
        Unbind( RP!.GetColumnIndependentUnitPositions );
        Unbind( RP!.GetRowIndependentUnitPositions );
        Unbind( RP!.GetUnitPosition );
    fi;
    
    if HasIsIntegersForHomalg( r ) and IsIntegersForHomalg( r ) then
        RP!.PrimaryDecomposition := RP!.PrimaryDecomposition_Z;
        RP!.RadicalSubobject := RP!.RadicalSubobject_Z;
        RP!.RadicalDecomposition := RP!.RadicalDecomposition_Z;
        Unbind( RP!.CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries );
        Unbind( RP!.MaximalDegreePart );
    fi;
    
    return S;
    
end );

##
InstallMethod( RingOfDerivations,
        "for homalg rings in Oscar",
        [ IsHomalgExternalRingInOscarRep, IsList, IsList ],
        
  function( R, indets, weights )
    local ar, r, var, der, param, stream, display_color, ext_obj, S, RP;
    
    ar := _PrepareInputForRingOfDerivations( R, indets );
    
    r := ar[1];
    var := ar[2];
    der := ar[3];
    param := ar[4];
    
    stream := homalgStream( R );
    
    if ( not ( IsBound( HOMALG_IO.show_banners ) and HOMALG_IO.show_banners = false )
         and not ( IsBound( stream.show_banner ) and stream.show_banner = false )
         and not ( IsBound( stream.show_banner_PLURAL ) and stream.show_banner_PLURAL = false ) ) then
        
        if IsBound( stream.color_display ) then
            display_color := stream.color_display;
        else
            display_color := "";
        fi;
        
        Print( "================================================================\n" );
        
        ## leave the below indentation untouched!
        Print( display_color, "\
                     SINGULAR::PLURAL\n\
The SINGULAR Subsystem for Non-commutative Polynomial Computations\n\
     by: G.-M. Greuel, V. Levandovskyy, H. Schoenemann\n\
FB Mathematik der Universitaet, D-67653 Kaiserslautern\033[0m\n\
================================================================\n" );
        
        stream.show_banner_PLURAL := false;
        
    fi;
    
    ## create the new ring in 2 steps: expand polynomial ring with derivatives and then
    ## add the Weyl-structure
    ## todo: this creates a block ordering with a new "dp"-block
    if HasIsIntegersForHomalg( r ) and IsIntegersForHomalg( r ) then
        ext_obj := homalgSendBlocking( [ "(integer", param,  "),(", var, der, "),(wp(", weights, "),c)" ], R, "initialize" );
    else
        ext_obj := homalgSendBlocking( [ "(", Characteristic( R ), param, "),(", var, der, "),(wp(", weights, "),c)" ], R, "initialize" );
    fi;
    
    ## as we are not yet done we cannot call CreateHomalgExternalRing
    ## to create a HomalgRing, and only then would homalgSendBlocking call stream.setring,
    ## so till then we have to prevent the garbage collector from stepping in
    stream.DeletePeriod_save := stream.DeletePeriod;
    stream.DeletePeriod := false;
    
    ext_obj := homalgSendBlocking( [ "Weyl();" ], TheTypeHomalgExternalRingObjectInOscar, ext_obj, "CreateHomalgRing" );
    
    ## this must precede CreateHomalgExternalRing as otherwise
    ## the definition of 0,1,-1 would precede "minpoly=";
    ## causing an error in the new Oscar
    if IsBound( r!.MinimalPolynomialOfPrimitiveElement ) then
        homalgSendBlocking( [ "minpoly=", r!.MinimalPolynomialOfPrimitiveElement ], "need_command", ext_obj, "define" );
    fi;
    
    S := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInOscar );
    
    ## now it is safe to call the garbage collector
    stream.DeletePeriod := stream.DeletePeriod_save;
    Unbind( stream.DeletePeriod_save );
    
    der := List( der , a -> HomalgExternalRingElement( a, S ) );
    
    Perform( der, Name );
    
    SetIsWeylRing( S, true );
    
    SetBaseRing( S, R );
    
    SetRingProperties( S, R, der );
    
    RP := homalgTable( S );
    
    RP!.SetInvolution :=
      function( R )
        homalgSendBlocking( Concatenation(
                [ "\nproc Involution (matrix M)\n{\n" ],
                [ "  map F = ", R, ", " ],
                [ JoinStringsWithSeparator( List( IndeterminateCoordinatesOfRingOfDerivations( R ), String ) ) ],
                Concatenation( List( IndeterminateDerivationsOfRingOfDerivations( R ), a -> [ ", -" , String( a ) ] ) ),
                [ ";\n  return( transpose( involution( M, F ) ) );\n}\n\n" ]
                ), "need_command", "define" );
    end;
    
    homalgStream( S ).setinvol( S );
    
    RP!.Compose :=
      function( A, B )
        
        # fix the broken design of Plural
        return homalgSendBlocking( [ "transpose( transpose(", A, ") * transpose(", B, ") )" ], [ "matrix" ], "Compose" );
        
    end;
    
    ## there exists a bug in Plural (3-0-4,3-1-0) that occurs with nres(M,2)[2];
    if homalgSendBlocking( "\n\
// start: check the nres-isHomog-bug in Plural:\n\
ring homalg_Weyl_1 = 0,(x,y,z,Dx,Dy,Dz),dp;\n\
def homalg_Weyl_2 = Weyl();\n\
setring homalg_Weyl_2;\n\
option(redTail);short=0;\n\
matrix homalg_Weyl_3[1][3] = 3*Dy-Dz,2*x,3*Dx+3*Dz;\n\
matrix homalg_Weyl_4 = nres(homalg_Weyl_3,2)[2];\n\
ncols(homalg_Weyl_4) == 2; kill homalg_Weyl_4; kill homalg_Weyl_3; kill homalg_Weyl_2; kill homalg_Weyl_1;\n\
// end: check the nres-isHomog-bug in Plural."
    , "need_output", S, "initialize" ) = "1" then;
    
        Unbind( RP!.ReducedSyzygiesGeneratorsOfRows );
        Unbind( RP!.ReducedSyzygiesGeneratorsOfColumns );
    fi;
    
    _Oscar_SetRing( S );
    
    ## there seems to exists a bug in Plural that occurs with mres(M,1)[1];
    Unbind( RP!.ReducedBasisOfRowModule );
    Unbind( RP!.ReducedBasisOfColumnModule );
    
    if not ( HasIsFieldForHomalg( r ) and IsFieldForHomalg( r ) ) then
        Unbind( RP!.IsUnit );
        Unbind( RP!.GetColumnIndependentUnitPositions );
        Unbind( RP!.GetRowIndependentUnitPositions );
        Unbind( RP!.GetUnitPosition );
    fi;
    
    if HasIsIntegersForHomalg( r ) and IsIntegersForHomalg( r ) then
        RP!.PrimaryDecomposition := RP!.PrimaryDecomposition_Z;
        RP!.RadicalSubobject := RP!.RadicalSubobject_Z;
        RP!.RadicalDecomposition := RP!.RadicalDecomposition_Z;
        Unbind( RP!.CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries );
        Unbind( RP!.MaximalDegreePart );
    fi;
    
    if 0 in weights then
        Unbind( RP!.IsUnit );
        Unbind( RP!.GetColumnIndependentUnitPositions );
        Unbind( RP!.GetRowIndependentUnitPositions );
        Unbind( RP!.GetUnitPosition );
    fi;
    
    RP!.MatrixOfSymbols := RP!.MatrixOfSymbols_workaround;
    
    return S;
    
end );

##
InstallMethod( ExteriorRing,
        "for homalg rings in Oscar",
        [ IsHomalgExternalRingInOscarRep, IsHomalgExternalRingInOscarRep, IsHomalgExternalRingInOscarRep, IsList ],
        
  function( R, Coeff, Base, indets )
    local ar, r, param, var, anti, comm, stream, display_color, ext_obj, S, RP;
    
    ar := _PrepareInputForExteriorRing( R, Base, indets );
    
    r := ar[1];
    param := ar[2];
    var := ar[3];
    anti := ar[4];
    comm := ar[5];
    
    stream := homalgStream( R );
    
    if ( not ( IsBound( HOMALG_IO.show_banners ) and HOMALG_IO.show_banners = false )
         and not ( IsBound( stream.show_banner ) and stream.show_banner = false )
         and not ( IsBound( stream.show_banner_SCA ) and stream.show_banner_SCA = false ) ) then
        
        if IsBound( stream.color_display ) then
            display_color := stream.color_display;
        else
            display_color := "";
        fi;
        
        Print( "================================================================\n" );
        
        ## leave the below indentation untouched!
        Print( display_color, "\
                     SINGULAR::SCA\n\
The SINGULAR Subsystem for Super-Commutative Algebras\n\
     by: G.-M. Greuel, O. Motsak, H. Schoenemann\n\
FB Mathematik der Universitaet, D-67653 Kaiserslautern\033[0m\n\
================================================================\n" );
        
        stream.show_banner_SCA := false;
        
    fi;
    
    ## create the new ring in 2 steps: create a polynomial ring with anti commuting and commuting variables and then
    ## add the exterior structure
    ext_obj := homalgSendBlocking( [ "(", Characteristic( R ), param, "),(", Concatenation( comm, anti ), "),(dp,C)" ], R, "initialize" );
    
    ## as we are not yet done we cannot call CreateHomalgExternalRing
    ## to create a HomalgRing, and only then would homalgSendBlocking call stream.setring,
    ## so till then we have to prevent the garbage collector from stepping in
    stream.DeletePeriod_save := stream.DeletePeriod;
    stream.DeletePeriod := false;
    
    ext_obj := homalgSendBlocking( [ "superCommutative_ForHomalg(", Length( comm ) + 1, ");" ], TheTypeHomalgExternalRingObjectInOscar, ext_obj, "CreateHomalgRing" );
    
    ## this must precede CreateHomalgExternalRing as otherwise
    ## the definition of 0,1,-1 would precede "minpoly=";
    ## causing an error in the new Oscar
    if IsBound( r!.MinimalPolynomialOfPrimitiveElement ) then
        homalgSendBlocking( [ "minpoly=", r!.MinimalPolynomialOfPrimitiveElement ], "need_command", ext_obj, "define" );
    fi;
    
    S := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInOscar );
    
    ## now it is safe to call the garbage collector
    stream.DeletePeriod := stream.DeletePeriod_save;
    Unbind( stream.DeletePeriod_save );
    
    anti := List( anti , a -> HomalgExternalRingElement( a, S ) );
    
    Perform( anti, Name );
    
    comm := List( comm , a -> HomalgExternalRingElement( a, S ) );
    
    Perform( comm, Name );
    
    SetIsExteriorRing( S, true );
    
    SetBaseRing( S, Base );
    
    SetRingProperties( S, R, anti );
    
    homalgSendBlocking( "option(redTail);option(redSB);", "need_command", stream, "initialize" );
    
    RP := homalgTable( S );
    
    RP!.SetInvolution :=
      function( R )
        homalgSendBlocking( Concatenation(
                [ "\nproc Involution (matrix M)\n{\n" ],
                [ "  map F = ", R ],
                Concatenation( List( IndeterminatesOfExteriorRing( R ), a -> [ ", ", String( a ) ] ) ),
                [ ";\n  return( transpose( involution( M, F ) ) );\n}\n\n" ]
                ), "need_command", "define" );
    end;
    
    homalgStream( S ).setinvol( S );
    
    RP!.Compose :=
      function( A, B )
        
        # fix the broken design of SCA
        return homalgSendBlocking( [ "transpose( transpose(", A, ") * transpose(", B, ") )" ], [ "matrix" ], "Compose" );
        
    end;
    
    if not ( HasIsFieldForHomalg( r ) and IsFieldForHomalg( r ) ) then
        Unbind( RP!.IsUnit );
        Unbind( RP!.GetColumnIndependentUnitPositions );
        Unbind( RP!.GetRowIndependentUnitPositions );
        Unbind( RP!.GetUnitPosition );
    fi;
    
    if HasIsIntegersForHomalg( r ) and IsIntegersForHomalg( r ) then
        RP!.PrimaryDecomposition := RP!.PrimaryDecomposition_Z;
        RP!.RadicalSubobject := RP!.RadicalSubobject_Z;
        RP!.RadicalDecomposition := RP!.RadicalDecomposition_Z;
        Unbind( RP!.CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries );
        Unbind( RP!.MaximalDegreePart );
    fi;
    
    return S;
    
end );

##
InstallMethod( PseudoDoubleShiftAlgebra,
        "for homalg rings in Oscar",
        [ IsHomalgExternalRingInOscarRep, IsList ],
        
  function( R, indets )
    local ar, r, var, shift, param, base, stream, display_color, switch, ext_obj,
          b, n, steps, pairs, d, P, RP, Ds, D_s, S, B, T, Y;
    
    ar := _PrepareInputForPseudoDoubleShiftAlgebra( R, indets );
    
    r := ar[1];
    var := ar[2];
    shift := ar[3];
    param := ar[4];
    base := ar[5];
    
    stream := homalgStream( R );
    
    if ( not ( IsBound( HOMALG_IO.show_banners ) and HOMALG_IO.show_banners = false )
         and not ( IsBound( stream.show_banner ) and stream.show_banner = false )
         and not ( IsBound( stream.show_banner_PLURAL ) and stream.show_banner_PLURAL = false ) ) then
        
        if IsBound( stream.color_display ) then
            display_color := stream.color_display;
        else
            display_color := "";
        fi;
        
        Print( "================================================================\n" );
        
        ## leave the below indentation untouched!
        Print( display_color, "\
                     SINGULAR::PLURAL\n\
The SINGULAR Subsystem for Non-commutative Polynomial Computations\n\
     by: G.-M. Greuel, V. Levandovskyy, H. Schoenemann\n\
FB Mathematik der Universitaet, D-67653 Kaiserslautern\033[0m\n\
================================================================\n" );
        
        stream.show_banner_PLURAL := false;
        
    fi;
    
    switch := ValueOption( "switch" );
    
    ## create the new ring in 2 steps: expand polynomial ring with shifts and then
    ## add the shift-structure
    ## todo: this creates a block ordering with a new "dp"-block
    
    if IsIdenticalObj( switch, true ) then
        
        if HasIsIntegersForHomalg( r ) and IsIntegersForHomalg( r ) then
            if base <> "" then
                #ext_obj := homalgSendBlocking( [ "(integer", param,  "),(", base, shift, var, "),(dp(", Length( base ), "),dp,C)" ], R, "initialize" );
                ext_obj := homalgSendBlocking( [ "(integer", param,  "),(", base, shift, var, "),(dp,C)" ], R, "initialize" );
            else
                ext_obj := homalgSendBlocking( [ "(integer", param,  "),(", shift, var, "),(dp,C)" ], R, "initialize" );
            fi;
        else
            if base <> "" then
                #ext_obj := homalgSendBlocking( [ "(", Characteristic( R ), param, "),(", base, shift, var, "),(dp(", Length( base ), "),dp,C)" ], R, "initialize" );
                ext_obj := homalgSendBlocking( [ "(", Characteristic( R ), param, "),(", base, shift, var, "),(dp,C)" ], R, "initialize" );
            else
                ext_obj := homalgSendBlocking( [ "(", Characteristic( R ), param, "),(", shift, var, "),(dp,C)" ], R, "initialize" );
            fi;
        fi;
        
    else
        
        if HasIsIntegersForHomalg( r ) and IsIntegersForHomalg( r ) then
            if base <> "" then
                #ext_obj := homalgSendBlocking( [ "(integer", param,  "),(", base, var, shift, "),(dp(", Length( base ), "),dp,C)" ], R, "initialize" );
                ext_obj := homalgSendBlocking( [ "(integer", param,  "),(", base, var, shift, "),(dp,C)" ], R, "initialize" );
            else
                ext_obj := homalgSendBlocking( [ "(integer", param,  "),(", var, shift, "),(dp,C)" ], R, "initialize" );
            fi;
        else
            if base <> "" then
                #ext_obj := homalgSendBlocking( [ "(", Characteristic( R ), param, "),(", base, var, shift, "),(dp(", Length( base ), "),dp,C)" ], R, "initialize" );
                ext_obj := homalgSendBlocking( [ "(", Characteristic( R ), param, "),(", base, var, shift, "),(dp,C)" ], R, "initialize" );
            else
                ext_obj := homalgSendBlocking( [ "(", Characteristic( R ), param, "),(", var, shift, "),(dp,C)" ], R, "initialize" );
            fi;
        fi;
        
    fi;
    
    ## as we are not yet done we cannot call CreateHomalgExternalRing
    ## to create a HomalgRing, and only then would homalgSendBlocking call stream.setring,
    ## so till then we have to prevent the garbage collector from stepping in
    stream.DeletePeriod_save := stream.DeletePeriod;
    stream.DeletePeriod := false;
    
    b := Length( base );
    n := b + Length( var ) + Length( shift );
    
    homalgSendBlocking( [ "matrix @d[", n, "][", n, "]" ], "need_command", ext_obj, "initialize" );
    
    n := Length( shift ) / 2;
    
    steps := ValueOption( "steps" );
    
    if IsRat( steps ) then
        steps := ListWithIdenticalEntries( n, steps );
    elif not ( IsList( steps ) and Length( steps ) = n and ForAll( steps, IsRat ) ) then
        steps := ListWithIdenticalEntries( n, 1 );
    fi;
    
    pairs := ValueOption( "pairs" );
    
    if IsIdenticalObj( switch, true ) then
        
        if IsIdenticalObj( pairs, true ) then
            d := Concatenation(
                         List( [ 1 .. n ],
                               i -> Concatenation( "@d[", String( b + ( 2 * i - 1 ) ), ",", String( b + 2 * n + i ), "] = -(", String( steps[i] ), ") * ", shift[2 * i - 1] ) ),
                         List( [ 1 .. n ],
                               i -> Concatenation( "@d[", String( b + ( 2 * i ) ), ",", String( b + 2 * n + i ), "] = (", String( steps[i] ), ") * ", shift[2 * i] ) ) );
        else
            d := Concatenation(
                         List( [ 1 .. n ],
                               i -> Concatenation( "@d[", String( b + ( i ) ), ",", String( b + 2 * n + i ), "] = -(", String( steps[i] ), ") * ", shift[i] ) ),
                         List( [ 1 .. n ],
                               i -> Concatenation( "@d[", String( b + ( n + i ) ), ",", String( b + 2 * n + i ), "] = (", String( steps[i] ), ") * ", shift[n + i] ) ) );
        fi;
        
    else
        
        if IsIdenticalObj( pairs, true ) then
            d := Concatenation(
                         List( [ 1 .. n ],
                               i -> Concatenation( "@d[", String( b + i ), ",", String( b + n + ( 2 * i - 1 ) ), "] = (", String( steps[i] ), ") * ", shift[2 * i - 1] ) ),
                         List( [ 1 .. n ],
                               i -> Concatenation( "@d[", String( b + i ), ",", String( b + n + ( 2 * i ) ), "] = -(", String( steps[i] ), ") * ", shift[2 * i] ) ) );
        else
            d := Concatenation(
                         List( [ 1 .. n ],
                               i -> Concatenation( "@d[", String( b + i ), ",", String( b + n + ( i ) ), "] = (", String( steps[i] ), ") * ", shift[i] ) ),
                         List( [ 1 .. n ],
                               i -> Concatenation( "@d[", String( b + i ), ",", String( b + n + ( n + i ) ), "] = -(", String( steps[i] ), ") * ", shift[n + i] ) ) );
        fi;
        
    fi;
    
    homalgSendBlocking( JoinStringsWithSeparator( d, "; " ), "need_command", ext_obj, "initialize" );
    
    ext_obj := homalgSendBlocking( [ "nc_algebra(1,@d)" ], TheTypeHomalgExternalRingObjectInOscar, ext_obj, "CreateHomalgRing" );
    
    ## this must precede CreateHomalgExternalRing as otherwise
    ## the definition of 0,1,-1 would precede "minpoly=";
    ## causing an error in the new Oscar
    if IsBound( r!.MinimalPolynomialOfPrimitiveElement ) then
        homalgSendBlocking( [ "minpoly=", r!.MinimalPolynomialOfPrimitiveElement ], "need_command", ext_obj, "define" );
    fi;
    
    P := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInOscar );
    
    ## now it is safe to call the garbage collector
    stream.DeletePeriod := stream.DeletePeriod_save;
    Unbind( stream.DeletePeriod_save );
    
    var := List( var , a -> HomalgExternalRingElement( a, P ) );
    
    Perform( var, Name );
    
    shift := List( shift , a -> HomalgExternalRingElement( a, P ) );
    
    Perform( shift, Name );
    
    SetIsPseudoDoubleShiftAlgebra( P, true );
    
    SetBaseRing( P, R );
    
    SetRingProperties( P, R, shift );
    
    RP := homalgTable( P );
    
    RP!.SetInvolution :=
      function( R )
        homalgSendBlocking( Concatenation(
                [ "\nproc Involution (matrix M)\n{\n" ],
                [ "  map F = ", R, ", " ],
                Concatenation( List( IndeterminateCoordinatesOfPseudoDoubleShiftAlgebra( R ), a -> [ "-" , String( a ), ", " ] ) ),
                [ JoinStringsWithSeparator( List( IndeterminateShiftsOfPseudoDoubleShiftAlgebra( R ), String ), ", " ) ],
                [ ";\n  return( transpose( involution( M, F ) ) );\n}\n\n" ]
                ), "need_command", "define" );
    end;
    
    homalgStream( P ).setinvol( P );
    
    RP!.Compose :=
      function( A, B )
        
        # fix the broken design of Plural
        return homalgSendBlocking( [ "transpose( transpose(", A, ") * transpose(", B, ") )" ], [ "matrix" ], "Compose" );
        
    end;
    
    ## there exists a bug in Plural (3-0-4,3-1-0) that occurs with nres(M,2)[2];
    if homalgSendBlocking( "\n\
// start: check the nres-isHomog-bug in Plural:\n\
ring homalg_Weyl_1 = 0,(x,y,z,Dx,Dy,Dz),dp;\n\
def homalg_Weyl_2 = Weyl();\n\
setring homalg_Weyl_2;\n\
option(redTail);short=0;\n\
matrix homalg_Weyl_3[1][3] = 3*Dy-Dz,2*x,3*Dx+3*Dz;\n\
matrix homalg_Weyl_4 = nres(homalg_Weyl_3,2)[2];\n\
ncols(homalg_Weyl_4) == 2; kill homalg_Weyl_4; kill homalg_Weyl_3; kill homalg_Weyl_2; kill homalg_Weyl_1;\n\
// end: check the nres-isHomog-bug in Plural."
    , "need_output", P, "initialize" ) = "1" then;
    
        Unbind( RP!.ReducedSyzygiesGeneratorsOfRows );
        Unbind( RP!.ReducedSyzygiesGeneratorsOfColumns );
    fi;
    
    _Oscar_SetRing( P );
    
    ## there seems to exists a bug in Plural that occurs with mres(M,1)[1];
    Unbind( RP!.ReducedBasisOfRowModule );
    Unbind( RP!.ReducedBasisOfColumnModule );
    
    if not ( HasIsFieldForHomalg( r ) and IsFieldForHomalg( r ) ) then
        Unbind( RP!.IsUnit );
        Unbind( RP!.GetColumnIndependentUnitPositions );
        Unbind( RP!.GetRowIndependentUnitPositions );
        Unbind( RP!.GetUnitPosition );
    fi;
    
    if HasIsIntegersForHomalg( r ) and IsIntegersForHomalg( r ) then
        RP!.PrimaryDecomposition := RP!.PrimaryDecomposition_Z;
        RP!.RadicalSubobject := RP!.RadicalSubobject_Z;
        RP!.RadicalDecomposition := RP!.RadicalDecomposition_Z;
        Unbind( RP!.CoefficientsOfUnreducedNumeratorOfWeightedHilbertPoincareSeries );
        Unbind( RP!.MaximalDegreePart );
    fi;
    
    shift := List( shift, String );
    
    if IsIdenticalObj( pairs, true ) then
        Ds := shift{List( [ 1 .. n ], i -> 2 * i - 1 )};
        D_s := shift{List( [ 1 .. n ], i -> 2 * i )};
    else
        Ds := shift{[ 1 .. n ]};
        D_s := shift{[ n + 1 .. 2 * n ]};
    fi;
    
    ## the "commutative" double-shift algebra
    S := R * shift;
    
    ## does not reduce elements instantaneously
    ## S := HomalgQRingInOscar( AmbientRing( S ), RingRelations( S ) );
    
    P!.CommutativeDoubleShiftAlgebra := S / ListN( Ds, D_s, {d, d_} -> ( d / S ) * ( d_ / S ) - 1 );

    ## the Laurent algebra
    B := BaseRing( R );
    
    T := B * shift;
    
    P!.LaurentAlgebra := T / ListN( Ds, D_s, {d, d_} -> ( d / T ) * ( d_ / T ) - 1 );
    
    ## the double-shift algebra
    Y := P / ListN( Ds, D_s, {d, d_} -> ( d / P ) * ( d_ / P ) - 1 );
    
    Y!.CommutativeDoubleShiftAlgebra := P!.CommutativeDoubleShiftAlgebra;
    Y!.LaurentAlgebra := P!.LaurentAlgebra;
    
    SetBaseRing( Y, BaseRing( P ) );
    
    SetIndeterminateCoordinatesOfDoubleShiftAlgebra( Y,
            List( IndeterminateCoordinatesOfPseudoDoubleShiftAlgebra( P ), d -> d / Y ) );

    if HasRelativeIndeterminateCoordinatesOfPseudoDoubleShiftAlgebra( P ) then
        
        SetRelativeIndeterminateCoordinatesOfDoubleShiftAlgebra( Y,
                List( RelativeIndeterminateCoordinatesOfPseudoDoubleShiftAlgebra( P ), d -> d / Y ) );
    fi;
    
    SetIndeterminateShiftsOfDoubleShiftAlgebra( Y,
            List( IndeterminateShiftsOfPseudoDoubleShiftAlgebra( P ), d -> d / Y ) );
    
    P!.DoubleShiftAlgebra := Y;
    
    if not IsIdenticalObj( switch, true ) then
        P!.SwitchedPseudoDoubleShiftAlgebra := PseudoDoubleShiftAlgebra( R, indets : switch := true );
    fi;
    
    return P;
    
end );

##
InstallMethod( DoubleShiftAlgebra,
        "for homalg rings in Oscar",
        [ IsHomalgExternalRingInOscarRep, IsList ],
        
  function( R, indets )
    local P;
    
    P := PseudoDoubleShiftAlgebra( R, indets );
    
    return P!.DoubleShiftAlgebra;
    
end );

##
InstallMethod( HomalgQRingInOscar,
        "for a homalg ring in Oscar and ring relations",
        [ IsHomalgExternalRingInOscarRep and IsFreePolynomialRing, IsHomalgRingRelations ],
        
  function( R, ring_rel )
    local r, stream, ideal, ext_obj, S, RP;
    
    r := CoefficientsRing( R );
    
    if not ( HasIsFieldForHomalg( r ) and IsFieldForHomalg( r ) ) then
        Error( "Oscar qrings are currently only supported over fields" );
    fi;
    
    stream := homalgStream( R );
    
    ideal := EntriesOfHomalgMatrix( EvaluatedMatrixOfRingRelations( ring_rel ) );
    
    ext_obj := homalgSendBlocking( [ "std(ideal(", ideal, "))" ], [ "qring" ], TheTypeHomalgExternalRingObjectInOscar, R, "CreateHomalgRing" );
    
    ## this must precede CreateHomalgExternalRing as otherwise
    ## the definition of 0,1,-1 would precede "minpoly=";
    ## causing an error in the new Oscar
    if IsBound( r!.MinimalPolynomialOfPrimitiveElement ) then
        homalgSendBlocking( [ "minpoly=", r!.MinimalPolynomialOfPrimitiveElement ], "need_command", ext_obj, "define" );
    fi;
    
    S := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInOscar );
    
    ## for the view methods:
    ## <A Oscar q ring>
    ## <A matrix over an Oscar q ring>
    S!.description := " Oscar q";
    
    SetAmbientRing( S, R );
    
    SetRingRelations( S, ring_rel );
    
    homalgSendBlocking( "option(redTail);option(redSB);", "need_command", stream, "initialize" );
    
    RP := homalgTable( S );
    
    # taken from ResidueClassRingForHomalg.gi
    RP!.RingName :=
      function( R )
        local ring_rel, entries, name;
        
        ring_rel := MatrixOfRelations( R );
        
        if IsBound( ring_rel!.BasisOfRowModule ) then
            ring_rel := ring_rel!.BasisOfRowModule;
        elif IsBound( ring_rel!.BasisOfColumnModule ) then
            ring_rel := ring_rel!.BasisOfColumnModule;
        fi;
        
        if not IsBound( ring_rel!.StringOfEntriesForRingName ) then
            
            entries := EntriesOfHomalgMatrix( ring_rel );
            
            if entries = [ ] then
                entries := "0";
            elif IsHomalgInternalRingRep( AmbientRing( R ) ) then
                entries := JoinStringsWithSeparator( List( entries, String ), ", " );
            else
                entries := JoinStringsWithSeparator( List( entries, Name ), ", " );
            fi;
            
            name := RingName( AmbientRing( R ) );
            
            ring_rel!.StringOfEntries := String( Concatenation( "[ ", entries, " ]" ) );
            ring_rel!.StringOfEntriesForRingName := String( Concatenation( name, "/( ", entries, " )" ) );
            
        fi;
        
        return ring_rel!.StringOfEntriesForRingName;
        
    end;

    RP!.SetInvolution :=
      function( R )
        homalgSendBlocking( "\nproc Involution (matrix m)\n{\n  return(transpose(m));\n}\n\n", "need_command", R, "define" );
    end;
    
    homalgStream( S ).setinvol( S );
    
    RP!.IsZero := r -> homalgSendBlocking( [ "reduce(", r, ",std(0))==0" ] , "need_output", "IsZero" ) = "1";
    
    RP!.IsOne := r -> homalgSendBlocking( [ "reduce(", r, ",std(0))==1" ] , "need_output", "IsOne" ) = "1";
    
    RP!.AreEqualMatrices :=
      function( A, B )
        
        return homalgSendBlocking( [ "matrix(reduce(", A, ",std(0))) == matrix(reduce(", B, ",std(0)))" ] , "need_output", "AreEqualMatrices" ) = "1";
        
    end;
    
    # taken from ResidueClassRingForHomalg.gi
    SetIndeterminatesOfPolynomialRing( S, List( IndeterminatesOfPolynomialRing( R ), r -> r / S ) );
    
    return S;
    
end );

##
InstallMethod( HomalgQRingInOscar,
        [ IsHomalgExternalRingInOscarRep and IsFreePolynomialRing, IsHomalgMatrix ],
        
  function( R, ring_rel )
    
    if NumberRows( ring_rel ) = 0 or NumberColumns( ring_rel ) = 0  then
        return R;
    elif NumberColumns( ring_rel ) = 1 then
        return HomalgQRingInOscar( R, HomalgRingRelationsAsGeneratorsOfLeftIdeal( ring_rel ) );
    elif NumberRows( ring_rel ) = 1 then
        return HomalgQRingInOscar( R, HomalgRingRelationsAsGeneratorsOfRightIdeal( ring_rel ) );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( HomalgQRingInOscar,
        [ IsHomalgExternalRingInOscarRep and IsFreePolynomialRing, IsList ],
        
  function( R, ring_rel )
    
    if ForAll( ring_rel, IsString ) then
        return HomalgQRingInOscar( R, List( ring_rel, s -> HomalgRingElement( s, R ) ) );
    elif not ForAll( ring_rel, IsRingElement ) then
        TryNextMethod( );
    fi;
    
    return HomalgQRingInOscar( R, HomalgMatrix( ring_rel, Length( ring_rel ), 1, R ) );
    
end );

##
InstallMethod( HomalgQRingInOscar,
        [ IsHomalgExternalRingInOscarRep and IsFreePolynomialRing, IsRingElement ],
        
  function( R, ring_rel )
    
    return HomalgQRingInOscar( R, [ ring_rel ] );
    
end );

##
InstallMethod( HomalgQRingInOscar,
        [ IsHomalgExternalRingInOscarRep and IsFreePolynomialRing, IsString ],
        
  function( R, ring_rel )
    
    return HomalgQRingInOscar( R, HomalgRingElement( ring_rel, R ) );
    
end );

##
InstallMethod( AddRationalParameters,
        "for Oscar rings",
        [ IsHomalgExternalRingInOscarRep and IsFieldForHomalg, IsList ],
        
  function( R, param )
    local c, par;
    
    if IsString( param ) then
        param := [ param ];
    fi;
    
    param := List( param, String );
    
    c := Characteristic( R );
    
    if HasRationalParameters( R ) then
        par := RationalParameters( R );
        par := List( par, String );
    else
        par := [ ];
    fi;
    
    par := Concatenation( par, param );
    par := JoinStringsWithSeparator( par );
    
    ## TODO: take care of the rest
    if c = 0 then
        return HomalgFieldOfRationalsInOscar( par, R );
    fi;
    
    return HomalgRingOfIntegersInOscar( c, par, R );
    
end );

##
InstallMethod( AddRationalParameters,
        "for Oscar rings",
        [ IsHomalgExternalRingInOscarRep and IsFreePolynomialRing, IsList ],
        
  function( R, param )
    local c, par, indets, r;
    
    if IsString( param ) then
        param := [ param ];
    fi;
    
    param := List( param, String );
    
    c := Characteristic( R );
    
    if HasRationalParameters( R ) then
        par := RationalParameters( R );
        par := List( par, String );
    else
        par := [ ];
    fi;
    
    par := Concatenation( par, param );
    par := JoinStringsWithSeparator( par );
    
    indets := Indeterminates( R );
    indets := List( indets, String );
    
    r := CoefficientsRing( R );
    
    if not IsFieldForHomalg( r ) then
        Error( "the coefficients ring is not a field\n" );
    fi;
    
    ## TODO: take care of the rest
    if c = 0 then
        return HomalgFieldOfRationalsInOscar( par, r ) * indets;
    fi;
    
    return HomalgRingOfIntegersInOscar( c, par, r ) * indets;
    
end );

##
InstallMethod( SetMatElm,
        "for homalg external matrices in Oscar",
        [ IsHomalgExternalMatrixRep and IsMutable, IsPosInt, IsPosInt, IsString, IsHomalgExternalRingInOscarRep ],
        
  function( M, r, c, s, R )
    
    homalgSendBlocking( [ M, "[", c, r, "]=", s ], "need_command", "SetMatElm" );
    
end );

##
InstallMethod( AddToMatElm,
        "for homalg external matrices in Oscar",
        [ IsHomalgExternalMatrixRep and IsMutable, IsPosInt, IsPosInt, IsHomalgExternalRingElementRep, IsHomalgExternalRingInOscarRep ],
        
  function( M, r, c, a, R )
    
    homalgSendBlocking( [ M, "[", c, r, "]=", a, "+", M, "[", c, r, "]" ], "need_command", "AddToMatElm" );
    
end );

##
InstallMethod( CreateHomalgMatrixFromString,
        "constructor for homalg external matrices in Oscar",
        [ IsString, IsHomalgExternalRingInOscarRep ],
        
  function( s, R )
    local r, c;
    
    r := Length( Positions( s, '[' ) ) - 1;
    
    c := ( Length( Positions( s, ',' ) ) + 1 ) / r;
    
    return CreateHomalgMatrixFromString( s, r, c, R );
    
end );

##
InstallMethod( CreateHomalgMatrixFromString,
        "constructor for homalg external matrices in Oscar",
        [ IsString, IsInt, IsInt, IsHomalgExternalRingInOscarRep ],
        
  function( s, r, c, R )
    local str, ext_obj;
    
    str := ShallowCopy( s );
    
    RemoveCharacters( str, "[]" );
    
    ext_obj := homalgSendBlocking( [ "MatrixForHomalg(", R, r, c, ", [", str, "])" ], "HomalgMatrix" );
    
    if not ( r = 1 and c = 1 ) then
        homalgSendBlocking( [ ext_obj, " = transpose(", ext_obj, ")" ], "need_command", "TransposedMatrix" );
    fi;
    
    return HomalgMatrix( ext_obj, r, c, R );
    
end );

##
InstallMethod( MatElmAsString,
        "for homalg external matrices in Oscar",
        [ IsHomalgExternalMatrixRep, IsPosInt, IsPosInt, IsHomalgExternalRingInOscarRep ],
        
  function( M, r, c, R )
    
    return homalgSendBlocking( [ M, "[", c, r, "]" ], "need_output", "MatElm" );
    
end );

##
InstallMethod( MatElm,
        "for homalg external matrices in Oscar",
        [ IsHomalgExternalMatrixRep, IsPosInt, IsPosInt, IsHomalgExternalRingInOscarRep ],
        
  function( M, r, c, R )
    local Mrc;
    
    Mrc := homalgSendBlocking( [ M, "[", c, r, "]" ], "MatElm" );
    
    return HomalgExternalRingElement( Mrc, R );
    
end );

####################################
#
# transfer methods:
#
####################################

##
InstallMethod( GetListOfHomalgMatrixAsString,
        "for homalg external matrices in Oscar",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInOscarRep ],
        
  function( M, R )
    
    return homalgSendBlocking( [ "\"[\"+string(transpose(", M, "))+\"]\"" ], "need_output", "GetListOfHomalgMatrixAsString" );
    #remark: matrices are saved transposed in singular
    
end );

##
InstallMethod( GetListListOfHomalgMatrixAsString,
        "for homalg external matrices in Oscar",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInOscarRep ],
        
  function( M, R )
    local v, command;
    
    v := homalgStream( R ).variable_name;
    
    command := [
                "matrix ", v, "m[", NumberColumns( M ),"][1]; ",
                v, "s=\"[\"; ",
                "for(int i=1;i<=", NumberRows( M ), ";i++){",
                v, "m=", M, "[1..", NumberColumns( M ), ",i]; ", ## matrices are saved transposed in Oscar
                "if(i!=1){", v, "s=", v, "s+\",\";}; ",
                v, "s=", v, "s+\"[\"+string(", v, "m)+\"]\";}; ",
                v, "s=", v, "s+\"]\"; kill ", v, "m"
                ];
    
    homalgSendBlocking( command, "need_command", "GetListListOfHomalgMatrixAsString" );
    
    return homalgSendBlocking( [ v, "s; ", v, "s=\"\"" ], "need_output", R, "GetListListOfHomalgMatrixAsString" );
    
end );

##
InstallMethod( GetSparseListOfHomalgMatrixAsString,
        "for homalg external matrices in Oscar",
        [ IsHomalgExternalMatrixRep, IsHomalgExternalRingInOscarRep ],
        
  function( M, R )
    local s;
    
    s := homalgSendBlocking( [ "GetSparseListOfHomalgMatrixAsString(", M, ")" ], "need_output", "GetSparseListOfHomalgMatrixAsString" );
    
    s := SplitString( s, "," );
    
    s := ListToListList( s, Length( s ) / 3, 3 );
    
    s := JoinStringsWithSeparator( List( s, JoinStringsWithSeparator ), "],[" );
    
    return Concatenation( "[[", s, "]]" );
    
end );

##
InstallMethod( SaveHomalgMatrixToFile,
        "for homalg external matrices in Oscar",
        [ IsString, IsHomalgMatrix, IsHomalgExternalRingInOscarRep ],
        
  function( filename, M, R )
    local mode, v, command;
    
    if not IsBound( M!.SaveAs ) then
        mode := "ListList";
    else
        mode := M!.SaveAs; #not yet supported
    fi;
    
    if mode = "ListList" then
        
        command := [ "write(\"", filename, "\", \"", String( EntriesOfHomalgMatrixAsListList( M ) ), "\")" ]; ## matrices are saved transposed in Oscar
        
        homalgSendBlocking( command, HomalgRing( M ), "need_command", "SaveHomalgMatrixToFile" );
        
    fi;
    
    return true;
    
end );

##
InstallMethod( LoadHomalgMatrixFromFile,
        "for homalg external rings in Oscar",
        [ IsString, IsInt, IsInt, IsHomalgExternalRingInOscarRep ],
        
  function( filename, r, c, R )
    local mode, v, command, M;
    
    if not IsBound( R!.LoadAs ) then
        mode := "ListList";
    else
        mode := R!.LoadAs; #not yet supported
    fi;
    
    M := HomalgVoidMatrix( R );
    
    if mode = "ListList" then
        
        v := homalgStream( R ).variable_name;
        
        command := [
                    v, "s=read(\"", filename, "\", String); ",
                    v, "r=[]; for i = split(", v, "s, r\"[\\[,\\]\\n\\r\]+\"); if length(i)>0; push!(", v, "r, eval(Meta.parse(replace(i, \"\/\" => \"\/\/\")))); end; end; ",
                    M, "=Involution(MatrixForHomalg(", R, r, c, ", ", v, "r)); ", ## matrices are saved transposed in Oscar
                    v, "s=\"\"; ", v, "r=\"\"",
                    ];
        
        homalgSendBlocking( command, "need_command", "LoadHomalgMatrixFromFile" );
        
    fi;
    
    SetNumberRows( M, r );
    SetNumberColumns( M, c );
    
    return M;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

## TODO: Workaround. Delete once https://github.com/oscar-system/Singular.jl/pull/323 is merged
InstallMethod( homalgSetName,
        "for homalg external ring elements",
        [ IsHomalgExternalRingElementRep, IsString, IsHomalgExternalRingInOscarRep ],

  function( r, name, R )
    
    name := homalgSendBlocking( [ r ], "need_output", "homalgSetName" );

    if Length( name ) > 1 and name{[ 1, 2 ]} = "1*" then
        name := name{[ 3 .. Length( name ) ]};
    fi;
    
    SetName( r, name );
    
end );

##
InstallMethod( Display,
        "for homalg external matrices in Oscar",
        [ IsHomalgExternalMatrixRep ], 1,
        
  function( o )
    
    if IsHomalgExternalRingInOscarRep( HomalgRing( o ) ) then
        
        Print( homalgSendBlocking( [ "transpose(", o, ")" ], "need_display", "Display" ) );
        
    else
        
        TryNextMethod( );
        
    fi;
    
end );

##
InstallMethod( DisplayRing,
        "for homalg rings in Oscar",
        [ IsHomalgExternalRingInOscarRep ], 1,
        
  function( o )
    
    homalgDisplay( [ o ] );
    
end );
