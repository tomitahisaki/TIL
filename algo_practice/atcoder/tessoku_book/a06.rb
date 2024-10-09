n, q = gets.split.map(&:to_i)
a = gets.split.map(&:to_i)

result_sum = Array.new(n + 1, 0)
n.times do |i|
  result_sum[i + 1] = result_sum[i] + a[i]
end

q.times do
  l, r = gets.split.map(&:to_i)
  puts result_sum[r] - result_sum[l - 1]
end
