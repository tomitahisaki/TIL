# 例外処理が発生していて、endまで出力されない
puts 'start'
module Greeter
  def hello
    puts 'hello'
  end
end

greeter = Greeter.new
puts 'end'
