using DelimitedFiles

x = readdlm("data_1.dat", '\n', Int, '\n')

global sumcount = 0

for n in 1:length(x)-3
    sum1 = sum(x[n:n+2])
    sum2 = sum(x[n+1:n+3])
    if sum2 > sum1
        global sumcount += 1
    end
end

print(sumcount)
