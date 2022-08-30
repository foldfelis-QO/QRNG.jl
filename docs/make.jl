using QRNG
using Documenter

DocMeta.setdocmeta!(QRNG, :DocTestSetup, :(using QRNG); recursive=true)

makedocs(;
    modules=[QRNG],
    authors="JingYu Ning <foldfelis@gmail.com> and contributors",
    repo="https://github.com/foldfelis/QRNG.jl/blob/{commit}{path}#{line}",
    sitename="QRNG.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://foldfelis.github.io/QRNG.jl",
        edit_link="master",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/foldfelis/QRNG.jl",
    devbranch="master",
)
