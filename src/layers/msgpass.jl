abstract type MessagePassing <: Meta end

adjlist(m::T) where {T<:MessagePassing} = m.adjlist
message(m::T; kwargs...) where {T<:MessagePassing} = identity(; kwargs...)
update(m::T; kwargs...) where {T<:MessagePassing} = identity(; kwargs...)

function update_edge(m::T; gi::GraphInfo, kwargs...) where {T<:MessagePassing}
    adj = gi.adj
    edge_idx = gi.edge_idx
    M = message(m; neighbor_data(kwargs, 1, adj[1])...)
    Y = similar(M, size(M, 1), gi.E)
    Y[:, 1:edge_idx[2]] = M
    @inbounds Threads.@threads for i = 2:gi.V
        j = edge_idx[i]
        k = edge_idx[i+1]
        Y[:, j+1:k] = message(m; neighbor_data(kwargs, i, adj[i])...)
    end
    Y
end

update_vertex(m::T; kwargs...) where {T<:MessagePassing} = update(m; kwargs...)

aggregate_neighbors(m::T, aggr::Symbol; kwargs...) where {T<:MessagePassing} =
    pool(aggr, kwargs[:cluster], kwargs[:M])

function propagate(mp::T; aggr::Symbol=:add, kwargs...) where {T<:MessagePassing}
    gi = GraphInfo(adjlist(mp))

    # message function
    M = update_edge(mp; gi=gi, kwargs...)

    # aggregate function
    M = aggregate_neighbors(mp, aggr; M=M, cluster=generate_cluster(M, gi))

    # update function
    Y = update_vertex(mp; M=M, kwargs...)
    return Y
end

function neighbor_data(d, i::Integer, ne)
    result = Dict{Symbol,AbstractArray}()
    if haskey(d, :X)
        result[:x_i] = view(d[:X], :, i)
        result[:x_j] = view(d[:X], :, ne)
    end
    if haskey(d, :E)
        result[:e_ij] = view(d[:E], :, i, ne)
    end
    result
end

function generate_cluster(M::AbstractMatrix, gi::GraphInfo)
    cluster = similar(M, Int, gi.E)
    @inbounds for i = 1:gi.V
        j = gi.edge_idx[i]
        k = gi.edge_idx[i+1]
        cluster[j+1:k] .= i
    end
    cluster
end
