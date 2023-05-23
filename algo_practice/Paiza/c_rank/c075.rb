n, m = gets.split.map(&:to_i)
# n 持ち金
# m 回数
cost_per_bus = []
m.times do
  cost_per_bus << gets.chomp.to_i
end

money = n
point = 0
cost_per_bus.each do |cost|
  if cost >= point
    money -= cost
    point += cost * 0.1
    puts  "#{money}" + " " + "#{point.to_i}"
  else
    point -= cost
    puts  "#{money}" + " " + "#{point.to_i}"
  end
end
