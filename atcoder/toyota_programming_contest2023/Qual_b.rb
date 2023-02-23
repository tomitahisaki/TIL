n, k = gets.split(' ').map(&:to_i)
s = gets.chomp.split('')
 
s_res = []
num = 0
 
s.each do |i|
  if i == "o" && num < k
    s_res << "o"
    num += 1
  else
    s_res << "x"
  end
end

puts s_res.join
