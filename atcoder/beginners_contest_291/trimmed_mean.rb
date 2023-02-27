n = gets.to_i
x = gets.split.map(&:to_f).sort

x.shift(n) # 先頭の要素を削除
x.pop(n) # 末尾の要素を削除
x_res =  x.sum / x.length
puts x_res

# x = gets.to_i
# a = gets.chomp.split(" ").map(&:to_f).sort
# x.times do
#     a.shift
#     a.pop
# end
 
# puts (a.sum)/(a.size)