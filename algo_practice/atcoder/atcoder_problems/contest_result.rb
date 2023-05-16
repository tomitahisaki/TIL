n, m = gets.split.map(&:to_i)
a = gets.split.map(&:to_i)
b = gets.split.map(&:to_i)

sum = 0
b.each do |i|
  sum += a[i - 1]
end

puts sum