# p ("aaaaaa".."zzzzzz").lazy.select { |e| e.end_with?("f")}.first(3)
# p ("aaaaaa".."zzzzzz").lazy.select { |e| e.end_with?("f")}.take(3)
# p ("aaaaaa".."zzzzzz").lazy.select { |e| e.end_with?("f")}.take(3).force
# p ("aaaaaa".."zzzzzz").lazy.select { |e| e.end_with?("f")}.first(3).force

# add = Proc.new do |x , y|
  # x + y
# end
# p add(1, 2)

# def fx(*args)
  # p(args)
# end
# fx(["apple", "banana", "carrot"])

# AnError = Class.new(Exception)
# begin
#   raise AnError
# rescue
#   puts "Bare rescue"
# rescue StandardError
#   puts "StandardError rescue"
# rescue AnError
#   puts "AnError rescue"
# rescue Exception
#   puts "Exception rescue"
# end

# class Identity
#   def self.this_object
#     self
#   end
  
#   def this_object
#     self
#   end
# end

# p a = Identity.this_object
# p b = Identity.this_object

# p c = Identity.new.this_object
# p d = Identity.new.this_object
# 
# p a == b
# p c == d

# while not DATA.eof?
#   print DATA.read 1
# end

# __END__
# 1
# 2
# 3
# 4

# ary = ["foo", "bar", nil, "baz"]

# p ary.map{ |i| i&.upcase}

# class ShoppingList
#   def initialize
#     @items = []
#   end

#   def add_item(item)
#     @items << item
#   end

#   def to_s
#     @items.map { |e| "- #{e}" }.join("\n")
#   end

#   # def __(1)__
#   #   "ShoppingList:\n  @items: #{@items.inspect}"
#   # end
# end

# list = ShoppingList.new

# list.add_item("Milk")
# list.add_item("Bread")
# list.add_item("Eggs")

# p list
# puts list


# m = Module.new
# CONST = "Constant in Toplevel"

# _proc = Proc.new do
#   CONST = "Constant in Proc"
# end

# m.module_eval(<<-EOS)
# CONST = "Constant in Module instance"

# def const
#   CONST
# end
# EOS

# m.module_eval(&_proc)

# p m.const

# module M
#   CONST = "Hello, world"
# end

# class M::C
#   CONST = "kotti"
#   def awesome_method
#     CONST
#   end
# end

# p M::C.new.awesome_method

# %r|(http://www(\.)(.*)/)| =~ "http://www.abc.com/"

# p $0
# p $1
# p $2
# p $3

# m = Module.new

# CONST = "Constant in Toplevel"

# _proc = Proc.new do
#   CONST = "Constant in Proc"
# end

# m.instance_eval(<<-EOS)
#   CONST = "Constant in Module instance"

#   def const
#     CONST
#   end
# EOS

# m.module_eval(&_proc)

# p m.const

# module M1
#   def method_1
#     __method__
#   end
# end

# class C
#   include M1
# end

# p C.new.method_1

# module M2
#   def method_2
#     __method__
#   end
# end

# module M1
#   include M2
# end

# p C.ancestors

# module M
#   def refer_const
#     CONST
#   end
# end

# module E
#   CONST = '010'
# end

# class D
#   CONST = "001"
# end

# class C < D
#   include E
#   include M
#   CONST = '100'
# end

# c = C.new
# p c.refer_const

# class Base
#   CONST = "Hello, world"
# end

# class C < Base
# end

# module P
#   CONST = "Good, night"
# end

# class Base
#   prepend P
# end

# module M
#   class C
#     CONST = "Good, evening"
#   end
# end

# module M
#   class ::C
#     def greet
#       CONST
#     end
#   end
# end

# p C.new.greet

# class C
#   CONST = "Good, night"
# end

# module M
#   CONST = "Good, evening"
# end

# module M
#   class C
#     CONST = "Hello, world"
#   end
# end

# module M
#   class ::C
#     p CONST
#   end
# end

# module M
#   def self.append_features(include_class_name)
#     puts "append_features"
#     super # このsuperを書かないとエラー発生
#   end
#   def func
#     p "Hello World"
#   end
# end

# class C
#   include M
# end

# C.new.func

# module M
#   @@val = 75
#   puts "M"
#   p @@val #=> モジュールで一番上の定義 M.class_variable_get(:@@val) 75
#   class Parent
#     @@val = 100
#     puts "Parent" 
#     p @@val #=> モジュール一番上で定義されたものとは共通でない M::Parent.class_variable_get(:@@val) 100
#   end

#   class Child < Parent
#     @@val += 50
#     puts "Child < Parent"
#     p @@val # => M::Parent.class_variable_get(:@@val) 150
#   end

#   if Child < Parent
#     @@val += 25
#     puts "hi1"
#     p @@val #=> M.class_variable_get(:@@val) 100
#   else
#     @@val += 30
#     puts "hi2"
#   end
# end

# p M::Parent.class_variable_get(:@@val) # => 150
# p M.class_variable_get(:@@val) # => 100

def foo(n)
  n ** n
end

foo = Proc.new { |n|
  n * 3
}

puts foo (2) * 2