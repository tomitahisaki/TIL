n = gets.to_i
arr = [1]

n.times do |i|
  arr << gets.to_i
end

sum = 0
count = 0
(arr.size - 1 ).times do |i|
  count = arr[i+1] - arr[i] 
  sum += count.abs
  count = 0
end

puts sum
