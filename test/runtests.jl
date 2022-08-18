using QuasiMonteCarloIntegration
using Test, QuasiMonteCarlo

@testset "   Simple test                                             " begin

    func(x) = pdf(MvNormal([1 0.5; 0.5 3]), x)

    QuasiMonteCarloIntegration.qmcintegral(func, [-1, -2], [3, 4], SobolSample(), n = 3000)

    QuasiMonteCarloIntegration.qmcintegral(func, [-1, -2], [3, 4], UniformSample(), n = 3000)

    QuasiMonteCarloIntegration.qmcintegral(func, [-1, -2], [3, 4], LatticeRuleSample(), n = 3000)

    QuasiMonteCarloIntegration.mcintegral(x -> pdf(Normal(0, 2), x), 0, 2; n = 3000)

    @test true
end
