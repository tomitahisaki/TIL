gets.to_i

array = gets.split(' ').map(&:to_i)
puts array.uniq.size == 1 ? 'Yes' : 'No'
