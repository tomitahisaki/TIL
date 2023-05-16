ans = gets.to_i.times.map do
  n, d, k = gets.split.map(&:to_i)
  k1, k2 = (k - 1).divmod(n / n.gcd(d))
  k1 + d * k2 % n
end
puts ans

# t = gets.to_i
# t.times do
#     n, d, k = gets.split.map(&:to_i)
#     k -= 1
 
#     g = n.gcd(d) # サイクルの個数
#     x = n / g # １サイクルの長さ
#     puts k / x + ((k * d) % n) # k / x <- 何周目か
# end