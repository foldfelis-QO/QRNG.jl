using QRNG
using Documenter

DocMeta.setdocmeta!(QRNG, :DocTestSetup, :(using QRNG); recursive=true)

makedocs(;
    modules=[QRNG],
    authors="JingYu Ning <115336923+jrunkening@users.noreply.github.com> and contributors",
    repo="https://github.com/foldfelis-QO/QRNG.jl/blob/{commit}{path}#{line}",
    sitename="QRNG.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://foldfelis-QO.github.io/QRNG.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/foldfelis-QO/QRNG.jl",
    devbranch="main",
)
