n = gets.to_i
days = []

while day = gets
  days << day.split.map(&:to_i)
end
# p days
time = []
days.each do |n|
  time << n[0] + n[1] + 24- n[2]
end

puts time.min
puts time.max