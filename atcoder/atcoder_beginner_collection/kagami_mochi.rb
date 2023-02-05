n = gets.chomp.to_i
d = readlines(chomp: true)
arr = d.map!{|a| a.to_i}.uniq
puts arr.length


# 配列に入れる前に含まれているかどうかを判定している
# n = gets.chomp.to_i
 
# arr = []
# n.times do
#   d = gets.chomp.to_i
#   arr << d unless arr.include?(d)
# end
 
# puts arr.size