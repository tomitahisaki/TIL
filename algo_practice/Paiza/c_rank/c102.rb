n = gets.to_i
arr_a = []

n.times do
  arr_a << gets.to_i
end

m = gets.to_i
arr_b = []
m.times do
  arr_b << gets.to_i
end
check = 0
(1..31).each do |i|
  if arr_a.include?(i) && arr_b.include?(i)
    check += 1
    if check % 2 == 0
      puts "B"
    else
      puts "A"
    end
  elsif arr_a.include?(i)
    puts "A"
  elsif arr_b.include?(i)
    puts "B"
  else
    puts "x"
  end
end
