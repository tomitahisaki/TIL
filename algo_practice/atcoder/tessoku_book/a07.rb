days = gets.to_i
people = gets.to_i
days_people = Array.new(days + 1, 0)

people.times do
  l, r = gets.split.map(&:to_i) # 2 3

  days_people[l - 1] += 1 # 参加者に参加する日に+1
  days_people[r] -= 1 # 参加者が帰る日に-1
end

people_count = 0
days.times do |i|
  people_count += days_people[i] # 参加者の累積和を求める
  puts people_count
end

