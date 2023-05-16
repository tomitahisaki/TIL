N, K = gets.chomp.split.map(&:to_i)
AS = gets.chomp.split.map(&:to_i)
 
arr = Array.new(N + 1, false)
AS.each do |a|
  arr[a] = true if a <= N
end
 
ans = 0
K.times do |i|
  break unless arr[i]
 
  ans += 1
end