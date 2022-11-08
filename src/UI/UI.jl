using Term
using UnicodePlots

include("utils.jl")

struct UI{T}<:AbstractUI
    signals::Vector{T}
    rns::Vector{T}
    bit_rate::Int64
end

function UI(T, bit_rate)
    return UI(T[0], T[0], bit_rate)
end

function gen_rn(rn; width)
    return Panel(
        "{red bold}$rn";
        title="Random Number", width=width, justify=:center
    )
end

function gen_chart(signals::Vector; nbins, title, width)
    return Panel(
        to_string(histogram(signals, nbins=nbins));
        title=title, width=width, height=nbins+5
    )
end

function gen_form(ui::UI)
    base_width = 75
    nbins = 22

    return Panel(
        gen_rn(bitstring(ui.rns[end])[(end-ui.bit_rate+1):end], width=2base_width) /
        (
            gen_chart(ui.signals, nbins=nbins, title="Signals", width=base_width) *
            gen_chart(ui.rns, nbins=nbins, title="Random Numbers", width=base_width)
        );

        title="Quantum Random Number Generator (Bit Rate: $(ui.bit_rate))",
        fit=true, style="bold blue"
    )
end

function init(::UI)
    alt_screen(true)
    clear()
end

function rander(ui::UI)
    println(gen_form(ui))
end

function update(ui::UI)
    clear()
    rander(ui)
end

function restore(::UI)
    alt_screen(false)
end
