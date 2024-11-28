n = gets.to_i

lists = {}
n.times do |i|
  _, *b = gets.split.map(&:to_i)
  lists["array_#{i + 1}"] = b
end

filtered_lists = lists.values.uniq

p filtered_lists.count
