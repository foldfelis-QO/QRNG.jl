using CSV, DataFrames
using GrayCode, QRNG

const N_LINE = 27
const N_ONE_LINE = 50000 # *8
const FILE = joinpath(@__DIR__, "../data/CF10M_LP2.5M(O2)_SR5M_BW20M(50ohm).Wfm.csv")

function gen_simulated_qrn()
    system = VacuumNoiseSystem{Gray8}(Δt=0.9)

    file_rn = joinpath(@__DIR__, "../data/rn/rn1.txt")
    rm(file_rn, force=true)

    io = open(file_rn, "a")
    for _ in 1:N_LINE
        for _ in 1:N_ONE_LINE
            # write(io, reinterpret(UInt8, yⁿ(system)))
            write(io, bitstring(yⁿ(system)))
        end
        write(io, '\n')
    end
    close(io)
end

function gen_fitted_qrn()
    # 2752002 random number
    file = FILE

    xs = collect(CSV.read(file, DataFrame, header=["ts", "xs"], delim=';')[!, "xs"]);
    system = fit(VacuumNoiseSystem{Gray8}, xs, Δt=0.9)


    file_rn = joinpath(@__DIR__, "../data/rn/rn2.txt")
    rm(file_rn, force=true)

    io = open(file_rn, "a")
    for _ in 1:N_LINE
        for _ in 1:N_ONE_LINE
            # write(io, reinterpret(UInt8, yⁿ(system)))
            write(io, bitstring(yⁿ(system)))
        end
        write(io, '\n')
    end
    close(io)
end

function gen_true_qrn()
    # 2752002 random number
    file = FILE

    xs = collect(CSV.read(file, DataFrame, header=["ts", "xs"], delim=';')[!, "xs"]);
    system = experiment(VacuumNoiseSystem{Gray8}, xs, Δt=0.9)


    file_rn = joinpath(@__DIR__, "../data/rn/rn3.txt")
    rm(file_rn, force=true)

    io = open(file_rn, "a")
    for _ in 1:N_LINE
        for _ in 1:N_ONE_LINE
            # write(io, reinterpret(UInt8, yⁿ(system)))
            write(io, bitstring(yⁿ(system)))
        end
        write(io, '\n')
    end
    close(io)
end


function gen_all_qrn()
    gen_simulated_qrn()
    gen_fitted_qrn()
    gen_true_qrn()
end
