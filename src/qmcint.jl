

"""
    mcintegral(f::Function, a::Real, b::Real, dist::Distribution = Uniform(a, b); n::Int = 1000, rng = RandomDevice())

Simple Monte Carlo integration.
"""
function mcintegral(f::Function, a::Real, b::Real, dist::Distribution = Uniform(a, b); n::Int = 1000, rng = RandomDevice())
    s   = 0.0
    ssq = 0.0
    for i = 1:n
        v    = f(rand(rng, dist))
        s   += v
        ssq += v*v
    end
    r = (b-a)*s/n
    e = sqrt((b-a)*ssq/n - (b-a)*(s/n)^2)/sqrt(n-1)
    r, e
end

"""
    qmcintegral(f::Function, a::AbstractVector, b::AbstractVector, sampler::QuasiMonteCarlo.SamplingAlgorithm  = SobolSample(); n::Int = 1000, rng = RandomDevice())

Simple Quasi-Monte Carlo integration.
"""

function qmcintegral(f::Function, a::AbstractVector, b::AbstractVector, sampler  = SobolSample(); kwargs...)
    qmcintegral(f, a, b, sampler; kwargs...)
end

function qmcintegral(f::Function, a::AbstractVector, b::AbstractVector, sampler::SobolSample; n::Int = 1000, rng = RandomDevice())
    s     = 0.0
    ssq   = 0.0
    dim   = length(a)
    smplr = QuasiMonteCarlo.SobolSeq(a, b)
    xvec  = Vector{Float64}(undef, dim)
    for i = 1:n
        QuasiMonteCarlo.next!(smplr, xvec)
        v    = f(xvec)
        s   += v
        ssq += v*v
    end
    r = prod(b-a)*s/n
    e = sqrt(prod(b-a)*ssq/n - prod(b-a)*(s/n)^2)/sqrt(n-1)
    r, e
end

function qmcintegral(f::Function, a::AbstractVector, b::AbstractVector, sampler::QuasiMonteCarlo.SamplingAlgorithm; n::Int = 1000, rng = RandomDevice())
    s   = 0.0
    ssq = 0.0
    dim = length(a)
    spl = QuasiMonteCarlo.sample(n, a, b, sampler)
    for i = 1:n
        v    = f(view(spl, :, i))
        s   += v
        ssq += v*v
    end
    r = prod(b-a)*s/n
    e = sqrt(prod(b-a)*ssq/n - prod(b-a)*(s/n)^2)/sqrt(n-1)
    r, e
end
