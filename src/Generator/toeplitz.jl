struct Encoder{M}
    toeplitz_matrix::M
end

function Encoder(in_nbits::Integer, out_nbits::Integer, seed::Vector)
    bits = [parse(Int, b) for b in bitstring(seed[2])[end:-1:1] * bitstring(seed[1])]

    t = Matrix{Int}(undef, out_nbits, in_nbits)
    for i in 1:out_nbits
        t[i, 1:end] .= bits[end-in_nbits-i+2:end-i+1]
    end

    return Encoder(t)
end

function (e::Encoder)(signal)
    hash = (e.toeplitz_matrix * [parse(Int, b) for b in bitstring(signal)]) .% 2

    return parse(Int, prod(string.(hash)), base=2)
end
