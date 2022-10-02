export QuantumNoiseSystem, VacuumNoiseSystem
export fit, experiment
export Δt, ρ, x, y, yⁿ

abstract type QuantumNoiseSystem{G<:Gray} end

struct VacuumNoiseSystem{G, D<:Distribution, T<:Real}<:QuantumNoiseSystem{G}
    Δt::T
    distribution::D
    var::T
end

function VacuumNoiseSystem{G}(Δt::T, dᵥ::D, varᵥ::T) where {G, D, T}
    return VacuumNoiseSystem{G, D, T}(Δt, dᵥ, varᵥ)
end

function VacuumNoiseSystem{G}(; Δt) where {G}
    dᵥ = GaussianStateBHD(VacuumState(Matrix, dim=DIM))
    varᵥ = QuantumStateDistributions.var(dᵥ, zero(eltype(dᵥ)))

    return VacuumNoiseSystem{G}(Δt, dᵥ, varᵥ)
end

function fit(Sys::Type{<:VacuumNoiseSystem}, xs; Δt)
    dᵥ = Distributions.fit(Normal, xs)
    varᵥ = Distributions.var(dᵥ)

    return Sys(Δt, dᵥ, varᵥ)
end

function experiment(Sys::Type{<:VacuumNoiseSystem}, xs; Δt)
    dᵥ = ExpDistribution(xs)
    varᵥ = Distributions.var(dᵥ)

    return Sys(Δt, dᵥ, varᵥ)
end

Δt(vns::VacuumNoiseSystem) = vns.Δt

ρ(vns::VacuumNoiseSystem) = vns.distribution.ρ

Statistics.var(vns::VacuumNoiseSystem) = vns.var

x(vns::VacuumNoiseSystem) = last(rand(vns.distribution))

y(x, var) = (1 + erf(x / √(2var))) / 2

y(vns::VacuumNoiseSystem) = y(x(vns), var(vns))

scale(y, nbits) = 2^nbits * y

function is_forbiddened(y_scaled, Δt)
    y_int_part = floor(Unsigned, y_scaled)
    Δtₕ = Δt/2

    return (y_int_part + 1 - Δtₕ) < y_scaled && y_scaled < (y_int_part + Δtₕ)
end

function yⁿ(vns::VacuumNoiseSystem{G}) where {G}
    y_scaled = scale(y(vns), nbits(G))
    while is_forbiddened(y_scaled, vns.Δt)
        y_scaled = scale(y(vns), nbits(G))
    end

    return G(floor(Unsigned, y_scaled))
end
