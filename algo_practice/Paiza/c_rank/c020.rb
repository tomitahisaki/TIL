m, p, q = gets.split.map(&:to_i)
# m 食品
# p 販売量％
# q 売れ残りの再販量％

rest_1 = m.to_f * (100 - p) / 100
# p rest_1

rest_2 = rest_1 * (100 - q) /100
puts rest_2

