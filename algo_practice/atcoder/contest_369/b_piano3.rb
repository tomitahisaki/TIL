n = gets.to_i
memo = { left: nil, right: nil }
result = 0
n.times do
  pos, hand = gets.split
  pos = pos.to_i
  hand = hand.to_sym
  result += (pos - memo[hand]).abs if memo[hand]
  memo[hand] = pos
end
puts result
