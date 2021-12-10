using LinearAlgebra, DelimitedFiles, StatsBase

crabs = vec(readdlm("data_7.dat", ',', Int))

max_pos = maximum(crabs)
min_pos = minimum(crabs)
dists = Int[]
for p in min_pos:max_pos
    dist = broadcast(abs, crabs .- p)
    dist_sum = sum(dist)
    append!(dists, dist_sum)
end

println(minimum(dists))
