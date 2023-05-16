n = gets.chomp.to_i
arr = gets.split.map(&:to_i)

def result(arr,n)
  count = 0
  while arr.all?{|a| a%2 == 0} do
    n.times do |i|
      arr[i] = arr[i] / 2
    end
    count += 1
  end

  puts count
end

result(arr,n)

# # puts arr.map!{|a| a/2}
# result = 0
# while arr.all?{|a| a.even?}
#   arr.map!{|a| a/2}
#   result += 1
# end
# puts result