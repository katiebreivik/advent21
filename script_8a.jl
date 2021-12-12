using DelimitedFiles

function read_data(filename)
    open(filename, "r") do f
        data = split(replace(read(f, String), "| " => "", "\n" => " "), " ", keepempty = false)
    end
end

function count_nums(num_list, num)
    if num == 1
        numlen = 2
    elseif num == 7
        numlen = 3
    elseif num == 4
        numlen = 4
    elseif num == 8
        numlen = 7
    else
        numlen = 0
    end

    num_count = 0
    for n in num_list
        if length(n) == numlen
            num_count += 1
        end
    end 
    return num_count
end

ones = 0
sevens = 0
fours = 0
eights = 0

j = 0
filename = "data_8.dat"
data = read_data(filename)
for ii in 1:Int(length(data)/14)
    all_nums = data[1 + j*14:10 + j*14]
    decode_nums = data[11 + j*14:14 + j*14]
    global ones += count_nums(decode_nums, 1)
    global sevens += count_nums(decode_nums, 7)
    global fours += count_nums(decode_nums, 4)
    global eights += count_nums(decode_nums, 8)

    global j += 1
end

println(ones + sevens + fours + eights)
