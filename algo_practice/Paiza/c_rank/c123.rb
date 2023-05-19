n = gets.to_i
age = n.times.map { gets.to_i} 
m = gets.to_i
order = m.times.map { gets.split.map(&:to_i) }

total = Array.new(n, 0)
order.each do |a, b, c|
  (a-1..b-1).each do |t|
    if age[t] > c
      total[t] += c
      if total[t] > age[t]
        total[t] = age[t]
      else
        next
      end
    else
      total[t] = age[t]
    end
  end
end
puts total
