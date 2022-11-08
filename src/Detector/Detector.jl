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
    while !(-v_lim ≤ (signal = 2randn()) < v_lim) end

    return floor(T, (signal + v_lim) / Δv)
end

function next(detector::PseudoDetector{T}, n::Integer) where {T}
    signals = Vector{T}(undef, n)
    for i in 1:length(signals)
        signals[i] = next(detector)
    end

    return signals
end
