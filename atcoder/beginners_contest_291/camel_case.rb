s = gets.chomp.chars

s.each_with_index do |i, n|
  puts n + 1 if ('A'..'Z').include?(i)
end