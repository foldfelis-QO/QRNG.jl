export ExpDistribution

mutable struct ExpDistribution{T}<:ContinuousUnivariateDistribution
    data::AbstractVector{T}
    var::T
    i::Int
end

function ExpDistribution(data)
    d = Distributions.fit(Normal, data)
    return ExpDistribution(data, var(d), 0)
end

Base.length(d::ExpDistribution) = 1

Statistics.var(d::ExpDistribution) = d.var

Distributions.sampler(d::ExpDistribution) = d

Base.eltype(::ExpDistribution{T}) where {T} = eltype(T)

function Base.rand(::AbstractRNG, d::ExpDistribution)
    d.i += 1

    return d.data[d.i]
end
