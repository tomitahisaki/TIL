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
