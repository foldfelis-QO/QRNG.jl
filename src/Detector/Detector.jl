using CSV, DataFrames

struct PseudoDetector{T}<:AbstrateDetector
    res_nbits::Int64
    res::Int64
    v_lim::Float64
    Δv::Float64
end

function PseudoDetector()
    res_nbits = 16
    res = 2^res_nbits
    v_lim = 10
    Δv = 2v_lim/res

    return PseudoDetector{UInt16}(res_nbits, res, v_lim, Δv)
end

get_res_nbits(detector::PseudoDetector) = detector.res_nbits

get_res(detector::PseudoDetector) = detector.res

function next(detector::PseudoDetector{T}) where {T}
    v_lim, Δv = detector.v_lim, detector.Δv
    while !(-v_lim ≤ (signal = 3randn()) < v_lim) end

    return floor(T, (signal + v_lim) / Δv)
end

function next(detector::PseudoDetector{T}, n::Integer) where {T}
    signals = Vector{T}(undef, n)
    for i in 1:length(signals)
        signals[i] = next(detector)
    end

    return signals
end

struct FileSourceDetector{T}<:AbstrateDetector
    i::Vector{Int}
    signals::Vector{T}
end

function FileSourceDetector(T, file::String)
    signals = CSV.read(file, DataFrame, header=0)[!, 1]
    signals = T.(signals .- typemin(signed(T)))

    return FileSourceDetector{T}([0], signals)
end

get_res_nbits(::FileSourceDetector{T}) where {T} = length(bitstring(typemin(T)))

get_res(detector::FileSourceDetector) = 2^get_res_nbits(detector)

function next(detector::FileSourceDetector)
    detector.i[1] += 1

    return detector.signals[detector.i[1]]
end

function next(detector::FileSourceDetector, n::Int)
    signals = detector.signals[(detector.i[1]+1):(detector.i[1]+n)]
    detector.i[1] += n

    return signals
end
