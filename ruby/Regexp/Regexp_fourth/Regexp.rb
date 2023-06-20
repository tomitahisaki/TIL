text = <<-TEXT
John:guitar, George:guitar, Paul:bass, Ringo:drum
Freddie:vocal, Brian:guitar, John:bass, Roger:drum
TEXT
p text.scan(/\w+(?=:bass)/)
# => ["Paul", "John"] 