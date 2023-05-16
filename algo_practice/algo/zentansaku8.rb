# ペアの全探索

n = gets.chomp.to_i
s = gets.chars.map(&:to_s)

count = 0
for i in 0...n do
  for j in i+1...n do
    if s[i] == s[j]
    #   puts "#{i} #{j}"
      count += 1
    end
  end
end

puts count