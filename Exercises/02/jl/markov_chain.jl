function markov_chain(
        x_start::Float64, # start value
        N::Int64, # number of values
        h::Float64, # step size
        w # weight function
    )
    x = zeros(Float64, N) # x-values
    x[1] = x_start

    for i in 1:N-1
        delta = 2 * rand() - 1
        x_bar = x[i] + min(h, 1) * delta # suggestion for new x-value

        p = w(x_bar) / w(x[i])
        if rand() < p # accept
            x[i+1] = x_bar
        else # do not acceot / keep value
            x[i+1] = x[i]
        end
    end

    return x
end

function markov_chain(
        x_start::Vector{Float64}, # start value
        N::Int64, # number of values
        h::Float64, # step size
        w # weight function
    )
    x = zeros(Float64, N, size(x_start, 1)) # x-values
    x[1,:] = x_start

    for i in 1:N-1
        delta = 2 * rand(size(x_start, 1)) .- 1
        x_bar = x[i,:] + min(h, 1) * delta # suggestion for new x-value

        p = w(x_bar...) / w(x[i]...)
        if rand() < p # accept
            x[i+1,:] = x_bar
        else # do not acceot / keep value
            x[i+1,:] = x[i,:]
        end
    end

    return x
end