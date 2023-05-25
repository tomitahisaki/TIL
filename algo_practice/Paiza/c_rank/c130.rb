# 不正解回答

n = gets.to_i
answer = []
n.times do
  answer << gets.split
end

next_practice = []
answer.each_with_index do |a, index|
  if a[0] == "y" && a[1] == "y"
    next
  else
    next_practice << index + 1
  end
end

if next_practice.empty?
  puts "0"
else
  puts "3"
  puts next_practice
end
