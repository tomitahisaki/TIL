
text = <<-TEXT
def hello(name)
  puts "Hello, \#{name}!"
end

hello('Alice')
     
hello('Bob')
	
hello('Carol')
TEXT

puts text.gsub(/^[ \t]+$/, '')
#gsubメソッドで、タブ,スペースを置換している
# def hello(name)
#   puts "Hello, #{name}!"
# end
# 
# hello('Alice')
# 
# hello('Bob')
# 
# hello('Carol')
#一応無駄なスペースやタブは削除去れている。
