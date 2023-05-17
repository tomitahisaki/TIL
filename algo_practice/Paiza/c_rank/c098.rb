n = gets.to_i
has_ball = []
n.times do
  has_ball << gets.to_i
end

turn = []
m = gets.to_i
m.times do
  turn << gets.split.map(&:to_i)
end
# turn [0] 本人 [1] 相手 [2] 渡す数
tmp = []
turn.each do |t|
  if has_ball[t[0]-1] >= t[2]
    tmp[0] = has_ball[t[0]-1] - t[2]
    has_ball[t[0]-1] = tmp[0]
    tmp[1] = has_ball[t[1]-1] + t[2]
    has_ball[t[1]-1] = tmp[1]
  else
    tmp[1] = has_ball[t[1]-1] + has_ball[t[0]-1]
    has_ball[t[1]-1] = tmp[1]
    tmp[0] = 0
    has_ball[t[0]-1] = tmp[0]
  end
end

puts has_ball
