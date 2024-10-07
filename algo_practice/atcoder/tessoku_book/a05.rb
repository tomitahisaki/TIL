n, k = gets.split.map(&:to_i)

result_count = 0

(1..n).each do |i|
  (1..n).each do |j|
    l = k - i - j
    result_count += 1 if l >= 1 && l <= n
  end
end
puts result_count
