module QRNG

using SpecialFunctions
using QuantumStateBase
using QuantumStateDistributions
using GrayCode
using Distributions
using Random
using Statistics

const DIM = 100

include("exp_distribution.jl")
include("system.jl")

end
