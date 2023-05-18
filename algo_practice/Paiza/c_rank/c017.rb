a, b = gets.split.map(&:to_i)
n = gets.to_i

arr = []
while n > 0
  arr << gets.split.map(&:to_i)
  n -= 1
end

arr.each do |x, y|
  if a > x
    puts "High"
  elsif x == a && b < y
    puts "High"
  else
    puts "Low"
  end
end
