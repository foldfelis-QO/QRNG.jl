# ##############
# # AbstractUI #
# ##############

abstract type AbstractUI end

function init(::AbstractUI) end

function rander(::AbstractUI) end

function update(::AbstractUI) end

function restore(::AbstractUI) end

# ####################
# # AbstrateDetector #
# ####################

abstract type AbstrateDetector end

function get_res_nbits(::AbstrateDetector) end

function get_res(::AbstrateDetector) end

function next(::AbstrateDetector) end

function next(::AbstrateDetector, n::Integer) end

# #############
# # Generator #
# #############

include("utils.jl")
include("toeplitz.jl")

struct Generator{UI, D, E}
    ui::UI
    detector::D
    encoder::E
end

function gen_rn(generator::Generator)
    signal = next(generator.detector)
    rn = generator.encoder(signal)

    push!(generator.ui.signals, signal)
    push!(generator.ui.rns, rn)

    update(generator.ui)
end

struct FileGenerator{D, E}
    detector::D
    encoder::E
end

function gen_rn(generator::FileGenerator)
    signal = next(generator.detector)
    rn = generator.encoder(signal)

    return rn
end
