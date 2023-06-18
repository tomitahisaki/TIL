text = <<-TEXT
name,email
alice,alice@example.com
bob,bob@example.com
TEXT

puts text.gsub(",","  ")
# name  email
# alice  alice@example.com
# bob  bob@example.com

text_backed = <<-TEXT
name  email
alice  alice@example.com
bob  bob@example.com
TEXT

# puts text_backed.gsub(/\t/,",") 反応しないので、下の形にした
puts text_backed.gsub(/ +/,",")
# name,email
# alice,alice@example.com
# bob,bob@example.com