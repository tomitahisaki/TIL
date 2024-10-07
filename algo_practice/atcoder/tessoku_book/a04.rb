n = gets.to_i.to_s(2)

n_length = n.length

join_zero = 10 - n_length
puts '0' * join_zero + n
