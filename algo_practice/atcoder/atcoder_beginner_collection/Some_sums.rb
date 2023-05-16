n, a, b = gets.split.map(&:to_i)

count = 0
(0..n).each do |i|
  if a <= i.digits.sum && i.digits.sum <= b
    count += i  
  end
end

puts count

# num = 0
# nums = []
# N,A,B = gets.tap(&:to_s).split(' ').map(&:to_i)
 
 
# while num <= N do
#   num1m = num / 10000
#   num1ma = num % 10000
#   num1000 = num1ma / 1000
#   num1000a = num1ma % 1000
#   num100 = num1000a / 100
#   num100a = num1000a % 100
#   num10 = num100a / 10
#   num1 = num % 10
#   numa = num1m + num1000 + num100 + num10 + num1  
#     if numa >= A && numa <= B
#     nums << num
#   end
#   num +=1
# end
 
# puts nums.inject(:+)

# n, a, b = gets.split.map(&:to_i)
 
# arr = []
# (1..n).each do |x|
#   sum = x.to_s.split('').map(&:to_i).sum
#   arr << x if a <= sum && sum <= b
# end
# p arr.sum