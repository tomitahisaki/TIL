def leet(n)
  case n
  when "A"
    return "4"
  when "E"
    return "3"
  when "G"
    return "6"
  when "I"
    return "1"
  when "O"
    return"0"
  when "S"
    return "5"
  when "Z"
    return "2"
  else
    return n
  end
end

s = gets.chomp.chars

res = []
s.each do |n|
  res << leet(n)
end

puts res.join
