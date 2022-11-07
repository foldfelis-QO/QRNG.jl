using REPL

const CSI = REPL.Terminals.CSI

function to_string(plot::UnicodePlots.Plot)
    io = IOBuffer()
    print(IOContext(io, :color => true), plot)

    return String(take!(io))
end

clear() = print("$(CSI)H$(CSI)2J")

function alt_screen(enable::Bool)
    if enable
        print("$(CSI)?1049h")
    else
        print("$(CSI)?1049l")
    end
end
