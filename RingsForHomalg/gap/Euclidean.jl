





## This is an implemention using the Julia package AbstractAlgebra of part of the paper
## CYCLOTOMIC RINGS WITH SIMPLE EUCLIDEAN ALGORITHM
## NORBERT KAIBLINGER
## https://homepage.boku.ac.at/kaiblinger/pub/kaib_simeucalg.pdf

using Hecke

function RingOfCyclotomicIntegers( n )
    K, z = CyclotomicField(n)
    R = maximal_order(K)
    R, R(z)
end

function RingOfGoldenRatioIntegers( )
    Qx, x = QQ["x"]
    K, z = NumberField(x^2-x-1, "z")
    R = maximal_order(K)
    K.auxilliary_data[1] = Dict{Symbol,Any}(:golden => true)
    R, R(z)
end

function divrem(b::NfOrdElem, a::NfOrdElem)
    divrem(b, a, discriminant(parent(a)))
end

function divrem(b::NfOrdElem, a::NfOrdElem, d::fmpz) ## d is the discriminant

    R = parent(a)
    C = number_field(R)

    n = get(C.auxilliary_data[1], :cyclo, false)

    g = get(C.auxilliary_data[1], :golden, false )

    if n == false && g == false
        error("the number field was not created by CyclotomicField or RingOfGoldenRatio")
    end

    if g
        ## the ring of golden ration integers
    elseif d == 1 ## n = 1, 2
        bound = 1/2
    elseif d == -3 ## n = 3, 6
        bound = 3/8 ## a, b = 27 * z + 14, 63 * z + 24 contradicts this bound
    elseif d == -4 ## n = 4
        bound = 1/2
    elseif d == 256 ## n = 8
        bound = 9/16
    elseif d == 144 ## n = 12
        bound = 225/256
    else
        error("this ring of cyclotomic integers is not a 1-step norm-Euclidean")
    end

    q = C(b) // C(a)

    h = Hecke.QQ(1//2)

    bas = R.basis_nf

    vx = map(c -> C(floor(c + h)), coefficients(C(q)))
    x = dot(vx, bas)

    if norm(q - x) >= 1
        println(q)
        println(x)
        println(norm(q - x))
        println(bound)
        error("wrong approximation")
    end

    x = R(x)

    x, b - x * a

end

## the code below is taken from GaussIntegers.jl

# From divrem, we get all the other division functions
function Base.mod(x::NfOrdElem, y::NfOrdElem)
  divrem(x, y)[2]
end

function Base.div(x::NfOrdElem, y::NfOrdElem)
  divrem(x, y)[1]
end

# Wikipedia pseudo code for gcd
function Base.gcd(x::NfOrdElem, y::NfOrdElem)
  while !iszero(y)
    t = y
    y = mod(x, y)
    x = t
  end
  x
end

# Wikipedia pseudo code for gcdx
function Base.gcdx(a::NfOrdElem, b::NfOrdElem)
  R = parent(a)
  s = zero(R)
  t = one(R)
  r = b
  old_s = one(R)
  old_t = zero(R)
  old_r = a

  while !iszero(r)
    quotient = div(old_r, r)

    prov = r
    r = old_r - quotient * r
    old_r = prov

    prov = s
    s = old_s - quotient * s
    old_s = prov

    prov = t
    t = old_t - quotient * t
    old_t = prov

  end

  old_r, old_s, old_t

end

function AbstractAlgebra.divides(a::NfOrdElem, b::NfOrdElem)
  iszero(mod(a,b))
end

function AbstractAlgebra.divexact(a::NfOrdElem, b::NfOrdElem)
  if iszero(b)
    throw(DivideError())
  end
  q, r = divrem(a, b)
  if !iszero(r)
    throw(DivideError())
  end
  q
end

function AbstractAlgebra.canonical_unit(a::NfOrdElem)
  if isunit(a)
      return a
  end
  one(parent(a))
end
