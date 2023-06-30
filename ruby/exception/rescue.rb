puts 'start'
module Greeter
	def hello 
		puts "hello"
	end
end

begin
	greeter = Greeter.new
rescue
	puts '例外が発生したが、続行する'
end

puts 'end'