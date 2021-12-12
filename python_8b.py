import numpy as np
import collections

def get_data(fname):
    with open(fname) as f:
        read_data = f.read()
        read_data = read_data.replace("| ", " ")
        read_data = read_data.replace("\n", " ")
        read_data = read_data.split(" ")
        while "" in read_data:
            read_data.remove("")
    return read_data

def get_len_six(dat):
    len_six = []
    for d in dat:
        if len(d) == 6:
            len_six.append(d)
    return len_six

def get_1478(dat):
    for d in dat: 
        if len(d) == 2:
            ones = [c for c in d]
        elif len(d) == 3:
            sevens = [c for c in d]
        elif len(d) == 4:
            fours = [c for c in d]
        elif len(d) == 7:
            eights = [c for c in d]
        else:
            continue
    return [ones, fours, sevens, eights]


def get_single(smalls, bigs):
    single = list(set(bigs) - set(smalls))
    return single[0]

def get_g(fours, sevens, dat):
    len_six = get_len_six(dat)
    check = list(set(fours + sevens))
    
    for ls in len_six:
        l = [c for c in ls]
        g = list(set(l) - set(check))
        if len(g) == 1:
            return g[0], l
        else:
            continue

def get_bd_zeros(ones, fours, a, e, g, dat):
    bd_check = []
    for four in fours:
        if four not in ones:
            bd_check.extend(four)
    len_six = get_len_six(dat)
    for ls in len_six:
        l = [c for c in ls]

        if collections.Counter(l) == collections.Counter(ones + [a] + [e] + [g] + [bd_check[0]]):
            b = bd_check[0]
            d = bd_check[1]
            zeros = l
        elif collections.Counter(l) == collections.Counter(ones + [a] + [e] + [g] + [bd_check[1]]):
            b = bd_check[1]
            d = bd_check[0]
            zeros = l
    return b, d, zeros

def get_cf_sixes(zeros, nines, ones, a, b, d, e, g, dat):
    len_six = get_len_six(dat)
    for ls in len_six:
        l = [c for c in ls]
        if l == zeros:
            continue
        elif l == nines:
            continue
        else:
            sixes = l
    f = list(set(sixes) - set([a, b, d, e, g,]))[0]
    for letter in ones:
        if letter != f:
            c = letter

    return c, f, sixes

def find_the_letters(dat):
    [ones, fours, sevens, eights] = get_1478(dat) 
    a = get_single(ones, sevens)
    g, nines = get_g(fours, sevens, dat)
    e = get_single(nines, eights)
    b, d, zeros = get_bd_zeros(ones, fours, a, e, g, dat)
    c, f, sixes = get_cf_sixes(zeros, nines, ones, a, b, d, e, g, dat)

    twos = [a, c, d, e, g]
    threes = [a, c, d, f, g]
    fives = [a ,b, d, f, g]

    return zeros, ones, twos, threes, fours, fives, sixes, sevens, eights, nines

def convert_list(l):
      
    # Converting integer list to string list
    s = [str(i) for i in l]
      
    # Join list items using join()
    res = int("".join(s))
      
    return(res)


fname = "data_8.dat"
data = get_data(fname=fname)
final_dig = []
for ii in range(0, int(len(data)/14)):

    d = data[0 + ii*14 :10 + ii*14]
    zeros, ones, twos, threes, fours, fives, sixes, sevens, eights, nines = find_the_letters(dat=d)

    digits = data[10 + ii*14 : 14 + ii*14]
    digit_list = []
    for d in digits:
        digit = [c for c in d]
        if collections.Counter(digit) == collections.Counter(zeros):
            digit_list.append(0)
        elif collections.Counter(digit) == collections.Counter(ones):
            digit_list.append(1)
        elif collections.Counter(digit) == collections.Counter(twos):
            digit_list.append(2)
        elif collections.Counter(digit) == collections.Counter(threes):
            digit_list.append(3)
        elif collections.Counter(digit) == collections.Counter(fours):
            digit_list.append(4)
        elif collections.Counter(digit) == collections.Counter(fives):
            digit_list.append(5)
        elif collections.Counter(digit) == collections.Counter(sixes):
            digit_list.append(6)
        elif collections.Counter(digit) == collections.Counter(sevens):
            digit_list.append(7)
        elif collections.Counter(digit) == collections.Counter(eights):
            digit_list.append(8)
        elif collections.Counter(digit) == collections.Counter(nines):
            digit_list.append(9)

    final_dig.append(convert_list(digit_list))
print(sum(final_dig))



