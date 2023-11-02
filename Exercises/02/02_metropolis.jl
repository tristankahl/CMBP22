using Plots

w(x) = 1 / sqrt(pi) * exp(- x^2)
w(x, y) = 1 / sqrt(pi) * exp(- (x^2 + y^2))

include("jl/markov_chain.jl")

x_values = markov_chain(0.0, 10^6, 1.0, w)

histogram(x_values; bins=-2.5:0.1:2.5, normalize=true, color="blue", label="Markov-chain")
plot!(collect(-2.5:0.1:2.5), w.(collect(-2.5:0.1:2.5)), width=2, color="red", label="w(x)")
xlabel!("\$x\$")
ylabel!("count")
savefig("fig/metropolis/markov.pdf")
savefig("fig/metropolis/markov.png")

plot(x_values[1:1000], xlabel="step", ylabel="x", label="")
savefig("fig/metropolis/x_values.pdf")
savefig("fig/metropolis/x_values.png")

xy_values = markov_chain([0.0, 0.0], 10^3, 0.01, w)

plot(xy_values[:, 1], xy_values[:,2], xlabel="x", ylabel="y", label="", aspect_ratio=:equal)
savefig("fig/metropolis/xy_values.pdf")
savefig("fig/metropolis/xy_values.png")
plot!(ticks=false, xlabel="", ylabel="", axis=:off)
savefig("fig/metropolis/xy_values_clean.pdf")
savefig("fig/metropolis/xy_values_clean.png")