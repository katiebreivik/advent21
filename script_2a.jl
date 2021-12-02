using DelimitedFiles

x = readdlm("data_2.dat", '\t')

global horizontal = 0
global depth = 0
for val in x
    checkval = val[1]
    if checkval == 'f'
        global horizontal += parse(Int, val[9])
    elseif checkval == 'd'
        global depth += parse(Int, val[6])
    elseif checkval == 'u'
        global depth -= parse(Int, val[4])
    end
end

println(horizontal * depth)
