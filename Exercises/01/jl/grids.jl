function grid_test()
    grid = Array{Bool, 2}(undef, 6, 25)
    grid[1:end, 1:end] .= 0
    
    grid[3:4, 3:4] .= 1
    
    grid[3, 9] = 1
    grid[4, 8] = 1
    grid[4, 10] = 1
    grid[5, 9] = 1
    
    grid[4, 14:16] .= 1
    
    grid[3, 21:23] .= 1
    grid[4, 20:22] .= 1

    return grid
end

function grid_glider()
    grid = Array{Bool, 2}(undef, 20, 20)
    grid[1:end, 1:end] .= 0
    grid[2, 3] = 1
    grid[3, 4] = 1
    grid[4, 2:4] .= 1
    return grid
end

function grid_diehard()
    grid = Array{Bool, 2}(undef, 20, 20) # minimum 5 10 on sheet
    grid[1:end, 1:end] .= 0
    grid[3, 2:3] .= 1
    grid[4, 3] = 1
    grid[2, 8] = 1
    grid[4, 7:9] .= 1
    return grid
end
