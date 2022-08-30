### A Pluto.jl notebook ###
# v0.19.11

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 7f980eea-afb2-4acb-b2c6-6948cce81cc3
# ╠═╡ show_logs = false
using Pkg; Pkg.develop(path=".."); Pkg.activate("..")

# ╔═╡ 331c64cc-0a25-471d-89a0-f3551a3ef0f0
using PlutoUI

# ╔═╡ 031e74cd-dbc0-4f04-8a04-29f475e8fc66
begin
	using QRNG
	using GrayCode
	using BenchmarkTools
end

# ╔═╡ 1aa4f2a8-9a2e-44bd-9c15-728f59340588
PlutoUI.Resource("https://static.vecteezy.com/system/resources/previews/000/543/077/large_2x/character-design-in-concept-of-quantum-computing-vector-illustration-about-future-technology-of-computer-system-for-web-banner-mascot-creator-cover-and-template.jpg")

# ╔═╡ 085b1a90-2826-11ed-1dd8-47d61cb339a8
md"
# QRNG

JingYu Ning

2022 09 02
"

# ╔═╡ c7b82c6d-6319-4990-8bf7-4ec07a89d3aa
md"
## Simulation
"

# ╔═╡ d84371c4-6f30-4d8e-b199-eaf00f3fe14f
systemᵥ = VacuumNoiseSystem{Gray8}(0.9);

# ╔═╡ d41a742e-0e47-4dd1-a5c6-f21630ece56b
@bind 🚀 Button("Generate a quantum random number")

# ╔═╡ 83efc954-8529-44d9-9044-d1b81609733a
🚀; yⁿₘ = yⁿ(systemᵥ);

# ╔═╡ 7cdf8362-2798-4602-943f-cd318eb7ba56
md"
The quantum random number is: **$(yⁿₘ)**

And the bit pattern is: **$(bitstring(yⁿₘ))**
"

# ╔═╡ e866e544-e0a0-4ec5-abd6-a36b6f468a5c
md"""
```julia-REPL
julia> @benchmark yⁿ($systemᵥ)
BenchmarkTools.Trial: 10000 samples with 8 evaluations.
 Range (min … max):  2.237 μs … 105.150 μs  ┊ GC (min … max): 0.00% … 88.42%
 Time  (median):     4.225 μs               ┊ GC (median):    0.00%
 Time  (mean ± σ):   4.867 μs ±   5.551 μs  ┊ GC (mean ± σ):  6.43% ±  5.64%

      ▄ ▃█▂▂▆▂ ▂
  ▂▄▃▇█▇████████▇▅▅▅▄▄▃▃▂▂▂▂▂▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ ▂
  2.24 μs         Histogram: frequency by time        13.8 μs <

 Memory estimate: 12.33 KiB, allocs estimate: 15.
```
"""

# ╔═╡ Cell order:
# ╟─7f980eea-afb2-4acb-b2c6-6948cce81cc3
# ╟─331c64cc-0a25-471d-89a0-f3551a3ef0f0
# ╟─1aa4f2a8-9a2e-44bd-9c15-728f59340588
# ╟─085b1a90-2826-11ed-1dd8-47d61cb339a8
# ╠═031e74cd-dbc0-4f04-8a04-29f475e8fc66
# ╟─c7b82c6d-6319-4990-8bf7-4ec07a89d3aa
# ╠═d84371c4-6f30-4d8e-b199-eaf00f3fe14f
# ╠═83efc954-8529-44d9-9044-d1b81609733a
# ╟─d41a742e-0e47-4dd1-a5c6-f21630ece56b
# ╟─7cdf8362-2798-4602-943f-cd318eb7ba56
# ╟─e866e544-e0a0-4ec5-abd6-a36b6f468a5c
