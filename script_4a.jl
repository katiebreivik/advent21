using DelimitedFiles

function read_input(filename)
  open(filename, "r") do f
    draw = parse.(Int, split(readline(f), ","))
    boards = split(replace(read(f, String), "\n" => " ", "\r\n" => " "), " ", keepempty = false)
    boards = reshape(parse.(Int, boards), 5, 5, :)
    (draw, boards)
  end
end

function main()
    (nums, cards) = read_input("data_4.dat") 
    j = 0
    num_count_old = 1000
    board_count = 0
    num_save = 0
    for ii in 1:Int((length(cards)/5)/5 )
        cards_select = view(cards, :, :, ii)
        num_count = 0
        kk = 0
        for n in nums
            cards_select[cards_select.==n] .= -1
            winner = any(all(==(-1), cards_select, dims = 1)) || any(all(==(-1), cards_select, dims = 2))
            
            if winner
                if kk < 1
                    kk += 1
                    if num_count < num_count_old
                        board_count = sum(cards_select[cards_select.!==-1])
                        num_count_old = num_count
                        num_save = n
                        
                    end
                end
            end
            num_count += 1
        end
        j += 1
    end
    println(board_count * num_save)
end

@time main()
