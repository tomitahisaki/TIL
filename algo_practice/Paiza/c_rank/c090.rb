s = gets.chomp.chars
s.delete("-")
dial = Array.new(10, 0)
dial.each_with_index do |i, index|
  if index == 0
    dial[index] = 12
  else
    dial[index] = index + 2
  end
end

sum = 0
s.each do |n|
  sum += dial[n.to_i] * 2 
end
puts sum
