# クラスを指定して例外捕捉
def divide_0
  1 / 0
end

begin
  divide_0
rescue ZeroDivisionError]
  # ZeroDivisionErrorのみ例外捕捉する
  puts "0で除算しました"
end

divide_0