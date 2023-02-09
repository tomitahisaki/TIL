S = gets.chomp

S.gsub!("eraser", "")
S.gsub!("erase", "")
S.gsub!("dreamer", "")
S.gsub!("dream", "")
 
puts  S.length == 0 ? "YES" : "NO"

def daydream(words)
  words=words.gsub(/eraser/,"").gsub(/erase/,"").gsub(/dreamer/,"").gsub(/dream/,"")
   puts words.length == 0 ? "YES" : 'NO'
 end
  
 words = gets.chomp.to_s
 daydream(words)