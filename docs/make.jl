using Documenter, PhyloDiamond

makedocs(
    sitename="PhyloDiamond.jl",
    authors="Zhaoxing Wu, Claudia Solís-Lemus, and contributors",
    modules=[PhyloDiamond],
    format = Documenter.HTML(prettyurls = get(ENV, "CI", nothing) == "true"),
    pages = [
        "Home" => "index.md",
        "Manual" => [
            "Installation" => "man/installation.md",
            "Implementation" => "man/implementation.md",
        ],
        "Library" => [
            "Public Methods" => "lib/public_methods.md",
        ]
    ]
)

deploydocs(
    repo = "github.com/solislemuslab/PhyloDiamond.jl.git",
)