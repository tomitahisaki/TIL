a, b = gets.split.map(&:to_i).sort

def count_x(a, b)
  x = b - a
  if x.zero?
    puts 1
  elsif x.odd?
    puts 2
  else
    puts 3
  end
end

count_x(a, b)
