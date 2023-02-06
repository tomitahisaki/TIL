N, Y = gets.split.map(&:to_i)

(0..N).each do |i|
  (0..N-i).each do |j|
    k = N - i - j
      if 10000 * i + 5000 * j + 1000 * k == Y 
         puts "#{i} #{j} #{k}"
        return
      end
  end
end

puts "-1 -1 -1"

# N, Y = gets.split.map(&:to_i)
 
# def res
#   (0..N).each do |x|
#     (0..(N - x)).each do |y|
#       z =  N - x - y
#       if 10000 * x + 5000 * y + 1000 * z == Y
#         return "#{x} #{y} #{z}"
#       end
#     end
#   end
#   return "-1 -1 -1"
# end
 
# puts res

# N, Y = gets.chomp.split(' ').map(&:to_i)
# res_10000 = -1
# res_5000 = -1
# res_1000 = -1
# is_break = false
 
# for a in 0..N
#     for b in 0..N-a
#         c = N - a - b
#         total = 10000*a + 5000*b + 1000*c
#         if total == Y
#            res_10000 = a
#            res_5000 = b
#            res_1000 = c
#            is_break = true
#            break
#         end
#     end
#     break if is_break
# end
 
# puts "#{res_10000} #{res_5000} #{res_1000}"