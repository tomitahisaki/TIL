# @param {String} word
# @param {Character} ch
# @return {String}
def reverse_prefix(word, ch)
  if word.include?(ch)
   index = word.index(ch)
   return word[0..index].reverse + word[index+1..word.length-1]
 else
   return word
  end
end

p reverse_prefix("abcdef", "d") # "dcbaef"
p reverse_prefix("xyxzxe", "z") # "zxyxxe"
p reverse_prefix("abcd", "z") # "abcd"
