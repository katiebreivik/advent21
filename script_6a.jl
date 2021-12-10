using LinearAlgebra, DelimitedFiles, StatsBase

freqs = countmap(vec(readdlm("data_6.dat", ',', Int)))

freq_list = Int[]
for ii in 0:8
    try
        append!(freq_list, freqs[ii])
    catch
        append!(freq_list, 0)
    end
end
println(freq_list)

step = [0 1 0 0 0 0 0 0 0;
        0 0 1 0 0 0 0 0 0;
        0 0 0 1 0 0 0 0 0;
        0 0 0 0 1 0 0 0 0;
        0 0 0 0 0 1 0 0 0;
        0 0 0 0 0 0 1 0 0;
        1 0 0 0 0 0 0 1 0;
        0 0 0 0 0 0 0 0 1;
        1 0 0 0 0 0 0 0 0]

println(sum(step^80 * freq_list))
println(sum(step^256 * freq_list))
