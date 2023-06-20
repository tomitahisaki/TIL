text = <<-TEXT
東京都
千葉県
神奈川県
埼玉都
TEXT

p text.scan(/(?<!東京)都/)
# ["都"] 埼玉の"都”にマッチ

text = <<-TEXT
東京都
東京
TEXT

p text.scan(/東京(?!都)/)
# 東京