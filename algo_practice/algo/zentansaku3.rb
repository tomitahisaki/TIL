# 複数の配列の全探索3

x, y, z = gets.split.map(&:to_i)
a = gets.split.map(&:to_i)
b = gets.split.map(&:to_i)
c = gets.split.map(&:to_i)


count = 0
a.each_with_index do |a_arr, i|
  b.each_with_index do |b_arr, j|
    c.each_with_index do |c_arr, k|
      if a_arr + b_arr == c_arr
        # puts "(#{i}, #{j}, #{k})"
        count += 1
      end
    end
  end
end

puts count