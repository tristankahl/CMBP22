using Random, Plots

# tasep corresponds to the cellular automata rule 184 = 2^7 + 2^5 + 2^4 + 2^3
# 111 110 101 100 011 010 001 000
#  1   0   1   1   1   0   0   0

N = 50
N_t = 101
lattice = zeros(Bool, N_t, N)

# starting configuration
for i in 1:N
    lattice[1, i] = rand([0, 1])
end

include("jl/tasep.jl")

flow = tasep!(lattice)

println(flow)

M = 0:5:N # rho * N
rho = M / N
flow = zeros(Float64, size(rho, 1))
for i in 1:size(rho, 1)
    lattice[1, :] = zeros(Bool, N)
    lattice[1, 1:Int(M[i])] .= Bool(1)
    Random.shuffle(lattice[1, :])
    flow[i] = tasep!(lattice)
end

plot(rho, flow, xlabel="\$\\rho\$", ylabel="\$j\$", label="")
savefig("fig/tasep/fundamental_diagram.pdf")