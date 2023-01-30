# ペアの全探索4

n = gets.chomp.to_i
arr = []

n.times do
  arr << gets.chomp
end

flag = "No"
for i in 0...n do
  for j in i+1...n do
    if arr[i] == arr[j]
    #   puts "#{arr[i]} #{arr[j]}"
      flag = "Yes"
    end
  end
end

puts flag



