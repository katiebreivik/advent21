using DelimitedFiles

function read_data(filename)
    open(filename, "r") do f
        data = split(replace(read(f, String), "->" => "", "\n" => " "), " ", keepempty = false)
        dat_list = reshape(data, 2, :)
    end
end


function main()

    filename = "data_5.dat"
    dat_list = read_data(filename)
    mines = zeros(Int32, 1000, 1000)

    x_start = zeros(Int32, length(dat_list[1, :]))
    y_start = zeros(Int32, length(dat_list[1, :]))

    x_end = zeros(Int32, length(dat_list[1, :]))
    y_end = zeros(Int32, length(dat_list[1, :]))

    # since julia indexes from 1 (ugh), lets add 1 to everything
    ii = 1
    for d in dat_list[1,:]
        (startx, starty) = parse.(Int, split(d, ","))
        x_start[ii] = startx + 1
        y_start[ii] = starty + 1
        ii += 1
    end

    ii = 1
    for d in dat_list[2,:]
        (endx, endy) = parse.(Int, split(d, ","))
        x_end[ii] = endx + 1
        y_end[ii] = endy + 1
        ii += 1
    end

    # Note that Julia indexes weirdly...so I have to do A[y, x]
    # I should probably figure out why this is the case...
    for ii in 1:length(x_end)
        if x_start[ii] == x_end[ii]
            if y_start[ii] < y_end[ii]
                mines[y_start[ii]:y_end[ii], x_start[ii]] .+= 1
            else
                mines[y_end[ii]:y_start[ii], x_start[ii]] .+= 1
            end
        elseif y_start[ii] == y_end[ii]
            if x_start[ii] < x_end[ii]
                mines[y_start[ii], x_start[ii]:x_end[ii]] .+= 1
            else
                mines[y_start[ii], x_end[ii]:x_start[ii]] .+= 1
            end
        elseif y_start[ii] < y_end[ii]
            if x_start[ii] < x_end[ii]
                j = 0
                for x in x_start[ii]:x_end[ii]
                    y =  y_start[ii] + j
                    mines[y, x] += 1
                    j += 1
                end
            elseif x_start[ii] > x_end[ii]
                j = 0
                for x in reverse(x_end[ii]:x_start[ii])
                    y = y_start[ii] + j
                    mines[y, x] += 1
                    j += 1
                end
            end
        elseif y_start[ii] > y_end[ii]
            if x_start[ii] < x_end[ii]
                j = 0
                for x in x_start[ii]:x_end[ii]
                    y =  y_start[ii] - j
                    mines[y, x] += 1
                    j += 1
                end
            elseif x_start[ii] > x_end[ii]
                j = 0
                for x in reverse(x_end[ii]:x_start[ii])
                    y = y_start[ii] - j
                    mines[y, x] += 1
                    j += 1
                end
            end   
        end
    end
    int_avoid = findall(x -> x>=2, mines)
    println(length(int_avoid))
end

@time main()
