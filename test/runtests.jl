using QRNG
using Test

# @testset "QRNG.jl" begin
#     # Write your tests here.
# end

ui = QRNG.UI()

# QRNG.init(ui)
QRNG.rander(ui)
for _ in 1:5
    sleep(1)
    QRNG.update(ui)
end
# QRNG.restore(ui)
