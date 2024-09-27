house_num, children_num = gets.split.map(&:to_i)
children_count = Hash.new(0)

children_num.times do
  house, gender = gets.split

  if children_count[house] == 0 && gender == "M"
    puts "Yes"
    children_count[house] += 1
  else
    puts "No"
  end
end
