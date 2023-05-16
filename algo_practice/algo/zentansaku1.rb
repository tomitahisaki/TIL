n, m = gets.split.map(&:to_i)
# 複数の配列の全探索1

a = gets.split.map(&:to_i)
b = gets.split.map(&:to_i)


count = 0
a.each_with_index do |a_arr, i|
 b.each_with_index do |b_arr, j|
   if a_arr > b_arr
    # puts "#{i}, #{j}"
    count += 1
   end
 end
end

puts count