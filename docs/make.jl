using Documenter, PhyloDiamond

makedocs(
    sitename="PhyloDiamond.jl",
    authors="Zhaoxing Wu, Claudia Solís-Lemus, and contributors",
    modules=[PhyloDiamond],
    format = Documenter.HTML(prettyurls = get(ENV, "CI", nothing) == "true"),
    # many exported helpers are not in the manual yet: warn instead of failing the build
    warnonly = [:missing_docs],
    pages = [
        "Home" => "index.md",
        "Quick start" => "man/quickstart.md",
        "Input and output" => "man/input_output.md",
        "The method in brief" => "man/method.md",
        "Library" => [
            "Public Methods" => "lib/public_methods.md",
        ]
    ]
)

deploydocs(
    repo = "github.com/solislemuslab/PhyloDiamond.jl.git",
    devbranch = "master",
)