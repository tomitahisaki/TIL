s = gets.chomp
t = gets.chomp

result = []
chars = s.chars

(chars.size - 1).times do |i|
  swapped_chars = chars.dup
  swapped_chars[i], swapped_chars[i + 1] = swapped_chars[i + 1], swapped_chars[i]
  result << swapped_chars.join
end
result << chars.join
puts result.include?(t) ? 'Yes' : 'No'
