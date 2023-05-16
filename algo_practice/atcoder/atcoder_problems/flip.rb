s = gets.chomp.chars

s_res = ''
s.each do |i|
  if i == '0'
    s_res += '1'
  else
    s_res += '0'
  end
end

puts s_res.to_s


# s = gets.chomp
# s.size.times { |i| s[i] = s[i] == '0' ? '1' : '0' }
# puts s

# arr = gets.chomp.split('').map(&:to_i)
# ans = []
# arr.length.times do |k|
#   ans.push arr[k]== 1 ? 0 : 1
# end
# puts ans.join("")

# num_array = gets.chomp.split('')
 
# ans = num_array.map { |num| num == "0" ? "1" : "0" }.join('')
 
# puts ans