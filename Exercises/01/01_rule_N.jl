using Plots
pyplot()

global L = 120 # space axis
global N = 50 # time axis
global lattice = zeros(Bool, N, L)
lattice[1, 60] = 1 # fill one cell

function apply_rule!(lattice, rule)
    N, L = size(lattice)
    rule_vector = zeros(Bool, 8)
    rule_rest = rule
    for i in 1:8
        rule_vector[i] = Bool(rule_rest % 2)
        rule_rest -= rule_rest % 2
        rule_rest /= 2
    end
    for i in 2:N
        for j in 2:L-1
            k = [4, 2, 1]' * lattice[i-1, j-1:j+1] + 1
            lattice[i, j] = rule_vector[k]
        end
    end
end

apply_rule!(lattice, 30)

heatmap(lattice, color=:binary, aspect_ratio=1, showaxis=:off, yflip=true, legend=false)
savefig("fig/rule_30.png")

n_t = [sum(lattice[i, 1:end]) for i in 1:N]
plot(1:N, n_t, xlabel="t", ylabel="n(t)", label="")
savefig("fig/rule_30_n.pdf")
savefig("fig/rule_30_n.png")

lattice_2 = zeros(Bool, N, L)
lattice_2[1, 1:end] = lattice[end, 1:end]

apply_rule!(lattice_2, 204) # 2^2+2^3+2^6+2^7 = 4+8+64+128 = 204

heatmap(lattice_2, color=:binary, aspect_ratio=1, showaxis=:off, yflip=true, legend=false)
savefig("fig/rule_204.png")
