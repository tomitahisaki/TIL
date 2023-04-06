# n, m, k = gets.split.map(&:to_i)
# #n カード
# #m セット枚数
# #k シャッフル

# array = (1..n).to_a
# set = array.each_slice(m).map{|i| i}
# set_res = []
# k.times do |i|
#   set[i], set[-i-1] = set[-i-1], set[i]
#   set_res << set
# end
# p set_res

# 全体のコードがこれです。
n, m, k = gets.split.map(&:to_i)

# 最初のカードの並び
cards = (1..n).to_a

k.times do
  # シャッフル後のカードの並びを格納する配列
  shuffled_cards = []

  # カードをM枚ずつのセットに分割し、並び替えた後の配列に追加
  sets = cards.each_slice(m).to_a
  sets.reverse_each { |set| shuffled_cards.concat(set) }

  # シャッフル後のカードの並びを更新
  cards = shuffled_cards
end

# シャッフル後のカードの並びを出力
# cards.each { |card| p card }
p cards