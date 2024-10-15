height, width = gets.split.map(&:to_i)
row = []
height.times do
  row << gets.chomp.split(&:to_i)
end

cumulative_area = []
height.times do |i|
  previous_num = 0
  cumulative_row = []
  width.times do |j|
    add_num = row[i][j] + previous_num
    cumulative_row << add_num
    previous_num = add_num
  end
  cumulative_area << cumulative_row
end
