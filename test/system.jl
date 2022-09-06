@testset "full simulation" begin
    system = VacuumNoiseSystem{Gray8}(Δt=0.9);

    ρ_analytical = zeros(QRNG.DIM, QRNG.DIM)
    ρ_analytical[1, 1] = 1

    @test Δt(system) == 0.9
    @test QRNG.ρ(system) == ρ_analytical
    @test var(system) ≈ 0.25
    @test x(system) isa Real
    @test y(system) isa Real
    @test yⁿ(system) isa Gray8
end

@testset "fitted system" begin
    xs = randn(40960)
    system = fit(VacuumNoiseSystem{Gray8}, xs, Δt=0.9);

    @test Δt(system) == 0.9
    @test isapprox(var(system), 1, atol=1e-1)
    @test x(system) isa Real
    @test y(system) isa Real
    @test yⁿ(system) isa Gray8
end

@testset "exp system" begin
    xs = randn(40960)
    system = experiment(VacuumNoiseSystem{Gray8}, xs, Δt=0.9);

    @test Δt(system) == 0.9
    @test isapprox(var(system), 1, atol=1e-1)
    @test x(system) isa Real
    @test y(system) isa Real
    @test yⁿ(system) isa Gray8
end
