# 複数の配列の全探索2

n, m, k = gets.split.map(&:to_i)
a = gets.split.map(&:to_i)
b = gets.split.map(&:to_i)

count = 0

a.each_with_index do |a_arr, i|
 b.each_with_index do |b_arr, j|
   if a_arr + b_arr == k
    #  puts "#{i} #{j}"
     count += 1
   end
 end
end

puts count