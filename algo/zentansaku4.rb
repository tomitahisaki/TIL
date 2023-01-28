# ペアの全探索1

n, k = gets.split.map(&:to_i)
a = gets.split.map(&:to_i)

count = 0
for i in 0...n do
  for j in i+1...n do
    if a[i] + a[j] <= k
    #   puts "#{a[i]} #{a[j]}"
      count += 1
    end
  end
end

puts count