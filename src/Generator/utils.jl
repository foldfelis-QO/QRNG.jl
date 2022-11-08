function min_entropy(signals::Vector, resolution::Integer)
    counts = zeros(resolution)
    for signal in signals
        counts[signal+1] += 1
    end

    pmf = counts ./ length(signals)

    return floor(Int, -log2(maximum(pmf)))
end
