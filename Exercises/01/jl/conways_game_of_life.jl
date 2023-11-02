function neighbors_sum(grid, x, y)
    my_sum = 0
    size_y, size_x = size(grid)
    r_1 = [1, 0] # first neighbors
    r_2 = [1, 1] # second neighbors
    rot = [0 -1; 1 0] # rotation by 90 deg
    for i in 1:4
    for r in [r_1, r_2]
        my_sum = my_sum + grid[
            (y-1+size_y-r[2])%size_y+1, # mod for periodic boundary conditions, minus for inverted y-axis (not necessary)
            (x-1+size_x+r[1])%size_x+1
        ]
    end
    r_1 = rot * r_1
    r_2 = rot * r_2
    end
    return my_sum
end

function f(cell, neighbors)
    if cell == true && (neighbors < 2 || neighbors > 3)
        return false
    end
    if cell == false && neighbors == 3
        return true
    end
    return cell
end

function step(grid_initial)
    size_y, size_x = size(grid_initial)
    grid = Array{Bool, 2}(undef, size_y, size_x)
    for x in 1:size_x
    for y in 1:size_y
        grid[y, x] = f(grid_initial[y, x], neighbors_sum(grid_initial, x, y))
    end
    end
    return grid
end

function n(grid)
    size_y, size_x = size(grid)
    counter = 0
    for x in 1:size_x
    for y in 1:size_y
        counter = counter + Int(grid[y, x])
    end
    end
    return counter
end
