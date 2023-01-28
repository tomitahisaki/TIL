# ペアの全探索2

l, r = gets.split.map(&:to_i)

count = 0
for i in l..r do
  for j in i+1..r do
    # puts "#{i} #{j}" if i % 10 == j % 10
    count += 1 if i % 10 == j % 10
  end
end

puts count

# l, r = gets.chomp.split(" ").map(&:to_i)
# 
# count = 0
# (l..r).each do |i|
  # (i+1..r).each do |j|
    # count += 1 if i.to_s[-1] == j.to_s[-1]
  # end
# end
# 
# puts count