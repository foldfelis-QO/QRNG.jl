module QRNG

using SpecialFunctions
using QuantumStateBase
using QuantumStateDistributions
using GrayCode

const DIM = 100

struct VacuumNoiseSystem{G<:Gray, D<:GaussianStateBHD, T<:Real}
    Δt::T
    distribution::D
    var::T
end

function VacuumNoiseSystem{G}(Δt::T, dᵥ::D, varᵥ::T) where {G, D, T}
    return VacuumNoiseSystem{G, D, T}(Δt, dᵥ, varᵥ)
end

function VacuumNoiseSystem{G}(Δt) where {G<:Gray}
    dᵥ = GaussianStateBHD(VacuumState(Matrix, dim=DIM))
    varᵥ = QuantumStateDistributions.var(dᵥ, zero(eltype(dᵥ)))

    return VacuumNoiseSystem{G}(Δt, dᵥ, varᵥ)
end

Δt(vns::VacuumNoiseSystem) = vns.Δt

ρ(vns::VacuumNoiseSystem) = vns.distribution.ρ

var(vns::VacuumNoiseSystem) = vns.var

x(vns::VacuumNoiseSystem) = rand(vns.distribution)[2]

y(x, var) = (1 + erf(x / √(2var))) / 2

y(vns::VacuumNoiseSystem) = y(x(vns), var(vns))

scale(y, nbits) = (2^nbits - 1) * y

function is_forbiddened(y_scaled, Δt)
    y_int_part = floor(Unsigned, y_scaled)
    Δtₕ = Δt/2

    return y_int_part - Δtₕ ≤ y_scaled ≤ y_int_part + Δtₕ
end

function yⁿ(vns::VacuumNoiseSystem{G}) where {G}
    y_scaled = scale(y(vns), nbits(G))
    while is_forbiddened(y_scaled, vns.Δt)
        y_scaled = scale(y(vns), nbits(G))
    end

    return G(floor(Unsigned, y_scaled))
end

end
