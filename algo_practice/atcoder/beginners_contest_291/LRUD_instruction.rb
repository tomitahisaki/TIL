n = gets.to_i
s = gets.chomp.chars

x = 0
y = 0
arr_res = [[0,0]]

s.each do |i|
  if i == "R"
    x += 1
  elsif i == "L"
    x -= 1
  elsif i == "U"
    y += 1
  else 
    y -= 1
  end
  arr_res.push([x, y])
end

puts arr_res.count - arr_res.uniq.count > 0 ? "Yes" : "No"