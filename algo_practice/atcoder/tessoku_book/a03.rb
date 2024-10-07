n, k = gets.split.map(&:to_i)
p = gets.split.map(&:to_i)
q = gets.split.map(&:to_i)

result = 'No'
p.each do |pi|
  q.each do |qi|
    result = 'Yes' if pi + qi == k
    break if result == 'Yes'
  end
end

puts result
