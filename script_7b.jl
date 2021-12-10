using LinearAlgebra, DelimitedFiles, StatsBase

crabs = vec(readdlm("data_7.dat", ',', Int))

max_pos = maximum(crabs)
min_pos = minimum(crabs)
dists = Int[]
fuels = Int[]
for p in min_pos:max_pos
    dist = broadcast(abs, crabs .- p)
    fuel = 0
    for d in dist
        fuel += (d * (d + 1)) / 2
    end
    append!(fuels, fuel)
end

println(minimum(fuels))
