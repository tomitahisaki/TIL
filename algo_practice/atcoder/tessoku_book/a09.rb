height, width, days = gets.split.map(&:to_i)
# heightの数だけ配列を作成し、その中にwidthの数だけ配列を作成する
area  = Array.new(height) { Array.new(width, 0) }

# 1 1 3 3 3
abcd = []
days.times do
  abcd << gets.split.map(&:to_i)
end

# 1 1 3 3 のばあい、area[0][0]からarea[2][2]までに1を足す
abcd.each do |a, b, c, d|
  (a - 1).upto(c - 1) do |i|
    (b - 1).upto(d - 1) do |j|
      area[i][j] += 1
    end
  end
end

area.each do |row|
puts row.join('') 
end

