def some_method
  1/0
end

begin 
  some_method
rescue => e
  puts "error #{e.class} #{e.mesage}"
  puts e.backtrace
  # 元の例外を取得
  origin = e.cause
  unless origin.nil?
    puts "origin_error #{origin.class} #{origin.message}"
    puts origin.backtrace
  end
end