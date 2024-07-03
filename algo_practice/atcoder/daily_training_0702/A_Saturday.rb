weekday = { Monday: 5, Tuesday: 4, Wednesday: 3, Thursday: 2, Friday: 1}
S = gets.chomp

def calc_until_saturday(weekday, s)
  return weekday[s.to_sym]
end

p calc_until_saturday(weekday, S)
