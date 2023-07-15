p dir = Dir.open("/Users/hisaki/practice/til/ruby/silver")



dir = Dir.open("/Users/hisaki/practice/til/ruby/silver")
dir.each{|file| puts file}


p dir = Dir.open("/Users/hisaki/practice/til/ruby/silver"){|file| file.path}