n = gets.to_i
ele = []
while vow = gets
  ele << vow.chomp
end

puts ele.count('For') > ele.length / 2 ? 'Yes' : 'No'

# n = gets.to_i
# s = n.times.map{
#   gets.chomp
# }
 
# if s.count('For') > s.count('Against')
#   puts 'Yes'
# else
#   puts 'No'
# end