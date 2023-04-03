a, b = gets.split.map(&:to_i)

if b == a * 2 || b == a * 2 + 1 ## if a == (b >> 1)
  puts 'Yes'
else
  puts 'No'
end