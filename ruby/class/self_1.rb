class Self
	puts "クラス直下のselfキーワード #{self}"

	def self.class_method
		"クラスメソッド内のselfキーワード "#{self}"
	end

	def instance_method
		"インスタンスメソッド内のselfキーワード "#{self}"
	end
end
