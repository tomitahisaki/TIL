n, m = gets.split.map(&:to_i)
a, b, c = gets.split.map(&:to_i)
# m 月数
# n 店数
# a コスト円　初期
# b 人件費
# c 利益
sell_count = []
run_cost = []

while sell = gets
  sell_count << sell.to_i
end

(1..n).each do |i|
  run_cost << sell_count[i-1] * c -a - b * m  
end

p run_cost.count{|i| i < 0}


