n = gets.to_i
arr = []
n.times do
  arr << gets.chomp
end

count = 0
arr.length.times do |i|
  if arr[i+1] != nil && arr[i].slice(-1) == arr[i+1].slice(0)
    # puts arr[i].slice(-1) + " " + arr[i+1].slice(0)
    count += 1
    puts "Yes" if count == arr.length - 1
    next
  else
    puts arr[i].slice(-1) + " " + arr[i+1].slice(0) unless arr[i+1] == nil
    break
  end
end
