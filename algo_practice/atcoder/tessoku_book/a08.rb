h, w = gets.split.map(&:to_i)
cell = []
targets = []

h.times do |i|
  cell[i] = gets.split.map(&:to_i)
end

n = gets.to_i
n.times do |i|
  targets[i] = gets.split.map(&:to_i)
end



sums
