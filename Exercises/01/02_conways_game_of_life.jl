using Plots
pyplot()

global size_x = 20
global size_y = 20
global time = 10

global grid = grid = Array{Bool, 2}(undef, 20, 20)
global grid[1:end, 1:end] .= 0

include("jl/grids.jl")

include("jl/conways_game_of_life.jl")

grids_initial = [grid_test(), grid_glider(), grid_diehard()]
names = ["test", "glider", "diehard"]
times = [10, 100, 135]

for i in 1:3
    global grid = grids_initial[i]
    global time = times[i]
    global n_values = Array{Int, 1}(undef, time+1)
    heatmap(grid, color=:binary, aspect_ratio=1, showaxis=:off, yflip=true, legend=false)
    savefig("fig/conways_game_of_life/game_of_life_"*names[i]*"_initial.png")

    anim = @animate for i in 1:(time+1)
        heatmap(grid, color=:binary, aspect_ratio=1, showaxis=:off, yflip=true, legend=false)
        n_values[i] = n(grid)
        global grid = step(grid)
    end
    gif(anim, "fig/conways_game_of_life/animation_"*names[i]*".gif", fps=5)
    mp4(anim, "fig/conways_game_of_life/animation_"*names[i]*".mp4", fps=5)
    plot(collect(0:time), n_values, label="n(t)")
    xlabel!("t")
    ylabel!("n")
    savefig("fig/conways_game_of_life/game_of_life_"*names[i]*"_n.pdf")
end
