function tasep!(lattice::Matrix{Bool})
    N_t, N = size(lattice)
    flow::Int64 = 0
    for i in 2:N_t
        lattice[i,:], flow_local = update!(copy(lattice[i-1,:]))
        flow += flow_local
    end
    return flow / (N_t-1)
end

function update!(state::Vector{Bool})
    last::Bool    = state[end] # used for periodic boundary conditions
    blocked::Bool = last # remember previous state of cell
    flow::Bool = 0
    for i in size(state, 1)-1:-1:1
        if state[i] && !blocked # can move
            state[i], state[i+1] = 0, 1
            blocked = 1
        else
            blocked = state[i]
        end
    end
    if last && !blocked
        state[end], state[1] = 0, 1
        flow = 1
    end
    return state, flow
end