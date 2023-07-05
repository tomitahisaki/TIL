# rescue節で例外情報を変数に格納する
# begin
#   1/0
# rescue => 
#   puts "#{e.class}  #{e.message}"
#   puts e.backtrace
# end

# 変数をつかって、上記の変数eを省略する
begin
  1/0
rescue => e
  puts "#{$!.class} #{$!.message}"
  puts $@
end