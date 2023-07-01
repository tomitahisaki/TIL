def method_1
  begin
    divide_0
  rescue => e
    puts "エラークラス: #{e.class}"
    puts "エラーメッセージ: #{e.message}"
    puts "バックトレース -----"
    puts "e.backtrace"
    puts "--------"
  end
end

def divide_0
  1 / 0
end

method_1