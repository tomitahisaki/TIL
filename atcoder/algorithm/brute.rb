n, s = gets.split.map(&:to_i)

count = 0
(1..n).each do |i|
  (1..n).each do |j|
    if i + j <= s
      # puts "#{i} #{j}"
      count += 1
    end
  end
end
puts count