using DelimitedFiles
using Statistics 

open("data_3.dat") do f
 
  # line_number
  line = 1  
  
  data = zeros(1000, 12)
  # read till end of file
  while ! eof(f) 
 
     # read a new / next line for every itera
     s = readline(f)         
     for ii in 1:12
         data[line, ii] = parse(Int, s[ii])
     end
     line += 1
  end    
  gamma = []
  epsilon = []
  for ii in 1:12
      if mean(data[:,ii]) < 0.5  
          append!(gamma, 0)
          append!(epsilon, 1)
      else
          append!(gamma, 1)
          append!(epsilon, 0)
      end
   end
   
   binary_g = 0
   for g in gamma
      binary_g = binary_g * 2 + g
   end
   
   binary_e = 0
   for e in epsilon
       binary_e = binary_e * 2 + e
   end
   println(binary_e * binary_g)
end

