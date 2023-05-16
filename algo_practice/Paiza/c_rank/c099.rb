n, d = gets.split.map(&:to_i)
k = []

while x = gets
  k << x.to_i
end

sum = d * d
k.each do |i|
  sum +=  d * (d - i)

end

puts sum