### A Pluto.jl notebook ###
# v0.19.9

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
begin
	using PlutoUI
	
	html"""<style>
	main {
		max-width: 50%;
	}
	"""
end

# ╔═╡ 031e74cd-dbc0-4f04-8a04-29f475e8fc66
begin
	using QRNG
	using GrayCode
	using Statistics
	using BenchmarkTools
end

# ╔═╡ 2a1e0e90-4ea2-4531-95c9-72ebd7c563da
begin
	using CSV
	using DataFrames
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

# ╔═╡ 21c6adae-5125-4ea3-97c0-fdeb5a6e2df6
md"
### Simulated vacuum noise system
"

# ╔═╡ d84371c4-6f30-4d8e-b199-eaf00f3fe14f
systemᵥ = VacuumNoiseSystem{Gray8}(Δt=0.9);

# ╔═╡ 4e394ab9-e65e-445d-a9ad-515eee928723
md"
### Varience of the RN for simulated vacuum noise system
"

# ╔═╡ 73828498-8ae1-4d9f-9863-83ee3efd68c6
var(systemᵥ)

# ╔═╡ 3456766c-7cd2-40f5-8307-95a1656041d7
md"
### Discreted RN from the simulated system
"

# ╔═╡ d41a742e-0e47-4dd1-a5c6-f21630ece56b
@bind 🚀 Button("Generate a quantum random number")

# ╔═╡ 83efc954-8529-44d9-9044-d1b81609733a
🚀; yⁿₘ = yⁿ(systemᵥ);

# ╔═╡ 7cdf8362-2798-4602-943f-cd318eb7ba56
md"
The quantum random number is: **$(yⁿₘ)**

And the bit pattern is: **$(bitstring(yⁿₘ))**
"

# ╔═╡ 75b7f15c-69ca-40ad-8332-a86d8f6a77b7
md"
### Benchmark
"

# ╔═╡ e866e544-e0a0-4ec5-abd6-a36b6f468a5c
md"""
```julia
julia> @benchmark yⁿ($systemᵥ)
BenchmarkTools.Trial: 10000 samples with 9 evaluations.                  
 Range (min … max):  1.588 μs … 93.237 μs  ┊ GC (min … max): 0.00% … 93.34%  
 Time  (median):     3.147 μs              ┊ GC (median):    0.00%            
 Time  (mean ± σ):   3.587 μs ±  4.106 μs  ┊ GC (mean ± σ):  7.15% ±  6.12%   
                                                                              
        ▁▂▆▄█▆▇▇▄▄▃▂▁                                                        
  ▁▂▂▄▅███████████████▇▆▆▄▄▃▃▃▂▂▂▂▂▂▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ ▃                
  1.59 μs        Histogram: frequency by time        8.32 μs <               
                                                                             
 Memory estimate: 12.33 KiB, allocs estimate: 15.
```
"""

# ╔═╡ c294d26e-8f51-4a37-9d54-7a5f03376031
md"
## Fitting a vacuum noise system from experiments

Vacuum noise data from Yi-Ru
"

# ╔═╡ a7f09540-fd08-4fa2-8d08-a64385b883eb
df = CSV.read(
	"../data/CF10M_LP2.5M(O2)_SR5M_BW20M(50ohm).Wfm.csv",
	DataFrame, header=["ts", "xs"], delim=';'
)[1000:end, :]

# ╔═╡ 48d6312d-e3d1-4b33-83e0-0e9ee01ba6b3
xs = collect(df[!, "xs"]);

# ╔═╡ ac3aa08c-5294-42c7-8de3-12823f201b0d
md"
### Fitted vacuum noise system
"

# ╔═╡ 7667e4c0-5de7-4b99-a9b8-d8e202b41f12
system_fit = fit(VacuumNoiseSystem{Gray8}, xs, Δt=0.9);

# ╔═╡ 545ff676-c0aa-40ef-a917-c004217a45a7
md"
### Varience of the RN for fitted vacuum noise system
"

# ╔═╡ c03d0db3-62fb-48a5-95a4-a8569abc602e
var(system_fit)

# ╔═╡ 188f5dba-9cb1-49a2-9398-a637417968f6
md"
### Discreted RN from the fitted system
"

# ╔═╡ 922ef814-9a63-4664-8c25-054659b58cee
@bind 🪰 Button("Generate a quantum random number")

# ╔═╡ 070e5ded-a789-4302-a8bd-930160e45569
🪰; yⁿₘ_fit = yⁿ(systemᵥ);

# ╔═╡ 045b7027-0391-4218-b8e4-45b7628cd2c3
md"
The quantum random number is: **$(yⁿₘ_fit)**

And the bit pattern is: **$(bitstring(yⁿₘ_fit))**
"

# ╔═╡ 6307645e-13e1-424a-8c7a-4d6e66afcce0
md"
### Benchmark
"

# ╔═╡ 89d1d7b8-ddc1-4a7e-a8ea-521522a84374
md"""
```julia
julia> @benchmark yⁿ($system_fit)                                             
BenchmarkTools.Trial: 10000 samples with 991 evaluations.                   
 Range (min … max):  43.948 ns … 60.200 ns  ┊ GC (min … max): 0.00% … 0.00%  
 Time  (median):     50.622 ns              ┊ GC (median):    0.00%          
 Time  (mean ± σ):   50.692 ns ±  1.809 ns  ┊ GC (mean ± σ):  0.00% ± 0.00%  
                                                                             
                         ▁▂▂▄▄▅▆▇▆████▇█▇▅▅▅▄▃▂▁                            
  ▂▂▂▁▂▂▁▂▂▂▂▃▂▃▃▃▃▄▄▅▅▇█████████████████████████▇▇▆▅▅▅▄▄▃▄▃▃ ▅               
  43.9 ns         Histogram: frequency by time        55.2 ns <               
                                                                             
 Memory estimate: 0 bytes, allocs estimate: 0. 
```
"""

# ╔═╡ 07b752bc-9aa9-4441-9280-6445791cd59f
md"
## Exp vacuum noise system

Vacuum noise data from Yi-Ru
"

# ╔═╡ ec72968c-913d-4cbb-bdd4-fae17e7dbcc0
df

# ╔═╡ 63fe1e64-d4a5-407e-9a3e-35ef71a0178a
xs;

# ╔═╡ be01c681-c8db-41de-bffa-31a2bf782427
md"
### Experiment vacuum noise system
"

# ╔═╡ 56cb3ea5-c413-418b-a5fc-a8458ea8f1c7
system_exp = experiment(VacuumNoiseSystem{Gray8}, xs, Δt=0.9);

# ╔═╡ e14af326-2d3f-44dc-8793-6aaf1c878e40
md"
### Varience of the RN for exp vacuum noise system
"

# ╔═╡ 300d2945-69bd-42fd-9543-dbb4ebe7b00d
var(system_exp)

# ╔═╡ 002ea92a-d1e2-47d7-830e-e0723eb94ba7
md"
### Discreted RN from the exp system
"

# ╔═╡ 9692fe96-9371-420e-b6db-fca6204c3ae2
@bind 🍌 Button("Generate a quantum random number")

# ╔═╡ 8f242f2a-85a1-4a5e-9c92-cfb55f17295a
🍌; yⁿₘ_exp = yⁿ(systemᵥ);

# ╔═╡ cf783925-739d-4b91-ba2b-ef6b4a46c365
md"
The quantum random number is: **$(yⁿₘ_exp)**

And the bit pattern is: **$(bitstring(yⁿₘ_exp))**
"

# ╔═╡ 67e6c184-554e-4fa4-924f-592db242110f
md"""
```julia
julia> @benchmark yⁿ($system_exp)                                             
BenchmarkTools.Trial: 10000 samples with 417 evaluations.                    
 Range (min … max):  264.724 ns …  21.766 μs  ┊ GC (min … max): 0.00% … 98.45%
 Time  (median):     333.317 ns               ┊ GC (median):    0.00%         
 Time  (mean ± σ):   333.759 ns ± 409.761 ns  ┊ GC (mean ± σ):  2.45% ±  1.97%
                                                                              
                                         ▂▂▅▅▅█▇▇█▆▅▃▂                        
  ▁▁▁▁▂▂▂▃▃▄▆▅▆▆▆▆▆▆▅▅▄▃▃▂▂▂▂▁▁▂▂▂▂▂▃▄▆▆▇██████████████▇▆▅▄▄▄▂▂ ▄             
  265 ns           Histogram: frequency by time          361 ns <             
                                                                              
 Memory estimate: 222 bytes, allocs estimate: 13.
```
"""

# ╔═╡ Cell order:
# ╟─7f980eea-afb2-4acb-b2c6-6948cce81cc3
# ╟─331c64cc-0a25-471d-89a0-f3551a3ef0f0
# ╟─1aa4f2a8-9a2e-44bd-9c15-728f59340588
# ╟─085b1a90-2826-11ed-1dd8-47d61cb339a8
# ╠═031e74cd-dbc0-4f04-8a04-29f475e8fc66
# ╟─c7b82c6d-6319-4990-8bf7-4ec07a89d3aa
# ╟─21c6adae-5125-4ea3-97c0-fdeb5a6e2df6
# ╠═d84371c4-6f30-4d8e-b199-eaf00f3fe14f
# ╟─4e394ab9-e65e-445d-a9ad-515eee928723
# ╠═73828498-8ae1-4d9f-9863-83ee3efd68c6
# ╟─3456766c-7cd2-40f5-8307-95a1656041d7
# ╠═83efc954-8529-44d9-9044-d1b81609733a
# ╟─d41a742e-0e47-4dd1-a5c6-f21630ece56b
# ╟─7cdf8362-2798-4602-943f-cd318eb7ba56
# ╟─75b7f15c-69ca-40ad-8332-a86d8f6a77b7
# ╟─e866e544-e0a0-4ec5-abd6-a36b6f468a5c
# ╟─c294d26e-8f51-4a37-9d54-7a5f03376031
# ╠═2a1e0e90-4ea2-4531-95c9-72ebd7c563da
# ╠═a7f09540-fd08-4fa2-8d08-a64385b883eb
# ╠═48d6312d-e3d1-4b33-83e0-0e9ee01ba6b3
# ╟─ac3aa08c-5294-42c7-8de3-12823f201b0d
# ╠═7667e4c0-5de7-4b99-a9b8-d8e202b41f12
# ╟─545ff676-c0aa-40ef-a917-c004217a45a7
# ╠═c03d0db3-62fb-48a5-95a4-a8569abc602e
# ╟─188f5dba-9cb1-49a2-9398-a637417968f6
# ╠═070e5ded-a789-4302-a8bd-930160e45569
# ╟─922ef814-9a63-4664-8c25-054659b58cee
# ╟─045b7027-0391-4218-b8e4-45b7628cd2c3
# ╟─6307645e-13e1-424a-8c7a-4d6e66afcce0
# ╟─89d1d7b8-ddc1-4a7e-a8ea-521522a84374
# ╟─07b752bc-9aa9-4441-9280-6445791cd59f
# ╠═ec72968c-913d-4cbb-bdd4-fae17e7dbcc0
# ╠═63fe1e64-d4a5-407e-9a3e-35ef71a0178a
# ╟─be01c681-c8db-41de-bffa-31a2bf782427
# ╠═56cb3ea5-c413-418b-a5fc-a8458ea8f1c7
# ╟─e14af326-2d3f-44dc-8793-6aaf1c878e40
# ╠═300d2945-69bd-42fd-9543-dbb4ebe7b00d
# ╟─002ea92a-d1e2-47d7-830e-e0723eb94ba7
# ╠═8f242f2a-85a1-4a5e-9c92-cfb55f17295a
# ╟─9692fe96-9371-420e-b6db-fca6204c3ae2
# ╟─cf783925-739d-4b91-ba2b-ef6b4a46c365
# ╟─67e6c184-554e-4fa4-924f-592db242110f
