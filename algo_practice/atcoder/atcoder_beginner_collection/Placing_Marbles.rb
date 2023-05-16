s1= gets.chomp.split('').map(&:to_i)

count = 0
s1.each do |s|
 if s == 1
  count += 1
 end
end

puts count

# 解答例
# print(gets.chomp.count('1'))

# a,b,c = gets.chomp.split('').map(&:to_i)
# puts a+b+c