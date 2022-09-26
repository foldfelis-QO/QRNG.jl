using QRNG
using Documenter

DocMeta.setdocmeta!(QRNG, :DocTestSetup, :(using QRNG); recursive=true)

makedocs(;
    modules=[QRNG],
    authors="JingYu Ning <foldfelis@gmail.com> and contributors",
    repo="https://github.com/foldfelis-QO/QRNG.jl/blob/{commit}{path}#{line}",
    sitename="QRNG.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://foldfelis-QO.github.io/QRNG.jl",
        edit_link="master",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/foldfelis-QO/QRNG.jl",
    devbranch="master",
)
