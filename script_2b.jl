using DelimitedFiles

x = readdlm("data_2.dat", '\t')

global horizontal = 0
global depth = 0

global horizontal = 0
global depth = 0
global aim = 0
for val in x
    checkval = val[1]
    if checkval == 'f'
        global horizontal += parse(Int, val[9])
        global depth += aim * parse(Int, val[9])
    elseif checkval == 'd'
        global aim += parse(Int, val[6])
    elseif checkval == 'u'
        global aim -= parse(Int, val[4])
    end
end

println(horizontal * depth)
