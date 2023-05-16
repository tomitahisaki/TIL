k = gets.to_i
alfabet = ('A'..'Z').to_a
res = []
k.times do |i|
  res <<  alfabet[i]
end

puts res.join

# k = gets.to_i
# puts ('A'..'Z').to_a.join[0,k]

# puts [*'A'..'Z'][0, gets.to_i].join