n, r =gets.split.map(&:to_i)

box = []

n.times do |i|
  box << gets.split.map(&:to_i)
end

box.each_with_index do |i, n|
  if r * r < i[0] * i[1] * i[2] && 2 * r <= i[0] && 2 * r <= i[1] && 2 * r <= i[2]
    puts n + 1
  end
end