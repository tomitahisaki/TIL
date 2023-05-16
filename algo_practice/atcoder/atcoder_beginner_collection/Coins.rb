a = gets.chomp.to_i #500
b = gets.chomp.to_i #100
c = gets.chomp.to_i #50
x = gets.chomp.to_i #合計

count = 0
(0..a).each do |a|
  (0..b).each do |b|
    (0..c).each do |c|
      if a * 500 + b * 100 + c * 50 == x
        count += 1
      end
    end
  end
end

puts count

# A = gets.to_i
# B = gets.to_i
# C = gets.to_i
# X = gets.to_i
 
# results = []
 
# 0.upto(A) do|k|
#   # 500円k枚の金額
#   coin500 = k*500
#   0.upto(B) do|i|
#     # 100円i枚の金額
#     coin100 = i*100
#     0.upto(C) do |j|
#       # 50円j枚の金額
#       coin50= j*50
#       # 合計を出力
#       if X == coin500 + coin100 + coin50
#         results << coin500 + coin100 + coin50
#       end
#     end
#   end
# end
 
# puts results.length

# a = gets.to_i
# b = gets.to_i
# c = gets.to_i
# x = gets.to_i
# count = 0
# for ai in 0..a do
#   for bi in 0..b do
#     for ci in 0..c do
#       if (ai*500 + bi*100 + ci*50) == x then
#         count += 1
#       end
#     end
#   end
# end
# p count