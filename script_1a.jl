using DelimitedFiles

x = readdlm("data_1.dat", '\n', Int, '\n')
diff = x[2:length(x)] - x[1:length(x)-1]
nincrease = length(diff[diff.>0])

print(nincrease)
