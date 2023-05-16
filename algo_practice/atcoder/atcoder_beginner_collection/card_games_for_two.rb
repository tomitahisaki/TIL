n = gets.to_i
arr = gets.split.map(&:to_i)

arr_alice = []
arr_bob = []
n.times do |i|
  if i.even?
    arr_alice << arr.max
    arr.delete_at(arr.index(arr.max))
  else
    arr_bob << arr.max
    arr.delete_at(arr.index(arr.max))
  end
end

puts arr_alice.sum - arr_bob.sum


# N = gets.to_i
# numbers= gets.split(" ").map(&:to_i).sort.reverse
# alice = []
# bob = []
# N.times do |x|
#   if x.odd? 
#     bob << numbers[x]
#   else
#     alice << numbers[x]
#   end
# end
# p score = alice.sum - bob.sum

# inputs = readlines
 
# arr = inputs[1].split(' ').map(&:to_i).sort.reverse
# even_sum = odd_sum = 0
# arr.each_with_index do |v, i|
#   if i%2 == 0
#     even_sum += v
#   else
#     odd_sum += v
#   end
# end
 
# p even_sum - odd_sum