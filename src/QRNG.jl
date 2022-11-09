module QRNG

include("Generator/Generator.jl")
include("UI/UI.jl")
include("Detector/Detector.jl")

function run()
    detector = FileSourceDetector(UInt16, joinpath(@__DIR__, "../data/anti_sq/RefCurve_2022-11-09_0_152518.Wfm.csv"))
    signals_warmup = next(detector, 2^20)
    bit_rate = min_entropy(signals_warmup, get_res(detector))
    generator = Generator(
        UI(Int, bit_rate),
        detector,
        Encoder(get_res_nbits(detector), bit_rate, signals_warmup[1:2])
    )

    init(generator.ui)
    for _ in 1:10000
        gen_rn(generator)
        sleep(0.1)
    end
    restore(generator.ui)

    return nothing
end

end
