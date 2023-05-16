s = gets.chomp.to_s

i = s.length / 2 
ans = ''
i.times do |n|
  ans += s[2*n + 1]
  ans += s[2*n]

end
puts ans


# s = gets.chomp
 
# 0.step(s.length - 1, 2).each do |i|
#   s[i], s[i + 1] = s[i + 1], s[i]
# end
 
# puts s

# s = gets.chomp.split('')
 
# s.size.times do |i|
#   s[i], s[i+1] = s[i+1], s[i] if i.even?
# end
 
# puts s.join