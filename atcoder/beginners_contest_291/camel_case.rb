s = gets.chomp.chars

s.each_with_index do |i, n|
  puts n + 1 if ('A'..'Z').include?(i)
end

# s = gets.chomp.chars
# s.each_with_index{|k,idx| puts idx + 1 if k == k.upcase}

# s = gets.chomp.chars
 
# s.each_with_index do |si, i|
#     puts i + 1 if si == si.upcase
# end