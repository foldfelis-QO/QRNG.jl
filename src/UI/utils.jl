function to_string(plot::UnicodePlots.Plot)
    io = IOBuffer()
    print(IOContext(io, :color => true), plot)

    return String(take!(io))
end
