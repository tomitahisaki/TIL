# ペアの全探索3

n = gets.to_i
a = gets.split.map(&:to_i)

count = 0
for i in 0...n do
  for j in i+1...n do
    for k in j+1...n do
      if a[j] >= a[i] && a[j] >= a[k]
        # puts "#{a[i]} #{a[j]} #{a[k]}"
        count += 1
      end
    end
  end
end

puts count

# ```ruby
# N = gets.to_i
# A = gets.split.map(&:to_i)

# count = 0
# 0.upto(N - 3) do |i|
#     (i + 1).upto(N - 2) do |j|
#         (j + 1).upto(N - 1) do |k|
#             count += 1 if A[j] >= A[i] && A[j] >= A[k]
#         end
#     end
# end
# puts count
# ```


# N = gets.to_i
# A = gets.split.map(&:to_i)

# count = 0
# 0.upto(N - 3) do |i|
#     (i + 1).upto(N - 2) do |j|
#         (j + 1).upto(N - 1) do |k|
#             count += 1 if A[j] >= A[i] && A[j] >= A[k]
#         end
#     end
# end
# puts count