# @param {String} s
# @return {Integer}
# s = "loveleetcode"
s = "aabb"

def first_uniq_char(s)
  # hashにする
  hash = s.chars.tally

  s.chars.each_with_index do |char, i|
    return i if hash[char] == 1
  end

  return -1
end

p first_uniq_char(s)
