# class Foo
#   def initialize
#     @x = 1
#   end
# end

# Foo.class_eval do
#   @y = 2
#   # @@a = 3
#   def output
#     @x
#   end
#   def greet
#     "hello instance_method"
#   end
#   def self.hi
#     "hi class_method"
#   end
# end

# foo = Foo.new
# puts foo.instance_variables # => @x
# puts Foo.instance_variables # => @y
# # puts Foo.class_variables # => @@a
# puts foo.output # => 1
# puts Foo.instance_methods.grep(/output/) # => output
# puts foo.greet
# puts Foo.hi

# ## 文字列で定義した場合、違いがクラス変数を呼ぶことが可能
# ## インスタンスメソッド、クラスメソッドも定義している

# class Foo
#   def initialize
#     @x = 1
#   end
# end

# Foo.class_eval(<<EOL)
#   @y = 2
#   @@a = 3
#   def output
#     @x
#   end
#   def greet
#     "hello instance_method"
#   end
#   def self.hi
#     "hi class_method"
#   end
# EOL

# foo = Foo.new
# puts foo.instance_variables # => @x
# puts Foo.instance_variables # => @y
# puts Foo.class_variables # => @@a
# puts foo.output # => 1
# puts Foo.instance_methods.grep(/output/) # => output
# puts foo.greet #=> "hello instance_method"
# puts Foo.hi #=> "hi class_method"

# # インスタンスメソッドを定義できなくなる 特異メソッドのみが定義可能。インスタンス変数は定義できる

# class Foo
#   def initialize
#     @x = 1
#   end
# end

# Foo.instance_eval do
#   @y = 2
#   # @@a = 3
#   def output
#     @x
#   end
#   def greet
#     "hello instance_method"
#   end
#   def self.hi
#     "hi class_method"
#   end
# end

# foo = Foo.new
# puts foo.instance_variables # => @x
# puts Foo.instance_variables # => @y
# # puts Foo.class_variables # => @@a
# # puts foo.output # => 1
# puts Foo.instance_methods.grep(/output/) # => output
# # puts foo.greet
# puts Foo.hi



# class Foo
#   def initialize
#     @x = 1
#   end
# end

# Foo.instance_eval(<<EOL)
#   @y = 2
#   # @@a = 3
#   def output
#     @x
#   end
#   def greet
#     "hello instance_method"
#   end
#   def self.hi
#     "hi class_method"
#   end
# EOL

# foo = Foo.new
# puts foo.instance_variables # => @x
# puts Foo.instance_variables # => @y
# # puts Foo.class_variables # => @@a
# # puts foo.output # => 1
# puts Foo.instance_methods.grep(/output/) # => output
# # puts foo.greet
# puts Foo.hi
