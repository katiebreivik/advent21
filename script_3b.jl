using DelimitedFiles
using Statistics 

open("data_3.dat") do f
   # line_number
  line = 1
  data = zeros(1000, 12)
  # read till end of file
  for j in 1:1000
     # read a new / next line for every itera
     s = readline(f)
     for ii in 1:12
         data[line, ii] = parse(Int, s[ii])
     end
     line += 1
  end
  
  jj = 0
  for ii in 1:12
      if ii == 1
         global dat_select_oxy = data
      else
         global dat_select_oxy = dat_select_oxy[ind_oxy, :]
      end
      if mean(dat_select_oxy[:,ii]) < 0.5
          oxygen_rating = 0.0
      else
          oxygen_rating = 1.0
      end

      global ind_oxy = findall(x -> x == oxygen_rating, dat_select_oxy[:, ii] )
      if length(ind_oxy) == 1 && jj == 0
          global dat_oxy = dat_select_oxy[ind_oxy, :]
          jj += 1
      end
  end
 
  jj = 0 
  for ii in 1:12
      if ii == 1
          global dat_select_co2 = data
      else
          global dat_select_co2 = dat_select_co2[ind_co2, :]
      end

      # if 0 is more common than 1, then the mean is <= 0.5
      if mean(dat_select_co2[:,ii]) < 0.5
          co2_rating = 1.0
      else
          co2_rating = 0.0
      end
      global ind_co2 = findall(x -> x == co2_rating, dat_select_co2[:, ii] )
      if length(ind_co2) == 1 && jj == 0 
          global dat_co2 = dat_select_co2[ind_co2, :]

          jj += 1
      end
   end 
   println(dat_oxy)
   println(dat_co2)
   binary_o = 0
   for d in dat_oxy
      binary_o = binary_o * 2 + d
   end

   binary_c = 0
   for d in dat_co2
       binary_c = binary_c * 2 + d
   end
   println(binary_o, binary_c)
   println(binary_o * binary_c)
   
end

