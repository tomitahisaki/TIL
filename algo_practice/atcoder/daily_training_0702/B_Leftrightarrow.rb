# params @S: String
S = gets.chomp

def check_arrow(s)
  return 'No' if s.slice(0) != "<" || s.slice(-1) != ">"
  return 'No' if s.count("<") > 1 || s.count(">") > 1
  return 'No' unless s.include?("=")
  return 'Yes'
end

puts check_arrow(S)
