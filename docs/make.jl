using QuasiMonteCarloIntegration
using Documenter


makedocs(
        modules = [QuasiMonteCarloIntegration],
        sitename = "QuasiMonteCarloIntegration.jl",
        authors = "Vladimir Arnautov",
        pages = [
            "Home" => "index.md",
            ],
        )


deploydocs(repo = "github.com/PharmCat/QuasiMonteCarloIntegration.jl.git", devbranch = "main", forcepush = true
)
