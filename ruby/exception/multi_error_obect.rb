def divide_0
  1/0
end

begin
	# NoMethodErrorを発生させる
	'abc'.foo
rescue ZeroDivisionError, NoMethodError => e
	puts '0で除算したか、存在しないメソッドが呼ばれました'
	puts "エラー: #{e.class}, #{e.message}"
end