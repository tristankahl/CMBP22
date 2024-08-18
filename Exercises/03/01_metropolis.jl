using Plots

# mod function for periodic boundaries maps 0 to N and N+1 to 1
function modx(x, NN)
    y = mod(x-1, NN) + 1
    return y
end

# size of "magnet"
N = 40
M = zeros(Int8, N, N)
# number of Monte-Carlo-iterations
iterations = 80000
# J, T, h are physical numbers (interaction, temperature, external field)
J = 1.0
T = 0.2
beta = 1/T
h = 0.02

# starting configuration

for i in 1:N
    for j in 1:N
        M[i, j] = Int8(rand([-1, 1]))
    end
end
 
heatmap(M, color=:binary, aspect_ratio=1, showaxis=:off, yflip=true, legend=false, grid=false)
savefig("fig/metropolis/start.png")
savefig("fig/metropolis/start.pdf")

anim = @animate for i in 1:Int64(iterations/10000)
    for j in 1:10000
        l = Int8(rand(1:N))
        m = Int8(rand(1:N))

        # flip spin
        sbar = -M[l, m]

        # calculating energy difference
        sum = 0
        sum += M[l%N+1, m]
        sum += M[(l+N-2)%N+1, m]
        sum += M[l, m%N+1]
        sum += M[l, (m+N-2)%N+1]

        dE = -J*(sbar - M[l,m])*sum -2.0*h*sbar

        alpha = exp(-beta*dE)

        gamma = rand()

        if (alpha > gamma)
            M[l, m] = sbar
        end
    end
    heatmap(M, color=:binary, aspect_ratio=1, showaxis=:off, yflip=true, legend=false, grid=false)
end
gif(anim, "fig/metropolis/animation.gif", fps=5)
mp4(anim, "fig/metropolis/animation.mp4", fps=5)
 