e =gets.chomp.chars

n = 0
e.each do |i|
  if i == "/"
    n += 1
  elsif i == "<"
    n += 10
  else
    n += 0
  end
end
puts n