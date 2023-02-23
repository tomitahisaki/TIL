n, m = gets.split().map(&:to_i) # n:問題数 m:解答数
a =gets.split().map(&:to_i) # 配点数
b =gets.split().map(&:to_i) # 解答した問題

results = 0

b.each do |i|
  results += a[i-1]
end

puts results